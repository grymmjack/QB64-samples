 ' ----------------------------------------------------------------
 ' PPRIMER.BAS (Printer Primer) by John Wolfskill
 ' Copyright (C) 1992 DOS Resource Guide
 ' Published in Issue #5, page 57.
 '
 ' Requirements: MS-DOS Qbasic or Microsoft QuickBasic 4.x
 '-----------------------------------------------------------------

 '(A) -- Program initialization --

  DEFINT A-Z                ' define all variables as integers

 '(B) -- Setup error-handler --

  ON ERROR GOTO TESTERROR   ' in case of program error, goto this label

 '(C) -- Initialize the screen --

  COLOR 7, 1                ' set colors (white on blue)
  CLS                       ' clear the screen

 '(D) -- Initialize string arrays and define strings --

  DIM ACTION$(6 TO 17), CONTROL$(6 TO 17), MESSAGE$(1 TO 5)
  NUM$ = " A B C D E F G H I J K L"
  RET$ = "<" + STRING$(2, 196) + CHR$(217)
  TE$ = "  to EXIT "

 '(E) -- Define the user input prompts --

  MESSAGE$(1) = " <S>end      <A>ssign      <Q>uit   "
  MESSAGE$(2) = "  <A>ction    <C>ontrol    <E>xit   "
  MESSAGE$(3) = RET$ + "Send   <A-L> Select   <ESC> Exit"
  MESSAGE$(4) = " Type Action String   " + RET$ + TE$
  MESSAGE$(5) = "Type Control String   " + RET$ + TE$

 '(F) -- Define the editing control keys --

  UPKEY$ = CHR$(0) + CHR$(72)        ' up arrow key
  DOWNKEY$ = CHR$(0) + CHR$(80)      ' down arrow key
  LEFTKEY$ = CHR$(0) + CHR$(75)      ' left arrow key
  RIGHTKEY$ = CHR$(0) + CHR$(77)     ' right arrow key
  HOME$ = CHR$(0) + CHR$(71)         ' home key
  END$ = CHR$(0) + CHR$(79)          ' end key
 
 '(G) -- Load the program data file from disk --

  GOSUB LOADFILE                '

 '(H) -- Display the program screen --

  GOSUB INITSCREEN              '

 '(I) -- Display the main prompt --

  MESSAGE = 1                   ' select a message
  GOSUB DISPLAYMESSAGE          ' and display it
  COLOR 7, 0                    ' set the screen colors (white on black)

 '(J) -- Display the data items --

  GOSUB DISPLAYDATA

 '(K) -- Main processing loop --

  DO                            'top of main processing loop
  X$ = INKEY$                   '   check for a keystroke
   X$ = UCASE$(X$)              '   force the ASCII value to uppercase
    SELECT CASE X$              ' define key case structure:

     CASE "S"                   '   if the <S> key was pressed
      MAXPOS = 26               '    assign maximum cursor column position
      MINPOS = 5                '    assign minimum cursor column position
      GOSUB SEND                '    send a control string to the printer
      COLOR 7, 0                '    set colors (white on black)
      GOSUB GATHER              '    read the screen, print the message
      MESSAGE = 1               '    select a message
      GOSUB DISPLAYMESSAGE      '    and display it

     CASE "A"                   '   if the <A> key was pressed
      GOSUB SELECTFUNCTION      '    select a program editing function
      IF CANCELKEY THEN         '   if the cancel flag is set
       CANCELKEY = 0            '    reset it
       GOSUB DISPLAYDATA        '    redisplay the data items
      END IF                    '
                                '   continue with this loop
     CASE "Q"                   '   if the <Q> key was pressed
      GOSUB SAVEFILE            '    save the current data
      CLS                       '    clear the screen
      END                       '    exit the program to DOS or Qbasic

     CASE ELSE                  '
      END SELECT                '   end of key case structure
 LOOP                           ' bottom of main processing loop:

 '(L) -- Select function routine --

