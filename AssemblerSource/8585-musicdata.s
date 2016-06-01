MUSICNOTEPTR	= ending
MUSICNOTEDUR	= ending+1
MUSICLO = 167
MUSICHI = 168

	.org 8583
	.segment "STARTUP"

	.word	MAIN
		
MAIN:

JUMPTABLES:

		jmp PLAYMUSIC           ; sys 8585      ; pass tune #
		jmp TURNONMUSIC         ; sys 8588
		jmp TURNOFFMUSIC        ; sys 8591


PLAYMUSIC:

		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx ending+2
        

		lda #15
		sta 36878
		sei
		lda #0
		sta MUSICNOTEPTR
		lda #1
		sta MUSICNOTEDUR

		LDX ending+2

		lda TUNELO,X
		sta MUSICLO
		lda TUNEHI,X
		sta MUSICHI

TURNONMUSIC:
		lda #<(PLAYMUSIC2)
		sta 788
		lda #>(PLAYMUSIC2)
		sta 789
		cli
		rts

TUNELO:
	.byte <(MUSIC_INT13)
    .byte <(REALMS1)
    .byte <(REALMS2)
    .byte <(BACHFUGUE)
	
TUNEHI:
	.byte >(MUSIC_INT13)
    .byte >(REALMS1)
    .byte >(REALMS2)
    .byte >(BACHFUGUE)
    
;---------------------------------------------------
	
TURNOFFMUSIC:
		lda #0
		sta 36876
		sta 36875
		sta 36874
		sei
		LDA #<(60095)
		STA 788
		LDA #>(60095)
		STA 789
		cli
		rts
;---------------------------------------------------

PLAYMUSIC2:
		php
		pha
		tya
		pha
		txa
		pha

		dec MUSICNOTEDUR
		LDA MUSICNOTEDUR
		CMP #1
		BEQ @CHANGENOTE
		CMP #0
		bne @PULLOUT

		ldy MUSICNOTEPTR
		lda (MUSICLO),y
		AND #224
		CLC
		ROR
		ROR
		ROR
		ROR
		ROR
		TAX
		LDA NOTEDURATION,X
		sta MUSICNOTEDUR
		LDA (MUSICLO),Y
		cmp #255
		beq @add897
		AND #31
		TAX
		LDA MUSICNOTES,X
		;sta 36874
		sta 36875
		sta 36876

@cont1:
		INY
@add888:
		sty MUSICNOTEPTR
@PULLOUT:
		PLA
		TAX
		pla
		tay
		pla
		plp
		jmp 60095
		
		
@add897:
		ldy #0
		JMP @add888
@CHANGENOTE:
		sta 36876
		STA 36875
		STA 36874
		JMP @PULLOUT
		
;----------------------------------------------------------------

MUSICNOTES:
	.byte 0			; rest			0
	.byte 135		; C				1
	.byte 143		; C# or Db		2
	.byte 147		; D				3
	.byte 151		; D# or Eb		4
	.byte 159		; E				5
	.byte 163		; F				6
	.byte 167		; F# 8or Gb		7
	.byte 175		; G				8
	.byte 179		; G# or Ab		9
	.byte 183		; A				10
	.byte 187		; A# or Bb		11
	.byte 191		; B				12
	.byte 195		; C				13
	.byte 199		; C# or Db		14
	.byte 201		; D				15
	.byte 203		; D# or Eb		16
	.byte 207		; E				17
	.byte 209		; F				18
	.byte 212		; F# or Gb		19
	.byte 215		; G				20
	.byte 217		; G# or Ab		21
	.byte 219		; A				22
	.byte 221		; A# or Bb		23
	.byte 223		; B				24
	.byte 225		; C				25
	.byte 227		; C# or Db		26
	.byte 228		; D				27
	.byte 229		; D# or Eb		28
	.byte 231		; E				29
	.byte 232		; F				30
	.byte 233		; F# or Gb		31
	.byte 235		; G				32
	.byte 236		; G# or Ab		33
	.byte 237		; A				34
	.byte 238		; A# or Bb		35
	.byte 239		; B				36
	.byte 240		; C				37
	.byte 241		; C# or Db		38

