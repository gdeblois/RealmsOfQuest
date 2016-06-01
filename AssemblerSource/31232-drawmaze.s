; maze graphics at memory location 31232

GETIN_K		= $FFE4
PRINTCHAR_K = $ffd2
PRINTSTRING_K = $CB1E


MUSICNOTEPTR	= 1021
MUSICNOTEDUR	= 1022
MUSICLO = $FB
MUSICHI = $FC

DT1L = 60           ; NEW
MBL  = 30
MBR  = 29
DT2L = 27           ; NEW
DB1L = 28           ; NEW
DB2L = 118
DT1R = 119          ; NEW
DT2R = 121          ; NEW
DB1R = 122          ; NEW
DB2R = 123
DA1  = 62           ; NEW
DA2  = 124          ; NEW
TB   = 108
BB   = 109
LB   = 112
RB   = 113
TLC  = 114
TRC  = 115
BLC  = 116
BRC  = 117
BS   = 110
FS   = 111
BSBL = 125          ; NEW
FSBL = 126          ; NEW
BSBR = 127          ; NEW
FSBR = 188          ; NEW

;-------------------------------------------------------

	.org 31230
	.segment "STARTUP"

	.word	MAIN
    
    
    MAIN:

;-------------------------------------------------------

JUMPTABLES:
	JMP drawmaze		;   -- 31232
    JMP mazedir         ;   -- 31235
	JMP pokegraphics	;   -- 31238		FNS(1)

;-------------------------------------------------------
    
