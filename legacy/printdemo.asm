[bits 16]
[org 0x7c00]

mov bp, 0x8000
mov sp, bp

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $

%include "print/print_str.asm"

HELLO_MSG:
	db 'Hello world!',0
GOODBYE_MSG:
	db "Bye bye!",0

times 510-($-$$) db 0

dw 0xaa55