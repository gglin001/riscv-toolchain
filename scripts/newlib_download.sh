#!/bin/bash

SHA="newlib-4.4.0"
REPO="git://sourceware.org/git/newlib-cygwin.git"

git clone -n --depth=1 --filter=tree:0 $REPO newlib
pushd newlib
git fetch --depth 1 origin $SHA
git checkout
popd
