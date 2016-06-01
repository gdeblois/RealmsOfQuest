		.org 14334
		.segment "STARTUP"

				.word	MAIN
		
MAIN:

;		monster data at memory location 14336
;		this file is called "RQ4.B" on the game disk


monstername:
.byte "ELF",0         ; level  1
.byte "CENTIPEDE",0         ; level  1
.byte "GNOME",0         ; level  1
.byte "GOBLIN",0         ; level  1
.byte "HOBBIT",0         ; level  1
.byte "KOBOLD",0         ; level  1
.byte "ORC",0         ; level  1
.byte "SHRIEKER",0         ; level  1
.byte "SKELETON",0         ; level  1
.byte "STIRGE",0         ; level  1
.byte "AXE BEAK",0         ; level  2
.byte "BROWNIE",0         ; level  2
.byte "BUGBEAR",0         ; level  2
.byte "DEVIL LEMURE",0         ; level  2
.byte "DWARF",0         ; level  2
.byte "GARGOYLE",0         ; level  2
.byte "GHOUL",0         ; level  2
.byte "GNOLL",0         ; level  2
.byte "QUASIT",0         ; level  2
.byte "WERERAT",0         ; level  2
.byte "BLINK DOG",0         ; level  3
.byte "APE",0         ; level  3
.byte "CARRION",0         ; level  3
.byte "DEMON MANES",0         ; level  3
.byte "GREEN SLIME",0         ; level  3
.byte "JACKALWERE",0         ; level  3
.byte "LEPRECHAUN",0         ; level  3
.byte "OGRE",0         ; level  3
.byte "PIERCER",0         ; level  3
.byte "PSEUDODRAGON",0         ; level  3
.byte "CATOBLEPAS",0         ; level  4
.byte "COCKATRICE",0         ; level  4
.byte "GIANT SPIDER",0         ; level  4
.byte "LAMIA",0         ; level  4
.byte "MINOTAUR",0         ; level  4
.byte "OGRE MAGE",0         ; level  4
.byte "OWL BEAR",0         ; level  4
.byte "SIREN",0         ; level  4
.byte "WEREWOLF",0         ; level  4
.byte "ZOMBIE",0         ; level  4
.byte "ANKHEG",0         ; level  5
.byte "BASILISK",0         ; level  5
.byte "DISPLACER",0         ; level  5
.byte "GIANT SLUG",0         ; level  5
.byte "HELL HOUND",0         ; level  5
.byte "MANTICORE",0         ; level  5
.byte "MEDUSA",0         ; level  5
.byte "OTYUGH",0         ; level  5
.byte "SUCCUBUS",0         ; level  5
.byte "WEREBOAR",0         ; level  5
.byte "CHIMERA",0         ; level  6
.byte "ETTIN",0         ; level  6
.byte "GORGON",0         ; level  6
.byte "HILL GIANT",0         ; level  6
.byte "LAMMASU",0         ; level  6
.byte "LURKER",0         ; level  6
.byte "MUMMY",0         ; level  6
.byte "NEO-OTYUGH",0         ; level  6
.byte "SU-MONSTER",0         ; level  6
.byte "WERETIGER",0         ; level  6
.byte "AIR EL",0         ; level  7
.byte "CLAY GOLEM",0         ; level  7
.byte "HYDRA",0         ; level  7
.byte "RAKHASA",0         ; level  7
.byte "SHAMBLER",0         ; level  7
.byte "SPECTRE",0         ; level  7
.byte "STONE GIANT",0         ; level  7
.byte "STONE GOLEM",0         ; level  7
.byte "TROLL",0         ; level  7
.byte "WIGHT",0         ; level  7
.byte "BLACK DRAGON",0         ; level  8
.byte "DRAGONNE",0         ; level  8
.byte "EARTH ELEMENT",0         ; level  8
.byte "FIRE ELEMENT",0         ; level  8
.byte "IRON GOLEM",0         ; level  8
.byte "MARILITH",0         ; level  8
.byte "WATER ELEMENT",0         ; level  8
.byte "WEREBEAR",0         ; level  8
.byte "WHITE DRAGON",0         ; level  8
.byte "WRAITH",0         ; level  8
.byte "BEHOLDER",0         ; level  9
.byte "BERZERKER",0         ; level  9
.byte "GHOST",0         ; level  9
.byte "GREEN DRAGON",0         ; level  9
.byte "LICH",0         ; level  9
.byte "PURPLE WORM",0         ; level  9
.byte "RED DRAGON",0         ; level  9
.byte "SILVER DRAGON",0         ; level  9
.byte "WYVERN",0         ; level  9
.byte "YEENOGHU",0         ; level  9
.byte "ASMODEUS",0         ; level 10
.byte "BALRON",0         ; level 10
.byte "DEMOGORGON",0         ; level 10
.byte "ERINYES",0         ; level 10
.byte "FIRE GIANT",0         ; level 10
.byte "GOLD DRAGON",0         ; level 10
.byte "ORCUS",0         ; level 10
.byte "STORM GIANT",0         ; level 10
.byte "TITAN",0         ; level 10
.byte "VAMPIRE",0         ; level 10
.byte "TIME LORD",0         ; level 11


