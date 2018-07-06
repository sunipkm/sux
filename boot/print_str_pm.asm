[bits 32]
; Consts
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_str_pm:
	pusha ; Push all registers to stack
	mov edx, VIDEO_MEMORY
begin_str_pm:
	mov al, [ebx] ; move byte to AL
	mov ah, WHITE_ON_BLACK ; color
	cmp al, 0 ; check if byte is 0
	je end_str_pm ; end of string, go to end
	mov [edx],ax ; put on screen
	inc ebx  ; increase pointer by 1
	add edx, 2 ; next cell in VIDEO_MEMORY
	;add bx, 0x0001 ; increase pointer
	jmp begin_str_pm
end_str_pm:
	popa ; pop stack to registers
	ret ; return