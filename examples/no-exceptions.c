#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main(void)
{
    printf("1. Testing return value from malloc...\n");
    int *p1 = malloc(4*sizeof(int));  // allocates enough for an array of 4 int

    if(p1) {
        printf("4 bytes successfully allocated and set:\n");
        for(int n=0; n<4; ++n) // populate the array
            p1[n] = n*n;
        for(int n=0; n<4; ++n) // print it back out
            printf("p1[%d] == %d\n", n, p1[n]);
    }

    free(p1);

    printf("\nmacOS C library writes malloc error output to stderr:\n");

    // 150,000,000,000,000 bytes == 150 terabytes
    long bytes = 150000000000000;
    int *p2 = malloc(bytes);

    printf("\nBut program keeps running, the above is not an exception!\n");
    if(p2) {
        printf("\nAllocated %ld bytes. Who lives like this?", bytes);
    } else {
        printf("\nCould not allocate %ld bytes.\n", bytes);
    }


   printf("\n\n2. Testing errno after trying to open file...\n");
   FILE * pf;
   int errnum;
   pf = fopen ("does-not-exist.txt", "r");

   if (pf == NULL) {
      errnum = errno;
      fprintf(stderr, "Value of errno: %d\n", errno);
      perror("Error printed by perror");
      fprintf(stderr, "Error opening file: %s\n", strerror( errnum ));
   } else {
      fclose (pf);
   }
   printf("\nAgain, no exception raised when opening non-existent file, program still running.\n");
   printf("Have a nice day.");

   return 0;
}
