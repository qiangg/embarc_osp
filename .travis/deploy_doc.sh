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

tar czvf doc.tar.gz embARC_Document.html embARC_Document

rm -rf embARC_Document.html embARC_Document
tar xzvf doc.tar.gz

#mkdir  ../../document || die
#cp -rf {embARC_Document,embARC_Document.html} ../../document

