; Include the bootloader
%include "bootloader/boot.s"
extern main

[BITS 32]

; Set up segments and stack pointer
    mov ax, 16
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

; Set stack to be 14 MB according to x86 Memory Map
    mov eax, 0x00EFFFFF
    mov esp, eax

; Now call the OS
    call main
; For safety, halt if the OS ever returns. Should not happen.
    cli
    hlt

section .text