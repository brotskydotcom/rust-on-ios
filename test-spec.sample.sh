#!/bin/sh
set -x
#  test-spec.sh
#  ios-test-harness
#
# This script defines shell variables needed for the
# build scripts to build and then find the static test lib.
#
# You need to source this path into your script, so the
# variable definitions will take effect in that scope.
#
# CRATE_PATH is the path to the root of the crate
# that produces the library.
CRATE_PATH="${PROJECT_DIR}/../keyring-rs"
#
# FEATURE_NAMES is used if your crate needs to
# be compiled with specific features on order
# to produce your library. Its value is the
# comma-separated list of features to use.
# Leave it empty for just the default features.
FEATURE_NAMES="apple-native"
#
# PACKAGE_NAME is used if your test library is
# created as the output of building a specific package
# in your crate, otherwise it's left empty.
PACKAGE_NAME=""
#
# EXAMPLE_NAME is used if your library is
# created as the output of building a specific example
# in your crate, otherwise it's left empty.
EXAMPLE_NAME="iostest"
#
# LIBRARY_NAME is the name of your built library.
# It will be copied to a library called libiostest.a
# inside of this project structure
LIBRARY_NAME="libiostest.a"
