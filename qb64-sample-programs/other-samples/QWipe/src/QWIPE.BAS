DEFINT A-Z

DECLARE SUB WORKING (KOUNT!)

' QWIPE.BAS
'   by Vincent D. O'Connor
' Copyright (C) 1994 DOS Resource Guide
' Published in Issue #17, September 1994 issue, page 67

TYPE WIPECHAR             'The size of the string that
   WIPE AS STRING * 2048  'overwrites the file to be wiped.
END TYPE
DIM CHAR AS WIPECHAR

ON ERROR GOTO ERRTRAP
START:
CLS
LOCATE 12, 1
LINE INPUT "Type the name of the file to be wiped: "; FILE$
IF FILE$ = "" THEN
   CLS : END
END IF
OPEN FILE$ FOR INPUT AS #1
CLOSE : LOCATE 14, 1: BEEP
PRINT "Wipe this file? (Y/N) ";
YN$ = UCASE$(INPUT$(1))
IF YN$ = "N" THEN
   FILE$ = "": GOTO START
END IF
CLS : LOCATE 12, 1
PRINT "Wiping file..."
OPEN FILE$ FOR RANDOM AS #1 LEN = 2048
SIZE = LOF(1) \ 2048       'Determine the number of string
IF SIZE < 1 THEN SIZE = 1  'sections to use to overwrite file.
FOR J = 1 TO 3  'Write three times to ensure that the file is overwritten.
   FOR K = 1 TO 2
      IF K = 1 THEN CHAR.WIPE = STRING$(2048, "0")  'Writes zeros over file.  
      IF K = 2 THEN CHAR.WIPE = STRING$(2048, "1")  'Writes 1s over file.  
      FOR I = 1 TO SIZE
         PUT #1, I, CHAR.WIPE: WORKING (I!)
      NEXT I
   NEXT K
NEXT J
RANDOMIZE TIMER
RANDCHAR = INT(RND * 256)  'Make random character.
CHAR.WIPE = STRING$(2048, RANDCHAR)
FOR I = 1 TO SIZE                      'Write random character
   PUT #1, I, CHAR.WIPE: WORKING (I!)  'over file.
NEXT I
CLOSE : NAME FILE$ AS "$": KILL "$"    'Make filename one character.
CLS : LOCATE 12, 1: BEEP
PRINT "File wiped! Press any key to continue..."
DO: LOOP WHILE INKEY$ = ""
GOTO START

ERRTRAP:
IF ERR <> 53 THEN
   PRINT ERR: CLOSE : END
ELSE
   BEEP: LOCATE 20, 1: PRINT "Error!      File not found!"
   LOCATE 21, 1: PRINT "Press any key to continue..."
   DO: LOOP WHILE INKEY$ = ""
   FILE$ = ""
   RESUME START
END IF

DEFSNG A-Z
SUB WORKING (KOUNT!)
   LOCATE 12, 15
   IF KOUNT! / 2 = KOUNT! \ 2 THEN
      PRINT "/"
   ELSE
      PRINT "\"
   END IF
END SUB

