[bits 16]
[org 0x7c00]

mov bx, 30

cmp bx, 4
jle if_block
cmp bx, 40
jl elif_40
mov al , 'C'
jmp end

if_block:
	mov al, 'A'
	jmp end
elif_40:
	mov al, 'B'
	jmp end

end:
	mov ah, 0x0e
	int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55