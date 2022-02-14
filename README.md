# rust-on-ios

This project is a resource for developers who want to build iOS apps with Rust core logic.  It contains both a demo application and an iOS test harness.  It's intended both as a proof of concept—one or more of the apps are published and available on the iOS platform app store—and as documentation others can leverage to build their own apps.

## Keyring Demo

The iOS *Keyring Demo* application, available on the Apple App Store, is built by wrapping a Swift UI around a Rust library.

The Rust library, in the `keyring-demo` crate, is a C-ABI library that uses Core Foundation constructs to bridge the Swift UI wrapper to functionality provided by the underlying [keyring crate](https://crates.io/crates/keyring).

The source for the iOS application is in the `keyring-demo` Xcode project inside the crate.  In addition to a standard Swift UI application structure, the project contains a `keyring` folder that provides a Swift `PasswordOps` object wrapper around the CoreFoundation Rust API.  The Xcode project also provides build scripts that invoke the Rust build from the XCode build, and build settings (such as turning off bitcode verification) that are necessary for the `Archive` builds required by the App Store to succeed.

## iOS Test Harness

The `ios-test-harness` Xcode project in this repo provides an iOS-based test framework that can be used similar to the standard Rust test framework.  It expects the crate being tested to provide a static library with a single `extern C` entrypoint with the signature `void test()`.  When run in the simulator (or on an iOS device), the test harness puts up a single screen with a `Run Test` button that can be used to invoke the `test()` entry.  When run via the Xcode `Project>Test` menu, the test harness invokes the `test()` entry as part of the test sequence.

The idea is to have your `test()` entry run the same series of tests that you would run via the Rust test harness.  If the tests pass without panic, the run is successful.

The test harness can be used on your own crates simply by cloning it locally and creating an appropriate `test-spec.sh` file at the top level of the project which declares where your crate is and how to build the test library.  You can copy the `test-spec.sample.sh` file to `test-spec.sh` in order to get started.

## License

Licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you shall be dual licensed as above, without any
additional terms or conditions.
