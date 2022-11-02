1 '  DESCRAM.BAS by Larry Sessions
2 '  Copyright (C) 1992 DOS Resource Guide
3 '  Published in Issue #4, page 74
4 '  This program works with both QBasic and GW-Basic
10 INPUT "Enter name of file to descramble: "; N$
15 INPUT "Enter name of file to write descrambled data: "; O$
20 OPEN "I", 1, N$
25 OPEN "O", 2, O$
30 IF EOF(1) THEN 75
35 X$ = INPUT$(1, #1)
40 Y = ASC(X$) - 128
45 IF Y > 0 GOTO 65
50 PRINT : PRINT "*** Can't Descramble. File '"; N$; "' is not a Scrambled file."
55 CLOSE #1, #2: NAME O$ AS "killfile": KILL "killfile"
60 GOTO 80
65 PRINT #2, CHR$(Y);
70 GOTO 30
75 CLOSE #1, #2: NAME N$ AS "killfile": KILL "killfile"
80 PRINT
85 END