; 15239
monsterstats:
.byte 1,10,0,30,1,8,1,0,0,0,0                ; ELF
.byte 1,2,1,34,4,2,1,0,0,0,3                ; CENTIPEDE
.byte 1,6,0,30,1,6,1,0,0,0,0                ; GNOME
.byte 1,7,0,31,1,6,1,0,0,0,0                ; GOBLIN
.byte 2,3,0,32,1,6,1,0,0,0,0                ; HOBBIT
.byte 1,4,0,32,1,4,1,0,0,0,0                ; KOBOLD
.byte 1,8,0,29,1,8,1,0,0,0,0                ; ORC
.byte 1,2,1,32,1,2,1,0,0,0,5                ; SHRIEKER
.byte 1,6,2,32,1,6,1,0,0,0,0                ; SKELETON
.byte 1,8,1,33,2,6,1,0,0,0,0                ; STIRGE
.byte 3,8,1,31,2,3,2,0,0,0,0                ; AXE BEAK
.byte 1,4,0,32,1,3,2,0,0,4,6                ; BROWNIE
.byte 3,8,0,30,2,6,2,0,0,0,0                ; BUGBEAR
.byte 3,8,3,32,1,3,2,0,0,0,1                ; DEVIL LEMURE
.byte 2,6,0,29,1,10,2,0,0,0,0                ; DWARF
.byte 4,8,0,25,2,3,2,0,0,0,0                ; GARGOYLE
.byte 2,8,2,30,1,3,2,0,0,0,4                ; GHOUL
.byte 2,8,0,29,1,8,2,0,0,0,0                ; GNOLL
.byte 3,6,1,27,1,4,2,0,0,0,0                ; QUASIT
.byte 3,8,1,30,1,8,2,0,0,0,3                ; WERERAT
.byte 4,8,1,30,1,6,3,0,0,0,4                ; BLINK DOG
.byte 5,8,1,31,2,8,3,0,0,0,0                ; APE
.byte 3,8,1,29,3,2,3,0,0,0,5                ; CARRION
.byte 1,12,3,28,2,8,3,0,0,0,4                ; DEMON MANES
.byte 2,8,1,34,1,6,3,0,0,4,10                ; GREEN SLIME
.byte 4,8,1,29,1,4,3,0,0,3,3                ; JACKALWERE
.byte 3,4,0,33,1,3,3,0,0,4,6                ; LEPRECHAUN
.byte 4,8,0,27,1,10,3,0,0,0,0                ; OGRE
.byte 4,8,1,28,2,6,3,0,0,0,0                ; PIERCER
.byte 2,8,0,25,1,3,3,0,0,0,8                ; PSEUDODRAGON
.byte 10,6,1,26,1,6,4,0,0,0,0                ; CATOBLEPAS
.byte 5,8,1,29,1,3,4,0,0,0,7                ; COCKATRICE
.byte 5,8,1,29,2,4,4,0,0,0,3                ; GIANT SPIDER
.byte 15,5,0,28,1,4,4,0,0,0,0                ; LAMIA
.byte 6,8,0,25,1,12,4,0,0,0,0                ; MINOTAUR
.byte 5,8,0,28,1,12,4,0,0,1,2                ; OGRE MAGE
.byte 5,8,1,30,2,10,4,0,0,0,0                ; OWL BEAR
.byte 3,8,0,30,2,4,4,0,0,6,6                ; SIREN
.byte 5,8,1,29,1,12,4,0,0,0,3                ; WEREWOLF
.byte 4,8,2,29,1,10,4,0,0,3,3                ; ZOMBIE
.byte 5,8,1,27,1,6,5,0,0,3,5                ; ANKHEG
.byte 5,8,1,25,1,10,5,0,0,0,7                ; BASILISK
.byte 6,8,1,29,2,6,5,0,0,0,4                ; DISPLACER
.byte 12,8,1,33,1,12,5,0,0,0,0                ; GIANT SLUG
.byte 6,8,3,29,1,6,5,0,0,0,8                ; HELL HOUND
.byte 6,8,1,29,6,6,5,0,0,0,0                ; MANTICORE
.byte 6,8,0,28,1,4,5,0,0,7,7                ; MEDUSA
.byte 7,8,1,28,3,6,5,0,0,0,0                ; OTYUGH
.byte 6,8,3,25,2,3,5,0,0,0,11                ; SUCCUBUS
.byte 8,8,1,26,1,8,5,0,0,0,3                ; WEREBOAR
.byte 9,8,1,27,2,6,6,0,0,0,8                ; CHIMERA
.byte 10,8,0,24,2,10,6,0,0,0,0                ; ETTIN
.byte 8,8,1,25,2,6,6,0,0,0,7                ; GORGON
.byte 9,8,0,26,1,20,6,0,0,0,0                ; HILL GIANT
.byte 8,8,1,25,2,12,6,0,0,0,0                ; LAMMASU
.byte 10,8,1,29,1,6,6,0,0,0,10                ; LURKER
.byte 6,8,2,26,1,12,6,0,3,3,11                ; MUMMY
.byte 9,8,1,25,2,12,6,0,0,0,0                ; NEO-OTYUGH
.byte 12,8,1,27,2,12,6,0,0,0,0                ; SU-MONSTER
.byte 10,8,1,25,2,10,6,0,0,0,3                ; WERETIGER
.byte 16,8,1,27,2,10,7,0,0,0,4                ; AIR EL
.byte 10,8,1,27,3,10,7,0,0,0,4                ; CLAY GOLEM
.byte 8,8,0,29,8,8,7,0,0,0,0                ; HYDRA
.byte 7,8,3,10,2,15,7,0,0,0,0                ; RAKHASA
.byte 8,8,1,24,4,8,7,0,0,0,10                ; SHAMBLER
.byte 10,8,2,27,1,8,7,0,0,11,11                ; SPECTRE
.byte 12,8,0,24,2,12,7,0,0,0,0                ; STONE GIANT
.byte 12,8,1,23,3,8,7,0,0,0,4                ; STONE GOLEM
.byte 10,8,0,27,3,10,7,0,0,0,1                ; TROLL
.byte 10,8,2,27,1,10,7,0,0,2,11                ; WIGHT
.byte 15,8,0,14,2,15,8,0,0,0,8                ; BLACK DRAGON
.byte 18,8,0,25,2,10,8,0,0,0,8                ; DRAGONNE
.byte 16,8,1,27,4,8,8,0,0,0,4                ; EARTH ELEMENT
.byte 16,8,1,27,3,8,8,0,0,0,4                ; FIRE ELEMENT
.byte 16,8,1,21,4,10,8,0,0,0,4                ; IRON GOLEM
.byte 8,11,3,17,8,8,8,0,9,9,9                ; MARILITH
.byte 16,8,1,27,3,8,8,0,0,0,4                ; WATER ELEMENT
.byte 15,8,1,25,2,10,8,0,0,3,3                ; WEREBEAR
.byte 12,8,0,16,2,10,8,0,0,0,8                ; WHITE DRAGON
.byte 15,8,2,25,2,15,8,0,0,4,9                ; WRAITH
.byte 32,9,1,17,2,8,9,0,2,5,9                ; BEHOLDER
.byte 25,10,0,15,3,15,9,0,0,0,0                ; BERZERKER
.byte 18,8,2,24,2,15,9,0,11,11,11                ; GHOST
.byte 22,10,0,12,1,15,9,0,0,2,8                ; GREEN DRAGON
.byte 26,8,2,21,3,10,9,0,2,4,9                ; LICH
.byte 30,15,1,28,4,10,9,0,0,0,10                ; PURPLE WORM
.byte 25,8,0,13,2,12,9,0,0,2,8                ; RED DRAGON
.byte 20,10,0,11,2,10,9,0,0,2,8                ; SILVER DRAGON
.byte 20,10,0,23,3,15,9,0,0,2,2                ; WYVERN
.byte 20,8,3,20,1,18,9,0,5,5,9                ; YEENOGHU
.byte 35,8,3,15,4,15,10,0,5,9,9                ; ASMODEUS
.byte 36,12,3,23,1,13,10,0,9,10,11                ; BALRON
.byte 40,10,3,10,3,30,10,0,4,9,11                ; DEMOGORGON
.byte 25,6,3,5,2,8,10,0,7,7,7                ; ERINYES
.byte 25,12,0,13,2,30,10,0,5,8,9                ; FIRE GIANT
.byte 25,10,0,10,2,25,10,0,2,8,8                ; GOLD DRAGON
.byte 30,10,3,16,3,20,10,0,2,5,9                ; ORCUS
.byte 30,10,0,9,2,40,10,0,2,9,9                ; STORM GIANT
.byte 50,10,0,15,4,40,10,0,1,5,9                ; TITAN
.byte 30,8,2,19,3,20,10,0,6,11,11                ; VAMPIRE
.byte 10,50,4,28,1,50,12,0,0,8,9                ; TIME LORD




