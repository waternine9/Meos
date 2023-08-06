#include "mem.hpp"

uint8_t Pages[50000]; // 1 page is 1 kb, 4000 pages
uint32_t PageSizes[400000];
#define ALLOC_ADDR 0x1000000

bool PageExists(int Page)
{
    uint8_t CurPage = Pages[Page / 8];
    return (CurPage >> (Page % 8)) & 1;
}

void PageUse(int Page)
{
    Pages[Page / 8] |= 1 << (Page % 8);
}

void PageFree(int Page)
{
    Pages[Page / 8] &= ~(1 << (Page % 8));
}

void* malloc(size_t _Bytes)
{
    size_t _BytesPages = _Bytes / 1000 + 1; // Kilobyte is 1000 bytes, it's Kibibyte which is 1028 
    for (int i = 0;i < 400000;i++)
    {
        bool Enough = true;
        for (int j = i;j < i + _BytesPages;j++)
        {
            if (PageExists(j))
            {
                Enough = false;
                break;
            }    
        }
        if (Enough)
        {
            PageSizes[i] = _BytesPages;
            for (int j = i;j < i + _BytesPages;j++)
            {
                PageUse(j);   
            }
            return (void*)(ALLOC_ADDR + i * 1000);
        }
    }
    return 0;
}

void free(void* _Block)
{
    uint32_t Page = ((int)_Block - ALLOC_ADDR) / 1000;
    if (Page < 0) return;
    uint32_t PageCount = PageSizes[Page];

    for (uint32_t i = Page;i < PageCount;i++)
    {
        PageFree(i);
    }
}

void AllocInit()
{
    for (int i = 0;i < 50000;i++)
    {
        Pages[i] = 0;
    }
    for (int i = 0;i < 400000;i++)
    {
        PageSizes[i] = 0;
    }
}