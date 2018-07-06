[org 0x7c00]

mov bp, 0x9000
mov sp, bp ; set stack

mov bx, MSG_REAL_MODE
call print_str

call switch_to_pm ; note that this is the point of no return

jmp $

%include "print/print_str.asm"
%include "gdt.asm"
%include "print/print_str_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_str_pm

	jmp $

MSG_REAL_MODE db "Started in 16-bit Real Mode",0
MSG_PROT_MODE db "Succesfully landed in 32-bit Protected Mode",0

times 510-($-$$) db 0
dw 0xaa55