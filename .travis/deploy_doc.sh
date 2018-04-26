#!/bin/sh

REPO_LINK="https://github.com/qiangg/embarc_osp.git"

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
#git fetch origin
#git branch -a

mkdir gh-pages || die
cd gh-pages || die
git init .
git remote add origin ${REPO_LINK}
git fetch origin -t
git checkout -b gh-pages origin/gh-pages || die
cd doc
rm -rf embARC_Document.html embARC_Document || die
cp ../../doc.tar.gz . || die
tar xzvf doc.tar.gz || die
rm -rf doc.tar.gz || die

git add --all || die
git commit -s -a -m "Update gh-pages branch"
if [ $? -eq 0 ]; then
	git push origin gh-pages || die
else
	echo 'No update in gh-pages branch'
fi

exit 0

#mkdir  ../../document || die
#cp -rf {embARC_Document,embARC_Document.html} ../../document