drawmaze:

    lda #0
    jsr colormaze

	@checkdarkness:
		lda 1011
		cmp #8
		bne @wizardseye
		lda 4259
		cmp #32
		bne @wizardseye
		lda 4271
		cmp #32
		bne @wizardseye
		LDA #<(@dark)
		LDY #>(@dark)
		JMP PRINTSTRING_K
	
			@dark:
				.byte 19,17,17,17,"  DARK",0
	
	@wizardseye:				; detect secret doors
		lda 4271
		cmp #32
		bne @wiz2 
		lda 4265
		cmp #32
		beq @detectmagic
	@wiz2:
		ldx #0
	@wiz3:
		lda FLW2,x
		cmp #3
		bne @wiz4
		lda #2
		sta FLW2,x
	@wiz4:
		inx
		cpx #14
		bne @wiz3
		
	@detectmagic:				; find teleporters and turntables
		lda 4271
		cmp #32
		bne @det2
		lda 4261
		cmp #32
		bne @det2
		jmp @findtraps
	@det2:
		lda 1012
		and #12
		cmp #4
		bne @det3
		ldx #5*22+3
		lda #31
		ldy #159
		jsr @pokeitem
	@det3:
		lda 1011
		and #12
		cmp #4
		bne @findtraps
		ldx #7*22+3
		lda #157
		ldy #158
		jsr @pokeitem
	
	@findtraps:
		lda 4271
		cmp #32
		bne @trap2
		lda 4267
		cmp #32
		bne @trap2
		jmp @stairs
	@trap2:
		lda 1012
		cmp #3
		bne @trap3
		ldx #5*22+3
		lda #164
		ldy #165
		jsr @pokeitem
	@trap3:
		lda 1011
		cmp #3
		bne @stairs
		ldx #7*22+3
		lda #155
		ldy #156
		jsr @pokeitem
		
	@stairs:
		;lda 1016
		;cmp #1
		;bne @stairs4
        
		lda 1012
		cmp #1
		bne @stairs2
		ldx #2*22+3
		jmp @stairs3
	@stairs2:
		cmp #2
		bne @stairs4
		ldx #5*22+3
	@stairs3:
		lda #0
		ldy #128
		jsr @pokeitem
	@stairs4:
		lda 1011
		cmp #1
		bne @stairs5
		ldx #3
		jmp @stairs6
	@stairs5:
		cmp #2
		bne @continue
		ldx #7*22+3
	@stairs6:
		lda #36
		ldy #37
		jsr @pokeitem
		
	@continue:

    
            ldx #0
        @l1:
            stx 251             ; x = 251
            ldy #0
        @l2:
            sty 252             ; y = 252
            ldx 251
                                    
            lda @pointer,x

            clc
            adc 252
            tay

            lda @position,y
            cmp #255
            beq @l9
            sta 253             ; position = 253

            ldx 251
            lda FLW2,x
            cmp #1
            beq @l10            ; hall
            cmp #2
            beq @l3             ; door
            
            ldx 251
            lda @pointer,x
            clc
            adc 252
            tay
            lda @wall,y
            ldx 253
            sta 4096,x
            jmp @l4
            
        @l3:
            ldx 251
            lda @pointer,x
            clc
            adc 252
            tay
            lda @door,y
            ldx 253
            sta 4096,x

        @l4:
    
        @l9:
            ldy 252
            iny
            cpy #10
            bne @l2
        @l10:
            ldx 251
            inx
            cpx #14
            bne @l1
            
            ; draw aw1
            
            lda AW1
            cmp #1
            beq @l20        ; hall
            cmp #2
            beq @l15        ; door
            
            ldx #0
        @l11:
            lda @aw1wall,x
            sta 4096+23,x
            lda @aw1wall+6,x
            sta 4096+45,x
            sta 4096+67,x
            sta 4096+89,x
            sta 4096+111,x
            lda @aw1wall+12,x
            sta 4096+133,x
            inx
            cpx #6
            bne @l11
            jmp @l20
                  
        @l15:
            ldx #0
        @l16:
            lda @aw1door,x
            sta 4096+23,x
            lda @aw1door+6,x
            sta 4096+45,x
            lda @aw1door+12,x
            sta 4096+67,x
            sta 4096+89,x
            sta 4096+111,x
            lda @aw1door+18,x
            sta 4096+133,x
            inx
            cpx #6
            bne @l16
            
            
        @l20:
            lda #1
            jsr colormaze
    
        rts

    @aw1wall:
        .byte TLC,TB,TB,TB,TB,TRC
        .byte LB,32,32,32,32,RB             ; *4
        .byte BLC,BB,BB,BB,BB,BRC
        
    @aw1door:
        .byte TLC,TB,TB,TB,TB,TRC
        .byte LB,TLC,TB,TB,TRC,RB
        .byte LB,LB,32,32,RB,RB             ; *3
        .byte BLC,BLC,BB,BB,BRC,BRC
        
    @pointer:
        .byte 0
        .byte 10
        .byte 20
        .byte 30
        .byte 40
        .byte 50
        .byte 60
        .byte 70
        .byte 80
        .byte 90
        .byte 100
        .byte 110
        .byte 120
        .byte 130


    @position:
   .byte 255,66,255,88,255,255,255,255,255,255      ; FLW2
   .byte 67,68,89,90,255,255,255,255,255,255      ; LW2
   .byte 69,70,91,92,255,255,255,255,255,255      ; AW2
   .byte 71,72,93,94,255,255,255,255,255,255      ; RW2
   .byte 73,255,95,255,255,255,255,255,255,255      ; FRW2
   .byte 44,66,88,110,255,255,255,255,255,255      ; FL1
   .byte 23,45,67,89,111,133,46,68,90,112      ; L1
   .byte 49,71,93,115,28,50,72,94,116,138      ; R1
   .byte 51,73,95,117,255,255,255,255,255,255      ; FR1
   .byte 22,44,66,88,110,132,255,255,255,255      ; LW1
   .byte 255,255,255,255,255,255,255,255,255,255      ; AW1
   .byte 29,51,73,95,117,139,255,255,255,255      ; RW1
   .byte 0,22,44,66,88,110,132,154,255,255      ; L0
   .byte 7,29,51,73,95,117,139,161,255,255      ; R0


   
    @wall:
        
   .byte TLC,TRC,BLC,BRC,0,0,0,0,0,0      ; FLW2
   .byte TLC,TRC,BLC,BRC,0,0,0,0,0,0      ; LW2
   .byte TLC,TRC,BLC,BRC,0,0,0,0,0,0      ; AW2
   .byte TLC,TRC,BLC,BRC,0,0,0,0,0,0      ; RW2
   .byte TLC,TRC,BLC,BRC,0,0,0,0,0,0      ; FRW2
   .byte BS,RB,RB,FS,0,0,0,0,0,0      ; FL1
   .byte BSBL,LB,LB,LB,LB,FSBL,BS,RB,RB,FS      ; L1
   .byte FS,LB,LB,BS,FSBR,RB,RB,RB,RB,BSBR      ; R1
   .byte FS,LB,LB,BS,0,0,0,0,0,0      ; FR1
   .byte TRC,RB,RB,RB,RB,BRC,0,0,0,0      ; LW1
   .byte 0,0,0,0,0,0,0,0,0,0      ; AW1
   .byte TLC,LB,LB,LB,LB,BLC,0,0,0,0      ; RW1
   .byte BS,RB,RB,RB,RB,RB,RB,FS,0,0      ; L0
   .byte FS,LB,LB,LB,LB,LB,LB,BS,0,0      ; R0


        
    @door:
        
   .byte TLC,TRC,DA1,DA2,0,0,0,0,0,0      ; FLW2
   .byte TLC,TRC,DA1,DA2,0,0,0,0,0,0      ; LW2
   .byte TLC,TRC,DA1,DA2,0,0,0,0,0,0      ; AW2
   .byte TLC,TRC,DA1,DA2,0,0,0,0,0,0      ; RW2
   .byte TLC,TRC,DA1,DA2,0,0,0,0,0,0      ; FRW2
   .byte BS,DT2L,MBR,DB2L,0,0,0,0,0,0      ; FL1
   .byte BSBL,DT1L,MBL,MBL,MBL,DB1L,BS,DT2L,MBR,DB2L      ; L1
   .byte FS,DT2R,MBL,DB2R,FSBR,DT1R,MBR,MBR,MBR,DB1R      ; R1
   .byte FS,DT2R,MBL,DB2R,0,0,0,0,0,0      ; FR1
   .byte TRC,RB,RB,RB,RB,BRC,0,0,0,0      ; LW1
   .byte 0,0,0,0,0,0,0,0,0,0      ; AW1
   .byte TLC,LB,LB,LB,LB,BLC,0,0,0,0      ; RW1
   .byte BS,DT2L,MBR,MBR,MBR,MBR,MBR,DB2L,0,0      ; L0
   .byte FS,DT2R,MBL,MBL,MBL,MBL,MBL,DB2R,0,0      ; R0



   	@pokeitem:
		sta 4096,x
		tya
		inx
		sta 4096,x
		rts

