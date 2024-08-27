#!/bin/bash

# Create directories for the ISO
mkdir -p iso/boot/grub

# Copy the kernel binary
cp mini-neokernel.bin iso/boot/

# Create GRUB configuration file
cat > iso/boot/grub/grub.cfg << EOF
set timeout=0
set default=0

menuentry "Mini NeoKernel" {
    multiboot /boot/mini-neokernel.bin
    boot
}
EOF

# Create the ISO
grub-mkrescue -o mini-neokernel.iso iso

# Clean up
rm -rf iso