SELECTFUNCTION:                 '

  MESSAGE = 2                   ' select a message
  GOSUB DISPLAYMESSAGE          ' and display it

 DO                             ' top of select function loop:
  X$ = INKEY$                   '   check the keyboard for a keystroke
    X$ = UCASE$(X$)             '   force the ASCII value to uppercase
      SELECT CASE (X$)          '  define a key case structure:

       CASE "A"                 '   if the <A> key was pressed
        MESSAGE = 4             '    select a message
        GOSUB DISPLAYMESSAGE    '    and display it
        FF = 0                  '    set function flag to "action"
        MAXPOS = 26             '    assign maximum cursor column position
        MINPOS = 5              '    assign minimum cursor column position
        GOSUB EDITOR            '    call the string editor
        EXIT DO                 '    exit this loop

       CASE "C"                 '   if the <C> key was pressed
        MESSAGE = 5             '    select a message
        GOSUB DISPLAYMESSAGE    '    and display it
        FF = 1                  '    set the function flag to "control"
        MAXPOS = 79             '    assign maximum cursor column position
        MINPOS = 30             '    assign minimum cursor column position
        GOSUB EDITOR            '    call the string editor
        EXIT DO                 '    exit this loop

       CASE "E"                 '   if the <E> key was pressed
        MESSAGE = 1             '    select a message
        GOSUB DISPLAYMESSAGE           '    and display it

       CASE ELSE                '
        END SELECT              '  end of key case structure
 LOOP                           ' Bottom of select function loop

 '(M) -- Action and control string assignment routine --

  IF CANCELKEY = 0 THEN      ' if <esc> key pressed, bypass the actions below
   IF FF = 0 THEN            '   if function flag set for "action" strings
     ACTION$(CLINE) = G$     '     assign G$ to action string variable
   ELSE                      '    else function flag set for "control" strings
     CONTROL$(CLINE) = G$    '     assign G$ to control string variable
   END IF                    '
  END IF                     '

  GOSUB GATHER               ' read and display the input
  MESSAGE = 1                ' select a message
  GOSUB DISPLAYMESSAGE       ' then display it
  RETURN                     ' exit this routine (return to the main prompt)

 '(N) -- Action string editing routine --

