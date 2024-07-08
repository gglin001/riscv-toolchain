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

# TODO: why fail
# build libcxx-rv64imafdc-lp64d
cmake --preset libcxx-rv64imafdc-lp64d -S$PWD/runtimes -DCMAKE_SYSROOT=$PWD/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdc/lp64d
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