;--------------------------------------

NOTEDURATION:

	.byte 5			; 0	1/16 of a second
	.byte 10		; 1	1/8 of a second
	.byte 20		; 2	2/8 of a second
	.byte 30		; 3	3/8 of a second
	.byte 40		; 4	4/8 of a second
	.byte 60		; 5	6/8 of a second
	.byte 80		; 6	8/8 second
	.byte 120		; 7	12/8 seconds

;-------------------------------------------------------------------------

MUSIC_INT13:
	; pitch + duration *32
	; intervention 13 BACH

	.byte 0		+32*2
	.byte 17	+32*2
	.byte 22	+32*2
	.byte 25	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 27	+32*2
	.byte 25	+32*3
	.byte 29	+32*3
	.byte 21	+32*3
	.byte 29	+32*3

	.byte 22	+32*2
	.byte 17	+32*2
	.byte 22	+32*2
	.byte 25	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 29	+32*2
	.byte 25	+32*3
	.byte 22	+32*3
	.byte 0		+32*2

	.byte 29	+32*2
	.byte 25	+32*2
	.byte 29	+32*2
	.byte 22	+32*2
	.byte 25	+32*2
	.byte 17	+32*2
	.byte 20	+32*2
	.byte 18	+32*3
	.byte 22	+32*3
	.byte 27	+32*3
	.byte 30	+32*4

	.byte 27	+32*2
	.byte 24	+32*2
	.byte 27	+32*2
	.byte 20	+32*2
	.byte 24	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 25	+32*3
	.byte 29	+32*4

	.byte 25	+32*2
	.byte 22	+32*2
	.byte 25	+32*2
	.byte 18	+32*3
	.byte 27	+32*4
	.byte 24	+32*2
	.byte 20	+32*2
	.byte 24	+32*2
	.byte 17	+32*3
	.byte 25	+32*4

	.byte 22	+32*2
	.byte 18	+32*2
	.byte 22	+32*2
	.byte 15	+32*3
	.byte 24	+32*3
	.byte 25	+32*3
	.byte 0		+32*2

	.byte 8		+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 20	+32*3

	.byte 13	+32*2
	.byte 8 	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 17	+32*3
	.byte 13	+32*3
	.byte 20	+32*3
	.byte 17	+32*3

	.byte 25	+32*2
	.byte 22	+32*2
	.byte 17	+32*2
	.byte 22	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 10	+32*2
	.byte 13	+32*2
	.byte 15	+32*3
	.byte 19	+32*3
	.byte 22	+32*3
	.byte 25	+32*3

	.byte 24	+32*2
	.byte 20	+32*2
	.byte 15	+32*2
	.byte 20	+32*2
	.byte 12	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 12	+32*2
	.byte 13	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 24	+32*3

	.byte 22	+32*2
	.byte 19	+32*2
	.byte 16	+32*2
	.byte 19	+32*2
	.byte 12	+32*2
	.byte 16	+32*2
	.byte 7 	+32*2
	.byte 10	+32*2
	.byte 8 	+32*3
	.byte 20	+32*4
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 17	+32*2

	.byte 10	+32*3
	.byte 19	+32*4
	.byte 15	+32*2
	.byte 12	+32*2
	.byte 15	+32*2
	.byte 8 	+32*3
	.byte 17	+32*4
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 13	+32*2

	.byte 7 	+32*2
	.byte 20	+32*2
	.byte 19	+32*2
	.byte 17	+32*2
	.byte 16	+32*2
	.byte 19	+32*2
	.byte 12	+32*2
	.byte 16	+32*2
	.byte 17	+32*2
	.byte 0		+32*2

	.byte 20	+32*2
	.byte 23	+32*2
	.byte 20	+32*2
	.byte 17	+32*2
	.byte 20	+32*2
	.byte 14	+32*2
	.byte 17	+32*2
	.byte 20	+32*2
	.byte 17	+32*2
	.byte 14	+32*2
	.byte 17	+32*2
	.byte 10	+32*2
	.byte 0 	+32*1

	.byte 18	+32*2
	.byte 22	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 12	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 12	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 0		+32*1

	; skipping to last 3 1/2 bars

	.byte 5 	+32*2
	.byte 10	+32*2
	.byte 13	+32*2
	.byte 12	+32*2
	.byte 5 	+32*2
	.byte 10	+32*2
	.byte 15	+32*2

	.byte 13	+32*2
	.byte 10	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 15	+32*2
	.byte 12	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 20	+32*2
	.byte 18	+32*2
	.byte 17	+32*2
	.byte 15	+32*2
	.byte 13	+32*2

	.byte 12	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 17	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 21	+32*2
	.byte 15	+32*2
	.byte 24	+32*2
	.byte 15	+32*2
	.byte 13	+32*2
	.byte 22	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 12	+32*2
	.byte 15	+32*2

	.byte 21 	+32*2
	.byte 24	+32*2
	.byte 25	+32*2
	.byte 22	+32*2
	.byte 17 	+32*2
	.byte 22	+32*2
	.byte 24	+32*2
	.byte 21	+32*2
	.byte 22	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 10	+32*5
	.byte 255

