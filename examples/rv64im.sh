###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -target riscv64-unknown-elf
  #
  --sysroot llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64imac/lp64
  -march=rv64im
  -mabi=lp64
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
  #
  -o $DIR/main
  # examples/add.c
  examples/hello.c
)
clang "${args[@]}"
clang "${args[@]}" -S -o $DIR/main.s
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -machine virt
  -cpu rv64
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
