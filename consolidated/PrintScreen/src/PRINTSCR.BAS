DECLARE SUB PrintScreen (NumLines%)
' PRINTSCR.BAS
'      Demonstration of how to use QBasic's SCREEN Function to print the
'      contents of a program's text screen display.

'  Copyright (C) 1995 DOS World. All Rights Reserved.

Start:
CLS
LOCATE 1, 1: PRINT "DOS World Screen Print Demonstrator"

' Determine number of lines to display
LOCATE 3, 1
PRINT "How many lines to display?  Enter 25 or 43 (or Q to Quit): ";
LINE INPUT LastLine$
IF UCASE$(LastLine$) = "Q" THEN END    ' If user pressed Q, then quit

NumLines% = VAL(LastLine$)             ' Convert LastLine$ to an integer

IF NumLines% <> 25 AND NumLines% <> 43 THEN    ' Check for valid number of
  LOCATE 5, 1:                                 '    display lines
  PRINT "** Please enter either 25 or 43 **"   ' Print error message
  SLEEP 2                                      ' Delay 2 seconds
  GOTO Start
END IF

' Make a Sample Screen Display
  CLS
  WIDTH 80, NumLines%                  ' Set # of lines to display
 
  Top$ = " 1" + SPACE$(25) + "Top Line of Screen Display" + SPACE$(25) + " 1"
  Bottom$ = LastLine$ + SPACE$(4) + "Bottom Line of Display -- Press Q to Quit or Any Other Key to Print" + SPACE$(5) + LastLine$
  LOCATE 1, 1: PRINT Top$;             ' Print the top line
  LOCATE NumLines%, 1: PRINT Bottom$;  ' Print the bottom line
 
  FOR row = 2 TO NumLines% - 1         ' Print the middle lines
    LOCATE row, 1
    PRINT USING "##"; row; : PRINT STRING$(76, 45); : PRINT USING "##"; row;
  NEXT row
 
  WHILE K$ = ""                        ' Give the user a chance to quit
    K$ = INKEY$                        ' without printing
  WEND
  IF UCASE$(K$) = "Q" THEN END
 
  ' Now call the subroutine that prints the screen.
  ' Include the PrintScreen subroutine in any QBasic program where
  ' want the capability to print text screens.
  CALL PrintScreen(NumLines%)

SUB PrintScreen (NumLines%)
' Include this subroutine in your own programs,
'    then CALL it to print the current text screen.

' PrintScreen requires the single parameter NumLines% to
'    tell it how many lines to print.

' This subroutine should NOT be use with graphics screens.

  FOR row = 1 TO NumLines%
    FOR col = 1 TO 80
      LPRINT CHR$(SCREEN(row, col));
    NEXT col
  NEXT row
  LPRINT CHR$(12)       ' This line sends a Form Feed to the printer.
                        ' Most laser printers require this line to eject
                        ' the page.  You may wish to omit it for use with
                        ' dot matrix printers.

END SUB

