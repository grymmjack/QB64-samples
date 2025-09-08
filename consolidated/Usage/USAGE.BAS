'   USAGE.BAS
'      by Tim Syrop
'   Copyright (c) 1994 DOS Resource Guide
'   Published in Issue #14, March 1994, page 53

OPEN "c:\dos\ul.sys" FOR APPEND AS #1
hourtime% = VAL(TIME$)
mintime$ = (MID$(TIME$, 3, 3))
IF hourtime% < 12 THEN AmOrPm$ = " AM" ELSE AmOrPm$ = " PM"
IF hourtime% > 12 THEN hourtime% = houtime% - 12
IF hourtime% = 0 THEN hourtime% = 12
hourtime$ = STR$(hourtime%)
UseInfo$ = "Computer started " + DATE$ + hourtime$ + mintime$ + AmOrPm$
WRITE #1, UseInfo$
CLOSE #1
SYSTEM

