#!/bin/bash

LLVM_SHA="release/18.x"
LLVM_REPO="https://github.com/llvm/llvm-project.git"

git clone -n --depth=1 --filter=tree:0 $LLVM_REPO llvm-project
pushd llvm-project
git sparse-checkout set --no-cone \
  /clang /cmake /compiler-rt /libcxx /libcxxabi /libunwind /lld /lldb /llvm /runtimes \
  '!/clang/test' '!/clang/unittests' '!/clang/docs' '!/clang/www' \
  '!/llvm/test' '!/llvm/unittests' '!/llvm/docs' \
  '!/compiler-rt/test' '!/libcxx/test' '!/lld/test' '!/lldb/test' '!/lldb/unittests'
git sparse-checkout add --no-cone \
  '!/llvm/lib/Target' '/llvm/lib/Target/*.*' \
  '/llvm/lib/Target/RISCV' '/llvm/lib/Target/ARM' '/llvm/lib/Target/AArch64'
git fetch --depth 1 origin $LLVM_SHA
git checkout
popd
