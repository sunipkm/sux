#!/bin/bash
makebin(){
	fname={$1//".img"/}
	command nasm -f bin -o $FNAME.bin $1
	command qemu-system-i386 -drive if=floppy,format=raw,file=$FNAME.bin
	command rm $FNAME.bin 
}
