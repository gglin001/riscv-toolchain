#!/bin/bash

PICOLIBC_SHA="60c2ad3b3c65d70fef0b55d5180347871920063a"
# PICOLIBC_SHA="1.8.6"
PICOLIBC_REPO="https://github.com/picolibc/picolibc.git"

git clone -n --depth=1 --filter=tree:0 $PICOLIBC_REPO picolibc
pushd picolibc
git fetch --depth 1 origin $PICOLIBC_SHA
git checkout
popd
