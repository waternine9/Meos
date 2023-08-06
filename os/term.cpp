#include "term.hpp"

constexpr uint32_t terminalWidth = 80;
constexpr uint32_t terminalHeight = 25;
uint32_t cursorX, cursorY;

void TermClear()
{
    for(unsigned int i = 0; i < terminalWidth * terminalHeight / 2; i++)
    {
        *(uint32_t*)(0x8B000 + i) = 0; 
    }
}

void TermPrint(const char* Str, uint8_t ColorCode)
{
    unsigned int maxLen = terminalWidth * terminalHeight;
    for(unsigned int i = 0; i < maxLen; i++)
    {
        Teletype(Str[i], ColorCode);
    }
}

void Teletype(const char c, uint8_t color)
{
    // Set character:
    if(c != 13)
    {
        *(uint16_t*)(0x8B000 + cursorY * terminalWidth + cursorX) = color << 8 | c;
        cursorX++;
    } else {
        cursorX = terminalWidth;
    };

    // Handle line wrap:
    if(cursorX >= terminalWidth)
    {
        // Set new position:
        cursorX = 0;
        cursorY++;
        // Handle scrolling:
        if(cursorY >= terminalHeight)
        {
            // Make sure cursor is on the last line:
            cursorY = terminalHeight - 1;
            
            // Scroll:
            for(unsigned int i = terminalWidth; i < terminalWidth * terminalHeight; i++)
            {
                *(uint16_t*)(0x8B000 + i) = *(uint16_t*)(0x8B000 + terminalWidth + i);
            }
        }
    }
}