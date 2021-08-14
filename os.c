#include "compile-targets.h"

typedef unsigned char Byte;	// 1 byte (8 bits)
typedef unsigned short Short;	// 2 bytes (16 bits)
typedef unsigned long Long;	// 4 bytes (32 bits)

enum vgacolor
{
	vgablack=0,
	vgablue=1,
	vgagreen=2,
	vgacyan=3,
	vgared=4,
};

Long os(){

	Long status = 1;

do{

if (status == 0) {
	__asm__("cli \n"
		"hlt \n"); }

else if (status == 1) {
	status = 0; }

else {
	return status; } }

	while (status != 10);

return 10; }
