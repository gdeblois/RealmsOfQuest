GETIN_K		= $FFE4
PRINTCHAR_K = $ffd2
PRINTSTRING_K = $CB1E


MUSICNOTEPTR	= 1021
MUSICNOTEDUR	= 1022
MUSICLO = $FB
MUSICHI = $FC




	.org 8190
	.segment "STARTUP"

	.word	MAIN
		
	; display and music routines
MAIN:

JUMPTABLES:
	JMP HIDESCREEN		;   -- mdc8192		FNS(0)
	JMP SHOWSCREEN		;   -- mdc8195		FNS(1)
	jmp drawscreen		;   -- mdc8198		FNS(2)
	JMP PLAYMUSIC		;   -- mdc8201		FNS(3)
	jmp TURNONMUSIC		;   -- mdc8204		FNS(4)
	JMP TURNOFFMUSIC	;   -- mdc8207		FNS(5)
	jmp erasecharline	;   -- mdc8210		FNS(6) (pass value with SYS call from basic)
	jmp reverseline		;   -- mdc8213		FNS(7) pass x,y,length from basic
	jmp drawmaze		;   -- mdc8216		FNS(8) draw maze. pass a,b,c,d,e,f,g
	jmp cleartext		;   -- mdc8219		FNS(9)
	jmp movecursor		;   -- mdc8222		FNS(10) (pass value with SYS call from basic X,Y)
	jmp showpic			;   -- mdc8225		FNS(11) (pass 1,2,3 from basic)
	jmp selectmenu		;   -- mdc8228		FNS(12) (pass 0-11 from basic)
	jmp revtopbottom	; 	-- mdc8231		FNS(13) reverse top bottom rows
	jmp displayspell	; 	-- mdc8234		FNS(14) pass 0-59 from basic
	jmp displayitem		; 	-- mdc8237		FNS(15) pass 0-137 from basic
	jmp itemdata		;	-- mdc8240		FNS(16) don't call this.  this is just a pointer
	jmp erasemaze		;	-- mdc8243		FNS(17) erase maze area
	jmp mazedir			;	-- mdc8246		FNS(18) pass 4630+lo-rm(-23), 4630+hi-rm(-23), di
	jmp mazetext		;	-- mdc8249		FNS(19) pass 0-6
	jmp printrace		;	-- mdc8252		FNS(20) pass 0-9 race, 10-11 sex
	jmp printclass		;	-- mdc8255		FNS(21) pass 0-11 class
	jmp loadpic			;	-- mdc8258		FNS(22) pass lev#(0-9),monster#(0-9)
	jmp printmonster	;	-- mdc8261		FNS(23) pass monster#
	jmp travelbuffs		;	-- mdc8264		FNS(24) display travel buffs
	jmp selectchar		;	-- mdc8267		FNS(25) pass 0-7, 8 or greater will select nothing
	jmp loadfile		;	-- mdc8270		FNS(26) pass ASCII char of file name
	jmp pause			;	-- mdc8273		FNS(27) pass # of 1/2seconds
	
HIDESCREEN:
	lda #255
	sta 36865
	rts
	
SHOWSCREEN:
	lda 1023
	sta 36865
	rts

movecursor:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx $fb
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		tay
		ldx $fb
	
movecursor2:
		;routine to physically move the cursor to X,Y location on the screen
		;guess which parameters should be passed????? ;)

		LDA #19
		JSR PRINTCHAR_K
@L1:
		STX 211
@L2:
		DEY
		BMI @L3
		LDA #17
		JSR PRINTCHAR_K
		BPL @L2
@L3:
		RTS
	
drawscreen:
		lda #147
		jsr $ffd2
		ldx #0
		ldy #0
	@l1:
		lda #160
		sta 4096+8*22,x
		sta 4096+8*22+9,x
		sta 4096+8*22+13,x
		sta 4096+8,y
		sta 4096+6*22+9,x
		sta 4096+6*22+13,x
		lda #2
		sta 37888+8*22,x
		sta 37888+8*22+9,x
		sta 37888+8*22+13,x
		sta 37888+6*22+9,x
		sta 37888+6*22+13,x
		sta 37888+8,y		
		
		tya
		clc
		adc #22
		tay
		inx
		cpx #9
		bne @l1
		
		LDX #0
		LDY #14
		JSR movecursor2
		LDA #<(@TEXTPARTY)
		LDY #>(@TEXTPARTY)
		JMP PRINTSTRING_K
		
		
	@TEXTPARTY: 
.byte 28,18,"# CHARACTER  HIT PTS S",5,146,0
	
;---------------------------------------------------

PLAYMUSIC:
		jmp 7680

TURNONMUSIC:
		jmp 7683
;---------------------------------------------------
	
TURNOFFMUSIC:
		jmp 7686
;---------------------------------------------------

SCREENPOS:
  .byte <4096
  .byte <4118
  .byte <4140
  .byte <4162
  .byte <4184
  .byte <4206
  .byte <4228
  .byte <4250
  .byte <4272
  .byte <4294
  .byte <4316
  .byte <4338
  .byte <4360
  .byte <4382
  .byte <4404
  .byte <4426
  .byte <4448
  .byte <4470
  .byte <4492
  .byte <4514
  .byte <4536
  .byte <4558
  .byte <4580

SCREENPOS2:
  .byte >4096
  .byte >4118
  .byte >4140
  .byte >4162
  .byte >4184
  .byte >4206
  .byte >4228
  .byte >4250
  .byte >4272
  .byte >4294
  .byte >4316
  .byte >4338
  .byte >4360
  .byte >4382
  .byte >4404
  .byte >4426
  .byte >4448
  .byte >4470
  .byte >4492
  .byte >4514
  .byte >4536
  .byte >4558
  .byte >4580


	
SCREENPOS3:
	.byte 74,96,118,140,162,184,206,228
;-------------------------------------------------------------

