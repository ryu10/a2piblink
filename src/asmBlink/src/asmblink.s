; hello.s
;
.segment "CODE"
; Apple ROM Routines
HOME = $FC58
COUT = $FDED
PRBYTE = $FDDA
PRINTCR = $FD8E
WAIT = $fca8
VIA = $c400
PB = VIA
DDRB = VIA + 2
T1L = VIA + 4 ; timer
T1H = VIA + 5 ; timer
ACR = VIA + $0B ; timer ctr bits reg
IFR = VIA + $0D ; timer interrupt status reg
IER = VIA + $0E ; interrupt enable reg
;
ENTRY:  
        lda #$ff ; Init VIA
        sta DDRB ; PB output
        ; Init VIA Timer1
        lda #0
        sta ACR ; Timer 1: one-shot; ShiftReg: disabled; PB7: unchanged.
        lda #$7f
        sta IER ; Disable all IRQ triggers
        lda #16
        sta ITR ; Blink LED 16 times
@L1:
        lda #1
        sta PB ; led on
        lda #'*'+$80
        jsr COUT
        jsr WAIT1SEC
        lda #0
        sta PB ; led off
        lda #'-'+$80
        jsr COUT
        jsr WAIT1SEC
        dec ITR
        bne @L1
        rts
;
WAIT1SEC:
        lda #10
        sta W1ST
@L1:    lda #$ce
        sta T1L
        lda #$c7
        sta T1H ; set T1=0xc7ce (50ms) and start TIMER 1
@L2:    lda IFR
        and #$40 ; bit6=TIMER 1 timeout
        beq @L2 
        dec W1ST
        bne @L1 ; TM1 (50ms) * 20 = 1 sec
        rts
;
.segment "DATA"
ITR:    .byte 0
W1ST:    .byte 0
