'CHDIR ".\samples\thebob\pongg"

'****************************************************************************
'---------------------------- P O N G G ! - 2.0 -----------------------------
'---------------------- Freeware by Bob Seguin - 2007 -----------------------
'****************************************************************************

DefInt A-Z

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB PrintSTRING (x, y, Prnt$, Mode)
DECLARE SUB Alphagetti (x, y, Char$, Mode)
DECLARE SUB Interval (Length!)
DECLARE SUB DrawSCREEN ()
DECLARE SUB SetPALETTE ()
DECLARE SUB PrintSCORE (x, n$)
DECLARE SUB TopFIVE ()
DECLARE SUB EndGAME ()

'$DYNAMIC

Dim Shared BallBOX(1 To 400)
Dim Shared BackBOX(1 To 200)
Dim Shared HeadBOX(1 To 1600)
Dim Shared PaddleBOX(1 To 250)
Dim Shared BigBOX(1 To 26000)
Dim Shared FontBOX(7100)
Dim Shared CharBOX(1 To 22)

Type PlayerTYPE
    PlayerNAME As String * 20
    PlayerSCORE As Long
    PlayDATE As String * 10
End Type
Dim Shared PlayerBOX(1 To 6) As PlayerTYPE
Open "pongg.top" For Append As #1
Close #1

Open "pongg.top" For Input As #1
Do While Not EOF(1)
    in = in + 1
    Input #1, PlayerBOX(in).PlayerNAME
    Input #1, PlayerBOX(in).PlayerSCORE
    Input #1, PlayerBOX(in).PlayDATE
Loop
Close #1

Dim Shared MouseDATA$
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
    Color 12
    Locate 10, 24: Print "Sorry, cat must have got the mouse."
    Locate 11, 24: Print String$(37, "-")
    Locate 12, 24: Print "Since this is a mouse-driven program,"
    Locate 13, 24: Print "it will have to be shut down."
    Sleep 3
    System
End If
LocateMOUSE 308, 440

Screen 12
SetPALETTE
DrawSCREEN

PaddleX = 281
BallX = 310: BallY = 62
Lives = 5
PrintSCORE 106, "5"
PrintSCORE 582, "000000"
Start = 1
Get (310, 62)-(330, 92), BackBOX()
Put (310, 62), BallBOX(201), And
Put (310, 62), BallBOX(), Or
Randomize Timer
Start = 1: BincX = 0: BincY = 0

