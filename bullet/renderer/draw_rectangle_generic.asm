code_drawRectangleGeneric:
; PARAMS:
; signed 32-bit int x
; signed 32-bit int y
; unsigned 32-bit int width
; unsigned 32-bit int height
; RETURNS: nothing
.localAreaSize equ 12
; Prolog:
    enter .localAreaSize, 0
    push esi
    push edi

; Convert parameters from X, Y, W and H to X0, Y0, X1 and Y1:
    mov ecx, [ebp + 8]
    mov edx, [ebp + 12]
    mov [ebp + 16], ecx
    mov [ebp + 20], edx

; Make sure parameters are within the viewport:

; Draw the rectangle:
; ...find the starting address:
    mov eax, [ebp + 8]
    mov edi, [ebp + 12]
    imul edi, [struct_context.u32_rowSizeInBytes]
    lea edi, [edi + eax * 4]
    add edi, [struct_context.ptr_framebufferData]
; ...calculate the row increment offset:
    mov eax, [ebp - 4]
    shl eax, 2
    sub eax, [struct_context.u32_rowSizeInBytes]
    neg eax
    mov [ebp - 12], eax
; ...loop vertically:
    mov edx, [ebp - 8]
    .y_loop:
    ; ...loop horizontally, one pixel at a time:
        mov eax, [ebp + 24] ; Get color.
        mov ecx, [ebp - 4] ; Get row width modulo by 8.
        and ecx, 7
        .x_loop_small:
        ; ...set a pixel:
            stosd
        ; ...repeat:
            dec ecx
            jnz .x_loop
    ; ...advance:
        add edi, [ebp - 12]
    ; ...repeat:
        dec edx
        jnz .y_loop

; Epilog:
.exit:
    pop edi
    pop esi
    leave
    ret 16