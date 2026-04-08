#include "core\Patcher.h"

static GH3P::Patcher g_patcher = GH3P::Patcher(__FILE__);

static void*D3DPPpi = (void*)0x0057BB79;
static int*presint = (int*)0x00C5B934;

void ApplyHack()
{
	g_patcher.WriteNOPs(D3DPPpi, 6);
	g_patcher.WriteInt32(presint, 0x80000000);
}