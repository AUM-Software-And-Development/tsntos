hd_to_0x1000:
mov dx, 0x102
mov si, attempting
	call video_padded_si
xor ax, ax
mov es, ax
mov ah, 2
mov al, 2
mov bx, 0x1000
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0
int 0x13
jc read_error
ret

read_error:
mov dx, 0x102
mov si, dreaderror
	call video_padded_si
cli
hlt

attempting:
db 0, "Try sector 2+ from BIOS disk to 0x10*10*10.", 11111111b

dreaderror:
db 0, "The disk sector could not be read.", 11111111b
