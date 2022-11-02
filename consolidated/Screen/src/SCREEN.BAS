' SCREEN.BAS
'   by Vincent D. O'Connor
' Copyright (C) 1994 DOS World
' Published in Issue #18, November 1994, page 60
'
'This program may be run in DOS 5.0 and above's QBasic
'or compiled with QuickBasic 4.0 or later, or with
'Visual Basic for DOS.
'
DEFINT A-Z
CONST FALSE = 0
CONST TRUE = NOT FALSE
DIM Code$(9), Lines$(24)
Code$(1) = CHR$(186): Code$(2) = CHR$(9):   Code$(3) = CHR$(1)
Code$(4) = CHR$(180): Code$(5) = CHR$(9):   Code$(6) = CHR$(205)
Code$(7) = CHR$(33):  Code$(8) = CHR$(205): Code$(9) = CHR$(32)

CLS
Message$ = "QBasic Batch File Screen Maker"
LOCATE 1, 41 - INT(LEN(Message$) / 2)
PRINT Message$;
PRINT STRING$(80, 196)
VIEW PRINT 3 TO 24
Start:
ScrnName$ = ""
Lines = 1
Goodname = FALSE
DO WHILE NOT Goodname
   CLS : LOCATE 6, 1
   LINE INPUT "Screen Name: "; ScrnName$
   IF "" = ScrnName$ THEN ScrnName$ = "SCREEN.COM"
   ScrnName$ = UCASE$(ScrnName$)
   Dot = INSTR(ScrnName$, ".")
   IF NOT Dot THEN
      ScrnName$ = ScrnName$ + ".COM"
      Dot = INSTR(ScrnName$, ".")
   END IF
   IF MID$(ScrnName$, Dot) <> ".COM" THEN
      ScrnName$ = MID$(ScrnName$, 1, Dot - 1) + ".COM"
   END IF
   IF LEN(ScrnName$) > 12 THEN
      BEEP: PRINT : PRINT
      PRINT "ERROR! Screen name is too long! - press any key to continue..."
      WHILE INKEY$ = "": WEND
   ELSE
      Goodname = TRUE
   END IF
LOOP
DO WHILE Lines < 25
   CLS : LOCATE 6, 1
   PRINT "Enter line # " + LTRIM$(STR$(Lines)) + " or ENTER to end."
   LOCATE 8, 1: PRINT "=>";
   LINE INPUT Line$(Lines)
   IF "" = Line$(Lines) THEN
      Lines = Lines - 1
      EXIT DO
   END IF
   IF LEN(Line$(Lines)) > 80 THEN
      Line$(Lines) = LEFT$(Line$(Lines), 80)
   END IF
   Length = LEN(Line$(Lines))
   IF "" <> RTRIM$(Line$(Lines)) THEN
      PRINT : PRINT "C)enter, R)ight justify, or L)eft justify line: ";
      DO
         Choice$ = UCASE$(INPUT$(1))
      LOOP WHILE INSTR("CRL", Choice$) < 1
      SELECT CASE Choice$
         CASE "C"
            Line$(Lines) = STRING$(40 - INT(Length / 2), 32) + Line$(Lines)
         CASE "R"
            Line$(Lines) = STRING$(80 - Length, 32) + Line$(Lines)
      END SELECT
   END IF
   Line$(Lines) = Line$(Lines) + CHR$(10) + CHR$(13)
   Lines = Lines + 1
LOOP
IF Lines > 24 THEN Lines = 24
OPEN ScrnName$ FOR OUTPUT AS #1
FOR I = 1 TO 9: PRINT #1, Code$(I); : NEXT
FOR I = 1 TO Lines: PRINT #1, Line$(I); : NEXT
PRINT #1, CHR$(36): CLOSE #1
CLS : LOCATE 12, 1
PRINT "Create another screen (Y/N): ";
DO
   Choice$ = UCASE$(INPUT$(1))
LOOP WHILE INSTR("YN", Choice$) < 1
IF Choice$ = "Y" THEN GOTO Start
VIEW PRINT: CLS : SYSTEM

