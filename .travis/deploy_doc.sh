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

tar czvf doc.tar.gz embARC_Document.html embARC_Document || die
git -c diff.mnemonicprefix=false -c core.quotepath=false checkout -b gh-pages || die
rm -rf embARC_Document.html embARC_Document || die
tar xzvf doc.tar.gz || die
rm -rf doc.tar.gz || die

git add --all || die
git commit -s -a -m "Update gh-pages branch"
if [ $? -eq 1 ]; then
	echo 'No update in gh-pages branch'
	exit 0
else
	git push origin gh-pages || die
fi

#mkdir  ../../document || die
#cp -rf {embARC_Document,embARC_Document.html} ../../document

