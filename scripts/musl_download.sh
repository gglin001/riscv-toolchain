#!/bin/bash

SHA="master"
REPO="git://git.musl-libc.org/musl"

git clone -n --depth=1 --filter=tree:0 $REPO musl
pushd musl
git fetch --depth 1 origin $SHA
git checkout
popd
