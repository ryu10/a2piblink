; lant.s
;
.segment "CODE"
; Apple ROM Routines
HGR = $F3E2
HCOLOR = $F6F0
HPLOT = $F457
HLINE = $F53A
COUT = $FDED
PRBYTE = $FDDA
PRINTCR = $FD8E
WAIT = $fca8
; constants
BITMAP_SIZE = $1b00
MAX_ANTS = 3
;
; zpg locs
; BC = $1D ; zpg loc $1D, $1E
BC = $EC ; zpg loc $EC, $ED
DE = $CE ; zpg loc $CE, $CF
FG = $EE ; zpg loc $EE, $EF
;
; structs
.struct Ant              ; 8 bytes
        ax .word
        ay .byte
        aori .byte
        updcolor .byte
        fill .byte 3
.endstruct
; offsets
ax_off = 0
ay_off = 2
aori_off = 3
updcol_off = 4
;
; program start
ENTRY:  
;       org $6000
        jsr HGR
        ldx #3    ; color = white
        jsr HCOLOR
; init
        ; ant0 at (100, 50), ori=2 (dn)
        lda #100 
        sta ANTS +ax_off
        lda #0
        sta ANTS +ax_off+1
        lda #50
        sta ANTS +ay_off
        lda #2
        sta ANTS +aori_off
        lda #3 ; white
        sta ANTS + updcol_off
        ; ant1 at (50, 100), ori=1 (right)
        lda #50   
        sta ANTS+.sizeof(Ant) +ax_off
        lda #0
        sta ANTS+.sizeof(Ant) +ax_off+1
        lda #100
        sta ANTS+.sizeof(Ant) +ay_off
        lda #1
        sta ANTS+.sizeof(Ant) +aori_off
        lda #3 ; white
        sta ANTS+.sizeof(Ant) +updcol_off
        ; ant2 at (150, 100), ori=3 (left)
        lda #150   
        sta ANTS+.sizeof(Ant)*2 +ax_off
        lda #0
        sta ANTS+.sizeof(Ant)*2 +ax_off+1
        lda #100
        sta ANTS+.sizeof(Ant)*2 +ay_off
        lda #3
        sta ANTS+.sizeof(Ant)*2 +aori_off
        lda #3 ; white
        sta ANTS+.sizeof(Ant)*2 +updcol_off
; test  plot
TESTMAIN:
        lda #MAX_ANTS
        sta CNTR
        lda #<ANTS
        sta FG    ; zpg FG = ANT Base address
        lda #>ANTS
        sta FG+1
MAIN0:  ldy #updcol_off ; load col -> COLOR
        lda (FG),y
        sta COLOR
        ldy #ax_off    ; load <ax -> x
        lda (FG),y
        tax
        iny            ; load >ax -> BWORK
        lda (FG),y
        sta BWORK
        ldy #ay_off    ; load ay -> a
        lda (FG),y
        ldy BWORK      ; >ax -> y
        jsr PLOTMAP
        clc
        lda FG
        adc #.sizeof(Ant)
        sta FG
        lda FG+1
        adc #0
        sta FG+1
        dec CNTR
        bne MAIN0
        rts
; plot at (yx, acc) in BITMAP and hgr vram
PLOTMAP:
        stx DE      ; save x, y, a
        sty DE+1
        pha
        ; plot in bitmap  
        jsr COOR2OFF
        ; get current byte in BITMAP
        tax
        lda BC
        clc
        adc #<BITMAP
        sta BC
        lda BC+1
        adc #>BITMAP
        sta BC+1
        ldy #0
        lda (BC),y
        sta BWORK
        clc
        lda #$01 ; mask init
@L0:    cpx #0
        beq @L1
        asl
        dex
        jmp @L0
@L1:    ldx COLOR
        bne @L2 
        eor #$FF ; bit black, invert mask
        and BWORK
        jmp @L3
@L2:    ora BWORK ; bit white
@L3:    sta (BC), y ; store result
        ; HPLOT
        lda COLOR
        jsr HCOLOR
        pla
        ldx DE
        ldy DE+1
        jsr HPLOT
        rts
; ([y, x] , a) -> offset, 
; offset >>3 -> BC, offset & 0x03 -> Acc
COOR2OFF:
        pha     ; set a->BC
        lda #0
        sta BC+1
        pla
        sta BC
        ; A * 280 -> BC
        ; 280 = $0118 = 0000 0001 0001 1000
        clc
        jsr ROLBC
        jsr ROLBC
        jsr ROLBC
        jsr ROLBC
        jsr ADDABC
        jsr ROLBC
        jsr ADDABC
        jsr ROLBC
        jsr ROLBC
        jsr ROLBC
        ; BC + [y, x] -> BC
        clc
        txa
        adc BC
        sta BC
        tya
        adc BC+1
        sta BC+1
        lda BC
        and #$07
        jsr LSRBC
        jsr LSRBC
        jsr LSRBC
        rts
ROLBC:  ; shift left [BC+1, BC]
        rol BC
        rol BC+1
        rts
LSRBC:
        lsr BC+1
        ror BC
        rts
ADDABC:  ; [BC+1, BC] + Ac -> [BC+1, BC] 
        pha
        clc
        adc BC
        sta BC
        lda #0
        adc BC+1
        sta BC+1
        pla
        rts
;
.segment "DATA"
BITMAP: 
        .res BITMAP_SIZE, 0
;
COLOR:
        .res 1
BWORK:
        .res 1
CNTR:
        .res 1
ANTS:
        .tag Ant  ; ant #0
        .tag Ant  ; ant #1
        .tag Ant  ; ant #2
        .tag Ant  ; ant #3
