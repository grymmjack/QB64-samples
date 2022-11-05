' Modified 2021 by wfbarnes for QB64 compiler.

'1 KEY OFF: CLS
'4 CLS
'5 PRINT TAB(16) + "**************************"
'10 PRINT TAB(26) + "ELIZA"
'20 PRINT TAB(20) + "CREATIVE COMPUTING"
'30 PRINT TAB(18) + "MORRISTOWN, NEW JERSEY": PRINT
'40 PRINT TAB(19) + "ADAPTED FOR IBM PC BY"
'50 PRINT TAB(20) + "PATRICIA DANIELSON AND PAUL HASHFIELD"
'52 PRINT TAB(21) + "BE SURE THAT THE CAPS LOCK IS ON"
'53 PRINT: PRINT TAB(16) + "PLEASE DON'T USE COMMAS OR PERIODS IN YOUR INPUTS": PRINT
'55 PRINT TAB(16) + "*************************"
'60 PRINT: PRINT: PRINT
'80 REM*****INITIALIZATION**********
100 Dim Shared S(36), R(36), N(36)
105 Dim Shared KEYWORD$(36), WORDIN$(7), WORDOUT$(7), REPLIES$(112)
Dim Shared N1, N2, N3
Dim L, X
110 N1 = 36: N2 = 14: N3 = 112
112 For X = 1 To N1: Read KEYWORD$(X): Next X
114 For X = 1 To N2 / 2: Read WORDIN$(X): Read WORDOUT$(X): Next X
116 For X = 1 To N3: Read REPLIES$(X): Next X
130 For X = 1 To N1
    140 Read S(X), L: R(X) = S(X): N(X) = S(X) + L - 1
150 Next X
'160 PRINT "HI! I'M ELIZA. WHAT'S YOUR PROBLEM?"

