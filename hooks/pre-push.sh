#!/bin/bash
set -e
tempdir=$(mktemp -d)

while read refname fsha rrefname rsha
do
    if [[ $refname = "refs/heads/master" ]] ; then
        wd=$(pwd)
        cd ${tempdir}
        git clone ${wd} .
        pip install -r requirements.txt
        . bin/activate
        make ssh_upload
    fi
done

rm -rf $tempdir
