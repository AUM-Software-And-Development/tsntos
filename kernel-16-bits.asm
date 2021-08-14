	[bits 16]

;
;
; 7c0h arrival section:
;
;
mov ax, cs
mov ds, ax
mov es, ax
mov si, arrived
	call video_padded_si
jmp enable_a20

	%include "macros-16-bits.asm"
	%include "video-16-bits.asm"
	%include "vga-16-bits.asm"
	%include "gdt-16-bits.asm"
arrived:
db 0, "Kernel found at location 0x10*10*10.", 11111111b

;
;
; Mode section:
;
;
enable_a20:
in al, 0x92
or al, 2
out 0x92, al
set_gdt:
cli
lgdt[gdt]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp code_segment:pmode_32
	[bits 32]
pmode_32:
mov ax, data_segment
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
mov ebp, 0x90000
mov esp, ebp
kernel:
mov byte [0x000b8000], 'K'
mov byte [0x000b8002], 'e'
mov byte [0x000b8004], 'r'
mov byte [0x000b8006], 'n'
mov byte [0x000b8008], 'e'
mov byte [0x000b800a], 'l'

;
;
; Kernel-OS section
;
;
section .text
	extern os
	call os
mov byte [0x000b8000], 'T'
cli
hlt
section .bss
section .rodata
section .data

times 1024-($-$$) db 0
