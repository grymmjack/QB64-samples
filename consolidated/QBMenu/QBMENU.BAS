'  QBMENU.BAS
'    by John Wolfskill
'  Copyright (C) 1994 DOS World Magazine
'  Published in Issue #16, July 1994, page 40
      
   DEFINT A-Z
   ON ERROR GOTO TESTERROR
   COLOR 15, 1: CLS
' -- Initialize string and integer arrays --
   DIM ITEM$(6 TO 17), PATHNAME$(6 TO 17), APPNAME$(6 TO 17), DIRPATH$(6 TO 17)
   DIM NEWITEM$(13), NEWPATHNAME$(13), NEWAPPNAME$(13), NEWDIRPATH$(13), RCOL(13)
   ' -- Setup internal string variables --
  COLOR$ = "     0=Black  1=Red  2=Green  3=Yellow  4=Blue  5=Magenta  6=Cyan  7=White      "
  ESC$ = "ECHO " + CHR$(27) + "[": NUM$ = "ABCDEFGHIJKL"
  TOPBAR$ = CHR$(201) + STRING$(60, 205) + CHR$(187)
  SIDEBAR$ = CHR$(186) + STRING$(60, 32) + CHR$(186)
  BOTTOMBAR$ = CHR$(200) + STRING$(60, 205) + CHR$(188)
  INDENT$ = STRING$(6, 32)
  MESSAGE$(1) = " <E>dit   <O>ptions   <C>reate   <P>urge   <S>ave and Quit   <A>bandon  "
  MESSAGE$(2) = " <TAB> Change Fields      <Up><Dn><ENTER>  Next Item      <ESC> Exit    "
  UK$ = CHR$(0) + CHR$(72)       'Cursor up
  DK$ = CHR$(0) + CHR$(80)       'Cursor down
  LK$ = CHR$(0) + CHR$(75)       'Cursor left
  RK$ = CHR$(0) + CHR$(77)       'Cursor right
  HOME$ = CHR$(0) + CHR$(71)     'Home cursor
  END$ = CHR$(0) + CHR$(79)      'End cursor
  ' -- Establish the default batch file data --
  GOSUB BLANKALL

  DOSBACKCOLOR$ = "0"            'Black screen background
  DOSTEXTCOLOR$ = "7"            'White text
  DOSFILLCOLOR$ = "4"            'on a blue background
  TIMEOUT$ = "20"                '20-second default timeout
  TIMEITEM$ = "A"                'Default item is A
  BATCHNAME$ = "MENU.BAT"        'Default name of batch file
  BATCHPATH$ = "C:\"             'Default path for batch file
  TITLE$ = "Applications Menu"   'Default menu title
  PROMPT$ = "Select a Menu Item" 'Default menu prompt
  BORDER$ = "1"                  'Graphics border enabled

' -- Load current batch file data from disk --
9999 OPEN "MM.DAT" FOR INPUT AS #1

    FOR CLNE = 6 TO 17
     INPUT #1, PATHNAME$(CLNE)
     IF LEFT$(PATHNAME$(CLNE), 1) <> "~" THEN GOSUB PARSE
     INPUT #1, ITEM$(CLNE)
    NEXT

  INPUT #1, DOSBACKCOLOR$
  INPUT #1, DOSTEXTCOLOR$
  INPUT #1, DOSFILLCOLOR$
  INPUT #1, TIMEOUT$
  INPUT #1, BORDER$
  INPUT #1, TIMEITEM$
  INPUT #1, BATCHNAME$
  INPUT #1, BATCHPATH$
  INPUT #1, TITLE$
  INPUT #1, PROMPT$
  CLOSE 1

'-- Routine draws the program screen --
GETPIC:
  COLOR 0, 15
  LOCATE 2, 10: PRINT STRING$(60, 32);
  LOCATE 2, 22: PRINT "DOS Resource Guide Batch File Menu Maker"
  LOCATE 4, 5: PRINT STRING$(72, 32)
  LOCATE 4, 15: PRINT "Menu Item"
  LOCATE 4, 42: PRINT "Command for Menu Item"
  COLOR 15, 0
 
  FOR J = 6 TO 17
   LOCATE J, 5: PRINT ITEM$(J);
   LOCATE J, 30: PRINT PATHNAME$(J);
  NEXT

  SPOS = 1

  FOR LNE = 6 TO 17
   LOCATE LNE, 2: PRINT MID$(NUM$, SPOS, 1);
   SPOS = SPOS + 1
  NEXT

  MESSAGE = 1: GOSUB MESSAGEBAR  'Displays main menu
 '-- Routine accepts keyboard input for main menu --
