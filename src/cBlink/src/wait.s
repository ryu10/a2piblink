VIA = $c400
T1L = VIA + 4 ; timer
T1H = VIA + 5 ; timer
ACR = VIA + $0B ; timer ctr bits reg
IFR = VIA + $0D ; timer interrupt status reg
IER = VIA + $0E ; interrupt enable reg
;
_wait:
.export _wait
        lda #10
        sta w1ctr
@L1:    lda #$ce
        sta T1L
        lda #$c7
        sta T1H ; set T1=0xc7ce (50ms) and start TIMER 1
@L2:    lda IFR
        and #$40 ; bit6=TIMER 1 timeout
        beq @L2 
        dec w1ctr
        bne @L1 ; TM1 (50ms) * 20 = 1 sec
        rts
;
w1ctr:    .byte 0
