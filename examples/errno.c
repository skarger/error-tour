#include <stdio.h>
#include <errno.h>

int main(void)
{
   printf("Opening file...\n");
   FILE * fp;
   fp = fopen("does-not-exist.txt", "r+");

   if (fp == NULL) {
     fprintf(stderr, "Value of errno: %d\n", errno);
     perror("Error printed by perror");
   } else {
   printf("\nWriting to file...\n");
   fprintf(fp,"some data");
   }

   printf("\nHave a nice day.");
   return 0;
}
