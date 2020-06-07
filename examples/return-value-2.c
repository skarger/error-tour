#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    // 150,000,000,000,000 bytes == 150 terabytes
    long bytes = 150000000000000;
    int *p2 = malloc(bytes);

    printf("\nBut program keeps running, the above is not an exception!\n");
    for(int n=0; n<4; ++n) // populate the array
        p2[n] = n*n;


    printf("Have a nice day.");
    return 0;
}


        // 150,000,000,000,000 bytes == 150 terabytes
        long bytes = 150000000000000;
        p = realloc(p, bytes);
        p[index] = index*index;
