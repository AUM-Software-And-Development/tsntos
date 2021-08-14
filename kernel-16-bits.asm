	[bits 16]
;
;
; 7c0h arrival section:
;
;
jmp 0x1200

	%include "macros-16-bits.asm"
	%include "video-16-bits.asm"
	%include "vga-16-bits.asm"

times 512-($-$$) db 0

	lvs cs
mov si, arrived
	call video_padded_si
;
;
; OS section:
;
;
section .text
	extern os
operating_system:
enable_a20:
in al, 0x92
or al, 2
out 0x92, al
	call os
; Testing:
cmp eax, 1
je vga_db
vid_t:
call text_mode
mov si, test
mov dx, 0x101
	call video_padded_si
cli
hlt
vga_db:
	call display_build
cli
hlt

section .bss
section .rodata
section .data
	arrived:
db 0, "Kernel found at location 0x10*10*10.", 11111111b
	test:
db 0, "This is a test.", 11111111b

times 1024-($-$$) db 0
