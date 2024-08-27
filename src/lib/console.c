#include "../include/console.h"

#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#if defined(__linux__) && defined(__ELF__)
__asm__(".section .note.GNU-stack,\"\",%progbits");
#endif

static uint16_t* vga_buffer = (uint16_t*)VGA_ADDRESS;

static uint16_t vga_entry(unsigned char ch, uint8_t color) {
    return (uint16_t)ch | (uint16_t)color << 8;
}

void console_clear() {
    for (int y = 0; y < VGA_HEIGHT; y++) {
        for (int x = 0; x < VGA_WIDTH; x++) {
            vga_buffer[y * VGA_WIDTH + x] = vga_entry(' ', 0x07);
        }
    }
}

void console_write(const char* str) {
    int index = 0;
    while (str[index]) {
        vga_buffer[index] = vga_entry(str[index], 0x07);
        index++;
    }
}