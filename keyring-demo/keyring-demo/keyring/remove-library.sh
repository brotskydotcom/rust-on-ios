#!/bin/sh
# set -x
# delete-iospw.sh
# Remove the library so it will be rebuilt next time.
#
rm -fv ${DERIVED_FILES_DIR}/libkeyring.a
