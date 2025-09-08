1 '  SCRAMBLE.BAS by Larry Sessions
2 '  Copyright (C) 1992 DOS Resource Guide
3 '  Published in Issue #4, page 74
4 '  This program works with both QBasic and GW-Basic
10 INPUT "Enter name of file to scramble: "; N$
15 INPUT "Enter name of file to write scrambled data: "; O$
20 OPEN "I", 1, N$
25 OPEN "O", 2, O$
30 IF EOF(1) THEN 70
35 A$ = INPUT$(1, #1)
40 IF ASC(A$) <= 127 THEN GOTO 60
45 PRINT : PRINT "*** Can't Scramble. File '"; N$; "' is not a text file."
50 CLOSE #1, #2: NAME O$ AS "killfile": KILL "killfile"
55 GOTO 75
60 PRINT #2, CHR$(ASC(A$) + 128);
65 GOTO 30
70 CLOSE #1, #2: NAME N$ AS "killfile": KILL "killfile"
75 PRINT
80 END