Do
    Beginning:
    MouseSTATUS LB, RB, MouseX, MouseY
    Key$ = UCase$(InKey$)
    Select Case Key$
        Case "T"
            TopFIVE
        Case " "
            RePAUSE:
            Do: k$ = UCase$(InKey$): Loop Until k$ <> ""
            If k$ = Chr$(27) Then Cls: System
            If k$ = "T" Then
                TopFIVE
                Put (BallX, BallY), BallBOX(), PSet
                GoTo RePAUSE
            End If
        Case Chr$(27)
            Cls
            System
    End Select
    If Start = 1 Then
        If Lives = 5 Then Play "MBT120L64O4cP32dP32eP32fP32gP32fP32eP32dP32c"
        Line (PaddleX, 440)-(PaddleX + 79, 450), 0, BF
        LocateMOUSE 308, 440
        PaddleX = 281
        Put (PaddleX, 440), PaddleBOX(), PSet
        Do
            MouseSTATUS LB, RB, MouseX, MouseY
            k$ = UCase$(InKey$)
            Line (255 - Scan, 20)-(267 - Scan, 36), 5, BF
            Line (375 + Scan, 20)-(387 + Scan, 36), 5, BF
            Scan = Scan + 12: If Scan = 120 Then Scan = 0
            Line (255 - Scan, 20)-(267 - Scan, 36), 12, BF
            Line (375 + Scan, 20)-(387 + Scan, 36), 12, BF
            Wait &H3DA, 8: Wait &H3DA, 8, 8
        Loop Until LB Or (k$ = "X" Or k$ = "T" Or k$ = "R" Or k$ = Chr$(27))
        Line (255 - Scan, 20)-(267 - Scan, 36), 5, BF
        Line (375 + Scan, 20)-(387 + Scan, 36), 5, BF
        Select Case k$
            Case "R"
                PaddleX = 281
                BallX = 310: BallY = 62
                Line (BallX, BallY)-(BallX + 20, BallY + 22), 0, BF
                Get (BallX, BallY)-(BallX + 20, BallY + 20), BackBOX()
                Put (BallX, BallY), BallBOX(201), And
                Put (BallX, BallY), BallBOX(), Or
                Lives = 5
                PlayerBOX(6).PlayerSCORE = 0
                Start = 1
                PrintSCORE 106, "5"
                PrintSCORE 582, "000000"
                GoTo Beginning
            Case "X"
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggin1.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (198, 178), BigBOX(), PSet
                Do
                    k$ = InKey$
                Loop Until k$ <> ""
                If k$ = Chr$(27) Then Cls: System
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggin2.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (198, 178), BigBOX(), PSet
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggacc.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (110, 118), BigBOX(4001), PSet
                Put (409, 118), BigBOX(6001), PSet
                Do
                    k$ = InKey$
                Loop Until k$ <> ""
                If k$ = Chr$(27) Then Cls: System
                Put (110, 118), BigBOX(1), PSet
                Put (409, 118), BigBOX(2001), PSet
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggin3.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (198, 178), BigBOX(), PSet
                Do
                    k$ = InKey$
                Loop Until k$ <> ""
                If k$ = Chr$(27) Then Cls: System
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggbak.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (198, 178), BigBOX(), PSet
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggops.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (246, 230), BigBOX(), PSet
                GoTo Beginning
            Case Chr$(27)
                Cls
                System
            Case "T"
                TopFIVE
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggops.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (246, 230), BigBOX(), PSet
                GoTo Beginning
        End Select
        MouseX = 308
        Def Seg = VarSeg(BigBOX(1))
        BLoad "ponggbak.bsv", VarPtr(BigBOX(1))
        Def Seg
        Put (198, 178), BigBOX(), PSet
        BincX = Fix(Rnd * 7) - 3: BincY = Int(Rnd * 3) + 4
        LocateMOUSE 308, 440
        Start = 0
    End If
    Select Case BincX
        Case Is < 0
            If BallX <= 12 Then BincX = Abs(BincX): GoSub NEON
        Case Is > 0
            If BallX >= 607 Then BincX = -BincX: GoSub NEON
    End Select
    Select Case BincY
        Case Is < 0
            If BallY <= 60 Then
                GoSub NEON
                BincY = Fix(Rnd * 4) + 6
                BincX = Fix(Rnd * 11) - 5
            End If
        Case Is > 0
            If BallY >= 419 Then
                If BallX + 10 >= PaddleX And BallX + 10 <= PaddleX + 79 Then
                    If Abs(BincX) = Abs(OldBINCx) Then BincX = BincX + Fix(Rnd * 5) - 2
                    BincY = -BincY: Play "MBMST220L64O1B"
                    OldBINCx = BincX

                    PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 10
                    If Score = 1 Then PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 15
                    If Score = 2 Then PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 40

                    PS$ = LTrim$(Str$(PlayerBOX(6).PlayerSCORE))
                    Select Case Len(PS$)
                        Case 1: PS$ = "00000" + PS$
                        Case 2: PS$ = "0000" + PS$
                        Case 3: PS$ = "000" + PS$
                        Case 4: PS$ = "00" + PS$
                        Case 5: PS$ = "0" + PS$
                    End Select
                    PrintSCORE 582, PS$
                    Score = 0
                End If
            End If
            If BallY >= 430 Then
                Sound 50, 5
                Line (BallX - 1, BallY - 1)-(BallX + 21, BallY + 21), 0, B
                Paint (BallX + 10, BallY + 10), 15, 0
                Interval 0
                Paint (BallX + 10, BallY + 10), 4, 0
                Interval 0
                Paint (BallX + 10, BallY + 10), 14, 0
                Interval 0
                Line (BallX, BallY)-(BallX + 20, BallY + 20), 0, BF
                Get (310, 60)-(330, 80), BackBOX()
                Line (14, 440)-(625, 450), 0, BF
                PaddleX = 281: Paddle = 0
                LocateMOUSE 308, 440
                Put (PaddleX, 440), PaddleBOX(), PSet
                BallX = 310: BallY = 60: Start = 1
                BincX = 0: BincY = 0

                Lives = Lives - 1
                Lives$ = LTrim$(Str$(Lives))
                PrintSCORE 106, Lives$
                If Lives = 0 Then EndGAME

                Score = 0
                Def Seg = VarSeg(BigBOX(1))
                BLoad "ponggops.bsv", VarPtr(BigBOX(1))
                Def Seg
                Put (246, 230), BigBOX(), PSet
            End If
    End Select

    Wait &H3DA, 8
    Wait &H3DA, 8, 8

    Out &H3C8, 2
    Out &H3C9, 50
    Out &H3C9, 10
    Out &H3C9, 50
    Out &H3C8, 3
    Out &H3C9, 50
    Out &H3C9, 10
    Out &H3C9, 50

    Put (BallX, BallY), BackBOX(), PSet

    If BincY = 0 Then BincY = 2
    If BincX > 10 Or BincX < -10 Then BincY = BincY + 1

    If BincX > 8 Then BincX = BincX - 1
    If BincY > 8 Then BincY = BincY - 1
    If BincX < -8 Then BincX = BincX + 1
    If BincY < -8 Then BincY = BincY + 1

    BallX = BallX + BincX: BallY = BallY + BincY 'Update X/Y's
    If BallX < 13 Then BallX = 14: GoSub NEON: BincX = Abs(BincX) + 1
    If BallX > 608 Then BallX = 607: GoSub NEON: BincX = -Abs(BincX) - 1
    If BallY < 60 Then BallY = 60
    If BallY > 439 And BincY < 0 Then BallY = 438

    If BallY < 400 Then
        Get (BallX, BallY)-(BallX + 20, BallY + 20), BackBOX()
    Else
        Get (310, 60)-(330, 80), BackBOX()
    End If
    Put (BallX, BallY), BallBOX(201), And
    Put (BallX, BallY), BallBOX(), Or

    If BallY < 167 Then
        If BallX < 130 Then 'LEFT Accelerator
            BallCX = BallX + 10: BallCY = BallY + 10
            If BallCX > 67 Then 'right half
                DiffX = BallCX - 67
                Q1 = 1
            Else
                DiffX = 67 - BallCX 'left half
                Q1 = 2
            End If
            If BallCY > 126 Then 'lower half
                DiffY = BallCY - 126
                Q2 = 4
            Else 'upper half
                DiffY = 126 - BallCY
                Q2 = 8
            End If
            If Sqr(DiffX ^ 2 + DiffY ^ 2) <= 37 Then
                Quadrant = Q1 + Q2
                Select Case Quadrant
                    Case 5 'lower right
                        BincX = Abs(BincX) + 4
                        BincY = -Abs(BincY) + 1
                    Case 6 'lower left
                        BincX = -Abs(BincX) - 1
                        BincY = Abs(BincY) + Int(Rnd * 2)
                    Case 9 'upper right
                        BincX = Abs(BincX) + 3
                        BincY = Abs(BincY)
                    Case 10 'upper left
                        BincX = Abs(BincX) + 3
                        BincY = Abs(BincY)
                End Select
                Score = 1
                GoSub Accelerator1
            End If
        End If
        If BallX > 495 Then 'RIGHT Accelerator
            BallCX = BallX + 10: BallCY = BallY + 10
            If BallCX > 565 Then 'right half
                DiffX = BallCX - 565
                Q1 = 1
            Else
                DiffX = 565 - BallCX 'left half
                Q1 = 2
            End If
            If BallCY > 126 Then 'bottom half
                DiffY = BallCY - 126
                Q2 = 4
            Else 'top half
                DiffY = 126 - BallCY
                Q2 = 8
            End If
            If Sqr(DiffX ^ 2 + DiffY ^ 2) <= 37 Then
                Quadrant = Q1 + Q2
                OldDIFF = Diff
                Select Case Quadrant
                    Case 5 'lower right
                        BincX = -Abs(BincX) - 4
                        BincY = -Abs(BincY) + 1
                    Case 6 'lower left
                        BincX = -Abs(BincX) - 5
                        BincY = Abs(BincY) + Int(Rnd * 1)
                    Case 9 'upper right
                        BincX = Abs(BincX) + 4
                        BincY = Abs(BincY)
                    Case 10 'upper left
                        BincX = Abs(BincX) + 2
                        BincY = Abs(BincY)
                End Select
                GoSub Accelerator2
                Score = 2
            End If
        End If
    End If

    Line (PaddleX, 440)-(PaddleX + 79, 450), 0, BF

    PaddleX = MouseX - 27
    PaddleX = PaddleX + Paddle
    If PaddleX < 14 Then PaddleX = 14
    If PaddleX > 546 Then PaddleX = 546
    Put (PaddleX, 440), PaddleBOX(), PSet

