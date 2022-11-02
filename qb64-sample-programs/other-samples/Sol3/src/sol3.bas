'CHDIR ".\samples\thebob\sol"

'****************************************************************************'
'-------------------------- S O L I T A I R E - 3 ---------------------------'
'------------- Copyright (C) 2000-2007 by Bob Seguin (Freeware) -------------'
'****************************************************************************'

DefInt A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, mX, mY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE SUB DrawSCREEN (Mode)
DECLARE SUB Interval (Length!)
DECLARE SUB CheckOUT ()
DECLARE SUB InitVALS ()

DECLARE SUB PlayGAME ()

DECLARE SUB Sol3MENU (Item)
DECLARE SUB Sol3DEAL ()
DECLARE SUB Sol3UNDO ()
DECLARE SUB Sol3HELP (Item)
DECLARE SUB BigBOX (InOUT)

DECLARE SUB SetSCORE ()
DECLARE SUB PutCARD (x, y, CardNUM)
DECLARE SUB CheckTOTAL ()
DECLARE SUB Finito ()

Type PlayTYPE
    Suit As Integer
    Value As Integer
    x As Integer
    y As Integer
    UpDOWN As Integer
End Type
Dim Shared MainPLAY(1 To 7, 0 To 18) As PlayTYPE

Type DeckTYPE
    Suit As Integer
    Value As Integer
End Type
Dim Shared Decks(1 To 3, 1 To 8) As DeckTYPE
Dim Shared TurnUPs(0 To 24) As DeckTYPE
Dim Shared Stacks(1 To 4) As DeckTYPE
Dim Shared Trick(1 To 18) As DeckTYPE

Dim Shared LettFileName$

ReDim Shared Buttons(600)
ReDim Shared Title(1 To 250)
ReDim Shared Card(1 To 2400)
ReDim Shared CardBACK(1 To 2400)
ReDim Shared BackERASE(1 To 2600)
ReDim Shared Selected(1 To 2400)
ReDim Shared Suits(1 To 800)
ReDim Shared MenuBOX(220)
ReDim Shared ItemBOX(500)
ReDim Shared MenuGFX(500)
ReDim Shared Deck(1 To 52)
ReDim Shared TopOFF(1 To 44)
ReDim Shared Chek(50)
ReDim Shared GetBOX(8000)
ReDim Shared OtherBOX(8000)
ReDim Shared Numbers(1100)

Dim Shared Score As Long
Dim Shared MoneyCARD
Dim Shared Tally
Dim Shared StackIT
Dim Shared Completed
Dim Shared MouseDATA$

Dim Shared Vegas
Dim Shared Money
Open "sol3opts.dat" For Input As #1
Input #1, Vegas, Money
Close #1

Def Seg = VarSeg(Suits(1))
BLoad "sol3suit.bsv", VarPtr(Suits(1))
Def Seg = VarSeg(Buttons(0))
BLoad "sol3btns.bsv", VarPtr(Buttons(0))
Def Seg = VarSeg(Title(1))
BLoad "sol3titl.bsv", VarPtr(Title(1))
Def Seg = VarSeg(CardBACK(1))
BLoad "sol3cd53.bsv", VarPtr(CardBACK(1))
Def Seg = VarSeg(BackERASE(1))
BLoad "sol3cd54.bsv", VarPtr(BackERASE(1))
Def Seg = VarSeg(Selected(1))
BLoad "sol3sele.bsv", VarPtr(Selected(1))
Def Seg = VarSeg(TopOFF(1))
BLoad "sol3topp.bsv", VarPtr(TopOFF(1))
Def Seg = VarSeg(Chek(0))
BLoad "sol3chek.bsv", VarPtr(Chek(0))
Def Seg = VarSeg(Numbers(0))
BLoad "sol3nums.bsv", VarPtr(Numbers(0))
Def Seg = VarSeg(MenuGFX(0))
BLoad "sol3men1.bsv", VarPtr(MenuGFX(0))
Def Seg

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

GoSub SetPALETTE
DrawSCREEN 1
InitVALS
Randomize Timer
Sol3DEAL
ShowMOUSE

Do
    Beginning:
    MouseSTATUS LB, RB, MouseX, MouseY
    If Menu > 2 Then Sol3MENU 1: GoTo Beginning
    Select Case MouseY
        Case Is < 18
            If MouseX > 621 And LB Then CheckOUT
            If Menu Then Sol3MENU 0
        Case 20 TO 35
            Select Case MouseX
                Case Is < 103
                    Sol3MENU 1
                Case Else
                    If Menu Then Sol3MENU 0
            End Select
        Case Is > 38
            If Menu Then Sol3MENU 0
            PlayGAME
            Finito
    End Select
    PauseMOUSE LB, RB, MouseX, MouseY
Loop

System

SetPALETTE:
Data 0,0,0,16,16,32,21,63,21,63,63,0
Data 63,0,0,28,28,28,0,34,0,63,50,10
Data 0,30,55,45,50,63,0,63,63,0,42,0
Data 63,45,55,63,30,40,48,48,48,63,63,63
Restore SetPALETTE
Out &H3C8, 0
For n = 1 To 48
    Read Intensity
    Out &H3C9, Intensity
Next n
Return

Sub CheckOUT

    HideMOUSE
    Put (622, 2), Buttons(400), PSet
    ShowMOUSE

    Interval .1

    HideMOUSE
    Put (588, 2), Buttons(), PSet
    ShowMOUSE

    Interval .1

    System

End Sub

Sub CheckTOTAL
    Shared Deck1, Deck2, Deck3, Deck4

    If Vegas = 0 Then
        If Deck1 = 0 Then
            If Deck2 = 0 Then
                If Deck3 = 0 Then
                    HideMOUSE
                    If Deck4 > 0 Then
                        Deck1 = Deck4
                        Put (5, 43), CardBACK(), PSet
                    End If
                    If Deck4 > 8 Then
                        Deck1 = 8
                        Deck2 = Deck4 - 8
                        Put (83, 43), CardBACK(), PSet
                    End If
                    If Deck4 > 16 Then
                        Deck1 = 8
                        Deck2 = 8
                        Deck3 = Deck4 - 16
                        Put (161, 43), CardBACK(), PSet
                    End If
                    Line (239, 43)-(313, 152), 11, BF
                    ShowMOUSE
                    For n = 1 To Deck3
                        Decks(3, n).Value = TurnUPs(Deck4).Value
                        Decks(3, n).Suit = TurnUPs(Deck4).Suit
                        Deck4 = Deck4 - 1
                    Next n
                    For n = 1 To Deck2
                        Decks(2, n).Value = TurnUPs(Deck4).Value
                        Decks(2, n).Suit = TurnUPs(Deck4).Suit
                        Deck4 = Deck4 - 1
                    Next n
                    For n = 1 To Deck1
                        Decks(1, n).Value = TurnUPs(Deck4).Value
                        Decks(1, n).Suit = TurnUPs(Deck4).Suit
                        Deck4 = Deck4 - 1
                    Next n
                    Deck4 = 0
                End If
            End If
        End If
    End If

