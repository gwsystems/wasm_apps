#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

uint32_t
fib(uint32_t n)
{
	if (n <= 1) return n;
	return fib(n - 1) + fib(n - 2);
}

int
main(int argc, char **argv)
{
	uint32_t n = 0;

	if (argc > 1) {
		n = atoi(argv[1]);
	} else {
		scanf("%u", &n);
	}

	uint32_t result = fib(n);
	printf("%u\n", result);
	return 0;
}
