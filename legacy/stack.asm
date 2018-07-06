[bits 16]
[org 0x7c00]
mov ah, 0x0e ; tty

mov bp, 0x8000 ; base of stack at 0x8000
mov sp, bp ;empty stack so top is at bottom

push 'A'
push 'B'
push 'C'

pop bx ; 16 bit moved to B
mov al, bl ; low of B copied to low of A
int 0x10 ;print to screen interrupt

pop bx 
mov al , bl
int 0x10

mov al, [0x7ffe]

int 0x10

jmp $

times 510-($-$$) db 0

dw 0xaa55