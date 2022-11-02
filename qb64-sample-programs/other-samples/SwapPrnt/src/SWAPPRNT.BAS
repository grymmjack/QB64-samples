'  SWAPPRNT.BAS
'  Swaps LPT1 and LPT2
'     by John Wolfskill
'
'  Copyright (C) 1993 DOS Resource Guide
'  Published in Issue # 13, January 1994, page 66


5 DEFINT A-Z
10 DEF SEG = &H40           ' ROM BIOS data area
20 FOR J = 0 TO 3           ' Two 16-bit numbers
30   A(J) = PEEK(J + 8)     ' Read LPT1 and LPT2 addresses
40 NEXT J                   ' into small array
50 SWAP A(0), A(2)          ' Swap LPT1 and LPT2 LSBs
60 SWAP A(1), A(3)          ' Swap LPT1 and LPT2 MSBs
70 FOR J = 0 TO 3           ' Two 16-bit numbers
80   POKE J + 8, A(J)       ' Restore addresses
90 NEXT J                   ' from array
100 DEF SEG                 ' Restore Basic's DS
110 SYSTEM                  ' Return to DOS





