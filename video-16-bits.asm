;
;
; Plain video array
;
;
video_si:
pusha
mov ah, 0x0e
	.charloop:
	mov al, [si]
	cmp al, 0
	je .initiatecount
	cmp al, 255
	je .exit
	cmp cl, 255
	je .exit
	inc si
	inc cl
	cmp al, [si]
	je .charloop
		int 0x10
	jmp .charloop
	
	.initiatecount:
		int 0x10	
	xor cl, cl
	inc cl
	inc si
	jmp .charloop
.exit:
popa
	ret

;
;
; Video array with extra line feed(s)
; Reserved: cx for the function counter
; Variables: dh, dl for before and after si
;
;
video_padded_si:
pusha
xor cx, cx
.loop1:
cmp ch, dh
je .exitloop1
	call video_0x0a0d
inc ch
jmp .loop1
.exitloop1:
	call video_si
.loop2:
cmp cl, dl
je .exitloop2
	call video_0x0a0d
inc cl
jmp .loop2
.exitloop2:
popa
	ret

;
;
; New line
;
;
video_0x0a0d:
pusha
mov ax, 0x0e0a
int 0x10
mov al, 0x0d
int 0x10
popa
	ret

;
;
; Define text mode
; Interrupts: 0x10
; ah = 0 results in resolution selection
;      al = 1-3 are the modes for it
; ah = 0x0b results in background/border color updates
;      bh/bl are the colors
;
;
text_mode:
pusha
mov ah, 0
mov al, 3
int 0x10
mov ah, 0x0b
mov bh, 0
mov bl, 0x09
int 0x10
popa
	ret	
