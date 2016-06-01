SCREEN		= 4096
COLOR		= 37888
PICTURES	= $A000
DUNDATA		= 49152

SCREENCOLOR	= 36879
TEXTCOLOR	= 646
FAC		= $61
PRINTSTRING_K	= $CB1E
PRINTINT_XA	= $DDCD		; prints x/a integer to the screen
PRINTFAC_K	= $DDD7		; prints FAC to screen
GETIN_K		= $FFE4
PRINTCHAR_K	= $FFD2
RANDOM_K	= $E094
INT_YA2FAC	= $D391		; converts y/a integer to floating point and stores it in FAC
CMP_FAC2AY	= $DC5B		; compares FAC to memory location a/y
STA_FAC2XY	= $DBD4		; stores FAC to memory location x/y
STA_FAC2TEMP1	= $DBCA		; stores FAC in temporary location 1
STA_FAC2AFAC	= $DC0C
STA_AFAC2FAC	= $DBFC
MEM_AY2FAC	= $DBA2		; transfers MFLPT in a/y to FAC
SUB_AY_FAC	= $D850		; FAC = memory at a/y - FAC
INT_FAC		= $DCCC		; perform INT on FAC
ADD_FAC_AY	= $D867		; add fac to MFLPT in a/y then store in FAC
POWER_AFAC_FAC	= $DF7B		; FAC = AFAC ^ FAC
MULTIPLY_FAC10	= $DAE2		; multiply FAC by 10
MULTIPLY_FAC_AY	= $DA28		; FAC = FAC * memory at A/Y

;******************************************************************

INVSIZE		= 10

;		= $10	
PCHARLO		= $39
PCHARHI		= $3A
PNAMELO		= $3B	; pointer to name
PNAMEHI		= $3C


TEMP1		= $48
TEMP2		= $49
TEMP3		= $4A
TEMP4		= $4B

MUSICLO		= 251
MUSICHI		= 252


PDUNLO		= $3D
PDUNHI		= $3E

TEMPMONS	= $3F

RNDSEED		= 673	; 673-676
TEMPNUMBERKEY	= 677
TEMPNUM		= 678
TEMPSTRING	= 679
TEMPSECMENU	= 680
TEMPSECLO	= 681
TEMPSECHI	= 682
TEMPAUSE	= 683

CTEMP1		= 696
CTEMP2		= 697
CTEMP3		= 698
CTEMP4		= 699

; the following values are temporary combat bonuses
COMBATBACKSTAB	= 700	; 700-705 backstab combat option
COMBATPARRY	= 706	; 706-711 parry combat option
COMBATATTACK	= 712	; 712-717 combat attack bonus (potion of giant strength also provides this)
COMBATARMOR	= 718	; 718-723 combat armor bonus
COMBATSAVE	= 724	; 724-729 combat save bonus
COMBATHASTE1	= 730	; 730-735 is the character hasted for entire combat?
COMBAT_END	= 735

; constants
PMENUSEL	= 742
VIDEOMODE	= 743	; store default 36865 value here
QUITFLAG	= 744
PAUSESOUND1	= 745
PAUSESOUND2	= 746
WHICHSONG	= 747
MUSICNOTEPTR	= 748
MUSICNOTEDUR	= 749


MB_TYPE		= 828
MB_NUMBER	= 829
MB_HITPOINTS	= 830
MB_HPX		= 831	; 831-837
MF_TYPE		= 838
MF_NUMBER	= 839
MF_HITPOINTS	= 840
MF_HPX		= 841	; 841-853
MORALE		= 854


TEMPBACK	= 935
JOY2		= 936
ORBTEMP		= 937
SPELL_STUNKILL	= 938
SPELL_WIZPRIEST	= 939
SPELLDAM2	= 940
SPELLDAM1	= 941
SPELLINTWIS	= 942
SPELLTYPE	= 943
SPELLAREA	= 944
SPELLFACTOR	= 945
DISARMTRIED	= 946
DISARMTRAP	= 947
TREASURETEMP	= 948
SPECIALATTACK	= 949
DCTEMP		= 950
PARRY		= 951
XPTEMP3		= 952	; 952 - 957 temp FAC
PIRATESHIP	= 958
MONSTERROW	= 959
MONSTERPTR	= 960
ROLLTEMP	= 961
PARTYWINS	= 962
MISSILE		= 963
PLAYERTURN	= 964
PCHARCOMBAT	= 965
MONSTERGREET	= 966
MONSTERDISP	= 967
STATUSTEMP	= 968
UNDERCHAR2	= 969	; tile data under the character after moving
XPTEMP1		= 970
XPTEMP2		= 971
PRINTSINGLETEMP	= 972
MOVEUP		= 973
MOVEDOWN	= 974	; 1=ladder, 2=throne, 3=fountain
TEMPFAROBJECT	= 975
MOVEFRONT	= 976
ANITEMP1	= 977
ANITEMP2	= 978
ANITEMP3	= 979
JOY1		= 980
UNDERCHAR	= 981	; tile data under the character
MATHTEMP	= 982
DICETEMP	= 983
STATCHECK	= 984
MOVETEXT	= 985
DRAWMAPLO2	= 986
DRAWMAPHI2	= 987
DRAWMAPX	= 988
DRAWMAPCARRY	= 989
DRAWMAPLO	= 990
DRAWMAPHI	= 991
SHIFT4		= 992	
CO_TEMP		= 993	; change order routine
COLORPTR	= 994
VIEWPOINTER	= 995
VIEWITEMCOUNT	= 996
VIEWSHIELD	= 997
VIEWITEM	= 998
VIEWPOTION	= 999
PCHARTEMP	= 1000
LINEARSEED	= 1001
TEMPNAME	= 1002 ; 1002-1021
TJ		= 1002



ASC_A		= 65
ASC_B		= 66
ASC_C		= 67
ASC_D		= 68
ASC_E		= 69
ASC_F		= 70
ASC_F1		= 133
ASC_F7		= 136
ASC_REVON	= 18
ASC_REVOFF	= 146
ASC_DEL		= 20

COPY_STUFF	= (END_PARTY-PCHAR)

;********************************************************************

		.org 4607
		.segment "STARTUP"

; LOAD "QUIKMAN.PRG",8,1
		.word	BASIC

; 0 SYS7140
; 0 SYS                                    7    1    4    0
BASIC:	.byte	$0B, $10, $00, $00, $9E, $37, $31, $34, $30, $00, $00, $00, $00

;********************************************************************
; PARTY INFO IS IN BETWEEN PNAMELOC TO END_PARTY
;	the data in this section will be saved to and loaded from disk
;********************************************************************

PNAMELOC:
	.byte <(NAME+0*21)
	.byte <(NAME+1*21)
	.byte <(NAME+2*21)
	.byte <(NAME+3*21)
	.byte <(NAME+4*21)
	.byte <(NAME+5*21)

PNAMELOCHI:
	.byte >(NAME+0*21)
	.byte >(NAME+1*21)
	.byte >(NAME+2*21)
	.byte >(NAME+3*21)
	.byte >(NAME+4*21)
	.byte >(NAME+5*21)

PCHARLOC:				; these pointers point to location of name and character stat data
	.byte <(STAT+0*35)		; these are to be copied to the RAM party area
	.byte <(STAT+1*35)
	.byte <(STAT+2*35)
	.byte <(STAT+3*35)
	.byte <(STAT+4*35)
	.byte <(STAT+5*35)

PCHARLOCHI:				; these pointers point to location of name and character stat data
	.byte >(STAT+0*35)		; these are to be copied to the RAM party area
	.byte >(STAT+1*35)
	.byte >(STAT+2*35)
	.byte >(STAT+3*35)
	.byte >(STAT+4*35)
	.byte >(STAT+5*35)

NAME:
	; this is where save game info starts!
	.byte "CADOR BOLIN         ",0		;pre-generated characters
	.byte "BOLZAIM ROUNDAXE    ",0
	.byte "MIRRENWEN MERIEL    ",0
	.byte "DAVGOL ADOLAMIN     ",0
	.byte "JACK B NIMBLE       ",0
	.byte "TELNIR DIVENDAL     ",0

	; the following is player stat info
STAT:
	;char R,C,L,ST,IN,WI,DX,CO,CH,XP         ,HP  ,MHP ,SU ,MSU, WEA,ARM,SHI,MI   ,POT,S,SEX
	.byte 0,5,1,15,12,12,13,15,16,0,0,0,0,0,0,0,12,0,12,0,0,0,0, 6,1,6,0,1,0, 1, 0,1,1,1,0		; cador b
	.byte 2,0,1,17, 9, 9, 9,17,10,0,0,0,0,0,0,0,15,0,15,0,0,0,0, 7,0,5,0,0,0, 0, 0,1,2,1,0		; roundaxe
	.byte 1,4,1,13,13,10,16,10,15,0,0,0,0,0,0,0,11,0,11,0,0,0,0, 5,0,7,0,1,0, 0, 0,0,0,1,1		; bellona
	.byte 0,2,1,12,14,16,10,13,13,0,0,0,0,0,0,0,10,0,10,1,0,0,1, 4,0,5,0,0,0, 0, 0,2,3,1,0		; cuthbert
	.byte 3,3,1,10,10,13,18,10,10,0,0,0,0,0,0,0,7 ,0,7 ,0,0,0,0,10,0,2,0,0,0, 0, 0,3,4,1,0		; arahan
	.byte 1,1,1, 9,17,11,14, 9,11,0,0,0,0,0,0,0,4 ,0,4 ,1,0,0,1, 9,0,1,0,0,0,11,11,0,0,1,0		; riverwind

	;byte	0	= RACE
	;	1	= CLASS
	;	2	= LEVEL
	;	3	= STR
	;	4	= INT
	;	5	= WIS
	;	6	= DEX
	;	7	= CON
	;	8	= CHA
	;	9-14	= XP (FAC)
	;	15-16	= HP (word)
	;	17-18	= MAX HP (word)
	;	19-20	= SU (word)
	;	21-22	= MSU (word)
	;	23	= WEAPON
	;	24	= WEAPON'S magic bonus
	;	25	= ARMOR
	;	26	= ARMOR's magic bonus
	;	27	= SHIELD
	;	28	= SHIELD's magic bonus
	;	29	= MAGIC ITEM
	;	30	= # charges left (if applicable)
	;	31	= POTION
	;	32	= # drinks of potion left
	;	33	= STATUS (0=dead, 1=good, 2=poisoned, 3=statue, 4=paralyzed, 5=empty)
	;	34	= SEX

PCHAR:			.byte 0				; character pointer (0-5)
POSGAME:		.byte 0				; 0 = castle, 1 = map
PMENU:			.byte 0
PMENUOFF:		.byte 0				; 1 = menu off for moving around
POSMAPCARRY:	.byte 0				; carry position on map (only applies to level 0 map)
POSMAPLO:		.byte 0				; lo position on map
POSMAPHI:		.byte 0				; hi position on map
POSDUNZ:		.byte 0				; 0 = map, 1=dunjon level 1, 2=level 2, etc
POSDUNLO:		.byte 0				; lo position in dunjon
POSDUNHI:		.byte 0				; hi position in dunjon
POSDUNFACING:	.byte 0				; direction facing: 0=north, 1=east, 2=south, 3=west
HAVESHIP:		.byte 0				; 0 = no, 1 = yes, 2 = inside the ship
POS_SHIPCARRY:	.byte 0				; carry position of ship
POS_SHIPLO:		.byte 0				; lo position of ship
POS_SHIPHI:		.byte 0				; hi position of ship
PMODE:			.byte 0				; 0 = noncombat, 1=combat
GOLD:			.byte 0,0,0,0,0			; FAC for party's gold
ARROWS:			.byte 0,0			; 2 byte integer to determine # of arrows
BULLETS:		.byte 0,0			; 2 byte integer to determine # of bullets
ITEMTYPE:		.byte 0,0,0,0,0,0,0,0,0,0	; COMMON INVENTORY DATA 1=weapon,2=armor,3=shield,4=magic item,5=potion
ITEMIS:			.byte 0,0,0,0,0,0,0,0,0,0	; COMMON INVENTORY DATA refer to weapon, armor, item tables for this information.
ITEMBONUS:		.byte 0,0,0,0,0,0,0,0,0,0	; COMMON INVENTORY DATA magical bonus of item (if applicable)
ORBS:			.byte 0				; bit pointers for the orbs of powers
QUESTITERATION:	.byte 0				; once a quest is solved, you start over (NIKAEDOR JR)
MUSICOFF:		.byte 0
QUESTITERATION2:.byte 0				; mini RQ3 quest iteration

END_PARTY:
		.byte 0,0			; extra padding (2 bytes)


;********************************************************************

ERASETEXTSECTION:
		LDA #<(SCREEN+12*22)
		STA 1
		LDA #>(SCREEN+12*22)
		STA 2
		LDA #22
		STA 3
		LDA #4
		STA 4
		LDA #0
		STA 5
		JSR ERASESECTION
		LDY #12
		LDX #0
		JMP MOVECURSOR

;********************************************************************

PRINTTEXTSECTION:

		PHA
		TYA
		PHA

		JSR ERASETEXTSECTION

		PLA
		TAY
		PLA

		JMP PRINTSTRING_K

;********************************************************************

SELECTMENUITEM:
		;this routine will highlight the menu item on the screen which is set to PMENUSEL

		JSR UNREVERSEMENUITEM

		LDX PMENUSEL
		LDY MENUITEMPOSITION,X
		LDX #0
@PC2:

		LDA SCREEN,Y		; reverse char the active character
		ORA #128
		STA SCREEN,Y
		INY
		INX
		CPX #10
		BNE @PC2
		RTS

;********************************************************************

PREPARE2:
		JSR PREPARESCREEN
		JSR PRINTMENU
		JMP PRINTCHARS

;********************************************************************
;       FONT AND GRAPHICS MEMORY LOCATION (5120-7139)
;********************************************************************

GRAPHICS:
	; font + some graphics
	.byte 24,89,253,251,89,36,36,102
	.byte 15,27,19,51,63,99,98,0,28,115,243,60,51,51,62,0,31,51,99,96,96,99,63,0,60,118,243,51,51,54,60,0,127,51,48,60,48,51,127,0,127
	.byte 243,48,62,56,48,48,0,31,49,96,111,103,97,63,0,54,118,246,62,54,54,54,0,12,28,28,28,28,28,30,0,4,6,7,70,230,254,124,0,34,102,236,120,108,108,102,0,32,96,224,96
	.byte 98,126,126,0,34,127,219,219,195,195,195,0,33,115,251,127,111,103,99,0,28,39,111,99,99,99,62,0,60,102,227,99,126,96,96,0,56,100,100,100,100,108,63,0,62,99,227
	.byte 127,110,103,99,0,63,97,112,62,3,71,126,0,255,153,24,24,24,24,60,0,33,99,227,99,99,99,62,0,35,99,227,54,54,28,8,0,97,97,225,109,109,55,54,0,99,99,54,28,54,99,99,0
	.byte 99,227,119,62,28,28,28,0,127,71,14,28,56,113,127,0,166,102,106,170,169,153,154,170,174,170,234,170,171,170,186,170,186,254,254,254,154,154,154,170,20,52,116,20
	.byte 255,255,254,124,234,186,174,171,234,186,174,171

	.byte 0,0,0,0,0,0,0,0,6,14,12,28,24,0,48,48,51,119,102,0,0,0,0,0,55,127,118,54,55,127,118,0,63,33,63,67,253,133,133,132,24,126,153,129,195,255,126,60,60,108,237
	.byte 63,111,110,63,1,12,28,56,48,0,0,0,0,6,12,24,24,24,12,6,0,48,24,12,12,12,24,48,0,153,219,126,60,126,219,153,0,8,24,24,127,254,24,24,16,0,0,0,0,0,12,28,24,0,0,0
	.byte 126,126,0,0,0,0,0,0,0,28,28,28,0,1,3,6,12,88,112,96,0,30,35,103,107,115,99,62,0,12,28,44,12,12,28,62,0,60,102,78,28,56,114,126,0,60,102,6,28,6,102,60,0,36,108
	.byte 108,127,254,12,12,0,254,98,96,124,6,206,124,0,28,54,96,254,99,99,62,0,127,103,6,14,12,28,24,0,30,51,115,62,103,103,62,0,62,99,99,63,3,99,62,0,4,28,28,0,0,28,28
	.byte 16,0,12,12,0,0,12,28,24,14,26,48,224,48,26,14,0,0,126,126,0,126,126,0,0,112,88,12,7,12,88,112,0,124,102,102,14,28,0,24,24

	;intro + dunjon + map graphics
	.byte 31,32,79,144,144,144,144,144,248,4,226,18,18,10,10,10,8,24,40,72,136,136,136,136,24,104,136,200,72,72,72,72,31,32,79,144,144,144,144,144,254,2,242,10,6,0
	.byte 0,0,63,64,135,136,144,145,158,128,254,2,242,14,0,254,2,242,255,128,152,164,196,4,4,4,254,2,50,74,70,64,64,64,59,108,225,46,40,40,47,32,240,8,228,18,18,18,228,8
	.byte 15,16,39,72,144,144,144,159,224,16,200,36,18,18,18,242,28,36,68,196,36,36,36,36,14,14,14,30,62,254,252,248,176,176,240,120,62,31,15,3,14,110,246,122,60,222,239
	.byte 246,152,216,248,248,127,63,31,15,104,104,104,104,252,254,254,222,159,191,176,120,60,31,15,7,240,240,48,0,14,254,252,240,127,0,0,192,224,255,255,255,26,26,30,30
	.byte 62,252,248,240,6,6,7,7,7,3,1,0,64,64,64,194,199,255,254,252,47,56,56,56,56,56,56,56,208,104,120,60,60,28,30,30,192,223,240,240,240,120,60,28,10,250,30,30,30,60
	.byte 120,112,36,52,52,52,60,63,63,31,0,0,0,6,14,254,254,252

	.byte 56,68,154,162,162,154,68,56,30,33,64,140,82,81,81,81,56,68,130,50,74,74,74,74,159,191,176,240,240,248,248,248,63,64,243,146,18,18,18,18,255,0,231,36,36,36
	.byte 36,36,255,1,206,76,72,72,72,72,81,81,113,113,113,249,249,249,202,202,206,206,206,222,220,216,26,30,30,30,30,63,127,255,52,60,60,60,60,255,255,255,72,88,120,121
	.byte 123,255,254,252,240,240,48,0,0,0,0,0,170,170,168,168,160,160,128,128,170,170,42,42,10,10,2,2,128,128,160,160,168,168,170,170,2,2,10,10,42,42,170,170,130,130
	.byte 130,130,130,130,130,130,106,106,90,90,86,86,85,85,169,169,165,165,149,149,85,85,128,255,128,128,128,255,128,128,0,255,0,0,0,255,0,0,1,255,1,1,1,255,1,1,129,255
	.byte 129,129,129,255,129,129,128,128,160,160,104,104,90,90,86,86,85,85,85,85,85,85,85,154,154,154,85,169,169,169,170,32,32,32,170,2,2,2,214,150,150,151,214,150,150,151
	.byte 154,102,169,170,166,153,106,170,154,102,169,170,130,130,130,130,106,154,166,169,106,154,166,169

	; reverse font + some graphics
	.byte 170,170,150,150,150,150,150,150,240,228,236,204,192,156,157,255,227,140,12,195,204,204,193,255,224,204,156,159,159,156,192,255,195,137,12,204,204,201,195
	.byte 255,128,204,207,195,207,204,128,255,128,12,207,193,199,207,207,255,224,206,159,144,152,158,192,255,201,137,9,193,201,201,201,255,243,227,227,227,227,227,225,255
	.byte 251,249,248,185,25,1,131,255,221,153,19,135,147,147,153,255,223,159,31,159,157,129,129,255,221,128,36,36,60,60,60,255,222,140,4,128,144,152,156,255,227,216,144
	.byte 156,156,156,193,255,195,153,28,156,129,159,159,255,199,155,155,155,155,147,192,255,193,156,28,128,145,152,156,255,192,158,143,193,252,184,129,255,0,102,231,231
	.byte 231,231,195,255,222,156,28,156,156,156,193,255,220,156,28,201,201,227,247,255,158,158,30,146,146,200,201,255,156,156,201,227,201,156,156,255,156,28,136,193,227
	.byte 227,227,255,128,184,241,227,199,142,128,255,0,0,136,170,154,154,170,170,21,21,16,170,190,255,255,255,0,0,34,170,166
	.byte 166,170,170,149,149,85,85,85,85,85,85,21,21,16,170,170,170,170,170

	.byte 255,255,255,255,255,255,255,255,249,241,243,227,231,255,207,207,204,136,153,255,255,255,255,255,200,128,137,201,200,128,137,255,192,164,167,129,228,100,1
	.byte 231,2,2,10,10,41,41,165,165,195,147,18,192,144,145,192,254,243,227,199,207,255,255,255,255,249,243,231,231,231,243,249,255,207,231,243,243,243,231,207,255,102
	.byte 36,129,195,129,36,102,255,247,231,231,128,1,231,231,239,255,255,255,255,255,243,227,231,255,255,255,129,129,255,255,255,255,255,255,255,227,227,227,255,254,252
	.byte 249,243,167,143,159,255,225,220,152,148,140,156,193,255,243,227,211,243,243,227,193,255,195,153,177,227,199,141,129,255,195,153,249,227,249,153,195,255,219,147
	.byte 147,128,1,243,243,255,1,157,159,131,249,49,131,255,227,201,159,1,156,156,193,255,128,152,249,241,243,227,231,255,225,204,140,193,152,152,193,255,193,156,156,192
	.byte 252,156,193,255,251,227,227,255,255,227,227,239,255,243,243,255,255
	.byte 243,227,231,241,229,207,31,207,229,241,255,255,129,129,255,129,129,255,255,143,167,243,248,243,167,143,255,131,153,153,241,227,255,231,231

PICTURE:
	; 484 empty bytes for the display portrait -- 80 zeros per line
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0

;********************************************************************
; Main entry point into the game

START:
		LDA #1			; beethoven 7
		JSR PLAYMUSIC
		JSR INITIALIZE
		JSR INTRO

		;f1 = start new game
		;f7 = resume old game
@S1:
		JSR GETKEY
		CMP #133
		BEQ @F1
		CMP #136
		BEQ @F3
		BNE @S1
		
		;jump table for function keys
@F1:		JMP STARTGAME
@F3:		JMP LOADGAME


;********************************************************************
STARTGAME:
		LDA #0
		STA PCHAR
STARTGAME2:
		LDA #0
		STA PMODE

		JSR PREPARE2
MAINMENU:
@SG2:
		LDA POSGAME
		LDA PMENUOFF
		BEQ @CONTINUE
		JMP MOVEAROUND
@CONTINUE:
		LDA POSGAME
		BNE @TRAVDISPLAY
		JSR CASTLEPIC
		LDA #2			; bach int13
		JSR PLAYMUSIC
		JMP @CONTINUE1
@TRAVDISPLAY:
		JSR PARTYPIC
@CONTINUE1:
		JSR SELECTMENUITEM
		JSR SELECTCHAR

		LDA POSGAME
		BNE @SG3
		LDA #<(@TEXTCASTLE)
		LDY #>(@TEXTCASTLE)
		JMP @SG4
@SG3:
		LDA #<(@TEXTMENU)
		LDY #>(@TEXTMENU)
@SG4:
		JSR PRINTTEXTSECTION
		LDA #<(@TEXTMENU2)
		LDY #>(@TEXTMENU2)
		JSR PRINTSTRING_K
@VIEWC1:
		;JSR SELECTCHAR
		;JSR SELECTMENUITEM
		LDA #0
		STA TEMP3
@VIEWC2:
		JSR GETKEY
		CMP #32
		BEQ @KEY_SPACE
		CMP #13
		BEQ @KEY_RETURN		
		CMP #17
		BEQ @KEY_DOWN
		CMP #145
		BEQ @KEY_UP

		CMP #29
		BEQ @KEY_RIGHT
		CMP #157
		BEQ @KEY_LEFT

		CMP #49
		BMI @VIEWC2
		CMP #55
		BPL @VIEWC3
		SEC
		SBC #49
@STAPCHAR:
		STA PCHAR
@JSRSELECTCHAR:
		JSR SELECTCHAR
		JMP @VIEWC2

@VIEWC3:
		CMP #65
		BMI @VIEWC2
		CMP #91
		BPL @VIEWC2
@KEY_MENU:
		JSR @PRESSKEY
		LDA QUITFLAG
		BNE @RESTART
		JMP @SG2

@KEY_SPACE:
		LDA POSGAME
		BNE @NOCYCLE
		JSR @CYCLEMENU
		JMP @SG2
@NOCYCLE:
		JMP @VIEWC2

@KEY_RETURN:
		JSR @PRESSRETURN
		LDA QUITFLAG
		BNE @RESTART
		JMP @SG2

@KEY_RIGHT:	
		INC PCHAR
		LDA PCHAR
		CMP #6
		BNE @JSRSELECTCHAR
		LDA #0
		BEQ @STAPCHAR
@KEY_LEFT:
		DEC PCHAR
		LDA PCHAR
		BPL @JSRSELECTCHAR
		LDA #5
		BNE @STAPCHAR

@RESTART:
		JMP START

@KEY_DOWN:
		INC PMENUSEL
		LDA #8
		CMP PMENUSEL
		BPL @JSRSELECTMENUITEM
		LDA #0
		JMP @STAPMENUSEL
@KEY_UP:
		DEC PMENUSEL
		LDA PMENUSEL
		BPL @JSRSELECTMENUITEM
		LDA #8
@STAPMENUSEL:
		STA PMENUSEL
@JSRSELECTMENUITEM:
		JSR SELECTMENUITEM
		JMP @VIEWC2

@PRESSKEY:
		CLC
		SBC #63
		STA TEMP1		; store the key value here A=1, Z=26
		JSR UNREVERSEMENUITEM
		LDY #0
@PK1:
		LDX POSITION,Y
		LDA SCREEN+56,X
		AND #63
		CMP TEMP1
		BNE @PK2
		STY PMENUSEL
		JSR SELECTMENUITEM
		JMP @PRESSRETURN
@PK2:
		INY
		CPY #9
		BMI @PK1
		RTS

@CYCLEMENU:
		INC PMENU
		LDA PMENU
		CMP #3
		BMI @CEXIT
		LDA #0
		STA PMENU
@CEXIT:
		LDA #0
		STA PMENUSEL
		JMP PRINTMENU

@PRESSRETURN:
		LDX PMENU
		LDA @PMENUJUMPLO,X
		STA 1
		LDA @PMENUJUMPHI,X
		STA 2
		JMP (1)

	@PMENUJUMPLO:
		.byte <(@PMENUPARTY)
		.byte <(@PMENUGUILD)
		.byte <(@PMENUSTORE)

	@PMENUJUMPHI:
		.byte >(@PMENUPARTY)
		.byte >(@PMENUGUILD)
		.byte >(@PMENUSTORE)

@PMENUGUILD:
		LDX PMENUSEL
		LDA @PMENUGUILDLO,X
		STA 1
		LDA @PMENUGUILDHI,X
		STA 2
		JMP (1)

	@PMENUGUILDLO:
		.byte <(CREATECHAR)
		.byte <(DELETECHAR)
		.byte <(EDITNAME)
		.byte <(INVENTORY)
		.byte <(CHANGEORDER)		; position
		.byte <(QUITGAME)		; quit
		.byte <(RESTNIGHT)		; rest/inn
		.byte <(SAVEGAME)		; save
		.byte <(VIEWCHAR)

	@PMENUGUILDHI:
		.byte >(CREATECHAR)
		.byte >(DELETECHAR)
		.byte >(EDITNAME)
		.byte >(INVENTORY)
		.byte >(CHANGEORDER)		; position
		.byte >(QUITGAME)		; quit
		.byte >(RESTNIGHT)		; rest/inn
		.byte >(SAVEGAME)		; save
		.byte >(VIEWCHAR)

@PMENUPARTY:
		LDX PMENUSEL
		LDA @PMENUPARTYLO,X
		STA 1
		LDA @PMENUPARTYHI,X
		STA 2
		JMP (1)

	@PMENUPARTYLO:
		.byte <(CASTSPELL)		; cast spell
		.byte <(DRINKPOTION)		; drink potion
		.byte <(INVENTORY)
		.byte <(TRAVEL2)		; move about
		.byte <(CHANGEORDER)		; position
		.byte <(QUITGAME)		; quit
		.byte <(SAVEGAME)		; save
		.byte <(USEITEM)		; use item
		.byte <(VIEWCHAR)

	@PMENUPARTYHI:
		.byte >(CASTSPELL)		; cast spell
		.byte >(DRINKPOTION)		; drink potion
		.byte >(INVENTORY)
		.byte >(TRAVEL2)		; move about
		.byte >(CHANGEORDER)		; position
		.byte >(QUITGAME)		; quit
		.byte >(SAVEGAME)		; save
		.byte >(USEITEM)		; use item
		.byte >(VIEWCHAR)

@PMENUSTORE:
		LDX PMENUSEL
		LDA @PMENUSTORELO,X
		STA 1
		LDA @PMENUSTOREHI,X
		STA 2
		JMP (1)

	@PMENUSTORELO:
		.byte <(TRADINGPOST)		; buy items
		.byte <(CASHIN)			; cash/gold
		.byte <(BUYSHIP)		; dockyard
		.byte <(INVENTORY)		; inventory
		.byte <(QUITGAME)		; quit/main
		.byte <(RESTNIGHT)		; rest/inn
		.byte <(SAVEGAME)		; save
		.byte <(HEALER)			; temple
		.byte <(VIEWCHAR)		; view char

	@PMENUSTOREHI:
		.byte >(TRADINGPOST)		; buy items
		.byte >(CASHIN)			; cash/gold
		.byte >(BUYSHIP)		; dockyard
		.byte >(INVENTORY)		; inventory
		.byte >(QUITGAME)		; quit/main
		.byte >(RESTNIGHT)		; rest/inn
		.byte >(SAVEGAME)		; save game
		.byte >(HEALER)			; temple
		.byte >(VIEWCHAR)		; view char

@NOTIMPLEMENTED:
		RTS

@TEXTCASTLE:
	.byte 13,"  INSIDE THE CASTLE:",0
@TEXTMENU:
	.byte 13,"   OUT ADVENTURING:",0
@TEXTMENU2:
	.byte 13," 1-6 SETS ACTIVE CHAR",0

;********************************************************************

INITIALIZE:
		LDA #<(DISABLERUNSTOP)
		STA 792
		LDA #>(DISABLERUNSTOP)
		STA 793

		CLD
		LDA 36865
		STA VIDEOMODE	; store ntsc/pal value
		LDA #8
		JSR PRINTCHAR_K
		LDA #142
		JSR PRINTCHAR_K
		JSR WHITETEXT	; set character color to white
		LDA #170	; set volume to 15, aux color to pink
		STA 36878

		LDA #205
		STA 36869	; predefined graphics start at GRAPHICS location

		JSR RANDOMIZE		

		LDA #>(STAT)
		STA PCHARHI
		LDA #>(NAME)
		STA PNAMEHI

		; erase all savegame data
		LDX #0
  @ERASED:
		LDA #0
		STA PCHAR,X
		INX
		CPX #COPY_STUFF+1
		BMI @ERASED

		STA QUITFLAG

		; make all 6 character slots empty characters
		LDA #5
		JSR SETSTATUSALL

		; initialize menu data
		;LDA #0
		;STA PMENUSEL
		;STA PMENUOFF
		;STA QUITFLAG
		;STA ORBS
		;STA QUESTITERATION
		;STA QUESTITERATION2

		LDA #1
		STA PMENU

CHEATGOLD:
		;set party gold to 500+
		LDY #244
		LDA #1

		JSR INT_YA2FAC	; convert to FAC
		JMP SETGOLD

;********************************************************************

SETSTATUSALL:
		STA TEMP1
		LDX #0
  @LOOP:
		LDA TEMP1
		STA STAT+33,X
		TXA
		CLC
		ADC #35
		TAX
		CPX #210
		BNE @LOOP
		RTS

;********************************************************************
		
INTRO:
		LDA #15
		STA SCREENCOLOR
		JSR CLEARSCREEN
		JSR HIDESCREEN
		LDA #<(TEXTINTRO)
		LDY #>(TEXTINTRO)
		JMP PRINTSTRING_K
		

;********************************************************************

PREPARESCREEN:
		JSR HIDESCREEN
		JSR CLEARSCREEN
		LDX #0
		LDY #0
@L1:
		; draw the section borders
		LDA #160
		STA SCREEN+11,Y
		STA SCREEN+242,X
		STA SCREEN+253,X
		STA SCREEN+33,X

		;the section borders is to match the actual border at 36879
		LDA #7
		AND SCREENCOLOR
		STA COLOR+11,Y
		STA COLOR+242,X
		STA COLOR+253,X
		STA COLOR+33,X

		;CPX #5
		;BPL @L3
		;TXA
		;CLC
		;ADC #177
		;STA SCREEN+11,Y

@L3:
		CPX #10
		BPL @L2
		TYA
		CLC
		ADC #22
		TAY
@L2:
		INX
		CPX #11
		BNE @L1

		LDX #0
		LDY #16
		JSR MOVECURSOR
		LDA #<(TEXTPARTY)
		LDY #>(TEXTPARTY)
		JMP PRINTSTRING_K

;********************************************************************

CASTLEPIC:
		LDY #35
		STY TEMPMONS
		JSR DISPLAYPIC3
		JSR COPYPIC

		LDA #90			; aux color green
		STA 36878

		LDA #<(@CASTLE1)
		STA 1
		LDA #>(@CASTLE1)
		STA 2

		LDA #10
		STA COLORPTR

		JSR SPECIALPIC

		LDA #4
		STA COLOR+7*22+5
		STA COLOR+8*22+5

		LDA #14
		LDX #4
   @BLUEFLAG:
		STA COLOR+25,X
		DEX
		BPL @BLUEFLAG

		RTS

@CASTLE1:
	.byte  32, 32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32
	.byte  32,32, 32, 207,208,209,210,211,32, 32,  32
	.byte  32,32, 32, 212,213,214,215,216,32, 32,  32
	.byte  32,192,193,194,32, 32, 32, 192,193,194, 32
	.byte  32,197,198,199,195,195,195,197,198,199, 32
	.byte  32,197,198,199,200,200,200,197,198,199, 32
	.byte 160,197,198,199,200,200,200,197,198,199,160
	.byte 160,197,198,199,200,160,200,197,198,199,160
	.byte 160,197,198,199,200,160,200,197,198,199,160
	.byte 160,202,203,204,160,196,160,202,203,204,160
	.byte 160,160,160,160,206,201,160,160,160,160,160

;********************************************************************

SPECIALPIC:
		LDY #0
		LDX #245
@L1:
		TXA
		CLC
		ADC #11
		TAX
		LDA #0
		STA TEMP4
@L2:
		LDA (1),Y
		STA SCREEN,X
		LDA COLORPTR
		STA COLOR,X
		INX
		INY
		CPY #121
		BEQ @L4
		INC TEMP4
		LDA TEMP4
		CMP #11
		BEQ @L1
		JMP @L2
@L4:
		RTS

;********************************************************************

TAVERNPIC:
		LDY #39
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #170		; aux color pink
		STA 36878

		LDA #<(@TAVERN1)
		STA 1
		LDA #>(@TAVERN1)
		STA 2
		LDA #10
		STA COLORPTR
		JSR SPECIALPIC

		LDX #10
  @COLTAV:
		LDA @COLTAVERN1,X
		STA COLOR+22*4,X
		STA COLOR+22*5,X
		STA COLOR+22*6,X
		STA COLOR+22*7,X
		LDA @COLTAVERN2,X
		STA COLOR+22*8,X
		STA COLOR+22*9,X
		DEX
		BPL @COLTAV
		RTS

@COLTAVERN1:
	.byte 10,10,9,14,14,14,12,12,9,13,13
@COLTAVERN2:
	.byte 10,10,9,14, 6, 6,12,12,9, 5, 5

@TAVERN1:
	.byte  32,232, 32 ,234,32 ,236,32 ,32 ,32 ,32 ,32
	.byte  32,233, 32 ,235,32 ,237,32 ,32 ,32 ,32 ,32
	.byte  32,122,122 ,122,122,122,32 ,32 ,32 ,32 ,32
	.byte  32, 32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32 ,32
	.byte 192,194, 32 , 32,196,198,200,222,32 ,228,230
	.byte 193,195, 32 , 32,197,199,201,223,32 ,229,231
	.byte 202,204, 32 , 32,206,208,210,224,32 ,238,240
	.byte 203,205, 32 , 32,207,209,211,225,32 ,239,241
	.byte 212,214,216 ,218,160,160,220,226,216,160,160
	.byte 213,215,217 ,219,160,160,221,227,217,160,160
	.byte 122,122,122 ,122,122,122,122,122,122,122,122

;********************************************************************

PIRATEPIC:
		LDY #40
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #8*16+10		; aux color orange
		STA 36878

		LDA #<(PIRATE1)
		STA 1
		LDA #>(PIRATE1)
		STA 2
		LDA #9
		STA COLORPTR

SHIPCOLORS:
		JSR SPECIALPIC

		LDA #6
		STA COLOR+10*22
		STA COLOR+10*22+10
		LDA #14
		STA COLOR+8*22
		STA COLOR+9*22
		STA COLOR+8*22+10
		STA COLOR+9*22+10
		STA COLOR+10*22+1
		STA COLOR+10*22+9

		LDX #6
		LDA #10
  @LOOP:
		STA COLOR+9*22+2,X
		STA COLOR+10*22+2,X
		DEX
		BPL @LOOP

		RTS

PIRATE1:
	.byte 032,225,225,225,225,032,222,032,032,225,225
	.byte 192,194,196,198,200,032,230,032,192,160,200
	.byte 193,195,197,199,201,032,231,032,193,160,201
	.byte 202,204,206,208,210,032,223,032,202,160,210
	.byte 203,205,207,209,211,032,223,032,203,160,211
	.byte 212,214,216,218,220,032,223,032,212,160,220
	.byte 213,215,217,219,221,032,223,032,213,160,221
	.byte 032,224,224,224,224,032,223,032,032,224,224
	.byte 232,160,160,160,160,032,223,032,160,160,234
	.byte 233,160,236,238,160,226,228,226,228,160,235
	.byte 160,232,237,239,160,227,229,227,229,234,160


;********************************************************************

DOCKYARDPIC:
		LDY #40
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #1*16+10		; aux color white
		STA 36878

		LDA #<(@DOCK1)
		STA 1
		LDA #>(@DOCK1)
		STA 2
		LDA #10
		STA COLORPTR

		JMP SHIPCOLORS

@DOCK1:
	.byte 032,225,225,032,032,222,032,032,032,225,225
	.byte 192,160,200,192,160,160,160,200,192,160,200
	.byte 193,160,201,193,160,160,160,201,193,160,201
	.byte 202,160,210,202,160,160,160,210,202,160,210
	.byte 203,160,211,203,160,160,160,211,203,160,211
	.byte 212,160,220,212,160,160,160,220,212,160,220
	.byte 213,160,221,213,160,160,160,221,213,160,221
	.byte 032,224,224,032,032,223,032,032,032,224,224
	.byte 232,160,160,032,160,160,160,160,032,160,234
	.byte 233,160,160,160,160,236,238,160,160,160,235
	.byte 160,232,160,160,160,237,239,160,160,234,160


;********************************************************************

TEMPLEPIC:
		LDY #41
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #12*16+10		; aux color light red
		STA 36878

		LDA #<(@TEMPLE1)
		STA 1
		LDA #>(@TEMPLE1)
		STA 2
		LDA #12			; char color red
		STA COLORPTR
		JMP SPECIALPIC

@TEMPLE1:
	.byte 192,194,196,032,032,032,032,032,192,194,196
	.byte 032,194,032,202,204,206,208,210,032,195,032
	.byte 032,195,032,203,205,207,209,211,032,194,032
	.byte 032,194,032,212,214,216,218,220,032,195,032
	.byte 032,194,032,213,215,217,219,221,032,194,032
	.byte 032,195,032,222,224,226,228,230,032,194,032
	.byte 032,194,032,223,225,227,229,231,032,195,032
	.byte 032,195,032,032,198,200,232,032,032,194,032
	.byte 032,194,032,032,199,201,233,032,032,195,032
	.byte 032,195,032,032,160,032,160,032,032,194,032
	.byte 193,194,197,032,160,032,160,032,193,194,197

;********************************************************************

BOLZAIMPIC:
		LDY #42
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #10*16+10		; aux color light red
		STA 36878

		LDA #<(@BOLZAIM1)
		STA 1
		LDA #>(@BOLZAIM1)
		STA 2
		LDA #10			; char color red
		STA COLORPTR
		JSR SPECIALPIC

		LDA #2
		STA COLOR+6*22+5
		STA COLOR+6*22+6
		STA COLOR+7*22+5
		STA COLOR+7*22+6

		LDX #6
@B1:
		LDA #6
		STA COLOR+8*22+2,X
		LDA SCREEN+9*22+2,X
		CMP #160
		BEQ @B2
		LDA #14
		BNE @B3
@B2:
		LDA #6
@B3:
		STA COLOR+9*22+2,X
		LDA #6
		STA COLOR+10*22+2,X
		DEX
		BPL @B1

		LDA #14
		STA COLOR+8*22+7

		RTS

@BOLZAIM1:
	.byte 032,122,122,122,122,122,122,122,122,122,032
	.byte 122,122,122,032,032,032,032,032,122,122,122
	.byte 122,122,032,192,194,196,198,200,032,122,122
	.byte 122,122,032,193,195,197,199,201,032,122,122
	.byte 122,122,032,202,204,206,208,210,032,122,122
	.byte 122,122,032,203,205,207,209,211,032,122,122
	.byte 122,122,032,032,032,160,160,214,032,122,122
	.byte 122,122,032,032,032,160,160,215,032,122,122
	.byte 122,122,160,160,160,160,160,216,160,122,122
	.byte 122,122,160,213,213,213,213,217,160,122,122
	.byte 122,122,160,160,160,160,160,160,160,122,122


;********************************************************************

HELLPIC:
		LDY #43
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #9*16+10		; aux color light orange
		STA 36878

		LDA #<(@HELL1)
		STA 1
		LDA #>(@HELL1)
		STA 2
		LDA #10			; char color red
		STA COLORPTR
		JSR SPECIALPIC

		LDX #10
		LDA #14
@H1:
		STA COLOR+1*22,X
		STA COLOR+2*22,X
		STA COLOR+3*22,X
		DEX
		BPL @H1


		LDA #2
		STA COLOR+6*22+3
		STA COLOR+7*22+3
		STA COLOR+7*22+5
		STA COLOR+7*22+6
		STA COLOR+7*22+7
		STA COLOR+8*22+5
		STA COLOR+8*22+6
		STA COLOR+8*22+7
		STA COLOR+9*22+5
		STA COLOR+9*22+6
		RTS


@HELL1:
	.byte 032,032,032,032,032,032,032,032,032,032,032
	.byte 032,192,194,032,032,032,032,032,192,194,032
	.byte 032,193,195,032,204,206,208,032,193,195,032
	.byte 032,032,032,032,205,207,209,032,032,032,032
	.byte 032,032,032,212,214,216,218,032,032,032,032
	.byte 032,032,032,213,215,217,219,201,032,032,032
	.byte 032,032,032,160,222,220,221,223,032,032,032
	.byte 196,198,196,160,210,160,160,160,196,198,196
	.byte 197,199,197,202,210,160,160,160,197,199,197
	.byte 196,198,196,203,200,160,160,211,196,198,196
	.byte 197,199,197,199,197,199,197,199,197,199,197

;********************************************************************

PARTYPIC:
		LDY #44
		STY TEMPMONS

		LDA #<(PICTURE)
		STA 3
		LDA #>(PICTURE)
		STA 4

		JSR DISPLAYPIC3
		LDA #1
		STA SHIFT4
		JSR PREPDOUBLE

		LDA #170		; aux color pink
		STA 36878

		LDA #<(@PARTY1)
		STA 1
		LDA #>(@PARTY1)
		STA 2
		LDA #10			; char color red
		STA COLORPTR
		JSR SPECIALPIC

		LDX #10
@L1:
		LDA @COLOR1,X
		STA COLOR+22*0,X
		STA COLOR+22*1,X
		STA COLOR+22*2,X
		STA COLOR+22*3,X
		STA COLOR+22*4,X
		STA COLOR+22*5,X
		STA COLOR+22*6,X
		STA COLOR+22*7,X
		STA COLOR+22*8,X
		STA COLOR+22*9,X
		STA COLOR+22*10,X
		DEX
		BPL @L1

		LDA #11
		STA COLOR+22*9+0
		STA COLOR+22*9+1
		STA COLOR+22*9+2
		LDA #9
		STA COLOR+22*8+9
		STA COLOR+22*8+10
		RTS

@COLOR1:
	.byte 14,14,14,12,12,12,10,10,10,13,13

@PARTY1:
	.byte 032,192,194,032,032,032,032,032,032,032,032
	.byte 032,193,195,032,032,032,196,198,200,228,230
	.byte 032,202,204,212,214,216,197,199,201,229,231
	.byte 032,203,205,213,215,217,206,208,210,238,240
	.byte 239,241,241,222,224,226,207,209,211,239,241
	.byte 241,241,241,223,225,227,241,218,220,241,241
	.byte 241,241,241,232,234,236,241,241,241,241,241
	.byte 241,241,241,233,235,237,241,219,221,241,241
	.byte 241,241,241,241,241,241,241,241,241,241,241
	.byte 241,241,241,241,241,241,241,241,241,241,241
	.byte 241,241,241,241,241,241,241,241,241,241,241

;********************************************************************



COPYPIC:
		LDY #0
@CP1:
		LDA (1),Y
		STA PICTURE,Y
		LDA #0
		STA PICTURE+200,Y
		INY
		CPY #200
		BNE @CP1
		RTS


;********************************************************************

SETPIC:

		LDA MONSTERPIC,X
		STA TEMPMONS
		LDA MONSTERCOLOR,X
		STA COLORPTR
		RTS

;********************************************************************

DISPLAYPIC3:
		;this prepares the picture that will be displayed
		LDY TEMPMONS
		LDA PICTURELO,Y
		STA 1
		LDA PICTUREHI,Y
		STA 2

		RTS

;********************************************************************

DUNJONPIC:
		JSR SETPIC
		JSR DISPLAYPIC3
		JSR COPYPIC
		JSR SETCOLOR

		LDX #0
@DP2:
		TXA
		CLC
		ADC #192
		STA SCREEN+135,X
		ADC #5
		STA SCREEN+157,X
		ADC #5
		STA SCREEN+179,X
		ADC #5
		STA SCREEN+201,X
		ADC #5
		STA SCREEN+223,X

		LDA TEMP1		;	get the character color
		STA COLOR+135,X
		STA COLOR+157,X
		STA COLOR+179,X
		STA COLOR+201,X
		STA COLOR+223,X

		INX
		CPX #5
		BNE @DP2
		RTS

;********************************************************************

PREPDOUBLE:
		LDY #0
@DP1:
		LDA SHIFT4
		BNE @DP3
		TYA
		AND #7
		CMP #6
		BMI @DP3

		TYA
		STA TEMP2
		CLC
		SBC #31
		TAY
		LDA (1),Y
		LDY TEMP2		
		JMP @DP4
		
@DP3:
		LDA (1),Y
@DP4:
		STA (3),Y
		STA TEMP2
		CLC
		LDA #1
		ADC 3
		STA 3
		LDA #0
		ADC 4
		STA 4
		LDA TEMP2
		STA (3),Y

		INY
		CPY #240
		BNE @DP1

		RTS

;********************************************************************

DOUBLEPIC:
		JSR DOUBLEPIC2
		LDA #0
		STA SHIFT4
		JSR PREPDOUBLE
		JSR SETCOLOR
		JSR DOUBLEERASE

		LDX #0
@DP2:
		TXA
		PHA
		CLC
		ROR
		TAX
		PLA		

		CLC
		ADC #192
		JSR DOUBLETRANSFER

		JSR DOUBLECOLOR
		CPX #10
		BNE @DP2
		RTS

;********************************************************************

SETCOLOR:
		LDA COLORPTR
		AND #240
		ORA #10
		STA 36878	;	every picture will have it's own auxiliary color
		LDA COLORPTR
		AND #15
		STA TEMP1	;	as well as get to define the character color
		RTS

;********************************************************************

DOUBLEPIC2:
		JSR ERASEUPPERLEFT
		LDA #<(PICTURE+4)
		STA 3
		LDA #>(PICTURE+4)
		STA 4

		JMP DISPLAYPIC3

;********************************************************************

ERASEUPPERLEFT:
		LDA #<(SCREEN)
		STA 1
		LDA #>(SCREEN)
		STA 2
		LDA #11
		STA 3
		STA 4
		STA 5
		JMP ERASESECTION

;********************************************************************


DOUBLEERASE:
		LDX #0
		LDA #0
@DE1:
		STA PICTURE+0*8,X
		STA PICTURE+2*8,X
		STA PICTURE+4*8,X
		STA PICTURE+6*8,X
		STA PICTURE+8*8,X
		STA PICTURE+50*8+4,X
		STA PICTURE+52*8+4,X
		STA PICTURE+54*8+4,X
		STA PICTURE+56*8+4,X
		STA PICTURE+58*8+4,X
		INX
		CPX #4
		BNE @DE1
		RTS

;********************************************************************

MIRRORDOUBLEPIC:
		JSR DOUBLEPIC2
		
		LDY #0
@DP1:
		TYA
		AND #7
		CMP #6
		BMI @DP3

		TYA
		STA TEMP2
		CLC
		SBC #31
		TAY
		LDA (1),Y
		LDY TEMP2		
		JMP @DP4
@DP3:
		LDA (1),Y
@DP4:
		STA TEMP2
		CLC
		AND #%11000000
		ROR
		ROR
		ROR
		ROR
		ROR
		ROR
		STA TEMP1
		LDA TEMP2
		AND #%00110000
		ROR
		ROR
		ORA TEMP1
		STA TEMP1
		LDA TEMP2
		AND #%00001100
		ROL
		ROL
		ORA TEMP1
		STA TEMP1
		LDA TEMP2
		AND #%00000011
		ROL
		ROL
		ROL
		ROL
		ROL
		ROL
		ORA TEMP1
		STA TEMP1

		STA (3),Y
		CLC
		LDA #1
		ADC 3
		STA 3
		LDA #0
		ADC 4
		STA 4
		LDA TEMP1
		STA (3),Y

		INY
		CPY #240
		BNE @DP1

		JSR SETCOLOR

		JSR DOUBLEERASE

		LDX #0
		LDA #200
		STA TEMP2
@DP2:
		TXA
		PHA
		CLC
		ROR
		TAX
		PLA		

		CLC
		ADC TEMP2
		JSR DOUBLETRANSFER

		DEC TEMP2
		DEC TEMP2
		DEC TEMP2
		DEC TEMP2

		JSR DOUBLECOLOR
		CPX #10
		BNE @DP2
		RTS

;********************************************************************

DOUBLETRANSFER:
		STA SCREEN+3,X
		ADC #1
		STA SCREEN+25,X		; this displays a double height graphic to the screen
		ADC #9
		STA SCREEN+47,X
		ADC #1
		STA SCREEN+69,X
		ADC #9
		STA SCREEN+91,X
		ADC #1
		STA SCREEN+113,X
		ADC #9
		STA SCREEN+135,X
		ADC #1
		STA SCREEN+157,X
		ADC #9
		STA SCREEN+179,X
		ADC #1
		STA SCREEN+201,X
		ADC #9
		STA SCREEN+223,X
		RTS

;********************************************************************

DOUBLECOLOR:
		LDA TEMP1		;	get the character color
		STA COLOR+03,X
		STA COLOR+25,X
		STA COLOR+47,X
		STA COLOR+69,X
		STA COLOR+91,X
		STA COLOR+113,X
		STA COLOR+135,X
		STA COLOR+157,X
		STA COLOR+179,X
		STA COLOR+201,X
		STA COLOR+223,X

		TXA
		CLC
		ROL
		TAX

		INX
		INX
		RTS

;********************************************************************

PRINTCHARS:
		; erase the chars section (when the order of players changes)
		LDA #<(SCREEN+17*22)
		STA 1
		LDA #>(SCREEN+17*22)
		STA 2
		LDA #22
		STA 3
		LDA #6
		STA 4
		LDA #0
		STA 5
		JSR ERASESECTION

		JSR HIDESCREEN

		LDA #0
		STA TEMP1
@PC1:
		LDX TEMP1
		LDY STATUSPOSITION,X

		; prepare char pointer		
		LDX TEMP1
		JSR PRINTSINGLECHAR

		LDX TEMP1
		INX
		STX TEMP1
		CPX #6
		BNE @PC1

		RTS

;********************************************************************

SELECTCHAR:
		;this routine will highlight the 'active' character on the screen which is set to PCHAR

		LDX #0
@PC1:
		LDA SCREEN+17*22,X		; un-reverse char all the characters
		AND #127
		STA SCREEN+17*22,X
		INX
		CPX #132
		BNE @PC1

		LDX PCHAR
		LDY CHARPOSITION,X
		LDX #0
@PC2:

		LDA SCREEN+256,Y		; reverse char the active character
		ORA #128
		STA SCREEN+256,Y
		INY
		INX
		CPX #22
		BNE @PC2
		RTS

;********************************************************************

UNREVERSEMENUITEM:
		LDX #0
@PC1:
		LDA SCREEN+2*22+12,X
		AND #127
		STA SCREEN+2*22+12,X
		LDA SCREEN+3*22+12,X
		AND #127
		STA SCREEN+3*22+12,X
		LDA SCREEN+4*22+12,X
		AND #127
		STA SCREEN+4*22+12,X
		LDA SCREEN+5*22+12,X
		AND #127
		STA SCREEN+5*22+12,X
		LDA SCREEN+6*22+12,X
		AND #127
		STA SCREEN+6*22+12,X
		LDA SCREEN+7*22+12,X
		AND #127
		STA SCREEN+7*22+12,X
		LDA SCREEN+8*22+12,X
		AND #127
		STA SCREEN+8*22+12,X
		LDA SCREEN+9*22+12,X
		AND #127
		STA SCREEN+9*22+12,X
		LDA SCREEN+10*22+12,X
		AND #127
		STA SCREEN+10*22+12,X


		INX
		CPX #10
		BNE @PC1
		RTS

;********************************************************************

PRINTSINGLECHAR2:
		LDA #18
		JSR PRINTCHAR_K
		LDA PCHAR
		STA TEMP1
		;JSR SELECTCHAR
		JSR PRINTSINGLECHAR

		LDX PCHAR
		LDY CHARPOSITION,X
		LDA SCREEN+277,Y		; reverse char the status
		ORA #128
		STA SCREEN+277,Y

		LDA #146
		JMP PRINTCHAR_K

PRINTSINGLECHAR:
		;pass char number into TEMP1
		LDA PCHAR
		STA PRINTSINGLETEMP
		; prepare char pointer		
		LDX TEMP1
		STX PCHAR
		JSR PREPARECHARPOINTER
		TXA
		CLC
		ADC #17
		TAY
		LDX #0
		JSR MOVECURSOR

		JSR ERASELINE			

		LDA TEMP1	; print number on screen
		CLC
		ADC #49
		JSR PRINTCHAR_K
		LDA #32
		JSR PRINTCHAR_K

		JSR GETSTATUS
		TAX
		LDA POKESTATUS,X
		LDX TEMP1
		LDY STATUSPOSITION,X
		STA SCREEN+256,Y
		CMP #32		; if it's empty, then exit the routine
		BEQ @PS1

		; print name (shortened to 10 chars or if space is hit first)
		LDA PNAMELO
		STA 1
		LDA PNAMEHI
		STA 2
		LDY #0
@PN1:
		LDA (1),Y
		STA TEMPNAME,Y
		INY
		CMP #32
		BEQ @PN2
		CPY #10
		BNE @PN1		
@PN2:
		LDA #0
		STA TEMPNAME,Y
		LDY #>(TEMPNAME)
		LDA #<(TEMPNAME)
		JSR PRINTSTRING_K

		LDA TEMP1
		CLC
		ADC #17
		TAY
		LDX #13
		JSR MOVECURSOR

		LDY #16		;print hitpoints
		JSR PRINTBYTES2
		LDA #47
		JSR PRINTCHAR_K
		LDY #18
		JSR PRINTBYTES2
@PS1:
		LDA PRINTSINGLETEMP
		STA PCHAR
		RTS

;********************************************************************

PRINTMENU:
		; PMENU is where the menu is
		JSR HIDESCREEN

		LDA #<(SCREEN+56)
		STA 1
		LDA #>(SCREEN+56)
		STA 2
		LDA #10
		STA 3
		LDA #9
		STA 4
		LDA #12
		STA 5
		JSR ERASESECTION

		LDX PMENU
		LDA @MENULO,X
		STA 3	; low
		LDA @MENUHI,X
		STA 4	; high

		LDA #0
		STA TEMP1
@PM1:
		LDA 3
		STA 1
		LDA 4
		STA 2
		LDX #12
		LDA TEMP1
		TAY
		JSR MOVECURSOR
		LDA TEMP1
		LDY 2
		LDX 1
		JSR PRINTSTRING
		INC TEMP1
		LDA TEMP1
		CMP #11
		BNE @PM1
		RTS

@MENULO:
	.byte <(@PARTYMENU)
	.byte <(@GUILDMENU)
	.byte <(@STOREMENU)

@MENUHI:
	.byte >(@PARTYMENU)
	.byte >(@GUILDMENU)
	.byte >(@STOREMENU)

@GUILDMENU:
	.byte "THE GUILD ",0,0
	.byte "CREATE",0
	.byte "DELETE",0
	.byte "EDIT NAME",0
	.byte "INVENTORY",0
	.byte "POSITION",0
	.byte "QUIT/MAIN",0
	.byte "REST/INN",0
	.byte "SAVE GAME",0
	.byte "VIEW CHAR.",0
	.byte 0

@PARTYMENU:
	.byte 5,"PARTY MENU",0,0
	.byte "CAST SPELL",0
	.byte "DRINK POT.",0
	.byte "INVENTORY",0
	.byte "MOVE ABOUT",0
	.byte "POSITION",0
	.byte "QUIT/MAIN",0
	.byte "SAVE GAME",0
	.byte "USE ITEM",0
	.byte "VIEW CHAR.",0

@STOREMENU:
	.byte "SHOPPES   ",0,0
	.byte "BOLZAIM TP",0
	.byte "CASH/GOLD",0
	.byte "DOCKYARD",0
	.byte "INVENTORY",0
	.byte "QUIT/MAIN",0
	.byte "REST/INN",0
	.byte "SAVE GAME",0
	.byte "THE TEMPLE",0
	.byte "VIEW CHAR",0

;********************************************************************

WHITETEXT:
		LDA #1
		STA TEXTCOLOR
		RTS

;********************************************************************

HIDESCREEN:
		LDA #255
		STA 36865
		RTS

;********************************************************************

SHOWSCREEN:
		LDA VIDEOMODE
		STA 36865
		RTS

;********************************************************************

COUNTINVENTORY:

		LDX #0
@LOOP0:
		STX VIEWPOINTER
		LDA ITEMTYPE,X
		CMP #0
		BEQ @LOOP0a
		INX
		JMP @LOOP0
@LOOP0a:
		RTS


		LDX #0
@C1:
		STX VIEWPOINTER
		LDA ITEMTYPE,X
		INX
		CMP #0
		BEQ @C1
		RTS


;********************************************************************

QUITGAME:
		LDA #<(TEXTAREYOUSURE)
		LDY #>(TEXTAREYOUSURE)
		JSR GETYESKEY
		BEQ @QUITYES
		RTS
@QUITYES:
		LDA #1
		STA QUITFLAG
		RTS

;********************************************************************

LOADGAME:
		JSR CLEARSCREEN
		LDA #<(DISKORTAPE)
		LDY #>(DISKORTAPE)
		JSR PRINTTEXTSECTION
		JSR GETKEY
		CMP #68
		BEQ @LOADDISK
		CMP #84
		BEQ @LOADTAPE
@EXITLOAD:
		JMP START

@LOADTAPE:
		JSR TURNOFFVOLUME
		LDX #1
		JSR CLEARSCREEN
		LDA #1
		TAY
		JSR $FFBA
		LDA #7			; contains the file name length
@LOADHERE3:
		LDY #>(LOADNAME)	; file name high byte
		LDX #<(LOADNAME)	; file name low byte
		JSR $FFBD		; set up file name

		LDA #0
		LDX #<(PNAMELOC)
		LDY #>(PNAMELOC)
		JSR $FFD5		; load

		LDA #1			; logical file 1
		JSR $FFC3		; close file
		;JSR CHEATGOLD
		JSR TURNONVOLUME
		JMP STARTGAME2

@LOADDISK:
		JSR SELECTSLOT
		BMI @EXITLOAD
		CLC
		ADC #49
		STA LOADNAME+7

		JSR TURNOFFVOLUME
		LDX #8
		JSR CLEARSCREEN
		LDA #1
		TAY
		JSR $FFBA
		LDA #8			; contains the file name length
		JMP @LOADHERE3

;********************************************************************

SAVEGAME:
		LDA #<(DISKORTAPE)
		LDY #>(DISKORTAPE)
		JSR PRINTTEXTSECTION
		JSR GETKEY
		LDX #8
		CMP #68
		BEQ @SAVEDISK
		CMP #84
		BEQ @SAVETAPE
@EXITSAVE:
		RTS
@SAVETAPE:
		JSR TURNOFFVOLUME
		LDX #1			; floppy (device 8)
		JMP @SAVEHERE2
@SAVEHERE:
		JSR TURNOFFVOLUME
@SAVEHERE2:
		JSR CLEARSCREEN
		STX TEMP4

		LDA #1  		; logical file number 1
		TAY			; ditto secondary address (not too important)
		JSR $FFBA		; set up file

		LDA TEMP4
		CMP #1
		BEQ @SAVETAPE2

		LDA #11			; contains the file name length
		LDY #>(SAVENAME)	; file name high byte
		LDX #<(SAVENAME)	; file name low byte
		JSR $FFBD		; set up file name
		JMP @CONTSAVE

@SAVETAPE2:
		LDA #7			; contains the file name length
		LDY #>(LOADNAME)	; file name high byte
		LDX #<(LOADNAME)	; file name low byte
		JSR $FFBD		; set up file name

@CONTSAVE:
		LDA #<(PNAMELOC)
		STA 251
		LDA #>(PNAMELOC)
		STA 252

		LDA #251		; get a pointer to start address
		LDX #<(END_PARTY)	; start address low byte
		LDY #>(END_PARTY)	; end address high byte
		JSR $FFD8 		; save RAM to device 8

		LDA #1			; logical file 1
		JSR $FFC3		; close file
		LDA WHICHSONG
		JSR PLAYMUSIC
		JSR TURNONVOLUME
		JMP PREPARE2

@SAVEDISK:
		JSR SELECTSLOT
		BMI @EXITSAVE
		CLC
		ADC #49
		STA LOADNAME+7
		LDX #8
		JMP @SAVEHERE

;********************************************************************

SAVENAME:
	.byte "@0:"
LOADNAME:
	.byte "RQ3SAVE "

SELECTSLOT:
		LDA #<(@FILESLOT)
		LDY #>(@FILESLOT)
		JSR PRINTTEXTSECTION
		LDX #9
		JMP GETNUMBERKEY

@FILESLOT:
	.byte 13,"     SLOT ? (1-9)",0

;********************************************************************

DISKORTAPE:
	; disk or tape
	.byte 13,"     ",18,"D",146,"ISK OR ",18,"T",146,"APE",0

;********************************************************************

VIEWCHAR:
		LDA #2
		STA VIEWITEMCOUNT	; to show how many items can be dropped, 0=weapon, 1=shield
		LDA #0			; which items can be dropped?
		STA VIEWSHIELD
		STA VIEWITEM
		STA VIEWPOTION
		STA VIEWPOINTER
		
		JSR ISCHAREMPTY
		BNE @VC1
		RTS
@VC1:
		JSR HIDESCREEN
		JSR CLEARSCREEN

		;print name
		LDY PNAMEHI
		LDA PNAMELO
		JSR PRINTSTRING_K

		JSR REVERSETOPLINE

		;print sex
		JSR PRINTRETURN
		LDY #34
		LDA (PCHARLO),Y
		LDY #>(TEXTSEX)
		LDX #<(TEXTSEX)
		JSR PRINTSTRING
		;print race
		;LDA #<(TEXTRACE2)
		;LDY #>(TEXTRACE2)
		;JSR PRINTSTRING_K
		LDY #0
		LDA (PCHARLO),Y
		LDY #>(TEXTRACE)
		LDX #<(TEXTRACE)
		JSR PRINTSTRING

		;print level
		JSR PRINTRETURN
		LDA #<(TEXTLEVEL)
		LDY #>(TEXTLEVEL)
		JSR PRINTSTRING_K
		LDY #2
		LDA (PCHARLO),Y
		JSR PRINTBYTE

		;print class
		JSR PRINTSPACE
		LDY #1
		LDA (PCHARLO),Y
		LDY #>(TEXTCLASS)
		LDX #<(TEXTCLASS)
		JSR PRINTSTRING

		;print experience points
		JSR PRINTRETURN
		LDA #<(TEXTEXP)
		LDY #>(TEXTEXP)
		JSR PRINTSTRING_K
		JSR POINTERXP
		JSR MEM_AY2FAC
		JSR PRINTFAC_K
		JSR PRINTRETURN

		;print attributes
		LDA #0
		STA TEMP2
@PRINTATTS1:
		JSR PRINTRETURN
		LDA TEMP2
		LDY #>(TEXTSTAT)
		LDX #<(TEXTSTAT)
		JSR PRINTSTRING
		LDA #13
		STA 211
		LDA TEMP2
		CLC
		ADC #3
		TAY
		JSR PRINTBYTE
		INC TEMP2
		LDA TEMP2
		CMP #6
		BNE @PRINTATTS1

		; print hit points
		JSR PRINTRETURN
		JSR PRINTRETURN
		LDA #<(TEXTHP)
		LDY #>(TEXTHP)
		JSR PRINTSTRING_K
		LDY #16
		JSR PRINTBYTES2
		LDA #47
		JSR PRINTCHAR_K
		LDY #18
		JSR PRINTBYTES2

		; print spell units if class can cast spells
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_SU,X
		STA TEMP3			; spell user flag for view item menu
		CMP #0
		BEQ @PRINTSU1
		LDA #1
		STA TEMP3			; set spell user flag to 1
		JSR PRINTRETURN
		LDA #<(TEXTSU)
		LDY #>(TEXTSU)
		JSR PRINTSTRING_K
		LDY #20
		JSR PRINTBYTES2
		LDA #47
		JSR PRINTCHAR_K
		LDY #22
		JSR PRINTBYTES2
@PRINTSU1:
;		LDY #15
;		LDX #0
;		JSR MOVECURSOR
		; print weapon
		JSR PRINTRETURN
		JSR PRINTRETURN
		LDY #23
		LDA (PCHARLO),Y
		LDY #>(TEXTWEAPON)
		LDX #<(TEXTWEAPON)
		JSR PRINTSTRING
		LDY #24
		LDA (PCHARLO),Y
		CMP #0
		BEQ @PRINTWEA1
		LDA #43
		JSR PRINTCHAR_K
		LDY #24
		JSR PRINTBYTE
@PRINTWEA1:
		; print armor
		JSR PRINTRETURN
		LDY #25
		LDA (PCHARLO),Y
		LDY #>(TEXTARMOR)
		LDX #<(TEXTARMOR)
		JSR PRINTSTRING
		LDY #26
		LDA (PCHARLO),Y
		CMP #0
		BEQ @PRINTARM1
		LDA #43
		JSR PRINTCHAR_K
		LDY #26
		JSR PRINTBYTE
@PRINTARM1:
		; print shield (if the char has it of course)
		LDY #27
		LDA (PCHARLO),Y
		CMP #0
		BEQ @PRINTSHI1

		INC VIEWITEMCOUNT
		INC VIEWSHIELD

		JSR PRINTRETURN
		LDY #27
		LDA (PCHARLO),Y
		LDY #>(TEXTSHIELD)
		LDX #<(TEXTSHIELD)
		JSR PRINTSTRING
		LDY #28
		LDA (PCHARLO),Y
		CMP #0
		BEQ @PRINTSHI1
		LDA #43
		JSR PRINTCHAR_K
		LDY #28
		JSR PRINTBYTE
@PRINTSHI1:	
		; print magic item (if applicable)
		LDY #29
		LDA (PCHARLO),Y
		STA TEMP2
		CMP #0
		BEQ @PRINTMAG1

		INC VIEWITEMCOUNT
		INC VIEWITEM

		JSR PRINTRETURN
		LDA TEMP2
		LDY #>(TEXTITEM)
		LDX #<(TEXTITEM)
		JSR PRINTSTRING
		LDX TEMP2
		LDA LIMITITEM,X
		CMP #0
		BEQ @PRINTMAG1
		JSR PRINTPAREN_L
		LDY #30
		JSR PRINTBYTE
		JSR PRINTPAREN_R
@PRINTMAG1:
		; print potion (if applicable)
		LDY #31
		LDA (PCHARLO),Y
		STA TEMP2
		CMP #0
		BEQ @PRINTPOT1

		INC VIEWITEMCOUNT
		INC VIEWPOTION

		JSR PRINTRETURN
		LDA TEMP2
		LDY #>(TEXTPOTION)
		LDX #<(TEXTPOTION)
		JSR PRINTSTRING
		JSR PRINTPAREN_L
		LDY #32
		JSR PRINTBYTE
		JSR PRINTPAREN_R
@PRINTPOT1:

		;print status
		JSR PRINTRETURN
		JSR PRINTRETURN

		LDY #>(TEXTSTATUS)
		LDA #<(TEXTSTATUS)
		JSR PRINTSTRING_K

		JSR GETSTATUS
		LDY #>(TEXTSTATUS2)
		LDX #<(TEXTSTATUS2)
		JSR PRINTSTRING

@PRINTSTATUS:
		JSR COUNTINVENTORY

		LDA #0
		STA TEMP4		; view menu item position

		LDA PMODE
		BNE @COMBATMODE		; can't mode items to inventory when in combat mode

		LDA VIEWPOINTER
		CMP #INVSIZE
		BMI @NOTFULL

		LDY #>(TEXTINVISFULL)
		LDA #<(TEXTINVISFULL)
		JSR PRINTBOTTOM
		JSR GETKEY
		JMP PREPARE2
@COMBATMODE:
		LDY #>(@RETURNTOCOMBAT)
		LDA #<(@RETURNTOCOMBAT)
		JSR PRINTBOTTOM
		JSR GETKEY
		JSR PREPARE2
		JSR SELECTMENUITEM
		JMP TURNMENUOFF
@NOTFULL:
		LDY #>(@VIEWMENU)
		LDA #<(@VIEWMENU)
		JSR PRINTBOTTOM


@MAINVIEWITEM:
		; highlight menu item
		; first unreverse all of the items
		LDX #0
@LOOP1:
		LDA SCREEN+14*22,X
		AND #127
		STA SCREEN+14*22,X
		INX
		CPX #132
		BNE @LOOP1

		; highlight selected menu item
		LDA TEMP4
		CLC
		ADC TEMP3
		TAX
		LDY POSITION,X
		LDX #0
@LOOP2:
		LDA SCREEN+14*22,Y
		ORA #128
		STA SCREEN+14*22,Y
		INY
		INX
		CPX #22
		BNE @LOOP2
		
		JSR SELECTITEM
		CMP #0
		BEQ @MAINVIEWITEM

@KEYMOVE:
		CMP #13		; return key
		BEQ @MOVEWEAPON
		JMP @EXIT
@MOVEWEAPON:
		; drop item to inventory
		LDX VIEWPOINTER
		LDA TEMP4
		CMP #0
		BNE @MOVEARMOR
		; move weapon
		LDA #1
		LDY #23
		JMP @DATAMOVE
@MOVEARMOR:
		CMP #1
		BNE @MOVESHIELD
		; move armor
		LDA #2
		LDY #25
		JMP @DATAMOVE
@MOVESHIELD:
		CMP #2
		BNE @MOVEITEM4
		; what is item #3?
		LDA VIEWSHIELD
		CMP #1
		BNE @MOVEITEM
		; move shield
		LDA #3
		LDY #27
		JMP @DATAMOVE
@MOVEITEM:
		LDA VIEWITEM
		CMP #1
		BNE @MOVEPOTION
		; move item
		LDA #4
		LDY #29
		JMP @DATAMOVE
@MOVEPOTION:
		; move potion
		LDA #5
		LDY #31
		JMP @DATAMOVE
@EXIT:
		JMP PREPARE2
@MOVEITEM4:
		; what is item #4?
		CMP #3
		BNE @MOVEPOTION		; item #5 will always be a potion
		JMP @MOVEITEM		; check item #4
		
@DATAMOVE:
		STA ITEMTYPE,X		
		LDA (PCHARLO),Y
		CMP #0
		BEQ @CANTMOVE
		STA ITEMIS,X
		LDA #0
		STA (PCHARLO),Y
		INY		; second Y value
		LDA (PCHARLO),Y
		STA ITEMBONUS,X
		LDA #0
		STA (PCHARLO),Y

		LDY #>(@ITEMISMOVED)
		LDA #<(@ITEMISMOVED)
@RETURNMOVE:
		JSR PRINTBOTTOM
		JSR PAUSE
		JMP VIEWCHAR
@CANTMOVE:
		LDA #0
		STA ITEMTYPE,X
		LDY #>(@CANTMOVEITEM)
		LDA #<(@CANTMOVEITEM)
		JMP @RETURNMOVE

@VIEWMENU:
	.byte "  RETURN=REMOVE ITEM ",0

@ITEMISMOVED:
	.byte "  MOVED TO INVENTORY ",0

@CANTMOVEITEM:
	.byte "   NOTHING TO MOVE!  ",0

@RETURNTOCOMBAT:
	.byte "    PRESS ANY KEY    ",0

;********************************************************************

TEXTINVISFULL:
	.byte "  INVENTORY IS FULL! ",0

;********************************************************************

PRINTBOTTOM:
		PHA
		TYA
		PHA
		LDX #0
		LDY #22
		JSR MOVECURSOR
		LDA #18
		JSR PRINTCHAR_K
		PLA
		TAY
		PLA		
		JSR PRINTSTRING_K
		LDA #146
		JSR PRINTCHAR_K
		LDA #160
		STA SCREEN+505		; poke reverse space in last screen pos.
		RTS


POSITION:
	.byte 0,22,44,66,88,110,132,154,176,198,220

;********************************************************************

REVERSETOPLINE:

		LDX #0
@VC2:
		LDA SCREEN,X		; reverse the top line
		ORA #128
		STA SCREEN,X
		INX
		CPX #22
		BNE @VC2
		RTS

;********************************************************************

NEWXP1:
		LDY #2
		LDA #0
		JSR INT_YA2FAC		; convert integer 2 to FAC
		JSR STA_FAC2AFAC	; store FAC in AFAC
		LDY #2
		LDA (PCHARLO),Y		; get level
		RTS

NEWXP2:
		LDA #0
		JSR INT_YA2FAC		; convert level to FAC
		JSR POWER_AFAC_FAC	; FAC = 2 ^ level
		JSR MULTIPLY_FAC10
		JMP MULTIPLY_FAC10	; multiply by 100

;********************************************************************

ADDXP:
		; pass a/y pointing to MFLPT to add to XP

		STA XPTEMP1
		STY XPTEMP2

		LDY #>(@YOUGET)
		LDA #<(@YOUGET)
		JSR PRINTTEXTSECTION

		LDA XPTEMP1
		LDY XPTEMP2

		JSR MEM_AY2FAC		; convert a/y to fac
		JSR INT_FAC
		JSR PRINTFAC_K
		LDY #>(@XP)
		LDA #<(@XP)
		JSR PRINTSTRING_K

		LDA XPTEMP1
		LDY XPTEMP2

		JSR MEM_AY2FAC		; convert a/y to fac
		JSR POINTERXP		; point to mflpt a/y
		JSR ADD_FAC_AY		; add fac to ay
		JSR INT_FAC
		JSR POINTERXP
		TAX
		JSR STA_FAC2XY		; store new xp value

@CHECKAGAIN:
		; check to see if the character passed a level

		JSR NEWXP1
		TAY
		JSR NEWXP2		

		JSR POINTERXP
		JSR CMP_FAC2AY		; compare FAC to XP
		BEQ @UPLEVEL
		BPL @EXIT

@UPLEVEL:
		; increase level by 1
		LDY #2
		CLC
		LDA #1
		ADC (PCHARLO),Y
		STA (PCHARLO),Y

		; increase maxhp
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_HP,X
		JSR ROLLDICE1
		JSR ADDMAXHP
		JSR CONBONUS

		; increase maxsu
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_SU,X
		BEQ @EXIT2
		LDY #2
		LDA (PCHARLO),Y
		CMP SPELLSTART,X
		BMI @EXIT2

		LDA SUADVANCE,X
		JSR ADDMAXSU
				

@EXIT2:
		JSR PRINTSINGLECHAR2
		JSR PAUSE
		LDY #>(@GAINLEVEL)
		LDA #<(@GAINLEVEL)
		JSR PRINTTEXTSECTION
		JMP @CHECKAGAIN
@EXIT:
		RTS

@YOUGET:
	.byte 13,"  YOU GET ",0
@XP:
	.byte " XP",0
@GAINLEVEL:
	.byte 13,"   YOU GAIN A LEVEL",0

;********************************************************************

SPELLSTART:
	;BYTE FIGHTER WIZARD CLERIC,THIEF,RANGER,PALADIN,MONK,NECROMANCER
	.byte 0,1,1,0,4,3,0,2
SUADVANCE:
	.byte 0,3,3,0,1,1,0,2

;********************************************************************

CONBONUS:
		LDY #7		; constitution bonus
		LDA (PCHARLO),Y
		TAX
		LDA STATADJUST,X
		JMP ADDMAXHP

;********************************************************************

CONPENALTY:
		LDY #7		; constitution bonus
		LDA (PCHARLO),Y
		TAX
		LDA STATADJUST,X
		JMP SUBMAXHP

;********************************************************************

SUBMAXHP:
		STA MATHTEMP
		LDY #18
		JSR SUBCONT
		DEY
		JSR SUBCONT
		LDY #17
		LDA (PCHARLO),Y
		BMI @ADJUST
		RTS
@ADJUST:
		STA (PCHARLO),Y
		LDA #1
		INY
		STA (PCHARLO),Y
		RTS

;********************************************************************

SUBCONT:
		LDA (PCHARLO),Y
		SEC
		SBC MATHTEMP
		STA (PCHARLO),Y
		DEY
		LDA (PCHARLO),Y
		SBC #0
		STA (PCHARLO),Y
		RTS

;********************************************************************

SUBMAXSU:
		STA MATHTEMP
		LDY #22
		JSR SUBCONT
		DEY
		JMP SUBCONT

;********************************************************************
ADDMAXHP:
		STA MATHTEMP
		LDY #18
		JSR ADDCONT
		DEY
		LDA MATHTEMP
		JMP ADDCONT

;********************************************************************

ADDCONT:
		CLC
		ADC (PCHARLO),Y
		STA (PCHARLO),Y
		DEY
		LDA #0
		ADC (PCHARLO),Y
		STA (PCHARLO),Y
		RTS

;********************************************************************

ADDMAXSU:
		STA MATHTEMP
		LDY #22
		JSR ADDCONT
		DEY
		LDA MATHTEMP
		JMP ADDCONT

;********************************************************************

CASHIN:
		JSR ISCHARMOBILE
		BNE @C1
		JMP CHARISIMMOBILE
@C1:
		LDA #<(@CASHMENU)
		LDY #>(@CASHMENU)
		JSR GETYESKEY
		BEQ @C2
		RTS
@C2:
		JSR MONEYPTR2		; move gold pointer to a/y
		JSR ADDXP
		JSR PAUSE

		;set party gold to 0
		LDY #0
		LDA #0
		JSR INT_YA2FAC	; convert to FAC
		JSR SETGOLD

		JMP PREPARE2
		

@CASHMENU:
	.byte 13," TRADE IN ALL OF YOUR"
	.byte 13,"  GOLD FOR XP? (Y/N)",0

;********************************************************************

HEALER:
		JSR TEMPLEPIC
		JSR ISCHAREMPTY
		BNE @HL0
		RTS
  @HL0:
		JSR @BUYHEALPTR
		JSR CMP_FAC2AY	; compare FAC to amount of gold pointed to by a/y
		CMP #1		; if cost is less than amount of gold then...
		BMI @HEALMENU
		JMP NOTENOUGHMONEY
  @HEALMENU:
		LDA #<(@HEALERMENU)
		LDY #>(@HEALERMENU)
		JSR GETYESKEY
		BNE @EXIT

		JSR @BUYHEALPTR
		JSR DEDUCTGOLD
		JSR RESURRECT
		JSR PRINTSINGLECHAR2
		JMP THANKYOUEXIT
@EXIT:
		RTS

@BUYHEALPTR:
		LDX TEMP4
		LDY #244
		LDA #1
		JMP MONEYPTR
		
@HEALERMENU:
	.byte 13," A 500GP DONATION FOR"
	.byte 13," COMPLETE HEAL? (Y/N)",0

;********************************************************************

RESURRECT:
		JSR GETSTATUS
		LDA #1
		STA (PCHARLO),Y
		JMP SETMAXHP

;********************************************************************
				

BUYSHIP:
	; determine if the party has enough gold

		JSR DOCKYARDPIC

		JSR @BUYSHIPPTR
		JSR CMP_FAC2AY	; compare FAC to amount of gold pointed to by a/y
		CMP #1		; if cost is less than amount of gold then...
		BMI @BUYSHIP
		JMP NOTENOUGHMONEY
@BUYSHIP:
		LDA #<(@CONFIRM)
		LDY #>(@CONFIRM)
		JSR GETYESKEY
		BEQ @DEDUCTGOLD
		RTS

@DEDUCTGOLD:
		JSR @BUYSHIPPTR
		JSR DEDUCTGOLD

		; set ship coordinates
		LDA #1
		STA HAVESHIP
		STA POS_SHIPCARRY
		LDA #173		; ship's coordinates will be just below the castle
		STA POS_SHIPLO
		LDA #5
		STA POS_SHIPHI

		JMP THANKYOUEXIT

@BUYSHIPPTR:
		LDY #64
		LDA #31		; lo/hi of 64/31 = 8000
		JMP MONEYPTR
	
@CONFIRM:
	.byte 13,"  SHIP COSTS 8000 GP"
	.byte 13,"  WILL YOU BUY?(Y/N)",0



;********************************************************************

NOTENOUGHMONEY:

		JSR STA_FAC_XPTEMP3

		LDA #<(NOTENOUGHTEXT)
		LDY #>(NOTENOUGHTEXT)
		JSR PRINTTEXTSECTION

		LDA #<(YOUNEED)
		LDY #>(YOUNEED)
		JSR PRINTSTRING_K

		JSR LDAY_XPTEMP3
		JSR MEM_AY2FAC
		JSR PRINTFAC_K

		LDA #<(GEEPEE)
		LDY #>(GEEPEE)
		JSR PRINTSTRING_K
		JMP GETKEY

NOTENOUGHTEXT:
	.byte 13
NOTENOUGHTEXT2:
	.byte "   NOT ENOUGH FUNDS  ",0
YOUNEED:
	.byte 13,"   YOU NEED ",0
GEEPEE:
	.byte " GP",0


;********************************************************************

THANKYOUEXIT:
		LDA #<(THANKYOU)
		LDY #>(THANKYOU)
		JSR PRINTTEXTSECTION
		JMP PAUSE

THANKYOU:
	.byte 13
THANKYOU2:
	.byte "      THANK YOU!     ",0

;********************************************************************

MONEYPTR:
		JSR INT_YA2FAC	; store y/a into FAC
MONEYPTR2:
		LDA #<(GOLD)
		LDY #>(GOLD)
		RTS

;********************************************************************

POINTERXP:
		JSR PREPARECHARPOINTER
		LDA PCHARLO
		CLC
		ADC #9
		LDY PCHARHI
		BCC @EXIT
		INY
@EXIT:
		RTS

;********************************************************************
DEDUCTGOLD:
		JSR SUB_AY_FAC
SETGOLD:
		JSR INT_FAC	; round down any decimal outliers
		LDX #<(GOLD)
		LDY #>(GOLD)
		JMP STA_FAC2XY	; store new FAC at gold

;********************************************************************

TRADINGPOST:
		JSR BOLZAIMPIC
		LDA #<(@WELCOME)
		LDY #>(@WELCOME)
		JSR PRINTTEXTSECTION
		JSR GETKEY
		CMP #66
		BEQ @BUY
		CMP #83
		BEQ @SELL
		RTS

@BUY:		JMP BUYWEAPON
@SELL:		JMP SELLWEAPON

@WELCOME:
	.byte 13," BOLZAIM TRADING POST"
	.byte 13," WILL YOU ",18,"B",146,"UY OR ",18,"S",146,"ELL",0

;********************************************************************

COSTWEAPON:
	; low byte
	.byte 0			; no weapon
	.byte 10		; dagger
	.byte 30		; staff
	.byte 20		; mace
	.byte 40		; flail
	.byte 60		; short sword
	.byte 100		; long sword
	.byte 150		; battle axe
	.byte 200		; two-handed sword
	.byte 50		; sling
	.byte 150		; bow
	.byte 250		; crossbow
	.byte 50		; 100 arrows
	.byte 100		; 100 bullets
COSTSHIELD:
	.byte 250		; shield

COSTARMOR:
	; low byte, high byte
	.byte 0			; no armor
	.byte 50		; robe  -- wizard's only 'armor' -- why it's more expensive than leather
	.byte 100		; leather
	.byte 150		; studded leather
	.byte 200		; ring mail
	.byte 144		; chain mail (400)
	.byte 232		; plate mail (1000)
	.byte 160		; elfin chain (4000)
	.byte 0,0,0,0,0,1,3,15

;********************************************************************

SELLWEAPON:
		JSR ISCHAREMPTY
		BNE @IV1
		RTS
@IV1:
		LDY #>(@SELLINGINV)
		LDA #<(@SELLINGINV)
		JSR INV1

@MAININVENTORYMENU:
		LDY #>(@SELLMENU)
		LDA #<(@SELLMENU)
		JSR INV2
		BEQ @SELECTITEM
		RTS

@SELECTITEM:
		JSR INV3
		CMP #13		; return key
		BEQ @OFFERTOSELL
		JMP PREPARE2

@OFFERTOSELL:
		LDX TEMP4
		LDA ITEMTYPE,X
		STA TEMP3

		CMP #1		; weapon
		BEQ @WEAPON
		CMP #2		; armor
		BEQ @ARMOR
		CMP #3		; shield
		BEQ @SHIELD
		CMP #4		; item
		BEQ @ITEM

		; potions sell for 100 GP each

		LDY #100
		LDA #0
		JMP @OFFER2

@WEAPON:
		LDY ITEMIS,X
		LDA COSTWEAPON,Y
		CLC
		ROR
		TAY
		LDA #0
		JMP @OFFER2

@ARMOR:
		LDY ITEMIS,X
		LDX COSTARMOR+8,Y
		LDA COSTARMOR,Y
		CLC
		ROR
		TAY
		TXA
		CLC
		ROR
		JMP @OFFER2
@SHIELD:
		LDY #125
		LDA #0
		JMP @OFFER2

@ITEM:
		; magic items sell for 500GP each
		LDY #244
		LDA #1

@OFFER2:
		JSR INT_YA2FAC
		JSR STA_FAC_XPTEMP3

		LDY #>(@SELLFOR)
		LDA #<(@SELLFOR)
		JSR PRINTBOTTOM

		LDA #18
		JSR PRINTCHAR_K

		JSR LDAY_XPTEMP3
		JSR MEM_AY2FAC
		JSR PRINTFAC_K

		LDA #146
		JSR PRINTCHAR_K

		JSR GETKEY
		CMP #89
		BEQ @SELLFINALLY

		LDY #>(@SELLMENU)
		LDA #<(@SELLMENU)
		JSR PRINTBOTTOM
		JMP @SELECTITEM

@SELLFINALLY:

		JSR LDAY_XPTEMP3
		JSR MEM_AY2FAC
		JSR MONEYPTR2
		JSR ADD_FAC_AY
		JSR SETGOLD

		JSR SHIFTDATA
		LDY #>(THANKYOU2)
		LDA #<(THANKYOU2)
		JSR PRINTBOTTOM
		JSR PAUSE
		JMP @IV1

@SELLINGINV:
	.byte 13,"SELLING INVENTORY",13,13,0

@SELLMENU:
	.byte "   RETURN=SELL ITEM  ",0

@SELLFOR:
	.byte "  Y=TO SELL FOR      ",157,157,157,157,157,0


;********************************************************************


BUYWEAPON:
		LDA #0
		STA TEMP4
@COMEBACK:
		JSR PREPARECHARPOINTER
		JSR HIDESCREEN
		JSR CLEARSCREEN
		JSR PRINTGOLD

		JSR REVERSETOPLINE

		LDA #1
		STA TEMP1

		LDA #21
		STA VIEWITEMCOUNT
@BW1:
		JSR PRINTRETURN
		LDA TEMP1
		LDY #>(TEXTWEAPON)
		LDX #<(TEXTWEAPON)
		JSR PRINTSTRING

		JSR @POSITION17
		LDY TEMP1
		LDA #0
		LDX COSTWEAPON,Y
		JSR PRINTINT_XA

		INC TEMP1
		LDA TEMP1
		CMP #15
		BNE @BW1
		
		LDA #1
		STA TEMP1
@BW2:
		JSR PRINTRETURN
		LDA TEMP1
		LDY #>(TEXTARMOR)
		LDX #<(TEXTARMOR)
		JSR PRINTSTRING

		JSR @POSITION17
		LDY TEMP1
		LDX COSTARMOR,Y
		LDA COSTARMOR+8,Y
		JSR PRINTINT_XA

		INC TEMP1
		LDA TEMP1
		CMP #8
		BNE @BW2

@PLEASESELECT:
		LDY #>(@TEXTSELECT)
		LDA #<(@TEXTSELECT)
		JSR PRINTBOTTOM

@SELECTITEM:
		; highlight item
		; first unreverse all of the items
		LDX #0
@LOOP1:
		LDA SCREEN+1*22,X
		AND #127
		STA SCREEN+1*22,X
		LDA SCREEN+1*22+231,X
		AND #127
		STA SCREEN+1*22+231,X
		INX
		CPX #231
		BNE @LOOP1

		; highlight selected menu item
		LDA TEMP4
		CMP #11
		BMI @LOOP1_1
		CLC
		SBC #10
@LOOP1_1:
		TAX
		LDY POSITION,X
		LDX #0
@LOOP2:
		LDA TEMP4
		CMP #11
		BPL @LOOP3
		LDA SCREEN+1*22,Y
		ORA #128
		STA SCREEN+1*22,Y
		JMP @LOOP4
@LOOP3:
		LDA SCREEN+12*22,Y
		ORA #128
		STA SCREEN+12*22,Y
@LOOP4:
		INY
		INX
		CPX #22
		BNE @LOOP2

		JSR SELECTITEM
		CMP #0
		BEQ @SELECTITEM
		CMP #13
		BEQ @BUYWEAPON2
@EXIT:
		JMP PREPARE2
		RTS

@BUYWEAPON2:
		LDA TEMP4
		STA TEMP3
		CMP #14
		BMI @BUYWEAPON3
		CLC
		SBC #12
		STA TEMP3	; temp3 = temp4 - 13

		JSR @PREPARMORPTR
		JSR CMP_FAC2AY	; compare FAC to amount of gold

		CMP #1
		BMI @CHECKINV2
		JMP @NOTENOUGH
@CHECKINV2:
		JSR COUNTINVENTORY
		LDA VIEWPOINTER
		CMP #INVSIZE
		BMI @DEDUCTCOSTARMOR
		JMP @INVENTORYISFULL
@DEDUCTCOSTARMOR:
		; deduct gold
		JSR @PREPARMORPTR
		JSR SUB_AY_FAC
		LDA #2
		JMP @DEDUCT2

@BUYWEAPON3:
		INC TEMP3	; temp3 = temp4 + 1
		JSR @PREPWEAPONPTR
		JSR CMP_FAC2AY	; compare FAC to amount of gold pointed to by a/y

		CMP #1		; if cost is greater than amount of gold then...
		BMI @CHECKINV
		JMP @NOTENOUGH

@CHECKINV:
		LDA TEMP3

		CMP #12
		BEQ @CHECKARROWS
		CMP #13
		BEQ @CHECKBULLETS

		; check to see there is enough room in inventory if buying a melee weapon
		JSR COUNTINVENTORY
		LDA VIEWPOINTER
		CMP #INVSIZE
		BMI @DEDUCTCOSTWEAPON
@INVENTORYISFULL:
		LDY #>(TEXTINVISFULL)
		LDA #<(TEXTINVISFULL)
		JMP @GOBACKSELECT

@CHECKARROWS:
		LDA #<(ARROWS)
		STA 1
		LDA #>(ARROWS)
		JMP @CHECKAMMO
@CHECKBULLETS:
		LDA #<(BULLETS)
		STA 1
		LDA #>(BULLETS)
@CHECKAMMO:
		STA 2

		LDY #1
		LDA (1),Y
		CMP #3
		BMI @ADDAMMO
		BEQ @CHECKAMMOLO
		BPL @INVENTORYISFULL
@CHECKAMMOLO:
		DEY
		LDA (1),Y
		CMP #133	; less than 901 unites of ammo?
		BMI @ADDAMMO
		BPL @INVENTORYISFULL
@ADDAMMO:
		LDY #0
		LDA #100
		CLC
		ADC (1),Y
		STA (1),Y
		LDA #0
		LDY #1
		ADC (1),Y
		STA (1),Y

@DEDUCTCOSTWEAPON:
		; deduct gold
		JSR @PREPWEAPONPTR
		JSR SUB_AY_FAC
		LDA TEMP4
		CMP #13
		BNE @TYPEWEAPON
		LDA #1
		STA TEMP3	; set typeis to shield
		LDA #3
		JMP @DEDUCT2
@TYPEWEAPON:
		LDA #1
@DEDUCT2:
		STA TEMP2
		JSR SETGOLD

		LDA TEMP3
		CMP #12
		BPL @MESSAGEBUY

		LDX VIEWPOINTER
		LDA TEMP2
		STA ITEMTYPE,X
		LDA TEMP3
		STA ITEMIS,X
@MESSAGEBUY:
		LDY #>(THANKYOU2)
		LDA #<(THANKYOU2)
@GOBACKBUYWEAPON:
		JSR PRINTBOTTOM
		JSR PAUSE
		JMP @COMEBACK

@NOTENOUGH:
		LDY #>(NOTENOUGHTEXT2)
		LDA #<(NOTENOUGHTEXT2)
@GOBACKSELECT:
		JSR PRINTBOTTOM
		JSR PAUSE
		JMP @PLEASESELECT

@PREPWEAPONPTR:
		LDX TEMP3
		LDY COSTWEAPON,X
		LDA #0
@PREP2:
		JMP MONEYPTR	; get the cost of the weapon/armor and store it in the FAC

@PREPARMORPTR:
		LDX TEMP3
		LDY COSTARMOR,X
		LDA COSTARMOR+8,X
		JMP @PREP2

@TEXTSELECT:
	.byte "   RETURN=BUY ITEM   ",0

@POSITION17:
		LDA #17
		STA 211
		RTS

;********************************************************************

PRINTGOLD:
		LDY #>(TEXTGOLD)
		LDA #<(TEXTGOLD)
		JSR PRINTSTRING_K
PRINTGOLD2:
		LDA #<(GOLD)
		LDY #>(GOLD)
		JSR MEM_AY2FAC
		JMP PRINTFAC_K

TEXTGOLD:
		.byte    "GOLD:    ",0

;********************************************************************

INV1:
		PHA
		TYA
		PHA

		JSR HIDESCREEN
		JSR CLEARSCREEN

		LDY PNAMEHI
		LDA PNAMELO
		JSR PRINTSTRING_K

		JSR REVERSETOPLINE

		PLA
		TAY
		PLA
		JSR PRINTSTRING_K

		JSR PRINTGOLD

		LDY #>(@TEXTARROWS)
		LDA #<(@TEXTARROWS)
		JSR PRINTSTRING_K
		LDX ARROWS
		LDA ARROWS+1
		JSR PRINTINT_XA

		LDY #>(@TEXTBULLETS)
		LDA #<(@TEXTBULLETS)
		JSR PRINTSTRING_K
		LDX BULLETS
		LDA BULLETS+1
		JSR PRINTINT_XA

		; orbs of power
		LDY #>(@TEXTORBS)
		LDA #<(@TEXTORBS)
		JSR PRINTSTRING_K

		JSR COUNTORBS

		JSR PRINTINT_XA

		LDA QUESTITERATION
		BEQ @QI

		LDA #47
		JSR PRINTCHAR_K
		LDX QUESTITERATION
		LDA #0
		JSR PRINTINT_XA
@QI:
		JSR PRINTRETURN

		LDA #0
		STA TEMP2
@IV2:
		LDX TEMP2
		JSR PRINTRETURN
		LDA ITEMTYPE,X
		CMP #0
		BEQ @EXIT

		LDA ITEMIS,X
		STA TEMP3
		LDA ITEMTYPE,X
		TAX
		DEX
		STX TEMP4
		LDY @INVITEMTEXTHI,X 
		LDA @INVITEMTEXTLO,X 
		TAX
		LDA TEMP3
		JSR PRINTSTRING
		LDX TEMP2
		LDA ITEMBONUS,X
		CMP #0
		BEQ @IV3
		LDX TEMP4
		LDA @TEXTBONUS1,X
		JSR PRINTCHAR_K
		LDX TEMP2
		LDA ITEMBONUS,X
		TAX
		LDA #0
		JSR PRINTINT_XA
		LDX TEMP4
		LDA @TEXTBONUS2,X
		JSR PRINTCHAR_K
		;JSR SHOWSCREEN		; for testing
@IV3:
		INC TEMP2
		LDA TEMP2
		CMP #INVSIZE
		BNE @IV2

		;number of items = temp2
@EXIT:

		RTS

@TEXTBONUS1:
		.byte "+++(("
@TEXTBONUS2:
		.byte 0,0,0,"))"

@INVITEMTEXTLO:
		.byte <(TEXTWEAPON)
		.byte <(TEXTARMOR)
		.byte <(TEXTSHIELD)
		.byte <(TEXTITEM)
		.byte <(TEXTPOTION)

@INVITEMTEXTHI:
		.byte >(TEXTWEAPON)
		.byte >(TEXTARMOR)
		.byte >(TEXTSHIELD)
		.byte >(TEXTITEM)
		.byte >(TEXTPOTION)

@TEXTORBS:
	.byte 13,13,"ORBS OF POWER: ",0

@TEXTARROWS:
		.byte 13,"ARROWS:  ",0
@TEXTBULLETS:
		.byte 13,"BULLETS: ",0

;********************************************************************

INV2:

		PHA
		TYA
		PHA

		LDA #0
		STA TEMP4
		LDA TEMP2
		STA VIEWITEMCOUNT
		CMP #0
		BEQ @EXITEMPTY		; at least 1 item?

		PLA
		TAY
		PLA
		JSR PRINTBOTTOM
		JMP @EXIT

@EXITEMPTY:
		PLA
		PLA
		LDY #>(@VIEWEMPTY)
		LDA #<(@VIEWEMPTY)
		JSR PRINTBOTTOM
		JSR GETKEY
		JSR PREPARE2
		LDA #1
		RTS
@EXIT:
		LDA #0
		RTS

@VIEWEMPTY:
	.byte "  INVENTORY IS EMPTY ",0

;********************************************************************

INV3:
		; highlight item
		; first unreverse all of the items
		LDX #0
@LOOP1:
		LDA SCREEN+9*22,X
		AND #127
		STA SCREEN+9*22,X
		INX
		CPX #INVSIZE*22
		BNE @LOOP1

		; highlight selected menu item
		LDA TEMP4
		TAX
		LDY POSITION,X
		LDX #0
@LOOP2:
		LDA SCREEN+9*22,Y
		ORA #128
		STA SCREEN+9*22,Y
		INY
		INX
		CPX #22
		BNE @LOOP2

		JSR SELECTITEM
		CMP #0
		BEQ INV3
		RTS

;********************************************************************

SHIFTDATA:
		LDX TEMP4		; item is equipped, just shifting inv data
		CPX #9
		BEQ @INVSHIFT2
@INVSHIFT1:
		LDA ITEMTYPE+1,X
		STA ITEMTYPE,X
		LDA ITEMIS+1,X
		STA ITEMIS,X
		LDA ITEMBONUS+1,X
		STA ITEMBONUS,X
		INX
		CPX #INVSIZE-1
		BNE @INVSHIFT1
@INVSHIFT2:
		LDA #0
		STA ITEMTYPE,X
		STA ITEMIS,X
		STA ITEMBONUS,X
		RTS

;********************************************************************

INVENTORY:
		JSR ISCHAREMPTY
		BNE @IV1
		RTS
@IV1:
		LDY #>(@VIEWINGINV)
		LDA #<(@VIEWINGINV)
		JSR INV1

@MAININVENTORYMENU:
		LDY #>(@VIEWMENU)
		LDA #<(@VIEWMENU)
		JSR INV2
		BEQ @SELECTITEM
		RTS

@SELECTITEM:
		JSR INV3

		CMP #13		; return key
		BEQ @EQUIPITEM
		CMP #20		; delete key
		BEQ @DELETEITEM
		JMP PREPARE2
@DELETEITEM:
		JSR SHIFTDATA
		LDY #>(@ITEMISREMOVED)
		LDA #<(@ITEMISREMOVED)
		JMP @GOBACK
@EQUIPITEM:
		JSR PREPARECHARPOINTER
		LDX TEMP4
		LDA ITEMTYPE,X
		STA TEMP3
		CLC
		ROL
		ADC #21
		STA TEMP1
		TAY
		LDA (PCHARLO),Y
		CMP #0			; is the item slot empty?
		BEQ @EQUIP2
		JMP @CANTEQUIP
@EQUIP2:
		;if equipping two handed weapon, check for shield
		CPY #23
		BNE @EQUIP3
		LDA ITEMIS,X
		TAX
		LDA HANDSWEAPON,X
		CMP #0
		BEQ @EQUIP4
		INY
		INY
		INY
		INY
		LDA (PCHARLO),Y
		CMP #0
		BNE @CANTEQUIPJUMP
		JMP @EQUIP4
@CANTEQUIPJUMP:
		JMP @CANTEQUIP
@EQUIP3:
		;if equipping shield, check for two-handed weapon
		CPY #27
		BNE @EQUIP4
		DEY
		DEY
		DEY
		DEY
		LDA (PCHARLO),Y
		TAX
		LDA HANDSWEAPON,X
		CMP #0
		BNE @CANTEQUIPJUMP

@EQUIP4:
		DEC TEMP3
		LDX TEMP3
		LDA @CHECKRACELO,X	; verify race item restrictions
		STA 1
		LDA @CHECKRACEHI,X
		STA 2
		LDA @CHECKCLASSLO,X	; verify class item restrictions
		STA 3
		LDA @CHECKCLASSHI,X
		STA 4

		LDY #0
		LDA (PCHARLO),Y	
		TAX			; x = race
		LDY TEMP4		; y = item number
		LDA ITEMIS,Y
		TAY			; y = what the item is
		LDA RACECHECK,X		; a = bit code of race
		AND (1),Y
		CMP #0
		BEQ @CANTEQUIP		; failed race check

		LDY #1
		LDA (PCHARLO),Y
		TAX			; x = class
		LDY TEMP4		; y = item number
		LDA ITEMIS,Y
		TAY			; y = what the item is
		LDA CLASSCHECK,X	; a = bit code of class
		AND (3),Y
		CMP #0
		BEQ @CANTEQUIP		; failed class check


		LDX TEMP4
		LDA ITEMIS,X
		LDY TEMP1
		STA (PCHARLO),Y
		INY
		LDA ITEMBONUS,X
		STA (PCHARLO),Y

		JSR SHIFTDATA		; item is equipped, just shift the data

		LDY #>(@ITEMISEQUIPPED)
		LDA #<(@ITEMISEQUIPPED)
		JMP @GOBACK

@CANTEQUIP:
		LDY #>(@CANTEQUIPITEM)
		LDA #<(@CANTEQUIPITEM)
@GOBACK:
		JSR PRINTBOTTOM
		JSR PAUSE
		JMP INVENTORY

@VIEWINGINV:
		.byte 13,"VIEWING INVENTORY",13,13,0

@CHECKRACELO:
		.byte <(RACEWEAPON)
		.byte <(RACEARMOR)
		.byte <(RACEALL)
		.byte <(RACEALL)
		.byte <(RACEALL)

@CHECKRACEHI:
		.byte >(RACEWEAPON)
		.byte >(RACEARMOR)
		.byte >(RACEALL)
		.byte >(RACEALL)
		.byte >(RACEALL)

@CHECKCLASSLO:
		.byte <(CLASSWEAPON)
		.byte <(CLASSARMOR)
		.byte <(CLASS_SHIELD)
		.byte <(CLASSITEM)
		.byte <(CLASSALL)

@CHECKCLASSHI:
		.byte >(CLASSWEAPON)
		.byte >(CLASSARMOR)
		.byte >(CLASS_SHIELD)
		.byte >(CLASSITEM)
		.byte >(CLASSALL)

@VIEWMENU:
	.byte " RET=EQUIP   DEL=DROP",0

@ITEMISEQUIPPED:
	.byte "   ITEM IS EQUIPPED  ",0

@CANTEQUIPITEM:
	.byte "   CAN'T EQUIP ITEM  ",0

@ITEMISREMOVED:
	.byte "  YOU DROP THE ITEM! ",0

;********************************************************************

COUNTORBS:

		LDY #7
		LDX #0
		LDA ORBS
		STA MATHTEMP
@CORBS1:
		LDA MATHTEMP
		AND #1
		BEQ @CORBS2
		INX
@CORBS2:
		CLC
		ROR MATHTEMP
		DEY
		BPL @CORBS1
		LDA #0
		RTS

;********************************************************************

SELECTITEM:
		JSR GETKEY
		STA TEMP1
		CMP #17
		BNE @KEYDOWN
@MOVECURSORDOWN:
		; key down
		INC TEMP4
		LDA TEMP4
		CMP VIEWITEMCOUNT
		BMI @CURSORMOVE
		LDA #0
		STA TEMP4
		JMP @CURSORMOVE
@KEYDOWN:
		CMP #145
		BNE @KEYLEFT
@MOVECURSORUP:
		;key up
		DEC TEMP4
		LDA TEMP4
		CMP #0
		BPL @CURSORMOVE
		LDA VIEWITEMCOUNT
		STA TEMP4
		DEC TEMP4
		JMP @CURSORMOVE
@KEYLEFT:
		CMP #157
		BNE @KEYRIGHT
		JMP @MOVECURSORUP
@KEYRIGHT:
		CMP #29
		BNE @GOBACK
		JMP @MOVECURSORDOWN
@GOBACK:
		LDA TEMP1
		RTS
@CURSORMOVE:
		LDA #0
		RTS

;********************************************************************

DELETECHAR:
		JSR ISCHAREMPTY
		BNE @DEL
		RTS
  @DEL:
		LDA #<(TEXTDELSURE)
		LDY #>(TEXTDELSURE)
		JSR GETYESKEY
		BNE @EXIT
		
		LDY #33
		LDA #5
		STA (PCHARLO),Y		;erase char

		LDA PCHAR
		STA TEMP1
		JMP PRINTSINGLECHAR
@EXIT:
		RTS

;********************************************************************

CHANGEORDER:
		LDA #<(@TEXTORDER)
		LDY #>(@TEXTORDER)
		JSR PRINTTEXTSECTION

		LDX #6
		JSR GETNUMBERKEY
		BMI @QUIT
		CMP PCHAR
		BEQ @QUIT

		TAY
		LDX PCHAR   	; x=active, y=selected

		LDA PNAMELOC,X
		STA CO_TEMP
		LDA PNAMELOC,Y
		STA PNAMELOC,X
		LDA CO_TEMP
		STA PNAMELOC,Y

		LDA PCHARLOC,X
		STA CO_TEMP
		LDA PCHARLOC,Y
		STA PCHARLOC,X
		LDA CO_TEMP
		STA PCHARLOC,Y

		LDA PNAMELOCHI,X
		STA CO_TEMP
		LDA PNAMELOCHI,Y
		STA PNAMELOCHI,X
		LDA CO_TEMP
		STA PNAMELOCHI,Y

		LDA PCHARLOCHI,X
		STA CO_TEMP
		LDA PCHARLOCHI,Y
		STA PCHARLOCHI,X
		LDA CO_TEMP
		STA PCHARLOCHI,Y

		STY PCHAR

		JSR PRINTCHARS
@QUIT:
		RTS

@TEXTORDER:
	.byte 13
	.byte "  PRESS 1-6 TO SELECT",13
	.byte "   THE NEW POSITION",0

;********************************************************************

CREATECHAR:
		JSR GETSTATUS
		CMP #5			; is the character empty?
		BEQ @CC1

		LDA #<(@TEXTISNOTEMPTY)	; player is not empty
		LDY #>(@TEXTISNOTEMPTY)
		JSR PRINTTEXTSECTION
		JMP PAUSE

@CC1:
		;roll the stats
		JSR @DISPLAYCREATE
		JSR PRINTRETURN

		LDA #0
		STA TEMP2
@CC2:
		LDA TEMP2
		LDY #>(TEXTSTAT)
		LDX #<(TEXTSTAT)
		JSR PRINTSTRING
		LDA #13
		STA 211

		LDA TEMP2
		CLC
		ADC #3
		TAY

		JSR ROLLCHAR6
		STA (PCHARLO),Y
		JSR ROLLCHAR6
		CLC
		ADC (PCHARLO),Y
		STA (PCHARLO),Y
		JSR ROLLCHAR6
		CLC
		ADC (PCHARLO),Y
		STA (PCHARLO),Y
		JSR PRINTBYTE
		JSR PRINTRETURN
		INC TEMP2
		LDA TEMP2
		CMP #6
		BNE @CC2

		LDA #<(@TEXTCREATE2)
		LDY #>(@TEXTCREATE2)
		JSR PRINTSTRING_K

		JSR GETKEY
		CMP #ASC_F7		; f7 to reroll character
		BEQ @CC1
		CMP #ASC_F1
		BEQ @CC3
@EXITCREATE:
		JMP PREPARE2

@CC3:
		; offer the option to choose a sex
		JSR @DISPLAYCREATE
		LDA #<(@CHOOSESEX)
		LDY #>(@CHOOSESEX)
		JSR PRINTSTRING_K
		LDX #2
		JSR GETNUMBERKEY
		BMI @EXITCREATE
		LDY #34
		STA (PCHARLO),Y

		; offer the option to choose a race
		JSR @DISPLAYCREATE
		LDA #<(@CHOOSERACE)
		LDY #>(@CHOOSERACE)
		JSR PRINTSTRING_K
		LDA #0
		STA TEMP2
@CC4:
		LDA TEMP2
		CLC
		JSR PRINTCHARNDASH
		LDA TEMP2
		LDY #>(TEXTRACE)
		LDX #<(TEXTRACE)
		JSR PRINTSTRING
		JSR PRINTRETURN
		INC TEMP2
		LDA TEMP2
		CMP #8
		BNE @CC4
		LDX #8
		JSR GETNUMBERKEY
		BMI @EXITCREATE
		LDY #0
		STA (PCHARLO),Y

		; option to choose a class
		JSR @DISPLAYCREATE
		LDA #<(@PICKCLASS)
		LDY #>(@PICKCLASS)
		JSR PRINTSTRING_K
		LDA #0
		STA TEMP2
@CC5:
		LDX TEMP2
		JSR @CHECKRACE
		BNE @CC6

		LDA TEMP2		
		CLC
		JSR PRINTCHARNDASH
		LDA TEMP2
		LDY #>(TEXTCLASS)
		LDX #<(TEXTCLASS)
		JSR PRINTSTRING
		JSR PRINTRETURN
@CC6:
		INC TEMP2
		LDA TEMP2
		CMP #8
		BNE @CC5
@CC7:
		LDX #8
		JSR GETNUMBERKEY
		BPL @CC7_1

		JMP @EXITCREATE
@CC7_1:
		STA TEMP2
		TAX
		JSR @CHECKRACE
		BNE @CC7
		LDA TEMP2
		LDY #1
		STA (PCHARLO),Y

		; make racial and sex adjustments
		LDA #3
		STA TEMP2
		LDY #0
		LDA (PCHARLO),Y
		TAY
		LDA @ADJUSTPOINTER,Y
		STA TEMP3	; race pointer
		LDY #34
		LDA (PCHARLO),Y
		TAY
		LDA @ADJUSTPOINTER,Y
		STA TEMP4	; sex pointer
@CC8:
		; first, we adjust the racial stat adjustment
		LDY TEMP3
		LDA @ADJUSTRACE,Y
		LDY TEMP2
		CLC
		ADC (PCHARLO),Y
		STA (PCHARLO),Y
		; then the sex stat adjustment
		LDY TEMP4
		LDA @ADJUSTSEX,Y
		LDY TEMP2
		CLC
		ADC (PCHARLO),Y
		STA (PCHARLO),Y

		INC TEMP4
		INC TEMP3
		INC TEMP2
		LDA TEMP2
		CMP #9
		BNE @CC8

		; set pointers 9 through 32 to 0
		LDY #9
		LDA #0
@CC9:
		STA (PCHARLO),Y
		INY
		CPY #33
		BNE @CC9

		; set hitpoints
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_HP,X
		JSR ADDMAXHP
		JSR CONBONUS

		; set spell units
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA @START_SU,X
		JSR ADDMAXSU

		; final adjustments and exit
		LDA #1
		LDY #33			; set status to good (1)
		STA (PCHARLO),Y
		LDY #2			; set level to 1
		STA (PCHARLO),Y
		JSR SETMAXSU	; set su and hp to maximum

		JSR PREPARE2
		JMP EDITNAME

@DISPLAYCREATE:
		JSR HIDESCREEN
		LDA #<(@TEXTCREATE1)
		LDY #>(@TEXTCREATE1)
		JSR PRINTSTRING_K
		RTS

@CHECKRACE:
		LDA @RACECLASS,X
		STA TEMP3
		LDY #0
		LDA (PCHARLO),Y
		TAX
		LDA RACECHECK,X
		AND TEMP3
		CMP RACECHECK,X
		RTS

@TEXTISNOTEMPTY:
	.byte 13," CHARACTER NOT EMPTY!",0

@TEXTCREATE1:
	.byte 147,13,"CREATING A CHARACTER",13,13,0

@TEXTCREATE2:
	.byte 13,13," ",ASC_REVON,"F1",ASC_REVOFF," KEEP"
	.byte 13,13," ",ASC_REVON,"F7",ASC_REVOFF," ROLL AGAIN",0

@CHOOSESEX:
	.byte "SEX?",13,13
	.byte "1-MALE",13
	.byte "2-FEMALE",0
	
@CHOOSERACE:
	.byte "RACE?",13,13,0

@PICKCLASS:
	.byte "CLASS?",13,13,0

@RACECLASS:
	;OGRE ORC SPRITE GNOME HOBBIT DWARF ELF HUMAN
	;      OOSGHDEH
	.byte %11111111		; fighter
	.byte %00110011		; wizard
	.byte %00011111		; priest
	.byte %01111111		; thief
	.byte %00000011		; ranger
	.byte %00000001		; paladin
	.byte %11000001		; monk
	.byte %00010011		; necromancer


@ADJUSTPOINTER:
	.byte 0,6,12,18,24,30,36,42

@ADJUSTSEX:
	;     STR,INT,WIS,DEX,CON,CHA
	.byte   2,  0,  0,  0,  0,  0		;male
	.byte   0,  0,  0,  0,  0,  2		;female

@ADJUSTRACE:
	;     STR,INT,WIS,DEX,CON,CHA
	.byte   1,  1,  0,  0,  0,  0		;human
	.byte   0,  1,  0,  1,255,  1		;elf
	.byte   2,  0,  0,255,  2,255		;dwarf
	.byte 255,  0,  1,  2,  0,  0		;hobbit
	.byte 255,  0,  2,  1,  1,255		;gnome
	.byte 254,  2,  0,  3,254,  2		;sprite
	.byte   3,255,255,255,  3,254		;orc
	.byte   4,254,254,254,  4,254		;ogre


@START_SU:
	.byte 0,1,1,0,0,0,0,0

;********************************************************************

EDITNAME:
		JSR ISCHAREMPTY
		BNE @E0
		RTS
@E0:
		LDY #0
		LDA #0
		STY TEMP2
@E1:
		STA (PNAMELO),Y
		INY
		CPY #20
		BNE @E1

		JSR PRINTSINGLECHAR2
		LDA #<(@NAME)
		LDY #>(@NAME)
		JSR PRINTTEXTSECTION
@E2:
		LDA #<(@DISPLAYCURSOR)
		LDY #>(@DISPLAYCURSOR)
		JSR PRINTSTRING_K
@E3:
		JSR GETKEY
		CMP #20
		BNE @E4
		; erase char
		LDA TEMP2
		CMP #0		; can't delete if name is blank
		BEQ @E3
		LDA #<(@ERASECHAR)
		LDY #>(@ERASECHAR)
		JSR PRINTSTRING_K
		DEC TEMP2
		LDY TEMP2
		LDA #0
		STA (PNAMELO),Y
		BEQ @E2
@E4:
		CMP #13
		BNE @E5
		; carriage return -- exit
		LDA TEMP2
		CMP #0		; name not allowed to be blank
		BEQ @E3
		LDA PCHAR
		STA TEMP1
		JMP PRINTSINGLECHAR
@E5:
		CMP #32		; if it a space
		BNE @E6
		LDA TEMP2
		CMP #0		; first char not allowed to be a space
		BEQ @E3
		LDA #32
		BNE @E7
@E6:
		CMP #65		; is it a letter of the alphabet?
		BMI @E3
		CMP #91
		BPL @E3
@E7:
		LDY TEMP2
		CPY #20		; maximum 20 characters!
		BEQ @E3
		STA (PNAMELO),Y	; store the letter or space in name location
		JSR PRINTCHAR_K
		INC TEMP2
		JMP @E2

@NAME:
	.byte 13,"ENTER NAME:",13,0
@DISPLAYCURSOR:
	.byte 18,32,146,157,0
@ERASECHAR:
	.byte 32,157,157,0

;********************************************************************

MONSTERNAME:
	.byte "KOBOLD",0
	.byte "SKELETON",0
	.byte "GNOME",0
	.byte "GIANT MOUSE",0
	.byte "MERMAN",0
	.byte "ORC",0
	.byte "DWARF",0
	.byte "PIRATE",0
	.byte "GIANT RAT",0
	.byte "HOBBIT",0
	.byte "FROST DWARF",0
	.byte "GNOLL",0
	.byte "GIANT BAT",0
	.byte "FIGHTER",0
	.byte "GREEN SLIME",0
	.byte "SPRITE",0
	.byte "ORC CHIEF",0
	.byte "ELF",0
	.byte "OGRE",0
	.byte "DROW ELF",0
	.byte "GIANT SPIDER",0
	.byte "GNOME CHIEF",0
	.byte "MINOTAUR",0
	.byte "MUNCHKIN",0
	.byte "MANTICORE",0
	.byte "MEDUSA",0
	.byte "BUCCANEER",0
	.byte "HARPY",0
	.byte "GHOUL",0
	.byte "ELITE GUARD",0
	.byte "PHANTOM",0
	.byte "TRITON",0
	.byte "TROLL",0
	.byte "MUMMY",0
	.byte "VAMPIRE BAT",0
	.byte "WRAITH",0
	.byte "HILL GIANT",0
	.byte "BASILISK",0
	.byte "SUCCUBUS",0
	.byte "SPECTRE",0
	.byte "QUEEN SPIDER",0
	.byte "NIGHT HAG",0
	.byte "XORN",0
	.byte "LICH",0
	.byte "VAMPIRE",0
	.byte "GHOST KNIGHT",0
	.byte "DEMON KOBOLD",0
	.byte "BLOOD GHOUL",0
	.byte "BEHOLDER",0
	.byte "DARK PUDDING",0
	.byte "SQUID",0
	.byte "CHIMERA",0
	.byte "MUMMY LORD",0
	.byte "ROPER",0
	.byte "DEMON GNOLL",0
	.byte "QUEEN XORN",0
	.byte "DEMONAUR",0
	.byte "FIRE LIZARD",0
	.byte "EVIL EYE",0
	.byte "NESS",0
	.byte "KRAKEN",0
	.byte "STORM GIANT",0
	.byte "GREEN DRAGON",0
	.byte "DEMON",0
	.byte "BLUE DRAGON",0
	.byte "ICE DEMON",0
	.byte "RED DRAGON",0
	.byte "DEMON BRIDE",0
	.byte "NIKAEDOR",0
	.byte "NIKAEDOR JR",0

;********************************************************************

MONSTERPIC:
	.byte 0  ;KOBOLD
	.byte 6  ;SKELETON
	.byte 2  ;GNOME
	.byte 3  ;GIANT MOUSE
	.byte 8  ;MERMAN
	.byte 9  ;ORC
	.byte 5  ;DWARF
	.byte 15  ;BUCCANEER
	.byte 3  ;GIANT RAT
	.byte 1  ;HOBBIT
	.byte 5  ;FROST DWARF
	.byte 11  ;GNOLL
	.byte 23  ;GIANT BAT
	.byte 27  ;FIGHTER
	.byte 7  ;GREEN SLIME
	.byte 4  ;SPRITE
	.byte 9  ;ORC CHIEFTAIN
	.byte 10  ;ELF
	.byte 14  ;OGRE
	.byte 10  ;DROW ELF
	.byte 25  ;GIANT SPIDER
	.byte 2  ;GNOME CHIEFTAIN
	.byte 19  ;MINOTAUR
	.byte 1  ;MUNCHKIN
	.byte 18  ;MANTICORE
	.byte 13  ;MEDUSA
	.byte 15  ;PIRATE CAPTAIN
	.byte 4  ;HARPY
	.byte 12  ;GHOUL
	.byte 27  ;ELITE GUARD
	.byte 26  ;PHANTOM
	.byte 8  ;TRITON
	.byte 20  ;TROLL
	.byte 16  ;MUMMY
	.byte 23  ;VAMPIRE BAT
	.byte 22  ;WRAITH
	.byte 14  ;HILL GIANT
	.byte 17  ;BASILISK
	.byte 33  ;SUCCUBUS
	.byte 22  ;SPECTRE
	.byte 25  ;SPIDER GODDESS
	.byte 13  ;NIGHT HAG
	.byte 21  ;XORN
	.byte 6  ;LICH
	.byte 26  ;VAMPIRE
	.byte 27  ;GHOST KNIGHT
	.byte 0  ;DEMON KOBOLD
	.byte 12  ;BLOOD GHOUL
	.byte 28  ;BEHOLDER
	.byte 7  ;DARK PUDDING
	.byte 24  ;SQUID
	.byte 18  ;CHIMERA
	.byte 16  ;MUMMY LORD
	.byte 29  ;ROPER
	.byte 11  ;DEMON GNOLL
	.byte 21  ;QUEEN XORN
	.byte 19  ;DEMONAUR
	.byte 17  ;FIRE LIZARD
	.byte 28  ;EVIL EYE
	.byte 30  ;NESS
	.byte 24  ;KRAKEN
	.byte 20  ;STORM GIANT
	.byte 32  ;GREEN DRAGON
	.byte 31  ;DEMON
	.byte 32  ;BLUE DRAGON
	.byte 31  ;ICE DEMON
	.byte 32  ;RED DRAGON
	.byte 33  ;DEMON BRIDE
	.byte 34  ;NIKAEDOR
	.byte 34  ;SON OF NIKAEDOR
	.byte 36,37,38			; throne, pool, treasure chest

MONSTERCOLOR:
	.byte 141  ;KOBOLD
	.byte 137  ;SKELETON
	.byte 170  ;GNOME
	.byte 30  ;GIANT MOUSE
	.byte 237  ;MERMAN
	.byte 94  ;ORC
	.byte 170  ;DWARF
	.byte 170  ;BUCCANEER
	.byte 138  ;GIANT RAT
	.byte 170  ;HOBBIT
	.byte 238  ;FROST DWARF
	.byte 250  ;GNOLL
	.byte 154  ;GIANT BAT
	.byte 170  ;FIGHTER
	.byte 221  ;GREEN SLIME
	.byte 173  ;SPRITE
	.byte 221  ;ORC CHIEFTAIN
	.byte 29  ;ELF
	.byte 138  ;OGRE
	.byte 238  ;DROW ELF
	.byte 141  ;GIANT SPIDER
	.byte 172  ;GNOME CHIEFTAIN
	.byte 138  ;MINOTAUR
	.byte 173  ;MUNCHKIN
	.byte 156  ;MANTICORE
	.byte 173  ;MEDUSA
	.byte 174  ;PIRATE CAPTAIN
	.byte 154  ;HARPY
	.byte 187  ;GHOUL
	.byte 174  ;ELITE GUARD
	.byte 75  ;PHANTOM
	.byte 94  ;TRITON
	.byte 186  ;TROLL
	.byte 29  ;MUMMY
	.byte 238  ;VAMPIRE BAT
	.byte 238  ;WRAITH
	.byte 170  ;HILL GIANT
	.byte 94  ;BASILISK
	.byte 170  ;SUCCUBUS
	.byte 221  ;SPECTRE
	.byte 172  ;SPIDER GODDESS
	.byte 238  ;NIGHT HAG
	.byte 154  ;XORN
	.byte 185  ;LICH
	.byte 105  ;VAMPIRE
	.byte 28  ;GHOST KNIGHT
	.byte 106  ;DEMON KOBOLD
	.byte 46  ;BLOOD GHOUL
	.byte 170  ;BEHOLDER
	.byte 107  ;DARK PUDDING
	.byte 221  ;SQUID
	.byte 138  ;CHIMERA
	.byte 26  ;MUMMY LORD
	.byte 218  ;ROPER
	.byte 61  ;DEMON GNOLL
	.byte 170  ;QUEEN XORN
	.byte 238  ;DEMONAUR
	.byte 45  ;FIRE LIZARD
	.byte 235  ;EVIL EYE
	.byte 94  ;NESS
	.byte 238  ;KRAKEN
	.byte 204  ;STORM GIANT
	.byte 221  ;GREEN DRAGON
	.byte 154  ;DEMON
	.byte 238  ;BLUE DRAGON
	.byte 238  ;ICE DEMON
	.byte 170  ;RED DRAGON
	.byte 156  ;DEMON BRIDE
	.byte 156  ;NIKAEDOR
	.byte 157  ;SON OF NIKAEDOR
	.byte 140,142,138		; throne, pool, treasure chest

MONSTERHD:
	.byte 1  ;KOBOLD
	.byte 1  ;SKELETON
	.byte 1  ;GNOME
	.byte 2  ;GIANT MOUSE
	.byte 2  ;MERMAN
	.byte 2  ;ORC
	.byte 2  ;DWARF
	.byte 2  ;BUCCANEER
	.byte 2  ;GIANT RAT
	.byte 1  ;HOBBIT
	.byte 3  ;FROST DWARF
	.byte 3  ;GNOLL
	.byte 3  ;GIANT BAT
	.byte 3  ;FIGHTER
	.byte 2  ;GREEN SLIME
	.byte 1  ;SPRITE
	.byte 4  ;ORC CHIEFTAIN
	.byte 2  ;ELF
	.byte 4  ;OGRE
	.byte 3  ;DROW ELF
	.byte 4  ;GIANT SPIDER
	.byte 5  ;GNOME CHIEFTAIN
	.byte 6  ;MINOTAUR
	.byte 4  ;MUNCHKIN
	.byte 6  ;MANTICORE
	.byte 4  ;MEDUSA
	.byte 6  ;PIRATE CAPTAIN
	.byte 3  ;HARPY
	.byte 3  ;GHOUL
	.byte 6  ;ELITE GUARD
	.byte 6  ;PHANTOM
	.byte 3  ;TRITON
	.byte 6  ;TROLL
	.byte 5  ;MUMMY
	.byte 4  ;VAMPIRE BAT
	.byte 5  ;WRAITH
	.byte 8  ;HILL GIANT
	.byte 6  ;BASILISK
	.byte 6  ;SUCCUBUS
	.byte 7  ;SPECTRE
	.byte 10  ;SPIDER GODDESS
	.byte 8  ;NIGHT HAG
	.byte 7  ;XORN
	.byte 11  ;LICH
	.byte 8  ;VAMPIRE
	.byte 10  ;GHOST KNIGHT
	.byte 10  ;DEMON KOBOLD
	.byte 6  ;BLOOD GHOUL
	.byte 9  ;BEHOLDER
	.byte 10  ;DARK PUDDING
	.byte 12  ;SQUID
	.byte 9  ;CHIMERA
	.byte 9  ;MUMMY LORD
	.byte 12  ;ROPER
	.byte 12  ;DEMON GNOLL
	.byte 13  ;QUEEN XORN
	.byte 12  ;DEMONAUR
	.byte 10  ;FIRE LIZARD
	.byte 12  ;EVIL EYE
	.byte 14  ;NESS
	.byte 16  ;KRAKEN
	.byte 15  ;STORM GIANT
	.byte 14  ;GREEN DRAGON
	.byte 17  ;DEMON
	.byte 16  ;BLUE DRAGON
	.byte 19  ;ICE DEMON
	.byte 18  ;RED DRAGON
	.byte 20  ;DEMON BRIDE
	.byte 25  ;NIKAEDOR
	.byte 30  ;SON OF NIKAEDOR

MONSTERDAM:
	.byte 4  ;KOBOLD
	.byte 4  ;SKELETON
	.byte 5  ;GNOME
	.byte 4  ;GIANT MOUSE
	.byte 4  ;MERMAN
	.byte 5  ;ORC
	.byte 6  ;DWARF
	.byte 7  ;BUCCANEER
	.byte 4  ;GIANT RAT
	.byte 4  ;HOBBIT
	.byte 6  ;FROST DWARF
	.byte 7  ;GNOLL
	.byte 4  ;GIANT BAT
	.byte 10  ;FIGHTER
	.byte 4  ;GREEN SLIME
	.byte 4  ;SPRITE
	.byte 7  ;ORC CHIEFTAIN
	.byte 8  ;ELF
	.byte 8  ;OGRE
	.byte 8  ;DROW ELF
	.byte 8  ;GIANT SPIDER
	.byte 8  ;GNOME CHIEFTAIN
	.byte 8  ;MINOTAUR
	.byte 8  ;MUNCHKIN
	.byte 10  ;MANTICORE
	.byte 4  ;MEDUSA
	.byte 12  ;PIRATE CAPTAIN
	.byte 10  ;HARPY
	.byte 8  ;GHOUL
	.byte 15  ;ELITE GUARD
	.byte 6  ;PHANTOM
	.byte 10  ;TRITON
	.byte 20  ;TROLL
	.byte 8  ;MUMMY
	.byte 6  ;VAMPIRE BAT
	.byte 6  ;WRAITH
	.byte 16  ;HILL GIANT
	.byte 8  ;BASILISK
	.byte 8  ;SUCCUBUS
	.byte 8  ;SPECTRE
	.byte 16  ;SPIDER GODDESS
	.byte 12  ;NIGHT HAG
	.byte 24  ;XORN
	.byte 10  ;LICH
	.byte 10  ;VAMPIRE
	.byte 12  ;GHOST KNIGHT
	.byte 24  ;DEMON KOBOLD
	.byte 15  ;BLOOD GHOUL
	.byte 18  ;BEHOLDER
	.byte 24  ;DARK PUDDING
	.byte 24  ;SQUID
	.byte 18  ;CHIMERA
	.byte 16  ;MUMMY LORD
	.byte 30  ;ROPER
	.byte 18  ;DEMON GNOLL
	.byte 24  ;QUEEN XORN
	.byte 18  ;DEMONAUR
	.byte 24  ;FIRE LIZARD
	.byte 24  ;EVIL EYE
	.byte 40  ;NESS
	.byte 50  ;KRAKEN
	.byte 40  ;STORM GIANT
	.byte 40  ;GREEN DRAGON
	.byte 32  ;DEMON
	.byte 50  ;BLUE DRAGON
	.byte 50  ;ICE DEMON
	.byte 60  ;RED DRAGON
	.byte 70  ;DEMON BRIDE
	.byte 80  ;NIKAEDOR
	.byte 90  ;SON OF NIKAEDOR

MONSTER_TS:
	.byte 0  ;KOBOLD
	.byte 48  ;SKELETON
	.byte 0  ;GNOME
	.byte 16  ;GIANT MOUSE
	.byte 32  ;MERMAN
	.byte 0  ;ORC
	.byte 0  ;DWARF
	.byte 80  ;BUCCANEER
	.byte 17  ;GIANT RAT
	.byte 2  ;HOBBIT
	.byte 0  ;FROST DWARF
	.byte 0  ;GNOLL
	.byte 17  ;GIANT BAT
	.byte 0  ;FIGHTER
	.byte 19  ;GREEN SLIME
	.byte 4  ;SPRITE
	.byte 0  ;ORC CHIEFTAIN
	.byte 2  ;ELF
	.byte 0  ;OGRE
	.byte 2  ;DROW ELF
	.byte 17  ;GIANT SPIDER
	.byte 0  ;GNOME CHIEFTAIN
	.byte 0  ;MINOTAUR
	.byte 2  ;MUNCHKIN
	.byte 0  ;MANTICORE
	.byte 6  ;MEDUSA
	.byte 80  ;PIRATE CAPTAIN
	.byte 4  ;HARPY
	.byte 53  ;GHOUL
	.byte 0  ;ELITE GUARD
	.byte 4  ;PHANTOM
	.byte 37  ;TRITON
	.byte 0  ;TROLL
	.byte 53  ;MUMMY
	.byte 56  ;VAMPIRE BAT
	.byte 56  ;WRAITH
	.byte 0  ;HILL GIANT
	.byte 22  ;BASILISK
	.byte 72  ;SUCCUBUS
	.byte 56  ;SPECTRE
	.byte 65  ;SPIDER GODDESS
	.byte 5  ;NIGHT HAG
	.byte 19  ;XORN
	.byte 53  ;LICH
	.byte 56  ;VAMPIRE
	.byte 53  ;GHOST KNIGHT
	.byte 65  ;DEMON KOBOLD
	.byte 56  ;BLOOD GHOUL
	.byte 6  ;BEHOLDER
	.byte 19  ;DARK PUDDING
	.byte 33  ;SQUID
	.byte 23  ;CHIMERA
	.byte 56  ;MUMMY LORD
	.byte 1  ;ROPER
	.byte 69  ;DEMON GNOLL
	.byte 19  ;QUEEN XORN
	.byte 71  ;DEMONAUR
	.byte 23  ;FIRE LIZARD
	.byte 6  ;EVIL EYE
	.byte 32  ;NESS
	.byte 33  ;KRAKEN
	.byte 5  ;STORM GIANT
	.byte 7  ;GREEN DRAGON
	.byte 72  ;DEMON
	.byte 7  ;BLUE DRAGON
	.byte 70  ;ICE DEMON
	.byte 7  ;RED DRAGON
	.byte 72  ;DEMON BRIDE
	.byte 69  ;NIKAEDOR
	.byte 70  ;SON OF NIKAEDOR


;********************************************************************

DRINKPOTION:
		JSR ISCHARMOBILE
		BEQ @CANTDRINK

		LDY #31
		LDA (PCHARLO),Y
		BEQ @CANTDRINK

		LDA #<(@DRINKPOT)
		LDY #>(@DRINKPOT)
		JSR PRINTTEXTSECTION
		JSR BEEPSOUND
		JSR PAUSE

		LDY #31
		LDA (PCHARLO),Y
		CMP #1
		BEQ @STRENGTH
		CMP #3
		BEQ @SPEED
		JMP @HEALING

@CANTDRINK:
		JMP INVALIDACTION

@HEALING:
		LDY #32
		JSR DEDUCTUSE
		JSR SETMAXHP
		JSR PRINTSINGLECHAR2
		LDA #1
		RTS

@STRENGTH:
		LDY #32
		JSR DEDUCTUSE

		LDX PCHAR
		LDA #15
		STA COMBATATTACK,X
		RTS
@SPEED:
		LDY #32
		JSR DEDUCTUSE
		LDX PCHAR
		LDA #1
		STA COMBATHASTE1,X
		RTS

@DRINKPOT:
	.byte 13," YOU DRINK THE POTION",0

;********************************************************************

USEITEM:
		JSR ISCHARMOBILE
		BEQ @CANTUSE
		LDY #29
		LDA (PCHARLO),Y
		CMP #8
		BEQ @USE_ROD
		CMP #9
		BPL @USE_WAND

@CANTUSE:
		JMP INVALIDACTION
@USE_ROD:
		JSR @DEDUCT_USE
		LDA #<(@USEROD)
		LDY #>(@USEROD)
		JSR PRINTTEXTSECTION
		JSR BEEPSOUND
		JSR PAUSE

		JSR SETPCHARTEMP
		JSR SELECTCHARK
		;STA PCHAR
		
		LDA #1
		LDY #33
		STA (PCHARLO),Y
		JSR SETMAXHP
		JSR PRINTSINGLECHAR2
		JSR SETPCHARNORMAL
		JSR SELECTCHAR
		LDA #1
		RTS

@USE_WAND:
		CMP #10
		BEQ @USE_LIGHTNING
		LDA #1
		STA SPELLAREA
		LDA #1
		JMP @USE_CONTINUE
@USE_LIGHTNING:
		LDA #0
		STA SPELLAREA
		LDA #2
@USE_CONTINUE:
		STA SPELLFACTOR
		JSR @DEDUCT_USE
		LDA #<(@USEWAND)
		LDY #>(@USEWAND)
		JSR PRINTTEXTSECTION
		JSR BEEPSOUND
		JSR PAUSE
		LDA #3
		STA SPELLTYPE
		LDA #20
		STA SPELLINTWIS
		LDA #2
		RTS
@DEDUCT_USE:
		LDY #30
		JSR DEDUCTUSE
		RTS

@USEROD:
	.byte 13,"   INVOKING THE ROD",0

@USEWAND:
	.byte 13,"  WAVING THE WAND...",0

;********************************************************************

DEDUCTUSE:
		LDA (PCHARLO),Y
		SEC
		SBC #1
		STA (PCHARLO),Y
		CMP #0
		BNE @EXITDEDUCT
		DEY
		LDA #0
		STA (PCHARLO),Y
@EXITDEDUCT:
		RTS

;---------------------------------------------------------------------

INVALIDACTION:

		LDA #<(@INVALIDACTION)
		LDY #>(@INVALIDACTION)
		JSR PRINTTEXTSECTION
		JSR PAUSE
		LDA #0
		RTS

@INVALIDACTION:
	.byte 13,"    ACTION INVALID",0

;********************************************************************

CASTSPELL:
		JSR ISCHARMOBILE
		BEQ @CANTCAST
		LDA #0
		STA TEMP4		; magic school: 0=wizard, 5=priest
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_SU,X
		CMP #0
		BNE @CAST1		; is the class allowed to be a spellcaster?
		JMP @CANTCAST
@CAST1:
		STA TEMP1
		CMP #5
		BNE @CAST2		; is the character a necromancer?
		LDA #<(@SELECTSCHOOL)
		LDY #>(@SELECTSCHOOL)
		JSR PRINTTEXTSECTION
@CASTKEY:
		JSR GETKEY
		CMP #80			; select priest?
		BEQ @SETPRIEST
		CMP #87
		BEQ @CAST3		; cast wizard
		CMP #32
		BEQ @EXITCAST
		JMP @CASTKEY
@SETPRIEST:
		LDA #5			; school is set to priest
		STA TEMP4
		JMP @CAST3

@CAST2:
		CMP #4
		BEQ @SETPRIEST		; paladin
		CMP #2
		BEQ @SETPRIEST		; priest

@CAST3:
		DEC TEMP1		; 0=wizard, 1=priest, 2=ranger, 3=paladin, 4=necromancer
		LDA #<(@SELECTLEVEL)
		LDY #>(@SELECTLEVEL)
		JSR PRINTTEXTSECTION
		LDX #5
		JSR GETNUMBERKEY
		BMI @EXITCAST
		STA TEMP2		; selected spell level 0-4
		LDX TEMP1
		LDA @MAX_LEVEL,X
		CMP TEMP2		; does selected spell level exceed class's maximum spell level?
		BPL @CHECKLEVEL		; if max_level >= temp2 then move on
@CANTCAST:
		LDA #<(@NOTALLOWED)
		LDY #>(@NOTALLOWED)
		JSR PRINTTEXTSECTION
		JSR PAUSE
@EXITCAST:
		LDA #0
		RTS
@CHECKLEVEL:
		LDY #2
		LDA (PCHARLO),Y
		STA TEMP3		; character level
		LDA @CLASSOFFSET,X
		CLC
		ADC TEMP3		; character level + class offset
		TAX
		CPX #12
		BPL @CHECKSTAT		; if character level >= 9 then can cast level 6 spells
		LDA TEMP2
		CMP @SPELL_LEVEL,X
		BMI @CHECKSTAT		; if select level < allowed spell level then you can cast this
		JMP @CANTCAST
@CHECKSTAT:
		LDY #4
		LDA TEMP4
		BEQ @CHECKSTAT1
		INY
@CHECKSTAT1:
		LDA (PCHARLO),Y
		LDX TEMP2
		CMP @SPELL_STAT,X
		BPL @CHECKSU		; does the character have enough INT or WIS to cast the spell
		JMP @CANTCAST

@CHECKSU:
		LDY #19
		LDA (PCHARLO),Y
		BNE @SELECTSPELL
		INY
		LDA TEMP2
		CMP (PCHARLO),Y
		BMI @SELECTSPELL	; check to see if there are enough spell units available
		BCC @SELECTSPELL
		LDY #29
		LDA (PCHARLO),Y
		CMP #7			; ring of wizardry
		BNE @CANTCAST
		LDA TEMP2
		SEC
		SBC #1
		LDY #20
		CMP (PCHARLO),Y
		BMI @SELECTSPELL
		;BCC @SELECTSPELL
@CANTCAST1:
		JMP @CANTCAST
@SELECTSPELL:
		LDA TEMP2
		CLC
		ADC TEMP4
		TAX
		LDA @SPELL_LO,X
		LDY @SPELL_HI,X
		TAX
		JSR PRINTTEXTSECMENU
		LDX #4
		JSR GETNUMBERKEY
		BMI @EXITCAST
		STA TEMP1		
		LDA TEMP2
		CLC
		ADC TEMP4
		ROL
		ROL
		ADC TEMP1
		STA TEMP1		; selected spell 0-19 wizard, 20-39 priest, spell level is in temp2
@DEDUCT_SU:
		LDY #29
		LDA (PCHARLO),Y
		CMP #7			; ring of wizardry
		BNE @DEDUCT_SU2
		DEC TEMP2		; ring of wizardry = costs 1 less SU to cast spells
@DEDUCT_SU2:
		LDA TEMP2
		LDY #20
		CLC
		ADC #1
		JSR DEDUCTBYTES2	; pass A=spell level 1-5, Y=number to deduct

		LDA #<(@CASTINGSPELL)
		LDY #>(@CASTINGSPELL)
		JSR PRINTTEXTSECTION
		LDY #>(WIZARD1)
		LDX #<(WIZARD1)
		LDA TEMP1		
		JSR PRINTSTRING
		JSR BEEPSOUND
		JSR PAUSE

		LDX TEMP1
		LDA SPELLEFFECTS,X
		JSR AND240_ROR4
		STA SPELLTYPE
		LDA SPELLEFFECTS,X
		AND #8
		CLC
		ROR
		ROR
		ROR
		STA SPELLAREA
		LDA SPELLEFFECTS,X
		AND #7
		STA SPELLFACTOR
		LDY #4
		LDA TEMP1
		CMP #20
		BMI @SETINT
		INY
@SETINT:
		LDA (PCHARLO),Y
		STA SPELLINTWIS

		; finally cast the spell
		LDA SPELLTYPE
		CMP #4
		BEQ @COMBATBON2
		CMP #5
		BEQ @CURESTA2
		CMP #9
		BEQ @CUREHP2
		CMP #6
		BEQ @TELEPORT1

@EXIT:
		LDA #1
		RTS

@CUREHP2:
		JSR @CUREHP
@CASTGOBACK:
		JSR SETPCHARNORMAL
		JMP @EXIT

@CURESTA2:
		JSR @CURESTATUS
		JMP @CASTGOBACK

@COMBATBON2:
		JSR @COMBATBONUS
		JMP @CASTGOBACK

@TELEPORT1:
		JSR @TELEPORT
		JMP @CASTGOBACK

;-----------------------------------------------------------

@TELEPORT:
		LDA PMODE
		BEQ @TELEPORT2
@TELEPORTCANT:
		LDA #<(@CANTTELEPORT)
		LDY #>(@CANTTELEPORT)
		JSR PRINTTEXTSECTION
		JMP PAUSE
@TELEPORT2:
		LDA SPELLFACTOR
		CMP #2
		BEQ @TELEPORTRECALL

		; dimension door

		LDA POSDUNZ
		BEQ @TELEPORTCANT
		CMP #15
		BPL @TELEPORTCANT
		INC POSDUNZ
		JSR ERASEUPPERLEFT
		JSR PRINTDUNJON
		RTS

@TELEPORTRECALL:
		JMP WORDOFRECALL

@CANTTELEPORT:
	.byte 13," CAN'T TELEPORT HERE!",0
		
;-----------------------------------------------------------

@COMBATBONUS:
		LDA SPELLAREA
		BEQ @COMBATONE

		JSR CHARLOOP1
  @CB1:
		JSR @COMBATX
		JSR CHARLOOP2
		BNE @CB1
		RTS

@COMBATONE:
		JSR SELECTCHARK
@COMBATX:
		JSR PREPARECHARPOINTER
		LDX SPELLFACTOR
		LDA @COMBATPTR,X
		CLC
		ADC PCHAR
		TAX
		LDA #12
		STA COMBATBACKSTAB,X
		JSR PRINTSINGLECHAR2
		RTS

@COMBATPTR:
	.byte 0,6,12,18,24,30

;-----------------------------------------------------------

@CURESTATUS:
		LDA SPELLAREA
		BEQ @CUREONE

		JSR CHARLOOP1
  @CS1:
		JSR @CUREX
		JSR CHARLOOP2
		BNE @CS1
		RTS

@CUREONE:
		JSR SELECTCHARK
@CUREX:
		JSR GETSTATUS
		CMP SPELLFACTOR
		BNE @CUREXIT2
		LDA #1
		LDY #33
		STA (PCHARLO),Y

		LDA SPELLFACTOR
		BNE @CUREXIT1
		LDY #16
		LDA #1
		STA (PCHARLO),Y
@CUREXIT1:
		JSR PRINTSINGLECHAR2
@CUREXIT2:
		RTS

;-----------------------------------------------------------

@CUREHP:
		LDA SPELLAREA
		BEQ @HEALONE

		JSR CHARLOOP1
  @CH1:
		JSR @HEALX
		JSR CHARLOOP2
		BNE @CH1
		RTS

@HEALONE:
		JSR SELECTCHARK
@HEALX:
		JSR ISCHARMOBILE
		BEQ @HEALXIT2

		LDX SPELLFACTOR
		CPX #3
		BNE @HEALX1
		JSR SETMAXHP
		JMP @HEALXIT
@HEALX1:
		LDA SPELLINTWIS
		CLC
		LDY #2
		ADC (PCHARLO),Y
		CPX #2 
		BEQ @HEALX2
		JMP @HEALXHP
@HEALX2:
		CLC
		ROL
@HEALXHP:
		JSR ROLLDICE1
		JSR ADDHP
@HEALXIT:
		JSR PRINTSINGLECHAR2
@HEALXIT2:
		RTS

;-----------------------------------------------------------

@CLASSOFFSET:
	.byte 3,3,0,1,2

@MAX_LEVEL:
	.byte 4,4,1,2,4

@SPELL_LEVEL:
	.byte 0,0,0,0,1,1,2,2,3,3,4,4

@SPELL_STAT:
	.byte 0,9,12,15,18

@SELECTSCHOOL:
	.byte 13," (W)IZARD OR (P)RIEST",0
@SELECTLEVEL:
	.byte 13,"  SPELL LEVEL? (1-5)",0
@NOTALLOWED:
	.byte 13," NOT ALLOWED TO CAST!",0

@CASTINGSPELL:
	.byte 13,"  CASTING THE SPELL:",13,"  ",0

@SPELL_LO:
	.byte <(WIZARD1)
	.byte <(WIZARD2)
	.byte <(WIZARD3)
	.byte <(WIZARD4)
	.byte <(WIZARD5)
	.byte <(PRIEST1)
	.byte <(PRIEST2)
	.byte <(PRIEST3)
	.byte <(PRIEST4)
	.byte <(PRIEST5)

@SPELL_HI:
	.byte >(WIZARD1)
	.byte >(WIZARD2)
	.byte >(WIZARD3)
	.byte >(WIZARD4)
	.byte >(WIZARD5)
	.byte >(PRIEST1)
	.byte >(PRIEST2)
	.byte >(PRIEST3)
	.byte >(PRIEST4)
	.byte >(PRIEST5)

;------------------------------------------------------------
	;      1234567890123456789
WIZARD1:
	.byte "CHARM MONSTER",0
	.byte "DISPEL MAGIC",0
	.byte "ENCHANTED WEAPON",0
	.byte "MAGIC MISSILE",0
WIZARD2:
	.byte "CLOUD KILL",0
	.byte "HASTE",0
	.byte "LIGHTNING BOLT",0
	.byte "SLEEP",0
WIZARD3:
	.byte "DEATH SPELL",0
	.byte "DISPEL ALL MAGIC",0
	.byte "FIREBALL",0
	.byte "PHANTASMAL FORCE",0
WIZARD4:
	.byte "ENCHANTED ARMY",0
	.byte "FINGER OF DEATH",0
	.byte "POWER WORD STUN",0
	.byte "STONE TO FLESH",0
WIZARD5:
	.byte "DIMENSION DOOR",0
	.byte "METEOR SWARM",0
	.byte "POWER WORD KILL",0
	.byte "TIME DELAY",0
;------------------------------------------------------------
PRIEST1:
	.byte "BLESS",0
	.byte "CURE LIGHT WOUNDS",0
	.byte "PROTECTION/EVIL",0
	.byte "TURN THE UNDEAD",0
PRIEST2:
	.byte "CURE POISON",0
	.byte "CURE SERIOUS WOUNDS",0
	.byte "INVOCATION",0
	.byte "REPULSE THE UNDEAD",0
PRIEST3:
	.byte "EXORCISM",0
	.byte "PRAYER",0
	.byte "REBUKE THE UNDEAD",0
	.byte "SPIRITUAL SHIELD",0
PRIEST4:
	.byte "CURE ALL POISONS",0
	.byte "EXCOMMUNICATION",0
	.byte "EXILE THE UNDEAD",0
	.byte "RESTORATION",0
PRIEST5:
	.byte "CURE ALL WOUNDS",0
	.byte "HOLY SYMBOL",0
	.byte "RESURRECTION",0
	.byte "WORD OF RECALL",0
;------------------------------------------------------------
SPELLEFFECTS:
	.byte 17     ; CHARM MONSTER
	.byte 84     ; DISPEL MAGIC
	.byte 66     ; ENCHANTED WEAPON
	.byte 49     ; MAGIC MISSILE

	.byte 33     ; CLOUD KILL
	.byte 69     ; HASTE
	.byte 50     ; LIGHTNING BOLT
	.byte 25     ; SLEEP

	.byte 41     ; DEATH SPELL
	.byte 92     ; DISPEL ALL MAGIC
	.byte 57     ; FIREBALL
	.byte 18     ; PHANTASMAL FORCE

	.byte 74     ; ENCHANTED ARMY
	.byte 34     ; FINGER OF DEATH
	.byte 26     ; POWER WORD STUN
	.byte 83     ; STONE TO FLESH

	.byte 105     ; DIMENSION DOOR
	.byte 58     ; METEOR SWARM
	.byte 42     ; POWER WORD KILL
	.byte 77     ; TIME DELAY
;------------------------------------------------------------
	.byte 68     ; BLESS
	.byte 145     ; CURE LIGHT WOUNDS
	.byte 67     ; PROTECTION/EVIL
	.byte 113     ; TURN THE UNDEAD

	.byte 82     ; CURE POISON
	.byte 146     ; CURE SERIOUS WOUNDS
	.byte 129     ; INVOCATION
	.byte 121     ; REPULSE THE UNDEAD

	.byte 130     ; EXORCISM
	.byte 76     ; PRAYER
	.byte 114     ; REBUKE THE UNDEAD
	.byte 75     ; SPIRITUAL SHIELD

	.byte 90     ; CURE ALL POISONS
	.byte 137     ; EXCOMMUNICATION
	.byte 122     ; EXILE THE UNDEAD
	.byte 147     ; RESTORATION

	.byte 155     ; CURE ALL WOUNDS
	.byte 138     ; HOLY SYMBOL
	.byte 80     ; RESURRECTION
	.byte 106     ; WORD OF RECALL

;********************************************************************

SELECTCHARK:
		JSR SETPCHARTEMP
		LDA #<(@SELECTCHR)
		LDY #>(@SELECTCHR)
		JSR PRINTTEXTSECTION
  @SCKEY:
		LDX #6
		JSR GETNUMBERKEY
		BMI @SCKEY
		STA PCHAR
		JSR GETSTATUS
		CMP #5
		BEQ @SCKEY
		RTS

@SELECTCHR:
	.byte 13,"   SELECT CHAR(1-6)",0

;********************************************************************

WORDOFRECALL:

		LDA HAVESHIP
		CMP #2
		BNE @RECALLCONTINUE
		JSR LEAVESHIP
@RECALLCONTINUE:
		LDA #0
		STA POSGAME
		STA POSDUNZ
		RTS

;********************************************************************

CHARISEMPTY:
		LDA #<(@TEXT)
		LDY #>(@TEXT)
		JSR PRINTTEXTSECTION
		JMP PAUSE

@TEXT:
	.byte 13,"  CHARACTER IS EMPTY",0


;********************************************************************

PAUSE:
		; affects x,y and temp4
		LDA #1
PAUSE2:		; pass 1,2 or 3 in acc for a shorter pause
		STA TEMPAUSE
@PAUSE1:
		LDX #0
@PAUSE2:
		LDY #0
@PAUSE3:
		INY
		BNE @PAUSE3
		INX
		BNE @PAUSE2
		INC TEMPAUSE
		LDA TEMPAUSE
		CMP #4
		BNE @PAUSE1
		RTS

;********************************************************************

BEEPSOUND:
		LDA #63
		JSR ROLLDICE
		ORA #128
		STA 36875
		JMP CONTSOUND
		

;------------------------------------------------------------

HITSOUND:
		LDA #31
		JSR ROLLDICE
		ORA #192
		STA 36877

;------------------------------------------------------------

CONTSOUND:
		LDA #3
		JSR PAUSE2
		LDA #0
		STA 36875
		STA 36877
		RTS

;********************************************************************

SHORTPAUSE:
		; affects x,y
		LDX #192
@SP1:
		INX
		BEQ @EXIT
		LDY #0
@SP2:
		INY
		BNE @SP2
		BEQ @SP1
@EXIT:
		RTS

;********************************************************************
		

ERASELINE:
		LDA #<(@TEXTERASELINE)
		LDY #>(@TEXTERASELINE)
		JMP PRINTSTRING_K

@TEXTERASELINE:
	.byte "                     ",145,29,0

;********************************************************************

ISCHAREMPTY:
		; this routine should only be used in the menu
		JSR GETSTATUS
		CMP #5			; is the character empty?
		BNE @EXIT
		JSR CHARISEMPTY
		LDA #0
		RTS
@EXIT:
		LDA #1
		RTS

;********************************************************************

GETSTATUS:
		JSR PREPARECHARPOINTER
		LDY #33
		LDA (PCHARLO),Y
		RTS

;********************************************************************

PREPARECHARPOINTER:
		; prepare char pointer		
		LDX PCHAR
		LDA PCHARLOC,X
		STA PCHARLO
		LDA PCHARLOCHI,X
		STA PCHARHI
		LDA PNAMELOC,X
		STA PNAMELO
		LDA PNAMELOCHI,X
		STA PNAMEHI
		RTS

;********************************************************************

RANDOMIZE:
		lda   $9124
		sta   RNDSEED
		lda   $9125
		sta   RNDSEED+1
		lda   $9004
		sta   RNDSEED+2
		lda   $9003
		sta   RNDSEED+3
		rts

;********************************************************************

RND:
   sec         ;Make sure it's deterministic
   lda   #$7a
   adc   RNDSEED
   sta   RNDSEED

   rol   a
   rol   a
   adc   #$69
   adc   RNDSEED+1
   sta   RNDSEED+1

   adc   #$a3
   rol   a
   rol   a
   rol   a
   rol   a
   adc   #$e1
   eor   RNDSEED+2
   sta   RNDSEED+2

   rol   a
   rol   a
   rol   a
   rol   a
   rol   a
   adc   #$57
   adc   RNDSEED+3
   sta   RNDSEED+3

   rts 

;********************************************************************

ROLLCHAR6:
		;a 'loaded' 6 sided dice that favors the player rolling stats for their character
		JSR RND
		AND #7
		TAX
		LDA @ROLLCHARDICE6,X
		RTS

@ROLLCHARDICE6:
	.byte 1,2,3,4,5,6,6,6

;********************************************************************

ROLL6:
		; roll six sided die for 0-5 result (generally to select one of the 6 chars)
		JSR RND
		AND #7
		CMP #6
		BPL ROLL6
		RTS

;********************************************************************

FIFTYFIFTY:
		LDA #2
		JSR ROLLDICE
		CMP #0
		RTS

;********************************************************************

ROLLDICE:
		;JSR RANDOMIZE
		; roll dice from 0 to acc-1
		CMP #0
		BPL @CONTROLL
		LDA #127
@CONTROLL:
		STA DICETEMP
@RD:
		JSR RND
		AND #127
		CMP DICETEMP
		BPL @RD
		RTS
		
;********************************************************************

ROLLDICE1:
		; roll dice from 1 to acc
		JSR ROLLDICE
		CLC
		ADC #1
		RTS

;********************************************************************

SCROLLUP:
		LDX #0
@SU1:
		LDA SCREEN+286,X
		STA SCREEN+264,X
		LDA SCREEN+308,X
		STA SCREEN+286,X
		LDA SCREEN+330,X
		STA SCREEN+308,X
		LDA #32
		STA SCREEN+330,X
		INX
		CPX #22
		BNE @SU1
SCROLLPOSITION:
		LDY #15
		LDX #0
		JMP POSITIONTEXT

;********************************************************************

PRINTCURSORWAIT:
		LDA SCREEN+15*22+2
		CMP #32
		BEQ @CONTINUE
		JSR SCROLLUP
@CONTINUE:
		JSR POSITIONTEXT
		LDA #<(@POINTER)
		LDY #>(@POINTER)
		JMP PRINTSTRING_K
@EXIT:
		RTS
@POINTER:
	.byte 5,146,">",0

;********************************************************************

POSITIONTEXT:
		LDY #15
		LDX #1
		LDA SCREEN+15*22
		CMP #32
		BNE @EXIT
		LDX #0
@EXIT:
		JMP MOVECURSOR

;********************************************************************

PRTCHARNSPACE:
		JSR PRINTCHAR_K
PRINTSPACE:
		LDA #32
		JMP PRINTCHAR_K
		
;********************************************************************

PRINTRETURN:
		LDA #13
		JMP PRINTCHAR_K
		
;********************************************************************

PRINTCHARNDASH:
		CLC
		ADC #49
		JSR PRINTCHAR_K
		LDA #45
		JMP PRINTCHAR_K


;********************************************************************

PRINTTEXTSECMENU:
		;x/y is low/high
		STX TEMPSECLO
		STY TEMPSECHI

		JSR ERASETEXTSECTION
		
		LDA #0
		STA TEMPSECMENU
@P1:
		LDA TEMPSECMENU
		JSR PRINTCHARNDASH
		LDX TEMPSECLO
		LDY TEMPSECHI
		LDA TEMPSECMENU
		JSR PRINTSTRING
		JSR PRINTRETURN
		INC TEMPSECMENU
		LDA TEMPSECMENU
		CMP #4
		BNE @P1
		RTS

;********************************************************************

PRINTSTRING:
		; x/y is low/high to be passed
		; # of string is in ACC
		STX 1
		STY 2
		LDY #0
		LDX #0
		STA TEMPSTRING
		CMP #0
		BEQ @PS4
@PS1:
		LDA (1),Y
		CMP #0
		BEQ @PS3
@PS2:
		JSR ADD1LOHI
		JMP @PS1
@PS3:
		INX
		CPX TEMPSTRING
		BNE @PS2

		JSR ADD1LOHI
@PS4:
		LDY 2
		LDA 1
		JMP PRINTSTRING_K

;********************************************************************

ADD1LOHI:
		CLC
		LDA #1
		ADC 1
		STA 1
		LDA #0
		ADC 2
		STA 2
		RTS

;********************************************************************


PRINTBYTE:
		LDA (PCHARLO),Y
		TAX
		LDA #0
		JSR PRINTINT_XA
		RTS

;********************************************************************

PRINTBYTES2:
		LDA (PCHARLO),Y
		TAX
		DEY
		LDA (PCHARLO),Y
		JSR PRINTINT_XA
		RTS

;********************************************************************

DEDUCTBYTES2:
		; y = pointer to deduct
		; a = amount to deduct
		SEC
		STA TEMPNUM
		LDA (PCHARLO),Y
		SBC TEMPNUM
		STA (PCHARLO),Y
		BCS @EXIT
		DEY
		LDA (PCHARLO),Y
		TAX
		DEX
		TXA
		STA (PCHARLO),Y
@EXIT:
		RTS

;********************************************************************
		
CLEARSCREEN:
		LDA #147
		JSR PRINTCHAR_K
		RTS


;********************************************************************

GETYESKEY:
		JSR PRINTTEXTSECTION
		JSR GETKEY
		CMP #89			; y key
		RTS

;********************************************************************

GETKEY:
		;affects X register, returns ASCII value in A
		JSR SHOWSCREEN
		
@GETK1:
		; check for joystick
		JSR JOYSTICK
		LDA JOY2
		BNE @JOYBUTTON
		LDA JOY1
		BNE @JOYMOVE

		; get key until something is pressed
		JSR GETIN_K
		CMP #0
		BEQ @GETK1
		CMP #48
		BEQ @TOGGLEMUSIC
		RTS

@TOGGLEMUSIC:
		LDA MUSICOFF
		EOR #1
		STA MUSICOFF

		STA 36874
		STA 36876
		JMP @GETK1

@JOYMOVE:
		PHA
		LDA PMENUOFF
		BEQ @JM1
		LDA POSDUNZ
		BNE @JM1
		BEQ @JM2
@JM1:
		JSR SHORTPAUSE
@JM2:
		PLA
		TAX
		LDA @JOYMOVEKEY,X
		RTS

@JOYBUTTON:
		JSR SHORTPAUSE
		LDA #13			; fire button = carriage return
		RTS

@JOYMOVEKEY:
	.byte 0,145,145,29,17,17,17,157,145

;********************************************************************

GETNUMBERKEY:
		; 1 is minimum, x = maximum, accumulator will be returned - (minus) 1
		STX TEMPNUMBERKEY
@L1:
		JSR GETKEY
		CMP #32
		BEQ @EXIT
		CLC
		SBC #48
		BMI @L1
		CMP TEMPNUMBERKEY
		BPL @L1
		CMP #0
		RTS
@EXIT:
		LDA #255
		CMP #0
		RTS

;********************************************************************

ERASESECTION:
		;***the folowing is to erase a section of the screen
		;mem loc 1-2 = lo-hi byte value of where to start at screen
		;loc 3 = width in X bytes
		;loc 4 = height in Y bytes
		;loc 5 = 22 minus loc 3 (to make it easier for the program)

		LDY #0
@L1:
		LDA 3
		STA 6
@L2:
		LDA #32
		STA (1),Y
		INY
		CLC
		DEC 6
		BNE @L2
		TYA
		ADC 5
		TAY
		DEC 4
		BNE @L1
		RTS

;********************************************************************

MOVECURSOR:
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
	
;********************** DATA **********************************

TEXTINTRO:
	.byte 17,17,159,"  PSYTRONIK PRESENTS",13,13,13
	.byte 159,32,32,202,203,196,197,204,205,206, 32,161,162,198,199,32,32,192,193,196,197,13
	.byte 31,32,32,218,219,212,213,220,221,222,223,167,168,214,215,32,32,208,207,163,172,13,13
	.byte 159 ,32,32,32,32,192,193,194,195,196,197,198,199,200,201,32,164,165,166,13
	.byte 31 ,32,32,32,32,208,209,210,211,212,213,214,215,216,217,32,169,170,171,13,13,13
	.byte 159," (C) 2009 SYSTEM IIII",13,13,13,5
	.byte "  ",18,"F1",146," START NEW GAME",13,13
	.byte "  ",18,"F7",146," RESUME OLD GAME",13,13,13
	.byte "   ",18,"0",146," TOGGLES MUSIC"
	.byte 5,19,0

TEXTPARTY:
	.byte 158,18,"# NAME       HITS    S",5,146,0

CHARPOSITION:
	.byte 118,140,162,184,206,228

MENUITEMPOSITION:
	.byte 56,78,100,122,144,166,188,210,232

STATUSPOSITION:
	.byte 139,161,183,205,227,249

TEXTDELSURE:
	.byte 13
	.byte "   DELETE CHARACTER"
TEXTAREYOUSURE:
	.byte 13,"  ARE YOU SURE?(Y/N)",0

;********************** TEXT LABELS FOR CHARACTERS**********************************

TEXTLEVEL:
	.byte "LEVEL ",0

TEXTSTATUS:
	.byte "STATUS:",0

TEXTSTATUS2:
	.byte "DEAD",0
	.byte "GOOD",0
	.byte "POISONED",0
	.byte "STATUE",0
	.byte "PARALYZED",0

POKESTATUS:
	.byte 4,7,16,19,26,32	; DGPSZ

TEXTSEX:
	.byte "MALE ",0
	.byte "FEMALE ",0

TEXTRACE:
	.byte "HUMAN",0
	.byte "ELF",0
	.byte "DWARF",0
	.byte "HOBBIT",0
	.byte "GNOME",0
	.byte "SPRITE",0
	.byte "ORC",0
	.byte "OGRE",0

TEXTCLASS:
	.byte "FIGHTER",0
	.byte "WIZARD",0
	.byte "PRIEST",0
	.byte "THIEF",0
	.byte "RANGER",0
	.byte "PALADIN",0
	.byte "MONK",0
	.byte "NECROMANCER",0

TEXTEXP:
	.byte "EXPERIENCE ",0

TEXTSTAT:
	.byte "STRENGTH",0
	.byte "INTELLIGENCE",0
	.byte "WISDOM",0
	.byte "DEXTERITY",0
	.byte "CONSTITUTION",0
	.byte "CHARISMA",0

TEXTHP:
	.byte "HIT POINTS  ",0

STATADJUST:
	.byte 0,0,0,0,0,0,0,0,0		; 0-8
	.byte 1,1,1,1			; 9-12
	.byte 2,2,2			; 13-15
	.byte 3,3			; 16-17
	.byte 4				; 18
	.byte 5				; 19
	.byte 6				; 20
	.byte 7				; 21
	.byte 8				; 22
	.byte 9				; 23
	.byte 10			; 24
	.byte 11			; 25
	.byte 12			; 26
	.byte 13			; 27
	.byte 14			; 28
	.byte 15			; 29
	.byte 16			; 30

CLASS_HP:
	;BYTE FIGHTER WIZARD CLERIC,THIEF,RANGER,PALADIN,MONK,NECROMANCER
	.byte 12,4,8,6,10,10,6,4

TEXTSU:
	.byte "SPELL UNITS ",0
CLASS_SU:
	;BYTE FIGHTER WIZARD CLERIC,THIEF,RANGER,PALADIN,MONK,NECROMANCER
	.byte 0,1,2,0,3,4,0,5

TEXTWEAPON:
	.byte "NO WEAPON",0
	.byte "DAGGER",0
	.byte "STAFF",0
	.byte "MACE",0
	.byte "FLAIL",0
	.byte "SHORT SWORD",0
	.byte "LONG SWORD",0
	.byte "BATTLE AXE",0
	.byte "TWO-HANDED SWORD",0
	.byte "SLING",0
	.byte "BOW",0
	.byte "CROSSBOW",0
	.byte "100 ARROWS",0
	.byte "100 BULLETS"
TEXTSHIELD:
	.byte 0,"SHIELD",0
CLASSWEAPON:
	;BYTE 0 0 PALADIN RANGER THIEF PRIEST WIZARD FIGHTER,MONK,NECROMANCER
	;      NMPRTPWF
	.byte %11111111		; no weapon
	.byte %10111011		; dagger
	.byte %11111111		; staff
	.byte %01110101		; mace
	.byte %01110101		; flail
	.byte %00111001		; short sword
	.byte %00110001		; long sword
	.byte %00110001		; battle axe
	.byte %00110001		; two-handed sword
	.byte %11111111		; sling
	.byte %00111001		; bow
	.byte %00110001		; crossbow

BACKSTABCLASS:
	.byte %01001000

CLASSCHECK:
RACECHECK:
BITCHECK:
	;BYTE FIGHTER,WIZARD,PRIEST,THIEF,RANGER,PALADIN,MONK,NECROMANCER
	;BYTE HUMAN,ELF,DWARF,HOBBIT,GNOME,SPRITE,ORC,OGRE
	.byte 1,2,4,8,16,32,64,128

CLASSALL:
RACEALL:
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
	.byte %11111111	
RACEWEAPON:
	;BYTE OGRE ORC SPRITE GNOME HOBBIT DWARF ELF HUMAN
	;      OOSGHDEH
	.byte %11111111		; no weapon
	.byte %11111111		; dagger
	.byte %11010111		; staff
	.byte %11011111		; mace
	.byte %11000111		; flail
	.byte %11011111		; short sword
	.byte %11011111		; long sword
	.byte %11000101		; battle axe
	.byte %11000011		; two-handed sword
	.byte %01011111		; sling
	.byte %01011111		; bow
	.byte %01000111		; crossbow
HANDSWEAPON:
	.byte 0,0,1,0,1,0,0,1,1,1,1,1

MISSILEWEAPON:
	.byte 0,0,0,0,0,0,0,0,0,1,1,1

DAMAGEWEAPON:
	.byte 2			; no weapon
	.byte 4			; dagger
	.byte 6			; staff
	.byte 6			; mace
	.byte 8			; flail
	.byte 8			; short sword
	.byte 10		; long sword
	.byte 12		; battle axe
	.byte 15		; two-handed sword
	.byte 4			; sling
	.byte 6			; bow
	.byte 8			; crossbow

TEXTARMOR:
	.byte "NO ARMOR",0
	.byte "ROBE",0
	.byte "LEATHER",0
	.byte "STUDDED LEATHER",0
	.byte "RING MAIL",0
	.byte "CHAIN MAIL",0
	.byte "PLATE MAIL",0
	.byte "ELFIN CHAIN",0

CLASSARMOR:
	;BYTE 0 0 PALADIN RANGER THIEF PRIEST WIZARD FIGHTER,MONK,NECROMANCER
	;      NMPRTPWF
	.byte %11111111		; no armor
	.byte %11111111		; robe
	.byte %01111101		; leather
	.byte %01111101		; studded leather
	.byte %00110101		; ring mail
	.byte %00110101		; chain mail
	.byte %00110101		; plate mail
	.byte %01111101		; elfin chain

CLASS_SHIELD:
	.byte %11111111		; no shield
	.byte %01110101		; shield

RACEARMOR:
	;BYTE OGRE ORC SPRITE GNOME HOBBIT DWARF ELF HUMAN
	;      OOSGHDEH
	.byte %11111111		; no armor
	.byte %11111111		; robe
	.byte %11111111		; leather
	.byte %11011111		; studded leather
	.byte %01011111		; ring mail
	.byte %01010111		; chain mail
	.byte %01000111		; plate mail
	.byte %11111111		; elfin chain

TEXTITEM:
	;BYTE  123456789012345678901
	.byte "NONE",0			;blank
	.byte "BOOTS OF ELVENKIND",0		; for haste
	.byte "CROWN OF MIGHT",0	;(F)	adds save + strength bonus + armor protection
	.byte "GIRDLE GIANT STRENGTH",0	;(F)	adds attack bonus
	.byte "GAUNTLET OF THIEVING",0	;(T)	adds + 20 to thieving abilities
	.byte "RING OF PROTECTION",0		; magic armor bonus during combat
	.byte "RING OF REGENARATION",0		; cures 1 hp per round of movement
	.byte "RING OF WIZARDRY",0	;(W)	spells only cost 1 su each to cast
	.byte "ROD OF RESURRECT.",0	;(P)	resurrect spell
	.byte "WAND OF FIRE",0		;(W)	fireball spell
	.byte "WAND OF LIGHTNING",0	;(W)	lightning bolt spell
CLASSITEM:
	;BYTE PALADIN RANGER THIEF PRIEST WIZARD FIGHTER
	;      NMPRTPWF
	.byte %11111111		; nothing
	.byte %11111111		; boots of elvenkind
	.byte %01110001		; crown of might
	.byte %01110001		; girdle of giant strength
	.byte %00001000		; gauntlet of thieving
	.byte %11111111		; ring protection
	.byte %11111111		; ring regeneration
	.byte %10000010		; ring of wizardry
	.byte %01000100		; rod of resurrect.
	.byte %11000010		; wand of fire
	.byte %11000010		; wand of lightning
LIMITITEM:
	.byte 0,0,0,0,0,0,0,0,1,1,1	; item is limited to # of charges

TEXTPOTION:
	;BYTE  123456789012345678901
	.byte 0
	.byte "POTION GIANT STR.",0
	.byte "POTION OF HEALING",0
	.byte "POTION OF SPEED",0

PICTURELO:
	.byte <(PICTURES+200*00)
	.byte <(PICTURES+200*01)
	.byte <(PICTURES+200*02)
	.byte <(PICTURES+200*03)
	.byte <(PICTURES+200*04)
	.byte <(PICTURES+200*05)
	.byte <(PICTURES+200*06)
	.byte <(PICTURES+200*07)
	.byte <(PICTURES+200*08)
	.byte <(PICTURES+200*09)
	.byte <(PICTURES+200*10)
	.byte <(PICTURES+200*11)
	.byte <(PICTURES+200*12)
	.byte <(PICTURES+200*13)
	.byte <(PICTURES+200*14)
	.byte <(PICTURES+200*15)
	.byte <(PICTURES+200*16)
	.byte <(PICTURES+200*17)
	.byte <(PICTURES+200*18)
	.byte <(PICTURES+200*19)
	.byte <(PICTURES+200*20)
	.byte <(PICTURES+200*21)
	.byte <(PICTURES+200*22)
	.byte <(PICTURES+200*23)
	.byte <(PICTURES+200*24)
	.byte <(PICTURES+200*25)
	.byte <(PICTURES+200*26)
	.byte <(PICTURES+200*27)
	.byte <(PICTURES+200*28)
	.byte <(PICTURES+200*29)
	.byte <(PICTURES+200*30)
	.byte <(PICTURES+200*31)
	.byte <(PICTURES+200*32)
	.byte <(PICTURES+200*33)
	.byte <(PICTURES+200*34)
	.byte <(PICTURES+200*35)
	.byte <(PICTURES+200*36)
	.byte <(PICTURES+200*37)
	.byte <(PICTURES+200*38)
	.byte <(PICTURES+200*39)
	.byte <(PICTURES+200*40)
	.byte <(TEMPLEGRAPHIC)
	.byte <(BOLZAIMGRAPHIC)
	.byte <(HELLGRAPHIC)
	.byte <(PARTYGRAPHIC)

PICTUREHI:
	.byte >(PICTURES+200*00)
	.byte >(PICTURES+200*01)
	.byte >(PICTURES+200*02)
	.byte >(PICTURES+200*03)
	.byte >(PICTURES+200*04)
	.byte >(PICTURES+200*05)
	.byte >(PICTURES+200*06)
	.byte >(PICTURES+200*07)
	.byte >(PICTURES+200*08)
	.byte >(PICTURES+200*09)
	.byte >(PICTURES+200*10)
	.byte >(PICTURES+200*11)
	.byte >(PICTURES+200*12)
	.byte >(PICTURES+200*13)
	.byte >(PICTURES+200*14)
	.byte >(PICTURES+200*15)
	.byte >(PICTURES+200*16)
	.byte >(PICTURES+200*17)
	.byte >(PICTURES+200*18)
	.byte >(PICTURES+200*19)
	.byte >(PICTURES+200*20)
	.byte >(PICTURES+200*21)
	.byte >(PICTURES+200*22)
	.byte >(PICTURES+200*23)
	.byte >(PICTURES+200*24)
	.byte >(PICTURES+200*25)
	.byte >(PICTURES+200*26)
	.byte >(PICTURES+200*27)
	.byte >(PICTURES+200*28)
	.byte >(PICTURES+200*29)
	.byte >(PICTURES+200*30)
	.byte >(PICTURES+200*31)
	.byte >(PICTURES+200*32)
	.byte >(PICTURES+200*33)
	.byte >(PICTURES+200*34)
	.byte >(PICTURES+200*35)
	.byte >(PICTURES+200*36)
	.byte >(PICTURES+200*37)
	.byte >(PICTURES+200*38)
	.byte >(PICTURES+200*39)
	.byte >(PICTURES+200*40)
	.byte >(TEMPLEGRAPHIC)
	.byte >(BOLZAIMGRAPHIC)
	.byte >(HELLGRAPHIC)
	.byte >(PARTYGRAPHIC)

;********************************************************************

ADDHP:
		LDY #16
		JSR ADDCONT
		LDY #17
		CMP (PCHARLO),Y
		BMI @EXIT
		BEQ @CHECKHI
@SETMAX:
		JMP SETMAXHP
@CHECKHI:
		LDY #16
		LDA (PCHARLO),Y
		LDY #18
		CMP (PCHARLO),Y
		BMI @EXIT
		JMP @SETMAX
@EXIT:
		RTS


;********************************************************************

DEDUCTHP:
		; accumulator passed determines # of HP deducted
		STA MATHTEMP
		LDY #16
		SEC
		LDA (PCHARLO),Y
		SBC MATHTEMP
		STA (PCHARLO),Y
		DEY
		LDA (PCHARLO),Y
		SBC #0
		STA (PCHARLO),Y

		BMI @DEAD
		BEQ @CHECKLO
		BPL @EXIT
@CHECKLO:
		INY
		LDA (PCHARLO),Y
		BEQ @DEAD
		JMP @EXIT
@DEAD:
		LDY #33
		LDA #0
		STA (PCHARLO),Y
		LDY #15
		STA (PCHARLO),Y
		INY
		STA (PCHARLO),Y

		LDA PMODE
		BNE @EXIT2

		LDA #<(@PLAYERDEAD)
		LDY #>(@PLAYERDEAD)
		JSR PRINTBOTTOMLINE
		LDA #3
		JSR PAUSE2
@EXIT:
		RTS

@EXIT2:
		JSR PAUSE
		LDA #<(@PLAYERDEAD2)
		LDY #>(@PLAYERDEAD2)
		JMP PRINTTEXTSECTION

@PLAYERDEAD2:
	.byte 13,"   "

@PLAYERDEAD:
	.byte "CHARACTER DIES!",0

;********************************************************************

PRINTBOTTOMLINE:
		PHA
		TYA
		PHA

		LDA SCREEN+15*22+1
		CMP #32
		BEQ @CONTINUE
		JSR SCROLLUP		; if bottom line is not empty, then scrollup
@CONTINUE:
		JSR POSITIONTEXT
		PLA
		TAY
		PLA
		JMP PRINTSTRING_K

;********************************************************************

RESTNIGHT:

		JSR @BUYNIGHTPTR
		JSR CMP_FAC2AY	; compare FAC to amount of gold pointed to by a/y
		CMP #1		; if cost is less than amount of gold then...
		BMI @BUYREST
		JMP NOTENOUGHMONEY
@BUYREST:
		LDA #<(@TAVCONFIRM)
		LDY #>(@TAVCONFIRM)
		JSR GETYESKEY
		BEQ @DEDUCTGOLD
		RTS

@DEDUCTGOLD:
		JSR @BUYNIGHTPTR
		JSR DEDUCTGOLD

		JSR HIDESCREEN
		LDA #<(@TAVMESSAGE)
		LDY #>(@TAVMESSAGE)
		JSR PRINTTEXTSECTION
		JSR TAVERNPIC

		JSR SETPCHARTEMP
		JSR CHARLOOP1
  @REST1:
		JSR CUREPARALYZATION
		JSR CUREPOISON
		JSR SETMAXSU
		JSR PRINTSINGLECHAR
		JSR CHARLOOP2
		BNE @REST1
		JSR SETPCHARNORMAL
		JSR SELECTCHAR

		JMP GETKEY


@BUYNIGHTPTR:
		LDY #5
		LDA #0		; lo/hi of 5/0 = 5
		JMP MONEYPTR

@TAVCONFIRM:
	.byte 13,"   PAY 5 GP TO REST"
	.byte 13," FOR THE NIGHT? (Y/N)",0

@TAVMESSAGE:
	.byte 13," THE HEROES RELAX AND"
	.byte 13," THEN REST AT THE INN",0

;********************************************************************

SETMAXSU:
		JSR ISCHARMOBILE
		BEQ @EXIT
		LDY #21
		LDA (PCHARLO),Y
		LDY #19
		STA (PCHARLO),Y
		LDY #22
		LDA (PCHARLO),Y
		LDY #20
		STA (PCHARLO),Y
		JMP SETMAXHP
@EXIT:
		RTS


SETMAXHP:
		JSR ISCHARMOBILE
		BEQ @EXIT
		LDY #17
		LDA (PCHARLO),Y
		LDY #15
		STA (PCHARLO),Y
		LDY #18
		LDA (PCHARLO),Y
		LDY #16
		STA (PCHARLO),Y
@EXIT:
		RTS

;********************************************************************

CUREPOISON:
		JSR PREPARECHARPOINTER
		LDY #33
		LDA (PCHARLO),Y
		CMP #2
		BNE @EXIT
		LDA #1
		STA (PCHARLO),Y
@EXIT:
		RTS

;********************************************************************

CUREPARALYZATION:
		JSR PREPARECHARPOINTER
		LDY #33
		LDA (PCHARLO),Y
		CMP #4
		BNE @EXIT
		LDA #1
		STA (PCHARLO),Y
@EXIT:
		RTS

;********************************************************************

TURNMENUOFF:
		LDX #0
@YL1:
		LDA COLOR,X
		AND #15
		CMP #1
		BNE @YL2
		LDA SCREEN,X
		AND #128
		BNE @YL2
		LDA #7
		STA COLOR,X
@YL2:
		INX
		CPX #242
		BNE @YL1
		RTS

;********************************************************************

MOVEAROUND:
		LDA #0
		STA PMODE
		JSR PREPARE3
		JSR TURNMENUOFF

@GOBACK:
		LDA POSDUNZ
		BEQ @GROUND
		JMP @UNDERGROUND
@GROUND:
		LDA #5			; bach int13
		JSR PLAYMUSIC
		JSR TRAVEL		; draw map on screen

@GOBACK2:
		LDA MOVETEXT
		BEQ @GETK1
		JSR @PRINTMOVETEXT

@GETK1:
		LDA SCREEN+15*22+2
		CMP #32
		BEQ @GETK2
		JSR PRINTCURSORWAIT
@GETK2:
		LDA #0
		STA MOVETEXT
		JSR GETKEY
		CMP #32
		BEQ @KEY_SPACE
		CMP #13
		BEQ @KEY_ENTER
		CMP #17
		BEQ @KEY_DOWN
		CMP #75
		BEQ @KEY_DOWN
		CMP #145
		BEQ @KEY_UP
		CMP #73
		BEQ @KEY_UP
		CMP #29
		BEQ @KEY_RIGHT
		CMP #76
		BEQ @KEY_RIGHT
		CMP #157
		BEQ @KEY_LEFT
		CMP #74
		BEQ @KEY_LEFT
		JMP @GOBACK
@KEY_SPACE:
		JMP RETURNMENU
@KEY_ENTER:
		JMP @ENTER
@KEY_DOWN:
		LDA #3
		STA MOVETEXT
		LDX #44
		JSR @CHECKMOVE
		BEQ @NOTMOVE
		LDA #32
		CLC
		ADC POSMAPLO
		STA POSMAPLO
@ADCPOSHI:
		LDA #0
		ADC POSMAPHI
@STAMAPHI:
		AND #7
		STA POSMAPHI
		JMP @GOBACK
@NOTMOVE:
		LDA #0
		STA MOVETEXT
		JMP @GOBACK2
@KEY_UP:
		LDA #1
		STA MOVETEXT
		LDX #0
		JSR @CHECKMOVE
		BEQ @NOTMOVE
		LDA POSMAPLO
		SEC
		SBC #32
		STA POSMAPLO
@SBCPOSHI:
		LDA POSMAPHI
		SBC #0
		JMP @STAMAPHI
@KEY_RIGHT:
		LDA #2
		STA MOVETEXT
		LDX #23
		JSR @CHECKMOVE
		BEQ @NOTMOVE
		DEC POSMAPCARRY
		LDA POSMAPCARRY
		CMP #0
		BMI @MOVERIGHT
		JMP @GOBACK
@MOVERIGHT:
		LDA #1
		STA POSMAPCARRY
		LDA POSMAPLO
		CLC
		ADC #1
		STA POSMAPLO
		JMP @ADCPOSHI
@KEY_LEFT:
		LDA #4
		STA MOVETEXT
		LDX #21
		JSR @CHECKMOVE
		BEQ @NOTMOVE
		INC POSMAPCARRY
		LDA POSMAPCARRY
		CMP #2
		BPL @MOVELEFT
		JMP @GOBACK
@MOVELEFT:
		LDA #0
		STA POSMAPCARRY
		LDA POSMAPLO
		SEC
		SBC #1
		STA POSMAPLO
		JMP @SBCPOSHI

@CHECKMOVE:

		STX TEMP4

		; is the character mobile?
		JSR ISCHARMOBILE
		BEQ @CANTMOVE

		LDX TEMP4
		LDA SCREEN+4*22+5,X
		STA UNDERCHAR2

		; is the party inside the ship?
		LDA HAVESHIP
		CMP #2
		BNE @CHECKLAND

		;check for water
		LDA SCREEN+4*22+5,X
		CMP #31
		BNE @CANTMOVE
		LDA COLOR+4*22+5,X
		AND #15
		CMP #14
		BEQ @CANMOVE
		BNE @CANTMOVE
  @CHECKLAND:
		LDA SCREEN+4*22+5,X
		CMP #31
		BEQ @CANTMOVE
		CMP #122
		BEQ @CANTMOVE
		CMP #125
		BEQ @CANTMOVE
		BNE @CANMOVE
  @CANTMOVE:
		LDA #0
		RTS
  @CANMOVE:
		CMP #27
		BEQ @CHECKPOISON
		CMP #127
		BEQ @CHECKLAVA
  @NOWMOVE:
		JSR @PRINTMOVETEXT
		JSR DEDUCTCHECK
		JSR ENCOUNTER
		LDA QUITFLAG
		BNE @DEADSTART
		LDA #1
		RTS
  @DEADSTART:
		JMP START
@CHECKPOISON:
		JMP @CHECKPOISON2
@CHECKLAVA:
		JMP @CHECKLAVA2


@CHECKPOISON2:
		JSR SETPCHARTEMP
		JSR ROLL6
		STA PCHAR
		STA TEMP1
		LDA #1			; status good
		JSR ISCHARSTATUS
		BNE @EXITPOISON		; can only poison characters with a 'good' status
		LDY #7			; constitution check
		LDA #4
		JSR ROLLSTAT
		BNE @EXITPOISON		; if con check passes then player is not poisoned
		LDY #33
		LDA #2			; player becomes poisoned!
		STA (PCHARLO),Y

		JSR @PRINTMOVETEXT
		JSR HITSOUND
		LDA #5
		STA MOVETEXT
		JSR @PRINTMOVETEXT
		JSR PRINTSINGLECHAR2
		LDA #0
		STA MOVETEXT
		JSR SETPCHARNORMAL
		JSR SELECTCHAR
  @EXITPOISON:
		JSR SETPCHARNORMAL
		JMP @NOWMOVE

@CHECKLAVA2:
		JSR @PRINTMOVETEXT
		JSR HITSOUND
		LDA #6
		STA MOVETEXT
		JSR @PRINTMOVETEXT

		JSR DAMAGEPARTY

		JMP @NOWMOVE

@ENTER:
		LDA UNDERCHAR
		CMP #30
		BEQ @BOARDSHIP
		CMP #31
		BEQ @EXITSHIP
		CMP #156
		BEQ @ENTERCASTLE
		CMP #126
		BEQ @ENTERDUN1
		CMP #159
		BEQ @ENTERTOWN
		JMP @NOTMOVE
@ENTERTOWN:
		LDA #14
		JSR @SPECIALENTER
		JSR RESTNIGHT
		JMP MOVEAROUND
@ENTERDUN1:
		JMP @ENTERDUNJON
@ENTERCASTLE:
		LDA #0
		STA POSGAME
		JMP RETURNMENU

@BOARDSHIP:
		LDA #2
		STA HAVESHIP
		LDA #7
  @ESHIP:
		STA MOVETEXT
		JMP @GOBACK

@EXITSHIP:
		JSR LEAVESHIP
		LDA #8
		JMP @ESHIP

@ENTERDUNJON:
		LDA POSMAPLO
		CMP #101
		BNE @ENTERNORMALDUN
		; can only enter final dunjon with 8 orbs
		LDA ORBS
		CMP #255
		BEQ @ENTERNORMALDUN2
		LDA #18
		JMP @ESHIP
@ENTERNORMALDUN:
		JSR CHECKORB
		BEQ @CANTENTER
@ENTERNORMALDUN2:
		LDA #1
		STA POSDUNZ
		LDA POSMAPLO
		STA POSDUNLO
		LDA #0
		STA POSDUNHI
		STA POSDUNFACING
		LDA #9
		JMP @ESHIP
@CANTENTER:
		LDA #19
		JMP @ESHIP

@PRINTMOVETEXT:
	LDA SCREEN+15*22+1
	CMP #32
	BEQ @CONTINUE
	JSR SCROLLUP		; if bottom line is not empty, then scrollup
@CONTINUE:
	LDA #62
	JSR PRINTCHAR_K
@CONTINUE2:
	JSR POSITIONTEXT
	LDA MOVETEXT
	LDY #>(@MOVETEXT)
	LDX #<(@MOVETEXT)
	JSR PRINTSTRING
	LDA #0
	STA MOVETEXT
	JMP SHORTPAUSE

@MOVETEXT:
	.byte 0,"NORTH",0		;1
	.byte "EAST",0
	.byte "SOUTH",0
	.byte "WEST",0
	.byte "SOMEONE'S POISONED!",0	;5
	.byte "MOLTEN LAVA BURNS!",0	;6
	.byte "BOARD THE SHIP",0	;7
	.byte "DISEMBARK",0		;8
	.byte "ENTER DUNJON",0		;9
	.byte "TURN RIGHT",0		;10
	.byte "TURN LEFT",0		;11
	.byte "CLIMB DOWN",0		;12
	.byte "CLIMB UP",0		;13
	.byte "ENTER TOWN",0		;14
	.byte "TURN AROUND",0		;15
	.byte "SIT ON THE THRONE?",0	;16
	.byte "DRINK THE WATER?",0	;17
	.byte "NEED 8 ORBS TO ENTER!",0	;18
	.byte "THIS DUNJON IS SOLVED",0 ;19


@UNDERGROUND:
		LDA POSMAPLO
		CMP #101
		BEQ @UNDER_1
		LDA #6			; moonlight sonta
		JMP @UNDER_2
@UNDER_1:
		LDA #3			; swan lake
@UNDER_2:
		JSR PLAYMUSIC
		JSR ERASEUPPERLEFT
@UNDER1:
		JSR PRINTDUNJON
		LDA MOVETEXT
		BEQ @GETKEY1
		JSR @PRINTMOVETEXT
@GETKEY1:
		LDA SCREEN+15*22+2
		CMP #32
		BEQ @GETKEY2
		JSR PRINTCURSORWAIT
@GETKEY2:
		LDA #0
		STA MOVETEXT
		JSR GETKEY
		CMP #29
		BEQ @TURN_RIGHT
		CMP #76
		BEQ @TURN_RIGHT
		CMP #157
		BEQ @TURN_LEFT
		CMP #74
		BEQ @TURN_LEFT
		CMP #145
		BEQ @MOVE_AHEAD
		CMP #73
		BEQ @MOVE_AHEAD
		CMP #17
		BEQ @TURN_AROUND
		CMP #75
		BEQ @TURN_AROUND
		CMP #32
		BEQ @KEY_SPACE2
		CMP #13
		BEQ @DUNJON_ENTER1
		JMP @GETKEY2
@KEY_SPACE2:
		JMP RETURNMENU
@DUNJON_ENTER1:
		JMP @DUNJONENTER
@TURN_RIGHT:
		JSR ISCHARMOBILE
		BEQ @GETKEY2
		LDA #10
		STA MOVETEXT
		INC POSDUNFACING
@TURN:
		LDA POSDUNFACING
		AND #3
		STA POSDUNFACING
		JMP @UNDERGROUND
@TURN_LEFT:
		JSR ISCHARMOBILE
		BEQ @GETKEY2
		LDA #11
		STA MOVETEXT
		DEC POSDUNFACING
		JMP @TURN
@TURN_AROUND:
		JSR ISCHARMOBILE
		BEQ @GETKEY2
		LDA #15
		STA MOVETEXT
		LDA POSDUNFACING
		CLC
		ADC #2
		STA POSDUNFACING
		JMP @TURN

@GETKEY3:
		JMP @GETKEY2

@MOVE_AHEAD:
		JSR ISCHARMOBILE
		BEQ @GETKEY3
		LDA MOVEFRONT
		BEQ @GETKEY3
		LDY POSDUNFACING
		CLC
		LDA POSDUNLO
		ADC @MOVECHANGE,Y
		STA POSDUNLO
		LDA #0
		ADC POSDUNHI
		AND #3
		STA POSDUNHI
		LDA @MOVECHANGE,Y
		AND #128
		BEQ @CONTMOVE
		DEC POSDUNHI
		LDA POSDUNHI
		AND #3
		STA POSDUNHI
  @CONTMOVE:
		INY
		STY MOVETEXT
  @CONTMOVE2:
		JSR @PRINTMOVETEXT
		JSR DEDUCTCHECK
		JSR ENCOUNTERD
		LDA QUITFLAG
		BNE @DEADSTART2
		LDA POSDUNZ
		BEQ @FINISHQUEST2
		JMP @UNDERGROUND
  @FINISHQUEST2:
		JMP RETURNMENU
  @DEADSTART2:
		JMP START

@DUNJONENTER:				; dunjonenter as in 'enter' key
		LDA MOVEUP
		BEQ @DE_DOWN
		LDA MOVEDOWN
		BEQ @DE_UP
		; when there is a conflict between a moveup and movedown
		LDA #13
		STA MOVETEXT
		JSR @PRINTMOVETEXT
		JSR PAUSE
		LDA #<(@CONFIRMENTER)
		LDY #>(@CONFIRMENTER)
		JSR @SPECIALCONFIRM2
		CMP #89
		BEQ @DE_UP
		BNE @DE_DOWN
  @DE_UP:
		LDA #13
		STA MOVETEXT
		DEC POSDUNZ
		BEQ @DUNJONEXIT
		JMP @CONTMOVE2
  @DUNJONEXIT:
		JMP @GOBACK

@DE_DOWN:
		LDA MOVEDOWN
		CMP #1
		BEQ @CLIMBDOWN
		; need to program throne + fountain checks here
		CMP #2
		BEQ @ENTERTHRONE
		CMP #3
		BEQ @ENTERFOUNTAIN2
		JMP @GETKEY2

  @ENTERFOUNTAIN2:
		JMP @ENTERFOUNTAIN
  @CLIMBDOWN:
		INC POSDUNZ
		LDA #12
		STA MOVETEXT
		JMP @CONTMOVE2
  @ENTERTHRONE:
		LDA #16
		JSR @SPECIALENTER
		LDX #70
		JSR @SPECIALCONFIRM1
		CMP #89
		BEQ @ET2
		JMP @TGB2
  @ET2:
		JSR ROLL6		; one of six stats will be affected
		CLC
		ADC #3
		TAY
		JSR PREPARECHARPOINTER
		LDA #10	
		JSR ROLLDICE
		CMP #2
		BMI @THRONEUP
		BEQ @THRONEDOWN

		; ZAP!
		LDA #<(@ZAP)
		LDY #>(@ZAP)
  @TDEDUCT:
		JSR PRINTTEXTSECTION
		JSR HITSOUND
		JSR PAUSE
		JSR ERASETEXTSECTION
		LDA #10
		JSR ROLLDICE1
		JSR DEDUCTHP_SHOW
		JMP @TGB3

  @THRONEDOWN:
		LDA #<(@THRONEMINUS)
		LDY #>(@THRONEMINUS)
		JSR PRINTTEXTSECTION

		JSR ROLL6
		CLC
		ADC #3
		TAY
		LDA (PCHARLO),Y
		SEC
		SBC #1
  @TH:
		CMP #31
		BPL @NOTHINGHAPPENSTHRONE
		CMP #0
		BEQ @NOTHINGHAPPENSTHRONE
		STA (PCHARLO),Y
		LDA #<(@THRONEHAPPENS)
		LDY #>(@THRONEHAPPENS)
		JSR PRINTSTRING_K
  @TGB1:
		JSR BEEPSOUND
		JSR PAUSE
		JSR PAUSE
  @TGB2:
		JSR ERASETEXTSECTION
  @TGB3:
		JSR PRINTCURSORWAIT
		JMP @UNDERGROUND
  @THRONEUP:
		LDA #<(@THRONEPLUS)
		LDY #>(@THRONEPLUS)
		JSR PRINTTEXTSECTION
		JSR ROLL6
		CLC
		ADC #3
		TAY

		LDA (PCHARLO),Y
		CLC
		ADC #1
		JMP @TH

   @NOTHINGHAPPENSTHRONE:
		LDA #<(NOTHINGHAPPENS)
		LDY #>(NOTHINGHAPPENS)
		JSR PRINTTEXTSECTION
		JMP @TGB1

  @ENTERFOUNTAIN:
		LDA #17
		JSR @SPECIALENTER
		LDX #71
		JSR @SPECIALCONFIRM1
		CMP #89
		BEQ @EF2
		JMP @TGB2
  @EF2:
		JSR PREPARECHARPOINTER
		LDA POSDUNLO
		AND #1
		CMP #1
		BEQ @FPOISONED
		JSR SETMAXHP
		LDA #<(@REFRESHED)
		LDY #>(@REFRESHED)
  @EF3:
		JSR PRINTTEXTSECTION
		JSR PRINTSINGLECHAR2
		JSR BEEPSOUND
		JSR PAUSE
		JMP @TGB2
  @FPOISONED:
		JSR PREPARECHARPOINTER
		LDY #33
		LDA #2
		STA (PCHARLO),Y
		LDA #<(@BITTER)
		LDY #>(@BITTER)
		JMP @TDEDUCT
				
		
@MOVECHANGE:
	.byte 224,1,32,255

@CONFIRMENTER:
	.byte 13,"     Y TO CONFIRM",0

@THRONEHAPPENS:
	.byte 13," MAGIC OVERWHELMS YOU",0

@THRONEMINUS:
	.byte 13,"  YOU FEEL WEAKER AS",0

@THRONEPLUS:
	.byte 13," YOU FEEL STRONGER AS",0

@ZAP:
	.byte 13,"        ZZZAP!",0

@REFRESHED:
	.byte 13,"  THOU ART REFRESHED",0

@BITTER:
	.byte 13,"     BITTER WATER",0

;--------------------------------------------------------------

@SPECIALENTER:
		STA MOVETEXT
		JSR @PRINTMOVETEXT
		JMP PAUSE

;--------------------------------------------------------------

@SPECIALCONFIRM1:
		JSR SETPIC
		JSR DOUBLEPIC
		LDA #<(@CONFIRMENTER)
		LDY #>(@CONFIRMENTER)
		JSR @SPECIALCONFIRM
		CMP #89
		RTS

@SPECIALCONFIRM2:
		JSR @SPECIALCONFIRM
		JSR PRINTCURSORWAIT
		LDA TEMP4
		RTS

@SPECIALCONFIRM:
		JSR PRINTTEXTSECTION
		JSR GETKEY
		STA TEMP4
		JSR ERASETEXTSECTION
		LDA TEMP4
		RTS

;********************************************************************

LEAVESHIP:

		LDA #1
		STA HAVESHIP
		LDA POSMAPCARRY
		TAX
		STA POS_SHIPCARRY
		LDA POSMAPLO
		STA POS_SHIPLO
		CPX #0
		BEQ @EXITSHIP2
		SEC
		SBC #1
		STA POS_SHIPLO
		LDA POSMAPHI
		SBC #0
		AND #7
		STA POS_SHIPHI
		JMP @EXITSHIP3
  @EXITSHIP2:
		LDA POSMAPHI
		STA POS_SHIPHI
  @EXITSHIP3:
		RTS

;********************************************************************

NOTHINGHAPPENS:
		.byte 13,"   NOTHING HAPPENS!",0

;********************************************************************

DEDUCTCHECK:
		; routine that checks whether hp are to be added or subtracted
		; while moving because of ring/regeneration and/or poison
		LDA #0
		STA DCTEMP
		JSR CHARLOOP1
  @DC1:
		JSR ISCHARMOBILE
		BEQ @LOOP
		LDY #29
		LDA (PCHARLO),Y
		CMP #6
		BNE @DCPOISON

		LDY #15
		LDA (PCHARLO),Y
		LDY #17
		CMP (PCHARLO),Y
		BNE @DC2
		LDY #16
		LDA (PCHARLO),Y
		LDY #18
		CMP (PCHARLO),Y
		BNE @DC2
		BEQ @DCPOISON
@DC2:
		LDA #1
		JSR ADDHP_SHOW		; ring of regeneration
		INC DCTEMP
  @DCPOISON:
		JSR GETSTATUS
		CMP #2
		BNE @LOOP
		LDA #1
		JSR DEDUCTHP_SHOW
		INC DCTEMP		; char is poisoned
  @LOOP:
		JSR CHARLOOP2
		BNE @DC1
		JSR SETPCHARNORMAL
		LDA DCTEMP
		BEQ @EXIT
		JMP SELECTCHAR
  @EXIT:
		RTS

;********************************************************************

DEDUCTHP_SHOW:
		JSR DEDUCTHP
		JMP PRINTSINGLECHAR2

ADDHP_SHOW:
		JSR ADDHP
		JMP PRINTSINGLECHAR2

;********************************************************************

ORBPOINTER:
	.byte 132,70,198,88,254,153,140,111

;********************************************************************

CHECKORB:
		LDX #7
@ED1:
		LDA ORBPOINTER,X
		CMP POSMAPLO
		BEQ @ED2
		DEX
		BPL @ED1
@ED2:
		LDA ORBS
		AND BITCHECK,X
		CMP BITCHECK,X
		BNE @ED3
		LDA #0
		RTS
@ED3:
		LDA BITCHECK,X
		STA ORBTEMP
		LDA #1
		RTS

;********************************************************************

ENCOUNTERD:
		LDA #0
		STA QUITFLAG
		STA ORBTEMP

		LDA POSDUNZ
		CMP #15
		BMI @ENCOUNTERD2

		LDA POSMAPLO
		CMP #101		; final dunjon
		BNE @ENCD
		LDA #255
		STA ORBTEMP
		JMP @ENCOUNTERD2

@ENCD:
		JSR CHECKORB

;------------------------------------------------------------

@ENCOUNTERD2:		
		LDA #50
		JMP ENCOUNTER2
ENCOUNTER:
		LDA #0
		STA QUITFLAG
		STA ORBTEMP
		LDA #40
ENCOUNTER2:
		JSR ROLLDICE
		CMP #0
		BEQ @YES
		LDA #0		;no
		RTS
@YES:
		; erase combat_______ values
		LDX #(COMBAT_END-COMBATPARRY)
		LDA #0
  @LE1:
		STA COMBATPARRY,X
		DEX
		BPL @LE1

;-----------------------------------------
		; loop through all 6 characters and set bonuses for magic items
		JSR CHARLOOP1
  @LI1:
		JSR PREPARECHARPOINTER
		LDX PCHAR
		LDY #29
		LDA (PCHARLO),Y
		CMP #1
		BNE @LI_CROWN
  @LI_BOOTS:
		LDA #1
		STA COMBATHASTE1,X
		JMP @LI_NEXT
  @LI_CROWN:
		CMP #2
		BNE @LI_GIRDLE
		LDA #8
		STA COMBATATTACK,X
		STA COMBATARMOR,X
		LDA #2
		STA COMBATSAVE,X
		JMP @LI_NEXT
  @LI_GIRDLE:
		CMP #3
		BNE @LI_RINGPROT
		LDA #10
		STA COMBATATTACK,X
		JMP @LI_NEXT
  @LI_RINGPROT:
		CMP #5
		BNE @LI_NEXT
		LDA #10
		STA COMBATARMOR,X
  @LI_NEXT:
		JSR CHARLOOP2
		BNE @LI1
		JSR SETPCHARNORMAL
;-----------------------------------------

		; erase monasters
		LDA #0
		STA MB_TYPE
		STA MB_NUMBER
		STA MF_NUMBER
		STA PARTYWINS
		STA PCHARCOMBAT
		STA MONSTERGREET
		STA PIRATESHIP
		DEC MB_TYPE

		LDA #1
		STA PMODE

		; now add the total level of the party
		JSR CHARLOOP1
		STA TEMP2		; set to 0
  @HIGHEST1:
		JSR ISCHARMOBILE
		BEQ @HIGHEST2
		LDY #2
		LDA (PCHARLO),Y
		CLC
		ADC TEMP2
		STA TEMP2
  @HIGHEST2:
		JSR CHARLOOP2
		BNE @HIGHEST1
		JSR SETPCHARNORMAL

		LDA ORBTEMP
		BEQ @NORMALENCOUNTER
		CMP #255
		BNE @ORBENCOUNTER

		; the "final" encounter
		
		LDA #30
		STA MORALE
		LDA #6
		STA MB_NUMBER
		LDA QUESTITERATION
		BNE @JUNIOR			; fight against the son of Nikaedor if this is a repeat quest!
		LDA #68
		JMP @FINAL1
  @JUNIOR:
		LDA #69
  @FINAL1:
		STA MB_TYPE
		TAX
		JSR @ROLLHPBACK
		LDA MB_HPX+6
		STA MB_HITPOINTS

		LDA #12
		STA MF_NUMBER
		LDA #67
		STA MF_TYPE
		TAX
		JSR @ROLLHPFRONT
		JMP @FROMSPECIALENCOUNTER

  @ORBENCOUNTER:
		; encounter for the orb!
		LDA #30
		STA MORALE
		LDA #6
		STA MB_NUMBER
		LDA #67
		STA MB_TYPE
		TAX
		JSR @ROLLHPBACK
		TAX
		

		JSR COUNTORBS
		TXA
		CLC
		ADC #5
		STA MF_NUMBER
		LDA #63
		STA MF_TYPE
		TAX
		JSR @ROLLHPFRONT
		JMP @FROMSPECIALENCOUNTER

  @NORMALENCOUNTER:
		; add the dunjon level to that
		LDA POSDUNZ
		CLC
		ADC TEMP2
		STA TEMP2

		; populate back row
		CMP #20
		BMI @FRONTROW
		LDA HAVESHIP
		CMP #2
		BEQ @BACKROLL
		LDA TEMP2
		SEC
		SBC #10
		CMP #40
		BMI @BACK2
		LDA #40
  @BACK2:
		STA TEMPBACK
  @BACKROLL:
		JSR @ROLLMONSTER
		CMP TEMPBACK
		BMI @BACKROLL
		STA MB_TYPE

		; set number of back monsters
		LDA #6
		JSR ROLLDICE1
		STA MB_NUMBER

		; roll monster hp
		LDX MB_TYPE
		JSR @ROLLHPBACK
		LDA MB_HPX+6
		STA MB_HITPOINTS

@FRONTROW:
		; populate front row
  @FRONTROLL:
		LDA TEMP2
		CMP #6
		BPL @FRONTROLL2
		LDA #6
		STA TEMP2
  @FRONTROLL2:
		JSR @ROLLMONSTER
		STA MF_TYPE

		; set number of front monsters
		LDA #9
		JSR ROLLDICE1
		CLC
		ADC #3
		STA MF_NUMBER
		CLC
		ADC MB_NUMBER
		ROR
		ADC #2
		STA MORALE

  @FROMSPECIALENCOUNTER:
		; roll monster hp
		LDX MF_TYPE
		JSR @ROLLHPFRONT
		LDA MF_HPX+12
		STA MF_HITPOINTS

		LDA #4
		JSR PLAYMUSIC

		LDA PCHAR
		STA PCHARCOMBAT

		; check to see if the party is surprised
		LDY #6		; DEX check
		LDA #10
		JSR ROLLSTAT
		BNE @MAINENCMENU

		LDA #<(@AMBUSHED)
		LDY #>(@AMBUSHED)
		JSR PRINTTEXTSECTION
		JSR PAUSE

		JMP @PL2

@MAINENCMENU:
		LDA #0
		STA MONSTERDISP
		JSR ERASETEXTSECTION

		; print back row
		LDA MB_NUMBER
		BEQ @PRINTFRONT
		JSR @PRINTMONSTERNUMBER
		LDA MB_TYPE
		JSR @PRINTMONSTERNAME
		JSR PRINTRETURN

  @PRINTFRONT:
		LDA MF_NUMBER
		BEQ @MAINENCMENU2
		JSR @PRINTMONSTERNUMBER
		LDA MF_TYPE
		STA MONSTERDISP
		JSR @PRINTMONSTERNAME

@MAINENCMENU2:
		JSR @SHOWMONSTER
		LDY #15
		LDX #0
		JSR MOVECURSOR
		LDA #<(@ENCMENU)
		LDY #>(@ENCMENU)
		JSR PRINTSTRING_K
  @ME_KEY:
		JSR GETKEY
		CMP #13
		BEQ @FIGHT
		CMP #70
		BEQ @FIGHT
		CMP #71
		BEQ @GREET
		CMP #82
		BEQ @RUNAWAY
		JMP @ME_KEY

@RUNAWAY:
		LDA PIRATESHIP
		BNE @FIGHT			; can't escape from a pirate ship arrrrrr
		JSR FIFTYFIFTY
		BNE @FIGHT
		LDA #<(@YOURUN)
		LDY #>(@YOURUN)
		JSR PRINTTEXTSECTION
		JMP @EXITCOMBAT

@GREET:
		LDA MONSTERGREET
		BNE @FIGHT

		LDX MF_TYPE
		JSR @GETMONSTERTYPE
		BNE @FIGHT

		LDY #8
		LDA #25
		JSR ROLLSTAT
		BEQ @FIGHT

		LDA #<(@GREETYOU)
		LDY #>(@GREETYOU)
		JSR PRINTTEXTSECTION
		JMP @VICTORY3

@FIGHT:
		LDA PCHAR
		STA PCHARCOMBAT

		; party attacks
		LDA #0
		STA PLAYERTURN
  @PARTYLV:
		LDA MF_TYPE
		STA MONSTERDISP
		JSR @SHOWMONSTER3
  @PARTYLOOP:
		LDX PLAYERTURN
		STX PCHAR
		LDA #0
		STA COMBATBACKSTAB,X		; backstab option off
		STA COMBATPARRY,X		; parry option off

		JSR ISCHARMOBILE
		BEQ @PL1_JMP
		JSR SELECTCHAR

  @PL_MENU:
		LDA #<(@FIGHTMENU)
		LDY #>(@FIGHTMENU)
		JSR PRINTTEXTSECTION
  @PL_KEY:
		JSR GETKEY
		CMP #13
		BEQ @PLATTACK
		CMP #65
		BEQ @PLATTACK
		CMP #66
		BEQ @BACKSTAB
		CMP #67
		BEQ @CASTSPELL1
		CMP #68
		BEQ @DRINKPOTION1
		CMP #80
		BEQ @PARRY
		CMP #85
		BEQ @USEITEM
		CMP #86
		BEQ @PLVIEW
		JMP @PL_KEY

  @PL1_JMP:	JMP @PL1

  @CASTSPELL1:
		JSR CASTSPELL
		BEQ @PL_MENU
		JMP @CASTSPELL2

  @DRINKPOTION1:
		JSR DRINKPOTION
		BEQ @PL_MENU
		JMP @PL1
  @PARRY:
		LDX PCHAR
		LDA #10
		STA COMBATPARRY,X
		JMP @PL1
  @USEITEM:
		JSR USEITEM
		BEQ @PL_MENU
		JMP @USEITEM1

  @PLVIEW:	JSR VIEWCHAR
		JMP @PARTYLV
  @BACKSTAB:
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASSCHECK,X
		AND BACKSTABCLASS
		BEQ @PL_KEY
		LDY #23
		LDA (PCHARLO),Y
		TAX
		LDA MISSILEWEAPON,X
		BNE @PL_KEY		

		LDA #10
		LDX PCHAR
		STA COMBATBACKSTAB,X

  @PLATTACK:	JSR @ATTACK
		JSR @CHECKHASTE

  @PL1:
		LDA PARTYWINS
		BNE @VICTORY
		INC PLAYERTURN
		LDA PLAYERTURN
		CMP #6
		BPL @PL11
		JMP @PARTYLV
  @PL11:
		LDA MORALE
		BPL @PL2
		LDA PIRATESHIP		; pirates never run away, arrrrrrr
		BNE @PL2
		JSR FIFTYFIFTY
		BEQ @MONSTERSFLEE
  @PL2:
		JSR SHOWSCREEN
		JSR @MONSTERATTACK
		JSR ISPARTYMOBILE
		BEQ @MONSTERSWIN
		JSR @SETPCHAR
		JMP @MAINENCMENU

@MONSTERSWIN:
		LDA #<(@YOULOSE)
		LDY #>(@YOULOSE)
		JSR PRINTTEXTSECTION
		;LDA #0
		;JSR SETSTATUSALL
		JMP @EXITCOMBAT

@MONSTERSFLEE:
		LDA #<(@FLEE)
		LDY #>(@FLEE)
		JMP @VICTORY2
@VICTORY:
		LDA #<(@WINS)
		LDY #>(@WINS)
@VICTORY2:
		JSR PRINTTEXTSECTION
		JSR @SETPCHAR

@VICTORY3:
		LDA ORBTEMP
		BNE @TREASURE2
		JSR FIFTYFIFTY
		BEQ @EXITCOMBAT
		LDA PIRATESHIP
		BNE @TREASURE2
		LDA HAVESHIP
		CMP #2
		BNE @TREASURE2
@EXITCOMBAT:
		JSR PAUSE
		JMP @EXITCOMBAT2
@TREASURE2:
		JMP @TREASURE


@EXITCOMBAT2:
		JSR @SETPCHAR
		LDA #0
		STA PMODE		; no longer in combat mode
		JSR ISCHARMOBILE
		BNE @EXITCOMBAT3
		JSR ISPARTYMOBILE
		BNE @SELECTNEWCHAR
		JSR GETKEY		; party is dead
		LDA #1
		STA QUITFLAG
		JMP @EXITCOMBAT3
@SELECTNEWCHAR:
		JSR CHARLOOP1
  @SNC:
		JSR ISCHARMOBILE
		BNE @SNC1
		JSR CHARLOOP2
		BNE @SNC
		JSR SETPCHARNORMAL
  @SNC1:
		JSR SELECTCHAR
@EXITCOMBAT3:
		JMP PREPARE3

;---------------------------------------------------------------------------------------------

@USEITEM1:
		CMP #2
		BEQ @CASTSPELL2
		JMP @PL1

;---------------------------------------------------------------------------------------------


@CASTSPELL2:
		LDA SPELLTYPE
		CMP #3
		BEQ @SPELLDAM1
		CMP #1
		BEQ @SPELLSTUN1
		CMP #2
		BEQ @SPELLKILL1
		CMP #7
		BEQ @SPELLTURN1
		CMP #8
		BEQ @SPELLHOLY1
		JMP @PL1
  @SPELLDAM1:
		JSR @SPELLDAMAGE
		JMP @PL1
  @SPELLSTUN1:
		LDA #0
  @SPELLSTUN2:
		STA SPELL_STUNKILL
		LDA #0
  @SPELLSTUN3:
		STA SPELL_WIZPRIEST
		JSR @SPELLSTUN
		JMP @PL1
  @SPELLKILL1:
		LDA #1
		JMP @SPELLSTUN2
  @SPELLTURN1:
		LDA #0
		STA SPELL_STUNKILL
		LDA #1
		JMP @SPELLSTUN3
  @SPELLHOLY1:
		LDA #1
		STA SPELL_STUNKILL
		LDA #1
		JMP @SPELLSTUN3

;---------------------------------------------------------------------------------------------

@TREASURE:
		JSR PAUSE
		LDA #72
		STA MONSTERDISP
		JSR @SHOWMONSTER3
		LDA #<(@FINDTREASURE)
		LDY #>(@FINDTREASURE)
		JSR PRINTTEXTSECTION
		JSR PAUSE

		; code for treasure trap here

		LDA #0
		STA DISARMTRAP
		STA DISARMTRIED
@TREASUREMENU:
		LDA #<(@TREASUREMEN)
		LDY #>(@TREASUREMEN)
		JSR PRINTTEXTSECTION
@TREASUREKEY:
		JSR GETKEY
		CMP #76
		BEQ @EXITTREASURE
		CMP #79
		BEQ @GETTREASURE
		CMP #68
		BEQ @DISARMTRAP
		JMP @TREASUREKEY

@DISARMTRAP:
		LDA DISARMTRIED
		BNE @TREASUREKEY
		LDA #1
		STA DISARMTRIED
		
		; check for disarm
		JSR CHARLOOP1
  @DISARM1:
		JSR ISCHARMOBILE
		BEQ @DISARM2			; immobile characters can't detect traps
		LDY #29
		LDA (PCHARLO),Y
		CMP #4
		BEQ @DISARM3			; gauntlet of thieving guarantees disarming of traps every time
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDY #6
		LDA @DISARMCLASS,X
		BEQ @DISARM2			; only thieves and rangers can detect/disarm traps
		JSR ROLLSTAT
		BEQ @DISARM2
  @DISARM3:
		JMP @DISARMSUCCESS
  @DISARM2:
		JSR CHARLOOP2
		BNE @DISARM1
		JSR SETPCHARNORMAL

		LDA #<(@TRAPNOTFOUND)
		LDY #>(@TRAPNOTFOUND)
		JMP @DISARMEXIT

@DISARMSUCCESS:
		; trap successfully disarmed
		LDA #1
		STA DISARMTRAP
		LDA #<(@YOUDISARM)
		LDY #>(@YOUDISARM)
@DISARMEXIT:
		JSR PRINTTEXTSECTION
		JSR PAUSE
		JMP @TREASUREMENU

@EXITTREASURE:
		JMP @EXITCOMBAT2

@GETTREASURE:
		JSR FIFTYFIFTY
		BEQ @GETTREASURE2

		LDA DISARMTRAP
		BNE @GETTREASURE2

		JSR FIFTYFIFTY
		BEQ @TREASUREBOMB

		; poisoned
		JSR POISONPARTY
		LDA #<(@TREASUREPOISON)
		LDY #>(@TREASUREPOISON)
		JMP @EXITTRAP
@TREASUREBOMB:
		JSR DAMAGEPARTY
		JSR SHORTPAUSE
		LDA #<(@TREASUREBOMB2)
		LDY #>(@TREASUREBOMB2)
@EXITTRAP:
		JSR PRINTTEXTSECTION
		JSR HITSOUND
		JSR PAUSE

@GETTREASURE2:
		LDA ORBTEMP
		BEQ @GETTREASURE3
		CMP #255
		BNE @GETTREASUREORB

		LDA #<(@FINISHQUEST)
		LDY #>(@FINISHQUEST)
		JSR PRINTTEXTSECTION
		LDA #1
		JSR PLAYMUSIC
		JSR GETKEY

		LDA #0
		STA ORBS
		INC QUESTITERATION
		JSR WORDOFRECALL
		JMP @GETTREASURE3

@GETTREASUREORB:
		ORA ORBS
		STA ORBS

		LDA #<(@FINDORB)
		LDY #>(@FINDORB)
		JSR PRINTTEXTSECTION
		LDA #1
		JSR PLAYMUSIC
		JSR GETKEY

@GETTREASURE3:
		; add gold
		LDA #<(@FINDGOLD)
		LDY #>(@FINDGOLD)
		JSR PRINTTEXTSECTION

		LDA #10
		CLC
		ADC MF_TYPE
		STA TREASURETEMP

		JSR ROLLDICE1
		TAY
		LDA #0
		JSR INT_YA2FAC
		JSR MULTIPLY_FAC10
		LDA ORBTEMP
		BEQ @GETTREASURE4

		JSR MULTIPLY_FAC10
		JSR MULTIPLY_FAC10
		JSR MULTIPLY_FAC10


@GETTREASURE4:
		JSR STA_FAC_XPTEMP3

		LDA #10
		JSR ROLLDICE
		TAY
		LDA #0
		JSR INT_YA2FAC

		JSR LDAY_XPTEMP3

		JSR ADD_FAC_AY

		JSR STA_FAC_XPTEMP3

		JSR PRINTFAC_K
		LDA #<(GEEPEE)
		LDY #>(GEEPEE)
		JSR PRINTSTRING_K

		JSR LDAY_XPTEMP3

		JSR MEM_AY2FAC
		JSR MONEYPTR2
		JSR ADD_FAC_AY
		JSR SETGOLD

		; now add a magic item
		LDA #127
		JSR ROLLDICE
		CMP TREASURETEMP
		BPL @ITEMEXIT
		LDA ITEMTYPE+9		; is inventory full?
		BNE @ITEMEXIT
		JMP @GETITEM
@ITEMEXIT:
		JMP @EXITCOMBAT
@GETITEM:
		JSR PAUSE
		LDA #5
		JSR ROLLDICE1
		STA TEMP1
		TAX
		LDA @ITEMRANGE,X
		JSR ROLLDICE1
		STA TEMP2
		LDX TEMP1
		LDA @ITEMBONUS,X
		JSR ROLLDICE1
		STA TEMP3

		LDX TEMP1
		CPX #4
		BNE @ITEMK
		LDX TEMP2
		LDA LIMITITEM,X
		BNE @ITEMK
		LDA #0
		STA TEMP3
  @ITEMK:
		LDX #0
  @ITEML:		
		LDA ITEMTYPE,X
		BEQ @ITEMADD
		INX
		JMP @ITEML
  @ITEMADD:
		LDA TEMP1
		STA ITEMTYPE,X
		LDA TEMP2
		STA ITEMIS,X
		LDA TEMP3
		STA ITEMBONUS,X

		LDA #<(@FINDITEM)
		LDY #>(@FINDITEM)
		JSR PRINTTEXTSECTION

		JMP @EXITCOMBAT

@FINISHQUEST:
	.byte    " * CONGRATULATIONS! *"
	.byte 13," YOU'VE  DEFEATED THE"
	.byte 13," DEMON WIZARD. NOW GO"
	.byte 13,"FORTH AND SLAY HIS SON",0

@FINDORB:
	.byte    " YOU'VE FOUND  ONE OF"
	.byte 13," THE EIGHT  ORBS THAT"
	.byte 13," YOU'LL NEED TO ENTER"
	.byte 13,"   NIKAEDOR'S LAIR!",0

@FINDTREASURE:
	.byte 13,"  YOU FIND TREASURE!",0

@FINDGOLD:
	.byte 13,"  YOU GET ",0

@FINDITEM:
	.byte 13,"  AND A SPECIAL ITEM",0

@TREASUREMEN:
	.byte 13," ",18,"O",146,"PEN ",18,"L",146,"EAVE TREASURE"
	.byte 13," ",18,"D",146,"ETECT/DISARM TRAPS",0

@YOUDISARM:
	.byte 13," YOU DISARM THE TRAP!",0

@TRAPNOTFOUND:
	.byte 13," NO TRAPS WERE FOUND!",0

@TREASUREPOISON:
	.byte 13,"    NOXIOUS FUMES!",0
@TREASUREBOMB2:
	.byte 13,"    BOMB EXPLODES!",0

@ITEMRANGE:
	.byte 0,11,7,1,10,3

@ITEMBONUS:
	.byte 0,10,5,5,99,99

@DISARMCLASS:
	; fighter,wizard,priest,thief,ranger,paladin,monk,necromancer
	.byte 0,0,0,10,20,0,0,0


;---------------------------------------------------------------------------------------------

@ROLLMONSTER:
		LDA PIRATESHIP
		BNE @ROLLLANDMONSTER
		LDA HAVESHIP
		CMP #2
		BEQ @ROLLSEAMONSTER

@ROLLLANDMONSTER:
		LDA TEMP2
		JSR ROLLDICE
		CMP #67				; monster value <=66?
		BPL @ROLLLANDMONSTER
		STA TEMP3
		TAX
		JSR @GETMONSTERTYPE
		CMP #2
		BEQ @ROLLLANDMONSTER
		CMP #5				; pirates do not appear on land
		BEQ @ROLLLANDMONSTER
@RETURN:
		LDA TEMP3
		RTS


@ROLLSEAMONSTER:
		LDA TEMP2
		JSR ROLLDICE
		CMP #67				; monster value <=66?
		BPL @ROLLSEAMONSTER
		STA TEMP3
		TAX
		JSR @GETMONSTERTYPE
		CMP #5
		BEQ @CHECKPIRATE
@ROLLSEAMONSTER2:
		LDX TEMP3
		JSR @GETMONSTERTYPE
		CMP #2
		BNE @ROLLSEAMONSTER
		JMP @RETURN

@CHECKPIRATE:
		LDA MB_TYPE
		CMP #255
		BNE @ROLLSEAMONSTER2

		LDA #1
		STA PIRATESHIP
		JMP @RETURN
	

;---------------------------------------------------------------------------------------------

@SPELLDAMAGE:
		JSR @COMBATSPELLPTR

  @SPELLD0:
		LDX SPELLDAM1
		LDA MF_HPX,X
		STA MF_HITPOINTS
		JSR @SPELLD1
		LDA PARTYWINS
		BNE @SDEXIT
		LDX SPELLDAM1
		LDA MF_HITPOINTS
		STA MF_HPX,X
		LDA SPELLAREA
		BEQ @SDEXIT
		DEC SPELLDAM1
		LDA SPELLDAM1
		BEQ @SPELLD3
		JMP @SPELLD0
  @SPELLD1:
		JSR @CASTINGLOOP

		LDA SPELLINTWIS
		CLC
		LDY #2
		ADC (PCHARLO),Y
		LDX SPELLFACTOR
		CPX #2
		BNE @SPELLD2
		ROL
  @SPELLD2:
		JSR ROLLDICE1
		STA TEMP3
		JMP @DODAMAGE	
  @SPELLD3:
		LDA SPELLDAM2
		STA MF_HITPOINTS

  @MONSTERPTR:
		LDA #<(MF_TYPE)
		STA PDUNLO
		LDA #>(MF_TYPE)
		STA PDUNHI
  @SDEXIT:
		RTS

;---------------------------------------------------------------------------------------------

@COMBATSPELLPTR:
		LDA MF_NUMBER
		STA SPELLDAM1
		LDA MF_HITPOINTS
		STA SPELLDAM2
		RTS

;---------------------------------------------------------------------------------------------

@CASTINGLOOP:
		JSR @MONSTERPTR
		JSR @DRAWMONSTER

		LDA #<(@CASTING)
		LDY #>(@CASTING)
		JSR PRINTTEXTSECTION
		JMP PAUSE

  @CASTING:
	.byte 13,"      CASTING...",0

;---------------------------------------------------------------------------------------------

@SPELLSTUN:
		JSR @COMBATSPELLPTR
  @SS1:
		LDX MF_TYPE
		LDA MONSTER_TS,X
		JSR AND240_ROR4
		TAX

		LDA SPELL_WIZPRIEST
		BNE @SS_PRIEST1

		; check wizard
		LDA @LIVINGPTR,X
		BEQ @SPELLNOEFFECT3
		BNE @SS_CASTING

  @SS_PRIEST1:
		; check priest
		LDA SPELL_STUNKILL
		BEQ @SS_PRIESTSTUN
		LDA @DEMONPTR,X
		BEQ @SPELLNOEFFECT
		JMP @SS_CASTING

  @SPELLNOEFFECT3:
		JMP @SPELLNOEFFECT

  @SS_PRIESTSTUN:
		LDA @DEMONPTR,X
		BNE @SPELLNOEFFECT
		LDA @LIVINGPTR,X
		BNE @SPELLNOEFFECT

  @SS_CASTING:
		JSR @CASTINGLOOP

		LDA SPELLINTWIS
		LDY #2
		CLC
		ADC (PCHARLO),Y
		SEC
		SBC MONSTERHD,X
		STA MATHTEMP
		;CLC
		;ROL MATHTEMP
		LDA SPELLFACTOR
		CMP #2
		BNE @SS2
		CLC
		ROL MATHTEMP
  @SS2:
		LDA #127
		JSR ROLLDICE
		CMP MATHTEMP
		BPL @SPELLNOEFFECT2

		LDA SPELL_STUNKILL
		BEQ @SS_REMOVE
		LDA #<(@SPELLDIES)
		LDY #>(@SPELLDIES)
		JSR PRINTTEXTSECTION
		JSR @MONSTERDIES
		JSR PAUSE
		JMP @SS3
  @SS_REMOVE:
		JSR @REMOVEMONSTER
		LDA #<(@REMOVED)
		LDY #>(@REMOVED)
		JSR PRINTTEXTSECTION
		JSR PAUSE
  @SS3:
		LDA PARTYWINS
		BNE @SSEXIT
		LDA SPELLAREA
		BEQ @SSEXIT
		DEC SPELLDAM1
		LDA SPELLDAM1
		BEQ @SSEXIT
		JMP @SS_CASTING
  @SSEXIT:
		RTS


  @SPELLNOEFFECT2:
		JSR @SPELLNOEFFECT
		JMP @SS3
  @SPELLNOEFFECT:
		LDA #<(@NOEFFECT)
		LDY #>(@NOEFFECT)
		JSR PRINTTEXTSECTION
		JMP PAUSE

  @LIVINGPTR:
	.byte 1,1,1,0,0,1		; 1 = living, 2 = dead

  @DEMONPTR:
	.byte 0,0,0,0,1,0

  @NOEFFECT:
	.byte 13,"      NO EFFECT!",0

  @REMOVED:
	.byte 13,"  MONSTER TAKEN OUT!",0

  @SPELLDIES:
	.byte 13,"  ",0

;---------------------------------------------------------------------------------------------

@ATTACK:
		; check for missile weapon
		LDA #3
		STA MISSILE
		LDY #23
		LDA (PCHARLO),Y
		TAX
		LDA MISSILEWEAPON,X
		BEQ @ATTACK2

		; check for ammo
		LDA #6				; dexterity will be used for thaco
		STA MISSILE
		LDA #<(ARROWS)
		STA PDUNLO
		LDA #>(ARROWS)
		STA PDUNHI
		LDY #23
		LDA (PCHARLO),Y
		CMP #9
		BNE @ATTACK1
		LDA #<(BULLETS)
		STA PDUNLO
		LDA #>(BULLETS)
		STA PDUNHI
@ATTACK1:
		; deduct ammo
		LDY #0
		SEC
		LDA (PDUNLO),Y
		SBC #1
		STA (PDUNLO),Y
		INY
		LDA (PDUNLO),Y
		SBC #0
		STA (PDUNLO),Y
		BPL @ATTACK1_1
		JMP @OUTOFAMMO
@ATTACK1_1:
		LDA MB_NUMBER
		BEQ @ATTACK2
		LDA #<(MB_TYPE)		; missile automatically attacks the back row first
		STA PDUNLO
		JMP @ATTACK3
@ATTACK2:
		LDA #<(MF_TYPE)
		STA PDUNLO
@ATTACK3:
		LDA #>(MF_TYPE)
		STA PDUNHI

		LDA MISSILE
		CMP #6
		BNE @ATTACK4
		JSR @DRAWMONSTER
@ATTACK4:

		; calculate thaco
		LDA #54
		LDY #2			; level
		CLC
		ADC (PCHARLO),Y
		LDY MISSILE		; strength/dexterity
		ADC (PCHARLO),Y
		LDY #24			; weapon bonus
		ADC (PCHARLO),Y
		LDX PCHAR
		ADC COMBATATTACK,X	; magic attack bonus
		STA TEMP4
		LDY #0
		LDA (PDUNLO),Y
		TAX
		LDA TEMP4
		SEC
		SBC MONSTERHD,X		; minus monster hit dice
		STA TEMP3
		LDA #127
		JSR ROLLDICE
		CMP TEMP3
		BMI @ATTACKHITS

		LDA #<(@YOUMISS)
		LDY #>(@YOUMISS)
		JSR PRINTTEXTSECTION
		JMP PAUSE

@ATTACKHITS:
		; calculate weapon damage
		LDA TEMP4
		SEC
		SBC #54
		STA TEMP4
		LDY #23
		LDA (PCHARLO),Y
		TAX
		LDA DAMAGEWEAPON,X
		CMP #2
		BNE @AH2
		; check for monk class
		LDY #1
		LDA (PCHARLO),Y
		CMP #6
		BNE @AH1
		LDY #2			; get level
		LDA (PCHARLO),Y
		CLC
		ROL			; hands damage = level * 2
		JMP @AH2
@AH1:
		LDA #2
@AH2:
		LDX PCHAR
		CLC
		ADC COMBATBACKSTAB,X
		ROL COMBATBACKSTAB,X

		STA TEMP3
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA @FIGHTERBONUS,X	; fighters, rangers and paladins score 1 extra HP damage per level with weapon
		BEQ @AH3
		LDY #2
		LDA TEMP3
		CLC
		ADC (PCHARLO),Y
		STA TEMP3
@AH3:
		LDA TEMP3
		JSR ROLLDICE1
		STA TEMP3
		LDA #127
		JSR ROLLDICE
		CMP TEMP4
		BPL @DODAMAGE
		LDA TEMP3
		CLC
		ROL			; double damage
		STA TEMP3
@DODAMAGE:
		LDA #<(@YOUHIT1)
		LDY #>(@YOUHIT1)
		JSR PRINTTEXTSECTION

		LDX TEMP3
		LDA #0
		JSR PRINTINT_XA

		LDA #<(@YOUHIT2)
		LDY #>(@YOUHIT2)
		JSR PRINTSTRING_K

		JSR HITSOUND

		; deduct hp from the monster
		JSR @DEDUCTMONSTERHP
		JMP PAUSE

@OUTOFAMMO:
		LDA #0
		LDY #0
		STA (PDUNLO),Y
		INY
		STA (PDUNLO),Y
		LDA #<(@NOAMMO)
		LDY #>(@NOAMMO)
		JSR PRINTTEXTSECTION
		JMP PAUSE

@CHECKHASTE:
		LDA PARTYWINS
		BEQ @CONTINUEHASTE
		RTS
@CONTINUEHASTE:
		LDX PCHAR
		LDA COMBATHASTE1,X
		BEQ @EXITATTACK
		JSR @DRAWMONSTER
		LDA #<(@ATTACKAGAIN)
		LDY #>(@ATTACKAGAIN)
		JSR PRINTTEXTSECTION
		JSR PAUSE
		JMP @ATTACK		; attack one more time!
@EXITATTACK:
		RTS

@ATTACKAGAIN:
	.byte 13,"     ATTACK AGAIN",0

@FIGHTERBONUS:
	.byte 1,0,0,0,1,1,0,0

;---------------------------------------------------------------------------------------------

@SPATTACK:
	.byte 0
	.byte "     POISONS YOU!",0
	.byte "   STEALS FROM YOU!",0
	.byte " DESTROYS YOUR ARMOR!",0
	.byte "      CHARMS YOU",0
	.byte "    PARALYZES YOU!",0
	.byte "  YOU TURN TO STONE!",0
	.byte "    BREATH WEAPON!",0
	.byte "     ENERGY DRAIN",0
	.byte "   YOU LOSE A LEVEL",0

@SPATTACKROLL:
	.byte 0,7,6,6,8,5,4,6,7



;1 poison (vs CON)
;2 steal (vs DEX)
;3 destroy armor (vs DEX)
;4 charm/paralysis (vs CHA)
;5 paralyze (vs WIS)
;6 gaze turns to stone (vs INT)
;7 breathe (vs DEX)
;8 energy drain (vs CON)

	@SPTABLELO:
		.byte 0
		.byte <(@SP_POISON)
		.byte <(@SP_STEAL)
		.byte <(@SP_DESTROY)
		.byte <(@SP_CHARM)
		.byte <(@SP_CHARM)	; paralyze (same as charm)
		.byte <(@SP_STONE)
		.byte <(@SP_BREATH)
		.byte <(@SP_DRAIN)

	@SPTABLEHI:
		.byte 0
		.byte >(@SP_POISON)
		.byte >(@SP_STEAL)
		.byte >(@SP_DESTROY)
		.byte >(@SP_CHARM)
		.byte >(@SP_CHARM)	; paralyze (same as charm)
		.byte >(@SP_STONE)
		.byte >(@SP_BREATH)
		.byte >(@SP_DRAIN)

;---------------------------------------------------------------------------------------------

@SP_PRINT:
		JSR PAUSE
		JSR ERASETEXTSECTION
		JSR PRINTRETURN
		LDA SPECIALATTACK
		LDY #>(@SPATTACK)
		LDX #<(@SPATTACK)
		JMP PRINTSTRING

;---------------------------------------------------------------------------------------------


@SP_POISON:
		LDA #2
  @DISABLECHAR:
		LDY #33
		STA (PCHARLO),Y
		JMP @NEXTSPECIAL

;-------------------------------

@SP_STEAL:
		LDA #2
		JSR ROLLDICE
		CLC
		ROL
		ADC #29
		TAY
  @REMOVEITEM:
		LDA (PCHARLO),Y
		BNE @CONTINUESTEAL
		JMP @NEXTMONSTER
  @CONTINUESTEAL:
		LDA #0
		STA (PCHARLO),Y
		INY
		STA (PCHARLO),Y
		JMP @NEXTSPECIAL

;-------------------------------

@SP_DESTROY:
		LDY #25
		JMP @REMOVEITEM

;-------------------------------

@SP_CHARM:
		LDA #4
		JMP @DISABLECHAR

;-------------------------------

@SP_STONE:
		LDA #3
		JMP @DISABLECHAR

;-------------------------------

@SP_BREATH:
		JSR @SP_PRINT
		JSR BEEPSOUND
		JSR PAUSE
		LDA #120		; breath can do up to 120 points of damage!
		JSR ROLLDICE1
		JSR DEDUCTHP_SHOW
		JMP @NEXTMONSTER

;-------------------------------

@SP_DRAIN:
		JSR @SP_PRINT
		JSR PAUSE
		JSR FIFTYFIFTY
		BEQ @ONEHP
		LDY #2
		LDA (PCHARLO),Y
		CMP #2			; characters below level 1 cannot be drained
		BPL @CONTINUEDRAIN
		JMP @ONEHP
  @CONTINUEDRAIN:
		; decrease maxhp
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_HP,X
		JSR ROLLDICE1
		JSR SUBMAXHP
		JSR CONPENALTY

		; decrease maxsu
		LDY #1
		LDA (PCHARLO),Y
		TAX
		LDA CLASS_SU,X
		BEQ @EXIT2
		LDY #2
		LDA (PCHARLO),Y
		CMP SPELLSTART,X
		BMI @EXIT2

		LDA SUADVANCE,X
		JSR SUBMAXSU

  @EXIT2:
		; decrease level by 1
		LDY #2
		SEC
		LDA (PCHARLO),Y
		SBC #1
		STA (PCHARLO),Y

		; set xp to previous level
		JSR NEWXP1
		SEC
		SBC #1
		TAY
		JSR NEWXP2

		JSR POINTERXP
		TAX
		JSR STA_FAC2XY	; store new FAC at experience

		INC SPECIALATTACK
		JSR @SP_PRINT
		JSR PAUSE
		JMP @EXIT4
  @ONEHP:
		LDY #15
		LDA #0
		STA (PCHARLO),Y
		INY 
		LDA #1
		STA (PCHARLO),Y
  @EXIT4:
		LDA #0
		JSR DEDUCTHP_SHOW
		JMP @NEXTMONSTER

;---------------------------------------------------------------------------------------------

@MONSTERATTACK:
		LDA #1
		STA MONSTERGREET
		LDA #0
		STA MONSTERROW
		LDA #<(MB_TYPE)
		STA PDUNLO
		LDA #>(MB_TYPE)
		STA PDUNHI
		LDA MB_NUMBER
		BNE @ROWATTACK
  @NEXTROW:
		LDA #<(MF_TYPE)
		STA PDUNLO
		INC MONSTERROW
		LDA MONSTERROW
		CMP #2
		BMI @ROWATTACK
		RTS
  @ROWATTACK:
		LDA #0
		STA MONSTERPTR
  @MONSTERATTACK2:
		JSR ISPARTYMOBILE
		BNE @CHOOSETARGET
		RTS
  @CHOOSETARGET:
		LDA #21
		JSR ROLLDICE
		TAX
		LDA @ATTACKTABLE,X
		STA PCHAR
		STA TEMP1
		JSR ISCHARMOBILE
		BEQ @MONSTERATTACK2

		JSR SELECTCHAR
		JSR ERASETEXTSECTION
		JSR @DRAWMONSTER
		JSR PAUSE

		JSR ERASETEXTSECTION
		JSR PRINTRETURN
		JSR PRINTSPACE
		JSR PRINTSPACE
		LDY #0
		LDA (PDUNLO),Y
		JSR @PRINTMONSTERNAME

		; calculate monster thaco
		LDA #74
		STA TEMP3
		LDY #0			; monster hd/level
		LDA (PDUNLO),Y
		STA TEMP2
		TAX
		LDA MONSTERHD,X		; monster hd
		CLC
		ADC TEMP3
		LDY #6			; dexterity
		SEC
		SBC (PCHARLO),Y
		LDY #25
		SEC
		SBC (PCHARLO),Y		; armor type
		INY			; armor bonus
		SEC
		SBC (PCHARLO),Y
		INY			; shield
		SEC
		SBC (PCHARLO),Y
		INY			; shield bonus
		SEC
		SBC (PCHARLO),Y
		LDY #2			; level
		SEC
		SBC (PCHARLO),Y
		LDX PCHAR
		SEC
		SBC COMBATARMOR,X	; magic defend bonus
		SEC
		SBC COMBATPARRY,X
		CLC
		ADC COMBATBACKSTAB,X
		ROR COMBATBACKSTAB,X	; set combatbackstab back to normal in case of haste
		STA TEMP3
		STA 900

		LDA #127
		JSR ROLLDICE
		CMP TEMP3
		BMI @MONSTERHITS

		LDA #<(@MONSMISSES)
		LDY #>(@MONSMISSES)
		JSR PRINTSTRING_K
		JSR @DRAWMONSTER2
		JMP @NEXTMONSTER

@MONSTERHITS:
		LDA #<(@MONSHITS)
		LDY #>(@MONSHITS)
		JSR PRINTSTRING_K

		LDX TEMP2
		LDA MONSTERDAM,X
		JSR ROLLDICE1
		JSR @ADDEXTRADAM
		PHA
		TAX
		LDA #0
		JSR PRINTINT_XA

		LDA #<(@MONSDAMAGE)
		LDY #>(@MONSDAMAGE)
		JSR PRINTSTRING_K
		JSR @DRAWMONSTER2

		JSR HITSOUND

		PLA
		JSR DEDUCTHP_SHOW

		LDY #0
		LDA (PDUNLO),Y
		TAX
		LDA MONSTER_TS,X
		AND #15
		CMP #0
		BEQ @NEXTMONSTER

		; special attack
		STA SPECIALATTACK
		JSR GETSTATUS
		CMP #1
		BNE @NEXTMONSTER		; special attacks only VS those with a 'good' status

		LDX SPECIALATTACK		; check to make sure the attack is successful
		LDY @SPATTACKROLL,X
		LDA #4
		LDX PCHAR
		SEC
		SBC COMBATSAVE,X

		JSR ROLLSTAT
		BNE @NEXTMONSTER

		LDX SPECIALATTACK
		LDA @SPTABLELO,X
		STA 1
		LDA @SPTABLEHI,X
		STA 2
		JMP (1)				; perform the special attack
		
@NEXTSPECIAL:
		JSR @SP_PRINT
		JSR PRINTSINGLECHAR2

		JSR BEEPSOUND

@NEXTMONSTER:
		JSR PAUSE
		INC MONSTERPTR
		LDA MONSTERPTR
		LDY #1
		CMP (PDUNLO),Y
		BMI @MONSTERGOBACK
		JMP @NEXTROW
  @MONSTERGOBACK:
		JMP @MONSTERATTACK2

@ADDEXTRADAM:
		CLC
		ADC QUESTITERATION
		CMP #0
		BMI @CAPLIMIT
		RTS
@CAPLIMIT:
		LDA #127
		RTS


;---------------------------------------------------------------------------------------------

@ENCMENU:
	.byte "   ",18,"F",146,"IGHT ",18,"R",146,"UN  ",18,"G",146,"REET",0

@SPACE3:
	.byte "   ",0

@FIGHTMENU:
	.byte 13," ",18,"A",146,"TTACK ",18,"B",146,"ACKSTAB ",18,"C",146,"AST"
	.byte 13," ",18,"D",146,"RINK ",18,"P",146,"ARRY ",18,"U",146,"SE ",18,"V",146,"IEW",0

@AMBUSHED:
	.byte 13,"      AMBUSHED!",0

@GREETYOU:
	.byte 13,"  MONSTERS GREET YOU",0

@YOURUN:
	.byte 13,"     YOU RUN AWAY",0

@YOUMISS:
	.byte 13,"       YOU MISS",0

@NOAMMO:
	.byte 13,"       NO AMMO!",0

@YOUHIT1:
	.byte 13,"  YOU DO ",0
@MONSDAMAGE:
@YOUHIT2:
	.byte " DAMAGE",13,"  ",0
@DIES:
	.byte " DIES!",0

@MONSHITS:
	.byte " HITS",13,"  DOES ",0

@MONSMISSES:
	.byte " MISSES",0

@YOULOSE:
	.byte 13,"  PARTY IS DESTROYED",0

@FLEE:
	.byte 13,"  THE MONSTERS FLEE!"

@WINS:
	.byte 13,"  YOU ARE VICTORIOUS",0

@ATTACKTABLE:
	.byte 0,0,0,0,0,0,1,1,1,1,1,2,2,2,2,3,3,3,4,4,5

;---------------------------------------------------------------------------------------------

@DEDUCTMONSTERHP:
		LDY #2
		LDA (PDUNLO),Y
		BMI @DEDUCTMONSTERHP2
		SEC
		SBC TEMP3
		STA (PDUNLO),Y
		CMP #1
		BMI @MONSTERDIES
		RTS
@DEDUCTMONSTERHP2:
		SEC
		SBC TEMP3
		STA (PDUNLO),Y
		RTS
  @MONSTERDIES:
		LDY #0
		LDA (PDUNLO),Y
		JSR @PRINTMONSTERNAME
		LDA #<(@DIES)
		LDY #>(@DIES)
		JSR PRINTSTRING_K
		JSR PAUSE

		; add experience
		LDY #0
		LDA (PDUNLO),Y
		TAX
		LDA MONSTER_TS,X
		AND #15
		STA TEMP4
		LDY #0
		LDA (PDUNLO),Y
		TAX
		LDA MONSTERHD,X
		CLC
		ADC TEMP4

		TAY
		LDA #0
		JSR INT_YA2FAC		; convert special + hd to FAC
		JSR STA_FAC2AFAC	; store FAC in AFAC
		LDY #2
		LDA #0
		JSR INT_YA2FAC		; convert 2 to FAC
		JSR POWER_AFAC_FAC	; FAC = (special attack + hd) ^ 2

		JSR STA_FAC_XPTEMP3

		LDY #0
		LDA (PDUNLO),Y
		TAX
		LDA MONSTERDAM,X
		CLC
		ADC QUESTITERATION
		TAY
		LDA #0

		JSR INT_YA2FAC		; store damage in FAC

		JSR LDAY_XPTEMP3

		JSR MULTIPLY_FAC_AY

		JSR STA_FAC_XPTEMP3

		LDA #10
		JSR ROLLDICE
		TAY
		LDA #0
		JSR INT_YA2FAC

		JSR LDAY_XPTEMP3

		JSR ADD_FAC_AY		; add hit points to fac (1 hp = 1 xp)

		JSR STA_FAC_XPTEMP3

		JSR LDAY_XPTEMP3

		JSR ADDXP		; finally, add the XP :)

  @REMOVEMONSTER:
		; remove a monster
		DEC MORALE
		LDY #1
		LDA (PDUNLO),Y
		TAX
		DEX
		TXA
		STA (PDUNLO),Y
		CMP #0
		BEQ @ROWKILLED

		; get new hp for monster
		TXA
		TAY
		INY
		INY
		LDA (PDUNLO),Y
		LDY #2
		STA (PDUNLO),Y
		RTS


  @ROWKILLED:
		LDA MF_NUMBER
		CMP #0
		BEQ @ROWKILLED1
		RTS
  @PARTYWINS:
		LDA #1
		STA PARTYWINS
		RTS
  @ROWKILLED1:
		LDA MB_NUMBER
		CMP #0
		BEQ @PARTYWINS

		LDX #9
  @RK2:
		LDA MB_TYPE,X
		STA MF_TYPE,X
		DEX
		BPL @RK2

		LDA #0
		STA MB_NUMBER
		RTS

;---------------------------------------------------------------------------------------------

@PRINTMONSTERNAME:
		LDY #>(MONSTERNAME)
		LDX #<(MONSTERNAME)
		JMP PRINTSTRING

@PRINTMONSTERNUMBER:
		PHA
		LDA #<(@SPACE3)
		LDY #>(@SPACE3)
		JSR PRINTSTRING_K
		JSR PRINTPAREN_L
		PLA
		TAX
		LDA #0
		JSR PRINTINT_XA
		JMP PRINTPAREN_R

;---------------------------------------------------------------------------------------------

@DRAWMONSTER:
		LDA #0
		BEQ @DM_CONT
@DRAWMONSTER2:
		LDA #1
		; draw monster
  @DM_CONT:
		STA TEMP2
		LDY #0
		LDA (PDUNLO),Y
		STA MONSTERDISP

@SHOWMONSTER2:
		LDX MONSTERDISP
		JSR SETPIC
		LDA TEMP2
		BNE @DM_CONT2
		JMP DOUBLEPIC
  @DM_CONT2:
		JMP MIRRORDOUBLEPIC

@SHOWMONSTER:
		LDA PIRATESHIP
		BNE @SHOWPIRATESHIP
		LDA ORBTEMP
		BNE @SHOWHELL
@SHOWMONSTER3:
		LDA #0
		STA TEMP2
		JMP @SHOWMONSTER2
  @SHOWPIRATESHIP:
		JMP PIRATEPIC
  @SHOWHELL:
		JMP HELLPIC

;---------------------------------------------------------------------------------------------

@GETMONSTERTYPE:
		LDA MONSTER_TS,X
		JMP AND240_ROR4

;---------------------------------------------------------------------------------------------

@ROLLMONSTERHP:
		TYA
		PHA
		LDY MONSTERHD,X
		DEY
		LDA #0
		STA MATHTEMP
  @ROLLMHP1:
		LDA #8
		JSR ROLLDICE1
		CLC
		ADC MATHTEMP
		STA MATHTEMP
		DEY
		BPL @ROLLMHP1
		PLA
		TAY
		RTS

;---------------------------------------------------------------------------------------------

@ROLLHPBACK:
		LDA #<(MB_HPX)
		STA PDUNLO
		LDY #6
		JMP @ROLLMONSTERSHP

;---------------------------------------------------------------------------------------------

@ROLLHPFRONT:
		LDA #<(MF_HPX)
		STA PDUNLO
		LDY #12

@ROLLMONSTERSHP:
		LDA #>(MF_HPX)
		STA PDUNHI

  @RML:
		JSR @ROLLMONSTERHP
		LDA MATHTEMP
		STA (PDUNLO),Y
		DEY
		BPL @RML
		RTS
		
;---------------------------------------------------------------------------------------------

@SETPCHAR:
		LDA PCHARCOMBAT
		STA PCHAR
		JMP SELECTCHAR

;********************************************************************

STA_FAC_XPTEMP3:
		LDX #<(XPTEMP3)
		LDY #>(XPTEMP3)
		JMP STA_FAC2XY		; store FAC at mem x/y

LDAY_XPTEMP3:
		LDA #<(XPTEMP3)
		LDY #>(XPTEMP3)
		RTS


;********************************************************************

DAMAGEPARTY:

		JSR CHARLOOP1
  @LAV1:
		JSR ISCHARMOBILE
		BEQ @LAV2			; can't hurt characters who are not mobile
		LDA #10
		JSR ROLLDICE1
		JSR DEDUCTHP_SHOW
  @LAV2:
		JSR CHARLOOP2
		BNE @LAV1
		JSR SETPCHARNORMAL
		JMP SELECTCHAR

;********************************************************************

POISONPARTY:
		JSR CHARLOOP1
  @LAV1:
		JSR GETSTATUS
		CMP #1
		BNE @LAV2			; can't poison characters who are not mobile
		LDY #7
		LDA #6
		JSR ROLLSTAT
		BNE @LAV2
		LDY #33
		LDA #2
		STA (PCHARLO),Y			; character is poisoned
  @LAV2:
		JSR CHARLOOP2
		BNE @LAV1
		JSR SETPCHARNORMAL
		JSR HIDESCREEN
		JSR PRINTCHARS
		JSR SHOWSCREEN
		JMP SELECTCHAR

;********************************************************************

PRINTPAREN_L:
		LDA #40
		JMP PRINTCHAR_K

;********************************************************************

PRINTPAREN_R:
		LDA #41
		JMP PRINTCHAR_K

;********************************************************************

AND240_ROR4:
		AND #240
		CLC
		ROR
		ROR
		ROR
		ROR
		RTS

;********************************************************************

CHARLOOP1:
		; when you need to loop through the party, you set it up here
		JSR SETPCHARTEMP
		LDA #0
		STA PCHAR
		STA TEMP1
		RTS

;********************************************************************

CHARLOOP2:
		; for looping through the party
		INC PCHAR
		INC TEMP1
		LDA PCHAR
		CMP #6
		RTS

;********************************************************************

PRINTDUNJON:
		LDA #138
		STA 36878		;  orange aux color

@FACINGX:
		LDX POSDUNFACING
		LDY @DUNJONDATA2,X
		LDX #0
  @FL:
		LDA @DUNJONDATA,Y
		STA TJ,X
		INY
		INX
		CPX #15
		BNE @FL

		JSR @DRAWCOLUMN1

		LDX TJ+0		; immediate left (-1 for facing north)
		JSR @SETPEEKPOS

		AND TJ+1
		CMP TJ+2
		BEQ @LEFTHALLN
		CMP TJ+3
		BEQ @LEFTHALLN
		CMP TJ+4
		BEQ @LEFTDOORN
		JSR @DRAWLEFTWALL
		JMP @MIDDLEN
@LEFTHALLN:
		JSR @DRAWLEFTHALL
		JMP @MIDDLEN
@LEFTDOORN:
		JSR @DRAWLEFTDOOR

@MIDDLEN:
		LDA #1
		STA MOVEFRONT		; flag for determining if you can move forward

		LDX TJ+9		; immediate front (-32 for facing north)
		JSR @SETPEEKPOS

		AND TJ+5
		CMP TJ+6
		BEQ @FRONTHALLN
		CMP TJ+7
		BEQ @FRONTHALLN
		CMP TJ+8
		BEQ @FRONTDOOR2N
		JSR @DRAWFRONTWALL
		LDA #0
		STA MOVEFRONT		; can't move forward!
		JMP @RIGHTN
@FRONTDOOR2N:
		JMP @FRONTDOORN
@FRONTHALLN:
		JSR @DRAWFRONTHALL

; ----------------- one level deeper --------------------------------
		LDX TJ+10		; far left (-33 for facing north)
		JSR @SETPEEKPOS
		AND TJ+1
		CMP TJ+2
		BEQ @FARLEFTHALLN
		CMP TJ+3
		BEQ @FARLEFTHALLN
		CMP TJ+4
		BEQ @FARLEFTDOORN
		JSR @DRAWFARLEFTWALL
		JMP @FARMIDDLEN
@FARLEFTHALLN:
		JSR @DRAWFARLEFTHALL
		JMP @FARMIDDLEN
@FARLEFTDOORN:
		JSR @DRAWFARLEFTDOOR
@FARMIDDLEN:
		
		LDX TJ+11		; far front (-64 for facing north)
		JSR @SETPEEKPOS

		AND TJ+5
		CMP TJ+6
		BEQ @FARFRONTHALLN
		CMP TJ+7
		BEQ @FARFRONTHALLN
		CMP TJ+8
		BEQ @FARFRONTDOORN
		JSR @DRAWFARFRONTWALL
		JMP @FARRIGHTN
@FARFRONTHALLN:
		JSR @DRAWFARFRONTHALL
		JMP @FARRIGHTN
@FARFRONTDOORN:
		JSR @DRAWFARFRONTDOOR
@FARRIGHTN:
		LDX TJ+12		; far right (-32 for facing north)
		JSR @SETPEEKPOS

		AND TJ+1
		CMP TJ+2
		BEQ @FARRIGHTHALLN
		CMP TJ+3
		BEQ @FARRIGHTHALLN
		CMP TJ+4
		BEQ @FARRIGHTDOORN
		JSR @DRAWFARRIGHTWALL
		JMP @FARLADDERN
@FARRIGHTHALLN:
		JSR @DRAWFARRIGHTHALL
		JMP @FARLADDERN
@FARRIGHTDOORN:
		JSR @DRAWFARRIGHTDOOR

@FARLADDERN:
		LDX TJ+14		; far ladders (-32 for facing north)
		JSR @DRAWFARLADDERS
		JMP @RIGHTN
; ----------------- one level deeper --------------------------------

@FRONTDOORN:
		JSR @DRAWFRONTDOOR

@RIGHTN:
		LDX TJ+13			; immediate right (+0 for facing north)
		JSR @SETPEEKPOS

		AND TJ+1
		CMP TJ+2
		BEQ @RIGHTHALLN
		CMP TJ+3
		BEQ @RIGHTHALLN
		CMP TJ+4
		BEQ @RIGHTDOORN
		JSR @DRAWRIGHTWALL
		JMP @COLUMN11N
@RIGHTHALLN:
		JSR @DRAWRIGHTHALL
		JMP @COLUMN11N
@RIGHTDOORN:
		JSR @DRAWRIGHTDOOR

@COLUMN11N:
		JSR @DRAWCOLUMN11
		JMP @OTHERITEMS

; ---------------------------------------------------------------------------

@OTHERITEMS:
		LDA #0
		STA MOVEUP
		STA MOVEDOWN

		LDA POSDUNZ
		CMP #1
		BNE @LADDERUP1
		LDA POSDUNLO
		CMP POSMAPLO
		BNE @LADDERUP1
		LDA POSDUNHI			; always a ladder at 1st level from entry point
		BEQ @LADDERUP2
@LADDERUP1:
		LDX #0
		DEC POSDUNZ
		JSR @SETPEEKPOS
		INC POSDUNZ

		AND #240
		CMP #240
		BNE @LADDERDOWN
@LADDERUP2:
		INC MOVEUP
		LDX #0
  @LOOPLU:
		LDA @LADDERGRAPHIC,X
		STA SCREEN+04,X
		STA SCREEN+26,X
		LDA #1
		STA COLOR+04,X
		STA COLOR+26,X
		INX
		CPX #3
		BNE @LOOPLU
@LADDERDOWN:
		LDA POSDUNZ
		CMP #15
		BEQ @THRONE			; no ladder-downs at 15th level
		LDX #0
		JSR @SETPEEKPOS
		AND #240
		CMP #240
		BNE @THRONE
		INC MOVEDOWN
		LDX #0
  @LOOPLD:
		LDA @LADDERGRAPHIC,X
		STA SCREEN+202,X
		STA SCREEN+224,X
		LDA #1
		STA COLOR+202,X
		STA COLOR+224,X
		INX
		CPX #3
		BNE @LOOPLD
		RTS

@THRONE:
		LDX #0
		JSR @SETPEEKPOS
		AND #252
		CMP #232
		BNE @FOUNTAIN
		LDA #2
		STA MOVEDOWN
		LDX #70
		JMP DUNJONPIC
@FOUNTAIN:
		LDX #0
		JSR @SETPEEKPOS
		AND #252
		CMP #216
		BNE @OI_EXIT
		LDA #3
		STA MOVEDOWN
		LDX #71
		JSR DUNJONPIC
@OI_EXIT:
		RTS


; ---------------------------------------------------------------------------

@DUNJONDATA:
	;       0  1  2  3  4  5  6  7  8   9  10  11  12  13  14
	.byte 255, 3, 1, 2, 3,12, 4, 8,12,224,223,192,224,  0,224
	.byte 224,12, 4, 8,12, 3, 1, 2, 3,  0,225,  1,  1,  0,  1
	.byte   0, 3, 1, 2, 3,12, 4, 8,12,  0, 32, 32, 31,255, 32
	.byte   0,12, 4, 8,12, 3, 1, 2, 3,255,255,254,223,224,255

@DUNJONDATA2:
	.byte 0,15,30,45

@LADDERGRAPHIC:
	.byte 116,117,118

@LEVELPTRHI:
	.byte >(DUNDATA+00*1024)
	.byte >(DUNDATA+01*1024)
	.byte >(DUNDATA+02*1024)
	.byte >(DUNDATA+03*1024)
	.byte >(DUNDATA+04*1024)
	.byte >(DUNDATA+05*1024)
	.byte >(DUNDATA+06*1024)
	.byte >(DUNDATA+07*1024)
	.byte >(DUNDATA+08*1024)
	.byte >(DUNDATA+09*1024)
	.byte >(DUNDATA+10*1024)
	.byte >(DUNDATA+11*1024)
	.byte >(DUNDATA+12*1024)
	.byte >(DUNDATA+13*1024)
	.byte >(DUNDATA+14*1024)
	.byte >(DUNDATA+15*1024)

@DRAW160:
		STY 1
		STY 3
		LDA #>(SCREEN)
		STA 2
		LDA #>(COLOR)
		STA 4
  @DRAW160L:
		LDY POSITION,X
		LDA #160
		STA (1),Y
		LDA TEMP3		; color
		STA (3),Y
		INX
		CPX TEMP4		; maximum pos
		BMI @DRAW160L
		RTS

@DRAWCOLUMN1:
		LDA #111
		STA SCREEN
		LDA #109
		STA SCREEN+220
		LDA #10
		STA COLOR
		STA COLOR+220
		STA TEMP4
		LDX #1
		LDA #2
		STA TEMP3
		LDY #0
		JMP @DRAW160

@DRAWLEFTWALL:
		LDA #111
		STA SCREEN+23
		STA SCREEN+46
		LDA #109
		STA SCREEN+199
		STA SCREEN+178
		LDA #10
		STA COLOR+23
		STA COLOR+46
		STA COLOR+199
		STA COLOR+178
		LDX #2
		STX TEMP3
		LDA #9
		STA TEMP4
		LDY #1
		JSR @DRAW160
		LDA #8
		STA TEMP4
		LDX #3
		LDY #2
		JMP @DRAW160


@DRAWLEFTHALL:
		LDX #3
		LDA #8
		STA TEMP4
		LDA #14
		STA TEMP3
		LDY #1
		JSR @DRAW160
		LDY #2
		LDX #3
		JMP @DRAW160

@DRAWLEFTDOOR:
		LDA #111
		STA SCREEN+23
		STA SCREEN+46
		LDA #10
		STA COLOR+23
		STA COLOR+46
		STA COLOR+45
		STA COLOR+68
		LDA #114
		STA SCREEN+45
		STA SCREEN+68
		LDA #109
		STA SCREEN+199
		STA SCREEN+178
		LDA #15
		STA COLOR+199
		STA COLOR+178
		LDX #3
		LDA #7
		STA TEMP3
		LDA #9
		STA TEMP4
		LDY #1
		JSR @DRAW160
		LDA #8
		STA TEMP4
		LDX #4
		LDY #2
		JMP @DRAW160

@DRAWFRONTHALL:
		LDA #111
		STA SCREEN+69
		LDA #109
		STA SCREEN+157
		LDA #10
		STA COLOR+69
		STA COLOR+157
		STA COLOR+73
		STA COLOR+161

		LDA #112
		STA SCREEN+73
		LDA #110
		STA SCREEN+161

		LDA #7
		STA TEMP4
		LDX #4
		LDA #2
		STA TEMP3
		LDY #3
		JSR @DRAW160
		LDY #7
		LDX #4
		JMP @DRAW160

@DRAWFRONTDOOR:
		LDX #3
		LDA #8
		STA TEMP4
		LDA #2
		STA TEMP3
		LDY #3
		JSR @DRAW160
		LDY #7
		LDX #3
		JSR @DRAW160
		LDA #7
		STA TEMP3
		LDY #4
		LDX #3
		JSR @DRAW160
		LDY #5
		LDX #3
		JSR @DRAW160
		LDY #6
		LDX #3
		JSR @DRAW160
		LDA #2
		STA COLOR+70
		STA COLOR+71
		STA COLOR+72
		RTS

@DRAWFRONTWALL:
		LDX #3
		LDA #8
		STA TEMP4
		LDA #2
		STA TEMP3
		LDY #3
		JSR @DRAW160
		LDY #4
		LDX #3
		JSR @DRAW160
		LDY #5
		LDX #3
		JSR @DRAW160
		LDY #6
		LDX #3
		JSR @DRAW160
		LDY #7
		LDX #3
		JMP @DRAW160

@DRAWRIGHTWALL:
		LDA #112
		STA SCREEN+31
		STA SCREEN+52
		LDA #110
		STA SCREEN+184
		STA SCREEN+207
		LDA #10
		STA COLOR+31
		STA COLOR+52
		STA COLOR+184
		STA COLOR+207
		LDX #2
		STX TEMP3
		LDA #9
		STA TEMP4
		LDY #9
		JSR @DRAW160
		LDA #8
		STA TEMP4
		LDX #3
		LDY #8
		JMP @DRAW160

@DRAWRIGHTHALL:
		LDX #3
		LDA #8
		STA TEMP4
		LDA #14
		STA TEMP3
		LDY #8
		JSR @DRAW160
		LDY #9
		LDX #3
		JMP @DRAW160

@DRAWRIGHTDOOR:
		LDA #112
		STA SCREEN+31
		STA SCREEN+52
		LDA #10
		STA COLOR+31
		STA COLOR+52
		STA COLOR+53
		STA COLOR+74
		LDA #115
		STA SCREEN+53
		STA SCREEN+74
		LDA #110
		STA SCREEN+184
		STA SCREEN+207
		LDA #15
		STA COLOR+184
		STA COLOR+207
		LDX #3
		LDA #7
		STA TEMP3
		LDA #9
		STA TEMP4
		LDY #9
		JSR @DRAW160
		LDA #8
		STA TEMP4
		LDX #4
		LDY #8
		JMP @DRAW160

@DRAWCOLUMN11:
		LDA #112
		STA SCREEN+10
		LDA #110
		STA SCREEN+230
		LDA #10
		STA COLOR+10
		STA COLOR+230
		STA TEMP4
		LDX #1
		LDA #2
		STA TEMP3
		LDY #10
		JMP @DRAW160

@DRAWFARLEFTHALL:
		LDA #160
		STA SCREEN+114
		LDA #14
		STA COLOR+114
		RTS

@DRAWFARLEFTWALL:
		LDA #111
		STA SCREEN+92
		LDA #109
		STA SCREEN+136
		LDA #10
		STA COLOR+92
		STA COLOR+136
		LDA #160
		STA SCREEN+114
		LDA #2
		STA COLOR+114
		RTS

@DRAWFARLEFTDOOR:
		LDA #120
		STA SCREEN+92
		LDA #109
		STA SCREEN+136
		LDA #10
		STA COLOR+92
		STA COLOR+114
		LDA #15
		STA COLOR+136
		LDA #121
		STA SCREEN+114
		RTS

@DRAWFARFRONTHALL:
		LDA #113
		STA SCREEN+115
  @COLOR115:
		LDA #10
  @COLOR_115:
		STA COLOR+115
		RTS

@DRAWFARFRONTWALL:
		LDA #160
		STA SCREEN+115
		LDA #2
		JMP @COLOR_115

@DRAWFARFRONTDOOR:
		LDA #128
		STA SCREEN+115
		JMP @COLOR115

@DRAWFARRIGHTWALL:
		LDA #112
		STA SCREEN+94
		LDA #110
		STA SCREEN+138
		LDA #10
		STA COLOR+94
		STA COLOR+138
		LDA #160
		STA SCREEN+116
		LDA #2
		STA COLOR+116
		RTS

@DRAWFARRIGHTDOOR:
		LDA #165
		STA SCREEN+94
		LDA #110
		STA SCREEN+138
		LDA #10
		STA COLOR+94
		STA COLOR+116
		LDA #15
		STA COLOR+138
		LDA #158
		STA SCREEN+116
		RTS

@DRAWFARRIGHTHALL:
		LDA #160
		STA SCREEN+116
		LDA #14
		STA COLOR+116
		RTS

@DRAWFARLADDERS:
		STX TEMPFAROBJECT
		DEC POSDUNZ
		JSR @SETPEEKPOS
		INC POSDUNZ
		AND #240
		CMP #240
		BNE @FARLADDERUP2N
		JMP @DRAWFLU
  @FARLADDERUP2N:
		LDA POSDUNZ
		CMP #1
		BNE @DRAWFARLADDERDOWN
		LDA PDUNLO
		CMP POSMAPLO
		BNE @DRAWFARLADDERDOWN
		LDA PDUNHI
		AND #3
		CMP #0
		BEQ @DRAWFLU
		JMP @DRAWFARLADDERDOWN
  @DRAWFLU:
		LDA #119
		STA SCREEN+71
		LDA #1
		STA COLOR+71

@DRAWFARLADDERDOWN:
		LDA POSDUNZ
		CMP #15			; down ladders can't appear on the 15th floor
		BEQ @DRAWFARTHRONE

		LDX TEMPFAROBJECT
		JSR @SETPEEKPOS
		AND #240
		CMP #240
		BNE @DRAWFARTHRONE

		LDA #119
@DRAWFARBOTTOM:
		STA SCREEN+159
		LDA #1
		STA COLOR+159
		RTS

@DRAWFARTHRONE:
		LDX TEMPFAROBJECT
		JSR @SETPEEKPOS
		AND #252
		CMP #232
		BNE @DRAWFARFOUNTAIN
		LDA #36
		JMP @DRAWFARBOTTOM

@DRAWFARFOUNTAIN:
		LDX TEMPFAROBJECT
		JSR @SETPEEKPOS
		AND #252
		CMP #216
		BNE @DFL_EXIT
		LDA #37
		JMP @DRAWFARBOTTOM
@DFL_EXIT:
		RTS


@SETPEEKPOS:
		; x is the # of the offset
		STX PDUNLO
		LDA #0
		STA PDUNHI
		LDA POSDUNLO
		CLC
		ADC PDUNLO
		STA PDUNLO
		LDA POSDUNHI
		ADC PDUNHI
		AND #3
		STA PDUNHI
		TXA
		AND #128
		BEQ @PEEKCONTINUE
		DEC PDUNHI
		LDA PDUNHI
		AND #3
		STA PDUNHI

  @PEEKCONTINUE:
		LDY POSDUNZ
		LDA @LEVELPTRHI,Y
		CLC
		ADC PDUNHI
		AND #63
		ORA #192
		STA PDUNHI

		LDY #0
		LDA (PDUNLO),Y
		EOR POSMAPLO
		CLC
		ADC QUESTITERATION
		ADC #0
		RTS

;********************************************************************

RETURNMENU:
		LDA #0
		STA PMENUOFF
		LDX #0
@RM1:
		LDA SCREEN,X
		CMP #160
		BEQ @RM2
@RM3:
		LDA COLOR,X
		AND #15
		CMP #7
		BNE @RM2
		LDA #1
		STA COLOR,X
@RM2:
		INX
		CPX #242
		BNE @RM1
		JMP MAINMENU

;********************************************************************

SETPCHARTEMP:
		LDA PCHAR
		STA PCHARTEMP
		RTS

;********************************************************************

SETPCHARNORMAL:
		LDA PCHARTEMP
		STA PCHAR
		RTS

;********************************************************************

TRAVEL2:
	JSR ISCHARMOBILE
	BNE @CONTINUE
	JMP CHARISIMMOBILE

@CONTINUE:
	LDA #1
	STA PMENUOFF
	LDA #0
	STA PMENU

	LDA POSGAME		; if not in castle, then don't change position
	BNE @EXIT

	LDA #1
	STA POSMAPCARRY
	STA POSGAME
	LDA #14
	STA POSMAPLO
	LDA #5
	STA POSMAPHI

@EXIT:
	RTS

;********************************************************************

CHARISIMMOBILE:
	LDA #<(@ISIMMOBILE)
	LDY #>(@ISIMMOBILE)
	JSR PRINTTEXTSECTION
	JMP PAUSE
@ISIMMOBILE:
	.byte 13,"  CHARACTER IMMOBILE",0

;********************************************************************

TRAVEL:
	; this is where the map or dunjon is going to be drawn on the screen

	LDA POSMAPCARRY
	EOR #1
	STA DRAWMAPCARRY
	LDA POSMAPLO
	SEC
	SBC #163
	STA DRAWMAPLO
	LDA POSMAPHI
	SBC #0
	AND #7
	STA DRAWMAPHI

	LDA #218
	STA 36878	; set auxiliary color to light green

	LDA #0
	STA DRAWMAPX
@T1:

	LDA DRAWMAPLO
	CLC
	ADC #<(MAPDATA)
	STA DRAWMAPLO2
	LDA DRAWMAPHI
	ADC #>(MAPDATA)
	STA DRAWMAPHI2

	;row 1
	LDY #0
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN,X
	LDA TEMP1
	STA COLOR,X

	;row 2
	LDY #32
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+22,X
	LDA TEMP1
	STA COLOR+22,X

	;row 3
	LDY #64
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+44,X
	LDA TEMP1
	STA COLOR+44,X

	;row 4
	LDY #96
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+66,X
	LDA TEMP1
	STA COLOR+66,X

	;row 5
	LDY #128
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+88,X
	LDA TEMP1
	STA COLOR+88,X

	;row 6
	LDY #160
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	CPX #5
	BNE @ROW6
	STA UNDERCHAR			; store tile poke data under character
	LDA #1
	STA TEMP1
	LDY HAVESHIP
	LDA @ACTIVEICON,Y		; print char or ship
@ROW6:
	STA SCREEN+110,X
	LDA TEMP1
	STA COLOR+110,X

	;row 7
	LDY #192
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+132,X
	LDA TEMP1
	STA COLOR+132,X

	;row 8
	LDY #224
	LDX #0
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+154,X
	LDA TEMP1
	STA COLOR+154,X

	;row 9
	LDY #0
	LDX #1
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+176,X
	LDA TEMP1
	STA COLOR+176,X

	;row 10
	LDY #32
	LDX #1
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+198,X
	LDA TEMP1
	STA COLOR+198,X

	;row 11
	LDY #64
	LDX #1
	JSR @GETTILE
	LDX DRAWMAPX
	STA SCREEN+220,X
	LDA TEMP1
	STA COLOR+220,X

	INC DRAWMAPX
	LDA DRAWMAPX
	CMP #11
	BEQ @EXIT
	INC DRAWMAPCARRY
	LDA DRAWMAPCARRY
	CMP #2
	BNE @LOOPBACK
	CLC
	LDA #1
	ADC DRAWMAPLO
	STA DRAWMAPLO
	LDA #0
	ADC DRAWMAPHI
	AND #7
	STA DRAWMAPHI
@LOOPBACK:
	LDA DRAWMAPCARRY
	AND #1
	STA DRAWMAPCARRY
	JMP @T1
@EXIT:
	RTS

@GETTILE:
	; returns character to poke "a" and color to poke "temp1"

	; to check for ship
	TYA
	CLC
	ADC DRAWMAPLO
	STA 1
	TXA
	ADC DRAWMAPHI
	AND #7
	STA 2

	; check for boat!
	LDA HAVESHIP
	CMP #1
	BNE @REGULARTILE
	LDA POS_SHIPCARRY
	CMP DRAWMAPCARRY
	BNE @REGULARTILE
	LDA POS_SHIPLO
	CMP 1
	BNE @REGULARTILE
	LDA POS_SHIPHI
	CMP 2
	BNE @REGULARTILE

	; return boat tile
	LDA #1		; color white
	STA TEMP1
	LDA #30		; ship tile
	RTS

@REGULARTILE:
	;for regular tile
	TYA
	CLC
	ADC DRAWMAPLO2
	STA 1
	TXA
	ADC DRAWMAPHI2
	STA 2
	CMP #>(ENDMAP)
	BEQ @CHECKEQUAL
	BPL @ADJUST
	BMI @GETTILE2
@CHECKEQUAL:
	LDA #<(ENDMAP)
	AND #128
	CLC
	ROR
	STA TEMP1
	LDA 1
	AND #128
	CLC
	ROR
	CMP TEMP1
	BMI @GETTILE2
	BEQ @CHECKEQUAL2
	BPL @ADJUST
@CHECKEQUAL2:
	LDA #<(ENDMAP)
	AND #127
	STA TEMP1
	LDA 1
	AND #127
	CMP TEMP1
	BMI @GETTILE2
@ADJUST:
	LDA 2
	SEC
	SBC #8
	STA 2

@GETTILE2:
	LDY #0
	LDA (1),Y
	LDX DRAWMAPCARRY
	CPX #1
	BEQ @RETURNTILE
	JSR AND240_ROR4

@RETURNTILE:
	AND #15
	TAX
	LDA @CONVERTCOLOR,X
	STA TEMP1
	LDA @CONVERTCHAR,X
	RTS


@CONVERTCHAR:
	.byte 28,29,27,127,123,159,156,126,126,155,157,122,125,31,124,31

@CONVERTCOLOR:
	.byte 13,13,13,12,10,9,9,10,12,9,9,10,10,14,11,11

@ACTIVEICON:
	.byte 0,0,30

;********************************************************************

ISCHARSTATUS:
	STA STATUSTEMP
	JSR GETSTATUS
	CMP STATUSTEMP
	RTS

;********************************************************************

ISPARTYMOBILE:
	JSR SETPCHARTEMP
	LDA #0
	STA PCHAR
@L1:
	JSR ISCHARMOBILE
	BNE @L2
	INC PCHAR
	LDA PCHAR
	CMP #6
	BNE @L1
	JSR SETPCHARNORMAL
	LDA #0
	RTS
@L2:
	JSR SETPCHARNORMAL
	LDA #1
	RTS

;********************************************************************

ISCHARMOBILE:
	JSR GETSTATUS
	TAX
	LDA @STATUSMOBILE,X
	RTS

@STATUSMOBILE:
	;     d g p s z e
	.byte 0,1,1,0,0,0

;********************************************************************

ROLLSTAT:
	STA ROLLTEMP
	JSR PREPARECHARPOINTER
	LDA (PCHARLO),Y		; get stat
	STA STATCHECK
	CLC
	ADC ROLLTEMP
	JSR ROLLDICE
	CMP STATCHECK
	BPL @FAIL
	LDA #1
	RTS
@FAIL:
	LDA #0
	RTS

;********************************************************************

PREPARE3:
		JSR ERASETEXTSECTION
		LDA #0
		STA MOVETEXT
		JMP PRINTCURSORWAIT

;********************************************************************

JOYSTICK:
	sei
	php
	pha
	tya
	pha
	txa
	pha
	lda 37139
	pha
	lda 37154
	pha
	lda #0
	sta JOY1
	sta JOY2
	lda #127
	sta 37154
	lda 37152
	eor #255
	and #128
	rol
	php
	lda #195
	sta 37139
	lda 37137
	eor #255
	and #60
	lsr
	lsr
	plp
	rol
	tay
	and #16
	cmp #16
	bne @d895
	sta JOY2
@d895:
	tya
	and #15
	ldx #0
@d900:
	inx
	cpx #9
	beq @d913
	cmp @d928,x
	bne @d900
	stx JOY1
@d913:
	pla
	sta 37154
	pla
	sta 37139
	pla
	tax
	pla
	tay
	pla
	plp
	cli
@d928:
	rts

	.byte 2,3,1,5,4,12,8,10,0,0,0,0,0,0

;********************************************************************



TURNOFFVOLUME:
		LDA 36878
		AND #240
		STA 36878
		RTS

;---------------------------------------------------

TURNONVOLUME:
		LDA 36878
		ORA #240
		STA 36878
		RTS

;---------------------------------------------------

PLAYMUSIC:
		CMP WHICHSONG
		BEQ @DONOTCHANGEPOSITION
		STA WHICHSONG
		sei
		lda #0
		sta MUSICNOTEPTR
		lda #10
		sta MUSICNOTEDUR

@DONOTCHANGEPOSITION:
		LDX WHICHSONG

		lda @TUNELO,X
		sta MUSICLO
		lda @TUNEHI,X
		sta MUSICHI
		lda #<(PLAYMUSIC2)
		sta 788
		lda #>(PLAYMUSIC2)
		sta 789
		cli
		rts

@TUNELO:
	.byte <(MUSIC_SILENCE)	
	.byte <(MUSIC_BEETHOVEN7)
	.byte <(MUSIC_INT13)
	.byte <(MUSIC_SWANLAKE)
	.byte <(MUSIC_TOCCATA)
	.byte <(MUSIC_FUGUE)
	.byte <(MUSIC_MOONLIGHT)

@TUNEHI:
	.byte >(MUSIC_SILENCE)	
	.byte >(MUSIC_BEETHOVEN7)
	.byte >(MUSIC_INT13)
	.byte >(MUSIC_SWANLAKE)
	.byte >(MUSIC_TOCCATA)
	.byte >(MUSIC_FUGUE)
	.byte >(MUSIC_MOONLIGHT)

;---------------------------------------------------

PLAYMUSIC2:
		php
		pha
		tya
		pha
		txa
		pha

		INC ANITEMP3
		LDA ANITEMP3
		AND #15
		BNE @CONTINUEMUSIC

		; animate lava
		LDA #<(GRAPHICS+127*8)
		STA 253
		LDA #>(GRAPHICS+127*8)
		STA 254
		JSR @REDRAW

		; animate water
		LDA #<(GRAPHICS+31*8)
		STA 253
		LDA #>(GRAPHICS+31*8)
		STA 254
		JSR @REDRAW

		; animate bridge
		LDA #<(GRAPHICS+124*8)
		STA 253
		LDA #>(GRAPHICS+124*8)
		STA 254
		JSR @REDRAW
		JMP @CONTINUEMUSIC

@REDRAW:
		LDY #7
		LDA (253),Y
		STA ANITEMP1
		LDY #0
  @L1:
		LDA (253),Y
		STA ANITEMP2
		LDA ANITEMP1
		STA (253),Y
		LDA ANITEMP2
		STA ANITEMP1
		INY
		CPY #8
		BNE @L1
		RTS

@CONTINUEMUSIC:
		LDA MUSICOFF
		BNE @MUSICOFF

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
		sta 36876
		sta 36874
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
		STA 36874
		STA 36876
		JMP @PULLOUT
@MUSICOFF:
		LDA #0
		JMP @CHANGENOTE


;----------------------------------------------------------------

MUSICNOTES:
	.byte 0			; rest			0
	.byte 135		; C			1
	.byte 143		; C# or Db		2
	.byte 147		; D			3
	.byte 151		; D# or Eb		4
	.byte 159		; E			5
	.byte 163		; F			6
	.byte 167		; F# or Gb		7
	.byte 175		; G			8
	.byte 179		; G# or Ab		9
	.byte 183		; A			10
	.byte 187		; A# or Bb		11
	.byte 191		; B			12
	.byte 195		; C			13
	.byte 199		; C# or Db		14
	.byte 201		; D			15
	.byte 203		; D# or Eb		16
	.byte 207		; E			17
	.byte 209		; F			18
	.byte 212		; F# or Gb		19
	.byte 215		; G			20
	.byte 217		; G# or Ab		21
	.byte 219		; A			22
	.byte 221		; A# or Bb		23
	.byte 223		; B			24
	.byte 225		; C			25
	.byte 227		; C# or Db		26
	.byte 228		; D			27
	.byte 229		; D# or Eb		28
	.byte 231		; E			29
	.byte 232		; F			30
	.byte 233		; F# or Gb		31
;	.byte 235		; G			32
;	.byte 236		; G# or Ab		33
;	.byte 237		; A			34
;	.byte 238		; A# or Bb		35
;	.byte 239		; B			36
;	.byte 240		; C			37
;	.byte 241		; C# or Db		38

NOTEDURATION:

	.byte 5			; 0	1/16 of a second
	.byte 9			; 1	1/8 of a second
	.byte 17		; 2	1/4 of a second
	.byte 25		; 3	3/8 of a second
	.byte 34		; 4	1/2 of a second
	.byte 50		; 5	3/4 of a second
	.byte 70		; 6	1 second
	.byte 100		; 7	1 1/2 seconds


;	.byte 4			; 0	1/16 of a second
;	.byte 8			; 1	1/8 of a second
;	.byte 15		; 2	1/4 of a second
;	.byte 23		; 3	3/8 of a second
;	.byte 30		; 4	1/2 of a second
;	.byte 45		; 5	3/4 of a second
;	.byte 60		; 6	1 second
;	.byte 90		; 7	1 1/2 seconds

;-------------------------------------------------------------------------

MUSIC_SILENCE:
	.byte 0,0,0,255

;-------------------------------------------------------------------------

MUSIC_BEETHOVEN7:
	; beethoven 7th http://www.8notes.com/scores/7214.asp?ftype=gif
	.byte 0		+32*2
	.byte 22	+32*7
	.byte 0

	.byte 13	+32*5
	.byte 13	+32*3
	.byte 13	+32*3
	.byte 12	+32*5
	.byte 12	+32*5

	.byte 12	+32*5
	.byte 12	+32*3
	.byte 12	+32*3
	.byte 13	+32*5
	.byte 13	+32*5

	.byte 13	+32*5
	.byte 13	+32*3
	.byte 15	+32*3
	.byte 17	+32*5
	.byte 17	+32*5

	.byte 15	+32*5
	.byte 10	+32*3
	.byte 13	+32*3
	.byte 17	+32*6

	.byte 20	+32*5
	.byte 20	+32*3
	.byte 22	+32*3
	.byte 24	+32*5
	.byte 24	+32*5

	.byte 19	+32*5
	.byte 18	+32*3
	.byte 21	+32*3
	.byte 22	+32*5
	.byte 22	+32*5

	.byte 17	+32*5
	.byte 17	+32*3
	.byte 17	+32*3
	.byte 15	+32*5
	.byte 17	+32*3

	.byte 17	+32*5
	.byte 19	+32*3
	.byte 21	+32*3
	.byte 22	+32*6
	.byte 0

	.byte 20	+32*5
	.byte 20	+32*3
	.byte 22	+32*3
	.byte 24	+32*5
	.byte 24	+32*5

	.byte 19	+32*5
	.byte 18	+32*3
	.byte 21	+32*3
	.byte 22	+32*5
	.byte 22	+32*5

	; page 2

	.byte 17	+32*5
	.byte 17	+32*3
	.byte 17	+32*3
	.byte 15	+32*5
	.byte 17	+32*5

	.byte 15	+32*5
	.byte 19	+32*3
	.byte 21	+32*3
	.byte 22	+32*6
	.byte 0

	; page 3 bar 3

	.byte 25	+32*5
	.byte 29	+32*3
	.byte 29	+32*3
	.byte 27	+32*5
	.byte 29	+32*5

	.byte 27	+32*2
	.byte 25	+32*2
	.byte 27	+32*3
	.byte 27	+32*3
	.byte 25	+32*2
	.byte 24	+32*2
	.byte 22	+32*6

	.byte 29	+32*5
	.byte 30	+32*3
	.byte 29	+32*3
	.byte 29	+32*6

	.byte 24	+32*5
	.byte 24	+32*3
	.byte 24	+32*3
	.byte 22	+32*5

	.byte 255

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

MUSIC_SWANLAKE:
	.byte 0 	+32*2
	.byte 19	+32*6
	.byte 12	+32*3
	.byte 14	+32*3
	.byte 15	+32*3
	.byte 17	+32*3

	.byte 19	+32*5
	.byte 15	+32*3
	.byte 19	+32*5
	.byte 15	+32*3

	.byte 19	+32*5
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 12	+32*3
	.byte 8 	+32*3
	.byte 15	+32*3

	.byte 12	+32*6
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 15	+32*3
	.byte 14	+32*3

	.byte 19	+32*6
	.byte 12	+32*3
	.byte 14	+32*3
	.byte 15	+32*3
	.byte 17	+32*3

	.byte 19	+32*5
	.byte 15	+32*3
	.byte 19	+32*5
	.byte 15	+32*3

	.byte 19	+32*5
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 12	+32*3
	.byte 8 	+32*3
	.byte 15	+32*3

	.byte 12	+32*6
	.byte 12	+32*4

	.byte 14	+32*4
	.byte 15	+32*4
	.byte 17	+32*4
	.byte 19	+32*3
	.byte 20	+32*3

	.byte 22	+32*5
	.byte 20	+32*3
	.byte 19	+32*4
	.byte 20	+32*3
	.byte 22	+32*3

	.byte 24	+32*5
	.byte 22	+32*3
	.byte 20	+32*4
	.byte 22	+32*3
	.byte 24	+32*3

	.byte 26	+32*5
	.byte 24	+32*3
	.byte 19	+32*3
	.byte 15	+32*3
	.byte 14	+32*3
	.byte 12	+32*3

	.byte 14	+32*4
	.byte 15	+32*4
	.byte 17	+32*4
	.byte 19	+32*3
	.byte 20	+32*3

	.byte 22	+32*5
	.byte 20	+32*3
	.byte 19	+32*4
	.byte 20	+32*3
	.byte 22	+32*3

	.byte 24	+32*5
	.byte 22	+32*3
	.byte 20	+32*4
	.byte 22	+32*3
	.byte 24	+32*3

	.byte 25	+32*5
	.byte 20	+32*3
	.byte 17	+32*4
	.byte 20	+32*3
	.byte 25	+32*5

	.byte 26	+32*5
	.byte 21	+32*3
	.byte 26	+32*5
	.byte 19	+32*3

	.byte 24	+32*4
	.byte 15	+32*4
	.byte 12	+32*4
	.byte 17	+32*5
	.byte 8 	+32*5

	.byte 19	+32*5
	.byte 12	+32*5
	.byte 19	+32*5
	.byte 12	+32*5

	.byte 19	+32*5
	.byte 12	+32*5
	.byte 20	+32*4
	.byte 12	+32*4
	.byte 23	+32*4
	.byte 11	+32*4

	.byte 24	+32*5
	.byte 12	+32*5
	.byte 24	+32*5
	.byte 12	+32*5

	; skip a few bars

	.byte 20	+32*4
	.byte 23	+32*4
	.byte 11	+32*4

	.byte 24	+32*6
	.byte 24	+32*6
	.byte 26	+32*6
	.byte 26	+32*6
	.byte 0 	+32*2

	.byte 19	+32*4
	.byte 17	+32*4
	.byte 14	+32*4
	.byte 11	+32*4

	.byte 7 	+32*4
	.byte 5 	+32*4
	.byte 1 	+32*4

	.byte 255

;---------------------------------------------------------------

MUSIC_TOCCATA:
	.byte 0 	+32*4
	.byte 12 	+32*2
	.byte 10 	+32*2
	.byte 12 	+32*2
	.byte 8 	+32*2
	.byte 12	+32*2
	.byte 7 	+32*2
	.byte 12	+32*2

	.byte 5 	+32*2
	.byte 12	+32*2
	.byte 4 	+32*2
	.byte 12	+32*2
	.byte 5 	+32*2
	.byte 12	+32*2
	.byte 7 	+32*2
	.byte 12	+32*2
	.byte 8 	+32*2
	.byte 12	+32*2
	.byte 2 	+32*2
	.byte 12	+32*2
	.byte 4 	+32*2

	.byte 5 	+32*2
	.byte 12	+32*2
	.byte 4 	+32*2
	.byte 12	+32*2
	.byte 5 	+32*2
	.byte 12	+32*2
	.byte 7 	+32*2
	.byte 12	+32*2
	.byte 8 	+32*2
	.byte 17	+32*2
	.byte 15	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 12	+32*2
	.byte 17	+32*2

	.byte 10	+32*2
	.byte 17	+32*2
	.byte 9 	+32*2
	.byte 17	+32*2
	.byte 10	+32*2
	.byte 17	+32*2
	.byte 12	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 17	+32*2
	.byte 5 	+32*2
	.byte 17	+32*2
	.byte 7 	+32*2
	.byte 17	+32*2
	.byte 9 	+32*2
	.byte 17	+32*2

	.byte 10	+32*2
	.byte 17	+32*2
	.byte 9 	+32*2
	.byte 17	+32*2
	.byte 10	+32*2
	.byte 17	+32*2
	.byte 12	+32*2
	.byte 17	+32*2
	.byte 13	+32*3
	.byte 17	+32*3
	.byte 13	+32*3
	.byte 17	+32*3

	.byte 18	+32*2
	.byte 3 	+32*2
	.byte 10	+32*2
	.byte 3 	+32*2
	.byte 18	+32*2
	.byte 3 	+32*2
	.byte 10	+32*2
	.byte 3 	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 12	+32*2
	.byte 8 	+32*2
	.byte 15	+32*2
	.byte 8 	+32*2
	.byte 12	+32*2
	.byte 8 	+32*2

	.byte 17	+32*2
	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 17	+32*2
	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 13	+32*2
	.byte 7 	+32*2
	.byte 10	+32*2
	.byte 7 	+32*2
	.byte 13	+32*2
	.byte 7 	+32*2
	.byte 10	+32*2
	.byte 7 	+32*2

	.byte 16	+32*2
	.byte 4 	+32*2
	.byte 7 	+32*2
	.byte 4 	+32*2
	.byte 16	+32*2
	.byte 4 	+32*2
	.byte 7 	+32*2
	.byte 4 	+32*2
	.byte 12	+32*2
	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2
	.byte 12	+32*2
	.byte 5 	+32*2
	.byte 8 	+32*2
	.byte 5 	+32*2

	.byte 10	+32*3
	.byte 4 	+32*3
	.byte 10	+32*3
	.byte 4 	+32*3
	.byte 8 	+32*3
	.byte 5 	+32*3
	.byte 8 	+32*3
	.byte 5 	+32*3

	.byte 7 	+32*2
	.byte 10	+32*2
	.byte 1 	+32*2
	.byte 10	+32*2
	.byte 7 	+32*2
	.byte 10	+32*2
	.byte 1		+32*3
	.byte 8 	+32*2
	.byte 24	+32*2
	.byte 22	+32*2
	.byte 24	+32*2
	.byte 20	+32*2
	.byte 24	+32*2
	.byte 19	+32*2
	.byte 24	+32*2
	
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 16	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 19	+32*2
	.byte 24	+32*2
	.byte 20	+32*2
	.byte 24	+32*2
	.byte 12	+32*2
	.byte 24	+32*2
	.byte 14	+32*2
	.byte 24	+32*2
	.byte 15	+32*2
	.byte 24	+32*2

	.byte 17	+32*2
	.byte 24	+32*2
	.byte 16	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 19	+32*2
	.byte 24	+32*2
	.byte 20	+32*2
	.byte 24	+32*2
	.byte 19	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 24	+32*2
	.byte 15	+32*2
	.byte 24	+32*2

	.byte 13	+32*2
	.byte 24	+32*2
	.byte 15	+32*2
	.byte 24	+32*2
	.byte 17	+32*2
	.byte 22	+32*2
	.byte 14	+32*2
	.byte 22	+32*2
	.byte 19	+32*2
	.byte 22	+32*2
	.byte 17	+32*2
	.byte 22	+32*2
	.byte 15	+32*2
	.byte 22	+32*2
	.byte 13	+32*2
	.byte 22	+32*2

	.byte 12	+32*2
	.byte 22	+32*2
	.byte 13	+32*2
	.byte 22	+32*2
	.byte 15	+32*2
	.byte 20	+32*2
	.byte 12	+32*2
	.byte 20	+32*2
	.byte 17	+32*2
	.byte 20	+32*2
	.byte 15	+32*2
	.byte 20	+32*2
	.byte 13	+32*2
	.byte 20	+32*2
	.byte 12	+32*2
	.byte 20	+32*2

	.byte 10	+32*2
	.byte 20	+32*2
	.byte 12	+32*2
	.byte 20	+32*2
	.byte 13	+32*2
	.byte 19	+32*2
	.byte 10	+32*2
	.byte 19	+32*2
	.byte 16	+32*2
	.byte 19	+32*2
	.byte 13	+32*2
	.byte 19	+32*2
	.byte 12	+32*2
	.byte 19	+32*2
	.byte 10	+32*2
	.byte 19	+32*2

	.byte 8 	+32*2
	.byte 19	+32*2
	.byte 10	+32*2
	.byte 19	+32*2
	.byte 12	+32*2
	.byte 17	+32*2
	.byte 8 	+32*2
	.byte 17	+32*2
	.byte 7 	+32*2
	.byte 19	+32*2
	.byte 7 	+32*2
	.byte 19	+32*2
	.byte 5 	+32*2
	.byte 17	+32*2
	.byte 5 	+32*2
	.byte 17	+32*2

	.byte 13	+32*2
	.byte 16	+32*2
	.byte 13	+32*2
	.byte 16	+32*2
	.byte 12	+32*2
	.byte 17	+32*2
	.byte 8 	+32*2
	.byte 17	+32*2
	.byte 7 	+32*2
	.byte 19	+32*2
	.byte 7 	+32*2
	.byte 19 	+32*2
	.byte 7 	+32*2

	.byte 0  	+32*4
	.byte 22	+32*3
	.byte 20	+32*3
	.byte 22	+32*6
	.byte 0		+32*4
	.byte 20	+32*3
	.byte 18	+32*3
	.byte 17	+32*3
	.byte 15	+32*3
	.byte 14	+32*6
	.byte 15	+32*6
	.byte 255

;--------------------------------------------------------------------

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

	.byte 15	+32*4
	.byte 0 	+32*1

	.byte 15	+32*3

	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*3
	.byte 20	+32*3
	.byte 19	+32*2
	.byte 20	+32*2
	.byte 17	+32*2
	.byte 19	+32*2
	.byte 15	+32*3
	.byte 20	+32*2
	.byte 15	+32*2

	.byte 16	+32*3
	.byte 13	+32*3
	.byte 6 	+32*3
	.byte 18	+32*3
	.byte 15	+32*2
	.byte 16	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*3
	.byte 16	+32*2
	.byte 11	+32*2

	.byte 13	+32*3
	.byte 10	+32*3
	.byte 3 	+32*3
	.byte 15	+32*3
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 13	+32*2

	.byte 15	+32*2
	.byte 16 	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 16	+32*2
	.byte 18	+32*2
	.byte 20	+32*2
	.byte 16	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 18	+32*2
	.byte 16	+32*2
	.byte 15	+32*2

	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 13	+32*2

	.byte 15	+32*3
	.byte 17	+32*3
	.byte 18	+32*2
	.byte 20	+32*2
	.byte 18	+32*2
	.byte 20	+32*2
	.byte 22	+32*3
	.byte 17	+32*3
	.byte 18	+32*4
	.byte 0 	+32*1

	; bring it home

	.byte 22	+32*2
	.byte 20	+32*2
	.byte 22	+32*2

	.byte 18	+32*2
	.byte 20	+32*2
	.byte 17	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*2
	.byte 20	+32*2
	.byte 18	+32*2
	.byte 20	+32*2

	.byte 17	+32*2
	.byte 18	+32*2
	.byte 15	+32*2
	.byte 17	+32*2
	.byte 13	+32*2
	.byte 15	+32*2
	.byte 11	+32*2
	.byte 13	+32*2
	.byte 10	+32*2
	.byte 11	+32*2
	.byte 8 	+32*2
	.byte 10	+32*2
	.byte 6 	+32*2
	.byte 18	+32*2
	.byte 17	+32*2
	.byte 18	+32*2

	.byte 15	+32*2
	.byte 17	+32*2
	.byte 14	+32*2
	.byte 15	+32*2
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 10	+32*4
	.byte 12	+32*3
	.byte 13	+32*3

	.byte 15	+32*3
	.byte 8 	+32*3
	.byte 10	+32*6

	.byte 255

;--------------------------------------------------------------------

MUSIC_MOONLIGHT:

	; Moonlight Sonata (Beethoven)

	.byte 0 	+32*2
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3

	.byte 10	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 10	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 10	+32*3
	.byte 15	+32*3
	.byte 19 	+32*3
	.byte 10	+32*3
	.byte 15	+32*3
	.byte 19	+32*3 

	.byte 9 	+32*3
	.byte 13	+32*3
	.byte 19	+32*3
	.byte 9 	+32*3
	.byte 13	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 16	+32*3
	.byte 7 	+32*3
	.byte 13	+32*3
	.byte 16	+32*3

	.byte 5 	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 21	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 21	+32*2

	.byte 21	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 9 	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 9 	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 21	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 21	+32*2

	.byte 21	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 22	+32*3
	.byte 14	+32*3
	.byte 19	+32*3
	.byte 10	+32*3
	.byte 14	+32*3
	.byte 19	+32*3

	.byte 21	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 19	+32*3
	.byte 12	+32*3
	.byte 16	+32*3
	.byte 24	+32*3
	.byte 12	+32*3
	.byte 16	+32*3

	.byte 17	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 9 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3

	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*2

	.byte 20	+32*3
	.byte 12	+32*3
	.byte 18	+32*3
	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 18	+32*3
	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 18	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 18	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 18	+32*3
	.byte 20	+32*2

	.byte 20	+32*3
	.byte 13	+32*3
	.byte 17	+32*3
	.byte 8 	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 8 	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 19	+32*3
	.byte 14	+32*3
	.byte 17	+32*3

	.byte 19	+32*3
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 7 	+32*3
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 14	+32*3
	.byte 17	+32*3
	.byte 12	+32*3
	.byte 14	+32*3

	.byte 19	+32*3
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 7 	+32*3
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 19	+32*3
	.byte 11	+32*3
	.byte 14	+32*3
	.byte 7 	+32*3
	.byte 11	+32*3
	.byte 14	+32*3

	.byte 12	+32*3
	.byte 15	+32*3
	.byte 19	+32*3
	.byte 12	+32*3
	.byte 15	+32*3
	.byte 19	+32*3
	.byte 12	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 24	+32*3
	.byte 16	+32*3
	.byte 19	+32*3

	.byte 25	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 23	+32*3
	.byte 17	+32*3
	.byte 20	+32*3

	.byte 24	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 12	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 12	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 24	+32*3
	.byte 16	+32*3
	.byte 19	+32*3

	.byte 25	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 20	+32*3
	.byte 23	+32*3
	.byte 17	+32*3
	.byte 20	+32*3

	.byte 24	+32*3
	.byte 19	+32*3
	.byte 22	+32*3
	.byte 12	+32*3
	.byte 19	+32*3
	.byte 22	+32*3
	.byte 24	+32*3
	.byte 19	+32*3
	.byte 22	+32*3
	.byte 12	+32*3
	.byte 17	+32*3
	.byte 21	+32*3

	.byte 22	+32*3
	.byte 17	+32*3
	.byte 21	+32*3
	.byte 22	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 21	+32*3
	.byte 16	+32*3
	.byte 19	+32*3
	.byte 21	+32*3
	.byte 14	+32*3
	.byte 17	+32*3

	.byte 19	+32*3
	.byte 14	+32*3
	.byte 16	+32*3
	.byte 21 	+32*3
	.byte 14	+32*3
	.byte 16	+32*3
	.byte 21	+32*4
	.byte 14	+32*4
	.byte 16	+32*4
	.byte 22	+32*4
	.byte 14	+32*4
	.byte 16	+32*4

	.byte 21	+32*5
	.byte 14	+32*5
	.byte 17	+32*5
	.byte 21	+32*5
	.byte 13	+32*5
	.byte 16	+32*5

	.byte 255



;********************************************************************

; more graphics!

TEMPLEGRAPHIC:
	.byte 59,59,11,3,3,11,59,59,187,187,187,187,187,171,186,187,184,184,176,128,128,176,184,184,126,127,127,127,126,106,127,85,255,175,250,251,171,254,254,85,1,7,7
	.byte 31,31,127,127,111,80,210,210,218,74,74,66,84,170,191,221,255,255,191,175,170,129,161,225,225,192,192,0,129,64,208,208,244,125,125,125,249,123,126,126,126,126
	.byte 123,31,27,231,182,214,218,218,218,246,247,250,191,191,175,170,170,170,255,169,173,253,233,169,169,169,247,237,237,189,253,253,189,228,244,30,31,7,31,127,125,20,0
	.byte 247,183,183,218,106,170,170,85,255,255,255,170,170,170,170,85,245,253,253,169,168,168,170,85,208,208,244,253,125,29,21,0,253,233,173,253,253,253,253,85

BOLZAIMGRAPHIC:
	.byte 0,0,0,63,191,191,63,21,0,5,5,5,170,170,5,5,0,2,10,10,10,7,7,23,170,170,170,170,170,255,125,255,0,128,160,160,160,208,208,212,21,21,63,63,63,63,63,15,5,0,0
	.byte 2,250,250,250,250,23,23,85,165,165,169,170,170,255,85,125,85,85,85,170,170,212,213,85,85,85,101,165,169,170,170,170,170,170,85,85,170,170,170,170,191,191,191
	.byte 191,191,191,149,149,149,191,127,127,191

HELLGRAPHIC:
	.byte 5,26,106,106,106,106,26,5,64,144,164,164,164,164,144,64,231,103,121,153,158,95,229,255,159,159,231,231,121,159,229,255,166,166,230,246,0,160,168,10,170
	.byte 170,234,250,254,255,255,255,4,4,60,63,63,60,52,52,10,43,21,47,47,47,47,3,160,224,80,224,224,224,192,192,166,166,166,166,170,171,175,191,170,100,168,168,168,40,40
	.byte 170,52,55,55,55,4,15,15,175,255,255,255,63,63,63,255,255,252,252,252,252,252,254,254,252,63,21,21,149,252,84,86,106,164,132,164,166,2,170,170,170

PARTYGRAPHIC:
	.byte 10,42,170,174,166,174,174,175,160,168,170,186,154,186,186,250,1,5,5,22,25,25,89,101,84,101,149,87,95,111,255,255,80,84,212,212,213,153,217,217,171,168,171
	.byte 171,15,5,21,170,234,42,234,234,240,80,84,170,101,101,89,89,89,89,101,85,252,255,254,250,63,207,240,255,217,213,213,217,217,89,101,85,2,10,42,169,165,167,165
	.byte 167,170,169,85,85,95,255,93,190,168,106,90,218,218,218,90,218,255,175,171,170,169,169,166,90,85,234,170,170,168,166,166,90,167,167,175,175,175,175,165,165,190,255
	.byte 255,243,255,85,85,65,218,218,218,218,218,250,90,90,170,42,42,62,55,63,255,255,168,170,174,174,190,190,250,250,165,165,165,165,165,169,42,170,0,85,85,85,85,85
	.byte 85,170,90,90,90,90,90,106,168,170,63,63,63,15,2,10,42,170,250,250,252,240,170,170,170,170

;----------------------------------------------------------------


MAPDATA:
	; 64x64 world map 2 map tiles per byte
	
	; 0 = grass
	; 1 = forest
	; 2 = swamp
	; 3 = lava
	; 4 = road
	; 5 = town
	; 6 = castle
	; 7 = dunjon
	; 8 = wizard's dunjon
	; 9 = west of castle
	; 10 = east of castle
	; 11 = brick wall
	; 12 = mountain
	; 13 = deep water
	; 14 = bridge
	; 15 = shallow water

	.byte 204,204,17,17,16,0,0,17,17,29,221,221,221,221,221,221,221,221,221,221,208,0,0,28,204,204,193,16,0,0,0,0
	.byte 204,204,17,17,17,17,17,17,17,45,221,221,221,220,204,204,221,221,221,221,0,0,0,17,204,204,193,16,0,0,0,0
	.byte 12,204,193,17,17,17,17,17,18,45,221,221,220,204,204,204,205,221,221,221,0,0,0,1,28,204,204,16,0,0,0,0
	.byte 12,204,193,17,0,1,17,17,34,34,221,221,220,204,199,204,205,221,221,221,0,0,0,1,17,204,204,17,0,0,0,0
	.byte 0,204,204,17,5,1,17,17,34,34,221,221,220,204,193,204,221,221,221,221,0,0,0,17,17,28,204,193,16,0,0,0
	.byte 0,204,204,17,0,1,17,34,34,32,13,221,220,204,17,204,221,221,221,221,0,0,1,17,31,252,204,193,17,16,0,0
	.byte 0,28,204,17,17,17,18,34,34,32,13,221,221,17,17,17,221,221,221,221,0,0,1,17,255,17,204,204,17,17,16,0
	.byte 1,28,204,17,17,17,18,34,34,32,13,221,221,209,17,17,29,221,221,208,0,0,17,17,241,17,28,204,204,17,17,16
	.byte 17,17,204,193,17,31,255,242,34,32,13,221,221,221,17,16,17,221,221,208,0,0,17,17,241,17,17,204,204,17,17,17
	.byte 17,17,204,204,17,31,221,255,34,32,0,221,221,221,208,0,0,221,221,208,0,1,17,17,255,255,241,28,204,204,17,17
	.byte 17,17,28,204,193,31,221,223,34,0,0,221,221,221,221,0,80,13,221,208,0,17,17,18,34,34,255,17,28,204,204,204
	.byte 204,204,28,204,193,47,221,223,255,255,239,253,221,221,221,208,0,13,221,221,1,17,17,34,34,34,47,17,17,28,204,204
	.byte 204,195,51,204,193,47,253,255,34,0,64,13,221,221,221,208,0,221,221,221,17,17,17,34,39,34,47,241,17,17,28,204
	.byte 204,195,51,51,204,34,255,242,32,0,64,0,221,221,221,221,221,221,221,221,223,254,255,34,34,34,33,241,17,17,17,17
	.byte 28,204,51,51,60,194,34,34,32,0,64,0,221,221,221,221,221,221,221,221,209,20,31,242,34,33,17,241,17,17,17,17
	.byte 17,28,204,51,51,204,34,34,32,0,64,0,13,221,221,221,221,221,221,221,209,20,17,255,255,255,255,255,241,17,17,17
	.byte 17,17,28,204,51,204,194,34,32,0,64,0,0,221,221,221,221,221,221,221,221,4,1,17,17,17,17,17,255,255,255,17
	.byte 17,17,17,28,195,60,194,34,0,0,64,0,0,13,221,221,221,221,221,221,221,4,0,1,17,17,17,17,17,17,31,17
	.byte 17,17,17,17,204,60,194,32,0,0,64,0,0,13,221,221,221,221,221,221,221,4,68,1,17,17,17,17,17,31,255,255
	.byte 255,17,17,17,204,140,194,32,0,0,64,0,0,0,221,221,221,221,221,221,221,0,4,0,1,17,17,31,255,255,221,221
	.byte 223,241,17,17,204,204,194,0,0,0,64,0,0,0,13,221,221,221,221,221,221,208,0,0,0,1,17,255,221,221,221,221
	.byte 223,241,17,17,28,204,194,0,0,0,64,0,0,0,0,221,221,221,221,221,221,221,5,4,68,1,31,253,221,204,205,221
	.byte 221,241,17,0,204,204,192,0,0,0,64,0,0,0,0,13,221,221,221,221,221,221,0,0,4,0,31,221,220,204,204,221
	.byte 221,241,17,0,204,204,0,0,0,0,64,0,0,0,0,0,221,221,221,221,221,221,208,0,4,0,255,221,220,199,204,221
	.byte 221,241,16,12,204,192,0,0,0,0,64,0,0,0,0,0,13,221,221,221,221,221,223,240,4,0,253,221,220,192,204,221
	.byte 223,241,16,204,204,0,5,4,68,68,68,68,68,68,68,0,13,221,221,221,221,221,221,255,254,255,253,221,221,222,221,221
	.byte 223,17,16,204,207,254,255,0,0,0,0,0,0,0,4,0,0,221,221,221,221,221,221,255,4,0,255,253,221,222,221,221
	.byte 255,17,0,204,192,0,15,255,255,0,0,0,0,0,4,0,0,13,221,221,221,221,221,208,4,0,1,255,253,222,221,255
	.byte 17,16,0,204,112,0,0,0,15,0,0,0,0,0,4,0,0,0,221,221,221,221,221,208,4,68,1,17,255,254,255,241
	.byte 17,0,0,204,204,17,16,0,15,240,0,0,0,0,4,68,68,64,29,221,221,221,221,221,0,4,0,1,17,4,15,17
	.byte 0,0,0,204,204,193,17,16,0,255,255,255,240,0,0,0,0,64,17,221,221,221,221,221,0,4,0,0,1,4,15,16
	.byte 0,0,0,204,204,255,255,255,255,242,34,0,255,255,0,0,0,64,17,253,221,221,221,221,208,4,0,0,0,4,15,0
	.byte 0,0,0,204,193,17,17,17,18,34,34,32,0,15,255,240,0,64,31,253,221,221,221,221,208,4,68,5,4,68,15,0
	.byte 0,0,12,204,17,28,193,17,34,34,34,34,0,0,0,255,255,239,255,255,221,221,221,221,208,4,0,0,0,0,15,0
	.byte 0,0,12,204,204,204,113,18,34,34,34,34,32,0,15,240,0,64,1,255,221,221,221,221,208,4,0,0,0,0,15,0
	.byte 0,0,204,204,17,28,193,18,34,255,255,255,255,254,255,0,0,64,1,17,221,221,221,221,208,4,0,0,0,0,255,0
	.byte 0,12,204,193,17,17,17,255,255,240,0,0,0,4,0,0,0,64,0,17,29,221,221,221,208,4,0,0,0,15,240,0
	.byte 0,204,204,255,255,255,255,240,0,0,0,0,0,4,0,0,0,64,0,17,29,221,221,221,0,4,0,0,0,255,0,0
	.byte 0,204,193,16,0,0,0,0,4,68,68,68,68,68,68,68,68,64,1,17,29,221,221,221,4,68,0,0,255,240,0,0
	.byte 12,204,192,0,68,68,68,68,68,0,0,0,0,4,0,0,0,0,17,17,221,221,221,221,4,0,0,255,240,0,0,0
	.byte 204,204,0,68,64,0,0,0,0,0,0,0,0,4,0,0,0,1,17,29,221,221,221,221,4,15,255,240,0,0,0,12
	.byte 204,192,4,64,0,0,0,0,0,0,0,0,0,4,0,0,1,17,17,221,221,221,221,223,254,255,0,0,0,0,0,204
	.byte 192,0,68,0,13,221,221,221,221,208,0,0,187,180,187,176,1,17,221,221,221,221,221,0,4,0,0,0,0,0,0,204
	.byte 0,68,64,13,221,221,221,221,221,221,208,0,180,68,68,176,13,221,221,221,221,221,0,0,4,0,0,0,0,0,12,204
	.byte 4,64,0,221,221,221,221,221,221,221,221,221,180,150,164,189,221,221,221,221,221,208,0,0,4,0,0,0,0,0,204,204
	.byte 4,0,13,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,208,0,0,0,4,0,0,0,0,12,204,192
	.byte 4,0,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,221,208,0,0,0,0,4,0,0,0,0,12,204,192
	.byte 4,0,221,221,221,221,221,0,180,84,176,221,221,221,221,221,221,221,221,0,0,0,0,0,4,0,0,0,0,204,204,192
	.byte 4,0,221,221,221,221,208,0,180,68,176,0,0,221,221,221,208,0,0,0,0,4,68,68,68,0,0,0,204,204,204,0
	.byte 4,0,221,221,221,221,208,0,187,75,176,0,0,0,0,0,0,0,0,4,68,68,0,0,0,0,0,204,204,204,192,0
	.byte 4,0,13,221,221,221,221,0,0,64,0,0,68,68,68,68,68,68,68,68,0,0,0,0,0,12,204,204,204,204,0,0
	.byte 4,0,1,221,221,221,221,208,0,68,68,68,64,0,0,0,0,0,0,0,0,0,0,0,204,204,204,204,204,192,0,0
	.byte 4,0,1,29,221,221,221,221,0,0,0,0,0,0,12,204,204,204,204,192,0,0,12,204,204,204,204,204,204,0,0,0
	.byte 4,0,1,28,221,221,221,221,208,0,0,0,0,0,0,0,204,204,204,204,204,204,204,204,51,204,204,204,0,0,0,0
	.byte 4,0,1,28,204,221,221,221,221,221,0,0,0,0,0,0,0,0,204,204,204,204,195,51,60,204,192,0,0,0,0,0
	.byte 4,0,17,204,17,13,221,221,221,221,221,208,0,0,0,0,0,0,0,12,204,195,51,60,204,192,0,0,0,0,0,0
	.byte 4,0,28,204,17,17,29,221,221,221,221,221,221,0,0,0,0,0,0,0,204,195,51,204,204,0,0,0,0,0,0,0
	.byte 4,1,28,193,17,17,17,221,221,221,221,221,221,221,0,0,0,0,0,0,12,204,51,204,192,0,0,0,0,0,0,0
	.byte 4,1,204,17,17,17,17,17,221,221,221,192,205,221,221,0,0,0,0,0,0,204,204,204,112,0,80,68,68,68,68,68
	.byte 68,12,204,17,17,17,17,17,29,221,220,192,204,221,221,221,208,0,0,0,0,12,204,204,192,0,0,0,0,0,0,0
	.byte 0,12,193,17,16,0,0,17,29,221,220,199,204,221,221,221,221,208,0,0,0,1,204,204,204,0,0,0,0,0,0,0
	.byte 0,204,17,17,0,204,192,1,17,221,220,204,204,221,221,221,221,221,208,0,0,1,28,204,204,192,0,0,0,0,0,0
	.byte 12,204,17,17,0,199,192,1,17,221,221,204,205,221,221,221,221,221,221,208,0,0,17,204,204,193,0,0,0,0,0,0
	.byte 204,204,17,17,0,192,192,1,17,29,221,221,221,221,221,221,221,221,221,221,208,0,1,28,204,193,16,0,0,0,0,0
ENDMAP:

;-----------------------------------------------------------------------------------------------

DISABLERUNSTOP:
		BIT $9111
		RTI
