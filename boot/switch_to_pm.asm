[bits 16]
switch_to_pm:
	cli ; setting protected mode interrupt vector
	lgdt [gdt_descriptor] ; load the global descriptor table
	mov eax, cr0 ; set first bit of cr0 to enter pm
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm


[bits 32]
init_pm:
	mov ax, DATA_SEG
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov fs,ax
	mov gs,ax

	mov ebp, 0x90000 
	mov esp, ebp ; update our stack position at top of free space

	call BEGIN_PM