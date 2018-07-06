delay:
	mov bp, 8096
	mov si, 8096
	delay2:
	dec bp
	nop
	jnz delay2
	dec si
	cmp si,0    
	jnz delay2
	; end delay
	ret

shutdown:
;Turn off the system
MOV     AX,0x5307
MOV     BX,0x0001
MOV     CX,0x0003
INT     0x15

ret
;Exit (for good measure and in case of failure)

times 510-($-$$) db 0

dw 0xaa55