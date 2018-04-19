#!/bin/sh

die() {
    echo " *** ERROR: " $*
    exit 1
}

set -x

git config user.name "embARC"
git config user.email "embARC@embARC.org"

echo 'Generating documentation ...'
cd ../doc || die
make || die


mkdir  ../../document || die
cp -rf {embARC_Document,embARC_Document.html} ../../document

