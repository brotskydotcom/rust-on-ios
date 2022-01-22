# rust-on-ios

This project contains iOS apps built by wrapping a Swift UI around Rust core logic.  It's intended both as a proof of concept—one or more of the apps are published and available on the iOS platform app store—and as documentation others can leverage to build their own apps.

## App Structure

Each of the apps is built as a pair:
- A rust crate which builds a static lib; this is named for the app and has a `-core` suffix.
- An iOS app which links the static lib; this is named for the app and has a `-tester` suffix.

Apps as published on the app store have the app name capitalized with the word `Demo` following it.

## License

Licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you shall be dual licensed as above, without any
additional terms or conditions.
