#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("Testing return value from malloc...\n");
    int *p1 = malloc(4*sizeof(int));  // allocates enough for an array of 4 int

    if(p1) {
        printf("4 bytes successfully allocated and set:\n");
        for(int n=0; n<4; ++n) // populate the array
            p1[n] = n*n;
        for(int n=0; n<4; ++n) // print it back out
            printf("p1[%d] == %d\n", n, p1[n]);
    }

    free(p1);

    printf("Have a nice day.");
    return 0;
}
