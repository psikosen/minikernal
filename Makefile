ARCH = x86
CC = clang
CFLAGS = -target i386-none-elf -m32 -ffreestanding -O2 -Wall -Wextra \
         -fno-exceptions -fno-stack-protector -nostdlib -nostdinc \
         -fno-builtin -I src/include
LDFLAGS = -target i386-none-elf -nostdlib -T linker.ld
SRCS = src/kernel.c src/lib/console.c
OBJS = $(SRCS:.c=.o)

all: mini-neokernel.bin

mini-neokernel.bin: $(OBJS) src/boot/boot.o
	$(CC) $(LDFLAGS) -o mini-neokernel.elf src/boot/boot.o $(OBJS)
	objcopy -O binary mini-neokernel.elf mini-neokernel.bin

src/boot/boot.o: src/boot/boot.s
	nasm -f elf32 src/boot/boot.s -o src/boot/boot.o

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f src/*.o src/lib/*.o src/boot/*.o mini-neokernel.bin mini-neokernel.elf