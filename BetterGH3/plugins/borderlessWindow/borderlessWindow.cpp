#include "core/Patcher.h"
#include <Windows.h>

static GH3P::Patcher g_patcher = GH3P::Patcher(__FILE__);

// Game memory addresses
static void* hWndDetour = (void*)0x0057BA6F;  // Called after CreateWindow
static int*  wndStyle   = (int*)0x0057BA5D;   // Window style flags
static HWND* hWnd       = (HWND*)0x00C5B8F8;  // Game window handle

// --- Helper: set GH3 window to borderless fullscreen ---
void ApplyBorderless()
{
    HWND hwnd = *hWnd;
    if (hwnd && IsWindow(hwnd))
    {
        // Remove all window styles
        SetWindowLong(hwnd, GWL_STYLE, WS_POPUP);
        SetWindowLong(hwnd, GWL_EXSTYLE, 0);

        // Resize to fill the primary display
        int screenW = GetSystemMetrics(SM_CXSCREEN);
        int screenH = GetSystemMetrics(SM_CYSCREEN);
        SetWindowPos(hwnd, HWND_TOP, 0, 0, screenW, screenH,
            SWP_FRAMECHANGED | SWP_NOZORDER | SWP_SHOWWINDOW);
    }
}

// --- Naked detour wrapper (cannot use C++ vars here) ---
__declspec(naked) void BorderlessHack()
{
    static const uint32_t returnAddress = 0x0057BA75;
    __asm {
        pushad
        call ApplyBorderless
        popad
        jmp returnAddress
    }
}

// --- Plugin entry point ---
void ApplyHack()
{
    // Force borderless style before window creation
    g_patcher.WriteInt32(wndStyle, WS_POPUP);

    // Hook post-window creation to resize & remove decorations
    g_patcher.WriteJmp(hWndDetour, BorderlessHack);
}
