		.org 38398
		.segment "STARTUP"

				.word	MAIN
		
		
		; Spell Tables at memory location 38400
MAIN:

RACES:
.byte 3,3,3,3,3,3,4,4    ; Human
.byte 3,4,3,4,2,4,0,9    ; Elf
.byte 4,2,3,2,4,2,10,5    ; Dwarf
.byte 2,3,4,4,3,3,6,6    ; Hobbit
.byte 4,1,3,4,4,1,3,3    ; Gnoll
.byte 2,3,5,3,3,2,15,7    ; Gnome
.byte 2,1,2,3,2,1,5,0    ; Kobold
.byte 5,1,1,1,5,1,4,2    ; Ogre
.byte 4,2,2,3,4,1,2,1    ; Orc
.byte 1,5,3,5,1,5,10,8    ; Sprite


CLASSES:
.byte 12,0,0,4,4,1,0,0,0,0,0,0,2,12,0,0,0,9,0   ; Fighter
.byte 4,0,0,1,1,0,6,0,1,0,2,0,5,0,12,0,9,0,0   ; Wizard
.byte 8,0,0,2,3,1,0,6,0,1,2,0,3,9,0,12,0,0,0   ; Priest
.byte 6,1,0,3,2,0,0,0,0,0,0,1,1,9,0,0,12,0,0   ; Thief
.byte 6,0,0,3,2,0,4,4,3,3,1,0,6,9,12,12,12,0,12   ; Bard
.byte 10,0,0,4,4,1,6,6,5,5,2,0,8,12,12,12,12,12,15   ; Lord
.byte 6,1,1,2,1,0,0,2,0,3,1,0,2,9,0,9,9,0,0   ; Monk
.byte 8,1,1,3,2,0,2,0,3,0,1,1,4,9,9,0,15,0,0   ; Ninja
.byte 10,0,0,4,4,1,0,4,0,4,1,0,3,12,0,12,0,9,12   ; Paladin
.byte 6,0,0,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0   ; Peasant
.byte 10,0,0,4,2,1,4,0,4,0,1,0,5,12,12,0,9,9,12   ; Ranger
.byte 4,0,0,1,1,0,6,6,2,2,2,0,7,0,12,12,12,0,0   ; Sage



WIZ_SPELLS:
.byte 0,1,1    ; 1 CHARM MONSTER
.byte 1,1,1    ; 1 FIND FAMILIAR
.byte 2,1,1    ; 1 MAGIC MISSILE
.byte 3,1,2    ; 1 SLEEP
.byte 4,1,1    ; 1 STINKING CLOUD
.byte 4,2,1    ; 2 CLOUDKILL
.byte 5,1,0    ; 2 DETECT MAGIC(M)
.byte 2,2,1    ; 2 LIGHTNING BOLT
.byte 6,0,0    ; 2 REVEAL LOCATION
.byte 7,0,1    ; 2 STRENGTH
.byte 2,1,2    ; 3 FIREBALL
.byte 7,1,1    ; 3 HASTE
.byte 1,3,1    ; 3 MONSTER SUMMON 1
.byte 3,2,1    ; 3 PHANTASMAL FORCE
.byte 5,3,0    ; 3 WIZARD'S EYE(W)
.byte 8,1,1    ; 4 DIMENSION DOOR
.byte 7,0+4,1    ; 4 ENCHANTED WEAPON
.byte 3,2,2    ; 4 FEAR
.byte 2,2,2    ; 4 ICE STORM
.byte 0,2,1    ; 4 MESMERIZE
.byte 4,2,2    ; 5 DEATH
.byte 1,6,1    ; 5 MONSTER SUMMON 2
.byte 7,0+8,1    ; 5 MORDENKAIS SWORD
.byte 3,2,3    ; 5 POWER WORD STUN
.byte 9,4,1    ; 5 STONE TO FLESH
.byte 1,9,0    ; 6 CLONE
.byte 8,10,1    ; 6 GATE
.byte 2,2,3    ; 6 METEOR SWARM
.byte 4,2,3    ; 6 POWER WORD KILL
.byte 7,1,2    ; 6 TIME STOP




PRI_SPELLS:
.byte 7,2,2    ; 1 BLESS
.byte 10,1,1    ; 1 CURE LIGHT WNDS
.byte 5,0,0    ; 1 LIGHT(L)
.byte 7,3,2    ; 1 PROT. FROM EVIL
.byte 11,1,2    ; 1 TURN THE UNDEAD
.byte 11,2,2    ; 2 EXILE THE UNDEAD
.byte 12,1,1    ; 2 EXORCISM
.byte 5,2,0    ; 2 INVISIBILITY(I)
.byte 7,3+8,1    ; 2 MIRROR IMAGE
.byte 0,1,2    ; 2 SPEAK WITH DEAD
.byte 10,2,1    ; 3 CURE SERIOUS WDS
.byte 5,4,0    ; 3 FIND TRAPS(T)
.byte 7,2+4,2    ; 3 PRAYER
.byte 9,3,1    ; 3 REMOVE CURSE
.byte 7,3+4,2    ; 3 SPIRITUAL SHIELD
.byte 0,2,2    ; 4 COMMUNE W. DEAD
.byte 9,2,1    ; 4 CURE POISON
.byte 5,5,0    ; 4 DETECT EVIL(E)
.byte 12,1,2    ; 4 EXCOMMUNICATION
.byte 9,3,2    ; 4 REMOVE ALL CRSES
.byte 1,4,2    ; 5 CACODEMON
.byte 9,2,2    ; 5 CURE ALL POISONS
.byte 10,3,1    ; 5 CURE CRIT WOUNDS
.byte 5,6,0    ; 5 TRUE SIGHT(S)
.byte 9,5,1    ; 5 RAISE DEAD
.byte 1,8,2    ; 6 ASTRAL SPELL
.byte 12,1,3    ; 6 HOLY SYMBOL
.byte 10,3,2    ; 6 RESTORATION
.byte 9,5,1    ; 6 RESURRECTION
.byte 8,0,1    ; 6 WORD OF RECALL



