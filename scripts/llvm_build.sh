#!/bin/bash

# $PWD is `.../riscv-toolchain`
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/llvm/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/compiler-rt/CMakePresets.json

pushd llvm-project

# build clang
cmake --preset clang -S$PWD/llvm
cmake --build $PWD/build --target install
# cmake --build $PWD/build --target install-distribution

# TODO: multi-arch
# clang -target riscv64-unknown-elf -print-multi-lib

# build compiler-rt
cmake --preset compiler-rt -S$PWD/compiler-rt
# clang -target riscv64-unknown-elf -nostartfiles -nostdlib -v ../_demos/hello.c -o hello
cmake --build $PWD/build_compiler-rt --target install
mkdir -p $PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib
cp $PWD/build_compiler-rt/install/lib/libclang_rt.builtins-riscv64.a \
  $PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib/libclang_rt.builtins.a

popd
