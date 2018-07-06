void memcpy ( unsigned char * src , unsigned char * dest , int n )
{
	int i = n ;
	while ( i-- )
		*( dest + i ) = *( src + i ) ;
	return ;
}

void memset ( unsigned char * dest , unsigned char value , int n )
{
	while ( n-- )
		* ( dest + n ) = value ;
	return ;
}

void memsetw ( unsigned short * dest , unsigned short val , int n )
{
	while ( n-- )
		* ( dest + n ) = val ;
	return ;
}

int strlen ( const char * str )
{
	int i = 0 ;
	while ( str [ i ] != 0 )
		i++ ;
	return i ;
}