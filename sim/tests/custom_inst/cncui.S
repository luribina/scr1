#include "riscv_test.h"
#include "test_macros.h"

#*****************************************************************************
# cncui.S
#-----------------------------------------------------------------------------
#
# Test cncui instruction.
#

RVTEST_RV64U
RVTEST_CODE_BEGIN
  
  TEST_CASE(2, t0, 0xC8000823, \
    li t0, 0x035EF823; \
    .word 0xC80002AB; \
  )

  TEST_CASE(3, t0, 0, \
    li t0, 0; \
    .word 0x000002AB; \
  )

  TEST_CASE(4, t0, 0x12345005, \
    li t0, 0x5; \
    .word 0x123452AB; \
  )

  TEST_CASE(5, t0, 0x000003C0, \
    li t0, 0x000003C0; \
    .word 0x000002AB; \
  )

  TEST_CASE(6, t0, 0x000003C0, \
    li t0, 0x020003C0; \
    .word 0x000002AB; \
  )

  TEST_CASE(7, t0, 0xFFFFFFFF, \
    li t0, 0xFFFFFFFF; \
    .word 0xFFFFF2AB; \
  )

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
