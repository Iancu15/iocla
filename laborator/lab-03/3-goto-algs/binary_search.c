#include <stdio.h>

void main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[4]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;
	int mid;
	int result = -1;

	binary_search:
		if (end < start) {
			printf("Elementul nu exista\n");
			goto end;
		}

		mid = (start + end) / 2;
		
		if (v[mid] == dest) {
			result = mid;
			goto end;
		}

		if (v[mid] > dest) {
			end = mid - 1;
			goto binary_search;
		}

		start = mid + 1;
		goto binary_search;

	end:
		printf("\n%d\n", result);
			
	/* TODO: Implement binary search */
}