GETKEYS:
  DO
    X$ = INKEY$
    X$ = UCASE$(X$)
    SELECT CASE X$
     CASE "O"         'Select batch file options
      GOSUB OPTIONS: GOSUB MENUBAR
      MESSAGE = 1: GOSUB MESSAGEBAR
     CASE "E"        'Edit item strings and DOS pathnames
      ACTION = 1: MESSAGE = 2: GOSUB MESSAGEBAR
      GOSUB ASSIGN
      MESSAGE = 1: GOSUB MESSAGEBAR
     CASE "A"        'Abandon the changes
      GOSUB SAVEFILE: CLS : SYSTEM
     CASE "S"        'Save the data and quit
      GOSUB SAVEFILE: CLS : SYSTEM
     CASE "C"        'Create a DOS batch file
       GOSUB PURGE: GOSUB MAKEBATCH: GOTO GETPIC
     CASE "P"        'Purge blank entries from list
       GOSUB PURGE
     CASE ELSE
    END SELECT
  LOOP
' -- Routine edits prompt/pathname strings --
ASSIGN:
  MAXLNE = 17: MINLNE = 6: CLNE = MINLNE

ASSIGN1:
  IF ACTION = 1 THEN MAXPOS = 26: MINPOS = 5
  IF ACTION = 2 THEN MAXPOS = 76: MINPOS = 30
  CPOS = MINPOS: LOCATE MINLNE, MINPOS: GOSUB GATHER
  COLOR 0, 15: LOCATE MINLNE, MINPOS: GOSUB GATHER

MOVECUR:
  DO
   X$ = INKEY$
      SELECT CASE (X$)
      CASE ""
       GOSUB FLASH
         
     CASE CHR$(13)
      IF CLNE < MAXLNE THEN
       COLOR 15, 0: GOSUB GATHER
       CLNE = CLNE + 1: CPOS = MINPOS
       COLOR 0, 15: GOSUB GATHER
      END IF
     
      CASE CHR$(27)
       GOSUB GATHER: RETURN
      
      CASE UK$
      IF CLNE > MINLNE THEN
       COLOR 15, 0: GOSUB GATHER
       CLNE = CLNE - 1
       COLOR 0, 7: GOSUB GATHER
      END IF
  
    CASE DK$
     IF CLNE < MAXLNE THEN
      COLOR 15, 0: GOSUB GATHER
      CLNE = CLNE + 1
      COLOR 0, 15: GOSUB GATHER
     END IF
 
    CASE LK$
     IF CPOS > MINPOS THEN CPOS = CPOS - 1
    
   CASE RK$
     IF CPOS < MAXPOS THEN CPOS = CPOS + 1
     
   CASE CHR$(8)
    IF CPOS > MINPOS THEN
      COLOR 0, 15: LOCATE CLNE, CPOS: PRINT " "; : COLOR 15, 0
      CPOS = CPOS - 1
    END IF

    CASE CHR$(9)
     COLOR 15, 0: GOSUB GATHER
     IF ACTION = 1 THEN ACTION = 2 ELSE ACTION = 1
     GOTO ASSIGN1
  
   CASE HOME$
    LOCATE CLNE, MINPOS: CPOS = MINPOS

   CASE END$
    LOCATE CLNE, MAXPOS: CPOS = MAXPOS

   CASE CHR$(32) TO CHR$(127)
      COLOR 0, 15: LOCATE CLNE, CPOS: PRINT X$; : COLOR 15, 0
      IF CPOS < MAXPOS THEN CPOS = CPOS + 1
    CASE ELSE
   END SELECT

  LOOP
