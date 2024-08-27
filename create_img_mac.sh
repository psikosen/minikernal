#!/bin/bash

# Create a disk image
dd if=/dev/zero of=mini-neokernel.img bs=1M count=64

# Create a FAT32 filesystem on the image
hdiutil attach mini-neokernel.img -mountpoint /Volumes/neokernel
diskutil eraseDisk FAT32 NEOKERNEL MBRFormat /dev/disk$(hdiutil info | grep -B 4 "mini-neokernel.img" | grep "/dev/disk" | awk '{print $1}' | sed 's/://')

# Copy the kernel to the image
cp mini-neokernel.bin /Volumes/NEOKERNEL/

# Detach the image
hdiutil detach /Volumes/NEOKERNEL

echo "Bootable disk image created: mini-neokernel.img"