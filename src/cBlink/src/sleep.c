void sleep(int t){
  int i;

  for(i=0;i<(t*100);i++){ // ~5ms delay 
    __asm__ ("pha ");
    __asm__ ("lda #$8c"); 
    __asm__ ("jsr $fca8");
    __asm__ ("pla ");
  }
}