EDITOR:                         '

  MAXLINE = 17                  ' define the bottom line of input box
  MINLINE = 6                   ' define the top line of input box
  CPOS = MINPOS                 ' set the column counter to leftmost position
  CLINE = MINLINE               ' set the line counter to the top of the box
 
  LOCATE MINLINE, MINPOS        ' home the cursor, top line of box
  GOSUB GATHER                  ' read the screen, print the message
  COLOR 0, 7                    ' set the highlight colors (black on white)
  LOCATE MINLINE, MINPOS        ' reset the cursor to leftmost position
  GOSUB GATHER                  ' read the screen, print the message

 '(O) -- String editing routine --

 DO                             'top of the editing loop:
  X$ = INKEY$                   '   check for a keystroke
     SELECT CASE (X$)           ' define a key case structure:

      CASE ""                   ' if no key is being pressed
       GOSUB FLASH              '   flash the cursor

      CASE CHR$(13)             ' if the <enter> key was pressed
       GOSUB GATHER             '   read and display the text input
       RETURN                   '   exit this routine

      CASE CHR$(27)             '  if the <esc> key was pressed
       CANCELKEY = 1            '    set the cancel flag
       RETURN                   '    exit this routine
                                '
      CASE UPKEY$               '   if the <up arrow> key was pressed
       IF CLINE > MINLINE THEN  '    then if line is within range
        COLOR 7, 0              '      set colors (white on black)
        GOSUB GATHER            '      read the screen, print the message
        CLINE = CLINE - 1       '      move the cursor bar up
        COLOR 0, 7              '      set highlight colors (black on white)
        GOSUB GATHER            '      read the screen, print the message
       END IF                   '
                                '
     CASE DOWNKEY$              '   if the <down arrow> key was pressed
     IF CLINE < MAXLINE THEN    '     then if the line is within range
      COLOR 7, 0                '       set colors (white on black)
      GOSUB GATHER              '       read the screen, print the message
      CLINE = CLINE + 1         '       move the cursor bar down
      COLOR 0, 7                '       set highlight colors (black on white)
      GOSUB GATHER              '       read the screen, print the message
     END IF                     '
                                '
     CASE LEFTKEY$              '    if the <left arrow> key was pressed
      IF CPOS > MINPOS THEN     '      then if cursor value is within range
       CPOS = CPOS - 1          '        move the cursor left
      END IF                    '
                                '
      CASE RIGHTKEY$            '   if the <right arrow> key was pressed
       IF CPOS < MAXPOS THEN    '      then if cursor value is within range
        CPOS = CPOS + 1         '        move the cursor right
       END IF                   '
                                '
      CASE CHR$(8)              '     if the <backspace> key was pressed
       IF CPOS > MINPOS THEN    '      then if cursor value is within range
        LOCATE CLINE, CPOS: PRINT " "; '  erase the character under cursor
        CPOS = CPOS - 1                 ' move the cursor left
       END IF                   '
                                '
      CASE HOME$                '     if the <Home> key was pressed
       LOCATE CLINE, MINPOS     '      set the cursor to leftmost position
       CPOS = MINPOS            '      set cursor counter to minimum value
                                '
      CASE END$                 '     if the <end> key was pressed
       LOCATE CLINE, MAXPOS     '      set cursor to rightmost position
       CPOS = MAXPOS            '      set cursor counter to maximum value
                                '
      CASE CHR$(32) TO CHR$(127)'     if any other typing key was pressed
       LOCATE CLINE, CPOS       '        locate the cursor
       PRINT X$;                '        print the character
       IF CPOS < MAXPOS THEN    '     if cursor is within range
         CPOS = CPOS + 1        '        move the cursor right
       END IF                   '
                                '
     CASE ELSE                  '
       END SELECT               '   end of the key case structure
                                '
    LOOP                        ' bottom of editing loop
                                '
 '(P)-- Send control strings to printer --

SEND:

  MESSAGE = 3                   '      select a message
  GOSUB DISPLAYMESSAGE          '      display it
  CLINE = LASTITEM              '      set to previous item choice
  IF CLINE < 6 OR CLINE > 17 THEN CLINE = 6 ' check range
  COLOR 0, 7                    '      set highlight colors (black on white)
  GOSUB GATHER                  '      and display the selected letter
 
 DO                             'top of end key loop:
  X$ = INKEY$                   '   check for a keystroke
    X$ = UCASE$(X$)             '   force the ASCII value to uppercase
     SELECT CASE (X$)           ' define a key case structure:
     
          CASE CHR$(65) TO CHR$(76)'  if keystroke within range A-L then
           COLOR 7, 0           '      set colors (white on black)
           GOSUB GATHER         '      and display the letter
           CLINE = ASC(X$) - 59 '      calculate the display line
           LASTITEM = CLINE     '      save choice for next time
           COLOR 0, 7           '      set highlight colors (black on white)
           GOSUB GATHER         '      and display the selected letter
                                '
          CASE CHR$(13)         '   if the <enter> key is pressed then
             GOSUB SENDCODES    '     send the string to the printer
             RETURN             '     exit this routine
                                '
          CASE CHR$(27)         '   if the <escape> key is pressed then
             RETURN             '      exit this routine
                                '
         CASE ELSE              '
          END SELECT            '   end of the key case structure
                                '
    LOOP                        ' bottom of send key loop
                                '
 '(Q) -- Send control string to printer --

SENDCODES:

  J = 0                         ' zero the string character counter
  B$ = ""                       ' setup a temporary string variable
  C$ = RTRIM$(LTRIM$(CONTROL$(CLINE))) + ","   ' select a control string

