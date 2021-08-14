#include "compile-targets.h"

typedef unsigned char  Byte;	// 1 byte (8 bits)
typedef unsigned short Short;	// 2 bytes (16 bits)
typedef unsigned long  Long;	// 4 bytes (32 bits)

static const Short vgaWidth = 80;
static const Short vgaHeight = 25;

enum vgacolor
{
	black = 0,
	blue = 1,
	green = 2,
	cyan = 3,
	red = 4,
};

static inline Byte vgatheme
(enum vgacolor fg, enum vgacolor bg)
{
	return fg | bg << 4;
}

static inline Short charoffset
(Byte character, Byte color)
{
	return (Short) character | (Short)color << 8;
}

// Void to convert?
Long strlen(const char* str)
{
	Long len = 0;
	while (str[len]) len++;
	return len;
}

void updatescreen()
{
	Long row = 0;
	Long col = 0;
	Byte pallete = vgatheme(cyan, blue);
	Short* buffer = (Short*) 0xb8000;
for (Long y = 0; y < vgaHeight; y++)
{
	for (Long x = 0; x < vgaWidth; x++)
	{
		const Long index = y * vgaWidth + x;
		buffer[index] = charoffset(' ', pallete);
	}
} }

Long os()
{
	Long status = 1;

	do {

if (status == 0)
{
	__asm__("cli \n"
		"hlt \n");
}

else if (status == 1)
{
	updatescreen();
	status = 0;
}

else 
{
	return status;
}
	
} while (status != 10);
return 10;
}
