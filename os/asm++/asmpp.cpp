#include <cstdint>
#include <cstddef>
#include "asmplusplus.hpp"

enum TokenType
{
    TOKEN_OTHER,
    TOKEN_VAR,
    TOKEN_CONST,
    TOKEN_ASSIGN,
    TOKEN_ADD,
    TOKEN_SUB,
    TOKEN_MUL,
    TOKEN_DIV,
    TOKEN_MODULO,
    TOKEN_INST_JMP,
    TOKEN_INST_CALL,
    TOKEN_INST_RET

};

enum VarType
{
    VAR_PTR,
    VAR_FLOAT,
    VAR_INT8,
    VAR_INT16,
    VAR_INT32,
    VAR_UINT8,
    VAR_UINT16,
    VAR_UINT32
};

struct Variable
{
    char* Name;
    VarType Type;
    void* Data;
};

struct Const
{
    char* Name;
    VarType type;
    
    float float_val;
    int8_t int8_val;
    int16_t int16_val;
    int32_t int32_val;
    uint8_t uint8_val;
    uint16_t uint16_val;
    uint32_t uint32_val;
};

struct Token
{
    TokenType type;
    Token* First;
    Token* Second;
    Variable* Var;
    Const Val;
};

/*
HOW THE LANGUAGE LOOKS LIKE:
Task: Print "hello world"
alloc some_memory { 'A', 2, 1, 2, 'D', 'I', 'C', 'K', 0 }
var0 = *some_memory
var1 = *(some_memory + 1); 
var0 = *some_memory;

jmp label0

label0;

cmp var1, var0;
*/

constexpr unsigned int InstTokenCount = 3;

struct InstructionTokenPair {
    const char* Keyword;
    TokenType Type;
} InstTokenPairs[InstTokenCount] = {
    { "jmp", TOKEN_INST_JMP },
    { "call", TOKEN_INST_CALL },
    { "ret", TOKEN_INST_RET }
};

constexpr unsigned int OperandTokenCount = 6;

struct OperandTokenPair {
    const char* Keyword;
    TokenType Type;
} OperandTokenPairs[OperandTokenCount] = {
    {"=", TOKEN_ASSIGN},
    {"+", TOKEN_ADD},
    {"-", TOKEN_SUB},
    {"*", TOKEN_MUL},
    {"/", TOKEN_DIV},
    {"%", TOKEN_MODULO}
};

Token* Tokenize(void* Code)
{

}

TokenType GetOperandTokenType(char* str, unsigned int len)
{
    if(len)
    {
        for(unsigned int i = 0; i < OperandTokenCount; i++)
        {
            for(unsigned int j = 0; j < len; j++)
            {
                if(OperandTokenPairs[i].Keyword[j] == str[j])
                {
                   if(j == len - 1) return OperandTokenPairs[i].Type;
                } else break;
            }
        }
    }
    return TOKEN_OTHER;
}

TokenType GetInstructionTokenType(char* str, unsigned int len)
{
    if(len)
    {
        for(unsigned int i = 0; i < InstTokenCount; i++)
        {
            for(unsigned int j = 0; j < len; j++)
            {
                if(InstTokenPairs[i].Keyword[j] == str[j])
                {
                   if(j == len - 1) return InstTokenPairs[i].Type;
                } else break;
            }
        }
    }
    return TOKEN_OTHER;
}