' -- Routine reads text strings from the screen --
GATHER:
  
  GATHER$ = ""

  FOR NPOS = MINPOS TO MAXPOS
   GATHER$ = GATHER$ + CHR$(SCREEN(CLNE, NPOS))
  NEXT

  LOCATE CLNE, MINPOS
  IF ACTION = 1 THEN ITEM$(CLNE) = GATHER$
  IF ACTION = 2 THEN PATHNAME$(CLNE) = GATHER$
  IF LEFT$(PATHNAME$(CLNE), 1) <> "~" THEN GOSUB PARSE
  PRINT GATHER$;
  RETURN
  '-- Routine sets item/pathname arrays to default values --
BLANKALL:
  FOR J = 6 TO 17
   PATHNAME$(J) = STRING$(47, 32)
   ITEM$(J) = "~" + STRING$(21, 32)
   APPNAME$(J) = ""
   DIRPATH$(J) = ""
  NEXT
  RETURN
'-- Routine separates DOS pathname from application name --
PARSE:
  APPNAME$(CLNE) = ""
  QQ = LEN(PATHNAME$(CLNE))

  FOR J = QQ TO 1 STEP -1
    IF MID$(PATHNAME$(CLNE), J, 1) = "\" THEN
     IF J = Q THEN EXIT FOR
     APPNAME$(CLNE) = RIGHT$(PATHNAME$(CLNE), QQ - J)
     DIRPATH$(CLNE) = LEFT$(PATHNAME$(CLNE), J - 1)
     EXIT FOR
    END IF
  NEXT

  RETURN
' -- Routine flashes the cursor --
FLASH:
  FL$ = CHR$(SCREEN(CLNE, CPOS))
  COLOR 15, 0: LOCATE CLNE, CPOS: PRINT CHR$(219);
  GOSUB PAUSE
  COLOR 0, 15: LOCATE CLNE, CPOS: PRINT FL$;
  GOSUB PAUSE
  RETURN
' -- Pause timer --
PAUSE:
  T! = TIMER: WHILE T! = TIMER: WEND: RETURN
'-- Routine clears the text scroll area --
MENUBAR:
  COLOR 15, 0
  FOR LNE = 19 TO 25
   LOCATE LNE, 1: PRINT STRING$(80, 32);
  NEXT
  RETURN
'-- Routine displays the main menu --
MESSAGEBAR:
  COLOR 0, 15: LOCATE 22, 4: PRINT MESSAGE$(MESSAGE); : COLOR 15, 0
  RETURN
' -- Routine saves the menu data to disk for later use--
SAVEFILE:
  OPEN "MM.DAT" FOR OUTPUT AS #1

  FOR J = 6 TO 17
   WRITE #1, PATHNAME$(J)
   WRITE #1, ITEM$(J)
  NEXT

  WRITE #1, DOSBACKCOLOR$
  WRITE #1, DOSTEXTCOLOR$
  WRITE #1, DOSFILLCOLOR$
  WRITE #1, TIMEOUT$
  WRITE #1, BORDER$
  WRITE #1, TIMEITEM$
  WRITE #1, BATCHNAME$
  WRITE #1, BATCHPATH$
  WRITE #1, TITLE$
  WRITE #1, PROMPT$
  CLOSE 1
  RETURN
 ' -- Routine removes blank items from list --
PURGE:
  TT$ = "": MENUITEMS = 0

  FOR J = 6 TO 17                 'Removes blank items from the list
   IF LEFT$(ITEM$(J), 1) <> "~" THEN
    MENUITEMS = MENUITEMS + 1
    NEWITEM$(MENUITEMS) = ITEM$(J)
    NEWPATHNAME$(MENUITEMS) = PATHNAME$(J)
    NEWAPPNAME$(MENUITEMS) = APPNAME$(J)
    NEWDIRPATH$(MENUITEMS) = DIRPATH$(J)
    TT$ = TT$ + CHR$(64 + MENUITEMS)  'Creates the CHOICE key list
   END IF
  NEXT

   GOSUB BLANKALL: COLOR 15, 0

   FOR J = 1 TO MENUITEMS
    ITEM$(J + 5) = NEWITEM$(J)
    PATHNAME$(J + 5) = NEWPATHNAME$(J)
    APPNAME$(J + 5) = NEWAPPNAME$(J)
    DIRPATH$(J + 5) = NEWDIRPATH$(J)
   NEXT

  MENUITEMS = MENUITEMS + 1        'Increment no. of items
  NEWITEM$(MENUITEMS) = "Exit"     'Add exit-to-DOS item
  TT$ = TT$ + CHR$(64 + MENUITEMS) 'Create CHOICE key list

  FOR J = 6 TO 17
   LOCATE J, 5: PRINT ITEM$(J);
   LOCATE J, 30: PRINT PATHNAME$(J);
  NEXT

  RETURN