;--------------------------------------------------------

colormaze:

        ; pass color
        
        ldx #0
    @l1:
        sta 37888+22*0,x
        sta 37888+22*1,x
        sta 37888+22*2,x
        sta 37888+22*3,x
        sta 37888+22*4,x
        sta 37888+22*5,x
        sta 37888+22*6,x
        sta 37888+22*7,x
        
        inx
        cpx #8
        bne @l1
        
        rts
;--------------------------------------------------------

mazedir:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx 253

		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx 254
		
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx 252
		
		ldy #23
		jsr @and240
		sta 1011			; h
		
		ldx 252
		cpx #0
		beq @southjump
		cpx #1
		beq @westjump
		cpx #2
		beq @north
		jmp @east

	@westjump:
		jmp @west
	@southjump:
		jmp @south
		
; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@        

@east:
        ldx #0
    @e1:
        lda @east_pos,x
        tay
        lda @east_and,x

        jsr @bigloop
        
        inx
        cpx #20
        bne @e1
        jmp @mazedirexit
        
; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@bigloop:

        cmp #3
        bne @e2
        jsr @and3
        jmp @e9
    @e2:
        cmp #12
        bne @e3
        jsr @and12
        jmp @e9
    @e3:
        jsr @and240
    @e9:
        sta FLW2,x
        rts

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
@north:
        ldx #0
    @n1:
        lda @north_pos,x
        tay
        lda @north_and,x

        jsr @bigloop

        inx
        cpx #20
        bne @n1
        jmp @mazedirexit

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@west:
        ldx #0
    @w1:
        lda @west_pos,x
        tay
        lda @east_and,x

        jsr @bigloop

        inx
        cpx #20
        bne @w1
        jmp @mazedirexit
        
; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
@south:
        ldx #0
    @s1:
        lda @south_pos,x
        tay
        lda @north_and,x

        jsr @bigloop

        inx
        cpx #20
        bne @s1
        jmp @mazedirexit

; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	
	@and3:
		lda (253),y
		and #3
		rts
	@and12:
		lda (253),y
		clc
		and #12
		ror
		ror
		rts
	@and240:
		lda (253),y
		clc
		and #240
		ror
		ror
		ror
		ror
		rts
        
@north_pos:
        .byte 0     ;FLW2
        .byte 1     ;LW2
        .byte 2     ;AW2
        .byte 3     ;RW2
        .byte 4     ;FRW2
        .byte 22    ;FL1
        .byte 23    ;L1
        .byte 24    ;R1
        .byte 25    ;FR1
        .byte 23    ;LW1
        .byte 24    ;AW1
        .byte 25    ;RW1
        .byte 45    ;L0
        .byte 46    ;R0
        .byte 46    ;I0
        .byte 22    ;I1
        .byte 23    ;I2
        .byte 24    ;I3
        .byte 25    ;I4
        .byte 26    ;I5
