C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
CFLAGS = -ffreestanding -m32 -fno-pie
CC = gcc

OBJ = ${C_SOURCES:.c=.o}

run: all
	qemu-system-i386 -drive if=floppy,format=raw,file=build/os-img

build:
	mkdir build

build/kernel.bin: build/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary -m elf_i386

build/%.o: %.c ${HEADERS}
	$(CC) $(CFLAGS) -c $< -o $@
build/%.o: kernel/%.asm
	nasm $< -f elf -o $@

build/%.bin: boot/%.asm
	nasm $< -f bin -Iboot/ -o $@

clean:
	rm -rf build/*.bin build/*.o build/os-img build kernel/*.o

all: build build/os-img

build/os-img: build/bootsect.bin build/kernel.bin
	cat $^ > build/os-img