End Sub

Sub ClearMOUSE
    Shared LB

    While LB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub DrawSCREEN (Mode)

    HideMOUSE
    If Mode = 1 Then
        Line (0, 0)-(639, 17), 1, BF
        Line (0, 18)-(639, 37), 14, BF
        Line (0, 38)-(639, 38), 0
        Put (588, 2), Buttons(), PSet
        Put (20, 0), Title(), PSet
        Put (20, 24), MenuGFX(), PSet
        Put (73, 24), MenuGFX(100), PSet
        Put (532, 24), MenuGFX(400), PSet
    End If

    Line (0, 39)-(639, 479), 11, BF
    Line (0, 155)-(639, 155), 2
    Line (318, 39)-(318, 155), 2
    Line (321, 39)-(321, 154), 6
    Line (319, 155)-(320, 155), 11
    PSet (321, 155), 8

    Index = 1
    For x = 326 To 568 Step 78
        Line (x, 43)-(x + 74, 151), 2, B
        Line (x, 43)-(x + 74, 43), 6
        Line (x, 43)-(x, 151), 6
        Line (x + 18, 73)-(x + 56, 121), 2, B
        Line (x + 18, 73)-(x + 56, 73), 6
        Line (x + 18, 73)-(x + 18, 121), 6
        Put (x + 25, 85), Suits(Index), PSet
        Index = Index + 200
    Next x

    If Vegas Then SetSCORE
    ShowMOUSE

End Sub

Sub Finito
    If Completed Then Exit Sub
    If Stacks(1).Value = 13 Then
        If Stacks(2).Value = 13 Then
            If Stacks(3).Value = 13 Then
                If Stacks(4).Value = 13 Then
                    HideMOUSE
                    Play "MBMST120O1L16ceg>ceg>ceg>L32cg"
                    Play "MBMST120O4L32cgcgcgcg"
                    For Reps = 1 To 400
                        x = Fix(Rnd * 560)
                        y = Fix(Rnd * 370)
                        CardNUM = Fix(Rnd * 52) + 1
                        PutCARD x, y, CardNUM
                    Next Reps
                    ShowMOUSE
                    DrawSCREEN 1
                    Play "MBO1L16CEGC"
                    x = 30
                    For CardNUM = 1 To 52
                        PutCARD x, 185, CardNUM
                        x = x + 10
                    Next CardNUM
                    Color 3
                    Line (180, 230)-(470, 265), 0, BF
                    Line (185, 235)-(465, 260), 4, B
                    Locate 16, 27: Print "C O N G R A T U L A T I O N S !"
                    Interval 2
                    DrawSCREEN 1
                    Completed = 1
                End If
            End If
        End If
    End If

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

Sub InitVALS
    Shared Menu

    For n = 1 To 52
        Deck(n) = n
    Next n

    For Col = 1 To 7
        For Row = 1 To 18
            MainPLAY(Col, Row).x = (Col - 1) * 88 + 18
            MainPLAY(Col, Row).y = (Row - 1) * 18 + 158
        Next Row
    Next Col

    For Col = 1 To 7
        MainPLAY(Col, 0).x = (Col - 1) * 88 + 18
        MainPLAY(Col, 0).y = 140
    Next Col

End Sub

DefSng A-Z
Sub Interval (Length!)

    OldTimer# = Timer
    Do: Loop Until Timer > OldTimer# + Length!

End Sub

DefInt A-Z
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

Sub Navigate
End Sub

Sub PauseMOUSE (OldLB, OldRB, OldMX, OldMY)
    Shared Key$

    Do
        Key$ = UCase$(InKey$)
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB <> OldLB Or RB <> OldRB Or MouseX <> OldMX Or MouseY <> OldMY Or Key$ <> ""

End Sub

