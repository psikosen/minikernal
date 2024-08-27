ARCH = x86_64
CC = x86_64-elf-gcc
LD = x86_64-elf-ld
OBJCOPY = x86_64-elf-objcopy
LDFLAGS = -m elf_x86_64 -nostdlib -T linker.ld

CFLAGS = -m64 -ffreestanding -Wall -Wextra -I./include

SRCS = src/kernel.c src/lib/console.c
OBJS = $(SRCS:.c=.o)

all: mini-neokernel.bin

mini-neokernel.bin: $(OBJS) src/boot/boot.o
	$(LD) $(LDFLAGS) -o mini-neokernel.elf $^
	$(OBJCOPY) -O binary mini-neokernel.elf $@

src/boot/boot.o: src/boot/boot.s
	nasm -f elf64 $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

iso: mini-neokernel.bin
	mkdir -p iso/boot/grub
	cp mini-neokernel.bin iso/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo 'menuentry "Mini NeoKernel" {' >> iso/boot/grub/grub.cfg
	echo '    multiboot /boot/mini-neokernel.bin' >> iso/boot/grub/grub.cfg
	echo '    boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue -o mini-neokernel.iso iso
	rm -rf iso

run: iso
	qemu-system-x86_64 -cdrom mini-neokernel.iso

clean:
	rm -f $(OBJS) src/boot/boot.o mini-neokernel.bin mini-neokernel.elf mini-neokernel.iso

.PHONY: all clean iso run