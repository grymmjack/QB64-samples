'CHDIR ".\samples\thebob\leapfrog"

'*****************************************************************************
'
'----------------------- L E A P F R O G. B A S -- 2.1 -----------------------
'
'------------ Copyright (C) 2002 - 2007 by Bob Seguin (Freeware) -------------
'
'*****************************************************************************
DefInt A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, mX, mY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB Interval (Length!)

DECLARE SUB DrawSCREEN ()
DECLARE SUB RAMarrays ()
DECLARE SUB SETxy (Pad)
DECLARE SUB Rings (Pad, Colr)
DECLARE SUB PutFROG (Pad, Image)
DECLARE SUB Hop (From, Destination, Direction)
DECLARE FUNCTION HopCHEK (Pad1, Pad2)
DECLARE FUNCTION HopDIRECTION (Pad1, Pad2)

Dim Shared LilyPOND(1 To 15)
Dim Shared Box(1 To 16400)
Dim Shared BasicsBOX(1 To 3000)
Dim Shared BackBOX(1 To 1650)
Dim Shared ErrorBOX(1 To 2640)
Dim Shared SoundON
Dim Shared MouseDATA$

Const ArrayHOP& = 1650
Const Wdth = 89
Const Dpth = 67

For n = 2 To 15
    LilyPOND(n) = 1
Next n

'Create and load MouseDATA$ for CALL ABSOLUTE routines
Data 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
Data 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
Data 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = Space$(57)
For i = 1 To 57
    Read h$
    Hexxer$ = Chr$(Val("&H" + h$))
    Mid$(MouseDATA$, i, 1) = Hexxer$
Next i

Moused = InitMOUSE
If Not Moused Then
    Print "Sorry, cat must have got the mouse."
    Sleep 2
    System
End If

Screen 12

Out &H3C8, 0
For n = 1 To 48
    Out &H3C9, 0
Next n

RAMarrays
DrawSCREEN
GoSub SetPALETTE

ShowMOUSE
SoundON = 1

