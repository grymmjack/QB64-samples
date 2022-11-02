CHDIR ".\programs\samples\thebob\abacus"

'****************************************************************************'
'
'--------------------------- A 1 2 G F X . B A S ----------------------------'
'------------------ Creates graphics files for ABACUS12.BAS -----------------'
'
'---------------- Copyright (C) 2007 by Bob Seguin (Freeware) ---------------'
'
'****************************************************************************'

DEFINT A-Z
DECLARE SUB PutBEAD (col, row, Index)

DIM SHARED Box(26000)
DIM SHARED Beads(450)
DIM NumBOX(1 TO 250)
DIM MenuBOX(400)

SCREEN 12

GOSUB SetPALETTE
MaxWIDTH = 397
MaxDEPTH = 86
x = 0: y = 0
RESTORE PixDATA
DO
READ DataSTRING$
FOR n = 1 TO LEN(DataSTRING$)
Char$ = MID$(DataSTRING$, n, 1)
SELECT CASE Char$
CASE "!"
n = n + 1
a$ = MID$(DataSTRING$, n, 1)
Count = ASC(a$) + 68
CASE "#"
n = n + 1
B$ = MID$(DataSTRING$, n)
FOR i = 1 TO LEN(B$)
t$ = MID$(B$, i, 1)
IF t$ = "#" THEN EXIT FOR
c$ = c$ + t$
NEXT i
Count = VAL("&H" + c$)
n = n + LEN(c$)
c$ = ""
CASE ELSE
Count = ASC(Char$) - 60
END SELECT
n = n + 1
Colr = VAL("&H" + MID$(DataSTRING$, n, 1))
FOR Reps = 1 TO Count
PSET (x, y), Colr
x = x + 1
IF x > MaxWIDTH THEN x = 0: y = y + 1
NEXT Reps
NEXT n
LOOP UNTIL y > MaxDEPTH 'DATA drawing loop ends here --------------------

GET (10, 60)-(22, 72), Box: PUT (10, 60), Box
GET (23, 60)-(35, 73), Box(100): PUT (23, 60), Box(100)
GET (36, 60)-(48, 73), Box(200): PUT (36, 60), Box(200)
GET (49, 60)-(61, 73), Box(300): PUT (49, 60), Box(300)
GET (62, 60)-(79, 71), Box(400): PUT (62, 60), Box(400)
GET (80, 60)-(97, 71), Box(500): PUT (80, 60), Box(500)
GET (0, 0)-(116, 54), Box(1000): PUT (0, 0), Box(1000)
GET (120, 0)-(388, 48), Box(3000): PUT (120, 0), Box(3000)
Index = 1
FOR x = 158 TO 260 STEP 11
IF x < 180 THEN Hop = 2 ELSE Hop = 0
GET (x + Hop, 50)-(x + 5 + Hop, 60), NumBOX(Index)
PUT (x + Hop, 50), NumBOX(Index)
Index = Index + 25
NEXT x
DEF SEG = VARSEG(NumBOX(1))
BSAVE "abanums.bsv", VARPTR(NumBOX(1)), 500
DEF SEG
GET (105, 60)-(123, 74), Beads: PUT (105, 60), Beads
GET (127, 60)-(145, 74), Beads(150): PUT (127, 60), Beads(150)
GET (150, 64)-(200, 75), Box(8000): PUT (150, 64), Box(8000)
GET (210, 64)-(239, 75), MenuBOX: GET (245, 64)-(265, 75), MenuBOX(100)
FOR x = 210 TO 265
FOR y = 64 TO 75
IF POINT(x, y) = 7 THEN PSET (x, y), 15
NEXT y
NEXT x
GET (210, 64)-(239, 75), MenuBOX(200): GET (245, 64)-(265, 75), MenuBOX(300)
PUT (210, 64), MenuBOX(200): PUT (245, 64), MenuBOX(300)
DEF SEG = VARSEG(MenuBOX(0))
BSAVE "abamenu.bsv", VARPTR(MenuBOX(0)), 800
DEF SEG
GET (271, 64)-(400, 75), Box(9000): PUT (271, 64), Box(9000)
PUT (398, 76), Box(9000)
GET (0, 76)-(524, 88), Box(9000): PUT (0, 76), Box(9000)

