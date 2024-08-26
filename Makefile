ARCH = x86_64
CC = x86_64-elf-gcc
LD = x86_64-elf-ld
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra \
         -fno-exceptions -fno-stack-protector -nostdlib -nostdinc \
         -fno-builtin -I src/include
LDFLAGS = -m elf_x86_64 -nostdlib -T linker.ld

SRCS = src/kernel.c src/lib/console.c
OBJS = $(SRCS:.c=.o)

all: mini-neokernel.bin

mini-neokernel.bin: $(OBJS) src/boot/boot.o
	$(LD) $(LDFLAGS) -o mini-neokernel.elf src/boot/boot.o $(OBJS)
	objcopy -O binary mini-neokernel.elf mini-neokernel.bin

src/boot/boot.o: src/boot/boot.s
	nasm -f elf64 src/boot/boot.s -o src/boot/boot.o

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f src/*.o src/lib/*.o src/boot/*.o mini-neokernel.bin mini-neokernel.elf
