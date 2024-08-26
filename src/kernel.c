#include "include/console.h"

void kernel_main(void) {
    console_clear();
    console_write("Welcome to Mini NeoKernel!\n");
    // Initialization code goes here
    while (1) {
        __asm__ volatile ("hlt" ::: "memory");
    }
}