1000 Rem *******************************
1010 Rem *****PROGRAM DATA FOLLOWS******
1020 Rem *******************************
1030 Rem *********KEYWORDS**************
1049 Rem *******************************
1050 Data "CAN YOU ","CAN I ","YOU ARE ","YOU'RE ","I DON'T ","I FEEL "
1060 Data "WHY DON'T YOU ","WHY CAN'T I ","ARE YOU ","I CAN'T ","I AM ","I'M "
1070 Data "YOU ","I WANT ","WHAT ","HOW ","WHO ","WHERE ","WHEN ","WHY "
1080 Data "NAME ","CAUSE ","SORRY ","DREAM ","HELLO ","HI ","MAYBE "
1090 Data "NO","YOUR ","ALWAYS ","THINK ","ALIKE ","YES ","FRIEND "
1100 Data "COMPUTER","NOKEYFOUND"
1200 Rem *********************************
1210 Rem ***STRING DATA FOR CONJUGATIONS**
1220 Rem *********************************
1230 Data " ARE "," AM "," WERE "," WAS "," YOU "," I "," YOUR"," MY "
1235 Data " I'VE "," YOU'VE "," I'M "," YOU'RE "
1240 Data " ME "," YOU "
1300 Rem ******************************
1310 Rem *********REPLIES**************
1320 Rem ******************************
1330 Data "DON'T YOU BELIEVE THAT I CAN*"
1340 Data "PERHAPS YOU WOULD LIKE TO BE LIKE ME*"
1350 Data "YOU WANT ME TO BE ABLE TO*"
1360 Data "PERHAPS YOU DON'T WANT TO*"
1365 Data "DO YOU WANT TO BE ABLE TO*"
1370 Data "WHAT MAKES YOU THINK I AM*"
1380 Data "DOES IT PLEASE YOU TO BELIEVE I AM*"
1390 Data "PERHAPS YOU WOULD LIKE TO BE*"
1400 Data "DO YOU SOMETIMES WISH YOU WERE*"
1410 Data "DON'T YOU REALLY*"
1420 Data "WHY DON'T YOU*"
1430 Data "DO YOU WISH TO BE ABLE TO*"
1440 Data "DOES THAT TROUBLE YOU*"
1450 Data "DO YOU OFTEN FEEL*"
1460 Data "DO YOU OFTEN FEEL*"
1470 Data "DO YOU ENJOY FEELING*"
1480 Data "DO YOU REALLY BELIEVE I DON'T*"
1490 Data "PERHAPS IN GOOD TIME I WILL*"
1500 Data "DO YOU WANT ME TO*"
1510 Data "DO YOU THINK YOU SHOULD BE ABLE TO*"
1520 Data "WHY CAN'T YOU*"
1530 Data "WHY ARE YOU INTERESTED IN WHETHER OR NOT I AM*"
1540 Data "WOULD YOU PREFER IF I WERE NOT*"
1550 Data "PERHAPS IN YOUR FANTASIES I AM*"
1560 Data "HOW DO YOU KNOW YOU CAN'T*"
1570 Data "HAVE YOU TRIED?"
1580 Data "PERHAPS YOU CAN NOW*"
1590 Data "DID YOU COME TO ME BECAUSE YOU ARE*"
1600 Data "HOW LONG HAVE YOU BEEN*"
1610 Data "DO YOU BELIEVE IT IS NORMAL TO BE*"
1620 Data "DO YOU ENJOY BEING*"
1630 Data "WE WERE DISCUSSING YOU--NOT ME."
1640 Data "OH, I*"
1650 Data "YOU'RE NOT REALLY TALKING ABOUT ME, ARE YOU?"
1660 Data "WHAT WOULD IT MEAN TO YOU IF YOU GOT*"
1670 Data "WHY DO YOU WANT*"
1680 Data "SUPPOSE YOU SOON GOT*"
1690 Data "WHAT IF YOU NEVER GOT*"
1700 Data "I SOMETIMES ALSO WANT*"
1710 Data "WHY DO YOU ASK?"
1720 Data "DOES THAT QUESTION INTEREST YOU?"
1730 Data "WHAT ANSWER WOULD PLEASE YOU THE MOST?"
1740 Data "WHAT DO YOU THINK?"
1750 Data "ARE SUCH QUESTIONS ON YOUR MIND OFTEN?"
1760 Data "WHAT IS IT THAT YOU REALLY WANT TO KNOW?"
1770 Data "HAVE YOU ASKED ANYONE ELSE?"
1780 Data "HAVE YOU ASKED SUCH QUESTIONS BEFORE?"
1790 Data "WHAT ELSE COMES TO MIND WHEN YOU ASK THAT?"
1800 Data "NAMES DON'T INTEREST ME."
1810 Data "I DON'T CARE ABOUT NAMES --PLEASE GO ON."
1820 Data "IS THAT THE REAL REASON?"
1830 Data "DON'T ANY OTHER REASONS COME TO MIND?"
1840 Data "DOES THAT REASON EXPLAIN ANYTHING ELSE?"
1850 Data "WHAT OTHER REASONS MIGHT THERE BE?"
1860 Data "PLEASE DON'T APOLOGIZE!"
1870 Data "APOLOGIES ARE NOT NECESSARY."
1880 Data "WHAT FEELINGS DO YOU HAVE WHEN YOU APOLOGIZE?"
1890 Data "DON'T BE SO DEFENSIVE!"
1900 Data "WHAT DOES THAT DREAM SUGGEST TO YOU?"
1910 Data "DO YOU DREAM OFTEN?"
1920 Data "WHAT PERSONS APPEAR IN YOUR DREAMS?"
1930 Data "ARE YOU DISTURBED BY YOUR DREAMS?"
1940 Data "HOW DO YOU DO ...PLEASE STATE YOUR PROBLEM."
1950 Data "YOU DON'T SEEM QUITE CERTAIN."
1960 Data "WHY THE UNCERTAIN TONE?"
1970 Data "CAN'T YOU BE MORE POSITIVE?"
1980 Data "YOU AREN'T SURE?"
1990 Data "DON'T YOU KNOW?"
2000 Data "ARE YOU SAYING NO JUST TO BE NEGATIVE?"
2010 Data "YOU ARE BEING A BIT NEGATIVE."
2020 Data "WHY NOT?"
2030 Data "ARE YOU SURE?"
2040 Data "WHY NO?"
2050 Data "WHY ARE YOU CONCERNED ABOUT MY*"
2060 Data "WHAT ABOUT YOUR OWN*"
2070 Data "CAN YOU THINK OF A SPECIFIC EXAMPLE?"
2080 Data "WHEN?"
2090 Data "WHAT ARE YOU THINKING OF?"
2100 Data "REALLY, ALWAYS?"
2110 Data "DO YOU REALLY THINK SO?"
2120 Data "BUT YOU ARE NOT SURE YOU*"
2130 Data "DO YOU DOUBT YOU*"
2140 Data "IN WHAT WAY?"
2150 Data "WHAT RESEMBLANCE DO YOU SEE?"
2160 Data "WHAT DOES THE SIMILARITY SUGGEST TO YOU?"
2170 Data "WHAT OTHER CONNECTIONS DO YOU SEE?"
2180 Data "COULD THERE REALLY BE SOME CONNECTION?"
2190 Data "HOW?"
2200 Data "YOU SEEM QUITE POSITIVE."
2210 Data "ARE YOU SURE?"
2220 Data "I SEE."
2230 Data "I UNDERSTAND."
2240 Data "WHY DO YOU BRING UP THE TOPIC OF FRIENDS?"
2250 Data "DO YOUR FRIENDS WORRY YOU?"
2260 Data "DO YOUR FRIENDS PICK ON YOU?"
2270 Data "ARE YOU SURE YOU HAVE ANY FRIENDS?"
2280 Data "DO YOU IMPOSE ON YOUR FRIENDS?"
2290 Data "PERHAPS YOUR LOVE FOR FRIENDS WORRIES YOU."
2300 Data "DO COMPUTERS WORRY YOU?"
2310 Data "ARE YOU TALKING ABOUT ME IN PARTICULAR?"
2320 Data "ARE YOU FRIGHTENED BY MACHINES?"
2330 Data "WHY DO YOU MENTION COMPUTERS?"
2340 Data "WHAT DO YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM?"
2350 Data "DON'T YOU THINK COMPUTERS CAN HELP PEOPLE?"
2360 Data "WHAT IS IT ABOUT MACHINES THAT WORRIES YOU?"
2370 Data "SAY, DO YOU HAVE ANY PSYCHOLOGICAL PROBLEMS?"
2380 Data "WHAT DOES THAT SUGGEST TO YOU?"
2390 Data "I SEE."
2400 Data "I'M NOT SURE I UNDERSTAND YOU FULLY."
2410 Data "COME COME ELUCIDATE YOUR THOUGHTS."
2420 Data "CAN YOU ELABORATE ON THAT?"
2430 Data "THAT IS QUITE INTERESTING."
2500 Rem *************************
2510 Rem *****DATA FOR FINDING RIGHT REPLIES
2520 Rem *************************
2530 Data 1,3,4,2,6,4,6,4,10,4,14,3,17,3,20,2,22,3,25,3
2540 Data 28,4,28,4,32,3,35,5,40,9,40,9,40,9,40,9,40,9,40,9
2550 Data 49,2,51,4,55,4,59,4,63,1,63,1,64,5,69,5,74,2,76,4
2560 Data 80,3,83,7,90,3,93,6,99,7,106,6

