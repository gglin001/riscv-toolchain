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

# TODO: set `--prefix` to llvm toolchain dir
# cp -r $PWD/picolibc/build/install/* \
#   llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/
# mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d
# cp -r $PWD/picolibc/build/install/include \
#   llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/include
# cp -r $PWD/picolibc/build/install/include \
#   llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include
# cp -r $PWD/picolibc/build/install/lib \
#   llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib
# cp llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/lib/libclang_rt.builtins.a \
#   llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/libclang_rt.builtins.a

mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d
mkdir -p llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib
cp -r $PWD/picolibc/build/install/include \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include
cp -r $PWD/picolibc/build/install/lib/rv64imafdc/lp64d/* \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/
cp llvm-project/build_crt/install/lib/libclang_rt.builtins-riscv64.a \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/libclang_rt.builtins.a
cp picolibc/build/install/lib/picolibc.ld \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/picolibc.ld
cp picolibc/build/install/lib/picolibcpp.ld \
  llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/picolibcpp.ld