Sub PlayGAME
    Shared LB, RB, MouseX, MouseY
    Shared Deck1, Deck2, Deck3, Deck4, CardSELECT
    Shared FCcol, FCrow, FCx, FCy, FCsuit, FCvalue, LastDECK

    BackERASE(2) = 127: CardBACK(2) = 109: Selected(2) = 109

    Select Case MouseY
        Case 43 TO 151
            Select Case MouseX
                Case 7 TO 81 'first deck
                    If LB Then
                        If CardSELECT Then GoSub ZeroTURNUPS
                        If Deck1 > 0 Then
                            CardNUM = (Decks(1, Deck1).Suit - 1) * 13 + Decks(1, Deck1).Value
                            HideMOUSE
                            PutCARD 239, 43, CardNUM
                            ShowMOUSE
                            Deck4 = Deck4 + 1
                            TurnUPs(Deck4).Suit = Decks(1, Deck1).Suit
                            TurnUPs(Deck4).Value = Decks(1, Deck1).Value
                            Decks(1, Deck1).Suit = 0
                            Decks(1, Deck1).Value = 0
                            Deck1 = Deck1 - 1
                            LastDECK = 1
                            If Deck1 = 0 Then
                                HideMOUSE
                                Line (5, 43)-(79, 152), 11, BF
                                If Vegas = 0 Then
                                    Line (24, 73)-(62, 121), 2, B
                                    Line (26, 75)-(60, 119), 2, BF
                                End If
                                ShowMOUSE
                            End If
                        Else
                            CheckTOTAL
                        End If
                        ClearMOUSE
                    End If
                Case 85 TO 159 'second deck
                    If LB Then
                        If CardSELECT Then GoSub ZeroTURNUPS
                        If Deck2 > 0 Then
                            CardNUM = (Decks(2, Deck2).Suit - 1) * 13 + Decks(2, Deck2).Value
                            HideMOUSE
                            PutCARD 239, 43, CardNUM
                            ShowMOUSE
                            Deck4 = Deck4 + 1
                            TurnUPs(Deck4).Suit = Decks(2, Deck2).Suit
                            TurnUPs(Deck4).Value = Decks(2, Deck2).Value
                            Decks(2, Deck2).Suit = 0
                            Decks(2, Deck2).Value = 0
                            Deck2 = Deck2 - 1
                            LastDECK = 2
                            If Deck2 = 0 Then
                                HideMOUSE
                                Line (83, 43)-(157, 152), 11, BF
                                If Vegas = 0 Then
                                    Line (102, 73)-(140, 121), 2, B
                                    Line (104, 75)-(138, 119), 2, BF
                                End If
                                ShowMOUSE
                            End If
                        Else
                            CheckTOTAL
                        End If
                        ClearMOUSE
                    End If
                Case 163 TO 237 'third deck
                    If LB Then
                        If CardSELECT Then GoSub ZeroTURNUPS
                        If Deck3 > 0 Then
                            CardNUM = (Decks(3, Deck3).Suit - 1) * 13 + Decks(3, Deck3).Value
                            HideMOUSE
                            PutCARD 239, 43, CardNUM
                            ShowMOUSE
                            Deck4 = Deck4 + 1
                            TurnUPs(Deck4).Suit = Decks(3, Deck3).Suit
                            TurnUPs(Deck4).Value = Decks(3, Deck3).Value
                            Decks(3, Deck3).Suit = 0
                            Decks(3, Deck3).Value = 0
                            Deck3 = Deck3 - 1
                            LastDECK = 3
                            If Deck3 = 0 Then
                                HideMOUSE
                                Line (161, 43)-(235, 152), 11, BF
                                If Vegas = 0 Then
                                    Line (180, 73)-(218, 121), 2, B
                                    Line (182, 75)-(216, 119), 2, BF
                                End If
                                ShowMOUSE
                            End If
                        Else
                            CheckTOTAL
                        End If
                        ClearMOUSE
                    End If
                Case 241 TO 319 'turn-up deck
                    If Deck4 > 0 Then
                        If LB Then
                            If CardSELECT = 0 Then
                                TSuit = TurnUPs(Deck4).Suit
                                TValue = TurnUPs(Deck4).Value
                                CardNUM = (TSuit - 1) * 13 + TValue
                                If (CardNUM = MoneyCARD) And Money Then
                                    HideMOUSE
                                    PutCARD 239, 43, CardNUM
                                    Play "MBT140O6L64GP32GP32GP32GP32GP32GP32GP32G"
                                    Score = Score + 52 + Tally: SetSCORE
                                    Tally = Tally + 5
                                    MoneyCARD = 0
                                    GoSub ZeroVALS
                                    ShowMOUSE
                                    Exit Sub
                                End If
                                HideMOUSE
                                Put (239, 43), Selected()
                                ShowMOUSE
                                CardSELECT = 2
                            Else
                                HideMOUSE
                                If CardSELECT = 2 Then
                                    TSuit = TurnUPs(Deck4).Suit
                                    TValue = TurnUPs(Deck4).Value
                                    CardNUM = (TSuit - 1) * 13 + TValue
                                    If (CardNUM = MoneyCARD) And Money Then
                                        PutCARD 239, 43, CardNUM
                                        Play "MBT140O6L64GP32GP32GP32GP32GP32GP32GP32G"
                                        MoneyCARD = 0
                                        GoSub ZeroVALS
                                        ShowMOUSE
                                        Exit Sub
                                    End If
                                    If Stacks(TSuit).Value = TValue - 1 Then
                                        If TurnUPs(Deck4 - 1).Value <> 0 Then
                                            CardNUM = (TurnUPs(Deck4 - 1).Suit - 1) * 13 + TurnUPs(Deck4 - 1).Value
                                            PutCARD 239, 43, CardNUM
                                        Else
                                            Line (239, 43)-(313, 152), 11, BF
                                        End If
                                        CardNUM = (TSuit - 1) * 13 + TValue
                                        PutCARD ((TSuit - 1) * 78 + 325), 43, CardNUM
                                        Score = Score + 5: Tally = Tally + 5
                                        If Vegas Then SetSCORE
                                        ShowMOUSE
                                        Stacks(TSuit).Value = Stacks(TSuit).Value + 1
                                        TurnUPs(Deck4).Suit = 0
                                        TurnUPs(Deck4).Value = 0
                                        Deck4 = Deck4 - 1
                                        GoSub ZeroVALS
                                    Else
                                        Put (239, 43), Selected()
                                        GoSub ZeroVALS
                                    End If
                                Else
                                    Put (FCx, FCy), Selected()
                                    GoSub ZeroVALS
                                End If
                                ShowMOUSE
                            End If
                            ClearMOUSE
                        End If
                    End If
            End Select
        Case Is > 159 'columns y
            Select Case MouseX
                Case 18 TO 92 'column 1
                    If LB Then
                        Column = 1
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 106 TO 180 'column 2
                    If LB Then
                        Column = 2
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 194 TO 268 'column 3
                    If LB Then
                        Column = 3
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 282 TO 356 'column 4
                    If LB Then
                        Column = 4
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 370 TO 444 'column 5
                    If LB Then
                        Column = 5
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 458 TO 532 'column 6
                    If LB Then
                        Column = 6
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
                Case 546 TO 620 'column 7
                    If LB Then
                        Column = 7
                        If CardSELECT = 0 Then
                            GoSub SELECT1
                        Else
                            GoSub SELECT2
                        End If
                    End If
            End Select
    End Select
    ClearMOUSE
    Exit Sub

    '*************************** FIRST SELECTION SUBROUTINE **********************
    SELECT1:
    LastDECK = 0
    FCcol = Column
    For FCrow = 18 To 1 Step -1
        If MainPLAY(FCcol, FCrow).Value <> 0 Then
            If MainPLAY(FCcol, FCrow).UpDOWN = 0 Then
                cn = (MainPLAY(FCcol, FCrow).Suit - 1) * 13 + MainPLAY(FCcol, FCrow).Value
                CardNUM = cn
                FCx = MainPLAY(FCcol, FCrow).x
                FCy = MainPLAY(FCcol, FCrow).y
                HideMOUSE
                PutCARD FCx, FCy, CardNUM
                ShowMOUSE
                MainPLAY(FCcol, FCrow).UpDOWN = 1
                GoSub ZeroVALS
                ClearMOUSE
                Return
            Else
                FCsuit = MainPLAY(FCcol, FCrow).Suit
                FCvalue = MainPLAY(FCcol, FCrow).Value
                FCx = MainPLAY(FCcol, FCrow).x
                FCy = MainPLAY(FCcol, FCrow).y
                If FCy + 108 < 479 Then Selected(2) = 109 Else Selected(2) = 480 - FCy
                HideMOUSE
                Put (FCx, FCy), Selected()
                ShowMOUSE
                CardSELECT = 1
                ClearMOUSE
                Return
            End If
        End If
    Next FCrow
    Return

    '************************* SECOND SELECTION SUBROUTINE ***********************

    SELECT2:
    LastDECK = 0
    SCcol = Column
    If CardSELECT = 1 Then
        HideMOUSE
        If FCcol = SCcol Or FCvalue = 1 Then
            If Stacks(FCsuit).Value = FCvalue - 1 Then
                GoSub LiftCARD
                CardNUM = (FCsuit - 1) * 13 + FCvalue
                PutCARD ((FCsuit - 1) * 78 + 325), 43, CardNUM
                Stacks(FCsuit).Value = Stacks(FCsuit).Value + 1
                MainPLAY(FCcol, FCrow).Value = 0
                MainPLAY(FCcol, FCrow).Suit = 0
                GoSub ZeroVALS
                Score = Score + 5: Tally = Tally + 5
                If Vegas Then SetSCORE
                ShowMOUSE
                ClearMOUSE
                Return
            Else
                If FCy + 108 < 479 Then Selected(2) = 109 Else Selected(2) = 480 - FCy
                Put (FCx, FCy), Selected()
                GoSub ZeroVALS
                ShowMOUSE
                ClearMOUSE
                Return
            End If
        Else
            For SCrow = 18 To 1 Step -1
                If MainPLAY(SCcol, SCrow).Value <> 0 Then Exit For
            Next SCrow

            If SCrow = 0 Then
                If FCvalue = 13 Then
                    GoSub LiftCARD
                    CardNUM = (MainPLAY(FCcol, FCrow).Suit - 1) * 13 + 13
                    PutCARD MainPLAY(SCcol, 1).x, MainPLAY(SCcol, 1).y, CardNUM
                    ShowMOUSE
                    MainPLAY(SCcol, 1).Suit = FCsuit
                    MainPLAY(SCcol, 1).Value = 13
                    MainPLAY(FCcol, FCrow).Suit = 0
                    MainPLAY(FCcol, FCrow).Value = 0
                    GoSub ZeroVALS
                    ClearMOUSE
                    Return
                Else
                    For Reduce = FCrow To 0 Step -1
                        If MainPLAY(FCcol, Reduce).UpDOWN = 1 Then
                            If MainPLAY(FCcol, Reduce).Value = 13 Then
                                SCrow = 0
                                MatchCARD = Reduce
                                GoTo TrickHANDLER
                            End If
                        End If
                    Next Reduce

                    If FCy + 108 > 479 Then Selected(2) = 480 - FCx Else Selected(2) = 109
                    Put (FCx, FCy), Selected()
                    ShowMOUSE
                    GoSub ZeroVALS
                    ClearMOUSE
                    Return
                End If
            End If


            For MatchCARD = FCrow To 0 Step -1
                If MainPLAY(FCcol, MatchCARD).UpDOWN = 1 Then
                    FCsuit = MainPLAY(FCcol, MatchCARD).Suit
                    FCvalue = MainPLAY(FCcol, MatchCARD).Value

                    If FCvalue + 1 = MainPLAY(SCcol, SCrow).Value Or FCrow = 0 Then
                        If MainPLAY(SCcol, SCrow).Suit Mod 2 <> FCsuit Mod 2 Then
                            If MatchCARD < FCrow Then
                                Erase Trick
                                TrickHANDLER:
                                For Row = FCrow - 1 To MatchCARD - 1 Step -1
                                    Ex = MainPLAY(FCcol, Row).x
                                    Ey = MainPLAY(FCcol, Row).y
                                    If MainPLAY(FCcol, Row).UpDOWN = 1 Then
                                        EraseNUM = (MainPLAY(FCcol, Row).Suit - 1) * 13 + MainPLAY(FCcol, Row).Value
                                        PutCARD Ex, Ey, EraseNUM
                                        Line (Ex, Ey + 109)-(Ex + 74, Ey + 127), 11, BF
                                    Else
                                        If MainPLAY(FCcol, Row).Value = 0 Then
                                            Line ((FCcol - 1) * 88 + 18, 158)-((FCcol - 1) * 88 + 92, 284), 11, BF
                                        Else
                                            If Ey + 109 > 479 Then
                                                BackERASE(2) = 480 - Ey
                                            Else
                                                BackERASE(2) = 127
                                            End If
                                            If Point(Ex + 1, Ey - 1) = 15 Then OnTOP = 1
                                            Put (Ex, Ey), BackERASE(), PSet
                                            If OnTOP Then Put (Ex, Ey), TopOFF(), PSet
                                        End If
                                    End If
                                    Count = Count + 1
                                    Trick(Count).Suit = MainPLAY(FCcol, Row + 1).Suit
                                    Trick(Count).Value = MainPLAY(FCcol, Row + 1).Value
                                    MainPLAY(FCcol, Row + 1).Suit = 0
                                    MainPLAY(FCcol, Row + 1).Value = 0
                                Next Row
                                x = MainPLAY(SCcol, SCrow).x
                                y = MainPLAY(SCcol, SCrow).y
                                For Cards = FCrow - MatchCARD + 1 To 1 Step -1
                                    CardNUM = (Trick(Cards).Suit - 1) * 13 + Trick(Cards).Value
                                    Slot = Slot + 1
                                    MainPLAY(SCcol, SCrow + Slot).Suit = Trick(Cards).Suit
                                    MainPLAY(SCcol, SCrow + Slot).Value = Trick(Cards).Value
                                    MainPLAY(SCcol, SCrow + Slot).UpDOWN = 1
                                    y = y + 18
                                    PutCARD x, y, CardNUM
                                Next Cards
                                ShowMOUSE
                                ClearMOUSE
                                GoSub ZeroVALS
                                Return
                            Else
                                GoSub LiftCARD
                                CardNUM = (FCsuit - 1) * 13 + FCvalue

                                NCx = MainPLAY(SCcol, SCrow).x
                                NCy = MainPLAY(SCcol, SCrow + 1).y

                                PutCARD NCx, NCy, CardNUM

                                ShowMOUSE
                                ClearMOUSE

                                MainPLAY(SCcol, SCrow + 1).Suit = FCsuit
                                MainPLAY(SCcol, SCrow + 1).Value = FCvalue
                                MainPLAY(SCcol, SCrow + 1).UpDOWN = 1

                                MainPLAY(FCcol, FCrow).Suit = 0
                                MainPLAY(FCcol, FCrow).Value = 0
                                GoSub ZeroVALS
                                Return
                            End If
                        End If
                    End If
                End If
            Next MatchCARD
            If FCy + 108 > 479 Then Selected(2) = 480 - FCx Else Selected(2) = 109
            Put (FCx, FCy), Selected()
            GoSub ZeroVALS
            ShowMOUSE
            ClearMOUSE
            Return
        End If

    Else 'CardSELECT = 2

        For SCrow = 18 To 1 Step -1
            If MainPLAY(SCcol, SCrow).Value <> 0 Then Exit For
        Next SCrow

        If SCrow = 0 Then
            HideMOUSE
            If TurnUPs(Deck4).Value = 13 Then
                If Deck4 > 1 Then
                    CardNUM = (TurnUPs(Deck4 - 1).Suit - 1) * 13 + TurnUPs(Deck4 - 1).Value
                    PutCARD 239, 43, CardNUM
                Else
                    Line (239, 43)-(313, 153), 11, BF
                End If
                CardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + 13
                PutCARD MainPLAY(SCcol, 1).x, 158, CardNUM
                ShowMOUSE
                MainPLAY(SCcol, 1).Suit = TurnUPs(Deck4).Suit
                MainPLAY(SCcol, 1).Value = TurnUPs(Deck4).Value
                TurnUPs(Deck4).Suit = 0
                TurnUPs(Deck4).Value = 0
                Deck4 = Deck4 - 1
                GoSub ZeroVALS
                ClearMOUSE
                Return
            End If
            ShowMOUSE
        End If

        HideMOUSE
        If TurnUPs(Deck4).Suit Mod 2 <> MainPLAY(SCcol, SCrow).Suit Mod 2 Then
            If TurnUPs(Deck4).Value + 1 = MainPLAY(SCcol, SCrow).Value Then
                Put (239, 43), Selected()
                TopcardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + TurnUPs(Deck4).Value
                SCsuit = TurnUPs(Deck4).Suit
                SCvalue = TurnUPs(Deck4).Value
                TurnUPs(Deck4).Suit = 0
                TurnUPs(Deck4).Value = 0
                If Deck4 > 0 Then
                    Deck4 = Deck4 - 1
                    If Deck4 = 0 Then
                        Line (239, 43)-(313, 152), 11, BF
                    Else
                        CardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + TurnUPs(Deck4).Value
                        PutCARD 239, 43, CardNUM
                    End If
                    PutCARD MainPLAY(SCcol, SCrow).x, MainPLAY(SCcol, SCrow + 1).y, TopcardNUM
                    ShowMOUSE
                    MainPLAY(SCcol, SCrow + 1).Suit = SCsuit
                    MainPLAY(SCcol, SCrow + 1).Value = SCvalue
                    MainPLAY(SCcol, SCrow + 1).UpDOWN = 1
                    GoSub ZeroVALS
                    ClearMOUSE
                    Return
                Else
                    Line (239, 43)-(315, 152), 11, BF
                    ShowMOUSE
                    GoSub ZeroVALS
                    ClearMOUSE
                    Return
                End If
            Else
                Put (239, 43), Selected()
                GoSub ZeroVALS
                ShowMOUSE
                ClearMOUSE
                Return
            End If
        Else
            Put (239, 43), Selected()
            GoSub ZeroVALS
            ShowMOUSE
            ClearMOUSE
            Return
        End If
    End If

    Return

    ZeroVALS:
    FCcol = 0: FCrow = 0: FCx = 0: FCy = 0: FCsuit = 0: FCvalue = 0: Column = 0: CardSELECT = 0
    Return

    LiftCARD:
    If FCrow = 1 Then
        Line ((FCcol - 1) * 88 + 18, 158)-((FCcol - 1) * 88 + 92, 266), 11, BF
    Else
        If MainPLAY(FCcol, FCrow - 1).UpDOWN = 1 Then
            CardNUM = (MainPLAY(FCcol, FCrow - 1).Suit - 1) * 13 + MainPLAY(FCcol, FCrow - 1).Value
            PutCARD FCx, FCy - 18, CardNUM
            Line (FCx, FCy + 91)-(FCx + 74, FCy + 109), 11, BF
        Else
            If FCy + 109 < 479 Then BackERASE(2) = 127 Else BackERASE(2) = 479 - FCy
            If Point(FCx + 1, FCy - 19) = 15 Then OnTOP = 1
            Put (FCx, FCy - 18), BackERASE(), PSet
            If OnTOP Then Put (FCx, FCy - 18), TopOFF(), PSet
        End If
    End If
    Return

    ZeroTURNUPS:
    HideMOUSE
    If FCy + 108 > 479 Then Selected(2) = 480 - FCx Else Selected(2) = 109
    If CardSELECT = 1 Then Put (FCx, FCy), Selected()
    ShowMOUSE
    GoSub ZeroVALS
    Return

