[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_str

call load_kernel

call switch_to_pm

jmp $

%include "16bit/print/print_str.asm"
%include "16bit/disk/diskload.asm"
%include "gdt.asm"
%include "print_str_pm.asm"
%include "switch_to_pm.asm"
[bits 16]
;load kern
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print_str

	mov bx, KERNEL_OFFSET ; parameter for diskload
	mov dh, 15 ; 15 sectors
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
; switched to 32 bit
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_str_pm

	call KERNEL_OFFSET

	jmp $

;GLOBAL VARS
BOOT_DRIVE db 0
MSG_REAL_MODE db "Starting in 16-bit Real Mode",0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0

times 510-($-$$) db 0
dw 0xaa55
