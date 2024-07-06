#!/bin/bash

# $PWD is `.../riscv-toolchain`
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/llvm/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/compiler-rt/CMakePresets.json
ln -s $PWD/scripts/CMakePresets.json $PWD/llvm-project/runtimes/CMakePresets.json

pushd llvm-project

# build clang
# https://llvm.org/docs/BuildingADistribution.html
cmake --preset clang -S$PWD/llvm
cmake --build $PWD/build --target install-distribution

# clang -target riscv64-unknown-elf -print-multi-lib
# get:
# .;@march=rv64imac@mabi=lp64
# rv64imafdc/lp64d;@march=rv64imafdc@mabi=lp64d

# build compiler-rt / `rv64imac/lp64`
cmake --preset compiler-rt-rv64imac-lp64 -S$PWD/compiler-rt
cmake --build $PWD/build_rt --target install
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/lib
cp build_rt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/lib/libclang_rt.builtins.a

# build compiler-rt-rv64imafdc-lp64d / `rv64imafdc/lp64d`
cmake --preset compiler-rt-rv64imafdc-lp64d -S$PWD/compiler-rt
cmake --build $PWD/build_rt --target install
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp build_rt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/libclang_rt.builtins.a

# build compiler-rt-rv64imafdcv-lp64d
cmake --preset compiler-rt-rv64imafdcv-lp64d -S$PWD/compiler-rt
cmake --build $PWD/build_rt --target install
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdcv/lp64d/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdcv/lp64d/lib
cp build_rt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdcv/lp64d/lib/libclang_rt.builtins.a

# build compiler-rt-rv64ima-lp64
cmake --preset compiler-rt-rv64ima-lp64 -S$PWD/compiler-rt
cmake --build $PWD/build_rt --target install
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/include
mkdir -p build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/lib
cp build_rt/install/lib/generic/libclang_rt.builtins-riscv64.a \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/lib/libclang_rt.builtins.a

# build libcxx
# cmake --preset libcxx-rv64imac-lp64 -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64
# cmake --build $PWD/build_cxx --target install

# cmake --preset libcxx-rv64imafdc-lp64d -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d
# cmake --build $PWD/build_cxx --target install

cmake --preset libcxx-rv64ima-lp64 -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64
cmake --build $PWD/build_cxx --target install

# TODO: build lldb ?

popd
