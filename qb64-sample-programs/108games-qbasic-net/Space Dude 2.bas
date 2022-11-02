'                                                ______
'                                               /      \
'                                              /        \
'                      /                                 \
'        /  |\    /|  /     /     |      |  _             \
'       /   |/   / | /     /     /| | | /| |/             /    
'      /__  |   /--| \    /__    \|  \| \| \_            /    written 10/97 by
'        /  |  /   |  \   \                             /      Jason
'       /              \   \                           /         Interactive
'      /                                              /
'                                              ______/______
DECLARE SUB GAMEOVER ()
DECLARE SUB SPAWN ()
DECLARE SUB MOVIE ()
DECLARE SUB BADHANDLER ()
DECLARE SUB DEBRISDRA ()
COMMON SHARED NRG%
COMMON SHARED NUMBG%
DIM SHARED BULLETX%(5)
DIM SHARED BULLETY%(5)
COMMON SHARED XI%
COMMON SHARED YI%
NUMBG% = 10
NRG% = 320
RANDOMIZE TIMER
TYPE DEBRISO
X AS INTEGER
Y AS INTEGER
CLR AS INTEGER
XVEL AS INTEGER
YVEL AS INTEGER
END TYPE
TYPE EVILOO
X AS INTEGER
Y AS INTEGER
STAT AS INTEGER
END TYPE
DIM SHARED EVIL(100) AS EVILOO
DIM SHARED DEBRIS(100) AS DEBRISO
FOR P% = 0 TO 99
DEBRIS(P%).X = 150
DEBRIS(P%).Y = 100
DEBRIS(P%).CLR = INT(RND * 15) + 1
DEBRIS(P%).XVEL = INT(RND * 6) - 3
DEBRIS(P%).YVEL = INT(RND * 6) - 3
NEXT
CALL MOVIE
SCREEN 7, , 0, 0
LINE (0, 0)-(319, 150), 9, BF
LINE (0, 150)-(319, 199), 1, BF
FOR N% = 150 TO 199
V% = V% + INT(RND * 15) - 2
LINE (0, N%)-(V%, N%), 14
NEXT
V% = 0
FOR N% = 150 TO 199
V% = V% + INT(RND * 13) - 4
LINE (0, N%)-(V%, N%), 2
NEXT
QUEUE$ = "******"
SCREEN 7, , 1, 2
N% = -1
ON TIMER(1) GOSUB HHH
XI% = 150
YI% = 125
DO
FR% = FR% + 1
N% = N% + 1
IF N% = 100 THEN N% = 0
'DEBRIS(N%).X = XI%
'DEBRIS(N%).Y = YI%
'DEBRIS(N%).CLR = 17
'DEBRIS(N%).XVEL = XV% + INT(RND * 8) - 4
'DEBRIS(N%).YVEL = -7
PCOPY 0, 1
'CLS
LINE (0, 1)-(NRG%, 6), 4, BF
LINE (0, 0)-(319, 7), 15, B
'LOCATE 1, 1: PRINT NRG%
CALL DEBRISDRA
FOR NNN% = 0 TO 4
IF G% = 0 THEN LINE (BULLETX%(NNN%) - 2, BULLETY%(NNN%))-(BULLETX%(NNN%) + 2, BULLETY%(NNN%) + 5), INT(RND * 16), BF
BULLETY%(NNN%) = BULLETY%(NNN%) - 5
IF BULLETY%(NNN%) < -15 THEN BULLETY%(NNN%) = -15
NEXT
CALL BADHANDLER
LINE (XI%, YI% - 2)-(XI% - 14, YI% + 6), 0
LINE (XI%, YI% - 2)-(XI% + 14, YI% + 6), 0
LINE (XI% + 14, YI% + 6)-(XI%, YI% + 4), 0
LINE (XI% - 14, YI% + 6)-(XI%, YI% + 4), 0
PAINT (XI%, YI%), 0, 0
LINE (XI% - 2, YI%)-(XI% + 2, YI% + 2), 4, BF
K$ = INKEY$
K$ = RIGHT$(K$, 1)
IF NOT K$ = "" THEN QUEUE$ = QUEUE$ + K$
IF LEN(QUEUE$) = 7 THEN QUEUE$ = RIGHT$(QUEUE$, 6)
IF QE% = 1 THEN LOCATE 6, 1: PRINT QUEUE$
IF QUEUE$ = "GODNOW" THEN GOD% = GOD% + 1: QUEUE$ = "******"
IF QUEUE$ = "SHOWQU" THEN QE% = QE% + 1: QUEUE$ = "******"
IF QE% = 2 THEN QE% = 0
IF GOD% = 1 THEN NRG% = 320
IF GOD% = 2 THEN GOD% = 0
IF K$ = "H" THEN K$ = "U"
IF K$ = "K" THEN K$ = "H"
IF K$ = "M" THEN K$ = "J"
IF K$ = "P" THEN K$ = "N"
IF K$ = "-" THEN TIMER ON
IF K$ = "=" THEN TIMER OFF
IF K$ = "H" THEN XV% = XV% - 10
IF K$ = "J" THEN XV% = XV% + 10
IF K$ = "N" THEN YV% = YV% + 10
IF K$ = "U" THEN YV% = YV% - 10
IF K$ = "&" THEN
SCREEN 7
END IF
IF K$ = "*" THEN
DEF SEG = &HA000
BSAVE "A:\GMEBG.BGR", 0, &HFFF9
DEF SEG
END IF
IF K$ = "G" THEN G% = G% + 1: IF G% = 2 THEN G% = 0
FOR NNN% = 0 TO 4
IF G% = 1 THEN BULLETX%(CUR%) = XI% + SIN(V% / 2.5) * 8
IF G% = 1 THEN BULLETY%(CUR%) = YI% + COS(V% / 2.5) * 8
IF G% = 1 THEN V% = V% + 1: CIRCLE (BULLETX%(NNN%), BULLETY%(NNN%)), 2, INT(RND * 16)
NEXT
IF V% > 15 THEN V% = 0
IF G% = 1 THEN CIRCLE (XI%, YI%), V%, 14
IF K$ = " " THEN
IF BULLETY%(CUR%) < 0 THEN
BULLETX%(CUR%) = XI%
BULLETY%(CUR%) = YI%
END IF
END IF
XI% = XI% + XV%
YI% = YI% + YV%
IF NOT XV% = 0 THEN XV% = XV% / 1.2
IF NOT YV% = 0 THEN YV% = YV% / 1.2
IF ABS(XV%) = 2 THEN XV% = 0
IF ABS(YV%) = 2 THEN YV% = 0
IF XI% > 320 THEN XI% = 319
IF XI% < 0 THEN XI% = 1
IF YI% > 200 THEN YI% = 199
IF YI% < 0 THEN YI% = 1
IF NRG% <= 0 THEN CALL GAMEOVER: END
FOR P% = 0 TO NUMBG%
NEXT
CUR% = CUR% + 1
IF CUR% = 5 THEN CUR% = 0
PCOPY 1, 2
LOOP UNTIL K$ = CHR$(27)
END
HHH:
SCREEN 7, , 0, 0
LOCATE 5, 1: PRINT FR%
FR% = 0
SCREEN 7, , 1, 2
RETURN

