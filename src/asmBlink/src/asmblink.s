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
;
ENTRY:  
        lda #$ff
        sta DDRB
        lda #0
        sta ITR
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
        inc ITR
        lda ITR
        cmp #16
        bne @L1
        rts
;
WAIT1SEC:
        lda #20
@L1:
        pha
        lda #$8c
        jsr WAIT
        pla
        clc
        sbc #1
        bne @L1
        rts
;
.segment "DATA"
ITR:    .byte 0
