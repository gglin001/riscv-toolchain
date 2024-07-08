# riscv-toolchain

riscv bare metal toolchain

## target

clang + compiler-rt + picolibc + ld.lld on linux and macos

## build

```bash
# setup env
scripts/env_setup.sh

# llvm
bash scripts/llvm_download.sh
bash scripts/llvm_build.sh

# picolibc
bash scripts/picolibc_download.sh
bash scripts/picolibc_build.sh

# optional: libcxx
bash scripts/llvm_build_libcxx.sh

# optional: newlib
bash scripts/newlib_download.sh
bash scripts/newlib_build.sh

# optional: musl
bash scripts/musl_download.sh
bash scripts/musl_build.sh
```
