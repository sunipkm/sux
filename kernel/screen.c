#include "screen.h"

int get_screen_offset ( int col, int row )
{
	return 2 * ( row * MAX_COLS + col ) ;
}

int get_cursor ( void )
{
	//dev uses its control register as an index to select internal regs
	// 14: high byte of cursor offset
	// 15: low byte of cursor offset
	port_byte_out(REG_SCREEN_CTRL,14);
	int offset = port_byte_in(REG_SCREEN_DATA) << 8 ; //got the byte and shifted it a byte to make it high
	port_byte_out(REG_SCREEN_CTRL,15); //select next register
	offset += port_byte_in(REG_SCREEN_DATA); //put the low byte in

	return offset * 2 ; //since each char is 2 bytes
}

void set_cursor(int offset){
	offset /= 2 ; //character index
	port_byte_out(REG_SCREEN_CTRL,14);
	port_byte_out(REG_SCREEN_DATA,(unsigned char)( offset >> 8 ) ) ; //move high byte to low and put it in
	port_byte_out(REG_SCREEN_CTRL,15);
	port_byte_out(REG_SCREEN_DATA,(unsigned char)( offset ) ) ;
	return ;
}

int handle_scrolling(int cursor_offset)
{
	if ( cursor_offset < MAX_ROWS*MAX_COLS*2 )
	{
		return cursor_offset ;
	}
	int i ;
	for ( i = 1 ; i < MAX_ROWS ; i++ ) {
		memcpy ( get_screen_offset ( 0 , i ) + VIDEO_ADDRESS , get_screen_offset ( 0 , i - 1 ) + VIDEO_ADDRESS , MAX_COLS * 2 ) ;
	}
	char * last_line = get_screen_offset ( 0 , MAX_ROWS - 1 ) + VIDEO_ADDRESS ;
	for ( i = 0 ; i < MAX_COLS * 2 ; i++ )
		last_line [ i ] = 0 ;

	cursor_offset -= 2 * MAX_COLS ;

	return cursor_offset ;
}


void print_char ( char ch , int col , int row , char attr )
{
	if ( ch == 0 )
		return ;
	unsigned char * vidmem = ( unsigned  char * ) VIDEO_ADDRESS ;

	if ( ! attr )
	{
		attr = WHITE_ON_BLACK ;
	}

	int offset ;
	if (!( row < 0 || col < 0 ) )
		offset = get_screen_offset ( col , row ) ;
	else
		offset = get_cursor ( ) ;
	if ( ch == '\n' )
	//set offset to end of current row so it will advance to first col of next row
	{
		int rows = offset / (2 * MAX_COLS) ;
		offset = get_screen_offset ( 79 , rows ) ;
	}
	else
	//commit to vidmem. Remember, little endian system
	{
		vidmem [ offset ] = ch ;
		vidmem [ offset + 1 ] = attr ;
	}

	offset += 2 ;
	offset = handle_scrolling ( offset ) ;
	set_cursor ( offset ) ;
}

void putch ( unsigned char c )
{
	print_char ( c , -1 , -1 , WHITE_ON_BLACK ) ;
}

void print_at ( char * str , int col , int row )
{
	if ( col >= 0 && row >= 0 )
		set_cursor(get_screen_offset(row,col));
	int i = 0 ;
	while(str[i]!=0)
	{
		print_char(str[i++], col, row, WHITE_ON_BLACK) ;
	}
	return ;
}

void puts ( char * str )
{
	print_at ( str , -1 , -1) ;
}



void cls(void){
	int row = 0 , col = 0 ;
	//Loop through vid mem and write blank
	for ( row = 0 ; row < MAX_ROWS ; row++ )
		for ( col = 0 ; col < MAX_COLS ; col++ )
			print_char ( ' ' , col, row, WHITE_ON_BLACK ) ;
	set_cursor ( get_screen_offset ( 0 , 0 ) ) ;
	return ;
}

void putnum ( int n )
{
	char str[11] ;
	int i = 11, c;
	while(i--)
		str[i]=0;
	i = 0 ;
	while ( n != 0 )
	{
		c = n % 10 ;
		n /= 10 ;
		str [i] = '0'+ (unsigned char) c ;
		i++ ;
		c = 0 ;
	}
	i++ ;
	while(i--)
		putch(str[i]) ;
	return ;
}
