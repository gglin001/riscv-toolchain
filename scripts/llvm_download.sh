#!/bin/bash

LLVM_SHA="release/18.x"
LLVM_REPO="https://github.com/llvm/llvm-project.git"

git clone -n --depth=1 --filter=tree:0 $LLVM_REPO llvm-project
pushd llvm-project
git sparse-checkout set --no-cone \
  /clang /cmake /compiler-rt /libc /libcxx /libcxxabi /libunwind /lld /lldb /llvm /runtimes \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' '!/clang/www' \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/compiler-rt/test' '!/libcxx/test' '!/lld/test' '!/lldb/test' '!/lldb/unittests'
git fetch --depth 1 origin $LLVM_SHA
git checkout
popd
