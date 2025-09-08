' ******************************TIMENAME******************************
'       by Douglas Park
'    Copyright (c) 1994 DOS Resource Guide
'    Published in Issue # 14, March 1994, page 59
' *********************************************************************

' Create three "lookup" strings.
Month$ = "ABCDEFGHJKLMN"
Day$ = "1234567890ABCDEFGHJKLMNPQRSTUVW"
Hour$ = "1234567890ABCDEFGHJKLMNPQ"

' Get the current date and time.
Str1$ = Date$
Str2$ = Time$

' Generate index numbers from the date and time.
MonthNum = Val(Mid$(Str1$, 1, 2))
DayNum = Val(Mid$(Str1$, 4, 2))
HourNum = Val(Mid$(Str2$, 1, 2))
MinNum = Val(Mid$(Str2$, 4, 2))
SecNum = Val(Mid$(Str2$, 7, 2))

' Create the string TimeName$ by concatenating Date$, the
' "lookup" results, and Hex$.
TimeNam1$ = Mid$(Str1$, 10, 1) + Mid$(Month$, MonthNum, 1)
TimeNam2$ = Mid$(Day$, DayNum, 1) + Mid$(Hour$, HourNum, 1)
TimeNam3$ = Hex$(MinNum) + Hex$(SecNum)
TimeName$ = TimeNam1$ + TimeNam2$ + TimeNam3$

' Print it to the screen.
Print TimeName$

' Open the output file and write two lines to it.
Open "SETNAME.BAT" For Output As #1
Print #1, "@ECHO OFF"
Print #1, "SET TIMENAME=" + TimeName$

' Close the output file and return control to the system.
Close #1
Sleep
System

