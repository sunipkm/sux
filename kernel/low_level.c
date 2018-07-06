unsigned char port_byte_in ( unsigned short port ) {
	// C wrapper that reads byte from specified port
	// "=a" (result) means: Put AL register in variable RESULT when finished
	// "d" (port) means: load EDX with port
	unsigned char result ;
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port)); //GAS syntax, src and dest are reversed, %dx means register but %% to get the character in C
	return result ;
}

void port_byte_out ( unsigned short port, unsigned char data )
{
	__asm__("out %%al, %%dx" : :"a" (data) , "d" (port)) ;
	return ;
}

unsigned short port_word_in ( unsigned short port )
{
	unsigned short result ;
	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
}

void port_word_out ( unsigned short port, unsigned short data )
{
	__asm__("out %%ax, %%dx" : :"a" (data) , "d" (port)) ;
	return ;
}