'Abacus drawing begins -------
VIEW SCREEN (200, 149)-(443, 295)
LINE (200, 149)-(443, 295), 6, BF
FOR Reps = 1 TO 120
x = FIX(RND * 250) + 200
y = FIX(RND * 164) + 149
Size = FIX(RND * 30) + 1
Hop = FIX(RND * 5) + 2
FOR Radius = 1 TO Size STEP Hop
CIRCLE (x, y), Radius, 12
NEXT Radius
NEXT Reps
FOR Reps = 1 TO 1200
x = FIX(RND * 250) + 200
y = FIX(RND * 200) + 108
Grain = FIX(RND * 20) + 1
FOR xx = x TO x + Grain
IF POINT(xx, y) = 6 THEN PSET (xx, y), 12
NEXT xx
NEXT Reps
VIEW

PUT (200, 149), Box, PSET
PUT (431, 149), Box(100), PSET
PUT (200, 282), Box(200), PSET
PUT (431, 282), Box(300), PSET
PUT (202, 193), Box(400), PSET
PUT (425, 193), Box(500), PSET

LINE (212, 161)-(431, 193), 0, BF
LINE (212, 203)-(431, 283), 0, BF

LINE (213, 160)-(430, 160), 8
LINE (213, 203)-(430, 203), 8
LINE (214, 149)-(429, 149), 4
LINE (200, 163)-(200, 281), 4
LINE (212, 194)-(431, 194), 4
LINE (212, 284)-(431, 284), 4
LINE (432, 161)-(432, 193), 4
LINE (432, 203)-(432, 283), 4
LINE (443, 163)-(443, 281), 8
LINE (214, 295)-(429, 295), 8

FOR x = 256 TO 410 STEP 44
LINE (x - 1, 197)-(x + 1, 199), 14, BF
LINE (x - 1, 200)-(x + 1, 200), 8
PSET (x - 1, 197), 15
NEXT x

FOR x = 223 TO 435 STEP 22
FOR y = 157 TO 283
IF POINT(x, y) = 0 THEN PSET (x, y), 7
NEXT y
NEXT x
VIEW

FOR x = 214 TO 412 STEP 22
FOR y = 220 TO 268 STEP 16
PUT (x, y), Beads, PSET
NEXT y
NEXT x
FOR x = 214 TO 412 STEP 22
PUT (x, 162), Beads(150), PSET
NEXT x

LINE (5, 5)-(634, 474), 10, B
LINE (7, 7)-(632, 472), 10, B

PUT (186, 48), Box(3000), PSET
FOR x = 186 TO 460
IF POINT(x, 66) <> 0 THEN PSET (x, 66), 7
IF POINT(x, 70) <> 0 THEN PSET (x, 70), 15
IF POINT(x, 74) <> 0 THEN PSET (x, 74), 15
IF POINT(x, 78) <> 0 THEN PSET (x, 78), 7
NEXT x
PUT (296, 96), Box(8000)
PUT (210, 124), MenuBOX
PUT (412, 124), MenuBOX(100)
FOR x = 44 TO 476 STEP 432
FOR y = 42 TO 372 STEP 110
PUT (x, y), Box(1000)
NEXT y
NEXT x
PUT (188, 372), Box(1000)
PUT (331, 372), Box(1000)
PUT (58, 446), Box(9000)
FOR x = 220 TO 418 STEP 22
PUT (x, 320), NumBOX
NEXT x
LINE (200, 316)-(443, 334), 10, B
FOR x = 221 TO 419 STEP 22
LINE (x, 298)-(x + 3, 316), 10, BF
NEXT x
LINE (200, 120)-(443, 138), 10, B

GET (324, 204)-(342, 218), Beads(300)
GET (212, 161)-(431, 330), Box
PutBEAD 6, 3, 0: PutBEAD 6, 7, 2
GET (324, 204)-(342, 283), Box(14000)
PutBEAD 6, 6, 2: PutBEAD 6, 7, 0
GET (324, 204)-(342, 283), Box(13000)
PutBEAD 6, 5, 2: PutBEAD 6, 6, 0
GET (324, 204)-(342, 283), Box(12000)
PutBEAD 6, 4, 2: PutBEAD 6, 5, 0
GET (324, 204)-(342, 283), Box(11000)
PutBEAD 6, 3, 2: PutBEAD 6, 4, 0
GET (324, 204)-(342, 283), Box(10000)
GET (324, 161)-(342, 193), Box(15000)
PutBEAD 6, 1, 2: PutBEAD 6, 2, 1
GET (324, 161)-(342, 193), Box(16000)
PUT (324, 161), Box(15000), PSET
DEF SEG = VARSEG(Box(0))
BSAVE "abasets.bsv", VARPTR(Box(0)), 34002
FOR y = 0 TO 320 STEP 160
GET (0, y)-(639, y + 159), Box
FileCOUNT = FileCOUNT + 1
FileNAME$ = "ABACUS" + LTRIM$(RTRIM$(STR$(FileCOUNT))) + ".BSV"
BSAVE FileNAME$, VARPTR(Box(0)), 52000
PUT (0, y), Box
NEXT y
DEF SEG