@north_and:
        .byte 12    ;FLW2
        .byte 12    ;LW2
        .byte 12    ;AW2
        .byte 12    ;RW2
        .byte 12    ;FRW2
        .byte 3     ;FL1
        .byte 3     ;L1
        .byte 3     ;R1
        .byte 3     ;FR1
        .byte 12    ;LW1
        .byte 12    ;AW1
        .byte 12    ;RW1
        .byte 3     ;L0
        .byte 3     ;R0
        .byte 240   ;I0
        .byte 240   ;I1
        .byte 240   ;I2
        .byte 240   ;I3
        .byte 240   ;I4
        .byte 240   ;I5

@south_pos:
        .byte 70    ;FLW2
        .byte 69    ;LW2
        .byte 68    ;AW2
        .byte 67    ;RW2
        .byte 70    ;FRW2
        .byte 69    ;FL1
        .byte 68    ;L1
        .byte 67    ;R1
        .byte 66    ;FR1
        .byte 47    ;LW1
        .byte 46    ;AW1
        .byte 45    ;RW1
        .byte 46    ;L0
        .byte 45    ;R0
        .byte 46    ;I0
        .byte 70    ;I1
        .byte 69    ;I2
        .byte 68    ;I3
        .byte 67    ;I4
        .byte 66    ;I5


@east_pos:
        .byte 3     ;FLW2
        .byte 25    ;LW2
        .byte 47    ;AW2
        .byte 69    ;RW2
        .byte 91    ;FRW2
        .byte 3     ;FL1
        .byte 25    ;L1
        .byte 47    ;R1
        .byte 69    ;FR1
        .byte 24    ;LW1
        .byte 46    ;AW1
        .byte 68    ;RW1
        .byte 24    ;L0
        .byte 46    ;R0
        .byte 46    ;I0
        .byte 3     ;I1
        .byte 25    ;I2
        .byte 47    ;I3
        .byte 69    ;I4
        .byte 91    ;I5
@east_and:
        .byte 3     ;FLW2
        .byte 3     ;LW2
        .byte 3     ;AW2
        .byte 3     ;RW2
        .byte 3     ;FRW2
        .byte 12    ;FL1
        .byte 12    ;L1
        .byte 12    ;R1
        .byte 12    ;FR1
        .byte 3     ;LW1
        .byte 3     ;AW1
        .byte 3     ;RW1
        .byte 12    ;L0
        .byte 12    ;R0
        .byte 240   ;I0
        .byte 240   ;I1
        .byte 240   ;I2
        .byte 240   ;I3
        .byte 240   ;I4
        .byte 240   ;I5

@west_pos:
        .byte 88    ;FLW2
        .byte 66    ;LW2
        .byte 44    ;AW2
        .byte 22    ;RW2
        .byte 0     ;FRW2
        .byte 67    ;FL1
        .byte 45    ;L1
        .byte 23    ;R1
        .byte 1     ;FR1
        .byte 67    ;LW1
        .byte 45    ;AW1
        .byte 23    ;RW1
        .byte 46    ;L0
        .byte 24    ;R0
        .byte 46    ;I0
        .byte 89    ;I1
        .byte 67    ;I2
        .byte 45    ;I3
        .byte 23    ;I4
        .byte 1     ;I5

@mazedirexit:
        lda AW1
        sta 1016
        
        lda I3
        sta 1012
        
        lda I0
        sta 1011
        
        rts

  
;        .byte 0     ;FLW2
;        .byte 0     ;LW2
;        .byte 0     ;AW2
;        .byte 0     ;RW2
;        .byte 0     ;FRW2
;        .byte 0     ;FL1
;        .byte 0     ;L1
;        .byte 0     ;R1
;        .byte 0     ;FR1
;        .byte 0     ;LW1
;        .byte 0     ;AW1
;        .byte 0     ;RW1
;        .byte 0     ;L0
;        .byte 0     ;R0
;        .byte 0     ;I0
;        .byte 0     ;I1
;        .byte 0     ;I2
;        .byte 0     ;I3
;        .byte 0     ;I4
;        .byte 0     ;I5
        
        
  ;-----------------------------------------------------

        
