#!/bin/bash

# newlib should build after picolibc installed
# $PWD is `.../riscv-toolchain`

pushd newlib

LLVM_BINDIR="$PWD/../llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

# TODO: disable multilib
mkdir -p build && pushd build
CC_FOR_TARGET='clang' \
  CFLAGS_FOR_TARGET="--target=riscv64-unknown-elf -mcmodel=medany -nostdlib -O2" \
  ../configure \
  --enable-multilib \
  --target=riscv64-unknown-elf \
  --prefix=$(pwd)/install
make -j$(nproc)
make install
popd

mkdir -p build-rv64ima-lp64 && pushd build-rv64ima-lp64
CC_FOR_TARGET='clang' \
  CFLAGS_FOR_TARGET="--target=riscv64-unknown-elf -mcmodel=medany -nostdlib -O2 -march=rv64ima -mabi=lp64" \
  ../configure \
  --disable-multilib \
  --target=riscv64-unknown-elf \
  --prefix=$(pwd)/install
make -j$(nproc)
make install
popd

popd

# `rv64imac/lp64`
# no default sysroot is created, set `--sysroot` first
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/include
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/lib
cp -r newlib/build/install/riscv64-unknown-elf/include/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/include/
cp newlib/build/install/riscv64-unknown-elf/lib/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/lib/
cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/lib/libclang_rt.builtins.a \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imac/lp64/lib/

# `rv64imafdc/lp64d`
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/include
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp -r newlib/build/install/riscv64-unknown-elf/include/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/include/
cp -r newlib/build/install/riscv64-unknown-elf/lib/rv64imafdc/lp64d/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/libclang_rt.builtins.a \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64imafdc/lp64d/lib/

# `rv64ima/lp64`
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/include
mkdir -p llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/lib
cp -r newlib/build-rv64ima-lp64/install/riscv64-unknown-elf/include/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/include/
cp -r newlib/build-rv64ima-lp64/install/riscv64-unknown-elf/lib/* \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/lib/
cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/lib/libclang_rt.builtins.a \
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/lib/
