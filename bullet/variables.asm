; Variable memory area:

; Align: 4
struct_context:
.ptr_framebufferData resd 1
.u32_rowSizeInBytes resd 1
.u32_framebufferWidth resd 1
.u32_framebufferHeight resd 1

struct_viewport:
.s32_x0 resd 1
.s32_y0 resd 1
.s32_x1 resd 1
.s32_y1 resd 1

; Align: 2


; Align: 1 / don't care