Do
    k$ = InKey$
    If k$ = Chr$(27) Then System
    MouseSTATUS LB, RB, MouseX, MouseY
    Select Case MouseY
        Case 8 TO 18
            Select Case MouseX
                Case 130 TO 188
                    If Menu <> 1 Then
                        GoSub PutMENU
                        Mx1 = 130: Mx2 = 188
                        GoSub GetMENU
                        HideMOUSE
                        Put (130, 8), BasicsBOX(1851), PSet
                        ShowMOUSE
                        Menu = 1
                    End If
                    If LB Then GoSub NewGAME
                Case 220 TO 258
                    If Menu <> 2 Then
                        GoSub PutMENU
                        Mx1 = 220: Mx2 = 260
                        GoSub GetMENU
                        HideMOUSE
                        Put (220, 8), BasicsBOX(2201), PSet
                        ShowMOUSE
                        Menu = 2
                    End If
                    If LB Then
                        If SoundON = 0 Then
                            HideMOUSE
                            Put (220, 8), BasicsBOX(2101), PSet
                            ShowMOUSE
                            SoundON = 1
                        Else
                            HideMOUSE
                            Put (220, 8), BasicsBOX(2301), PSet
                            ShowMOUSE
                            SoundON = 0
                        End If
                        GoSub GetMENU
                        ClearMOUSE
                    End If
                Case 600 TO 626
                    If Menu <> 3 Then
                        GoSub PutMENU
                        Mx1 = 600: Mx2 = 626
                        GoSub GetMENU
                        HideMOUSE
                        Put (600, 8), BasicsBOX(2001), PSet
                        ShowMOUSE
                        Menu = 3
                    End If
                    If LB Then System
                Case Else
                    If Menu Then GoSub PutMENU
            End Select
        Case 65 TO 121
            Select Case MouseX
                Case 290 TO 346: Pad = 1
            End Select
        Case 145 TO 201
            Select Case MouseX
                Case 242 TO 298: Pad = 2
                Case 338 TO 394: Pad = 3
            End Select
        Case 225 TO 281
            Select Case MouseX
                Case 194 TO 250: Pad = 4
                Case 290 TO 346: Pad = 5
                Case 386 TO 442: Pad = 6
            End Select
        Case 305 TO 361
            Select Case MouseX
                Case 146 TO 202: Pad = 7
                Case 242 TO 298: Pad = 8
                Case 338 TO 394: Pad = 9
                Case 434 TO 490: Pad = 10
            End Select
        Case 385 TO 441
            Select Case MouseX
                Case 98 TO 154: Pad = 11
                Case 194 TO 250: Pad = 12
                Case 290 TO 346: Pad = 13
                Case 386 TO 442: Pad = 14
                Case 482 TO 538: Pad = 15
            End Select
        Case Else
            If Menu Then GoSub PutMENU
    End Select

    If BoxON Then If LB And MouseX > 578 Then System
    If GameOVER = 0 Then
        If LB And Pad Then
            If Chosen Then
                If Pad = Pad1 Then
                    Rings Pad1, 11
                    Pad1 = 0: Chosen = 0
                    ClearMOUSE
                    GoTo Continue
                End If
                Direction = HopDIRECTION(Pad1, Pad)
                MidPAD = HopCHEK(Pad1, Pad)
                GoSub ErrorCHECK
                If Pad Then
                    Rings Pad1, 11
                    Chosen = 0
                    Hop Pad1, Pad, Direction
                    LilyPOND(Pad) = 1
                    LilyPOND(Pad1) = 0
                    LilyPOND(MidPAD) = 0
                    PutFROG MidPAD, 3
                    If SoundON Then Play "MBMST220L64O1cP16eP16g"
                    Interval .1
                    PutFROG MidPAD, 2
                    Interval .3
                    PutFROG MidPAD, 1
                    If SoundON Then Play "MBT220L64O2b"
                    Pad1 = 0: Pad = 0: Chosen = 0
                    For n = 1 To 15
                        If LilyPOND(n) = 1 Then
                            Count = Count + 1
                            LastPAD = n
                        End If
                    Next n
                    If Count = 1 Then
                        Interval .3
                        If SoundON Then
                            Play "MFMST120O1L16ceg>ceg>ceg>L32cg"
                            Play "MBMST120O4L32cgcgcgcg"
                        End If
                        PutFROG LastPAD, 3
                        For Reps = 1 To 8
                            Rings LastPAD, 0
                            Wait &H3DA, 8
                            Wait &H3DA, 8, 2
                            Rings LastPAD, 9
                            Wait &H3DA, 8
                            Wait &H3DA, 8, 8
                            Rings LastPAD, 4
                            Wait &H3DA, 8
                            Wait &H3DA, 8, 8
                            Rings LastPAD, 11
                            Wait &H3DA, 8
                            Wait &H3DA, 8, 8
                        Next Reps
                        Rings LastPAD, 9
                        PutFROG LastPAD, 2
                        GameOVER = 1
                    Else
                        Count = 0
                    End If
                End If
            Else
                If LilyPOND(Pad) = 1 Then
                    Rings Pad, 7
                    Pad1 = Pad
                    Chosen = 1
                    ClearMOUSE
                Else
                    HideMOUSE
                    Put (38, 230), ErrorBOX(), PSet
                    ShowMOUSE
                    Interval 1.5
                    HideMOUSE
                    Line (36, 230)-(160, 260), 0, BF
                    ShowMOUSE
                    Pad1 = 0: Pad = 0: Chosen = 0
                End If
            End If
        End If
    End If
    Continue:
    Pad = 0
Loop

System

ErrorCHECK:
If MidPAD = 0 Then
    HideMOUSE
    Put (38, 230), ErrorBOX(661), PSet
    ShowMOUSE
    Rings Pad1, 11
    Pad = 0: Pad1 = 0: Chosen = 0
    Interval 1.5
    HideMOUSE
    Line (36, 230)-(160, 260), 0, BF
    ShowMOUSE
    Return
End If
If LilyPOND(Pad) = 1 Then
    HideMOUSE
    Put (38, 230), ErrorBOX(1321), PSet
    ShowMOUSE
    Rings Pad1, 11
    Pad = 0: Pad1 = 0: Chosen = 0
Else
    If LilyPOND(MidPAD) = 0 Then
        HideMOUSE
        Put (38, 230), ErrorBOX(1981), PSet
        ShowMOUSE
        Rings Pad1, 11
        Pad = 0: Pad1 = 0: Chosen = 0
    End If
End If
If Pad = 0 Then
    Interval 1.5
    HideMOUSE
    Line (36, 230)-(160, 260), 0, BF
    ShowMOUSE
End If
Return

GetMENU:
HideMOUSE
Get (Mx1, 8)-(Mx2, 18), BasicsBOX(2701)
ShowMOUSE
Return

PutMENU:
HideMOUSE
If Menu = 1 Then Put (130, 8), BasicsBOX(2701), PSet
If Menu = 2 Then Put (220, 8), BasicsBOX(2701), PSet
If Menu = 3 Then Put (600, 8), BasicsBOX(2701), PSet
ShowMOUSE
Menu = 0
Return

NewGAME:
If SoundON Then Play "MBT220MSO5L64cP16dP16eP16fP16gP16fP16eP16dP16c"
For n = 2 To 15
    LilyPOND(n) = 1
    PutFROG n, 2
