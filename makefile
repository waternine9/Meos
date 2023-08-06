build:
	gcc -c -m32 os/*.cpp -fno-rtti -nostdlib -ffreestanding -mno-red-zone -fno-exceptions -nodefaultlibs -fno-builtin -fno-pic -O0
	nasm -f elf32 bootloader/os_trampoline.s
	ld -m i386pe *.o -T link.ld -o bin/boot.exe
	objcopy -O binary bin/boot.exe bin/boot.img
	rm *.o
run:
	qemu-system-x86_64 bin/boot.img