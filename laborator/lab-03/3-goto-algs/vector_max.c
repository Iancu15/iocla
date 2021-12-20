#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max = -50;
	int i = 0;
	sizeof(v)/sizeof(v[0])

	start:
		if(i == 8)
			goto end;

		if(v[i] > max) {
			max = v[i];
			goto next;
		}

	next:

		i++;
		goto start;

	end:
		printf("\n%d\n", max);

	/* TODO: Implement finding the maximum value in the vector */
}
