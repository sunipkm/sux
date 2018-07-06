void interrupt_setup(void)
{
	idt_install();
    isrs_install();
    irq_install();
	timer_install();
	keyboard_install();
	__asm__ __volatile__ ("sti");
	return ;
}

void main(){
	interrupt_setup();
	char * video_memory = (char*) 0xb8000;
	//*video_memory = 'X';
	cls();
	puts("Welcome to sunipOS!\nWe are currently working on everything else. Please come back later.\nBye Bye!\n");
	//timer_install();
	puts("Started timer.\n");
	puts("started keyboard.\n\n") ;
	puts("Can now print numbers: " ) ;
	putnum(40920);
	puts("\n");
	//for (;;);
}
