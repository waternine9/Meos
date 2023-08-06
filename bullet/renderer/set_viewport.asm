code_setViewport:
; PARAMS:
; signed 32-bit int x
; signed 32-bit int y
; unsigned 32-bit int width
; unsigned 32-bit int height
; Returns: nothing
.localAreaSize equ 0
; Prolog:
    enter .localAreaSize, 0
    push ebx
    push esi

; Convert parameters from X, Y, W, and H to X0, Y0, X1 and Y1:
    lea esi, [ebp + 8]
    lodsd ; Create X1.
    add [ebp + 16], eax
    lodsd ; Create Y1.
    add [ebp + 20], eax

; Clip the viewport to fit in the framebuffer and store it:
; ...setup:
    lea esi, [ebp + 8]
    lea edi, [struct_viewport]
    xor ebx, ebx
    mov ecx, [struct_context.u32_framebufferWidth]
    mov edx, [struct_context.u32_framebufferHeight]
; ...X0:
    lodsd
    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, ecx
    cmovg eax, ecx
    stosd
; ...Y0:
    lodsd
    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, edx
    cmovg eax, edx
    stosd
; ...X1:
    lodsd
    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, ecx
    cmovg eax, ecx
    stosd
; ...Y1:
    lodsd
    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, edx
    cmovg eax, edx
    stosd

; Epilog:
    pop esi
    pop ebx
    leave
    ret