Loop

End

'------------------------------- SUBROUTINES ---------------------------------

NEON:
Play "MBMST220L64O1B"
Out &H3C8, 13
Out &H3C9, 0
Out &H3C9, 63
Out &H3C9, 0
Wait &H3DA, 8
Wait &H3DA, 8, 8
Out &H3C8, 13
Out &H3C9, 42
Out &H3C9, 42
Out &H3C9, 42
Return

Accelerator1:
Out &H3C8, 3
Out &H3C9, 63
Out &H3C9, 50
Out &H3C9, 63
Wait &H3DA, 8
GoSub AcceleratorSOUND
Return

Accelerator2:
Out &H3C8, 2
Out &H3C9, 63
Out &H3C9, 50
Out &H3C9, 63
Wait &H3DA, 8
GoSub AcceleratorSOUND
Return

AcceleratorSOUND:
Hz = 620
For Reps = 1 To 3
    Hz = Hz + 100
    Sound Hz, Hz / 3000
Next Reps
Return

PaletteDATA:
Data 12,2,22,50,37,63,40,10,50,40,10,50
Data 53,0,0,19,2,22,17,2,22,42,42,42
Data 55,55,55,16,9,26,15,2,22,63,55,55
Data 25,12,35,42,42,42,55,63,9,63,63,63

