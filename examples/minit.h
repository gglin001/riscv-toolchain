// https://github.com/riscv-software-src/riscv-pk/blob/master/machine/minit.c

typedef unsigned long uintptr_t;

#define MSTATUS_FS 0x00006000
#define MSTATUS_VS 0x00000600

#define write_csr(reg, val) ({ asm volatile("csrw " #reg ", %0" ::"rK"(val)); })

// NOTE: only for RVV demos for now
static void mstatus_init() {
  uintptr_t mstatus = 0;
#ifdef __riscv_flen
  mstatus |= MSTATUS_FS;
#endif
#ifdef __riscv_v_elen
  mstatus |= MSTATUS_VS;
#endif
  write_csr(mstatus, mstatus);
}
