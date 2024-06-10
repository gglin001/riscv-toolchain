#!/bin/bash

# $PWD is `.../riscv-toolchain`
ln -s $PWD/scripts/picolibc-cross.txt $PWD/picolibc/picolibc-cross.txt

pushd picolibc

LLVM_BINDIR="$PWD/../llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

# clang -target riscv64-unknown-elf -print-multi-lib
# get:
# .;@march=rv64imac@mabi=lp64
# rv64imafdc/lp64d;@march=rv64imafdc@mabi=lp64d

args=(
  # -Dmultilib-list="rv64imac/lp64,rv64imafdc/lp64d"
  -Dmultilib-list=".,rv64imafdc/lp64d"
  --cross-file=$PWD/picolibc-cross.txt
  --prefix=$PWD/build/install
  build
)
meson setup "${args[@]}"

meson compile -C build
meson install -C build

popd

# `rv64imac/lp64` / `.`
mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/include
mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib
cp -r picolibc/build/install/include/* \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/include/
cp picolibc/build/install/lib/* \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib/
# TODO: fix it
cp llvm-project/build_crt/install/lib/riscv64-unknown-unknown-elf/libclang_rt.builtins.a \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib/

# `rv64imafdc/lp64d`
mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include
mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp -r picolibc/build/install/include/* \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include/
cp -r picolibc/build/install/lib/rv64imafdc/lp64d/* \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
cp llvm-project/build_crt/install/lib/riscv64-unknown-unknown-elf/libclang_rt.builtins.a \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
cp picolibc/build/install/lib/picolibc.ld \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
cp picolibc/build/install/lib/picolibcpp.ld \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