' -- Error Handler --
TESTERROR:
  IF ERR > 23 AND ERR < 28 OR ERR = 68 THEN RESUME NEXT
' -- Create a new data file, if none exists --
  IF ERL = 9999 THEN
     IF ERR = 53 THEN GOSUB SAVEFILE: RESUME 9999
  END IF

  CLS : PRINT "Error "; ERR; " in line "; ERL; : CLOSE : END
'-- Routine selects colors and timeout values --
OPTIONS:
  GOSUB MENUBAR
  LOCATE 18, 1: COLOR 0, 15: PRINT COLOR$; : COLOR 15, 0
  LOCATE 20, 1: VIEW PRINT 20 TO 24

TITLE:
  PRINT : PRINT "Current menu title is: "; TITLE$
  PRINT "Type a new title (55 or fewer characters) "; : INPUT TL$

  IF LEN(TL$) > 55 THEN
   BEEP: PRINT "Title too long...Retry"
   FOR J = 1 TO 30: GOSUB PAUSE: NEXT
   GOTO TITLE
  END IF

  IF TL$ <> "" THEN TITLE$ = LTRIM$(RTRIM$(TL$))

PROMPT:
  PRINT : PRINT "Current prompt string is: "; PROMPT$
  PRINT "Type a new prompt string (55 or fewer characters)"; : INPUT PT$

  IF LEN(PT$) > 55 THEN
   BEEP: PRINT "Prompt string too long ..Retry"
   FOR J = 1 TO 30: GOSUB PAUSE: NEXT
   GOTO PROMPT
  END IF

  IF PT$ <> "" THEN PROMPT$ = LTRIM$(RTRIM$(PT$)) + " ?"
  
  PRINT : PRINT "Current screen background color is: "; DOSBACKCOLOR$
  INPUT "Enter a new screen background color (0-7)"; DBC$
  IF DBC$ <> "" THEN DOSBACKCOLOR$ = DBC$
  
  PRINT : PRINT "Current text foreground color is: "; DOSTEXTCOLOR$
  INPUT "Enter a new text foreground color (0-7)"; DTC$
  IF DTC$ <> "" THEN DOSTEXTCOLOR$ = DTC$
  
  PRINT : PRINT "Current text background color is: "; DOSFILLCOLOR$
  INPUT "New text background color (0-7)"; DFC$
  IF DFC$ <> "" THEN DOSFILLCOLOR$ = DFC$

  IF BORDER$ = "1" THEN OLDYN$ = "Yes" ELSE OLDYN$ = "No"

  PRINT : PRINT "Current border preference is: "; OLDYN$
  INPUT "Do you want a graphics menu border (y/n)"; YN$
  IF UCASE$(YN$) = "Y" THEN BORDER$ = "1"
  IF UCASE$(YN$) = "N" THEN BORDER$ = "0"
  
  PRINT : PRINT "Current menu timeout is: "; TIMEOUT$; " seconds"
  INPUT "Enter a new timeout value (0-99 seconds 0=No timeout)"; TMO$
  IF TMO$ <> "" THEN TIMEOUT$ = TMO$
  
  PRINT : PRINT "Current timeout item is: "; TIMEITEM$
  PRINT "Enter a new timeout item (A-L)"; : INPUT TI$
' The following line was added after this program listing was published in
' DOS Resource Guide Magazine.  It forces whatever letter you enter as the
' timeout item to uppercase, which QBMENU.BAS requires.
  TI$ = UCASE$(TI$)
  IF TI$ <> "" THEN TIMEITEM$ = TI$

  VIEW PRINT: GOSUB MENUBAR: RETURN
