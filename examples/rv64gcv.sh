###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -target riscv64-unknown-elf
  #
  --sysroot llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imafdcv/lp64d
  -march=rv64gcv
  -mabi=lp64d
  #
  # --sysroot llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64
  # -march=rv64ima_zve64x
  # -mabi=lp64
  #
  -nostdlib
  -lc
  -lm
  -lclang_rt.builtins
  #
  -mcmodel=medany
  #
  -lcrt0-semihost
  # -lcrt0
  # -lcrt0-hosted
  #
  -lsemihost
  # -ldummyhost
  #
  -T examples/riscv.ld
  -Wl,-Map,$DIR/main.map
  #
  # -v
  -save-temps=obj
  #
  -o $DIR/main
  examples/rvv.c
)
clang "${args[@]}"
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -machine virt
  -cpu rv64,v=true,vlen=256,elen=64,vext_spec=v1.0
  -semihosting-config enable=on # semihost
  -nographic
  -bios none
  -monitor none
  -serial none
  #
  # -d out_asm
  # -d in_asm
  # -d cpu
  # -d exec
  # -d op
  #
  -kernel $DIR/main
)
qemu-system-riscv64 "${args[@]}"

###############################################################################
