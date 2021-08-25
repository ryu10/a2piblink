#include <stdio.h>
#include <stdlib.h>

extern const char text[];       /* In text.s */

int main (void)
{
  int i;
  for(i=0;i<8;i++){
    printf ("%s %d\n", text, i);
  }
  printf("\n");
  return EXIT_SUCCESS;
}
