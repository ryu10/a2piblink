; hello.s
;
.segment "CODE"
; Apple ROM Routines
HOME = $FC58
COUT = $FDED
PRBYTE = $FDDA
PRINTCR = $FD8E
;
ENTRY:  
;        jsr HOME
        lda #0
        sta ITR
@L1:
        jsr PRHELLO
        lda ITR
        jsr PRBYTE
        jsr PRINTCR
        inc ITR
        lda ITR
        cmp #8
        bne @L1
        rts
;
PRHELLO:
        ldx #0
@L1:    lda HELLO,X
        ora #$80
        jsr COUT
        inx
        cpx #12
        bne @L1
        rts
;
.segment "DATA"
HELLO:  .asciiz "HELLO WORLD "
ITR:    .byte 0