End Sub

Sub PutCARD (x, y, CardNUM)
    Shared HoldNUM, Dealt

    If Money Then
        If HoldNUM = CardNUM Then Dealt = 1
        If CardNUM = MoneyCARD And Dealt = 0 Then
            HoldNUM = CardNUM
            CardNUM = 55
        End If
    End If

    FileNAME$ = "Sol3CD" + LTrim$(RTrim$(Str$(CardNUM))) + ".BSV"
    Def Seg = VarSeg(Card(1))
    BLoad FileNAME$, VarPtr(Card(1))
    Def Seg
    If Point(x + 1, y - 1) = 15 Then OnTOP = 1 'Check for underlying card...
    If y + 108 > 479 Then Card(2) = 480 - y Else Card(2) = 109
    Put (x, y), Card(), PSet
    If OnTOP Then Put (x, y), TopOFF(), PSet 'Place B/W card top if required

End Sub

Sub SetSCORE

    If Score < 0 Then
        PrintSCORE& = Score - Score * 2
        Minus = 1
    Else
        PrintSCORE& = Score
    End If
    Scor$ = "$" + LTrim$(RTrim$(Str$(PrintSCORE&)))
    Line (564, 23)-(631, 34), 14, BF
    x = 572
    If Minus Then Line (566, 29)-(571, 29), 4
    For n = 1 To Len(Scor$)
        Char$ = Mid$(Scor$, n, 1)
        If Char$ = "$" Then
            Index = 500
        Else
            Index = Val(Char$) * 50
        End If
        If Minus Then Index = Index + 550
        Put (x, 23), Numbers(Index), PSet
        x = x + 7
    Next n
    If Minus Then Index = 550: Colr = 4 Else Index = 0: Colr = 2
    Line (x + 1, 31)-(x + 2, 32), Colr, B
    Put (x + 5, 23), Numbers(Index), PSet
    Put (x + 12, 23), Numbers(Index), PSet