;-------------------------------------------------------------------------

REALMS1:

	.byte 0		+32*2

.byte  7 + 5 *32
.byte  7 + 3 *32
.byte  3 + 3 *32
.byte  5 + 3 *32
.byte  5 + 3 *32
.byte  5 + 5 *32
.byte  0 + 5 *32
.byte  5 + 2 *32
.byte  8 + 3 *32
.byte  10 + 2 *32
.byte  0 + 2 *32
.byte  10 + 2 *32
.byte  11 + 2 *32
.byte  10 + 2 *32
.byte  8 + 2 *32
.byte  10 + 3 *32
.byte  8 + 3 *32
.byte  8 + 3 *32
.byte  5 + 3 *32
.byte  5 + 4 *32


.byte  5 + 2 *32
.byte  5 + 2 *32
.byte  8 + 2 *32
.byte  5 + 2 *32
.byte  3 + 2 *32
.byte  5 + 3 *32
.byte  5 + 3 *32
.byte  8 + 5 *32
.byte  5 + 2 *32
.byte  8 + 2 *32
.byte  10 + 3 *32
.byte  11 + 2 *32
.byte  12 + 2 *32
.byte  10 + 3 *32
.byte  12 + 2 *32
.byte  12 + 2 *32
.byte  10 + 2 *32
.byte  8 + 2 *32
.byte  10 + 3 *32
.byte  8 + 3 *32


.byte  8 + 3 *32
.byte  8 + 3 *32
.byte  8 + 3 *32
.byte  5 + 3 *32
.byte  5 + 3 *32
.byte  5 + 3 *32
.byte  5 + 5 *32
.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  19 + 2 *32
.byte  17 + 2 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  14 + 2 *32
.byte  12 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  19 + 2 *32
.byte  20 + 2 *32


.byte  22 + 2 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  20 + 2 *32
.byte  15 + 2 *32
.byte  14 + 2 *32
.byte  12 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  13 + 3 *32
.byte  12 + 2 *32
.byte  13 + 2 *32
.byte  0 + 2 *32
.byte  13 + 7 *32
.byte  5 + 2 *32
.byte  7 + 2 *32
.byte  9 + 2 *32
.byte  10 + 2 *32
.byte  12 + 2 *32
.byte  15 + 2 *32


.byte  12 + 3 *32
.byte  20 + 2 *32
.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  19 + 2 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  14 + 3 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  19 + 2 *32
.byte  22 + 2 *32
.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  19 + 2 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  14 + 2 *32
.byte  0 + 2 *32


.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  13 + 2 *32
.byte  12 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  13 + 2 *32
.byte  12 + 3 *32
.byte  13 + 3 *32
.byte  15 + 2 *32
.byte  13 + 2 *32
.byte  12 + 3 *32
.byte  0 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  19 + 2 *32
.byte  22 + 2 *32
.byte  19 + 3 *32
.byte  19 + 2 *32


