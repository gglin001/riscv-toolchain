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
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/lib
cp build_crt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/lib/libclang_rt.builtins.a

# build compiler-rt-rv64imafdc-lp64d
cmake --preset compiler-rt-rv64imafdc-lp64d -S$PWD/compiler-rt
cmake --build $PWD/build_crt --target install
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp build_crt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/libclang_rt.builtins.a

# TODO: multi-arch ?
# clang -target riscv64-unknown-elf -print-multi-lib

# TODO: build libcxx

# TODO: build lldb ?

popd
