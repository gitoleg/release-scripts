#!/bin/bash

#
# Synopsys:
# Changes a version of opam packages in opam file

source check.sh


repo=${REPO:-$PWD}

change_pkg_version() {
    pkg=$1
    old_version=$2
    new_version=$3
    path=$repo/packages/$pkg/$pkg.$new_version/opam
    sed -i "s/^version:.*/version: \"$new_version\"/" $path
    if [ "$pkg" == "bap" ]; then
        sed -i "s/$old_version/$new_version/g" $path
    fi
}

run_change_version() {
    old_version=$1
    new_version=$2
    check_version $old_version
    check_version $new_version
    setup_packages $3 $4

    for package in $packages; do
        check_package $package
        if [ "$needs_update" == "true" ]; then
            change_pkg_version $package $old_version $new_version
        fi
    done
}