erasecharline:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		pha
		clc
		adc #15
		tay
		ldx #0
		
		lda #>4352
		sta $fc
		pla
		tax
		lda SCREENPOS3,x
		sta $fb
		ldy #1
		lda #32
	@l1:
		sta ($fb),y
		iny
		cpy #22
		bne @l1
		rts
;-------------------------------------------------------------

reverseline:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx $fd

		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		lda SCREENPOS,x
		sta $fb
		lda SCREENPOS2,x
		sta $fc

		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx $fe

		lda $fd
		clc
		adc $fb
		sta $fb
		lda #0
		adc $fc
		sta $fc

reverseline2:
		ldy #0
	@l1:
		lda ($fb),y
		clc
		adc #128
		sta ($fb),y
		iny
		cpy $fe
		bne @l1
		rts
;-------------------------------------------------------------


		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1013

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1014

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1015

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1016

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1017

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1018

		;jsr $cefd			; CHKCOM
		;jsr $d79e			; get value from BASIC  in X
		;stx 1019

drawmaze:
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
		lda 1013,x
		cmp #3
		bne @wiz4
		lda #2
		sta 1013,x
	@wiz4:
		inx
		cpx #7
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
		lda 1016
		cmp #1
		bne @stairs4
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
		; left bar
		lda #1
		cmp 1013
		bne @leftbar
		cmp 1014
		bne @leftbar
		cmp 1015
		bne @leftbar
		cmp 1016
		bne @leftbar
		jmp @draw_a
		
	@leftbar:
		lda #113
		sta 4096+1+22*2
		sta 4096+1+22*3
		sta 4096+1+22*4
		sta 4096+1+22*5
		
	@draw_a:
		lda 1013
		cmp #1
		beq @draw_b
		
		lda #110
		sta 4096
		sta 4096+23
		lda #111
		sta 4096+7*22
		sta 4096+6*22+1
		lda 1013
		cmp #2
		bne @draw_c
	
	@door_a:
		lda #110
		sta 4096+22
		lda #113
		sta 4096+22*2
		sta 4096+22*3
		sta 4096+22*4
		sta 4096+22*5
		sta 4096+22*6
		jmp @draw_c

	@draw_b:
		lda 1014
		cmp #1
		beq @draw_c
		
		lda #108
		sta 4096+44
		lda #115
		sta 4096+44+1
		lda #117
		sta 4096+110+1
		lda #109
		sta 4096+110
		lda 1014
		cmp #2
		bne @draw_c
		
	@door_b:
		lda #115
		sta 4096+66
		lda #113
		sta 4096+88
		lda #117
		sta 4096+110
		
	@draw_c:
		lda 1016
		cmp #1
		bne @draw_d
		
		lda 1015
		cmp #1
		bne @draw_c2
		jmp @rightbar
		
	@draw_c2:		
		cmp #2
		beq @door_c
		
		lda #110
		sta 4096+46
		lda #60
		sta 4096+69
		lda #111
		sta 4096+46+66
		lda #188
		sta 4096+69+22
		jmp @rightbar
	
	@door_c:
		lda #110
		sta 4096+46
		lda #125
		sta 4096+69
		lda #118
		sta 4096+46+66
		lda #126
		sta 4096+69+22
		lda #124
		sta 4096+68
		lda #119
		sta 4096+90
		jmp @rightbar
		
	@draw_d:
		lda #108
		sta 4096+46
		sta 4096+47
		sta 4096+48
		sta 4096+49
		lda #109
		sta 4096+46+66
		sta 4096+47+66
		sta 4096+48+66
		sta 4096+49+66
		
		lda 1016
		cmp #2
		bne @rightbar
		
	@door_d:
		lda #114
		sta 4096+3*23
		lda #115
		sta 4096+3*23+1
		lda #112
		sta 4096+3*23+22
		lda #113
		sta 4096+3*23+23
		lda #116
		sta 4096+3*23+44
		lda #117
		sta 4096+3*23+45
	
	@rightbar:
		; right bar
		lda #1
		cmp 1016
		bne @rightbar2
		cmp 1017
		bne @rightbar2
		cmp 1018
		bne @rightbar2
		cmp 1019
		bne @rightbar2
		jmp @draw_g
	
	@rightbar2:
		lda #112
		sta 4096+6+22*2
		sta 4096+6+22*3
		sta 4096+6+22*4
		sta 4096+6+22*5
	
	@draw_g:
		lda 1016
		cmp #1
		bne @draw_f
		
		lda 1019
		cmp #1
		beq @draw_f
		cmp #2
		beq @door_g
		
		; draw g wall
		lda #62
		sta 4096+3*22+4
		lda #111
		sta 4096+2*22+5
		lda #190
		sta 4096+4*22+4
		lda #110
		sta 4096+5*22+5
		jmp @draw_f
	
	@door_g:
		lda #27
		sta 4096+3*22+4
		lda #28
		sta 4096+3*22+5
		lda #111
		sta 4096+2*22+5
		lda #127
		sta 4096+4*22+4
		lda #123
		sta 4096+5*22+5
		lda #122
		sta 4096+4*22+5
		
	@draw_f:
		lda 1017
		cmp #1
		bne @draw_e
		
		lda 1018
		cmp #1
		beq @exit
		lda #114
		sta 4096+2*22+6
		lda #108
		sta 4096+2*22+7
		lda #116
		sta 4096+5*22+6
		lda #109
		sta 4096+5*22+7
		lda 1018
		cmp #2
		bne @exit
		
		lda #116
		sta 4096+5*22+7
		lda #112
		sta 4096+4*22+7
		lda #114
		sta 4096+3*22+7
		jmp @exit
		
	@draw_e:
		lda #111
		sta 4096+7
		sta 4096+22+6
		lda #110
		sta 4096+6*22+6
		sta 4096+7*22+7
		
		lda 1017
		cmp #2
		bne @exit
		
		lda #111
		sta 4096+22+7
		lda #112
		sta 4096+7+2*22
		sta 4096+7+3*22
		sta 4096+7+4*22
		sta 4096+7+5*22
		sta 4096+7+6*22
		
	@exit:
		rts

	@pokeitem:
		sta 4096,x
		tya
		inx
		sta 4096,x
		rts
