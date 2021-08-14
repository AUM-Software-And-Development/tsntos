source = bootloader-16-bits kernel-16-bits

.PHONY: tsnt-os # This item shouldn't be a file name, but if it is... don't run it.

clean:
	@-rm $(source) || true
	@-rm *.bin || :

tsnt-os:
	make -s clean
	nasm -f bin bootloader-16-bits.asm
	nasm -f bin kernel-16-bits.asm
	cat $(source) > tsnt-os.bin
	mv *.bin bin
	mv $(source) bin
	qemu-system-i386 -fda bin/tsnt-os.bin
