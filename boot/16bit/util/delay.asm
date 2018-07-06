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