#!/bin/bash
set -x
# create-iospw.sh
# Build the correct Rust target and place
# the resulting library in the build products
#
# read the spec for building the library
if [[ -f "${PROJECT_DIR}/test-spec.sh" ]]; then
    source "${PROJECT_DIR}/test-spec.sh"
else
    echo "error: Can't find test-spec.sh in the project directory"
    return
fi
#
# The $PATH used by Xcode likely won't contain Cargo, fix that.
# In addition, the $PATH used by XCode has lots of Apple-specific
# developer tools that your Cargo isn't expecting to use, fix that.
# Note: This assumes a default `rustup` setup and default path.
build_path="$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin"
#
# Figure out the correct Rust target from the ARCHS and PLATFORM.
# This script expects just one element in ARCHS.
case "$ARCHS" in
	"arm64")	rust_arch="aarch64" ;;
	"x86_64")	rust_arch="x86_64" ;;
	*)			echo "error: unsupported architecture: $ARCHS" ;;
esac
if [[ "$PLATFORM_NAME" == "macosx" ]]; then
	rust_platform="apple-darwin"
else
	rust_platform="apple-ios"
fi
if [[ "$PLATFORM_NAME" == "iphonesimulator" ]]; then
    if [[ "${rust_arch}" == "aarch64" ]]; then
        rust_abi="-sim"
    else
        rust_abi=""
    fi
else
	rust_abi=""
fi
rust_arch="${rust_arch}-${rust_platform}${rust_abi}"
#
# set the build args from the spec
if [[ -f "${CRATE_PATH}/Cargo.toml" ]]; then
    build_args=(--manifest-path "${CRATE_PATH}/Cargo.toml" --target "${rust_arch}")
else
    echo "error: No Cargo.toml found in '${CRATE_PATH}'"
    return
fi
if [[ "${FEATURE_NAMES}" != "" ]]; then
    build_args=("${build_args[@]}" --features ${FEATURE_NAMES})
fi
if [[ "${PACKAGE_NAME}" != "" ]]; then
    build_args=("${build_args[@]}" --package ${PACKAGE_NAME})
fi
if [[ "${EXAMPLE_NAME}" != "" ]]; then
    build_args=("${build_args[@]}" --example ${EXAMPLE_NAME})
    target_path="examples/"
else
    target_path=""
fi
if [[ "${LIBRARY_NAME}" == "" ]]; then
    echo "error: No library name found in test specification"
    return
else
    target_path="${target_path}${LIBRARY_NAME}"
fi
#
# Build library in debug or release
if [[ "$CONFIGURATION" == "Release" ]]; then
	target_config="release"
	env PATH="${build_path}" cargo build --release "${build_args[@]}"
elif [[ "$CONFIGURATION" == "Debug" ]]; then
	target_config="debug"
	env PATH="${build_path}" cargo build "${build_args[@]}"
else
    echo "error: Unexpected build configuration: $CONFIGURATION"
fi
#
# Copy the built library to the derived files directory
cp -v "${CRATE_PATH}/target/${rust_arch}/${target_config}/${target_path}" ${DERIVED_FILES_DIR}/libiostest.a
