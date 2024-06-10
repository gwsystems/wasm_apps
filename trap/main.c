#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int
main(int argc, char **argv)
{
	uint32_t n = 0;

	if (argc > 1) {
		n = atoi(argv[1]);
	} else {
		scanf("%u", &n);
	}

	if (n == 2) {
	    /* Illegal memory operation */
	    uint32_t *trap = NULL;
	    *trap = 42;
	    printf("%u\n", *trap);
	} else if (n == 1) {
	    /*Infinite loop */
	    while(1) {};
	} else if (n == 3) {
	    /*ILLEGAL_ARITHMETIC*/
	    uint32_t trap = 10 / 0;
            printf("%u\n", trap); 
	} else {
	    printf("%u\n", n);	
	}
	
	return 0;
}
