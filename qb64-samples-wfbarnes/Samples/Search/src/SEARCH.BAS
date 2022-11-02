DECLARE FUNCTION BINARYSEARCH! (ARRAY!(), SEARCHNUM!)
DECLARE FUNCTION LINEARSEARCH! (ARRAY!(), SEARCHNUM!)

' SEARCH.BAS
'   by Antonio and Alfonso De Pasquale
' Copyright (C) 1994 DOS Resource Guide
' Published in Issue #15, May 1994, page 56

START:
    COLOR 15, 1
    CLS : CLEAR : RANDOMIZE TIMER: ENTRIES = 5000: DIM NUMLIST(ENTRIES)

    PRINT TAB(31); "Search Demonstrator"
    PRINT TAB(25); "By Antonio & Alfonso De Pasquale"
    FOR x = 1 TO 80: PRINT CHR$(196); : NEXT x: PRINT : PRINT
    PRINT " This program proves that a binary search of a large"
    PRINT " array is faster than a linear search of that same array."
    PRINT : PRINT " LINEAR SEARCH and BINARY SEARCH": PRINT
    PRINT " Please wait a moment while I create an array of"; ENTRIES; "random numbers..."
    FOR x = 1 TO ENTRIES: NUMLIST(x) = INT(20 * RND + 1) + NUMLIST(x - 1): NEXT x
    PRINT " The array was created. The numbers range from"; NUMLIST(1); "to"; NUMLIST(x - 1)
    PRINT

MAIN:
    FOR x = 12 TO 22: LOCATE x, 1: PRINT SPACE$(79): NEXT x
    LOCATE 12, 1
    PRINT : PRINT " Choose one: (L)inear Search, (B)inary Search, (Q)uit: ";
    K$ = ""
    DO WHILE K$ <> "L" AND K$ <> "B" AND K$ <> "Q"
      K$ = UCASE$(INKEY$)
    LOOP
    PRINT K$
    IF K$ = "Q" THEN
      COLOR 7, 0
      CLS
      END
    END IF
   
    LOCATE 14, 1
    INPUT " Please enter a number to search for: ", NUM$
    NUMBER = VAL(NUM$): IF NUMBER = 0 THEN CLS : END
    LOCATE 16, 1: PRINT " The search was started at   "; TIME$
  
    IF K$ = "L" THEN
      POSITION = LINEARSEARCH(NUMLIST(), NUMBER)
    ELSE
      POSITION = BINARYSEARCH(NUMLIST(), NUMBER)
    END IF
  
    LOCATE 17, 1: PRINT " The search was completed at "; TIME$
    LOCATE 19, 1
    IF POSITION = -1 THEN
      PRINT " The number you specified isn't in the array."
    ELSE
      PRINT " The number you specified occupies position"; POSITION; "in the array"
    END IF
    LOCATE 21, 2: PRINT "Press Enter to continue"
    DO: LOOP UNTIL INKEY$ = CHR$(13)
    GOTO MAIN

FUNCTION BINARYSEARCH (ARRAY(), SEARCHNUM)

    LOW = LBOUND(ARRAY)
    HIGH = UBOUND(ARRAY)
    INDEX = LOW
    DO WHILE (SEARCHNUM <> ARRAY(INDEX)) AND (LOW <= HIGH)
      INDEX = INT((LOW + HIGH) / 2)
      IF SEARCHNUM < ARRAY(INDEX) THEN HIGH = INDEX - 1
      IF SEARCHNUM > ARRAY(INDEX) THEN LOW = INDEX + 1
    LOOP

    IF SEARCHNUM = ARRAY(INDEX) THEN
      BINARYSEARCH = INDEX
    ELSE
      BINARYSEARCH = -1
    END IF

END FUNCTION

FUNCTION LINEARSEARCH (ARRAY(), SEARCHNUM)

LOW = LBOUND(ARRAY)
HIGH = UBOUND(ARRAY)
FOR INDEX = LOW TO HIGH
  IF SEARCHNUM = ARRAY(INDEX) THEN
    LINEARSEARCH = INDEX
    EXIT FUNCTION
  END IF
NEXT INDEX

LINEARSEARCH = -1

END FUNCTION

