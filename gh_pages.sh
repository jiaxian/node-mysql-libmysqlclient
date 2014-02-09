#!/bin/bash

BRANCH=`git branch 2> /dev/null | grep "*" | sed 's#*\ \(.*\)#\1#'`
if [ "$BRANCH" != "master" ]
then
    exit 1
fi

DESC=`git describe`

# Update gh-pages branch
TMP=`mktemp -d ${TMPDIR}temp.XXXXXXXXXX`
cp -r ./doc/* $TMP
rm -f $TMP/*~
git checkout gh-pages
cp -r $TMP/* ./
git add .
git ci -m "Update docs to $DESC"
git checkout master
rm -rf $TMP
