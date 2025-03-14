###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

# riscv64-unknown-elf-ld --verbose >examples/ld_default.ld
#
# modify `ld_default.ld` for qemu-virt
# ref:
# https://twilco.github.io/riscv-from-scratch/2019/04/27/riscv-from-scratch-2.html
# https://github.com/qemu/qemu/blob/master/hw/riscv/virt.c
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
  # -lgloss
  # -lnosys
  -lsemihost
  #
  # -Wl,-Ttext=0x80000000
  -T examples/ld.default.qemu.ld
  -Wl,-Map,$DIR/main.map
  #
  # -v
  -save-temps=obj
  #
  -o $DIR/main
  #
  examples/crt0.default.qemu.S
  examples/hello.c # TODO: support qemu virt uart
  # examples/add.c
)
clang "${args[@]}"
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm
llvm-objdump -M no-aliases -s -d $DIR/main >$DIR/main.s.dasm
llvm-objcopy -O binary $DIR/main $DIR/main.bin

###############################################################################

# DIR="_demos/example" && mkdir -p $DIR
# args=(
#   -m512
#   -d
#   $DIR/main
# )
# spike "${args[@]}"

# r 100

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -m 512M
  -machine virt
  -cpu rv64
  -semihosting-config enable=on # semihost
  -nographic
  -bios none
  -monitor none
  -serial none
  # -serial stdio
  #
  # -d out_asm
  -d in_asm
  # -d cpu
  # -d exec
  # -d op
  #
  -kernel $DIR/main
  # -kernel $DIR/main.bin
)
qemu-system-riscv64 "${args[@]}"
# qemu-system-riscv64 -s "${args[@]}"

###############################################################################

# gdb
# target remote :1234

# lldb
# target create _demos/example/main
# gdb-remote localhost:1234

###############################################################################
