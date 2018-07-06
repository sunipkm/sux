print_str:
	pusha ; Push all registers to stack
	mov ah, 0x0e ; set up tty
begin_str:
	cmp byte [bx], 0h ; check if byte is 0
	jz end_str ; end of string, go to end
	mov al, [bx] ; move byte to AL
	int 0x10 ; print
	inc bx  ; increase pointer by 1
	;add bx, 0x0001 ; increase pointer
	jmp begin_str
end_str:
	mov al, 0x0d ; carriage return
	int 0x10 ; display
	mov al, 0x0a ;newline
	int 0x10 ; display
	popa ; pop stack to registers
	ret ; return