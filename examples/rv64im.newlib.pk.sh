###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

# riscv64-unknown-elf-ld --verbose >examples/ld_default.ld
#
# modify `ld_default.ld` for qemu-virt
# ref: https://twilco.github.io/riscv-from-scratch/2019/04/27/riscv-from-scratch-2.html
#

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -target riscv64-unknown-elf
  #
  --sysroot llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64
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
  -lgloss
  # -lnosys
  # -lsemihost
  #
  -Wl,-Ttext=0x80000000
  -Wl,-Map,$DIR/main.map
  #
  # -v
  -save-temps=obj
  #
  -o $DIR/main
  #
  # llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/lib/crt0.o
  examples/crt0_default.S
  examples/hello.c
  # examples/add.c
)
clang "${args[@]}"
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm
llvm-objdump -M no-aliases -s -d $DIR/main >$DIR/main.s.dasm
llvm-objcopy -O binary $DIR/main $DIR/main.bin

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -m512
  pk
  $DIR/main
)
spike "${args[@]}"

###############################################################################
