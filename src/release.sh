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

url=$1
version=$2
base=${BASE:-master}

check_version $version
setup_packages $3 $4

prerelease_package() {
    pkg=$1
    oldpath=packages/$pkg/$pkg.$base
    newpath=packages/$pkg/$pkg.$version
    rm -rf $newpath
    cp -r $oldpath $newpath
}

for package in $packages; do
    check_package $package
    if [ "$needs_update" == "true" ]; then
        prerelease_package $package
        ./set-url.sh $url $version $package
        ./change-version.sh $base $version $package
    fi
done
