#ifndef __KERN_UTIL_H
#define __KERN_UTIL_H
void mempy(char * , char * , int ) ;
void memset ( unsigned char * dest , unsigned char value , int n ) ;
void memsetw ( unsigned short * dest , unsigned short val , int n ) ;
int strlen ( const char * str ) ;
#endif