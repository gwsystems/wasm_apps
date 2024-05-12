#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include <stdint.h>
/* This is the dummy function to simulate TPCC different requests' execution time
 * type 1: Payment 5.7us -- pass parameter 8
 * type 2: OrderStatus 6us -- pass parameter 9
 * type 3: NewOrder 20us -- pass parameter 37
 * type 4: Delivery 88us -- pass parameter 165
 * type 5: StockLevel 100us -- pass parameter 188
 */

char buf[512] = {0};

/*
 * "This came from ejb's hsearch."
 */
uint32_t ejb_hash(const char *s, size_t len) // 9-10us
{
	unsigned char *key = (unsigned char*) s;
	const uint32_t PRIME1 = 37;
	const uint32_t PRIME2 = 1048583;
	uint32_t h = 0;

	while (len--) {
		h = h * PRIME1 ^ (*key++ - ' ');
	}
	h %= PRIME2;

	return h;
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
	uint32_t result = 0;
	for (int i = 0; i < n; i++) {
		result = ejb_hash(buf, 512);
	}
	printf("%u\n", result);
	return 0;
}