'-- Routine creates batch file from menu data --
MAKEBATCH:

  QQ$ = CHR$(64 + MENUITEMS)

  IF LEFT$(TIMEITEM$, 1) > QQ$ THEN
   BEEP: GOSUB MENUBAR: LOCATE 23, 1
   PRINT " Default timeout item invalid. Max. allowable letter is " + QQ$
   FOR J = 1 TO 100: GOSUB PAUSE: NEXT
   GOSUB MENUBAR
   RETURN
  END IF

  GOSUB MENUBAR
  ITEMROW = (25 - MENUITEMS) / 2   'Assign screen row

  FOR J = 1 TO MENUITEMS           'Calculate screen coordinates
   NEWITEM$(J) = "(" + CHR$(64 + J) + ")   " + NEWITEM$(J)
   RCOL(J) = (80 - LEN(NEWITEM$(J))) / 2   'Assign screen column
  NEXT
  
  ITEMCOLUMN = 40           'Default is center of screen

  FOR J = 1 TO MENUITEMS    'Find leftmost column for entire menu block
   WORKINGCOLUMN = RCOL(J)  'by checking the length of each item
    IF WORKINGCOLUMN < ITEMCOLUMN THEN
     ITEMCOLUMN = WORKINGCOLUMN
     ITEMLENGTH = LEN(NEWITEM$(J))
    END IF
  NEXT

  IF ITEMCOLUMN < 2 THEN ITEMCOLUMN = 2 'Check for out-of-range columns
  TITLECOLUMN = (80 - LEN(TITLE$)) / 2  'Center title over menu
  VIEW PRINT 20 TO 24                   'Set text scroll box
