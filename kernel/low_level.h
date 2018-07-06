#ifndef __KERN_LOW_LEVEL_H
#define __KERN_LOW_LEVEL_H

struct regs
{
    unsigned int gs, fs, es, ds;      /* pushed the segs last */
    unsigned int edi, esi, ebp, esp, ebx, edx, ecx, eax;  /* pushed by 'pusha' */
    unsigned int int_no, err_code;    /* our 'push byte #' and ecodes do this */
    unsigned int eip, cs, eflags, useresp, ss;   /* pushed by the processor automatically */ 
};

unsigned char port_byte_in ( unsigned short port );
void port_byte_out ( unsigned short port, unsigned char data );


unsigned short port_word_in ( unsigned short port );


void port_word_out ( unsigned short port, unsigned short data );

void timer_install(void);
void keyboard_install ( void );
void delay(int);

#endif