;-------------------------------------------------------------

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
		
	@east:
		ldy #1
		jsr @and12
		sta 1013			; a
		jsr @and3
		sta 1014			; b
		ldy #2
		jsr @and12
		sta 1015			; c
		ldy #23
		jsr @and3
		sta 1016			; d
		jsr @and12
		sta 1017			; e
		ldy #45
		jsr @and3
		sta 1018			; f
		ldy #24
		jsr @and12
		sta 1019			; g
		jsr @and240
		sta 1012			;i		
		rts
		
	@north:
		ldy #22
		jsr @and3
		sta 1013			; a
		ldy #0
		jsr @and12
		sta 1014			; b
		jsr @and3
		sta 1015			; c
		ldy #1
		jsr @and12
		sta 1016			; d
		jsr @and240
		sta 1012			; i
		jsr @and3
		sta 1019			; g
		
		ldy #23
		jsr @and3
		sta 1017			; e

		ldy #2		
		jsr @and12
		sta 1018			; f
		rts
		
	@west:
		ldy #23
		jsr @and12
		sta 1013			; a
		ldy #44
		jsr @and3
		sta 1014			; b
		ldy #22
		jsr @and12
		sta 1015			; c
		jsr @and240
		sta 1012			; i
		jsr @and3
		sta 1016			; d
		ldy #1
		jsr @and12
		sta 1017			; e
		ldy #0
		jsr @and3
		sta 1018			; f
		jsr @and12
		sta 1019			; g
		rts
		
	@south:
		ldy #23
		jsr @and3
		sta 1013			; a
		jsr @and12
		sta 1016			; d
		ldy #24
		jsr @and12
		sta 1014			; b
		ldy #45
		jsr @and3
		sta 1015			; c
		jsr @and240
		sta 1012			; i
		ldy #22
		jsr @and3
		sta 1017			; e
		jsr	@and12
		sta 1018			; f
		ldy #44
		jsr @and3
		sta 1019			; g
		rts
	
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
;-------------------------------------------------------------

travelbuffs:	
	; display travel buffs
		
		ldx #0
		lda #32
	@l1:
		sta 4096+7*22+9,x
		inx
		cpx #13
		bne @l1
		
		ldx #0
	@l2:
		lda 1004,x
		cmp #0
		beq @l3
		dec 1004,x
		txa
		clc
		rol
		tay
		lda @travelmagic,x
		sta 4096+7*22+9,y
	@l3:
		inx
		cpx #7
		bne @l2	
		
	@travelmagic:
		.byte 12,13,9,23,20,5,19
;-------------------------------------------------------------

erasemaze:
	; erase maze
	
		ldx #0
		lda #32
	@l1:
		sta 4096+22*0,x
		sta 4096+22*1,x
		sta 4096+22*2,x
		sta 4096+22*3,x
		sta 4096+22*4,x
		sta 4096+22*5,x
		sta 4096+22*6,x
		sta 4096+22*7,x

		inx
		cpx #8
		bne @l1
		rts
;-------------------------------------------------------------

cleartext:
		ldx #0
		lda #32
	@l1:
		sta 4294,x
		inx
		cpx #110
		bne @l1
		ldx #0
		ldy #9
		jmp movecursor2
;-------------------------------------------------------------

showpic:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx $fe
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx 1003
		ldx $fe
		cpx #0
		beq @pic1
		cpx #1
		beq @pic2
		jmp @pic3
		
	@pic1:
		ldy #>4608
		jmp @draw
	@pic2:
		ldy #>5120
		jmp @draw
	@pic3:
		ldy #>5632
	
	@draw:
		sty $fc
		iny
		sty $fe
		ldy #0
		sty $fb
		sty $fd

	@l1:
		lda ($fb),y
		sta 7680,y
		lda ($fd),y
		sta 7680+256,y
		iny
		cpy #0
		bne @l1

		ldx #0
		lda #192
	@l2:
		clc
		sta 4096,x
		adc #1
		sta 4096+22,x
		adc #1
		sta 4096+44,x
		adc #1
		sta 4096+66,x
		adc #1
		sta 4096+88,x
		adc #1
		sta 4096+110,x
		adc #1
		sta 4096+132,x
		adc #1
		sta 4096+154,x
		adc #1
		
		inx
		cpx #8
		bne @l2
		
		ldx #0
		lda 1003
	@l3:
		sta 37888,x
		sta 37888+22,x
		sta 37888+44,x
		sta 37888+66,x
		sta 37888+88,x
		sta 37888+110,x
		sta 37888+132,x
		sta 37888+154,x
		inx
		cpx #8
		bne @l3
		rts
;-------------------------------------------------------------

loadpic:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		clc
		adc #48
		sta @filename+12
		
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		clc
		adc #48
		sta @filename+13
		
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		clc
		rol
		adc #18
		sta $fc
		adc #1
		sta $fe
		
		jsr load1
		LDA #14			; contains the file name length
		LDY #>(@filename)	; file name high byte
		LDX #<(@filename)	; file name low byte
		jsr load2
		
		; now copy image at 7680 at location specified in $fb,$fd
		
		ldy #0
	@l1:
		lda 7680,y
		sta ($fb),y
		lda 7680+256,y
		sta ($fd),y
		iny
		cpy #0
		bne @l1
		
		rts
		
@filename:
	.byte "RQ4.MONSTER 00",0
;-------------------------------------------------------------	
	
loadfile:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		sta @filename+4
		
		jsr load1
		lda #5
		LDY #>(@filename)	; file name high byte
		LDX #<(@filename)	; file name low byte
		jmp load2
		
@filename:
	.byte "RQ4.C",0
;-------------------------------------------------------------		

load1:
		LDX 1020
		LDA #1
		TAY
		jmp $FFBA
