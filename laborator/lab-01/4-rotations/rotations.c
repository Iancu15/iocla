#include <stdio.h>

void rotate_left(int *number, int bits)
{
	int bit = number >> (bits - 1);
	int mask = number << (bits - 1);
	return ((number & ~mask) << 1) & ~bit) 
}

void rotate_right(int *number, int bits)
{
	int bit = (1 & number) << (bits - 1)
 	return ((number >> 1) & ~bit) 
}

int main()
{
	int *number, bits;
	scanf("%d %d", number, &bits)
	printf("%d %d", rotate_left(number, bits), rotate_right(number,bits));
	return 0;
}

