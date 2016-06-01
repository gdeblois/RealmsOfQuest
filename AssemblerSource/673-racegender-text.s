		.org 671
		.segment "STARTUP"

				.word	MAIN
		
		; text data for races and genders at memory location 673
MAIN:

racetext:
	.byte "HUMAN ",0
	.byte "ELF ",0
	.byte "DWARF ",0
	.byte "HOBBIT ",0
	.byte "GNOLL ",0
	.byte "GNOME ",0
	.byte "KOBOLD ",0
	.byte "OGRE ",0
	.byte "ORC ",0
	.byte "SPRITE ",0
	
sextext:
	.byte "MALE ",0
	.byte "FEMALE ",0