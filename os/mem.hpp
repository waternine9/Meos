#ifndef MEM_HPP
#define MEM_HPP

#include <stdint.h>
#include <stddef.h>

void* malloc(size_t _Bytes);
void free(void* _Block);
void AllocInit();

#endif // MEM_HPP