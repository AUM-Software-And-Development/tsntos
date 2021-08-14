source = kernel-16-bits.o os-16-bits.o
output = bootloader-16-bits kernel-16-bits

.PHONY: tsnt-os # This item shouldn't be a file name, but if it is... don't run it.

clean:
	@-rm $(source) || true
	@-rm *.bin || :
	@-rm *.o

tsnt-os:
	make -s clean
	nasm -f bin bootloader-16-bits.asm
	nasm -f elf32 kernel-16-bits.asm -o kernel-16-bits.o
	clang -c -ffreestanding -m32 -O1 -o os-16-bits.o os.c
	ld -m elf_i386 -T os.ld
	cat $(output) > tsnt-os.bin
	mv *.bin bin
	mv $(source) bin
	mv $(output) bin
	qemu-system-i386 -fda bin/tsnt-os.bin