End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
End Sub

Sub Sol3DEAL
    Shared Deck1, Deck2, Deck3, Deck4
    Shared FCcol, FCrow, FCx, FCy, FCsuit, FCvalue, CardSELECT
    Shared HoldNUM, Dealt

    DrawSCREEN 2
    Erase Stacks: Completed = 0
    HoldNUM = 0: Dealt = 0

    HideMOUSE
    For x = 5 To 161 Step 78
        Put (x, 43), CardBACK(), PSet
    Next x
    ShowMOUSE

    For Col = 1 To 7
        For Row = 1 To 18
            MainPLAY(Col, Row).Suit = 0
            MainPLAY(Col, Row).Value = 0
            MainPLAY(Col, Row).UpDOWN = 0
        Next Row
    Next Col

    'Shuffle cards
    For n = 52 To 2 Step -1
        Card = Int(Rnd * n) + 1
        Swap Deck(n), Deck(Card)
    Next n

    MoneyNUM = Fix(Rnd * 24) + 29
    MoneyCARD = Deck(MoneyNUM)

    For Row = 1 To 7
        For Col = Row To 7
            PasteBOARD = PasteBOARD + 1
            DeckVALUE = Deck(PasteBOARD)
            Select Case DeckVALUE
                Case 1 TO 13
                    MainPLAY(Col, Row).Suit = 1
                    MainPLAY(Col, Row).Value = DeckVALUE
                Case 14 TO 26
                    MainPLAY(Col, Row).Suit = 2
                    MainPLAY(Col, Row).Value = DeckVALUE - 13
                Case 27 TO 39
                    MainPLAY(Col, Row).Suit = 3
                    MainPLAY(Col, Row).Value = DeckVALUE - 26
                Case 40 TO 52
                    MainPLAY(Col, Row).Suit = 4
                    MainPLAY(Col, Row).Value = DeckVALUE - 39
            End Select
            Value = Deck(PasteBOARD) Mod 13
            If Value = 0 Then Value = 13
            MainPLAY(Col, Row).Value = Value
            x = MainPLAY(Col, Row).x
            y = MainPLAY(Col, Row).y
            HideMOUSE
            If Row = Col Then
                MainPLAY(Col, Row).UpDOWN = 1
                PutCARD x, y, DeckVALUE
            Else
                MainPLAY(Row, Col).UpDOWN = 0
                If Point(x + 1, y - 1) = 15 Then OnTOP = 1 Else OnTOP = 0
                Put (x, y), CardBACK(), PSet
                If OnTOP Then Put (x, y), TopOFF(), PSet
            End If
            ShowMOUSE
        Next Col
    Next Row

    For Col = 1 To 3
        For Num = 1 To 8
            PasteBOARD = PasteBOARD + 1
            DeckVALUE = Deck(PasteBOARD)
            Select Case DeckVALUE
                Case 1 TO 13
                    Decks(Col, Num).Suit = 1
                    Decks(Col, Num).Value = DeckVALUE
                Case 14 TO 26
                    Decks(Col, Num).Suit = 2
                    Decks(Col, Num).Value = DeckVALUE - 13
                Case 27 TO 39
                    Decks(Col, Num).Suit = 3
                    Decks(Col, Num).Value = DeckVALUE - 26
                Case 40 TO 52
                    Decks(Col, Num).Suit = 4
                    Decks(Col, Num).Value = DeckVALUE - 39
            End Select
        Next Num
    Next Col

    Deck1 = 8: Deck2 = 8: Deck3 = 8: Deck4 = 0: CardSELECT = 0
    FCcol = 0: FCrow = 0: FCx = 0: FCy = 0: FCsuit = 0: FCvalue = 0

    Score = Score - 52: Tally = -52
    If Vegas Then SetSCORE Else Score = 0