SUB BADHANDLER
'X AS INTEGER
'Y AS INTEGER
'STAT AS INTEGER
'LOCATE 1, 1: PRINT XI%, YI%
FOR P% = 0 TO NUMBG%
IF EVIL(P%).STAT = 4 THEN
IF NRG% > 0 THEN VVV% = VVV% + 1
GOTO PPOP
END IF
IF NRG% < 0 AND INT(RND * 5) = 1 THEN
BULLETX%(0) = EVIL(P%).X
BULLETY%(0) = EVIL(P%).Y
EVIL(P%).STAT = 0
END IF
IF EVIL(P%).X% > XI% - 15 AND EVIL(P%).X% < XI% + 15 AND EVIL(P%).Y% > YI% - 15 AND EVIL(P%).Y% < YI% + 15 THEN
NRG% = NRG% - 5
SOUND NRG% + 1000, .1
SCREEN 7, , 1, 2
END IF
FOR NNN% = 0 TO 4
IF BULLETX%(NNN%) > EVIL(P%).X - 15 AND BULLETX%(NNN%) < EVIL(P%).X + 15 AND BULLETY%(NNN%) > EVIL(P%).Y - 5 AND BULLETY%(NNN%) < EVIL(P%).Y + 15 THEN
EVIL(P%).STAT = 4
BULLETY%(NNN%) = -5
CIRCLE (EVIL(P%).X, EVIL(P%).Y), INT(RND * 50), 14
FOR N% = 1 TO INT(RND * 70) + 2
DEBRIS(N%).X = EVIL(P%).X
DEBRIS(N%).Y = EVIL(P%).Y
DEBRIS(N%).CLR = P% MOD 14 + 2
FFF% = N%
NEXT
DEBRIS(FFF%).CLR = -1
DEBRIS(FFF%).X = EVIL(P%).X
DEBRIS(FFF%).Y = EVIL(P%).Y
DEBRIS(FFF%).XVEL = INT(RND * 6) - 2
DEBRIS(FFF%).YVEL = -INT(RND * 4)
FFF% = INT(RND * 100)
DEBRIS(FFF%).CLR = -1
DEBRIS(FFF%).X = EVIL(P%).X
DEBRIS(FFF%).Y = EVIL(P%).Y
DEBRIS(FFF%).XVEL = INT(RND * 6) - 3
DEBRIS(FFF%).YVEL = -INT(RND * 4)
END IF
NEXT
IF EVIL(P%).STAT = 0 THEN
EVIL(P%).X% = EVIL(P%).X + 3
IF INT(RND * 50) = 1 THEN EVIL(P%).STAT = 1
'IF INT(RND * 20) = 3 THEN SOUND INT(RND * 100) + 37, .1
END IF
IF EVIL(P%).STAT = 1 THEN
EVIL(P%).X% = EVIL(P%).X - 3
' INT(RND * 100) + 37, .1
'IF INT(RND * 20) = 3 THEN   INT(RND * 100) + 37, .1
IF INT(RND * 50) = 1 THEN EVIL(P%).STAT = 0
END IF
IF INT(RND * 100) = 5 THEN
EVIL(P%).STAT = 2
END IF
IF EVIL(P%).STAT = 2 THEN
EVIL(P%).Y% = EVIL(P%).Y + 6
'IF INT(RND * 2) = 0 THEN   2037 - EVIL(P%).Y, .1
N% = INT(RND * 100)
IF INT(RND * 7) = 0 THEN
DEBRIS(N%).X = EVIL(P%).X%
DEBRIS(N%).Y = EVIL(P%).Y%
DEBRIS(N%).XVEL = INT(RND * 6) - 3
DEBRIS(N%).YVEL = -1
DEBRIS(N%).CLR = 17
END IF
END IF
IF EVIL(P%).STAT = 5 THEN
EVIL(P%).Y = EVIL(P%).Y - 5
IF EVIL(P%).Y < 20 + INT(RND * 10) THEN EVIL(P%).STAT = 0
END IF
CIRCLE (EVIL(P%).X, EVIL(P%).Y), 4, P% MOD 14 + 2
PAINT (EVIL(P%).X, EVIL(P%).Y), P% MOD 14 + 2, P% MOD 14 + 2
CIRCLE (EVIL(P%).X - 2, EVIL(P%).Y - 2), 2, 15
PAINT (EVIL(P%).X - 2, EVIL(P%).Y - 2), 15, 15
CIRCLE (EVIL(P%).X + 2, EVIL(P%).Y - 2), 2, 15
PAINT (EVIL(P%).X + 2, EVIL(P%).Y - 2), 15, 15
SELECT CASE EVIL(P%).STAT
CASE 0
PSET (EVIL(P%).X + 3, EVIL(P%).Y - 2), 0
PSET (EVIL(P%).X - 2, EVIL(P%).Y - 2), 0
CASE 1
PSET (EVIL(P%).X + 2, EVIL(P%).Y - 2), 0
PSET (EVIL(P%).X - 3, EVIL(P%).Y - 2), 0
CASE 2
PSET (EVIL(P%).X - 2, EVIL(P%).Y - 1), 0
PSET (EVIL(P%).X + 2, EVIL(P%).Y - 1), 0
CIRCLE (EVIL(P%).X - 2, EVIL(P%).Y - 1), 1, 4
CIRCLE (EVIL(P%).X + 2, EVIL(P%).Y - 1), 1, 4
CIRCLE (EVIL(P%).X, EVIL(P%).Y + 3), 2, 0
PAINT (EVIL(P%).X, EVIL(P%).Y + 3), 0, 0
CASE 5
PSET (EVIL(P%).X - 2, EVIL(P%).Y - 2), 0
PSET (EVIL(P%).X + 2, EVIL(P%).Y - 2), 0
LINE (EVIL(P%).X - 3, EVIL(P%).Y - 5)-(EVIL(P%).X + 3, EVIL(P%).Y - 4), P% MOD 14 + 2, BF
CIRCLE (EVIL(P%).X, EVIL(P%).Y + 2), 1, 0
END SELECT
IF EVIL(P%).X > 310 THEN EVIL(P%).X = 310
IF EVIL(P%).X < 10 THEN EVIL(P%).X = 10
IF EVIL(P%).Y > 200 THEN
EVIL(P%).Y = 200: EVIL(P%).STAT = 5
FOR N% = 1 TO 15
V% = INT(RND * 100)
DEBRIS(V%).CLR = P% MOD 14 + 2
DEBRIS(V%).X = EVIL(P%).X
DEBRIS(V%).Y = EVIL(P%).Y
DEBRIS(V%).XVEL = INT(RND * 26) - 13
DEBRIS(V%).YVEL = -5
NEXT
END IF
PPOP:
NEXT
IF VVV% = NUMBG% + 1 THEN LOCATE 1, 1: PRINT "FINISHED!!!!": CALL SPAWN
END SUB

