#!/bin/bash

set -e
tempdir=$(mktemp -d)
printenv
while read refname fsha rrefname rsha
do
    if [[ $refname = "refs/heads/master" ]] ; then
        pushd .
        #git clone --recursive . $tempdir
        git archive master | tar -x -C $tempdir
        git submodule foreach --recursive \
            'git ls-files | sed "s#^#$path/#"' | cpio -pmdv $tempdir || :
        pip freeze > $tempdir/requirements.txt
        cd $tempdir
        ls
        virtualenv .
        . bin/activate
        pip install -r requirements.txt
        make rsync_upload
        popd
    fi
done

rm -rf $tempdir
