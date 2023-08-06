code_setPixel:
; Params:
; signed 32-bit int x
; signed 32-bit int y
; unsigned 32-bit int color
; Returns: nothing
; Make sure we are within the framebuffer:
    mov ecx, [esp + 4] ; X
    mov edx, [esp + 8] ; Y
    cmp ecx, [struct_viewport.s32_x0]
    jl .exit
    cmp ecx, [struct_viewport.s32_x1]
    jge .exit
    cmp edx, [struct_viewport.s32_y0]
    jl .exit
    cmp edx, [struct_viewport.s32_y1]
    jge .exit

; Calculate the address and set the pixel:
    mov eax, [esp + 12]
    imul edx, [struct_context.u32_rowSizeInBytes]
    lea edx, [edx + ecx * 4]
    add edx, [struct_context.ptr_framebufferData]
    mov [edx], eax

; Epilog:
.exit:
    ret 12