mov ah, 0x0e ; int 10/ah = 0eh -> scrolling teletype

mov al , 'H',
int 0x10
call wait_func

mov al , 'e',
int 0x10
call wait_func

mov al , 'l',
int 0x10
call wait_func

mov al , 'l',
int 0x10
call wait_func

mov al , 'o',
int 0x10

mov al, 0x0d
int 0x10

mov al, 0x0a
int 0x10

mov al, 'w'
int 0x10

jmp $

wait_func:
	mov bp, 4096
	mov si, 4096
	delay2:
	dec bp
	nop
	jnz delay2
	dec si
	cmp si,0    
	jnz delay2
	; end delay
	ret

times 510-($-$$) db 0

dw 0xaa55