Next n
LilyPOND(1) = 0
PutFROG 1, 1
If LastPAD Then Rings LastPAD, 11
Count = 0
GameOVER = 0
ClearMOUSE
Return

SetPALETTE:
Data 0,0,21,60,55,55,0,38,14,0,0,0,63,0,0,0,24,0,0,34,10,32,40,55
Data 21,21,21,53,0,63,31,55,4,18,28,40,63,58,58,8,30,0,63,63,21,63,63,63
Restore SetPALETTE
Out &H3C8, 0
For n = 1 To 48
    Read Intensity: Out &H3C9, Intensity
Next n
Return

Sub ClearMOUSE
    Shared LB, RB

    While LB Or RB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub DrawSCREEN

    Def Seg = VarSeg(Box(1))
    BLoad "leappnd1.bsv", VarPtr(Box(1))
    Put (191, 63), Box(), PSet
    BLoad "leappnd2.bsv", VarPtr(Box(1))
    Put (95, 302), Box(), PSet
    Def Seg

    Def Seg = VarSeg(Box(1))
    BLoad "leapins1.bsv", VarPtr(Box(1))
    Put (24, 45), Box()
    BLoad "leapins2.bsv", VarPtr(Box(1))
    Put (445, 45), Box()
    Def Seg

    Line (5, 24)-(634, 474), 8, B
    Paint (0, 0), 8
    Line (10, 29)-(629, 469), 11, B
    Def Seg = VarSeg(Box(1))
    BLoad "leaphead.bsv", VarPtr(Box(1))
    Def Seg
    Put (12, 6), Box(), PSet

    Def Seg = VarSeg(BasicsBOX(1))
    BLoad "leapbscs.bsv", VarPtr(BasicsBOX(1))
    Def Seg

    For n = 2 To 15
        PutFROG n, 2
    Next n

    For n = 1 To 15
        Rings n, 11
    Next n

    Def Seg = VarSeg(ErrorBOX(1))
    BLoad "leaperrs.bsv", VarPtr(ErrorBOX(1))
    Def Seg

End Sub

Sub FieldMOUSE (x1, y1, x2, y2)

    MouseDRIVER 7, 0, x1, x2
    MouseDRIVER 8, 0, y1, y2

End Sub

Sub HideMOUSE

    LB = 2
    MouseDRIVER LB, 0, 0, 0

End Sub

Sub Hop (From, Destination, Direction)
    Shared x, y

    Select Case Direction
        Case 1: Direction$ = "UL"
        Case 2: Direction$ = "UR"
        Case 3: Direction$ = "DL"
        Case 4: Direction$ = "DR"
        Case 5: Direction$ = "L"
        Case 6: Direction$ = "R"
    End Select

    FileNAME$ = "Leap" + Direction$ + ".BSV"

    Def Seg = VarSeg(Box(1))
    BLoad FileNAME$, VarPtr(Box(1))
    Def Seg

    SETxy From

    If SoundON Then Play "MBT220MSL64O5cP16gP16>cP16gP16cP16<gP16c"
    For n = 9903 To 9921 Step 3
        PutFROG From, 1
        HideMOUSE
        Get (x + Box(n - 2), y + Box(n - 1))-(x + Box(n - 2) + Wdth, y + Box(n - 1) + Dpth), BackBOX()
        Put (x + Box(n - 2), y + Box(n - 1)), Box(Box(n) + ArrayHOP&), And
        Put (x + Box(n - 2), y + Box(n - 1)), Box(Box(n)), Or
        'IF n = 9915 THEN a$ = INPUT$(1)
        ShowMOUSE
        Interval 0
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        HideMOUSE
        Put (x + Box(n - 2), y + Box(n - 1)), BackBOX(), PSet
        ShowMOUSE
    Next n
    PutFROG Destination, 2
    Interval .5

End Sub

Function HopCHEK (Pad1, Pad2)

    HopVAL = Val(LTrim$(Str$(Pad1)) + LTrim$(Str$(Pad2)))

    Select Case HopVAL
        Case 14: HopCHEK = 2
        Case 16: HopCHEK = 3
        Case 27: HopCHEK = 4
        Case 29: HopCHEK = 5
        Case 38: HopCHEK = 5
        Case 310: HopCHEK = 6
        Case 41: HopCHEK = 2
        Case 46: HopCHEK = 5
        Case 413: HopCHEK = 8
        Case 411: HopCHEK = 7
        Case 512: HopCHEK = 8
        Case 514: HopCHEK = 9
        Case 61: HopCHEK = 3
        Case 64: HopCHEK = 5
        Case 613: HopCHEK = 9
        Case 615: HopCHEK = 10
        Case 72: HopCHEK = 4
        Case 79: HopCHEK = 8
        Case 83: HopCHEK = 5
        Case 810: HopCHEK = 9
        Case 92: HopCHEK = 5
        Case 97: HopCHEK = 8
        Case 103: HopCHEK = 6
        Case 108: HopCHEK = 9
        Case 114: HopCHEK = 7
        Case 1113: HopCHEK = 12
        Case 125: HopCHEK = 8
        Case 1214: HopCHEK = 13
        Case 1311: HopCHEK = 12
        Case 134: HopCHEK = 8
        Case 136: HopCHEK = 9
        Case 1315: HopCHEK = 14
        Case 145: HopCHEK = 9
        Case 1412: HopCHEK = 13
        Case 156: HopCHEK = 10
        Case 1513: HopCHEK = 14
        Case Else: HopCHEK = 0
    End Select

