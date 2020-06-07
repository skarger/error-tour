#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *p = malloc(sizeof(int));

    printf("Testing return value from malloc...\n");
    if (p) {
        p[0] = 99;
        printf("Memory successfully allocated and set:\n");
        printf("p[0] == %d\n", p[0]);

        free(p);
    }

    printf("Have a nice day.");
    return 0;
}
