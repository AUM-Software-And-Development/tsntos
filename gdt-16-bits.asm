gdt_entry:
nulldescriptor:
dd 0x0
dd 0x0
codesegment:
dw 0xffff
dw 0x0
db 0x0
db 10011010b
db 11001111b
db 0x0
datasegment:
dw 0xffff
dw 0x0
db 0x0
db 10010010b
db 11001111b
db 0x0
gdt_end:
gdt:
dw gdt_end - gdt_entry -1
dd gdt_entry
code_segment: equ codesegment - gdt_entry
data_segment: equ datasegment - gdt_entry
