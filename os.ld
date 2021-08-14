OUTPUT_FORMAT(binary)
ENTRY(os)
INPUT(kernel-16-bits.o os-16-bits.o)
OUTPUT(kernel-16-bits)

SECTIONS
{
	. = 0x1000;

	.text :
	{
		*(.text*);
	}

	.bss :
	{
		*(.bss*);
	}

	.data :
	{
		*(.data*);
	}

}