DO                              '
  J = J + 1                     ' increment the string character counter
                                '
  IF J > LEN(C$) THEN EXIT DO   ' if we've reached the end, exit this routine
   A$ = MID$(C$, J, 1)          '    read the next character
                                '
   IF A$ = "#" THEN             ' if it's a "#" then print the test string
      LPRINT MID$(C$, 2, LEN(C$) - 2); CHR$(13); CHR$(10)
      EXIT DO                   '        exit this loop
   END IF                       '
                                '
  IF A$ = "," OR J = LEN(C$) THEN    ' If it's a comma or end of string
     LPRINT CHR$(VAL(B$)); : B$ = "" '  print the string
   ELSE                         '          otherwise
     B$ = B$ + A$               '           add its value to the temp string
  END IF                        '
                                '
 LOOP                           '          and loop for another character
                                '
 RETURN                         ' exit this routine (to the main prompt)
                                '
 '(R) -- Gather input from screen  --

GATHER:                         '

  G$ = ""                       ' initialize a temporary string variable
                                '
  FOR NPOS = MINPOS TO MAXPOS   ' read characters from the screen
   G$ = G$ + CHR$(SCREEN(CLINE, NPOS))  ' use the temp variable to hold them
  NEXT                          '
                                '
  LOCATE CLINE, MINPOS          ' locate the cursor
  PRINT G$;                     ' print the string
  RETURN                        ' exit this routine

 '(S) -- Display the data items --

DISPLAYDATA:

  FOR J = 6 TO 17               ' top of counter loop:
   LOCATE J, 5                  '   position the cursor
   PRINT ACTION$(J);            '   display the action strings
   LOCATE J, 30                 '   position the cursor
   PRINT CONTROL$(J);           '   display the control strings
  NEXT                          ' bottom of counter loop:
 RETURN

 '(T) -- Flash the cursor --    '

FLASH:                          '

  FL$ = CHR$(SCREEN(CLINE, CPOS))' read the character under the cursor
  COLOR 7, 0                    '    set colors (white on black)
  LOCATE CLINE, CPOS            '    set the cursor position
  PRINT CHR$(219);              '    print a big white block
  GOSUB PAUSE                   '    wait a few clock ticks
  LOCATE CLINE, CPOS            '    locate cursor
  PRINT FL$;                    '    replace the original character
  GOSUB PAUSE                   '    wait a few clock ticks
  RETURN                        '    exit this routine
                                '
 '(U) -- Pause timer --         '

PAUSE:                          '

  T! = TIMER                    ' get the current time
  WHILE T! = TIMER: WEND        ' execute a do-nothing loop
  RETURN                        ' exit this routine
                                '
 '(V) -- Print the user prompt box --

DISPLAYMESSAGE:                 '                  

  LOCATE 20, 20                 '                  locate cursor
  PRINT CHR$(201) + STRING$(36, 205) + CHR$(187) ' display a string
  LOCATE 21, 20                                  ' locate cursor
  PRINT CHR$(186) + STRING$(36, 32) + CHR$(186)  ' display a string
  LOCATE 22, 20                 '                  ' locate cursor
  PRINT CHR$(200) + STRING$(36, 205) + CHR$(188) ' display a string
  LOCATE 21, 21                 ' locate cursor
  PRINT MESSAGE$(MESSAGE);      ' print the message
  RETURN                        ' exit this routine
                                '
 '(W)  -- Save data file to disk --

SAVEFILE:                     '

  OPEN "PP.DAT" FOR OUTPUT AS #1 'open the data file for output
   FOR J = 6 TO 17            '  top of counter loop:
    WRITE #1, CONTROL$(J)     '   write the control strings to disk
    WRITE #1, ACTION$(J)      '   write the action strings to disk
   NEXT                       ' bottom of counter loop
  CLOSE 1                     ' close the file handle
  RETURN                      ' exit this routine
                              '
 '(X) -- Load data file from disk --

