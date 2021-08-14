;
;
; Macros:
;
;
;
;
; Segments:
;
;
	%macro lvars 1
mov ax, %1
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
	%endmacro

	%macro lmins 1
mov ax, %1
mov ds, ax
mov es, ax
	%endmacro

	%macro les 1
mov ax, %1
mov es, ax
	%endmacro
