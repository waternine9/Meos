ENTRY(main)
SECTIONS {
    . = 0x7C00;
    
    .boot :
    {
        *(.boot)
        *(.text)
    }
    .rodata : 
    {
        *(.rodata)
    }
    .data : 
    {
        *(.data)
    }
    . = 0x7C00 + 0x4000000;
    .bss : 
    {
        *(.bss)
    }
}
