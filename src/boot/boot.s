section .text
global _start
extern kernel_main  ; Declare kernel_main as an external symbol

_start:
    ; Initialize stack pointer, call the kernel main function
    cli                ; Disable interrupts
    xor ax, ax         ; Clear registers
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; Load the stack pointer with a safe memory address
    mov esp, 0x9FC00
    ; Call the kernel main function
    call kernel_main
    ; Halt the CPU
hang:
    hlt
    jmp hang