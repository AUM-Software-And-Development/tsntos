;
;
; Note all VGA locations can be defined by within one segment
; 65536 vs 64000
;
;
; VGA video ram:
;	0a000h Segment paragraph address
;	offset range: 0-fa00h
;
; Mode 13h:
; 	320 x 200 x 256 is colors using a pallete
; 	Pixel = 1 byte - 00h to ffh 
;	([bit]pp is not used in VGA)
; 
; No conventions. Width == Stride == 320
;
; To plot a pixel:
; 	offset = y_pos * 320 + x_pos
;	Which row in use (y), and how far down the
;       row is it? (x)
;
;
;
;
; Display:
;
;
	vgaaddress:
dw 0xa000
	display_build:
pusha

	; This will set mcga mode, 320x200x256
mov ah, 0
mov al, 19
int 16

;
;
; Note les fails if the data segment is changed.
;
; les is useful for paging data segments
; (multi-threading sectors)
; it uses the current ds as its segment.
;
; di gets the address until the register is full
; (2 bytes in real mode)
;
; es gets the offset -> assumed to be the following x bytes.
;
;
	lds si, [vgaaddress]
	mov ax, cs
	mov ds, ax
	les di, ds:[vgaaddress]
	les si

	; Set bx as a pointer within the segment
	; (uses es:bx to address video memory)
	; Pixel colors are mapped 0-0x0ff or 0-256

display_line:
mov ax, 90  ; y position
mov cx, 320 ; stride/width
mul cx      ; change ax to ax * cx
mov bx, ax
mov al, 3 

mov ax, 320 
add ax, bx

.aloop:
cmp bx, ax
	je display_close
es mov [bx], al
inc bx
jmp .aloop

display_close:
popa
	lvars cs
ret