pokegraphics:
        ldx #0
    @l1:
        lda DT1L_,x
        sta DT1L*8+6144,x
        lda DT2L_,x
        sta DT2L*8+6144,x
        lda DB1L_,x
        sta DB1L*8+6144,x
        lda DT1R_,x
        sta DT1R*8+6144,x
        lda DT2R_,x
        sta DT2R*8+6144,x
        lda DB1R_,x
        sta DB1R*8+6144,x
        lda DA1_,x
        sta DA1*8+6144,x
        lda DA2_,x
        sta DA2*8+6144,x
        
        lda BSBL_,x
        sta BSBL*8+6144,x
        lda FSBL_,x
        sta FSBL*8+6144,x
        lda BSBR_,x
        sta BSBR*8+6144,x
        lda FSBR_,x
        sta FSBR*8+6144,x
        
        lda smladderleft,x
        sta 0*8+6144,x
        lda smladderright,x
        sta 128*8+6144,x
        
        lda bigladderleft,x
        sta 36*8+6144,x
        lda bigladderright,x
        sta 37*8+6144,x
        
        inx
        cpx #8
        bne @l1
        rts
        
DT1L_:
    .byte %10000000
    .byte %10000000
    .byte %10000000
    .byte %10000000
    .byte %10001000
    .byte %10001100
    .byte %10001010
    .byte %10001001

DT2L_:
    .byte %10000001
    .byte %01000001
    .byte %00100001
    .byte %00010001
    .byte %00010001
    .byte %00010001
    .byte %00010001
    .byte %00010001

DB1L_:
    .byte %10001001
    .byte %10001010
    .byte %10001100
    .byte %10001000
    .byte %10010000
    .byte %10100000
    .byte %11000000
    .byte %10000000

DT1R_:
    .byte %00000001
    .byte %00000001
    .byte %00000001
    .byte %00000001
    .byte %00010001
    .byte %00110001
    .byte %01010001
    .byte %10010001

DT2R_:
    .byte %10000001
    .byte %10000010
    .byte %10000100
    .byte %10001000
    .byte %10001000
    .byte %10001000
    .byte %10001000
    .byte %10001000

DB1R_:
    .byte %10010001
    .byte %01010001
    .byte %00110001
    .byte %00010001
    .byte %00001001
    .byte %00000101
    .byte %00000011
    .byte %00000001

DA1_:
    .byte %10011111
    .byte %10010000
    .byte %10010000
    .byte %10010000
    .byte %10010000
    .byte %10010000
    .byte %10010000
    .byte %11111111

DA2_:
    .byte %11111001
    .byte %00001001
    .byte %00001001
    .byte %00001001
    .byte %00001001
    .byte %00001001
    .byte %00001001
    .byte %11111111

BSBL_:
    .byte %10000000
    .byte %11000000
    .byte %10100000
    .byte %10010000
    .byte %10001000
    .byte %10000100
    .byte %10000010
    .byte %10000001

FSBL_:
    .byte %10000001
    .byte %10000010
    .byte %10000100
    .byte %10001000
    .byte %10010000
    .byte %10100000
    .byte %11000000
    .byte %10000000

BSBR_:
    .byte %10000001
    .byte %01000001
    .byte %00100001
    .byte %00010001
    .byte %00001001
    .byte %00000101
    .byte %00000011
    .byte %00000001

FSBR_:
    .byte %00000001
    .byte %00000011
    .byte %00000101
    .byte %00001001
    .byte %00010001
    .byte %00100001
    .byte %01000001
    .byte %10000001

smladderleft:
    .byte %00000000
    .byte %00010000
    .byte %00011111
    .byte %00010000
    .byte %00010000
    .byte %00011111
    .byte %00010000
    .byte %00000000

smladderright:
    .byte %00000000
    .byte %00001000
    .byte %11111000
    .byte %00001000
    .byte %00001000
    .byte %11111000
    .byte %00001000
    .byte %00000000

bigladderleft:
    .byte %00000000
    .byte %11111111
    .byte %10000000
    .byte %11111111
    .byte %10000000
    .byte %11111111
    .byte %10000000
    .byte %00000000

bigladderright:
    .byte %00000000
    .byte %11111111
    .byte %00000001
    .byte %11111111
    .byte %00000001
    .byte %11111111
    .byte %00000001
    .byte %00000000
    
sample:
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000
;    .byte %00000000

FLW2:   .BYTE 0
LW2:    .BYTE 0
AW2:    .BYTE 0
RW2:    .BYTE 0
FRW2:   .BYTE 0
FL1:    .BYTE 0
L1:     .BYTE 0
R1:     .BYTE 0
FR1:    .BYTE 0
LW1:    .BYTE 0
AW1:    .BYTE 0
RW1:    .BYTE 0
L0:     .BYTE 0
R0:     .BYTE 0
I0:     .BYTE 0
I1:     .BYTE 0
I2:     .BYTE 0
I3:     .BYTE 0
I4:     .BYTE 0
I5:     .BYTE 0