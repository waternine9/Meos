#ifndef BULLET_HPP
#define BULLET_HPP

#include <stdint.h>
#include <stddef.h>

// Bullet API by JokuIhminen and saalty, 2023:

// Structures:
volatile struct BulletContext 
{
    void* FramebufferData;
    uint32_t FramebufferPitch;
    uint32_t FramebufferWidth;
    uint32_t FramebufferHeight;
};

// Enumerations:
enum BulletError : uint32_t
{
    BULLET_ERROR_NONE = 0,
    BULLET_ERROR_FRAMEBUFFER = 1
};

// Functions:
#ifdef __cplusplus
extern "C"
#endif // __cplusplus
{
    BulletError __stdcall BulletInitialize(BulletContext* Context);
    void __stdcall BulletSetPixel(int32_t X, int32_t Y, uint32_t Color);
    void __stdcall BulletDrawRectangle(int32_t X, int32_t Y, uint32_t W, uint32_t H, uint32_t Color);
    void __stdcall BulletDrawImage(void* PixelData, int32_t X, int32_t Y, uint32_t W, uint32_t H, uint32_t ColorDepth, uint32_t Pitch);
    void __stdcall BulletSetViewport(int32_t X, int32_t Y, uint32_t W, uint32_t H);
}

#endif // BULLET_HPP