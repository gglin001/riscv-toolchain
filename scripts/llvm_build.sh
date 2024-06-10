#!/bin/bash

# $PWD is `.../riscv-toolchain`
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/llvm/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/compiler-rt/CMakePresets.json

pushd llvm-project

# build clang
# https://llvm.org/docs/BuildingADistribution.html
cmake --preset clang -S$PWD/llvm
cmake --build $PWD/build --target install-distribution

# build compiler-rt
cmake --preset compiler-rt -S$PWD/compiler-rt
cmake --build $PWD/build_crt --target install

# TODO: multi-arch ?
# clang -target riscv64-unknown-elf -print-multi-lib

# TODO: build libcxx

# TODO: build lldb ?

popd