;-------------------------------------------------------------

load2:
		JSR $FFBD		; set up file name

		LDA #0
		sta $fb
		sta $fd
		LDX #<(7680)
		LDY #>(7680)
		JSR $FFD5		; load

		LDA #1			; logical file 1
		jmp $FFC3		; close file
;-------------------------------------------------------------

selectmenu:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		pha
		ldx #0
	@l1:
		lda 4096+9+22*0,x
		and #127
		sta 4096+9+22*0,x
		
		lda 4096+9+22*1,x
		and #127
		sta 4096+9+22*1,x
		
		lda 4096+9+22*2,x
		and #127
		sta 4096+9+22*2,x
		
		lda 4096+9+22*3,x
		and #127
		sta 4096+9+22*3,x
		
		lda 4096+9+22*4,x
		and #127
		sta 4096+9+22*4,x
		
		lda 4096+9+22*5,x
		and #127
		sta 4096+9+22*5,x
		
		inx
		cpx #13
		bne @l1
		
		pla
		tax
		
		lda @menu,x
		tay
		
		ldx #0
	@l2:
		lda 4096,y
		ora #128
		sta 4096,y
		iny
		inx
		cpx #6
		bne @l2
		
		rts
		
	@menu:
		.byte 9+22*0
		.byte 9+22*1
		.byte 9+22*2
		.byte 9+22*3
		.byte 9+22*4
		.byte 9+22*5
		
		.byte 16+22*0
		.byte 16+22*1
		.byte 16+22*2
		.byte 16+22*3
		.byte 16+22*4
		.byte 16+22*5
;-------------------------------------------------------------

selectchar:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		txa
		pha
		ldx #0
	@l1:
		lda 4096+15*22,x
		and #127
		sta 4096+15*22,x
		inx
		cpx #176
		bne @l1
		
		pla
		tax
		cpx #8
		beq @l2
		bpl @l2
		
		lda SCREENPOS+15,x
		sta $fb
		lda SCREENPOS2+15,x
		sta $fc
		
		lda #0
		sta $fd
		lda #22
		sta $fe

		jmp reverseline2
	@l2:
		rts
;-------------------------------------------------------------
revtopbottom:
		ldx #0
	@l1:
		lda 4096,x
		ora #128
		sta 4096,x
		lda 4096+22*22,x
		ora #128
		sta 4096+22*22,x
		inx
		cpx #22
		bne @l1
		
		rts
;-------------------------------------------------------------

displayspell:

		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		
		txa
		LDY #>(@spells)
		LDX #<(@spells)
		JMP PRINTSTRING

@spells:
.byte "CHARM MONSTER",0   ;0  13
.byte "FIND FAMILIAR",0   ;1  13
.byte "MAGIC MISSILE",0   ;2  13
.byte "SLEEP",0   ;3  5
.byte "STINKING CLOUD",0   ;4  14
.byte "CLOUDKILL",0   ;5  9
.byte "DETECT MAGIC(M)",0   ;6  15
.byte "LIGHTNING BOLT",0   ;7  14
.byte "REVEAL LOCATION",0   ;8  15
.byte "STRENGTH",0   ;9  8
.byte "FIREBALL",0   ;10  8
.byte "HASTE",0   ;11  5
.byte "MONSTER SUMMON 1",0   ;12  16
.byte "PHANTASMAL FORCE",0   ;13  16
.byte "WIZARD'S EYE(W)",0   ;14  15
.byte "DIMENSION DOOR",0   ;15  14
.byte "ENCHANTED WEAPON",0   ;16  16
.byte "FEAR",0   ;17  4
.byte "ICE STORM",0   ;18  9
.byte "MESMERIZE",0   ;19  9
.byte "DEATH",0   ;20  5
.byte "MONSTER SUMMON 2",0   ;21  16
.byte "MORDENKAIS SWORD",0   ;22  16
.byte "POWER WORD STUN",0   ;23  15
.byte "STONE TO FLESH",0   ;24  14
.byte "CLONE",0   ;25  5
.byte "GATE",0   ;26  4
.byte "METEOR SWARM",0   ;27  12
.byte "POWER WORD KILL",0   ;28  15
.byte "TIME STOP",0   ;29  9

.byte "BLESS",0   ;0  5
.byte "CURE LIGHT WNDS",0   ;1  15
.byte "LIGHT(L)",0   ;2  8
.byte "PROT. FROM EVIL",0   ;3  15
.byte "TURN THE UNDEAD",0   ;4  15
.byte "EXILE THE UNDEAD",0   ;5  16
.byte "EXORCISM",0   ;6  8
.byte "INVISIBILITY(I)",0   ;7  15
.byte "MIRROR IMAGE",0   ;8  12
.byte "SPEAK WITH DEAD",0   ;9  15
.byte "CURE SERIOUS WDS",0   ;10  16
.byte "FIND TRAPS(T)",0   ;11  13
.byte "PRAYER",0   ;12  6
.byte "REMOVE CURSE",0   ;13  12
.byte "SPIRITUAL SHIELD",0   ;14  16
.byte "COMMUNE W. DEAD",0   ;15  15
.byte "CURE POISON",0   ;16  11
.byte "DETECT EVIL(E)",0   ;17  14
.byte "EXCOMMUNICATION",0   ;18  15
.byte "REMOVE ALL CRSES",0   ;19  16
.byte "CACODEMON",0   ;20  9
.byte "CURE ALL POISONS",0   ;21  16
.byte "CURE CRIT WOUNDS",0   ;22  16
.byte "TRUE SIGHT(S)",0   ;23  13
.byte "RAISE DEAD",0   ;24  10
.byte "ASTRAL SPELL",0   ;25  12
.byte "HOLY SYMBOL",0   ;26  11
.byte "RESTORATION",0   ;27  11
.byte "RESURRECTION",0   ;28  12
.byte "WORD OF RECALL",0   ;29  14
;-------------------------------------------------------------

