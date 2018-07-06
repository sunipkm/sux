[bits 16]
[org 0x7c00]

mov bp, 0x7fff
mov sp, bp

mov cx, 0xabcd
call print_hex

call delay

call shutdown

%include "print/print_hex.asm"

%include "util/delayndown.asm"