LOADFILE:                     '

9999  OPEN "PP.DAT" FOR INPUT AS #1   ' open the data file for input
       FOR J = 6 TO 17        ' top of counter loop:
       INPUT #1, CONTROL$(J)  '   read control strings from disk
       INPUT #1, ACTION$(J)   '   read action strings from disk
       NEXT                   '  bottom of counter loop
      CLOSE 1                 '  close the file handle
      RETURN                  '  exit this routine
                              '
 '(Y) -- Display the program screen --

INITSCREEN:                   '

 COLOR 7, 4                   '                       set colors (white on red)
 LOCATE 1, 1: PRINT STRING$(80, 32); '                 print a blank line
 LOCATE 1, 26: PRINT "DOS RESOURCE PRINTER PRIMER"; ' display a string

 '--Display the Action string box --

 COLOR 0, 7                                     ' set colors (black on white)
 LOCATE 3, 1                                    ' locate cursor
 PRINT CHR$(201) + STRING$(25, 205) + CHR$(187) 'display a string
 LOCATE 4, 1                                    ' locate cursor
 PRINT CHR$(186) + STRING$(9, 32) + "ACTION" + STRING$(10, 32) + CHR$(186)
 LOCATE 5, 1                                    'locate cursor
 PRINT CHR$(199) + STRING$(2, 196) + CHR$(194) + STRING$(22, 196) + CHR$(182)

 '-- Display the item identifiers --

 SPOS = 1                          '          begin with first character
                                   '
 FOR LNE = 6 TO 17                 '            top of counter loop:
  LOCATE LNE, 1                    '                locate cursor
  PRINT CHR$(186); MID$(NUM$, SPOS, 2); '           print portion of string
  PRINT CHR$(179) + STRING$(22, 32) + CHR$(186); '  print the rest
  SPOS = SPOS + 2                                '  increment counter
 NEXT                              '             bottom of counter loop
                                   '
 LOCATE LNE, 1                     '  locate cursor
 PRINT CHR$(200) + STRING$(2, 205) + CHR$(207) + STRING$(22, 205) + CHR$(188);
 COLOR 7, 1                        '  set colors (white on blue)

 ' -- Display the control string box --

 COLOR 0, 7                        ' set highlight colors (black on white)
 LOCATE 3, 29                                   ' locate cursor
 PRINT CHR$(201) + STRING$(50, 205) + CHR$(187) ' display a string
 LOCATE 4, 29                      '            ' locate cursor
 PRINT CHR$(186) + STRING$(16, 32) + "CONTROL STRING" + STRING$(20, 32) + CHR$(186)
 LOCATE 5, 29                      '            ' locate cursor
 PRINT CHR$(199) + STRING$(50, 196) + CHR$(182) ' display a string

 ' -- Display the body --          '

 FOR LNE = 6 TO 17                 '                top of counter loop
   LOCATE LNE, 29                  '                   locate cursor
   PRINT CHR$(186) + STRING$(50, 32) + CHR$(186); '    display a string
  NEXT                              '               bottom of counter loop

 '-- Display the bottom border --

  LOCATE 18, 29                     '                 locate cursor
  PRINT CHR$(200) + STRING$(50, 205) + CHR$(188); '   display a string
  RETURN                            '                 exit this routine

 '(Z) -- Error Handler --   

TESTERROR:                

  IF ERL = 9999 AND ERR = 53 THEN
   GOSUB SAVEFILE: RESUME LOADFILE ' if data file doesn't exist, create it
  END IF

  COLOR 7, 0: CLS : BEEP            '       clear the screen. Red alert
  PRINT "Error "; ERR; " in line "; ERL; '  print the error line and number
  CLOSE                             '       just in case, close all files
  END                               '       Oops! End the program

 '----- End of program code ------------

