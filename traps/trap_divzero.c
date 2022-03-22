#include <stdio.h>
#include <stdint.h>

int
main()
{
	int denominator;
	scanf("%d", &denominator);
	int result = INT32_MIN / denominator;
	printf("%d\n", result);
	return 0;
}
