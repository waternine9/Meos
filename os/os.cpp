#include <stdint.h>
#include <stddef.h>
#include "term.hpp"
#include "mem.hpp"

void volatile PrintChar(char c, int x, int y)
{
	*(uint16_t*)(0xb8000 + (y * 80 + x) * 2) = 0x0F00 | c;
}

void volatile PrintNumber(int n, int x, int y)
{
	do 
	{
		PrintChar('0' + ((n /= 10) % 10), x++, y);
	} while (n > 0);
}

void main()
{
	AllocInit();
	for (int i = 0;i < 1000;i++) PrintNumber((int)malloc(1337), 10, 10);
}