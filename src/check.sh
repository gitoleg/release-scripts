#!/bin/bash

# check_version version
# valid version could be either master
# some dot separated numbers: 1.3 1.3.4 ...
check_version () {
    x=`echo $1 | grep [0-9].[0-9]`

    if [ "$x" == "" ] && [ "$1" != "master" ];  then
        echo "WRONG version '$1'!"
        exit 1
    fi
}


# setup_packages - defines excluded and included packages
# Usage:
# setup_packages
# setup_packages package1,package2,package3
# setup_packages exclude package1,package2,package3
excluded_packages=
packages=
setup_packages() {
    if [ "$1" == "exclude" ]; then
        excluded_packages=$(echo $2 | tr ',' '\n')
        packages=`ls packages`
    else
        packages=$(echo $1 | tr ',' '\n')
        if [ "$packages" == "" ]; then
            packages=`ls packages`
        fi
    fi
}

# check_package p - defines if package needs to be updated
needs_update=
check_package() {
    pkg="$1"
    if [ "$excluded_packages" != "" ]; then
        needs_update=true
        for p in $excluded_packages; do
            if [ $p == $pkg ]; then
                needs_update=false
            fi
        done
    else
        needs_update=false
        for p in $packages; do
            if [ $p == $pkg ]; then
                needs_update=true
            fi
        done
    fi
}
