; Bullet API by JokuIhminen, 2023:
%include "abstract/macros.asm"
%include "abstract/constants.asm"
%include "abstract/export.asm"

section .text
%include "initialize.asm"
%include "renderer/set_viewport.asm"
%include "renderer/set_pixel.asm"
%include "renderer/draw_rectangle.asm"

section .data

section .bss
%include "variables.asm"