COLOR 11
LOCATE 14, 23: PRINT "The graphics files for ABACUS12.BAS"
LOCATE 15, 26: PRINT "have been successfully created."
LOCATE 17, 27: PRINT "You can now run the program."
LINE (120, 140)-(520, 340), 10, B
LINE (124, 144)-(516, 336), 10, B

a$ = INPUT$(1)

SYSTEM

SetPALETTE:
DATA 20, 0, 24, 0, 0, 42, 0, 0, 45, 10, 0, 50
DATA 55, 0, 0, 50, 0, 0, 40, 0, 0, 42, 42, 42
DATA 30, 0, 0, 20, 10, 55, 25, 5, 29, 40, 30, 63
DATA 45, 0, 0, 63, 0, 0, 60, 45, 20, 63, 63, 63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity
OUT &H3C9, Intensity
NEXT n
RETURN

PixDATA:
DATA "#21F#0=9>B=9�0=9>B=9}0=3?9=3@0=3?9=3H0?9=3@0=3?9!0=3AB=3V0UB=9_0=3AB=3"
DATA "b0=9JB=3E0=3IB=9G0=9IB=3T0=9GB=9!W0=9CBT0=3YB=9=3Z0=9CB_0=9NBD0=3KBG0=9"
DATA "JB=3P0=3MB=3R0@AN0@A`0BAx0=3EB=9S0]B=3V0=3EB=9\0=9PB=9C0KB=9G0=9KBO0=9"
DATA "OBQ0BAM0@A`0BAw0=9GBS0^B=9T0=9GBZ0=9SB=3B0KB=9G0=9KBN0QBQ0CAL0@A`0@AJ0"
DATA "JA[0=3JBR0LB=9OBQ0=3JBX0VBB0KB=9G0=3JB=9M0RB=3O0EAK0@A`0@AJ0JAZ0=9KB=3"
DATA "Q0=9JB=9?0=3LB=9O0=9KB=3V0WB=3A0=9JB=9H0JB=9L0=9LB=9>0?9=3N0kAF0PAB0JA"
DATA "Z0MBQ0=9JB=9A0=3KB=3N0MBT0=3NB=9=3>0=3=9@B=3A0=9JB=9H0JB=9K0=3KB=3U0lA"
DATA "F0PAB0JAZ0=9LB=9P0=9JB=9C0KBN0=9LB=9S0LB=3N0=9JB=9H0JB=9K0KB=3V0lAF0PA"
DATA "B0@AB0@A[0MB=3O0=9JB=9C0=3JBO0MB=3Q0KB=3P0=9JB=9H0JB=9J0=3KBV0mAF0PAB0"
DATA "@AB0@A[0=3MBO0=9JB=3D0JBO0=3MBP0=9JBR0=9JB=3H0JB=9J0KB=3U0FA>0@AD0DA=0"
DATA "CAP0@A@0>AB0@AB0@AB0@AA0AAR0=9LB=9N0=9JBE0=3IBP0=9LB=9N0=3JBS0=9JBI0JB"
DATA "=9J0KBV0EA?0@AC0DA?0BAP0@A@0>AB0@AB0@AB0@A@0BAS0MB=3M0=9JBF0IBQ0MB=3M0"
DATA "JBT0=9JBI0JB=3I0=3KBU0EA@0BA@0DA@0BAP0@A>0BA@0@AB0@AB0@A?0AAU0NBM0=3JB"
DATA "F0IBQ0NBL0=3IB=9T0=3JBI0JBJ0LBT0EAA0BA@0CAB0AAP0@A>0BA@0@AA0AAB0@A>0BA"
DATA "T0=9NB=9M0JBE0=3IBP0=9NB=9K0JBV0JBI0JBJ0KB=9T0DAJ0DA\0@A@0@A@0@A?0CAB0"
DATA "HAT0PB=3L0JBE0IB=9P0PB=3J0JBV0JBI0JBJ0KB=3T0CAJ0DA]0@A@0@A@0@A>0DAB0HA"
DATA "S0RBL0JBD0=3IBP0RBI0=3JBV0JBI0JBJ0KBU0fAP0@AH0JAD0FAR0=3RB=9K0JBD0IB=3"
DATA "O0=3RB=9H0JB=9V0JBI0JBJ0KBU0fAP0@AH0IAE0FAR0TBK0JBB0=3IB=3P0TBH0JBW0JB"
DATA "I0JBJ0KB]0^AJ0ZAi0VBJ0JB@0=3JBQ0VBG0JBW0JBI0JBJ0KB]0^AJ0YAi0=3VB=9I0JB"
DATA "=9LB=3Q0=3VB=9F0JBW0JBI0JBJ0KB]0@AX0>AJ0VA@0PAT0FB=0MB=3H0YB=9S0FB=0MB"
DATA "=3E0JBW0JBI0JBJ0KB]0@AX0>AJ0VA@0PAS0=9EB=3=0=3MBH0\B=3O0=9EB=3=0=3MBE0"
DATA "JB=9V0JBI0JBJ0KB]0@AX0>AP0@A@0@A@0@A@0RAP0=3EB=9?0MB=9G0^B=3L0=3EB=9?0"
DATA "MB=9D0KBV0JBI0JBJ0KB]0@AX0>AP0@A@0@A@0@A@0RAP0FB@0=3MB=3F0_B=9K0FB@0=3"
DATA "MB=3C0KBV0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0@AB0DAO0=9EB=3A0=9MBF0JB=9QB=9I0"
DATA "=9EB=3A0=9MBC0KBV0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0@AB0CAO0=3EB=9C0MB=9E0JB"
DATA "@0=3=9MB=9G0=3EB=9C0MB=9B0KB=9U0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0LAP0FB>0?B"
DATA "=9>0=3MB=3D0JBC0=9LBG0FB>0?B=9>0=3MB=3A0LBU0JB=3H0JBJ0KB]0^AP0@A@0@A@0"
DATA "@AD0KAP0=9EB=3=0AB=3>0NBD0JBD0=3KB=9E0=9EB=3=0AB=3>0NBA0MBT0JB=9H0JBJ0"
DATA "KB]0@AX0>AP0@A@0@A@0@AF0FAR0=3EB=9=0=9BB>0=3MB=9C0JBE0=3KBD0=3EB=9=0=9"
DATA "BB>0=3MB=9@0MB=9S0KBH0JBJ0KB]0@AX0>AP0@A@0@A@0@AF0FAR0FB=0=9DB>0=9MB=3"
DATA "B0JBF0KBD0FB=0=9DB>0=9MB=3?0=3MB=9R0KBH0JBJ0KB]0^AO0AAH0@AD0HAQ0=9EB=3"
DATA "=9FB>0NBB0JBF0=3JBC0=9EB=3=9FB>0NB@0NB=9Q0KBH0JBJ0KB]0^AN0BAH0@AD0HAP0"
DATA "=3EB>9HB=0=9NB@0=3JBG0JBB0=3EB>9HB=0=9NB?0PB=3O0KB=3G0JBI0=9KB]0^AM0CA"
DATA "D0bAF0FB=9JB=0NB=9?0=9JBG0JBB0FB=9JB=0NB=9>0=3QB=9M0LBF0=3JB=3H0KB=9]0"
DATA "^AL0DAD0bAE0=9VB=3NB?0=9JBF0=9JBA0=9VB=3NB?0UB=9=3?0=3>9=3A0MBC0=3LB=9"
DATA "H0KB=3]0@AX0>AL0CAE0NAF0DAF0=3kB>0=9JB=3E0KB@0=3kB>0=3]BA0OB=3=0=3OB=9"
DATA "H0KB^0@AX0>AL0BAF0NAF0DAF0YB=0NB=9=0=9JB=9D0=3JB=9@0YB=0NB=9>0=9[B=9A0"
DATA "eB=9G0=9JB=9^0^AL0BAs0FB=9=3MB=9=0=9NB=0=9JB=9C0=3KB=3?0FB=9=3MB=9=0=9"
DATA "NB?0[BB0=3dB=9F0=3KB_0^AL0AAs0=3FB?0KB=3?0MB=9=0=9JB=9B0=9KB=9?0=3FB?0"
DATA "KB=3?0MB=9@0YBD0dB=9E0=3KB=9_0^AR0dAJ0FB=3@0=9HBA0=3KB=9>0=9JB=9?0=3=9"
DATA "MB@0FB=3@0=9HBA0=3KB=9B0WB=3D0dB=9>0?9>3=9LB=9`0^AR0dAJ0EB=9B0=9FBC0JB"
DATA "=3?0aBA0EB=9B0=9FBC0JB=3D0=9TB=9E0=3SB=9=0JB=9>0RBi0@AF0BAX0dAJ0=9DBD0"
DATA "=3DBD0=3GB=9A0`BB0=9DBD0=3DBD0=3GB=9G0=9SBG0=9QB=3=0=3KB>0PB=9j0@AF0BA"
DATA "X0dAK0CB=3F0AB=9F0=9EB=9B0^B=3D0CB=3F0AB=9F0=9EB=9J0=9PBI0OB=3?0=9KB>0"
DATA "=3NB=9k0@AF0BAX0@AD0@AD0@AD0@AK0=9BBH0?B=9H0DB=3C0=3[B=3F0=9BBH0?B=9H0"
DATA "DB=3M0=9MB=3J0=9KB=3A0=9JB=3?0LB=9m0@AF0BAX0@AD0@AD0@AD0@AL0ABY0=9BBF0"
DATA "=3VB=9K0ABY0=9BBR0=3IB=9M0=9FB=3D0=3IBB0=3HB=3]0tAF0@AD0@AD0@AD0@AL0=3"
DATA "?B=9Z0ABr0=3?B=9Z0AB!J0tAF0@AD0@AD0@AD0@AM0?B[0=3?Bt0?B[0=3?B!K0tAF0@A"
DATA "D0@AD0@AD0@A#124#0tAF0@AD0@AD0@AD0@A#134#0BAF0BAX0@AD0@AD0@AD0@A#134#0"
DATA "BAF0BAX0@AD0@AD0@AD0@Aq0@FD0>FB0@FC0@FE0>FB0BFB0@FB0BFB0@FC0@F!T0DAF0BA"
DATA "X0@AD0@AD0@AD0@Ap0>F>0>FA0@FA0>F>0>FA0>F>0>FC0?FB0>FE0>F>0>FE0>FA0>F>0"
DATA ">FA0>F>0>F!S0DAF0BAX0@AD0@AD0@AD0@Ap0>F>0>FC0>FE0>FE0>FC0?FB0>FE0>FH0>F"
DATA "B0>F>0>FA0>F>0>F#127#0>F>0>FC0>FE0>FE0>FB0@FB0AFB0>FH0>FB0>F>0>FA0>F>0"
DATA ">F#127#0>F>0>FC0>FD0>FD0?FC0@FB0>F>0>FA0AFD0>FD0@FC0AF#127#0>F>0>FC0>F"
DATA "C0>FG0>FA0>F=0>FF0>FA0>F>0>FC0>FC0>F>0>FE0>F#127#0>F>0>FC0>FB0>FH0>FA0"
DATA "BFE0>FA0>F>0>FB0>FD0>F>0>FE0>F#127#0>F>0>FC0>FA0>FE0>F>0>FD0>FB0>F>0>F"
DATA "A0>F>0>FB0>FD0>F>0>FA0>F>0>F#128#0@FD0>FA0BFB0@FE0>FC0@FC0@FC0>FE0@FC0"
DATA "@F!N0VF=EG6>0@6@C?6=E?6>FA6K0B6>F?6H0=6>5A4=6I0=1>3A9=1#10B#0HE>8JE>6=C"
DATA "=6AC=6>0F6>E>6BE>6K4?6=FAE>6F0=6=C>5D4=6E0=1=2>3D9=1#109#0?E>8BE=8>6=8"
DATA "BE>8BEH6BC>6=F>E>6@E>8=EN6=F>8@E>6E0>6=C>5@4=D=F=D>4=6C0>1=2>3@9=B=F=B"
DATA ">9=1#108#0>E@6=E@8@6@8=E@6AEECG6?E=6AE=6=F>E>6=F>EB6=F>E>6=F=E=6=FAE=6"
DATA "D0>6>C=5A4?F?4=6A0>1>2=3A9?F?9=1#107#0>E@6=EB6AC=6=E@6AEA6=F=EB6=F=E>6"
DATA ">C=6AE>8EE=8>E@6>E=8EE>8>ED0=6>C>5A4=D=F=D?4=CA0=1>2>3A9=B=F=B?9=2#107#0"
DATA "?E>6=F>EACA6?E>6=FAE?6@EB6@E?6AE>6DE?6BE?6DE>6>EC0>6>C>5H4=C?0>1>2>3H9"
DATA "=2A0=B@0=Bf0=BF0A7>0A7>0?7>0A7=0A7B0@7>0=7@0=7=0=7=0A7f0=BC0=B[0=B\0=B"
DATA "V0BE>8=E@6>C>6=E>8EE>6=E>8=E=8AC=6=8=E>8=E>6AE=6=FEE=6=F=E@8>E=6=FDE>6"
DATA ">EC0>6>C?5F4>C?0>1>2?3F9>2@0=BA0=Bg0=BE0=7@0=7=0=7A0=7?0=7=0=7C0=7C0=7"
DATA "@0=7=0=7@0=7=0=7?0=7D0>B>0=B=0=BD0=B>0=BM0=BC0=B[0=B\0=BA0=BP0?E>8=E>6"
DATA "=ED6=E>6=E>8EE>6=ED6=E>6BE=8AE>8>E>8?E=8@6=8?E>8>E>8AE=8C0=C=6?C>5G4=C"
DATA "?0=2=1?2>3G9=2@0=BA0=Bg0=BE0=7@0=7=0=7A0=7A0=7C0=7C0=7@0=7=0=7@0=7=0=7"
DATA "?0=7C0=B>0>B>0=BD0=B>0=BM0=BC0=B[0=B\0=BA0=BP0?E>6=8>E=F=EAC=6=F?E=8>6"
DATA "BE>8?E=8=6>C=6=C=6=C=6=8?E>8?E>8@E=6=F=E=8>6?8>C@6?8>6=8=E=6=F@E=8=6C0"
DATA "=5>6>C>5E4=5>C?0=3>1>2>3E9=3>2@0=BA0=B>0?B>0@B?0?B>0=B=0>B?0?B?0>B?0?B"
DATA "?0=BE0=7@0=7=0=7A0=7A0=7C0=7C0=7@0=7=0=7@0=7=0=7?0=7J0>B>0?B>0>B=0>B>0"
DATA "?B>0=B=0>B@0=B?0?B>0@B?0?B?0?B>0=B?0=B>0>B@0=B>0@B?0?B?0@B>0?B?0>B@0=B"
DATA "=0>B>0>B=0?B=0>BH0?E?6>8>EB6>E>8>C=6AE@6=E=8FC=8=E@6>E>6BE=8N6=8BE>6C0"
DATA "=C?6>C>5=4=5A4=5>C=6?0=2?1>2>3=9=3A9=3>2=1@0=BA0=BA0=B=0=B?0=BA0=B=0>B"
DATA ">0=B=0=B?0=B=0=B>0=B=0=B?0=B>0=BE0A7>0@7?0?7>0@7@0=7C0=7@0=7=0=7@0=7=0"
DATA "=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0>B>0=B?0=BB0=B=0=B?0=BA0=B=0=B?0=B"
DATA "=0=B?0=B=0=B>0=B?0=B>0=B?0=BA0=B=0=B?0=B=0=B?0=B=0=B>0=B?0>B>0=B=0=B>0"
DATA "=B>0=B>0=BG0?E>C?6>8?6=C>6>8A6AE@6=EH6=E@6>E>6=8>E?8>CK8?6?8>E=8>6D0=5"
DATA "?6>C>5=4=5=4@5=C=6A0=3?1>2>3=9=3=9@3=2=1A0=BA0=B>0@B=0=B?0=B>0@B=0=B?0"
DATA "=B=0AB>0=B?0AB>0=BE0=7@0=7=0=7E0=7=0=7C0=7C0=7@0=7=0=7@0=7=0=7?0=7J0=B"
DATA ">0=B?0=B=0=B>0=B>0=B?0=B=0=B?0=B>0=B@0@B=0=B?0=B>0@B=0=BA0=B?0=B>0=B@0"
DATA "=B?0=B?0=B>0@B=0=B?0=B=0AB>0=BA0=B?0=B=0=B>0=B>0=B>0=BG0>E=8I6CCBE>6=F"
DATA "BE>6=FBE>6=F>E?6>8A6K0B6>8?6D0=6=C?6?C?5=C=5?C=6A0=1=2?1?2?3=2=3?2=1A0"
DATA "=B>0=B>0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=BC0=B>0=BB0=BE0=7@0=7=0=7"
DATA "E0=7=0=7C0=7C0=7>0=7=0=7=0=7@0=7=0=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0"
DATA "=B?0=B>0=B?0=B?0=B=0=B?0=B=0=B?0=B=0=BA0=B?0=B?0=B?0=B?0=B?0=B=0=B?0=B"
DATA "=0=B?0=B=0=BC0=B@0=B?0=B=0=B>0=B>0=B>0=BG0=E=8@C>6=C=6>C>8E6=8XEi0=5=C"
DATA "@6=C=6BC=6C0=3=2@1=2=1B2=1B0=B>0=B>0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B"
DATA "=0=B?0=B=0=B>0=B=0=B?0=B>0=BE0=7@0=7=0=7A0=7?0=7=0=7C0=7C0=7?0>7=0=7@0"
DATA "=7=0=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0=B?0=B=0=B@0=B?0=B=0=B?0=B=0=B"
DATA "?0=B=0=B?0=B=0=B>0>B=0=B>0=B=0=B@0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0"
DATA "=B?0=B?0=B=0=B>0=B>0=B>0=BU0F6=8=EV8j0=6=5=CF6E0=1=3=2F1C0=B?0>B?0@B=0"
DATA "@B?0@B=0=B?0=B>0?B?0>B?0?B?0=BE0=7@0=7=0A7>0?7>0A7?0=7D0@7?0@7>0=7?0=7"
DATA "K0=B>0?B?0=B>0=B>0?B>0=B?0=B=0=BA0@B=0@B?0@B>0?B?0>B=0=B>0>B>0=B@0@B?0"
DATA "@B>0@B>0?B?0>B>0=B=0=B?0=B>0=B=0=B>0=B>0=B�0=6>C?6=C>6I0=1>2?1=2>1E0=B"
DATA "I0=B_0=Bm0=7�0=BK0=B!r0=BH0=B^0=B!R0=BG0@B#1AE#0ABn0=Be0=BC0=BQ0=B�0=B"
DATA "e0=BB0=BD0=BR0=B@0=BK0=BA0=BW0=BA0=B=0=Bh0=B=0=Br0=BC0=BH0=BD0=BO0=BQ0"
DATA "=BS0=Bs0=Bn0=BB0=BA0=B>0=BI0=B@0=BK0=BA0=B]0=BN0=BW0=B=0=Br0=BC0=BH0=B"
DATA "D0=BO0=BQ0=BS0=Bs0=Bn0=BB0=BA0=B>0=BI0=B@0=BK0=BA0=B]0=BN0=BW0=B=0=BB0"
DATA "?B>0>BB0?BC0?B?0?B>0?B=0>B>0@B>0=B>0?B>0>B>0?BB0>B=0=B?0=B=0>B>0?B>0>B"
DATA "=0=B>0?B>0=BB0?B>0=B=0>BB0=B=0>B?0?B>0=B>0=B>0=BA0>B>0?BB0=B?0=B>0>B?0"
DATA "?BC0?B>0=B=0>BC0?B>0@B?0?B?0?B>0=B?0=B>0>BE0=B?0=B=0=B>0>B>0=B=0>BA0=B"
DATA "=0>B>0>B=0>B=0@B>0=B?0=B@0=B>0=B>0=B>0=B>0?B>0@B>0=B=0>B?0?B>0?B=0>B?0"
DATA "?B@0=B>0@B=0=B=0>B>0?B?0?B>0>B@0?B?0?B>0?B=0>B@0=B>0@B>0=B?0=B=0=BF0=B"
DATA "A0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=B?0=B=0=B>0=B?0=BA0=B>0=B?0"
DATA "=B=0=B>0=B?0=B=0=B>0=BA0=B=0=BA0=B?0=B=0>B>0=BA0>B>0=B=0=B?0=B=0=B>0=B"
DATA ">0=BA0=B>0=B?0=BA0=B?0=B=0=B>0=B=0=B?0=BE0=B=0>B>0=BE0=B=0=B?0=BA0=B=0"
DATA "=B?0=B=0=B?0=B=0=B>0=BD0=B?0=B=0=B=0=B>0=B=0=B=0=BB0>B>0=B=0=B>0=B>0=B"
DATA "?0=BA0=B@0=B>0=B>0=B>0=B=0=B?0=B=0=B?0=B=0>B>0=B=0=B?0=B=0=B>0=B>0=B=0"
DATA "=B?0=B?0=B=0=B?0=B=0=B=0=B>0=B?0=B=0=B?0=B=0=B@0=B?0=B=0=B?0=B=0=B>0=B"
DATA ">0=B?0=B>0=BA0=B?0=B=0=BC0@BA0=BA0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0AB=0"
DATA "=B>0ABA0=B>0=B?0=B=0=B>0=B?0=B=0=B>0=B>0@B=0=BA0=B?0=B=0=B?0=BA0=B?0=B"
DATA "=0=B?0=B=0=B=0=B=0=B=0=BA0=B>0=B?0=BA0=B?0=B>0=B?0ABB0@B=0=B?0=BB0@B=0"
DATA "=B?0=B>0@B=0=BA0=B?0=B>0=BG0=B=0=B>0=B>0=B?0=B=0=BB0=B?0=B=0=B>0=B>0=B"
DATA "?0=B@0=B@0=B?0=B=0=B=0=B=0=B=0AB=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0=B>0=B=0"
DATA "AB?0=B=0=B?0=B=0=B=0=B>0AB=0=BA0=B@0=BA0=B?0=B=0=B>0=B>0=B>0=B?0=BA0=B"
DATA "?0=B=0=BB0=B?0=BA0=BA0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=BA0=B>0=BE0=B>0"
DATA "=B?0=B=0=B>0=B?0=B=0=B>0=B=0=B?0=B=0=BA0=B?0=B=0=B?0=BA0=B?0=B=0=B?0=B"
DATA "=0=B=0=B=0=B=0=BA0=B>0=B?0=BA0=B?0=B?0=B>0=BE0=B?0=B=0=B?0=BA0=B?0=B=0"
DATA "=B?0=B=0=B?0=B=0=BA0=B?0=B?0=BF0=B=0=B>0=B?0=B>0=B=0=BB0=B?0=B=0=B>0=B"
DATA ">0=B?0=B@0=B@0=B?0=B=0=B=0=B=0=B=0=BA0=B?0=B=0=B?0=B=0=B?0=B=0=B>0=B>0"
DATA "=B=0=BC0=B=0=B?0=B=0=B=0=B>0=BA0=BA0=B@0=BA0=B?0=B=0=B>0=B>0=B>0=B?0=B"
DATA "A0=B?0=B=0=BB0=B?0=BA0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=B?0=B=0"
DATA "=B>0=B?0=BA0=B>0=B>0>B=0=B>0=B?0=B=0=B>0=B=0=B?0=B=0=BA0=B?0=B=0=B?0=B"
DATA "A0=B?0=B=0=B?0=B>0=B?0=BB0=B>0=B?0=BA0=B>0>B=0=B>0=B=0=B?0=BA0=B?0=B=0"
DATA "=B?0=BA0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0>B=0=B>0=BF0=B?0=B=0=B>0=B"
DATA "=0=B=0=BB0=B?0=B=0=B>0=B>0=B?0=B?0=B@0=BA0=B?0=B>0=B?0=B=0=B?0=B=0=B?0"
DATA "=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B?0=B=0=B?0=B=0=B=0=B>0=B?0=B=0=B?0=B=0=B"
DATA "@0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B@0=BB0?B>0=BC0@BB0?B?0?B>0=B>0=B>0=B=0"
DATA "@B>0=B>0?B?0=B>0?BC0=B>0>B=0=B>0=B>0?B>0=B>0=B>0@B=0=BB0?B>0=B?0=BA0=B"
DATA "?0=B>0?B?0=B?0=BC0=B>0?BC0>B=0=B>0>B?0?BC0@B=0=B?0=BB0@B=0@B?0@B>0?B?0"
DATA ">B=0=B>0>B?0=BC0=B?0=B>0>B>0=B>0=BA0=B?0=B>0=B>0=B=0@B>0=B=0=B@0=BA0=B"
DATA "?0=B?0?B>0@B>0=B?0=B>0?B>0=B>0=B>0=B>0?B>0=B=0=B>0@B=0=B=0=B?0?B?0?B?0"
DATA "=B=0=B>0?B?0?B>0=B>0=B>0=B=0=Bq0=B!v0=Bd0=B�0"

SUB PutBEAD (col, row, Index)

IF row < 3 THEN Hop = 0 ELSE Hop = 10
PutCOL = col * 22 + 192
PutROW = row * 16 + 146 + Hop
PutINDEX = Index * 150
PUT (PutCOL, PutROW), Beads(PutINDEX), PSET

END SUB
