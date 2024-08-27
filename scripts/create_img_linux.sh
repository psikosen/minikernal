#!/bin/bash

# Create a disk image
dd if=/dev/zero of=mini-neokernel.img bs=1M count=64

# Set up a loop device
LOOP_DEVICE=$(sudo losetup -f --show mini-neokernel.img)

# Create a FAT32 filesystem on the image
sudo mkfs.vfat -F 32 $LOOP_DEVICE

# Mount the filesystem
sudo mkdir -p /mnt/neokernel
sudo mount $LOOP_DEVICE /mnt/neokernel

# Copy the kernel to the image
sudo cp mini-neokernel.bin /mnt/neokernel/

# Unmount the filesystem
sudo umount /mnt/neokernel

# Detach the loop device
sudo losetup -d $LOOP_DEVICE

echo "Bootable disk image created: mini-neokernel.img"