Rem $STATIC
Sub ClearMOUSE
    Shared LB

    While LB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub DrawSCREEN

    Def Seg = VarSeg(BigBOX(1))
    For y = 0 To 320 Step 160
        FileNUM = FileNUM + 1
        FileNAME$ = "pongg" + LTrim$(Str$(FileNUM)) + ".bsv"
        BLoad FileNAME$, VarPtr(BigBOX(1))
        Put (0, y), BigBOX()
    Next y
    Def Seg

    Def Seg = VarSeg(HeadBOX(1))
    BLoad "ponggnms.bsv", VarPtr(HeadBOX(1))
    Def Seg = VarSeg(PaddleBOX(1))
    BLoad "ponggpdl.bsv", VarPtr(PaddleBOX(1))
    Def Seg = VarSeg(BigBOX(1))
    Put (281, 440), PaddleBOX(), PSet
    Def Seg = VarSeg(BallBOX(1))
    BLoad "ponggbal.bsv", VarPtr(BallBOX(1))

    Def Seg = VarSeg(BigBOX(1))
    BLoad "ponggops.bsv", VarPtr(BigBOX(1))
    Def Seg

    Put (246, 230), BigBOX(), PSet
    Def Seg = VarSeg(FontBOX(0))
    BLoad "pongg2.fbs", VarPtr(FontBOX(0))
    Def Seg

End Sub

