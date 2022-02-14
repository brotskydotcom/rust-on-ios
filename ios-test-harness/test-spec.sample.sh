#!/bin/sh
# set -x
#  test-spec.sh
#  ios-test-harness
#
# This script defines shell variables needed for the
# build scripts to build and then find the static test lib.
# Note that the built library name must be libiostest.a
#
# You need to source this path into your script, so the
# variable definitions will take effect in that scope.
#
# CRATE_PATH is the path to the root of the crate
# that produces the library.
CRATE_PATH="${PROJECT_DIR}/.."  # path if this XCode project is inside the crate
#
# PACKAGE_NAME is used if you are building just one
# package in a workspace.  It's the name of the package
# or empty otherwise
PACKAGE_NAME=""
#
# EXAMPLE_NAME is used if your library is an example
# output rather than the crate's output.  It's the
# name of the example or empty otherwise.
EXAMPLE_NAME="ios"
#
# LIBRARY_NAME is the name of your built library.
# It will be copied to a library called libiostest.a
LIBRARY_NAME="libios.a"
