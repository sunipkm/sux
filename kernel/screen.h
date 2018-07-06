#ifndef __KERN_SCREEN_H
#define __KERN_SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

#define WHITE_ON_BLACK 0x0f

//screen dev io
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

int get_screen_offset ( int col , int row );

int get_cursor ( void );

void set_cursor(int offset);

int handle_scrolling(int cursor_offset);

void print_char ( char ch , int col , int row , char attr );

void print_at ( char * str , int col , int row );

void puts ( char * str ) ;

void cls(void) ;

void putnum ( int n );
#endif
