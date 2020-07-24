#include <stdio.h>
#include <errno.h>

int main(void)
{
   printf("Opening file...\n");
   FILE * fp;
   fp = fopen("does-not-exist.txt", "r+");

   if (fp != NULL) {
     printf("\nWriting to file...\n");
     fprintf(fp,"some data");
   } else {
     printf("\nCannot write to non-existent file.\n");
   }

   printf("\nHave a nice day.\n");
   return 0;
}
