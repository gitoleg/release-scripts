#!/bin/bash

help="
Usage:
$ ./pack.sh command arguments
run either from opam-repository or with REPO env variable set:
$ REPO=/home/me/opam-repository ./pack.sh

Commands:
change-version - changes a version of opam packages in opam file
help           - displays this message and exits
release        - creates a new package from some other (master by default) version.
                 One can release package (packages) based on any other than master version.
remove         - removes a specified version of opam packages from repository
set-url        - changes url file for opam packages. Doesn't create it if file not exists.
                 If url is an archive, then appropriate url file will be generated:
                 with an archive and md5sum fields.

Note, that version must be either master or string with dot-separated digits: 1.3, 1.4.0.

Examples:

Command: change-version
$ ./pack.sh change-version old_version new_version
$ ./pack.sh change-version old_version new_version package1,package2,...
$ ./pack.sh change-version old_version new_version exclude package1,package2,...

Command: set-url
$ ./pack.sh set-url url version
$ ./pack.sh set-url url version package1,package2,...
$ ./pack.sh set-url url version exclude package1,package2,...

Command: release
$ ./pack.sh release url new_version
$ ./pack.sh release url new_version package1,package2,...
$ ./pack.sh release url new_version exclude package1,package2,...
$ BASE=desired-version ./pack.sh release url version

Command: remove
$ ./pack.sh remove version
$ ./pack.sh remove version package1,package2,...
$ ./pack.sh remove version exclude package1,package2,..."

source set-url.sh
source change-version.sh

cmd=$1
shift

if [ "$cmd" == "help" ]; then
    echo "$help"
    exit 0
elif [ "$cmd" == "release" ]; then
    ./release.sh $@
elif [ "$cmd" == "change-version" ]; then
    run_change_version.sh $@
elif [ "$cmd" == "set-url" ]; then
    run_set_url.sh $@
elif [ "$cmd" == "remove" ]; then
    ./remove.sh $@
else
    echo "Unknown command $cmd! $help"
    exit 1
fi
