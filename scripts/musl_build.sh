#!/bin/bash

# $PWD is `.../riscv-toolchain`

pushd musl

LLVM_BINDIR="$PWD/../llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

mkdir -p build-rv64imac-lp64 && pushd build-rv64imac-lp64
CC="clang" CROSS_COMPILE="llvm-" \
  CFLAGS="--target=riscv64-unknown-elf -mcmodel=medany -nostdlib -O2 -march=rv64imac -mabi=lp64" \
  ../configure \
  --prefix=$PWD/install \
  --target=riscv64-unknown-elf \
  --disable-shared
make -j$(nproc)
make install
popd

mkdir -p build-rv64imafdc-lp64d && pushd build-rv64imafdc-lp64d
CC="clang" CROSS_COMPILE="llvm-" \
  CFLAGS="--target=riscv64-unknown-elf -mcmodel=medany -nostdlib -O2 -march=rv64imafdc -mabi=lp64d" \
  ../configure \
  --prefix=$PWD/install \
  --target=riscv64-unknown-elf \
  --disable-shared
make -j$(nproc)
make install
popd

popd

# `rv64imac/lp64`
# no default sysroot is created, set `--sysroot` first
mkdir -p llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imac/lp64
cp -r musl/build-rv64imac-lp64/install/include \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imac/lp64/
cp -r musl/build-rv64imac-lp64/install/lib \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imac/lp64/
cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/lib/libclang_rt.builtins.a \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imac/lp64/lib/

# `rv64imafdc/lp64d`
mkdir -p llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imafdc/lp64d
cp -r musl/build-rv64imafdc-lp64d/install/include \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imafdc/lp64d/
cp -r musl/build-rv64imafdc-lp64d/install/lib \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imafdc/lp64d/
cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/libclang_rt.builtins.a \
  llvm-project/build/install/lib/musl/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
