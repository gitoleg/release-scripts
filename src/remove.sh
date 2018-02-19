#!/bin/bash

#
# Synopsys:
# Removes a specified version of opam packages from repository
#
# Usage:
# remove version
# remove version package1,package2,...
# remove version exclude package1,package2,...
source check.sh

version=$1
setup_packages $2 $3

for package in $packages; do
    check_package $package
    if [ "$needs_update" == "true" ]; then
        rm -rf packages/$package/$package.$version
    fi
done
