		.org 826
		.segment "STARTUP"

				.word	MAIN
		

		
; various data at memory location 828
		
MAIN:

; class text data
classtext:
	.byte "FIGHTER",13,0
	.byte "WIZARD",13,0
	.byte "PRIEST",13,0
	.byte "THIEF",13,0
	.byte "BARD",13,0
	.byte "LORD",13,0
	.byte "MONK",13,0
	.byte "NINJA",13,0
	.byte "PALADIN",13,0
	.byte "PEASANT",13,0
	.byte "RANGER",13,0
	.byte "SAGE",13,0

; stat text data
stats:
	.byte "STR",0
	.byte "INT",0
	.byte "WIS",0
	.byte "DEX",0
	.byte "CON",0
	.byte "CHA",0

; attack position for players 0-7
attackpos:
	.byte 0,0,0,0,0,0,0,0			; char #0
	.byte 1,1,1,1,1,1,1,1			; char #1
	.byte 2,2,2,2,2,2				; char #2
	.byte 3,3,3,3,3,3				; char #3
	.byte 4,4,4,4					; char #4
	.byte 5,5,5,4					; char #5
	.byte 6,6						; char #6
	.byte 7,7						; char #7
	
; status
status:
	;.byte " GPZSD",0
	
	.byte 32,7,16,26,19,4
	
; buffer table
bufftable:
	.byte 3,4,5,2
