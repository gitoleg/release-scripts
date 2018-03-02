#!/bin/bash

#
# Synopsys:
# Releases a new version of opam packages based on master version
#
# Usage:
# release url new_version
# release url new_version package1,package2,...
# release url new_version exclude package1,package2,...
#
# One can release package (packages) based on any other than master version:
# BASE=desired-version ./release.sh url version
source check.sh
source set-url.sh
source change-version.sh

url=$1
version=$2
base=${BASE:-master}
repo=${REPO:-$PWD}

check_version $version
setup_packages $3 $4
get_md5 $url
md5='b7785715c24645e8e69a8091427d090e'

prerelease_package() {
    pkg=$1
    oldpath=$repo/packages/$pkg/$pkg.$base
    newpath=$repo/packages/$pkg/$pkg.$version
    rm -rf $newpath
    cp -r $oldpath $newpath
}

for package in $packages; do
    check_package $package
    if [ "$needs_update" == "true" ] && [ -d "packages/$pkg/$pkg.$base" ]   ; then
        prerelease_package $package
        set_pkg_url $package $version $url $md5
        change_pkg_version $package $base $version
    fi
done
