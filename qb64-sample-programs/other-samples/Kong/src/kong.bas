'CHDIR ".\samples\thebob\kong"

'****************************************************************************'
'____________________________________________________________________________
'____________________________________________________________________________'
'_____��___��__�����__��___��__�����____________��___��___����___��__��______'
'_____��___��_��___��_��___��_��___��___________��___��____��____��__��______'
'_____��__��__��___��_���__��_��___��___________���_���____��____��__��______'
'_____��_��___��___��_���__��_��_______�_�_�_�__���_���____��____��__��______'
'_____����____��___��_����_��_��_______�_�_�____�������____��____��__��______'
'_____����____��___��_��_����_��_______�_�___�__��_�_��____��_____����_______'
'_____��_��___��___��_��__���_��__���___�__�_�__��_�_��____��______��________'
'_____��__��__��___��_��__���_��___��___________��_�_��_��_��______��________'
'_____��___��_��___��_��___��_��___��___________��___��_��_��______��________'
'_____��___��__�����__��___��__�����____________��___��__���______����_______'
'                                                                            '
'----------- Microsoft QBasic originally came bundled with four -------------'
'----------- example programs: a simple money management program ------------'
'----------- called, appropriately, "Money", a utility for removing ---------'
'----------- line numbers from BASIC programs called "RemLine", and ---------'
'----------- two game programs, "Nibbles" and "Gorilla". In the case --------'
'----------- of the second game, I loved the idea of two gorillas -----------'
'----------- throwing exploding bananas at each other from the roof- --------'
'----------- tops and had always wanted to do my own version. Here ----------'
'----------- then, is my homage to the QBasic classic, GORILLA.BAS... -------'
'
'-------------------- ...KING-KONG vs MIGHTY JOE YOUNG ----------------------'
'------- (Freeware)--Unique elements Copyright (C) 2005 by Bob Seguin -------'
'------------------------ email: BOBSEG@sympatico.ca ------------------------'
'
'************** NOTE: Mouse routines will not work with QB7.1 ***************'

DefInt A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB MouseDRIVER (LB, RB, MX, MY)

DECLARE FUNCTION ControlPANEL ()
DECLARE FUNCTION Computer ()
DECLARE FUNCTION BananaTOSS ()

DECLARE SUB SetPALETTE ()
DECLARE SUB DrawSCREEN ()
DECLARE SUB StartUP ()
DECLARE SUB DoAPES ()
DECLARE SUB PlayGAME ()
DECLARE SUB TopMENU (InOUT)
DECLARE SUB Instructions ()
DECLARE SUB Sliders (Value, Slider)
DECLARE SUB EndGAME ()
DECLARE SUB Interval (Duration!)
DECLARE SUB Fade (InOUT)
DECLARE SUB SetWIND ()
DECLARE SUB Explode (What)
DECLARE SUB ApeCHUCKLE (Which)
DECLARE SUB PrintSCORE (Ape, Score)

Const Degree! = 3.14159 / 180
Const g# = 9.8

ReDim Shared Box(1 To 26000)
ReDim Shared KongBOX(1 To 5500)
ReDim Shared YoungBOX(1 To 5500)
Dim Shared ExplosionBACK(1200)
Dim Shared SliderBOX(1 To 440)
Dim Shared Banana(1 To 900)
Dim Shared FadeBOX(1 To 48)
Dim Shared LilBOX(1 To 120)
Dim Shared Buildings(1 To 8, 1 To 2)
Dim Shared NumBOX(1 To 300)

Def Seg = VarSeg(NumBOX(1))
BLoad "kongnums.bsv", VarPtr(NumBOX(1))
Def Seg = VarSeg(LilBOX(1))
BLoad "kongwind.bsv", VarPtr(LilBOX(1))
Def Seg = VarSeg(Banana(1))
BLoad "kongbnna.bsv", VarPtr(Banana(1))
Def Seg = VarSeg(SliderBOX(1))
BLoad "kongsldr.bsv", VarPtr(SliderBOX(1))
Def Seg

For n = 1 To 8
    Buildings(n, 1) = n
Next n

Dim Shared LB, RB, MouseX, MouseY
Dim Shared x#, y#, Angle#, Speed#, Wind!, t#
Dim Shared KongX, KongY, YoungX, YoungY, Ape
Dim Shared KScore, YScore, Item, LBldg, RBldg
Dim Shared NumPLAYERS, CompTOSS

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
    Print "Sorry, cat must have got the mouse."
    Sleep 2
    System
End If

Restore PaletteDATA
For n = 1 To 48
    Read FadeBOX(n)
Next n

