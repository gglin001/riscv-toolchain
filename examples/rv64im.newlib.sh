###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -target riscv64-unknown-elf
  #
  --sysroot llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64
  -march=rv64im
  -mabi=lp64
  #
  -Wl,-Ttext=0x80000000
  #
  -nostdlib
  -lc
  # -lm
  -lgloss
  -lclang_rt.builtins
  #
  -mcmodel=medany
  -Wl,-Map,$DIR/main.map
  #
  # -v
  -save-temps=obj
  #
  -o $DIR/main
  #
  llvm-project/build/install/lib/newlib/riscv64-unknown-elf/rv64ima/lp64/lib/crt0.o
  # examples/add.c
  examples/hello.c
)
clang "${args[@]}"
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm
llvm-objcopy -O binary $DIR/main $DIR/main.bin

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  pk
  $DIR/main
)
spike "${args[@]}"

#####

# DIR="_demos/example" && mkdir -p $DIR
# args=(
#   -d
#   pk
#   $DIR/main
# )
# spike "${args[@]}"

# # 2 times
# # until pc 0 0x80000000

exit

###############################################################################

# TODO: why fail

DIR="_demos/example" && mkdir -p $DIR
args=(
  # -m 512M
  -machine virt
  -cpu rv64
  # -semihosting-config enable=on # semihost
  -nographic
  -bios none
  -monitor none
  -serial none
  #
  # -d out_asm
  -d in_asm
  # -d cpu
  # -d exec
  # -d op
  #
  # -kernel $DIR/main
  -kernel $DIR/main.bin
)
qemu-system-riscv64 "${args[@]}"
# qemu-system-riscv64 -s "${args[@]}"

###############################################################################

# gdb
# target remote :1234

lldb
target create _demos/example/main
gdb-remote localhost:1234

###############################################################################