displayitem:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		
		txa
		LDY #>(@items)
		LDX #<(@items)
		JMP PRINTSTRING
		
@items:
  .byte " ",0  ; 0
  .byte "AXE",0  ; 1
  .byte "BROAD SWORD",0  ; 2
  .byte "CLUB",0  ; 3
  .byte "DAGGER",0  ; 4
  .byte "MACE",0  ; 5
  .byte "QUARTER STAFF",0  ; 6
  .byte "SHORT SWORD",0  ; 7
  .byte "WAR HAMMER",0  ; 8
  .byte "CHAIN MAIL",0  ; 9
  .byte "LEATHER ARMOR",0  ; 10
  .byte "PLATE MAIL",0  ; 11
  .byte "ROBE",0  ; 12
  .byte "SHIELD",0  ; 13
  .byte "MAP QUEST",0  ; 14
  .byte "AXE OF CHARMS",0  ; 15
  .byte "AXE OF CIRGAR",0  ; 16
  .byte "AXE OF LORDS",0  ; 17
  .byte "AXE OF MIGHT",0  ; 18
  .byte "AXE+1",0  ; 19
  .byte "BALMUNG",0  ; 20
  .byte "CUTHBERTS MACE",0  ; 21
  .byte "DAGGER+1",0  ; 22
  .byte "DAGGER+2",0  ; 23
  .byte "DAGGER+3",0  ; 24
  .byte "DEATH BLADE",0  ; 25
  .byte "DEATH DAGGER",0  ; 26
  .byte "EXCALIBUR",0  ; 27
  .byte "HAMMER OF THOR",0  ; 28
  .byte "KARGEN HAMMER",0  ; 29
  .byte "MACE OF WARGIR",0  ; 30
  .byte "MACE+1",0  ; 31
  .byte "MACE+2",0  ; 32
  .byte "MAUL OF NANREG",0  ; 33
  .byte "ROD OF CLOUDS",0  ; 34
  .byte "ROD OF COMMAND",0  ; 35
  .byte "ROD OF DEATH",0  ; 36
  .byte "ROD OF HEALING",0  ; 37
  .byte "ROD OF KINGS",0  ; 38
  .byte "ROD OF LIFE",0  ; 39
  .byte "ROD OF RESCUE",0  ; 40
  .byte "STAFF OF DIM",0  ; 41
  .byte "STAFF OF FEAR",0  ; 42
  .byte "STAFF OF FIRE",0  ; 43
  .byte "STAFF OF GLORY",0  ; 44
  .byte "STAFF OF LIFE",0  ; 45
  .byte "STAFF OF LIGHT",0  ; 46
  .byte "STAFF OF ORCUS",0  ; 47
  .byte "SWORD OF CHARM",0  ; 48
  .byte "SWORD OF LIGHT",0  ; 49
  .byte "SWORD+1",0  ; 50
  .byte "SWORD+2",0  ; 51
  .byte "SWORD+3",0  ; 52
  .byte "SWORD+4",0  ; 53
  .byte "WIZARD'S STAFF",0  ; 54
  .byte "CHAIN MAIL+1",0  ; 55
  .byte "CHAIN MAIL+2",0  ; 56
  .byte "CHAIN MAIL+3",0  ; 57
  .byte "CHAIN MAIL+4",0  ; 58
  .byte "COAT OF ARND",0  ; 59
  .byte "ELVEN ARMOR",0  ; 60
  .byte "LEATHER+1",0  ; 61
  .byte "LEATHER+2",0  ; 62
  .byte "LEATHER+3",0  ; 63
  .byte "MITHRIL MAIL",0  ; 64
  .byte "PLATE MAIL+1",0  ; 65
  .byte "PLATE MAIL+2",0  ; 66
  .byte "PLATE MAIL+3",0  ; 67
  .byte "PLATE MAIL+4",0  ; 68
  .byte "PLATE MAIL+5",0  ; 69
  .byte "ROBE+1",0  ; 70
  .byte "ROBE+2",0  ; 71
  .byte "MITHRIL SHIELD",0  ; 72
  .byte "SHIELD+1",0  ; 73
  .byte "SHIELD+2",0  ; 74
  .byte "SHIELD+3",0  ; 75
  .byte "BISHOP'S GEM",0  ; 76
  .byte "GEM OF ANNIHIL",0  ; 77
  .byte "GEM OF COTIAR",0  ; 78
  .byte "GEM OF DEATH",0  ; 79
  .byte "GEM OF FIRE",0  ; 80
  .byte "GEM OF HEALER",0  ; 81
  .byte "GEM OF HEALING",0  ; 82
  .byte "GEM OF HELIA",0  ; 83
  .byte "GEM OF ICEPIC",0  ; 84
  .byte "GEM OF METEORS",0  ; 85
  .byte "GEM OF MISSILE",0  ; 86
  .byte "GEM OF NIMROD",0  ; 87
  .byte "SORCERER'S GEM",0  ; 88
  .byte "AMULET OF ISIS",0  ; 89
  .byte "BISHOP'S RING",0  ; 90
  .byte "CROWN OF MIGHT",0  ; 91
  .byte "DAPHNI'S RING",0  ; 92
  .byte "EYE OF VECNA",0  ; 93
  .byte "HOLY CROSS",0  ; 94
  .byte "IMPERIAL RING",0  ; 95
  .byte "NECKLACE/MISSL",0  ; 96
  .byte "PLATINUM RING",0  ; 97
  .byte "RING OF DEAD",0  ; 98
  .byte "RING OF PROT+1",0  ; 99
  .byte "RING OF PROT+2",0  ; 100
  .byte "RING OF PROT+3",0  ; 101
  .byte "RING OF REGEN",0  ; 102
  .byte "RING OF WORLDS",0  ; 103
  .byte "RING/HERACLES",0  ; 104
  .byte "RING/INVISIBLE",0  ; 105
  .byte "RING/WIZARDRY",0  ; 106
  .byte "SEERING STONE",0  ; 107
  .byte "SILVER CROSS",0  ; 108
  .byte "FULL HEAL POT.",0  ; 109
  .byte "HEALER POTION",0  ; 110
  .byte "HEALING POTION",0  ; 111
  .byte "HOLY WATER",0  ; 112
  .byte "POTION OF DEAD",0  ; 113
  .byte "POTION OF LIFE",0  ; 114
  .byte "POTION OF LONG",0  ; 115
  .byte "POTION OF SPED",0  ; 116
  .byte "POTION/CLAIRV",0  ; 117
  .byte "POTION/CURE P",0  ; 118
  .byte "BOOK OF BEASTS",0  ; 119
  .byte "BOOK OF BEAUTY",0  ; 120
  .byte "BOOK OF DARK",0  ; 121
  .byte "BOOK OF HEALTH",0  ; 122
  .byte "CODEX I PLANES",0  ; 123
  .byte "NECRONOMICON",0  ; 124
  .byte "RECORD OF SPED",0  ; 125
  .byte "SCROLL OF DUMA",0  ; 126
  .byte "SCROLL OF FIRE",0  ; 127
  .byte "SCROLL OF HEAL",0  ; 128
  .byte "SCROLL OF LIFE",0  ; 129
  .byte "SCROLL OF MAPS",0  ; 130
  .byte "SCROLL/COTIAR",0  ; 131
  .byte "SCROLL/DEATH",0  ; 132
  .byte "SCROLL/FLESH",0  ; 133
  .byte "SCROLL/LIGHTNG",0  ; 134
  .byte "SCROLL/SLEEP",0  ; 135
  .byte "TOME OF LIGHT",0  ; 136
  .byte "TOME OF MAGI",0  ; 137
