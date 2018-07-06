disk_load:
	push dx

	mov ah, 0x02 ; bios read sector
	mov al, dh   ; read DH sectors
	mov ch, 0x00 ; select cyl 0
	mov dh, 0x00 ; select head 0
	mov cl, 0x02 ; start reading from 2nd sector

	int 0x13 ; read disk

	jc disk_err ; jump if error, then carry is set

	pop dx ; restore dx
	cmp dh, al ; check if we read everything
	jne disk_err
	ret

disk_err:
	mov bx, DISK_ERR_MSG
	call print_str
	jmp $
	

DISK_ERR_MSG:
	db "Disk read error, shutting down...",0

;%include "print/print_str.asm"