Screen 12
Out &H3C8, 0
For n = 1 To 48
    Out &H3C9, 0
Next n

Randomize Timer

Do
    PlayGAME
Loop
 
End

PaletteDATA:
Data 0,4,16,0,10,21,0,16,32,32,10,0
Data 63,0,0,63,32,0,18,18,24,30,30,37
Data 42,42,50,55,55,63,0,0,0,43,27,20
Data 8,8,21,0,63,21,63,55,25,63,63,63

Sub ApeCHUCKLE (Which)

    Select Case Which
        Case 1 'Kong chuckle
            For Reps = 1 To 10
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Put (KongX, KongY), KongBOX(1351), PSet
                Interval .1
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Put (KongX, KongY), KongBOX(1801), PSet
                Interval .1
            Next Reps

        Case 2 'Young chuckle
            For Reps = 1 To 10
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Put (YoungX, YoungY), YoungBOX(1351), PSet
                Interval .1
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Put (YoungX, YoungY), YoungBOX(1801), PSet
                Interval .1
            Next Reps
    End Select

End Sub

Function BananaTOSS

    t# = 0
    If Ape = 1 Then
        YTurn = 0: KTurn = 7
        x# = KongX: y# = KongY - 24
    Else
        KTurn = 7: KTurn = 0
        x# = YoungX: y# = YoungY - 24
    End If

    If Ape = 2 Then Angle# = 180 - Angle#
    Angle# = Angle# * Degree!
    vx# = Speed# * Cos(Angle#)
    vy# = Speed# * Sin(Angle#)
    InitialX = x#
    InitialY = y#

    'GET starting background location of banana ---------------------------
    Get (x#, y#)-(x# + 12, y# + 12), Banana(801)

    'Animate banana toss (frames 2 & 3) -----------------------------------
    For Index = 451 To 901 Step 450
        Interval .02
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        If Ape = 1 Then
            Put (KongX, KongY), KongBOX(Index), PSet
        Else
            Put (YoungX, YoungY), YoungBOX(Index), PSet
        End If
    Next Index

    Index = 1 'Initialize banana index

    Do 'banana toss loop

        Interval .001
        Wait &H3DA, 8
        Wait &H3DA, 8, 8

        'PUT banana background at old x/y ---------------------------
        If x# >= 0 And x# <= 627 Then
            If y# >= 40 Then
                Put (x#, y#), Banana(801), PSet
            End If
        End If

        'Determine new position of banana --------------------------
        'NOTE: The essential formula for determining the path of
        'the thrown banana is taken from the original GORILLA.BAS
        x# = InitialX + (vx# * t#) + (.5 * (Wind! / 5) * t# ^ 2)
        y# = InitialY + -(vy# * t#) + (.5 * g# * t# ^ 2)
        t# = t# + .1

        'Whether or not to PUT the banana and background
        If x# >= 2 And x# < 627 Then
            If y# >= 40 And y# <= 467 Then

                'JOE YOUNG hit
                If x# + 12 >= YoungX + 2 And x# <= YoungX + 38 Then
                    If y# + 12 >= YoungY + 7 And y# <= YoungY + 42 Then
                        Explode 2
                        KScore = KScore + 1
                        PrintSCORE 1, KScore
                        ApeCHUCKLE 1
                        BananaTOSS = 1
                        Exit Function
                    End If
                End If

                'KONG is hit
                If x# + 12 >= KongX + 2 And x# <= KongX + 38 Then
                    If y# + 12 >= KongY + 7 And y# <= KongY + 42 Then
                        Explode 1
                        YScore = YScore + 1
                        PrintSCORE 2, YScore
                        ApeCHUCKLE 2
                        BananaTOSS = 2
                        Exit Function
                    End If
                End If

                'Building hit
                If y# > 120 Then
                    If (Point(x# + 2, y#) <> 12 And Point(x# + 2, y#) <> 0) Then BLDG = 1
                    If (Point(x# + 10, y#) <> 12 And Point(x# + 10, y#) <> 0) Then BLDG = 1
                    If (Point(x#, y# + 10) <> 12 And Point(x#, y# + 10) <> 0) Then BLDG = 1
                End If
                If BLDG = 1 Then
                    BLDG = 0
                    Explode 3
                    BananaTOSS = 3
                    Exit Function
                End If

                'GET background, PUT banana at new location
                Get (x#, y#)-(x# + 12, y# + 12), Banana(801)
                Put (x#, y#), Banana(Index + 50), And
                Put (x#, y#), Banana(Index)

            End If 'Legal banana-PUT END IF's
        End If

        Index = Index + 100 'Index changes whether banana is PUT or not ---------
        If Index = 801 Then Index = 1

        'Ape reaction turns section -----------------------------------------------

        If t# > .5 And t# < .6 Then 'Finish toss (arm goes down)
            If Ape = 1 Then
                Put (KongX, KongY), KongBOX(4501), PSet
            Else
                Put (YoungX, YoungY), YoungBOX(2701), PSet
            End If
        End If

        If t# > 1.5 Then 'Turn with passing banana (both apes)
            If YTurn < 2 Then
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Select Case YTurn
                    Case 0: Put (YoungX, YoungY), YoungBOX(3151), PSet: YTurn = 1
                    Case 1: Put (YoungX, YoungY), YoungBOX(2701), PSet: YTurn = 2
                End Select
            End If

            If KTurn < 2 Then
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Select Case KTurn
                    Case 0: Put (KongX, KongY), KongBOX(4051), PSet: KTurn = 1
                    Case 1: Put (KongX, KongY), KongBOX(4501), PSet: KTurn = 2
                End Select
            End If

            If x# > YoungX And YTurn < 7 Then
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Select Case YTurn
                    Case 2: Put (YoungX, YoungY), YoungBOX(2701), PSet: YTurn = 3
                    Case 3: Put (YoungX, YoungY), YoungBOX(3151), PSet: YTurn = 4
                    Case 4: Put (YoungX, YoungY), YoungBOX(3601), PSet: YTurn = 5
                    Case 5: Put (YoungX, YoungY), YoungBOX(4051), PSet: YTurn = 6
                    Case 6: Put (YoungX, YoungY), YoungBOX(4501), PSet: YTurn = 7
                End Select
            End If

            If x# < KongX + 40 And KTurn < 7 Then
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Select Case KTurn
                    Case 2: Put (KongX, KongY), KongBOX(4501), PSet: KTurn = 3
                    Case 3: Put (KongX, KongY), KongBOX(4051), PSet: KTurn = 4
                    Case 4: Put (KongX, KongY), KongBOX(3601), PSet: KTurn = 5
                    Case 5: Put (KongX, KongY), KongBOX(3151), PSet: KTurn = 6
                    Case 6: Put (KongX, KongY), KongBOX(2701), PSet: KTurn = 7
                End Select
            End If
        End If

    Loop Until x# < 3 Or x# > 627

    If x# >= 0 And x# <= 627 Then 'erase banana to end toss sequence -------
        If y# >= 40 Then
            Put (x#, y#), Banana(801), PSet
        End If
    End If

    BananaTOSS = 3

End Function

Sub ClearMOUSE

    While LB Or RB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Function Computer
    Static CompSPEED, CompANGLE, XDiff, YDiff, FinalX

    'The computer's gameplay is designed to imitate the play of a
    'real person. The first shot is established as an educated guess
    'with a touch of randomness. On subsequent shots, the formula
    'modifies Speed# and Angle# based on the outcome of this first shot.
    'Sometimes, just like a real person, the first shot will score a
    'hit. Other times, it is a long and embarassing process.

    'Computer-shot computation formulas
    If CompTOSS = 0 Then
        XDiff = YoungX - KongX
        YDiff = KongY - YoungY
        CompSPEED = XDiff / (Fix(Rnd * 2) + 6) + Wind!
        CompANGLE = 35 - (YDiff / 5)
        CompTOSS = 1
    Else
        If KongX > FinalX Then
            CompSPEED = CompSPEED * .9
        Else
            CompSPEED = CompSPEED * 1.2
            If YoungX - FinalX < 100 Then 'Oops! Tall building
                CompANGLE = CompANGLE + 10
            Else
                CompANGLE = CompANGLE + 3
            End If
        End If
    End If
    If CompSPEED > 99 Then CompSPEED = 99
    If CompSPEED < 0 Then CompSPEED = 0
    If CompANGLE > 70 Then CompANGLE = 70
    If CompANGLE < 0 Then CompANGLE = 0

    Speed# = CompSPEED
    Angle# = CompANGLE
    Sliders Int(Speed#), 1
    Sliders Int(Angle#), 2
    Interval 1

    Select Case BananaTOSS 'Call to BananaTOSS FUNCTION -----------
        Case 1 'Kong exploded Young
            If KScore = 3 Then 'Kong wins
                Computer = 2 'Game over
                Exit Function
            End If
            Computer = 1 'Reset screen
            Exit Function
        Case 2 'Young exploded Kong
            If YScore = 3 Then 'Young wins
                Computer = 2 'Game over
                Exit Function
            End If
            Computer = 1 'Reset screen
            Exit Function
        Case 3 'Building explosion or banana out-of-play
            FinalX = x#
            Computer = -1 'Change player
            Exit Function
    End Select

    Computer = 0 'No action required

End Function

Function ControlPANEL
    Shared Player1SPEED#, Player2SPEED#
    Shared Player1ANGLE#, Player2ANGLE#

    Select Case MouseX
        Case 147 TO 246
            If MouseY > 441 And MouseY < 463 Then
                If LB = -1 Then
                    Speed# = MouseX - 147
                    If Speed# < 0 Then Speed# = 0
                    If Speed# > 99 Then Speed# = 99
                    Select Case Ape
                        Case 1
                            Player1SPEED# = Speed#
                        Case 2
                            Player2SPEED# = Speed#
                    End Select
                    Sp = Int(Speed#)
                    Sliders Sp, 1
                End If
            End If
        Case 385 TO 499
            If MouseY > 423 And MouseY < 463 Then
                If LB = -1 Then
                    Angle# = 494 - MouseX
                    If Angle# < 0 Then Angle# = 0
                    If Angle# > 90 Then Angle# = 90
                    Select Case Ape
                        Case 1
                            Player1ANGLE# = Angle#
                        Case 2
                            Player2ANGLE# = Angle#
                    End Select
                    An = Int(Angle#)
                    Sliders An, 2
                End If
            End If
        Case 305 TO 335
            If MouseY > 423 And MouseY < 452 Then
                If LB = -1 Then
                    HideMOUSE
                    Get (308, 427)-(331, 447), Box(25500)
                    Get (311, 430)-(328, 444), Box(25000)
                    Put (310, 429), Box(25000), PSet
                    Line (309, 428)-(330, 446), 1, B
                    Line (308, 428)-(331, 448), 10, B
                    Line (331, 429)-(331, 447), 8
                    Line (308, 448)-(330, 448), 8
                    ShowMOUSE
                    Interval .2
                    HideMOUSE
                    Put (308, 427), Box(25500), PSet
                    ShowMOUSE
                    Select Case BananaTOSS 'Call to BananaTOSS FUNCTION -----------
                        Case 1 'Kong exploded Young
                            If KScore = 3 Then 'Kong wins
                                ControlPANEL = 2 'Game over
                                Exit Function
                            End If
                            ControlPANEL = 1 'Reset screen
                            Exit Function
                        Case 2 'Young exploded Kong
                            If YScore = 3 Then 'Young wins
                                ControlPANEL = 2 'Game over
                                Exit Function
                            End If
                            ControlPANEL = 1 'Reset screen
                            Exit Function
                        Case 3 'Building explosion or banana out-of-play
                            ControlPANEL = -1 'Change player
                            Exit Function
                    End Select
                End If
            End If
    End Select
    ControlPANEL = 0 'No action required

End Function

Sub DoAPES

    KongX = LBldg * 80 - 59
    KongY = Buildings(LBldg, 2) - 42
    YoungX = RBldg * 80 - 59
    YoungY = Buildings(RBldg, 2) - 42
 
    Def Seg = VarSeg(Box(1))
    BLoad "kongmjy.bsv", VarPtr(Box(1))
    Def Seg
    ApeINDEX = 1
    Get (YoungX, YoungY)-(YoungX + 38, YoungY + 42), YoungBOX(5000)
    For Index = 1 To 9001 Step 900
        Put (YoungX, YoungY), YoungBOX(5000), PSet
        Put (YoungX, YoungY), Box(Index + 450), And
        Put (YoungX, YoungY), Box(Index)
        Get (YoungX, YoungY)-(YoungX + 38, YoungY + 42), YoungBOX(ApeINDEX)
        ApeINDEX = ApeINDEX + 450
    Next Index

    Def Seg = VarSeg(Box(1))
    BLoad "kongkong.bsv", VarPtr(Box(1))
    Def Seg
    ApeINDEX = 1
    Get (KongX, KongY)-(KongX + 38, KongY + 42), KongBOX(5000)
    For Index = 1 To 9001 Step 900
        Put (KongX, KongY), KongBOX(5000), PSet
        Put (KongX, KongY), Box(Index + 450), And
        Put (KongX, KongY), Box(Index)
        Get (KongX, KongY)-(KongX + 38, KongY + 42), KongBOX(ApeINDEX)
        ApeINDEX = ApeINDEX + 450
    Next Index

    Put (KongX, KongY), KongBOX(2251), PSet
    Put (YoungX, YoungY), YoungBOX(2251), PSet

    Def Seg = VarSeg(Box(1))
    BLoad "kongexpl.bsv", VarPtr(Box(1))
    Def Seg

End Sub

Sub DrawSCREEN

    'Main screen background/title bar and control panel
    Cls
    Def Seg = VarSeg(Box(1))
    FileCOUNT = 0
    For y = 0 To 320 Step 160
        FileCOUNT = FileCOUNT + 1
        FileNAME$ = "kongscr" + LTrim$(Str$(FileCOUNT)) + ".bsv"
        BLoad FileNAME$, VarPtr(Box(1))
        Put (0, y), Box(), PSet
    Next y
    Def Seg

    'Shuffle buildings order
    For n = 8 To 2 Step -1
        Tower = Int(Rnd * n) + 1
        Swap Buildings(n, 1), Buildings(Tower, 1)
    Next n

    LBldg = Fix(Rnd * 3) + 1
    RBldg = Fix(Rnd * 3) + 6

    'Set buildings order/ save height information to array
    x = 0
    Def Seg = VarSeg(Box(1))
    For n = 1 To 8
        FileNAME$ = "kongbld" + LTrim$(Str$(Buildings(n, 1))) + ".bsv"
        BLoad FileNAME$, VarPtr(Box(1))
        Height = 165 + Fix(Rnd * 160)
        If n = LBldg And Height > 264 Then Height = 264
        If n = RBldg And Height > 264 Then Height = 264
        Buildings(n, 2) = Height
        Box(2001) = 405 - (Height + Box(1))
        Put (x, Height + Box(1)), Box(2000), PSet
        Put (x, Height + Box(1) - 45), Box(1000), And
        Put (x, Height + Box(1) - 45), Box(2)
        x = x + 80
    Next n

    'Street lights
    For x = 19 To 639 Step 120
        Line (x, 360)-(x + 1, 400), 10, B
        Circle (x + 8, 364), 2, 15
        Paint Step(0, 0), 15
        Circle Step(0, 0), 5, 8
    Next x

    'Foreground building silhouettes
    BLoad "kongfbld.bsv", VarPtr(Box(1))
    Def Seg
    Put (0, 362), Box(7000), And
    Put (0, 362), Box()

    SetWIND
    Sliders 0, 1
    Sliders 0, 2
    PrintSCORE 1, KScore
    PrintSCORE 2, YScore

End Sub

Sub Explode (What)
    Static BlastCOUNT

    Select Case What
        Case 1
            Ex = x# - 26: Ey = y# - 26
            GoSub FirstBLAST
            Ex = KongX - 12: Ey = KongY - 12
            Dx = KongX - 4: Dy = KongY + 20
        Case 2
            Ex = x# - 26: Ey = y# - 26
            GoSub FirstBLAST
            Ex = YoungX - 12: Ey = YoungY - 12
            Dx = YoungX - 4: Dy = YoungY + 20
        Case 3
            Ex = x# - 26: Ey = y# - 26
            Dx = x# - 20: Dy = y# - 20
    End Select

    If Ex + 62 > 639 Then Ex = 639 - 62
    If Ex < 0 Then Ex = 0
    Get (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()

    For Index = 1 To 14421 Step 2060
        Put (Ex, Ey), ExplosionBACK(), PSet
        If Index = 4121 Then
            If What = 1 Then
                Put (KongX, KongY), KongBOX(5000), PSet
            ElseIf What = 2 Then
                Put (YoungX, YoungY), YoungBOX(5000), PSet
            End If
            GoSub Damage
            Get (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()
        End If
        Put (Ex, Ey), Box(Index + 1030), And
        Put (Ex, Ey), Box(Index), Xor
        Interval .05
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
    Next Index

    Put (Ex, Ey), ExplosionBACK(), PSet

    Exit Sub

    Damage:
    Open "kongcrtr.dat" For Input As #2
    Input #2, Wdth, Dpth
    BlastCOUNT = BlastCOUNT + 1
    Select Case BlastCOUNT
        Case 1
            For cx = Dx + Wdth To Dx Step -1
                For cy = Dy + Dpth To Dy Step -1
                    GoSub DrawCRATER
                Next cy
            Next cx
        Case 2
            For cx = Dx To Dx + Wdth
                For cy = Dy To Dy + Dpth
                    GoSub DrawCRATER
                Next cy
            Next cx
            BlastCOUNT = 0
    End Select
    Close #2
    Return

    DrawCRATER:
    Input #2, Colr
    If Colr <> 0 Then
        If Point(cx, cy) <> 0 And Point(cx, cy) <> 12 Then
            PSet (cx, cy), Colr
        End If
    End If
    Return

    FirstBLAST:
    If Ex < 0 Then Ex = 0
    If Ex + 62 > 639 Then Ex = 577
    Get (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()
    For Index = 1 To 6181 Step 2060
        Interval 0
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        Put (Ex, Ey), ExplosionBACK(), PSet
        Put (Ex, Ey), Box(Index + 1030), And
        Put (Ex, Ey), Box(Index), Xor
    Next Index
    Put (Ex, Ey), ExplosionBACK(), PSet
    Return

End Sub

Sub Fade (InOUT)

    If InOUT = 1 Then 'Fade out
        FullFADE! = 1
        Do
            Interval .1
            Wait &H3DA, 8
            Wait &H3DA, 8, 8
            FullFADE! = FullFADE! * 1.3
            Out &H3C8, 0
            For n = 1 To 48
                Out &H3C9, Int(FadeBOX(n) / FullFADE!)
            Next n
        Loop While FullFADE! < 20
        Out &H3C8, 0
        For n = 1 To 48
            Out &H3C9, 0
        Next n
    Else 'Fade in
        FullFADE! = 20
        Do
            Interval .1
            Wait &H3DA, 8
            Wait &H3DA, 8, 8
            FullFADE! = FullFADE! * .825
            Out &H3C8, 0
            For n = 1 To 48
                Out &H3C9, Int(FadeBOX(n) / FullFADE!)
            Next n
        Loop While FullFADE! > 1.2
        SetPALETTE
    End If

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

Sub Instructions

    HideMOUSE
    Get (192, 140)-(447, 290), Box(12000)
    ShowMOUSE

    For n = 1 To 3
        Def Seg = VarSeg(Box(1))
        FileNAME$ = "kongins" + LTrim$(Str$(n)) + ".bsv"
        BLoad FileNAME$, VarPtr(Box(1))
        Def Seg
        HideMOUSE
        Put (192, 140), Box(), PSet
        ShowMOUSE
        GoSub ClickARROW
    Next n

    HideMOUSE
    Put (192, 140), Box(12000), PSet
    ShowMOUSE

    Def Seg = VarSeg(Box(1))
    BLoad "kongexpl.bsv", VarPtr(Box(1))
    Def Seg

    Exit Sub

    ClickARROW:
    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        Select Case MouseX
            Case 400 TO 424
                If MouseY > 154 And MouseY < 168 Then
                    If Arrow = 0 Then
                        HideMOUSE
                        Get (400, 154)-(424, 167), Box(25000)
                        For x = 400 To 424
                            For y = 154 To 167
                                If Point(x, y) = 6 Then PSet (x, y), 13
                            Next y
                        Next x
                        ShowMOUSE
                        Arrow = 1
                    End If
                Else
                    If Arrow Then
                        HideMOUSE
                        Put (400, 154), Box(25000), PSet
                        ShowMOUSE
                        Arrow = 0
                    End If
                End If
            Case Else
                If Arrow Then
                    HideMOUSE
                    Put (400, 154), Box(25000), PSet
                    ShowMOUSE
                    Arrow = 0
                End If
        End Select
        If Arrow = 1 And LB = -1 Then
            Put (400, 154), Box(25000), PSet
            ClearMOUSE
            Arrow = 0
            Return
        End If
    Loop
    Return

End Sub

DefSng A-Z
Sub Interval (Length!)

    OldTIMER# = Timer
    Do
        If Timer < OldTIMER# Then Exit Sub
    Loop Until Timer > OldTIMER# + Length!
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

Sub PlayGAME
    Static Started
    Shared Player1SPEED#, Player2SPEED#
    Shared Player1ANGLE#, Player2ANGLE#

    DrawSCREEN
    DoAPES
    CompTOSS = 0

    Fade 2

    Do
        If Started = 0 Then
            KScore = 0: YScore = 0
            PrintSCORE 1, KScore
            PrintSCORE 2, YScore
            StartUP
            Started = 1
            If NumPLAYERS = 2 Then
                Ape = Fix(Rnd * 2) + 1
                Player1SPEED# = 0: Player2SPEED# = 0
                Player1ANGLE# = 0: Player2ANGLE# = 0
            Else
                Ape = 2
            End If
            ClearMOUSE
        End If

        If Ape = 1 Then Ape = 2 Else Ape = 1

        If Ape = 1 Then
            YTurn = 0: KTurn = 7
            Line (73, 473)-(97, 474), 13, B 'LED's
            Line (540, 473)-(564, 474), 10, B
            Put (KongX, KongY), KongBOX(), PSet
            Speed# = Player1SPEED#: Angle# = Player1ANGLE#
            Sliders Int(Player1SPEED#), 1
            Sliders Int(Player1ANGLE#), 0
        Else
            YTurn = 7: KTurn = 0
            Line (73, 473)-(97, 474), 10, B 'LED's
            Line (540, 473)-(564, 474), 13, B
            Put (YoungX, YoungY), YoungBOX(), PSet
            Speed# = Player2SPEED#: Angle# = Player2ANGLE#
            Sliders Int(Player2SPEED#), 1
            Sliders Int(Player2ANGLE#), 0
        End If
        If NumPLAYERS = 1 And Ape = 2 Then LocateMOUSE 319, 440
        ShowMOUSE

        Do
            MouseSTATUS LB, RB, MouseX, MouseY
            Select Case MouseY
                Case 18 TO 27
                    TopMENU 1
                Case 424 TO 462
                    If NumPLAYERS = 1 And Ape = 2 Then
                        Select Case Computer 'Call to Computer FUNCTION
                            Case -1: Exit Do 'Change player
                            Case 1 'Reset screen
                                Fade 1
                                HideMOUSE
                                Player1SPEED# = 0: Player2SPEED# = 0
                                Player1ANGLE# = 0: Player2ANGLE# = 0
                                Exit Sub
                            Case 2: GoSub EndGAME 'Game over
                        End Select
                    Else
                        Select Case ControlPANEL 'Call to ControlPANEL FUNCTION
                            Case -1: Exit Do 'Change player
                            Case 1 'Reset screen
                                Fade 1
                                HideMOUSE
                                Player1SPEED# = 0: Player2SPEED# = 0
                                Player1ANGLE# = 0: Player2ANGLE# = 0
                                Exit Sub
                            Case 2: GoSub EndGAME 'Game over
                        End Select
                    End If
                Case Else
                    If Item Then TopMENU 0
            End Select
        Loop

    Loop

    Exit Sub

    EndGAME:
    Def Seg = VarSeg(Box(1))
    If KScore = 3 Then
        BLoad "kongwink.bsv", VarPtr(Box(1))
    Else
        BLoad "kongwiny.bsv", VarPtr(Box(1))
    End If
    Def Seg
    wx = (640 - Box(1)) / 2
    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    Put (wx, 160), Box(), PSet
    a$ = Input$(1)
    If a$ = Chr$(13) Then
        Started = 0
        Fade 1
        Player1SPEED# = 0: Player2SPEED# = 0
        Player1ANGLE# = 0: Player2ANGLE# = 0
        HideMOUSE
        Exit Sub
    End If
    System
    Return

End Sub

Sub PrintSCORE (Ape, Score)

    If Ape = 1 Then
        Put (19, 452), NumBOX(Score * 75 + 1), PSet
    Else
        Put (604, 452), NumBOX(Score * 75 + 1), PSet
    End If

End Sub

Sub SetPALETTE

    Restore PaletteDATA
    Out &H3C8, 0
    For n = 1 To 48
        Read Intensity
        Out &H3C9, Intensity
    Next n

End Sub

Sub SetWIND

    Wind! = Fix(Rnd * 17) - 8
    Line (291, 462)-(349, 476), 7, BF
    If Wind! = 0 Then
        Put (298, 465), LilBOX(), PSet
    Else
        If Wind! < 0 Then
            PSet (320 + Abs(Wind! * 2) + 3, 466), 13
            Draw "L10"
            Draw "L" + LTrim$(Str$(Abs(Wind! * 3))) + "U3 G6 F6 U3 R10"
            Draw "R" + LTrim$(Str$(Abs(Wind! * 3))) + "U6 bg3 p13,13"
        Else
            PSet (320 - Wind! * 2 - 3, 466), 13
            Draw "R10"
            Draw "R" + LTrim$(Str$(Abs(Wind! * 3))) + "U3 F6 G6 U3 L10"
            Draw "L" + LTrim$(Str$(Abs(Wind! * 3))) + "U6 bf3 p13,13"
        End If
    End If

End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
End Sub

Sub Sliders (Value, Slider)
    Static LeftX, RightX

    If LeftX = 0 Then LeftX = 141
    If RightX = 0 Then RightX = 484
    Wait &H3DA, 8
    Wait &H3DA, 8, 8

    HideMOUSE
    If Slider = 1 Then
        Put (LeftX, 443), SliderBOX(281), PSet
        LeftX = 141 + Value
        Get (LeftX, 443)-(LeftX + 10, 461), SliderBOX(281)
        Put (LeftX, 443), SliderBOX(201), PSet
    Else
        Put (RightX, 443), SliderBOX(361), PSet
        RightX = 489 - Value
        Get (RightX, 443)-(RightX + 10, 461), SliderBOX(361)
        Put (RightX, 443), SliderBOX(201), PSet
    End If
    ShowMOUSE

    GoSub SetNUMS

    Exit Sub

    SetNUMS:
    Num$ = LTrim$(Str$(Value))
    If Value < 10 Then
        LNum = 0
        RNum = Val(Num$)
    Else
        LNum = Val(Mid$(Num$, 1, 1))
        RNum = Val(Mid$(Num$, 2, 1))
    End If
    HideMOUSE
    If Slider = 1 Then
        Put (260, 447), SliderBOX(LNum * 20 + 1), PSet
        Put (266, 447), SliderBOX(RNum * 20 + 1), PSet
    Else
        Put (369, 447), SliderBOX(LNum * 20 + 1), PSet
        Put (375, 447), SliderBOX(RNum * 20 + 1), PSet
    End If
    ShowMOUSE
    Return

End Sub

Sub StartUP

    Def Seg = VarSeg(Box(1))
    BLoad "kong1pl2.bsv", VarPtr(Box(1))
    Def Seg
    Get (209, 160)-(430, 237), Box(12000)
    Put (209, 160), Box(), PSet
    LocateMOUSE 340, 190
    ShowMOUSE

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        Select Case MouseX
            Case 244 TO 270
                If Item = 0 Then
                    Select Case MouseY
                        Case 193 TO 205
                            If LB Then
                                ButtonX = 245: ButtonY = 194
                                GoSub Clicker
                                NumPLAYERS = 2
                                FileNAME$ = "kongopen.bsv"
                                GoSub LoadFILE
                            End If
                        Case 209 TO 221
                            If LB Then
                                ButtonX = 245: ButtonY = 210
                                GoSub Clicker
                                NumPLAYERS = 1
                                FileNAME$ = "Kong1PLR.BSV"
                                GoSub LoadFILE
                            End If
                    End Select
                End If
            Case 340 TO 366
                If Item = 1 Then
                    If MouseY > 209 And MouseY < 221 Then
                        If LB Then
                            ButtonX = 340: ButtonY = 210
                            GoSub Clicker
                            Exit Do
                        End If
                    End If
                End If
        End Select
    Loop

    HideMOUSE
    Put (209, 160), Box(12000), PSet
    ShowMOUSE
    Item = 0
    Def Seg = VarSeg(Box(1))
    BLoad "kongexpl.bsv", VarPtr(Box(1))
    Def Seg

    Exit Sub

    LoadFILE:
    Def Seg = VarSeg(Box(1))
    BLoad LCase$(FileNAME$), VarPtr(Box(21500))
    Def Seg
    HideMOUSE
    Put (209, 160), Box(21500), PSet
    ShowMOUSE
    Return

    Clicker:
    HideMOUSE
    Get (ButtonX, ButtonY)-(ButtonX + 24, ButtonY + 10), Box(20000)
    Line (ButtonX, ButtonY)-(ButtonX + 24, ButtonY + 10), 8, B
    ShowMOUSE
    Interval .1
    HideMOUSE
    Put (ButtonX, ButtonY), Box(20000), PSet
    ShowMOUSE
    Interval .01
    Item = Item + 1
    Return

End Sub

Sub TopMENU (InOUT)
    Static MX1

    If InOUT = 0 Then GoSub DeLIGHT: Exit Sub

    Select Case MouseX
        Case 20 TO 72
            If Item <> 1 Then
                GoSub DeLIGHT
                MX1 = 20: MX2 = 72
                GoSub HiLIGHT
                Item = 1
            End If
        Case 594 TO 616
            If Item <> 2 Then
                GoSub DeLIGHT
                MX1 = 594: MX2 = 616
                GoSub HiLIGHT
                Item = 2
            End If
        Case Else
            GoSub DeLIGHT
    End Select

    If LB = -1 And Item Then
        Select Case Item
            Case 1: GoSub DeLIGHT: Instructions
            Case 2: GoSub DeLIGHT: System
        End Select
    End If

    Exit Sub

    HiLIGHT:
    HideMOUSE
    Get (MX1, 18)-(MX2, 27), Box(25000)
    For x = MX1 To MX2
        For y = 18 To 27
            If Point(x, y) <> 1 And Point(x, y) <> 2 Then
                PSet (x, y), 13
            End If
        Next y
    Next x
    ShowMOUSE
    Return

    DeLIGHT:
    If Item Then
        HideMOUSE
        Put (MX1, 18), Box(25000), PSet
        ShowMOUSE
    End If
    Item = 0
    Return

End Sub