;-------------------------------------------------------------

itemdata:
  .byte 0,2,0,0,0,0,0,0,0,0    ; 0 NONE
  .byte 1,8,0,0,0,0,2+4,0,6,0    ; 1 AXE
  .byte 1,12,0,0,0,0,3+4,0,30,0    ; 2 BROAD SWORD
  .byte 1,6,0,0,0,0,1,0,4,0    ; 3 CLUB
  .byte 1,4,0,0,0,0,0+4,0,2,0    ; 4 DAGGER
  .byte 1,8,0,0,0,0,1,0,10,0    ; 5 MACE
  .byte 1,4,0,0,0,0,0,0,3,0    ; 6 QUARTER STAFF
  .byte 1,10,0,0,0,0,2+4,0,8,0    ; 7 SHORT SWORD
  .byte 1,6,1,0,0,0,1,0,9,0    ; 8 WAR HAMMER
  .byte 2,0,6,0,0,0,2,0,30,0    ; 9 CHAIN MAIL
  .byte 2,0,4,0,0,0,1,0,15,0    ; 10 LEATHER ARMOR
  .byte 2,0,8,0,0,0,3,0,60,0    ; 11 PLATE MAIL
  .byte 2,0,2,0,0,0,0,0,5,0    ; 12 ROBE
  .byte 3,0,1,0,0,0,1,0,14,0    ; 13 SHIELD
  .byte 7,0,0,9,25,0,0,1,50,0    ; 14 MAP QUEST
  .byte 1,24,4,20,10,18,2+4,9,48,117    ; 15 AXE OF CHARMS
  .byte 1,24,3,0,0,0,2+4,7,32,78    ; 16 AXE OF CIRGAR
  .byte 1,30,8,28,5,16,3+4,10,232,253    ; 17 AXE OF LORDS
  .byte 1,12,2,0,0,0,2+4,3,8,7    ; 18 AXE OF MIGHT
  .byte 1,10,1,0,0,0,2+4,1,144,1    ; 19 AXE+1
  .byte 1,20,5,6,5,52,3+4,8,200,175    ; 20 BALMUNG
  .byte 1,30,10,58,5,32,16,10,232,253    ; 21 CUTHBERTS MACE
  .byte 1,4,1,0,0,0,0+4,1,50,0    ; 22 DAGGER+1
  .byte 1,6,2,0,0,0,0+4,3,200,0    ; 23 DAGGER+2
  .byte 1,8,3,0,0,0,0+4,5,132,3    ; 24 DAGGER+3
  .byte 1,20,6,0,0,0,3+4,8,0,125    ; 25 DEATH BLADE
  .byte 1,10,4,21,5,24,0+4,9,124,146    ; 26 DEATH DAGGER
  .byte 1,25,7,21,3,53,3+4,9,80,195    ; 27 EXCALIBUR
  .byte 1,20,4,8,5,29,1,4,76,29    ; 28 HAMMER OF THOR
  .byte 1,15,3,0,0,0,1,5,64,31    ; 29 KARGEN HAMMER
  .byte 1,15,3,0,0,0,1,5,148,17    ; 30 MACE OF WARGIR
  .byte 1,10,1,0,0,0,1,1,244,1    ; 31 MACE+1
  .byte 1,12,2,0,0,0,1,3,64,6    ; 32 MACE+2
  .byte 1,20,5,57,2,32,16,9,216,214    ; 33 MAUL OF NANREG
  .byte 1,8,0,6,10,6,8,4,144,1    ; 34 ROD OF CLOUDS
  .byte 1,12,0,14,3,6,0,2,88,2    ; 35 ROD OF COMMAND
  .byte 1,10,0,21,10,6,8,8,124,21    ; 36 ROD OF DEATH
  .byte 1,8,0,32,5,6,16,5,44,1    ; 37 ROD OF HEALING
  .byte 1,8,0,1,3,6,0,3,44,1    ; 38 ROD OF KINGS
  .byte 1,10,0,59,10,6,16,7,194,1    ; 39 ROD OF LIFE
  .byte 1,12,0,60,25,6,0,9,16,39    ; 40 ROD OF RESCUE
  .byte 1,12,0,16,25,6,0,6,220,5    ; 41 STAFF OF DIM
  .byte 1,6,0,18,3,6,8,6,88,2    ; 42 STAFF OF FEAR
  .byte 1,8,0,11,10,6,8,4,80,20    ; 43 STAFF OF FIRE
  .byte 1,20,0,27,3,6,0,7,136,19    ; 44 STAFF OF GLORY
  .byte 1,10,0,55,10,6,16,5,164,1    ; 45 STAFF OF LIFE
  .byte 1,8,0,8,10,6,8,3,140,10    ; 46 STAFF OF LIGHT
  .byte 1,30,56,56,5,6,16,10,232,253    ; 47 STAFF OF ORCUS
  .byte 1,10,2,20,10,50,3+4,5,232,3    ; 48 SWORD OF CHARM
  .byte 1,10,2,49,10,50,3+4,6,4,26    ; 49 SWORD OF LIGHT
  .byte 1,10,1,0,0,0,2+4,1,32,3    ; 50 SWORD+1
  .byte 1,12,2,0,0,0,3+4,3,152,8    ; 51 SWORD+2
  .byte 1,15,3,0,0,0,3+4,5,160,15    ; 52 SWORD+3
  .byte 1,20,4,0,0,0,3+4,7,76,29    ; 53 SWORD+4
  .byte 1,12,5,21,2,6,8,9,136,94    ; 54 WIZARD'S STAFF
  .byte 2,0,7,0,0,0,2,1,100,0    ; 55 CHAIN MAIL+1
  .byte 2,0,8,0,0,0,2,2,44,1    ; 56 CHAIN MAIL+2
  .byte 2,0,9,0,0,0,2,3,188,2    ; 57 CHAIN MAIL+3
  .byte 2,0,10,0,0,0,2,4,220,5    ; 58 CHAIN MAIL+4
  .byte 2,0,30,0,0,0,0,10,36,244    ; 59 COAT OF ARND
  .byte 2,0,15,0,0,0,0,7,16,39    ; 60 ELVEN ARMOR
  .byte 2,0,5,0,0,0,1,1,75,0    ; 61 LEATHER+1
  .byte 2,0,6,0,0,0,1,3,200,0    ; 62 LEATHER+2
  .byte 2,0,7,0,0,0,1,5,244,1    ; 63 LEATHER+3
  .byte 2,0,20,0,0,0,0,9,168,97    ; 64 MITHRIL MAIL
  .byte 2,0,9,0,0,0,3,1,200,0    ; 65 PLATE MAIL+1
  .byte 2,0,10,0,0,0,3,2,244,1    ; 66 PLATE MAIL+2
  .byte 2,0,11,0,0,0,3,3,176,4    ; 67 PLATE MAIL+3
  .byte 2,0,12,0,0,0,3,4,196,9    ; 68 PLATE MAIL+4
  .byte 2,0,13,0,0,0,3,5,112,23    ; 69 PLATE MAIL+5
  .byte 2,0,3,0,0,0,0,1,40,0    ; 70 ROBE+1
  .byte 2,0,4,0,0,0,0,2,100,0    ; 71 ROBE+2
  .byte 3,0,6,0,0,0,1,8,40,35    ; 72 MITHRIL SHIELD
  .byte 3,0,2,0,0,0,1,1,100,0    ; 73 SHIELD+1
  .byte 3,0,3,0,0,0,1,3,244,1    ; 74 SHIELD+2
  .byte 3,0,4,0,0,0,1,5,196,9    ; 75 SHIELD+3
  .byte 4,0,0,64,100,0,16,2,250,0    ; 76 BISHOP'S GEM
  .byte 4,0,0,29,10,0,8,9,196,9    ; 77 GEM OF ANNIHIL
  .byte 4,0,0,44,100,0,16,2,25,0    ; 78 GEM OF COTIAR
  .byte 4,0,0,21,10,0,8,9,20,130    ; 79 GEM OF DEATH
  .byte 4,0,0,11,100,0,8,2,232,3    ; 80 GEM OF FIRE
  .byte 4,0,0,41,100,0,16,2,30,0    ; 81 GEM OF HEALER
  .byte 4,0,0,32,100,0,16,2,15,0    ; 82 GEM OF HEALING
  .byte 4,0,0,53,100,0,16,2,60,0    ; 83 GEM OF HELIA
  .byte 4,0,0,19,100,0,8,2,244,1    ; 84 GEM OF ICEPIC
  .byte 4,0,0,28,25,0,8,5,16,39    ; 85 GEM OF METEORS
  .byte 4,0,0,3,10,0,8,2,200,0    ; 86 GEM OF MISSILE
  .byte 4,0,0,36,100,0,16,2,250,0    ; 87 GEM OF NIMROD
  .byte 4,0,0,64,100,0,8,2,250,0    ; 88 SORCERER'S GEM
  .byte 5,0,0,24,10,0,0,7,244,1    ; 89 AMULET OF ISIS
  .byte 5,0,0,64,10,0,16,4,64,31    ; 90 BISHOP'S RING
  .byte 5,0,10,30,5,0,0,10,156,224    ; 91 CROWN OF MIGHT
  .byte 5,0,0,128+1,50,0,0,10,232,253    ; 92 DAPHNI'S RING
  .byte 5,0,0,54,5,0,0,10,4,166    ; 93 EYE OF VECNA
  .byte 5,0,0,57,3,0,16,9,64,156    ; 94 HOLY CROSS
  .byte 5,0,0,21,5,0,0,9,16,39    ; 95 IMPERIAL RING
  .byte 5,0,0,3,5,0,8,4,44,1    ; 96 NECKLACE/MISSL
  .byte 5,0,0,57,5,0,0,9,20,130    ; 97 PLATINUM RING
  .byte 5,0,0,46,10,0,0,9,100,0    ; 98 RING OF DEAD
  .byte 5,0,1,0,0,0,0,4,232,3    ; 99 RING OF PROT+1
  .byte 5,0,2,0,0,0,0,6,184,11    ; 100 RING OF PROT+2
  .byte 5,0,3,0,0,0,0,8,136,19    ; 101 RING OF PROT+3
  .byte 5,0,0,58,5,0,0,6,232,3    ; 102 RING OF REGEN
  .byte 5,0,0,16,25,0,0,5,88,2    ; 103 RING OF WORLDS
  .byte 5,0,0,128+8,100,0,0,9,80,195    ; 104 RING/HERACLES
  .byte 5,0,0,38,5,0,0,2,172,8    ; 105 RING/INVISIBLE
  .byte 5,0,0,64,10,0,8,4,64,31    ; 106 RING/WIZARDRY
  .byte 5,0,0,7,5,0,0,2,200,0    ; 107 SEERING STONE
  .byte 5,0,0,49,10,0,16,5,100,0    ; 108 SILVER CROSS
  .byte 6,0,0,53,100,0,0,3,40,0    ; 109 FULL HEAL POT.
  .byte 6,0,0,41,100,0,0,2,20,0    ; 110 HEALER POTION
  .byte 6,0,0,32,100,0,0,1,10,0    ; 111 HEALING POTION
  .byte 6,0,0,49,25,0,16,2,15,0    ; 112 HOLY WATER
  .byte 6,0,0,46,100,0,0,2,25,0    ; 113 POTION OF DEAD
  .byte 6,0,0,59,100,0,0,6,136,19    ; 114 POTION OF LIFE
  .byte 6,0,0,128+2,100,0,0,5,250,0    ; 115 POTION OF LONG
  .byte 6,0,0,12,100,0,0,2,45,0    ; 116 POTION OF SPED
  .byte 6,0,0,54,100,0,0,3,50,0    ; 117 POTION/CLAIRV
  .byte 6,0,0,47,100,0,0,1,30,0    ; 118 POTION/CURE P
  .byte 7,0,0,22,5,0,8,8,152,58    ; 119 BOOK OF BEASTS
  .byte 7,0,0,128+13,100,0,0,9,80,195    ; 120 BOOK OF BEAUTY
  .byte 7,0,0,27,25,0,0,9,136,19    ; 121 BOOK OF DARK
  .byte 7,0,0,128+12,100,0,0,9,80,195    ; 122 BOOK OF HEALTH
  .byte 7,0,0,27,5,0,8,10,200,175    ; 123 CODEX I PLANES
  .byte 7,0,0,56,5,0,16,8,168,97    ; 124 NECRONOMICON
  .byte 7,0,0,128+11,100,0,0,9,80,195    ; 125 RECORD OF SPED
  .byte 7,0,0,1,25,0,8,5,100,0    ; 126 SCROLL OF DUMA
  .byte 7,0,0,11,25,0,8,3,196,9    ; 127 SCROLL OF FIRE
  .byte 7,0,0,32,5,0,16,3,126,4    ; 128 SCROLL OF HEAL
  .byte 7,0,0,55,50,0,16,3,244,1    ; 129 SCROLL OF LIFE
  .byte 7,0,0,9,25,0,0,2,50,0    ; 130 SCROLL OF MAPS
  .byte 7,0,0,44,25,0,16,3,100,0    ; 131 SCROLL/COTIAR
  .byte 7,0,0,29,25,0,8,7,136,19    ; 132 SCROLL/DEATH
  .byte 7,0,0,25,25,0,8,3,44,1    ; 133 SCROLL/FLESH
  .byte 7,0,0,8,25,0,8,2,176,4    ; 134 SCROLL/LIGHTNG
  .byte 7,0,0,4,25,0,8,1,50,0    ; 135 SCROLL/SLEEP
  .byte 7,0,0,128+10,100,0,0,9,80,195    ; 136 TOME OF LIGHT
  .byte 7,0,0,128+9,100,0,0,9,80,195    ; 137 TOME OF MAGI

