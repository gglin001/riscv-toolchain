#!/bin/bash

# $PWD is `.../riscv-toolchain`
ln -s $PWD/scripts/picolibc-cross.txt $PWD/picolibc/picolibc-cross.txt

pushd picolibc

LLVM_BINDIR="$PWD/../llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"
args=(
  --cross-file=$PWD/picolibc-cross.txt
  --prefix=$PWD/build/install
  build
)
meson setup "${args[@]}"

meson compile -C build
meson install -C build

popd