'--
BATCH:
  CLS : PRINT "Current batch filename is: "; BATCHNAME$
  PRINT "Enter new filename, omitting file extension"; : INPUT BN$

  IF INSTR(BN$, ".BAT") OR LEN(BN$) > 8 THEN
   PRINT "Invalid filename...": BEEP: BEEP: GOTO BATCH
  END IF

  IF LEN(BN$) > 1 THEN BATCHNAME$ = UCASE$(LTRIM$(RTRIM$(BN$))) + ".BAT"
 
  PRINT : PRINT "Current pathname for batch file is: "; BATCHPATH$
  PRINT "Enter new pathname for batch file: "; : INPUT BP$
  IF BP$ <> "" THEN BATCHPATH$ = LTRIM$(RTRIM$(BP$))
 
  IF LEN(BATCHPATH$) = 3 THEN  'Removes trailing backslash, if present
   IF MID$(BATCHPATH$, 3, 1) = "\" THEN DOSMENU$ = BATCHPATH$ + BATCHNAME$
  ELSE
    DOSMENU$ = BATCHPATH$ + "\" + BATCHNAME$
  END IF
 
  '-- Create the menu batch file --
  PRINT : PRINT "Please wait...Creating " + DOSMENU$
  FOR J = 1 TO 30: GOSUB PAUSE: NEXT
  
  IF TIMEOUT$ <> "0" THEN
   CHOICE$ = INDENT$ + "Choice /n /t:"    'Zero means no default timeout
   T1$ = TIMEITEM$ + "," + TIMEOUT$ + " /c:"
  ELSE
   CHOICE$ = INDENT$ + "Choice /n"        'Default timeout specified
   T1$ = " /c:"
  END IF

  OPEN DOSMENU$ FOR OUTPUT AS #1
    PRINT #1, INDENT$ + "@ECHO OFF"
    PRINT #1, " "
    PRINT #1, " REM -- DOS RESOURCE GUIDE MENU MAKER BATCH FILE --"
    PRINT #1, " "
    PRINT #1, " REM  This batch file requires the ANSI.SYS driver"
    PRINT #1, " REM  and a color monitor for proper operation."
    PRINT #1, " "
    PRINT #1, ":START"
    PRINT #1, INDENT$ + ESC$ + "3" + DOSTEXTCOLOR$ + ";" + "4" + DOSBACKCOLOR$ + "m"
    PRINT #1, INDENT$ + ESC$ + "2J"
    PRINT #1, INDENT$ + ESC$ + "3" + DOSTEXTCOLOR$ + ";" + "4" + DOSFILLCOLOR$ + "m"
    PRINT #1, " "

   IF BORDER$ = "1" THEN
    PRINT #1, INDENT$ + ESC$ + "3;10H" + TOPBAR$
    FOR JJ = 4 TO 20
     PRINT #1, INDENT$ + ESC$ + LTRIM$(STR$(JJ)) + ";10H" + SIDEBAR$
    NEXT
    PRINT #1, INDENT$ + ESC$ + "21;10H" + BOTTOMBAR$
  END IF

    PRINT #1, " "
    PRINT #1, INDENT$ + ESC$ + LTRIM$(STR$(ITEMROW - 2)) + ";" + LTRIM$(STR$(TITLECOLUMN)) + "H" + TITLE$
  
   FOR J = 1 TO MENUITEMS
    IF CHR$(J + 64) = LEFT$(TIMEITEM$, 1) THEN I$ = "*" ELSE I$ = ""
    LI$ = NEWITEM$(J) + I$ + STRING$(ITEMLENGTH - LEN(NEWITEM$(J)), 32)
    PRINT #1, INDENT$ + ESC$ + LTRIM$(STR$(ITEMROW)) + ";" + LTRIM$(STR$(ITEMCOLUMN)) + "H" + LI$
    ITEMROW = ITEMROW + 1
   NEXT

   PROMPTCOLUMN = (80 - LEN(PROMPT$)) / 2     'Centers prompt below menu
   P1$ = CHR$(27) + "[" + LTRIM$(STR$(ITEMROW + 1)) + ";" + LTRIM$(STR$(PROMPTCOLUMN)) + "H " + PROMPT$
   PRINT #1, " "
   PRINT #1, CHOICE$ + T1$ + TT$ + " " + P1$

   FOR J = MENUITEMS TO 1 STEP -1
    PRINT #1, INDENT$ + "IF ERRORLEVEL " + LTRIM$(STR$(J)); " GOTO ITEM" + CHR$(64 + J)
   NEXT

   FOR J = MENUITEMS - 1 TO 1 STEP -1
    PRINT #1, " "
    PRINT #1, ":ITEM" + CHR$(64 + J)
    PRINT #1, INDENT$ + ESC$ + "37;40m"
    PRINT #1, INDENT$ + ESC$ + "2J"
    PRINT #1, INDENT$ + "CD " + UCASE$(NEWDIRPATH$(J))
    PRINT #1, INDENT$ + UCASE$(NEWAPPNAME$(J))
    PRINT #1, INDENT$ + "CD " + UCASE$(BATCHPATH$)
    PRINT #1, INDENT$ + "GOTO START"
   NEXT

   PRINT #1, " "
   PRINT #1, ":ITEM" + CHR$(64 + MENUITEMS)
   PRINT #1, INDENT$ + ESC$ + "37;40m"
   PRINT #1, INDENT$ + ESC$ + "2J"
   CLOSE #1

  PRINT : PRINT DOSMENU$ + " was created successfully..."
  FOR J = 1 TO 30: GOSUB PAUSE: NEXT
  PRINT : PRINT "Add " + DOSMENU$ + " to your AUTOEXEC.BAT file (Y/N)";
  INPUT YN$: PRINT

  IF UCASE$(YN$) = "Y" THEN
   OPEN LEFT$(BATCHPATH$, 1) + ":\AUTOEXEC.BAT" FOR APPEND AS #1
   PRINT #1, "REM DRG MENU-MAKER BATCH FILE"
   PRINT #1, "CD " + BATCHPATH$
   PRINT #1, "CALL " + DOSMENU$
   PRINT #1, "CD " + LEFT$(BATCHPATH$, 1) + ":\"
   CLOSE #1
   PRINT DOSMENU$ + " was added to your AUTOEXEC.BAT file...";
   FOR J = 1 TO 20: GOSUB PAUSE: NEXT
  END IF

  CLS : VIEW PRINT: RETURN