End Sub

Sub Sol3HELP (Item)
    Shared LB

    Get (194, 80)-(446, 203), GetBOX()
    Select Case Item
        Case 1 'Introduction
            FirstPAGE = 1: LastPAGE = 5
        Case 2 'Basic Solitaire
            FirstPAGE = 6: LastPAGE = 11
        Case 3 'Game Options
            FirstPAGE = 12: LastPAGE = 15
        Case 4 'About Solitaire 3
            HideMOUSE
            Def Seg = VarSeg(OtherBOX(0))
            BLoad "sol3hp16.bsv", VarPtr(OtherBOX(0))
            Def Seg
            Put (194, 80), OtherBOX(), PSet
            ShowMOUSE
    End Select
    If Item <> 4 Then CurrentPAGE = FirstPAGE: GoSub PutHELP

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        If MouseY > 85 And MouseY < 100 Then
            Select Case MouseX
                Case 389 TO 403 'Left arrow button
                    If LB = -1 Then
                        If CurrentPAGE > FirstPAGE Then
                            CurrentPAGE = CurrentPAGE - 1
                            GoSub PutHELP
                        End If
                    End If
                Case 405 TO 419 'Right arrow button
                    If LB = -1 Then
                        If CurrentPAGE < LastPAGE Then
                            CurrentPAGE = CurrentPAGE + 1
                            GoSub PutHELP
                        End If
                    End If
                Case 423 TO 437 'Close button
                    If LB = -1 Then
                        GoSub CloseHELP
                        Exit Do
                    End If
            End Select
        End If
        ClearMOUSE
        PauseMOUSE LB, RB, MouseX, MouseY
    Loop

    Exit Sub

    CloseHELP:
    HideMOUSE
    Get (423, 86)-(437, 99), Buttons(500)
    Put (423, 86), Buttons(400), PSet
    ShowMOUSE
    Interval .1
    HideMOUSE
    Put (423, 86), Buttons(500), PSet
    Put (194, 80), GetBOX(), PSet
    ShowMOUSE
    ClearMOUSE
    Return

    DoARROWS:
    HideMOUSE
    If CurrentPAGE > FirstPAGE Then
        Paint (396, 92), 15, 14
    Else
        Paint (396, 92), 1, 14
    End If
    If CurrentPAGE < LastPAGE Then
        Paint (411, 92), 15, 14
    Else
        Paint (411, 92), 1, 14
    End If
    ShowMOUSE
    Return

    PutHELP:
    Def Seg = VarSeg(OtherBOX(0))
    FileNAME$ = "Sol3HP" + LTrim$(RTrim$(Str$(CurrentPAGE))) + ".BSV"
    BLoad FileNAME$, VarPtr(OtherBOX(0))
    Def Seg
    HideMOUSE
    Put (194, 80), OtherBOX(), PSet
    ShowMOUSE
    GoSub DoARROWS
    Return

