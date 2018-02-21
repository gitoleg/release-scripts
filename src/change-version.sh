#!/bin/bash

#
# Synopsys:
# Changes a version of opam packages in opam file
#
# Usage:
# change_version old_version new_version
# change_version old_version new_version package1,package2,...
# change_version old_version new_version exclude package1,package2,...
#

source check.sh

old_version=$1
new_version=$2

check_version $old_version
check_version $new_version
setup_packages $3 $4
repo=${REPO:-$PWD}

change_version() {
    path=$repo/packages/$1/$1.$new_version/opam
    sed -i "s/^version:.*/version: \"$new_version\"/" $path
}

for package in $packages; do
    check_package $package
    if [ "$needs_update" == "true" ]; then
        change_version $package
    fi
done