.byte  20 + 2 *32
.byte  19 + 3 *32
.byte  15 + 2 *32
.byte  19 + 3 *32
.byte  15 + 4 *32
.byte  14 + 2 *32
.byte  13 + 2 *32
.byte  0 + 7 *32
.byte  5 + 2 *32
.byte  8 + 2 *32
.byte  10 + 2 *32
.byte  12 + 2 *32
.byte  14 + 2 *32
.byte  15 + 2 *32
.byte  16 + 2 *32
.byte  17 + 2 *32
.byte  20 + 2 *32
.byte  23 + 3 *32
.byte  22 + 4 *32
.byte  20 + 3 *32


.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  14 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  22 + 2 *32
.byte  19 + 3 *32
.byte  19 + 2 *32
.byte  15 + 2 *32
.byte  14 + 2 *32
.byte  12 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  13 + 2 *32
.byte  12 + 2 *32
.byte  13 + 2 *32


.byte  15 + 2 *32
.byte  13 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  19 + 3 *32
.byte  22 + 3 *32
.byte  24 + 3 *32
.byte  20 + 2 *32
.byte  22 + 2 *32
.byte  20 + 2 *32
.byte  19 + 3 *32
.byte  19 + 2 *32
.byte  20 + 2 *32
.byte  15 + 2 *32
.byte  17 + 3 *32
.byte  17 + 7 *32
.byte  0 + 3 *32
.byte  23 + 2 *32
.byte  0 + 2 *32
.byte  22 + 2 *32


.byte  20 + 2 *32
.byte  22 + 2 *32
.byte  20 + 3 *32
.byte  17 + 2 *32
.byte  15 + 2 *32
.byte  17 + 2 *32
.byte  20 + 2 *32
.byte  22 + 3 *32
.byte  31 + 2 *32
.byte  29 + 3 *32
.byte  31 + 2 *32
.byte  0 + 5 *32
.byte  27 + 2 *32
.byte  29 + 2 *32
.byte  31 + 2 *32
.byte  29 + 2 *32
.byte  27 + 2 *32
.byte  29 + 2 *32
.byte  29 + 2 *32
.byte  31 + 6 *32


    .byte 255

;------------------------------------------------------------------------------

REALMS2:


.byte  0 + 2 *32
.byte  15 + 1 *32
.byte  16 + 1 *32
.byte  8 + 2 *32
.byte  10 + 1 *32
.byte  11 + 1 *32
.byte  12 + 2 *32
.byte  12 + 1 *32
.byte  11 + 1 *32
.byte  10 + 2 *32
.byte  10 + 1 *32
.byte  10 + 1 *32
.byte  8 + 2 *32
.byte  8 + 1 *32
.byte  8 + 1 *32
.byte  5 + 4 *32
.byte  15 + 1 *32
.byte  16 + 1 *32
.byte  8 + 2 *32
.byte  10 + 1 *32

.byte  11 + 1 *32
.byte  12 + 2 *32
.byte  12 + 1 *32
.byte  11 + 1 *32
.byte  10 + 2 *32
.byte  10 + 1 *32
.byte  10 + 1 *32
.byte  13 + 2 *32
.byte  8 + 1 *32
.byte  8 + 1 *32
.byte  3 + 5 *32
.byte  15 + 1 *32
.byte  16 + 1 *32
.byte  17 + 2 *32
.byte  10 + 1 *32
.byte  11 + 1 *32
.byte  12 + 2 *32
.byte  12 + 1 *32
.byte  11 + 1 *32
.byte  10 + 2 *32

.byte  10 + 1 *32
.byte  10 + 1 *32
.byte  8 + 2 *32
.byte  17 + 1 *32
.byte  19 + 2 *32
.byte  13 + 1 *32
.byte  14 + 1 *32
.byte  15 + 2 *32
.byte  15 + 1 *32
.byte  14 + 1 *32
.byte  13 + 2 *32
.byte  13 + 1 *32
.byte  13 + 1 *32
.byte  12 + 2 *32
.byte  15 + 1 *32
.byte  16 + 1 *32
.byte  17 + 2 *32
.byte  10 + 1 *32
.byte  11 + 1 *32