Sub EndGAME
    Shared Lives, LB
    Static MenuY

    SelectSCREEN:
    If PlayerBOX(6).PlayerSCORE > PlayerBOX(5).PlayerSCORE Then
        GetSCORE = 1
        Def Seg = VarSeg(BigBOX(1))
        BLoad "pongggo1.bsv", VarPtr(BigBOX(1)) 'GO1 = Game Over 1 (3 options)
        Def Seg
        Put (233, 220), BigBOX(), PSet
    Else
        Def Seg = VarSeg(BigBOX(1))
        BLoad "pongggo2.bsv", VarPtr(BigBOX(1)) 'GO2 = Game Over 2 (2 options)
        Def Seg
        Put (233, 220), BigBOX(), PSet
    End If
    MenuY = 256
    Get (262, 256)-(374, 273), BigBOX(7001)
    LocateMOUSE 320, 310
    ShowMOUSE
    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        Select Case MouseX
            Case 266 TO 378
                Select Case MouseY
                    Case 256 TO 273
                        If Menu <> 1 Then
                            HideMOUSE
                            Put (262, MenuY), BigBOX(7001), PSet
                            Get (262, 256)-(374, 273), BigBOX(7001)
                            MenuY = 256
                            Play "MBMST220L64O6B"
                            Put (262, 256), BigBOX(4001), PSet
                            ShowMOUSE
                            Menu = 1
                        End If
                        If LB Then
                            If GetSCORE Then
                                GoSub Topper
                                GoTo SelectSCREEN
                            Else
                                Exit Do
                            End If
                        End If
                    Case 274 TO 291
                        If Menu <> 2 Then
                            HideMOUSE
                            Put (262, MenuY), BigBOX(7001), PSet
                            Get (262, 274)-(374, 291), BigBOX(7001)
                            MenuY = 274
                            Play "MBMST220L64O6B"
                            Put (262, 274), BigBOX(5001), PSet
                            ShowMOUSE
                            Menu = 2
                        End If
                        If LB Then
                            If GetSCORE Then
                                Exit Do
                            Else
                                HideMOUSE
                                Cls
                                System
                            End If
                        End If
                    Case 292 TO 309
                        If Menu <> 3 And GetSCORE Then
                            HideMOUSE
                            Put (262, MenuY), BigBOX(7001), PSet
                            Get (262, 292)-(374, 309), BigBOX(7001)
                            MenuY = 292
                            Play "MBMST220L64O6B"
                            Put (262, 292), BigBOX(6001), PSet
                            ShowMOUSE
                            Menu = 3
                        End If
                        If LB And GetSCORE Then
                            HideMOUSE
                            Cls
                            System
                        End If
                End Select
        End Select
        PauseMOUSE LB, RB, MouseX, MouseY
    Loop
    Lives = 5
    PlayerBOX(6).PlayerSCORE = 0
    PrintSCORE 106, "5"
    PrintSCORE 582, "000000"
    HideMOUSE
    Def Seg = VarSeg(BigBOX(1))
    BLoad "ponggbak.bsv", VarPtr(BigBOX(1))
    Def Seg
    Put (198, 178), BigBOX(), PSet
    Do
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB
    ClearMOUSE

    Exit Sub

    '--------------------------------SUBROUTINES----------------------------------

    Topper:

    Def Seg = VarSeg(BigBOX(1))
    BLoad "ponggbak.bsv", VarPtr(BigBOX(1))
    Def Seg
    HideMOUSE
    Put (198, 178), BigBOX(), PSet

    Line (208, 198)-(428, 267), 8, BF
    Line (210, 200)-(426, 265), 15, B
    Line (218, 225)-(418, 257), 7, BF

    PrintSTRING 264, 206, "Please enter your name:", 0
    Line (250, 253)-(254, 254), 15, B
    x = 250

    Do
        Do
            k$ = InKey$
        Loop Until k$ <> ""
        Select Case k$
            Case Chr$(8) 'Backspace
                If CharCOUNT Then
                    Line (x, 253)-(x + 4, 254), 7, B
                    Line (CharBOX(CharCOUNT), 235)-(x, 255), 7, BF
                    Name$ = Left$(Name$, Len(Name$) - 1)
                    x = CharBOX(CharCOUNT)
                    Line (x, 253)-(x + 4, 254), 15, B
                    CharCOUNT = CharCOUNT - 1
                End If
            Case Chr$(13) 'Enter
                Line (x, 253)-(x + 4, 254), 7, B
                PlayerBOX(6).PlayerNAME = Name$
                PlayerBOX(6).PlayDATE = Date$
                Exit Do
            Case Chr$(27) 'Escape key
                Cls
                System
            Case Else
                If Len(Name$) < 20 Then
                    If k$ = Chr$(34) Then k$ = "'"
                    Name$ = Name$ + k$
                    Line (x, 253)-(x + 4, 254), 7, B
                    CharCOUNT = CharCOUNT + 1
                    CharBOX(CharCOUNT) = x
                    PrintSTRING x, 235, k$, 0
                    Line (x, 253)-(x + 4, 254), 15, B
                End If
        End Select
    Loop
    For a = 1 To 6
        For B = a To 6
            If PlayerBOX(B).PlayerSCORE > PlayerBOX(a).PlayerSCORE Then Swap PlayerBOX(B), PlayerBOX(a)
        Next B
    Next a
    Open "pongg.top" For Output As #1
    For n = 1 To 5
        Write #1, PlayerBOX(n).PlayerNAME, PlayerBOX(n).PlayerSCORE, PlayerBOX(n).PlayDATE
    Next n
    Close #1
    TopFIVE
    Menu = 0: GetSCORE = 0
    Return