;-------------------------------------------------------------

PRINTSTRING:
		; x/y is low/high to be passed
		; # of string is in ACC
		STX $fb
		STY $fc
		LDY #0
		LDX #0
		STA $fd
		CMP #0
		BEQ @PS4
@PS1:
		LDA ($fb),Y
		CMP #0
		BEQ @PS3
@PS2:
		JSR ADD1LOHI
		JMP @PS1
@PS3:
		INX
		CPX $fd
		BNE @PS2

		JSR ADD1LOHI
@PS4:
		LDY $fc
		LDA $fb
		JMP PRINTSTRING_K
;-------------------------------------------------------------
ADD1LOHI:
		CLC
		LDA #1
		ADC $fb
		STA $fb
		LDA #0
		ADC $fc
		STA $fc
		RTS
;-------------------------------------------------------------

mazetext:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx 1003
		jsr cleartext
		lda #159
		jsr $ffd2
		
		lda 1003
		LDY #>(5142)
		LDX #<(5142)
		jsr PRINTSTRING
		ldx #15
		ldy #13
		jsr movecursor2
		
		LDA #<(@space)
		LDY #>(@space)
		jsr PRINTSTRING_K
	@k1:
		jsr GETIN_K
		cmp #32
		bne @k1
		rts		
	
	@space:
	.byte 5,"(SPACE)",0
;-------------------------------------------------------------

printrace:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		
		txa
		LDY #>(673)
		LDX #<(673)
		JMP PRINTSTRING
;-------------------------------------------------------------

printclass:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		
		txa
		LDY #>(828)
		LDX #<(828)
		JMP PRINTSTRING
;-------------------------------------------------------------

printmonster:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		
		txa
		LDY #>(14336)
		LDX #<(14336)
		JMP PRINTSTRING
;-------------------------------------------------------------

pause:
		jsr $cefd			; CHKCOM
		jsr $d79e			; get value from BASIC  in X
		stx $fe
	@l0:
		ldy #0
	@l1:
		ldx #0
	@l2:
		inx
		cpx #0
		bne @l2
		iny
		cpy #0
		bne @l1
		dec $fe
		lda $fe
		cmp #0
		bne @l0
		rts
;-------------------------------------------------------------