End Sub

Sub Sol3MENU (InOUT)
    Shared LB, RB, MouseX, MouseY, Menu, Deck1, Deck2, Deck3
    Static MenuX, MenuXX, Ix, Iy, Item, Count

    If InOUT = 0 Then GoSub PutMENU: Exit Sub

    '**************************** MENU OPEN SECTION ****************************

    Select Case Menu
        Case 3 'Game menu open
            If MouseX < 10 Or MouseX > 110 Then GoSub CloseMENU: Exit Sub
            Select Case MouseY
                Case Is < 20
                    GoSub CloseMENU
                Case 20 TO 37
                    If MouseX < 12 Or MouseX > 52 Then GoSub CloseMENU
                Case 42 TO 56
                    If Item <> 1 Then
                        If Item Then GoSub PutITEM
                        Ix = 16: Iy = 42
                        GoSub GetITEM
                        Item = 1
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3DEAL
                        ClearMOUSE
                    End If
                Case 57 TO 71
                    If Item <> 2 Then
                        If Item Then GoSub PutITEM
                        Ix = 16: Iy = 57
                        GoSub GetITEM
                        Item = 2
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3UNDO
                        ClearMOUSE
                    End If
                Case 72 TO 86
                    If Item <> 3 Then
                        If Item Then GoSub PutITEM
                        Ix = 16: Iy = 72
                        GoSub GetITEM
                        Item = 3
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Def Seg = VarSeg(OtherBOX(0))
                        BLoad "sol3hp17.bsv", VarPtr(OtherBOX(0))
                        Def Seg
                        Get (194, 80)-(446, 203), GetBOX()
                        Put (194, 80), OtherBOX(), PSet
                        If Vegas = 1 Then Put (246, 137), Chek(), PSet
                        If Vegas = 0 Then Put (246, 155), Chek(), PSet
                        If Money = 1 Then Put (246, 173), Chek(), PSet

                        Do
                            MouseSTATUS LB, RB, MouseX, MouseY
                            Select Case MouseY
                                Case 86 TO 99 'close options menu
                                    If (MouseX > 422 And MouseX < 438) And LB Then
                                        HideMOUSE
                                        Get (423, 86)-(437, 99), Buttons(500)
                                        Put (423, 86), Buttons(400), PSet
                                        ShowMOUSE
                                        Interval .1
                                        HideMOUSE
                                        Put (423, 86), Buttons(500), PSet
                                        ShowMOUSE
                                        ClearMOUSE
                                        Exit Do
                                    End If
                                Case 136 TO 145 'select Vegas type scoring
                                    If (MouseX > 243 And MouseX < 260) And LB Then
                                        HideMOUSE
                                        If Vegas = 1 Then
                                            Vegas = 0: Score = 0
                                            Put (246, 155), Chek(), PSet
                                            Line (245, 137)-(258, 144), 15, BF
                                            Line (563, 18)-(639, 37), 14, BF
                                            If Money Then
                                                Line (245, 173)-(258, 180), 15, BF
                                                Money = 0
                                            End If
                                        Else
                                            Put (246, 137), Chek(), PSet
                                            Line (245, 155)-(258, 162), 15, BF
                                            Vegas = 1: Score = Tally
                                        End If
                                        ShowMOUSE
                                        ClearMOUSE
                                        NewDEAL = 1
                                    End If
                                Case 154 TO 163 'select no scoring (continuous play)
                                    If (MouseX > 243 And MouseX < 260) And LB Then
                                        HideMOUSE
                                        If Vegas = 1 Then
                                            Line (563, 18)-(639, 37), 14, BF
                                            Line (246, 137)-(258, 144), 15, BF
                                            Vegas = 0: Score = 0
                                            Put (246, 155), Chek(), PSet
                                            If Money = 1 Then
                                                Line (246, 173)-(258, 180), 15, BF
                                                Money = 0
                                            End If
                                        Else
                                            Put (246, 137), Chek(), PSet
                                            Line (245, 155)-(258, 162), 15, BF
                                            Vegas = 1: Score = Tally
                                        End If
                                        ShowMOUSE
                                        ClearMOUSE
                                        NewDEAL = 1
                                    End If
                                Case 172 TO 181 'money card
                                    If (MouseX > 243 And MouseX < 260) And LB Then
                                        HideMOUSE
                                        If Money = 1 Then
                                            Line (245, 173)-(258, 180), 15, BF
                                            Money = 0
                                        Else
                                            Put (246, 173), Chek(), PSet
                                            Money = 1
                                            If Vegas = 0 Then
                                                Put (246, 137), Chek(), PSet
                                                Line (245, 155)-(258, 162), 15, BF
                                                Vegas = 1: Score = Tally
                                            End If
                                        End If
                                        ShowMOUSE
                                        ClearMOUSE
                                        NewDEAL = 1
                                    End If
                            End Select
                            PauseMOUSE LB, RB, MouseX, MouseY
                        Loop
                        Open "sol3opts.dat" For Output As #1
                        Write #1, Vegas, Money
                        Close #1
                        HideMOUSE
                        Put (194, 80), GetBOX(), PSet
                        ShowMOUSE
                        If NewDEAL Then
                            Score = 0
                            HideMOUSE
                            Sol3DEAL
                            If Vegas Then SetSCORE
                            ShowMOUSE
                            ClearMOUSE
                            Exit Sub
                        End If
                        ClearMOUSE
                    End If
                Case 92 TO 106
                    If Item <> 4 Then
                        If Item Then GoSub PutITEM
                        Ix = 16: Iy = 92
                        GoSub GetITEM
                        Item = 4
                    End If
                    If LB Then
                        GoSub CloseMENU
                        System
                    End If
                Case Is > 106
                    GoSub CloseMENU
                Case Else
            End Select
            Exit Sub
        Case 4 'Help menu open
            If MouseX < 63 Or MouseX > 163 Then GoSub CloseMENU: Exit Sub
            Select Case MouseY
                Case Is < 20
                    GoSub CloseMENU
                Case 20 TO 37
                    If MouseX < 63 Or MouseX > 103 Then GoSub CloseMENU
                Case 42 TO 56
                    If Item <> 1 Then
                        If Item Then GoSub PutITEM
                        Ix = 66: Iy = 42
                        GoSub GetITEM
                        Item = 1
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3HELP 1
                        ClearMOUSE
                    End If
                Case 57 TO 71
                    If Item <> 2 Then
                        If Item Then GoSub PutITEM
                        Ix = 66: Iy = 57
                        GoSub GetITEM
                        Item = 2
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3HELP 2
                        ClearMOUSE
                    End If
                Case 72 TO 86
                    If Item <> 3 Then
                        If Item Then GoSub PutITEM
                        Ix = 66: Iy = 72
                        GoSub GetITEM
                        Item = 3
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3HELP 3
                        ClearMOUSE
                    End If
                Case 92 TO 106
                    If Item <> 4 Then
                        If Item Then GoSub PutITEM
                        Ix = 66: Iy = 92
                        GoSub GetITEM
                        Item = 4
                    End If
                    If LB Then
                        GoSub CloseMENU
                        Sol3HELP 4
                        ClearMOUSE
                    End If
                Case Is > 106
                    GoSub CloseMENU
                Case Else
            End Select
            Exit Sub
    End Select

    '*************************** MENU CLOSED SECTION ****************************

    Select Case MouseX
        Case Is < 12
            If Menu Then GoSub PutMENU
        Case 12 TO 52
            If Menu <> 1 Then '-------------------- Game selected
                HideMOUSE
                If Menu Then GoSub PutMENU
                MenuX = 12
                GoSub GetMENU
                Line (12, 20)-(52, 36), 15, B
                Line (12, 36)-(52, 36), 0
                Line (52, 20)-(52, 36), 0
                Put (20, 24), MenuGFX(200), PSet
                ShowMOUSE
                Menu = 1
            End If
            If Menu = 1 And LB Then '-------------- Game opens
                HideMOUSE
                Line (12, 20)-(52, 36), 14, BF
                Line (12, 20)-(52, 36), 15, B
                Line (12, 20)-(12, 36), 0
                Line (12, 20)-(52, 20), 0
                Put (21, 24), MenuGFX(), PSet
                Get (12, 37)-(112, 110), GetBOX()
                MenuXX = 12
                Def Seg = VarSeg(OtherBOX(0))
                BLoad "sol3men2.bsv", VarPtr(OtherBOX(0))
                Def Seg
                Put (12, 37), OtherBOX(), PSet
                Menu = 3
                ShowMOUSE
            End If
        Case 53 TO 62
            If Menu Then GoSub PutMENU
        Case 63 TO 103
            If Menu <> 2 Then '------------------ Help selected
                HideMOUSE
                If Menu Then GoSub PutMENU
                MenuX = 63
                GoSub GetMENU
                Line (63, 20)-(103, 36), 15, B
                Line (63, 36)-(103, 36), 0
                Line (103, 20)-(103, 36), 0
                Put (73, 24), MenuGFX(300), PSet
                ShowMOUSE
                Menu = 2
            End If
            If Menu = 2 And LB Then '-------------- Help opens
                HideMOUSE
                Line (63, 20)-(103, 36), 14, BF
                Line (63, 20)-(103, 36), 15, B
                Line (63, 20)-(63, 36), 0
                Line (63, 20)-(103, 20), 0
                Put (74, 24), MenuGFX(100), PSet
                Get (63, 37)-(163, 110), GetBOX()
                Def Seg = VarSeg(OtherBOX(0))
                BLoad "sol3men3.bsv", VarPtr(OtherBOX(0))
                Def Seg
                Put (63, 37), OtherBOX(), PSet
                MenuXX = 63: Menu = 4
                ShowMOUSE
            End If
    End Select

    Exit Sub

    GetITEM:
    HideMOUSE
    Get (Ix, Iy)-(Ix + 92, Iy + 15), ItemBOX()
    Put (Ix, Iy), ItemBOX(), PReset
    ShowMOUSE
    Return

    PutITEM:
    HideMOUSE
    If ItemBOX(1) Then Put (Ix, Iy), ItemBOX(), PSet
    ShowMOUSE
    Item = 0
    Return

    GetMENU:
    HideMOUSE
    Get (MenuX, 20)-(MenuX + 40, 36), MenuBOX()
    ShowMOUSE
    Return

    PutMENU:
    HideMOUSE
    Put (MenuX, 20), MenuBOX(), PSet
    ShowMOUSE
    Menu = 0
    Return

    CloseMENU:
    HideMOUSE
    Put (MenuXX, 37), GetBOX(), PSet
    Put (MenuX, 20), MenuBOX(), PSet
    ShowMOUSE
    Menu = 0: Item = 0
    Return
    'LINE (16, 42)-(108, 56), 4, B
    'LINE (16, 57)-(108, 71), 4, B
    'LINE (16, 72)-(108, 86), 4, B
    'LINE (16, 92)-(108, 106), 4, B

