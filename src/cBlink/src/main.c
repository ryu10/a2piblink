#include <stdio.h>
#include <stdlib.h>

#include <peekpoke.h>

extern const char text[];       /* In text.s */
extern void __fastcall__ wait(); /* In wait.s */
extern void sleep(int); /* in sleep.c */

void sleep2(int t){
  int i;

  for(i=0;i<(t*200);i++){ 
    wait(); // ~5ms delay 
  }
}

int main (void)
{
  int i;

  POKE(0xc402,0xff);

  for(i=0;i<16;i++){
    putchar('*');
    POKE(0xc400,1);
    sleep(2);

    putchar('-');
    POKE(0xc400,0);
    sleep2(1);
  }

  printf("\n");
  return EXIT_SUCCESS;
}
