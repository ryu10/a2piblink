#include <stdio.h>
#include <stdlib.h>

#include <peekpoke.h>

extern const char text[];       /* In text.s */
extern void __fastcall__ wait(); /* In wait.s */
extern void sleep(int); /* in sleep.c */

void sleep2(int t){
  int i;

  for(i=0;i<(t);i++){ 
    wait(); // ~1s delay 
  }
}

int main (void)
{
  int i;

  POKE(0xc402,0xff); /* DDRB; Set PB to output */
  POKE(0xc40b,0); /* ACR; Timer 1: one-shot; ShiftReg: disabled; PB7: unchanged. */
  POKE(0xc40e,0x7f); /* IER; Disable all IRQ triggers */

  for(i=0;i<16;i++){
    putchar('*');
    POKE(0xc400,1);
    sleep2(1);

    putchar('-');
    POKE(0xc400,0);
    sleep2(1);
  }

  printf("\n");
  return EXIT_SUCCESS;
}
