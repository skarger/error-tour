#include <stdio.h>
#include <errno.h>

int main(void)
{
   printf("Testing errno after trying to open file...\n");
   FILE * pf;
   pf = fopen ("does-not-exist.txt", "r");

   if (pf == NULL) {
      fprintf(stderr, "Value of errno: %d\n", errno);
      perror("Error printed by perror");
   } else {
      fclose (pf);
   }
   printf("\nAgain, no exception raised when opening non-existent file, program still running.\n");

   printf("Have a nice day.");
   return 0;
}
