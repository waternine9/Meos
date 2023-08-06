code_initialize:
; PARAMS:
; structPtr context
; RETURNS: u32 error
.localAreaSize equ 4
; Prolog:
    enter .localAreaSize, 0
    push esi
    push edi

; Check parameter validity and copy at the same time:
    mov esi, [ebp + 8] ; Get the context structure.
    lea edi, [struct_context] ; Set the copy target.
    mov dword [ebp - 4], const_errorFramebuffer ; Set the error code in case this fails.
    lodsd ; Check framebuffer pointer.
    test eax, eax
    jz .error
    stosd
    movsd ; Trustingly copy row size.
    lodsd ; Check width.
    cmp eax, const_maxFramebufferWidth
    ja .error
    stosd
    lodsd ; Check height.
    cmp eax, const_maxFramebufferHeight
    ja .error
    stosd
    
; Set the default viewport:
    xor eax, eax
    push dword [struct_context.u32_framebufferHeight]
    push dword [struct_context.u32_framebufferWidth]
    push eax
    push eax
    call code_setViewport

; Set the return value to indicate success:
    mov dword [ebp - 4], 0

; Epilog:
.error:
    mov eax, [ebp - 4] ; Return value.
    pop edi
    pop esi
    leave
    ret 4