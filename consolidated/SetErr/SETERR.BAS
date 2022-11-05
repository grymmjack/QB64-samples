1 '   SETERR.BAS
2 '   Copyright (c) 1993 DOS Resource Guide
3 '   Published in The Essential Guide to DOS Special Issue
4 '   October 1993, page 58
10 REM SETERR.BAS
20 REM This program creates SETERR.COM, which sets the DOS
30 REM ERRORLEVEL to the value specified in the command line.
40 REM Values may be from 0 to 255. Use it like this:
50 REM SETERR 100
60 REM --------------------------
70 KEY OFF: CLS
80 OUTFILE$ = "SETERR.COM"
90 OPEN OUTFILE$ FOR RANDOM AS 1 LEN = 1
100 FIELD 1, 1 AS A$
110 READ COUNT, CHECKSUM
120 FOR I = 1 TO COUNT
130   READ BYTE$
140   BYTE$ = "&h" + BYTE$
150   BYTE = VAL(BYTE$)
160   CHECK = CHECK + BYTE
170   LSET A$ = CHR$(BYTE)
180   PUT 1
190 NEXT I
200 CLOSE
210 IF CHECK = CHECKSUM THEN 250
220 PRINT "Error in data statements - file not created."
230 PRINT "Please check data and try again."
240 KILL OUTFILE$
250 END
260 DATA 62,7430
270 DATA B0,00,BE,00,00,8A,9C,80
280 DATA 00,80,FB,02,7C,2C,46,FE
290 DATA CB,46,8A,94,80,00,80,FA
300 DATA 2F,7E,1D,80,FA,3A,7D,18
310 DATA B1,0A,F6,E1,80,EA,30,00
320 DATA D0,FE,CB,75,E4,50,8A,D0
330 DATA B4,02,CD,21,58,E9,02,00
340 DATA B0,00,B4,4C,CD,21

