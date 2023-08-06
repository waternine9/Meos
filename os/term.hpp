#ifndef TERM_H
#define TERM_H

#include <stdint.h>
#include <stddef.h>

void TermClear();
void TermPrint(const char* Str, uint16_t ColorCode);
void Teletype(const char c, uint8_t color);

#endif // TERM_H