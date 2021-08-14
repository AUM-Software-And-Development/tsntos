	[bits 16]
	[org 0]

;
;
; MBR section:
;
;
	jmp 0x7c0:2
mov byte [bootdisk], dl
mov ax, cs
mov ds, ax
mov dx, 0x101
mov si, bootmsg
	call video_padded_si
	call hd_to_0x1000
	jmp 0:0x1000

	%include "disk-16-bits.asm"
	%include "video-16-bits.asm"

bootmsg:
	db 0, "Read 0xa+a5+5. Found this in MBR.", 11111111b

bootdisk:
	db 0

times 510-($-$$) db 0
dw 0xaa55