End Sub

Sub FieldMOUSE (x1, y1, x2, y2)

    MouseDRIVER 7, 0, x1, x2
    MouseDRIVER 8, 0, y1, y2

End Sub

Sub HideMOUSE

    LB = 2
    MouseDRIVER LB, 0, 0, 0

End Sub

Function InitMOUSE

    LB = 0
    MouseDRIVER LB, 0, 0, 0
    InitMOUSE = LB

End Function

DefSng A-Z
Sub Interval (Length!)

    OldTimer# = Timer
    Do: Loop Until Timer > OldTimer# + Length!
    Wait &H3DA, 8

End Sub

DefInt A-Z
Sub LocateMOUSE (x, y)

    LB = 4
    MX = x
    MY = y
    MouseDRIVER LB, 0, MX, MY

End Sub

Sub MouseDRIVER (LB, RB, MX, MY)

    Def Seg = VarSeg(MouseDATA$)
    Mouse = SAdd(MouseDATA$)
    Call Absolute(LB, RB, MX, MY, Mouse)

End Sub

Sub MouseSTATUS (LB, RB, MouseX, MouseY)

    LB = 3
    MouseDRIVER LB, RB, MX, MY
    LB = ((RB And 1) <> 0)
    RB = ((RB And 2) <> 0)
    MouseX = MX
    MouseY = MY

End Sub

Sub PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


    Shared Key$

    Do
        Key$ = UCase$(InKey$)
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB <> OldLB Or RB <> OldRB Or MouseX <> OldMX Or MouseY <> OldMY Or Key$ <> ""

End Sub

Sub PrintSCORE (x, n$)

    For n = 1 To Len(n$)
        Digit$ = Mid$(n$, n, 1)
        NumSTART = Val(Digit$) * 100 + 1
        Put (x, 21), HeadBOX(NumSTART), PSet
        x = x + 7
    Next n

End Sub

Sub PrintSTRING (x, y, Prnt$, Mode)

    For i = 1 To Len(Prnt$)
        Char$ = Mid$(Prnt$, i, 1)
        If Char$ = " " Then
            x = x + FontBOX(1)
        Else
            Index = (Asc(Char$) - 33) * FontBOX(0) + 2
            Put (x, y), FontBOX(Index)
            x = x + FontBOX(Index)
        End If
        If Mode And x > 300 Then Exit Sub
    Next i

End Sub

Sub SetPALETTE

    Restore PaletteDATA
    Out &H3C8, 0
    For n = 1 To 48
        Read Intensity
        Out &H3C9, Intensity
    Next n

End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
End Sub

Sub TopFIVE

    Def Seg = VarSeg(BigBOX(1))
    BLoad "ponggtfv.bsv", VarPtr(BigBOX(1))
    Def Seg
    Put (198, 178), BigBOX(), PSet
    TopY = 210
    For n = 1 To 5
        If PlayerBOX(n).PlayerSCORE <> 0 Then
            PrintSTRING 215, TopY, RTrim$(PlayerBOX(n).PlayerNAME), 1
            PrintSTRING 320, TopY, LTrim$(Str$(PlayerBOX(n).PlayerSCORE)), 0
            PrintSTRING 370, TopY, PlayerBOX(n).PlayDATE, 0
        End If
        TopY = TopY + 21
    Next n
    Do
        k$ = InKey$
    Loop Until k$ <> ""
    If k$ = Chr$(27) Then Cls: System
    Def Seg = VarSeg(BigBOX(1))
    BLoad "ponggbak.bsv", VarPtr(BigBOX(1))
    Def Seg
    Put (198, 178), BigBOX(), PSet

End Sub
