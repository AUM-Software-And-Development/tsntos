	[bits 16]
	[org 0]
;
;
; 7c0h arrival section:
;
;
jmp 0x100:0x200

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
; Note this must return to text mode to use it
	call display_build

;
;
; Test purposes:
;
;
;	call text_mode
;mov si, test
;	mov dx, 0x201
;	call video_padded_si

cli
hlt

	arrived:
db 0, "Kernel found at location 0x10*10*10.", 11111111b
	test:
db 0, "This is a test.", 11111111b

times 1024-($-$$) db 0