.byte  12 + 2 *32
.byte  12 + 1 *32
.byte  11 + 1 *32
.byte  10 + 2 *32
.byte  10 + 1 *32
.byte  10 + 1 *32
.byte  8 + 2 *32
.byte  15 + 1 *32
.byte  16 + 1 *32
.byte  17 + 2 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32

.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  9 + 2 *32
.byte  12 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32

.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32

.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  18 + 2 *32
.byte  12 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  15 + 1 *32

.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  12 + 2 *32
.byte  8 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32

.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  12 + 1 *32
.byte  12 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  12 + 2 *32
.byte  12 + 2 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  10 + 2 *32
.byte  8 + 2 *32
.byte  12 + 4 *32
.byte  3 + 2 *32

.byte  12 + 2 *32
.byte  0 + 4 *32
.byte  12 + 3 *32
.byte  8 + 2 *32
.byte  6 + 2 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  12 + 3 *32

.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  10 + 2 *32
.byte  10 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  16 + 4 *32
.byte  1 + 1 *32

.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  15 + 3 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  14 + 2 *32
.byte  10 + 2 *32
.byte  15 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 2 *32
.byte  20 + 1 *32
.byte  17 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32

.byte  1 + 1 *32
.byte  24 + 2 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  1 + 1 *32
.byte  17 + 1 *32
.byte  23 + 4 *32
.byte  22 + 2 *32
.byte  18 + 2 *32
.byte  20 + 3 *32
.byte  27 + 3 *32
.byte  20 + 3 *32
.byte  17 + 3 *32
.byte  20 + 3 *32
.byte  27 + 3 *32
.byte  22 + 3 *32
.byte  29 + 3 *32
.byte  17 + 3 *32
.byte  16 + 3 *32


.byte  24 + 3 *32
.byte  17 + 7 *32

    .byte 255
    
;----------------------------------------------------------------------------------

BACHFUGUE:

MUSIC_FUGUE:

	; Bach Fugue 542

	.byte 0		+32*2
	.byte 10	+32*4
	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 3 	+32*3
	.byte 15	+32*3

	.byte 14	+32*2
	.byte 15	+32*2
	.byte 12	+32*2
	.byte 14	+32*2
	.byte 10	+32*2
	.byte 15	+32*2
	.byte 10	+32*2
	.byte 11	+32*3
	.byte 8 	+32*3
	.byte 1 	+32*3
	.byte 13	+32*3

	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*2
	.byte 10	+32*2
	.byte 6 	+32*3
	.byte 11	+32*2
	.byte 5 	+32*2
	.byte 8 	+32*3
	.byte 5 	+32*4
	.byte 10	+32*3

	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 3 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 10	+32*3
	.byte 12	+32*3
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 13	+32*2
	.byte 15	+32*2

	.byte 17	+32*3
	.byte 12	+32*3
	.byte 13	+32*5
	.byte 12	+32*4

	.byte 10	+32*5
	.byte 9 	+32*4

	.byte 10	+32*4
	.byte 0 	+32*1
	.byte 10	+32*3
	.byte 8 	+32*2
	.byte 10	+32*2
	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 10	+32*2

	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 5 	+32*2
	.byte 3 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 6 	+32*2
	.byte 3 	+32*2
	.byte 5 	+32*2
	.byte 2 	+32*2
	.byte 5 	+32*2
	.byte 3 	+32*2
	.byte 6 	+32*2

	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 6 	+32*2
	.byte 10	+32*2
	.byte 8 	+32*2
	.byte 11	+32*2
	.byte 10	+32*2
	.byte 13	+32*2
	.byte 12	+32*2
	.byte 14	+32*2
	.byte 15	+32*4
	.byte 15	+32*2
	.byte 14	+32*3

	.byte 15	+32*6
    
	.byte 255
    
;--------------------------------------------------------------------

ending:
    .byte 0,0,0,0