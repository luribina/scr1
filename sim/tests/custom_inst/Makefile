
include rv32_tests.inc

ARCH_tmp := imf

ifneq (,$(findstring c,$(ARCH_lowercase)))
	ARCH_tmp := $(ARCH_tmp)c
endif

override ARCH := $(ARCH_tmp)

src_dir := $(CURDIR)
obj_dir   := $(bld_dir)/riscv_objs
test_list := $(patsubst %.S, %, $(notdir $(rv32_isa_tests)))
objs      := $(addprefix $(obj_dir)/,$(test_list:%=%.o))
test_elf  := $(addprefix $(bld_dir)/,$(test_list:%=%.elf))
test_hex  := $(addprefix $(bld_dir)/,$(test_list:%=%.hex))
test_dump := $(addprefix $(bld_dir)/,$(test_list:%=%.dump))

CFLAGS := -I$(inc_dir) -I$(src_dir) -DASM -Wa,-march=rv32$(ARCH) -march=rv32$(ARCH) -mabi=ilp32f -D__riscv_xlen=32
LDFLAGS := -static -fvisibility=hidden -nostdlib -nostartfiles -T$(inc_dir)/link.ld -march=rv32$(ARCH) -mabi=ilp32f
RISCV_TESTS := $(src_dir)/

VPATH += $(src_dir) $(bld_dir) $(obj_dir) $(RISCV_TESTS)

default: log_requested_tgt $(test_elf) $(test_hex) $(test_dump)

define compile_template
$(obj_dir)/$$(basename $(notdir $(SRC))).o: $$(SRC) | $(obj_dir)
	$(RISCV_GCC) -c $$< $(CFLAGS) -o $$@
 endef

$(foreach SRC,$(rv32_isa_tests), $(eval $(compile_template)))

log_requested_tgt:
	$(foreach test_name, $(test_list), $(eval $(shell echo $(test_name).hex >> $(bld_dir)/test_info)))

$(obj_dir) :
	mkdir -p $(obj_dir)

$(bld_dir)/%.elf: $(obj_dir)/%.o | $(obj_dir)
	$(RISCV_GCC) $^ $(LDFLAGS) -o $@

$(bld_dir)/%.hex: $(bld_dir)/%.elf
	$(RISCV_OBJCOPY) $^ $@

$(bld_dir)/%.dump: $(bld_dir)/%.elf
	$(RISCV_OBJDUMP) $^ > $@

clean:
	$(RM) $(test_elf) $(test_hex) $(test_dump) $(objs)
	$(RM) -R $(obj_dir)