SUB BD
SCREEN 7, , 0, 0

SCREEN 7, , 1, 2
END SUB

SUB DEBRISDRA
FOR P% = 1 TO 98 STEP 2
PSET (DEBRIS(P%).X, DEBRIS(P%).Y), DEBRIS(P%).CLR
DEBRIS(P%).X = DEBRIS(P%).X + DEBRIS(P%).XVEL
IF DEBRIS(P%).X > 320 THEN DEBRIS(P%).X = 319: DEBRIS(P%).XVEL = -DEBRIS(P%).XVEL \ 3
IF DEBRIS(P%).X < 0 THEN DEBRIS(P%).X = 1: DEBRIS(P%).XVEL = -DEBRIS(P%).XVEL \ 3
IF INT(RND * 2) = 1 THEN DEBRIS(P%).YVEL = DEBRIS(P%).YVEL + 1
IF DEBRIS(P%).CLR = 14 THEN DEBRIS(P%).YVEL = -5
DEBRIS(P%).Y = DEBRIS(P%).Y + DEBRIS(P%).YVEL
IF DEBRIS(P%).Y < 0 THEN DEBRIS(P%).Y = 1: DEBRIS(P%).YVEL = 0
IF DEBRIS(P%).Y > 200 THEN DEBRIS(P%).Y = 200: DEBRIS(P%).YVEL = 0
'IF INT(RND * 5000) = 2 AND DEBRIS(P%).CLR = 14 THEN
'LINE -(DEBRIS(P%).X, DEBRIS(P%).Y), DEBRIS(P%).CLR
'END IF
IF DEBRIS(P%).CLR <= 15 AND DEBRIS(P%).CLR >= 0 THEN
LINE -(DEBRIS(P%).X, DEBRIS(P%).Y), DEBRIS(P%).CLR
IF INT(RND * 50) = 2 THEN CIRCLE (DEBRIS(P%).X, DEBRIS(P%).Y), 1, DEBRIS(P%).CLR
END IF
'''IF INT(RND * 5) = 3 THEN
'''CIRCLE (DEBRIS(P%).X, DEBRIS(P%).Y), INT(RND * 2) + 1, DEBRIS(P%).CLR
'''END IF
'P% = P% - 1
IF DEBRIS(P%).CLR = -1 THEN
CIRCLE (DEBRIS(P%).X, DEBRIS(P%).Y), 2, 15
PAINT (DEBRIS(P%).X, DEBRIS(P%).Y), 15, 15
PSET (DEBRIS(P%).X, DEBRIS(P%).Y), 0
'FFF% = INT(RND * 100)
'DEBRIS(FFF%).X = DEBRIS(P%).X
'DEBRIS(FFF%).Y = DEBRIS(P%).Y
'DEBRIS(FFF%).CLR = 4
END IF
IF DEBRIS(P%).CLR >= 17 AND DEBRIS(P%).CLR <= 30 THEN
DEBRIS(P%).Y = DEBRIS(P%).Y - INT(RND * 3)
DEBRIS(P%).YVEL = 0
CIRCLE (DEBRIS(P%).X, DEBRIS(P%).Y), DEBRIS(P%).CLR \ 24, 7
PAINT (DEBRIS(P%).X, DEBRIS(P%).Y), INT(RND * 2) + 7, 7
IF INT(RND * 2) = 1 THEN
CIRCLE (DEBRIS(P%).X, DEBRIS(P%).Y), DEBRIS(P%).CLR \ 24, 4
END IF
DEBRIS(P%).CLR = DEBRIS(P%).CLR + 1
IF DEBRIS(P%).CLR = 31 THEN DEBRIS(P%).CLR = 8
END IF
IF DEBRIS(P%).YVEL > 10 THEN DEBRIS(P%).YVEL = 10
NEXT
END SUB

SUB GAMEOVER
FOR N% = YI% TO 210 STEP 5
PCOPY 0, 1
CALL DEBRISDRA
CALL BADHANDLER
YI% = N%
OO% = INT(RND * 100)
DEBRIS(OO%).X = XI%
DEBRIS(OO%).Y = YI%
DEBRIS(OO%).CLR = 14
CIRCLE (XI%, YI%), 2, 15
PAINT (XI%, YI%), 15, 15
LINE (XI%, YI% + 3)-(XI% + 10, YI% - 2)
LINE (XI%, YI% + 3)-(XI% - 10, YI% - 2)
LINE (XI%, YI%)-(XI% + 10, YI% - 2)
LINE (XI%, YI%)-(XI% - 10, YI% - 2)
LINE (XI% - 2, YI% - 1)-(XI% + 2, YI% - 1), 4
PCOPY 1, 2
NEXT
FOR N% = 1 TO 400 STEP 5
PCOPY 1, 2
PCOPY 0, 1
CALL DEBRISDRA
OO% = INT(RND * 100)
DEBRIS(OO%).X = XI%
DEBRIS(OO%).Y = YI%
DEBRIS(OO%).YVEL = -INT(RND * 50)
DEBRIS(OO%).CLR = -1
'PCOPY 0, 1
CIRCLE (XI%, YI%), N%, 14
CIRCLE (XI%, YI%), N% MOD 100 + INT(RND * 100), 14
CIRCLE (XI%, YI%), N% MOD 200 + INT(RND * 100), 4
CIRCLE (XI%, YI%), N% MOD 50 + INT(RND * 100), 14
PAINT (INT(RND * 320), INT(RND * 200)), 14, 14
LOCATE 1, 1: PRINT "KABOOM!!!!!!!!"
CALL BADHANDLER
NEXT
END
END SUB

SUB MOVIE
SCREEN 13
FOR N% = 16 TO 30
LINE (0, 0)-(319, 199), N%, BF
FOR V% = 1 TO 1000: NEXT
NEXT
CIRCLE (150, 100), 75, 15
FOR N% = 30 TO 16 STEP -1
PAINT (1, 1), N%, 15
FOR V% = 1 TO 1000: NEXT
NEXT
FOR N% = 1 TO 100
CALL DEBRISDRA
NEXT
CLS
LOCATE 1, 1
PRINT "FROM A DISTANT PLANET......."
SLEEP 1
CIRCLE (160, 100), 40, 4
PAINT (50, 100), 4, 4
SLEEP 1
CLS
LOCATE 1, 1
PRINT , "SPACE DUDE"
LINE (0, 10)-(319, 20), 8, BF
LINE (0, 200)-(320, 175), 8, BF
LINE (120, 10)-(110, 200), 8, BF
LINE (320 - 120, 10)-(320 - 110, 200), 8, BF
LOCATE 10, 1: PRINT "VERSION 3.117"
LOCATE 11, 1: PRINT "(c) 1997 JASON"
FOR N% = 1 TO 100
COLOR INT(RND * 16)
LOCATE 12, 1: PRINT ">NOW WITH:"
LOCATE , 1: PRINT "CHEAT CODES"
LOCATE , 1: PRINT "RAPID FIRE"
LOCATE , 1: PRINT "COOLER SHIP"
NEXT
COLOR 15
SLEEP 3
END SUB

SUB SPAWN
NUMBG% = NUMBG% + 1
IF NUMBG% = 96 THEN NUMBG% = 95
FOR P% = 0 TO NUMBG%
EVIL(P%).X = INT(RND * 320)
EVIL(P%).Y = INT(RND * 70) + 5
EVIL(P%).STAT = 1
NEXT
SCREEN 7, , 0, 0
LOCATE 2, 1: PRINT "LEVEL:"; NUMBG% - 5
FOR N% = 7 TO 16
FOR M% = 0 TO 100
IF POINT(M%, N%) = 0 THEN PSET (M%, N%), 9
NEXT
NEXT
SCREEN 7, , 1, 2
END SUB


