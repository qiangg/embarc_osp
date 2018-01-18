#!/bin/sh

set_1="TOOLCHAIN=gnu BOARD=emsk BD_VER=23 CUR_CORE=arcem11d"
set_2="TOOLCHAIN=gnu BOARD=emsk BD_VER=23 CUR_CORE=arcem7d"

die() {
    echo " *** ERROR: " $*
    exit 1
}

set -x

[ $TRAVIS_OS_NAME != linux ] || {
    export PATH=/tmp/arc_gnu_2017.09_prebuilt_elf32_le_linux_install/bin:$PATH || die
    git checkout -- . || die
    bash apply_embARC_patch.sh || die
    cd .travis || die

    [ $BUILD_TARGET != arc-gcc-emsk23-11d ] || {
        python3 build.py "${set_1}" || die
    }

    [ $BUILD_TARGET != arc-gcc-emsk23-7d ] || {
        python3 build.py "${set_2}" || die
    }
}