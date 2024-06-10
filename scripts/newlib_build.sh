#!/bin/bash

# $PWD is `.../riscv-toolchain`
mkdir -p newlib/build

# TODO: unify build env
micromamba install texinfo

pushd newlib/build

LLVM_BINDIR="$PWD/../llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

CC_FOR_TARGET='clang' \
  CFLAGS_FOR_TARGET="--target=riscv64-unknown-elf -mcmodel=medany -nostdlib" \
  ../configure \
  --target=riscv64-unknown-elf --prefix=$(pwd)/install

make -j$(nproc)
make install

popd

# `rv64imac/lp64`
# no default sysroot is created, set `--sysroot` first
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/include
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/lib
cp -r newlib/build/install/riscv64-unknown-elf/include/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/include/
cp newlib/build/install/riscv64-unknown-elf/lib/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/lib/

# `rv64imafdc/lp64d`
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/include
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp -r newlib/build/install/riscv64-unknown-elf/include/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/include/
cp -r newlib/build/install/riscv64-unknown-elf/lib/rv64imafdc/lp64d/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
