[BITS 64]
section .text
global _start
extern kernel_main  ; Declare kernel_main as an external symbol

_start:
    ; Initialize stack pointer, call the kernel main function
    cli                ; Disable interrupts
    xor rax, rax       ; Clear 64-bit registers
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; Load the stack pointer with a safe memory address
    mov rsp, 0x9FC00   ; Use 64-bit stack pointer
    ; Call the kernel main function
    call kernel_main
    ; Halt the CPU
hang:
    hlt
    jmp hang

section .note.GNU-stack noalloc noexec nowrite progbits