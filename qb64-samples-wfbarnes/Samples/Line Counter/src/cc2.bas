CLS
REM I HAVE FIXED THE BLANK LINE COUNTING BUG
PRINT "********************************"
PRINT "CODE COUNTER BY MURRAY PARKINSON"
PRINT "********************************"
PRINT
PRINT "ENTER FILE NAME:";
INPUT FILEN$
CLS
OPEN FILEN$ FOR INPUT AS #1
WHILE NOT EOF(1)
INPUT #1, A$
IF A$ <> "" THEN LN = LN + 1
WEND
CLOSE
PRINT "********************************"
PRINT "CODE COUNTER BY MURRAY PARKINSON"
PRINT "********************************"
PRINT
IF LN = 1 THEN PRINT "YOUR PROGRAM HAS ONLY 1 LINE OF CODE!"
PRINT "YOUR PROGRAM HAS"; LN; "LINES OF CODE"