End Sub

Sub Sol3UNDO
    Shared Deck1, Deck2, Deck3, Deck4, LastDECK

    HideMOUSE
    If Deck4 > 0 Then
        If LastDECK Then
            LastSUIT = TurnUPs(Deck4).Suit
            LastVALUE = TurnUPs(Deck4).Value
            Select Case LastDECK
                Case 1
                    Deck1 = Deck1 + 1
                    Decks(1, Deck1).Suit = LastSUIT
                    Decks(1, Deck1).Value = LastVALUE
                    Put (5, 43), CardBACK(), PSet
                Case 2
                    Deck2 = Deck2 + 1
                    Decks(2, Deck2).Suit = LastSUIT
                    Decks(2, Deck2).Value = LastVALUE
                    Put (83, 43), CardBACK(), PSet
                Case 3
                    Deck3 = Deck3 + 1
                    Decks(3, Deck3).Suit = LastSUIT
                    Decks(3, Deck3).Value = LastVALUE
                    Put (161, 43), CardBACK(), PSet
            End Select
            Deck4 = Deck4 - 1
            LastSUIT = TurnUPs(Deck4).Suit
            LastVALUE = TurnUPs(Deck4).Value
            If Deck4 = 0 Then
                Line (239, 43)-(313, 152), 11, BF
            Else
                CardNUM = (LastSUIT - 1) * 13 + LastVALUE
                PutCARD 239, 43, CardNUM
            End If
        End If
    End If
    LastDECK = 0
    ShowMOUSE

End Sub
