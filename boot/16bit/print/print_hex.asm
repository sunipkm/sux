print_hex:
	pusha ; Push all registers to stack
	mov ah, 0x0e ; set up tty
	mov al, '0'
	int 0x10
	mov al, 'x'
	int 0x10
	mov dx , 0x05
begin_hex:
	dec dx
	jz end_hex
	mov bx, cx
	rol bx, 0x04
	mov cx, bx
	and bx, 0x000f
	cmp bl, 0x0a
	jl number_hex
letter_hex:
	add bl, 0x57
	mov al, bl
	jmp hex_print
number_hex:
	add bl, 0x30
	mov al, bl
	jmp hex_print
hex_print:
	int 0x10
	jmp begin_hex
end_hex:
	mov al, 0x0d ; carriage return
	int 0x10 ; display
	mov al, 0x0a ;newline
	int 0x10 ; display
	popa ; pop stack to registers
	ret ; return