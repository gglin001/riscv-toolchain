#!/bin/bash

# after `compiler-rt` and `libc`(picolibc)

pushd llvm-project

# build libcxx-rv64imac-lp64
cmake --preset libcxx-rv64imac-lp64 -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64
cmake --build $PWD/build-libcxx-rv64imac-lp64 --target install
cp -r build-libcxx-rv64imac-lp64/install/include/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/include/
cp -r build-libcxx-rv64imac-lp64/install/lib/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64/lib/

# build libcxx-rv64imafdc-lp64d
SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d
export EXTRA_CMAKE_C_FLAGS="-I$SYSROOT/include"
cmake --preset libcxx-rv64imafdc-lp64d -S$PWD/runtimes -DCMAKE_SYSROOT=$SYSROOT
cmake --build $PWD/build-libcxx-rv64imafdc-lp64d --target install
cp -r build-libcxx-rv64imafdc-lp64d/install/include/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/include/
cp -r build-libcxx-rv64imafdc-lp64d/install/lib/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d/lib/

# build libcxx-rv64ima-lp64
cmake --preset libcxx-rv64ima-lp64 -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64
cmake --build $PWD/build-libcxx-rv64ima-lp64 --target install
cp -r build-libcxx-rv64ima-lp64/install/include/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/include/
cp -r build-libcxx-rv64ima-lp64/install/lib/* \
  build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64/lib/

# TODO: build lldb ?

popd
