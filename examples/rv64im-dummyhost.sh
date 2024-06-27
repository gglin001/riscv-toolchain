###############################################################################

LLVM_BINDIR="$PWD/llvm-project/build/install/bin"
export PATH="$LLVM_BINDIR:$PATH"

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -target riscv64-unknown-elf
  #
  --sysroot llvm-project/build/install/lib/clang-runtimes/riscv64-unknown-elf/rv64ima/lp64
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
  # -lcrt0-semihost
  -lcrt0
  # -lcrt0-hosted
  #
  # -lsemihost
  -ldummyhost
  #
  -T examples/riscv.ld
  -Wl,-Map,$DIR/main.map
  #
  # -v
  -save-temps=obj
  #
  -o $DIR/main
  # examples/add.c
  examples/hello.c
)
clang "${args[@]}"
llvm-objdump -M no-aliases -d $DIR/main >$DIR/main.dasm

###############################################################################

DIR="_demos/example" && mkdir -p $DIR
args=(
  -d
  # --isa rv64gcv
  --isa rv64g
  --pc=0x80000000
  $DIR/main
)
spike "${args[@]}"

# r 300
# r 300

###############################################################################
