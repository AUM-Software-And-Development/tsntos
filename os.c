#pragma once

typedef int Integer;

extern display_build();

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
