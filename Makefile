KSRCS := $(shell find ./kernel -name *.asm)
BSRCS := $(shell find ./bootloader -name *.asm)

system.bin: $(KSRCS) $(BSRCS)
	cd bootloader && make
	cd kernel && make
	rm -f system.bin
	touch system.bin
	cat bootloader/boot.bin >> system.bin
	cat kernel/kernel.bin >> system.bin

run: system.bin
	bochs -q 'boot:a' 'floppya: 1_44=system.bin, status=inserted'

debug: system.bin
	bochs -q 'boot:a' 'floppya: 1_44=system.bin, status=inserted' 'display_library: x, options="gui_debug"'
