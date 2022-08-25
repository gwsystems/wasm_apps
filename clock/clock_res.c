#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int
main()
{
	struct timespec ts;
	int             rc;

	rc = clock_getres(CLOCK_REALTIME, &ts);
	if (rc != 0) {
		perror("clock_getres CLOCK_REALTIME");
		exit(EXIT_FAILURE);
	}
	printf("Realtime nsec: %lu\n", ts.tv_nsec);

	rc = clock_getres(CLOCK_MONOTONIC, &ts);
	if (rc != 0) {
		perror("clock_getres CLOCK_MONOTONIC");
		exit(EXIT_FAILURE);
	}
	printf("Monotonic nsec: %lu\n", ts.tv_nsec);

	puts("All tests passed!");
	exit(EXIT_SUCCESS);
}
