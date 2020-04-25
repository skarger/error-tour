#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("\nmacOS C library writes malloc error output to stderr:\n");

    // 150,000,000,000,000 bytes == 150 terabytes
    long bytes = 150000000000000;
    int *p2 = malloc(bytes);

    printf("\nBut program keeps running, the above is not an exception!\n");
    if(p2) {
        printf("\nAllocated %ld bytes. Who lives like this?", bytes);
    } else {
        printf("\nmalloc returned NULL, could not allocate %ld bytes.\n", bytes);
    }

    printf("Have a nice day.");
    return 0;
}
