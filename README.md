# Rust on iOS/macOS

This project is a resource for developers who want to build iOS or macOS apps that make use of Rust libraries.

The `rust-test-harness` Xcode project in this repo provides an XCode-based application that can be used to invoke a Rust-built static library.  It expects the crate being tested to provide a static library with a single `extern C` entrypoint with the signature `void test(int op)` (on the Rust side, that’s `extern "C" fn test(op i32)` with name mangling turned off).  When the iOS build target is run in the simulator (or on an iOS device), or whenb the macOS build target is run on a Mac, the test harness puts up a screen with a picker for which test you want to run, and then it passes the index of that choice as the argument to the `test` entry.

If the test runs without panicing, you get an alert on the iOS side that says to check the logs for details. Anything you print to stdout on the Rust side will be in the log.

The test harness can be used on your own crates simply by cloning it locally and creating an appropriate `test-spec.sh` file at the top level of the project which declares where your crate is and how to build the test library.  You can copy the `test-spec.sample.sh` file to `test-spec.sh` in order to get started. Detailed instructions are in the next section.

**PLEASE NOTE**: You will need your own Apple developer account in order to build and run this project, because both the iOS and macOS targets use provisioning profiles. You will have to change those provisioning profiles to ones that you own.

## Usage

Because Apple remembers which developers have registered which bundle ids, to use this test harness you will have to go into XCode and change its bundle ID and signing information. When you open the test harness project, XCode may recommend that you update your script sandbox settings…don’t! This will prevent the test harness from accessing your crate directory.

To use this test harness, you must create a `test-spec.sh` shell script. There are five shell variables in the `test-spec.sh` script that you set in order for this test harness to work:

* `CRATE_PATH` must be defined as a full path to the directory containing the crate you want to test. 
* `CRATE_FEATURES` gives a comma-separated list of crate features (other than the default) that must be defined when compiling your test library. If there are no such features, define it as the empty string (`“”`). There is currently no way to disable the default features of the crate being tested.
* `CRATE_PACKAGE` gives the name of the package (if any) whose build will produce your test library. If there is no such package, define it as the empty string.
* `CRATE_EXAMPLE` gives the name of the example (if any) whose build will produce your test library. If there is no such example, define it as the empty string.
* `LIBRARY_NAME` gives the name of the library 

If both `CRATE_PACKAGE` and `CRATE_EXAMPLE` are specified, the build will specify both, and the library will be assumed to be created by the example. If neither are specified, the test harness will assume that your crate contains only one package and that building it will build the library.

This test harness can be used to test both debug and release builds of your crate. Running the test harness in the Debug configuration will do a debug build of your library, and similarly for Release.

The XCode target of your build (e.g., a macOS device, an iOS device or an iOS device simulator) will be used to pick an appropriate target platform for your rust library build. You must have installed the appropriate target support on your machine.

(N.B. This test harness assumes you have done a standard install of Rust using `rustup` and sets the `PATH` variable based on that when building your test library.)

For example: The `test-spec.sample.sh` file that comes with this project assumes that the directory containing the `ios-test-harness.xcodeproj` bundle (that is, the top level of this repository) is adjacent to the directory containing the crate being tested (called `keyring-rs`), and that the test library is an example in that crate.

Before running the test harness, you will want to edit the code in `ContentView.swift` (in the `test-runner` directory) to have the correct descriptions (and correct number) of test opcodes for your library. A future project of mine will be to load the opcodes and descriptions from the static library that you test.

## License

Licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you shall be dual licensed as above, without any additional terms or conditions.
