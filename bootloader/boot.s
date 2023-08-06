; JokuIhminen's JokuBOOT (modified by saltman):

; Developer settings:
%define firstSectorToRead 2
%define sectorsToRead 20
%define osStartAddress 0x7E00

; Directives:
bits 16

section .boot

; Entry point:
entry:
; First things first, store the drive number
    mov [DriveNumber], dl

; Setup segments and stack pointer:
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov ax, 0x7C00
    mov sp, ax

; Hook the #UD exception:
    mov [24], word code_handleError
    mov [26], ax

; Activate A20
    mov ax, 0x2403
    int 0x15

; Load sectors:
    mov ah, 0x02
    mov al, sectorsToRead
    mov dl, [DriveNumber]
    xor dh, dh
    mov cl, firstSectorToRead
    mov bx, osStartAddress
    int 0x13
    jnc code_handleError ; If carry is set, loading sectors failed.

; Load a global descriptor table for flat addressing:
    cli
    lgdt [GDTDesc]
    mov   eax, cr0
    or    eax, 1
    mov   cr0, eax
    jmp 8:osStartAddress

; Error handler (takes in si as error message)
code_handleError:
; Print the error message:
    mov si, DiskErrorMsg
; ...loop through:
    .char_loop:
        lodsb ; Get a character.
        test al, al ; If zero, we are done.
        jz .done
        mov ah, 0xE ; Print the character.
        xor bx, bx
        int 0x10
        jmp .char_loop ; Repeat.

.done:
    cli
    hlt

; Data:
DiskErrorMsg db "FATAL: Failed to load OS!"
db 0

GDTStart:
    dq 0 
GDTCode:
    dw 0xFFFF     ; Limit
    dw 0x0000     ; Base
    db 0x00       ; Base
    db 0b10011010 ; Access
    db 0b11001111 ; Flags + Limit
    db 0x00       ; Base
GDTData:
    dw 0xFFFF     ; Limit
    dw 0x0000     ; Base
    db 0x00       ; Base
    db 0b10010010 ; Access
    db 0b11001111 ; Flags + Limit
    db 0x00       ; Base
GDTEnd:

GDTDesc:
    .GDTSize dw GDTEnd - GDTStart ; GDT size 
    .GDTAddr dd GDTStart          ; GDT address

DriveNumber: resb 1

; Boot signature:
times 510 - ($ - $$) db 0x0
dw 0xAA55