'''''

Do
    Input i$
    Print Eliza$(i$)
Loop Until LCase$(i$) = "exit"

'''''

Function Eliza$ (TheStringIn As String) Static
    Dim TheReturn As String
    Dim K As Integer
    Dim L As Integer
    Dim X As Integer
    Dim C As String
    Dim I As String
    Dim F As String
    Dim P As String
    170 Rem ***********************************
    180 Rem *******USER INPUT SECTION**********
    190 Rem ***********************************
    200 I = UCase$(TheStringIn) 'INPUT I$
    201 I = "  " + I + "  "
    210 Rem GET RID OF APOSTROPHES
    220 For L = 1 To Len(I)
        230 'REM IF MID$(I$,L,1)="'"THEN I$=LEFT$(I$,L-1)+RIGHT$(I$,LEN(I$)-L):GOTO 230
        240 If L + 4 > Len(I) Then 250
        241 If Mid$(I, L, 4) <> "SHUT" Then 250
        242 TheReturn = "O.K. IF YOU FEEL THAT WAY I'LL SHUT UP...."
        243 GoTo ElizaFuncExit 'END
    250 Next L
    255 If I = P Then TheReturn = "PLEASE DON'T REPEAT YOURSELF!": GoTo ElizaFuncExit
    260 Rem ***********************************
    270 Rem ********FIND KEYWORD IN I$*********
    280 Rem ***********************************
    300 For K = 1 To N1
        320 For L = 1 To Len(I) - Len(KEYWORD$(K)) + 1
            340 If Mid$(I, L, Len(KEYWORD$(K))) <> KEYWORD$(K) Then 350
            341 If K <> 13 Then 349
            342 If Mid$(I, L, Len(KEYWORD$(29))) = KEYWORD$(29) Then K = 29
            349 F = KEYWORD$(K): GoTo 390
        350 Next L
    360 Next K
    370 K = 36: GoTo 570: Rem WE DIDN'T FIND ANY KEYWORDS
    380 Rem ******************************************
    390 Rem **TAKE PART OF STRING AND CONJUGATE IT****
    400 Rem **USING THE LIST OF STRINGS TO BE SWAPPED*
    410 Rem ******************************************
    430 C = " " + Right$(I, Len(I) - Len(F) - L + 1) + " "
    440 For X = 1 To N2 / 2
        460 For L = 1 To Len(C)
            470 If L + Len(WORDIN$(X)) > Len(C) Then 510
            480 If Mid$(C, L, Len(WORDIN$(X))) <> WORDIN$(X) Then 510
            490 C = Left$(C, L - 1) + WORDOUT$(X) + Right$(C, Len(C) - L - Len(WORDIN$(X)) + 1)
            495 L = L + Len(WORDOUT$(X))
            500 GoTo 540
            510 If L + Len(WORDOUT$(X)) > Len(C) Then 540
            520 If Mid$(C, L, Len(WORDOUT$(X))) <> WORDOUT$(X) Then 540
            530 C = Left$(C, L - 1) + WORDIN$(X) + Right$(C, Len(C) - L - Len(WORDOUT$(X)) + 1)
            535 L = L + Len(WORDIN$(X))
        540 Next L
    550 Next X
    555 If Mid$(C, 2, 1) = " " Then C = Right$(C, Len(C) - 1): Rem ONLY 1 SPACE
    556 For L = 1 To Len(C)
        557 If Mid$(C, L, 1) = "!" Then C = Left$(C, L - 1) + Right$(C, Len(C) - L): GoTo 557
    558 Next L
    560 Rem **********************************************
    570 Rem **NOW USING THE KEYWORD NUMBER (K) GET REPLY**
    580 Rem **********************************************
    600 F = REPLIES$(R(K))
    610 R(K) = R(K) + 1: If R(K) > N(K) Then R(K) = S(K)
    620 If Right$(F, 1) <> "*" Then TheReturn = F: P = I: GoTo ElizaFuncExit
    625 If C <> "   " Then 630
    626 TheReturn = "YOU WILL HAVE TO ELABORATE MORE FOR ME TO HELP YOU"
    627 GoTo ElizaFuncExit
    630 TheReturn = Left$(F, Len(F) - 1) + C
    640 P = I: GoTo ElizaFuncExit
    ElizaFuncExit:
    Eliza$ = TheReturn
    'GOTO 170
End Function
