[org 0x7c00]

mov [BOOT_DRV], dl ; BIOS stores boot drive at dl


mov bp, 0x8000 ; init stack pointers
mov sp, bp

;mov bx,0xa000
;mov es,bx ; ES=0x0000 indirectly

mov bx, 0x9000 ; Loat 5 sectors to 0x0000(ES):0x9000(BX)
mov dh, 5
mov dl, [BOOT_DRV]
call disk_load

mov cx, [0x9000]
call print_hex

mov cx, [0x9000+512]
call print_hex

call delay
call shutdown

%include "disk/diskload.asm"

%include "print/print_hex.asm"
;%include "print/print_str.asm"
BOOT_DRV: db 0

%include "util/delayndown.asm"

times 256 dw 0xdead
times 256 dw 0xface