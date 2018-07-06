; GDT
gdt_start:
gdt_null: ; mandatory null descriptor
	dd 0x0 ; define double word, 4 bytes
	dd 0x0 ; 

gdt_code: ;code segment descriptor
	; base = 0x0, limit = 0xfffff
	; 1st flahs: (present)1 (privilege)00 (descriptor type)1 -> 1001b
	; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
	; 2nd flags: (granularity)1 (32bit)1 (64bit segment)0 (AVL)0 ->1100b
	dw 0xffff ; limit (bits 0-15)
	dw 0x0 ; base (0-15)
	db 0x0 ; base (16-23)
	db 10011010b ; 1st flags + type flags
	db 11001111b ; 2nd flags + limit (bits 16-19)
	db 0x0 ; base (bits 24-31)

gdt_data: ;data segment descriptor
	; base = 0x0, limit = 0xfffff
	; 1st flahs: (present)1 (privilege)00 (descriptor type)1 -> 1001b
	; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
	; 2nd flags: (granularity)1 (32bit)1 (64bit segment)0 (AVL)0 ->1100b
	dw 0xffff ; limit (bits 0-15)
	dw 0x0 ; base (0-15)
	db 0x0 ; base (16-23)
	db 10010010b ; 1st flags + type flags
	db 11001111b ; 2nd flags + limit (bits 16-19)
	db 0x0 ; base (bits 24-31)

gdt_end: ;empty label added so that assembler can calculate size

;GDT Descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1 ; size of our GDT, always 1 less
	dd gdt_start

; Handy Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start