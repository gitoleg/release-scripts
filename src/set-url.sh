#!/bin/bash

#
# Synopsys:
# Changes url file for opam packages. Doesn't create it
# if file not exists (e.g. for conf packages)
#
# Set up url for either:
# - all packages with specified version;
# - for specified packages only;
# - for all packages except specified.

source check.sh

md5=
get_md5() {
    url="$1"
    # check that url is archive and if so calculate md5sum
    archives="gz tar zip"
    extension="${url##*.}"
    for a in $archives; do
        if [ "$extension" == "$a" ]; then
            is_archive=true
        fi
    done
    if [ "$is_archive" == "true" ]; then
        filename="${url##*/}"
        wget $url
        md5=`md5sum $filename`
        md5=`echo $md5 | cut -d' ' -f1`
        rm $filename
    fi
}

# set_archive pkg url checksum
set_archive() {
    pkg="$1"
    version="$2"
    url="$3"
    checksum="$4"
    path=packages/$pkg/$pkg.$version/url
    if [ -e "$path" ]; then
       echo "set url for $pkg.$version"
       cat > $path <<EOF
archive: "$url"
checksum: "$checksum"
EOF
    fi
    if [ ! -e "$path" ]; then
        echo "skipping $pkg"
    fi
}

# set_source pkg url
set_source() {
    pkg="$1"
    version="$2"
    url="$3"
    path=packages/$pkg/$pkg.$version/url
    if [ -e "$path" ]; then
    cat > $path <<EOF
src: "$url"
EOF
    fi
    if [ ! -e "$path" ]; then
        echo "skipping $pkg"
    fi
}

set_pkg_url() {
    pkg="$1"
    version="$2"
    url="$3"
    md5="$4"
    if [ "$md5" != "" ]; then
        set_archive $pkg $version $url $md5
    else
        set_source $pkg $version $url
    fi
}

run_set_url() {
    url=$1
    version=$2
    check_version $version
    setup_packages $3 $4
    get_md5 $url

    # do a job for every package
    for package in $packages; do
        check_package $package
        if [ "$needs_update" == "true" ]; then
            set_pkg_url $package $version $url $md5
        fi
    done
}
