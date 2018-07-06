[bits 16]
[org 0x7c00] ; makes 2nd attempt right, else 3rd. Basically offsets everything
mov ah, 0x0e ; scrolling tty BIOS routine

	; Attempt 1
	;mov al , the_secret
	;int 0x10

	; Attempt 2
	mov al, [the_secret]
	;int 0x10

	;mov bx, the_secret
	;add bx, 0x7c00
	;mov al, [bx]
	;int 0x10

	;mov al, [0x7c1e]
	int 0x10

	jmp $

the_secret:
	db "X"

times 510-($-$$) db 0
dw 0xaa55