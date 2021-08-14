#pragma once

#include "compile-targets.h"

typedef int Integer;

int os()
{
	Integer status = 1;
	if (status == 0)
	{
	__asm__("cli");
	__asm("hlt");
	}
	else
	{
		return status;
	}
}