End Function

Function HopDIRECTION (Pad1, Pad2)
    Shared x, y

    SETxy Pad1
    Pad1x = x: Pad1y = y
    SETxy Pad2
    Pad2x = x: Pad2y = y

    If Pad1y - Pad2y = 160 Then Up = 1
    If Pad2y - Pad1y = 160 Then Down = 1
    If Pad1y = Pad2y Then Across = 1
    If Pad1x - Pad2x = 96 Then Left = 1
    If Pad2x - Pad1x = 96 Then Right = 1

    If Up And Left Then HopDIRECTION = 1
    If Up And Right Then HopDIRECTION = 2
    If Down And Left Then HopDIRECTION = 3
    If Down And Right Then HopDIRECTION = 4
    If Across Then
        If Pad1x - Pad2x = 192 Then HopDIRECTION = 5
        If Pad2x - Pad1x = 192 Then HopDIRECTION = 6
    End If

End Function

Function InitMOUSE

    LB = 0
    MouseDRIVER LB, 0, 0, 0
    InitMOUSE = LB

End Function

Sub Interval (Length!)

    OldTIMER# = Timer
    Do
        If Timer < OldTIMER# Then Exit Do
    Loop Until Timer > OldTIMER# + Length!

End Sub

Sub LocateMOUSE (x, y)

    LB = 4
    mX = x
    mY = y
    MouseDRIVER LB, 0, mX, mY

End Sub

Sub MouseDRIVER (LB, RB, mX, mY)

    Def Seg = VarSeg(MouseDATA$)
    Mouse = SAdd(MouseDATA$)
    Call Absolute(LB, RB, mX, mY, Mouse)

End Sub

Sub MouseSTATUS (LB, RB, MouseX, MouseY)

    LB = 3
    MouseDRIVER LB, RB, mX, mY
    LB = ((RB And 1) <> 0)
    RB = ((RB And 2) <> 0)
    MouseX = mX
    MouseY = mY

End Sub

Sub PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


    Shared Key$

    Do
        Key$ = UCase$(InKey$)
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB <> OldLB Or RB <> OldRB Or MouseX <> OldMX Or MouseY <> OldMY Or Key$ <> ""

End Sub

Sub PutFROG (Pad, Image)
    Shared x, y

    Index = (Image - 1) * 600 + 51
    SETxy Pad

    HideMOUSE
    Put (x - 24, y - 20), BasicsBOX(Index), PSet
    ShowMOUSE

End Sub

Sub RAMarrays
    Def Seg = VarSeg(Box(1))
    BLoad "leapdr.bsv", VarPtr(Box(1))
    BLoad "leapdl.bsv", VarPtr(Box(1))
    BLoad "leapur.bsv", VarPtr(Box(1))
    BLoad "leapul.bsv", VarPtr(Box(1))
    BLoad "leapr.bsv", VarPtr(Box(1))
    BLoad "leapl.bsv", VarPtr(Box(1))
    Def Seg
End Sub

Sub Rings (Pad, Colr)
    Shared x, y

    SETxy Pad

    HideMOUSE
    Circle (x, y), 44, Colr
    Circle (x, y), 39, Colr
    ShowMOUSE

End Sub

Sub SETxy (Pad)
    Shared x, y

    Select Case Pad
        Case 1: y = 95: x = 318
        Case 2: y = 175: x = 270
        Case 3: y = 175: x = 366
        Case 4: y = 255: x = 222
        Case 5: y = 255: x = 318
        Case 6: y = 255: x = 414
        Case 7: y = 335: x = 174
        Case 8: y = 335: x = 270
        Case 9: y = 335: x = 366
        Case 10: y = 335: x = 462
        Case 11: y = 415: x = 126
        Case 12: y = 415: x = 222
        Case 13: y = 415: x = 318
        Case 14: y = 415: x = 414
        Case 15: y = 415: x = 510
    End Select

End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
End Sub
