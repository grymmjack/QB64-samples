'CHDIR ".\samples\thebob\chopper"

'                                                                  같       '
'                     같                                          같�       '
'            같같같 같�                                           같�       '
'           같같같� 같�                                           같�       '
'          같�  같  같�               같     같                   같�       '
'         같�   같  같  같       같 같같   같같      같�    같 같 같        '
'       같같        같 같�   같같같 같같   같같    같같   같같같� 같        '
'       같같       같 같같  같� 같같같같� 같같같  같 같   같같같  같        '
'       께�        께께께�  께  께 께께께께께께께 께께�   께께    께        '
'        께   께� 께� 께� 께�  께  께 께� 께 께께께께 께께께     께         '
'        께  께�  께�  께  께� 께  께� 께 께� 께 께� 께 께께     께�        '
'        께께께   께   께  께께�   께께�  께께�  께께께   께     께께       '
'                      께          께께   께께                    께        '
'                                  께     께                                '
'                                 께�    께�                                '
'                                 께     께                                 '
'                                                                           '
'         CHOPPER.BAS - Copyright (C) 2005 by Bob Seguin (Freeware)         '
'                                                                           '
'***************************************************************************'

DefInt A-Z

DECLARE FUNCTION InitMOUSE ()
DECLARE FUNCTION Seeker (x, y, Mode)

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)

DECLARE SUB PrintSTRING (x, y, Prnt$)

DECLARE SUB SetPALETTE ()
DECLARE SUB FourBIT (x1, y1, x2, y2, FileNAME$)
DECLARE SUB LoadIMAGE (x, y, FileNAME$)
DECLARE SUB LoadFILE (FileNAME$)
DECLARE SUB LoadBSI (x, y, FileNAME$)
DECLARE SUB ClearBOX ()

DECLARE SUB Interval (Length!)
DECLARE SUB ChopperIDE ()
DECLARE SUB Tire (x, y, Outer, Inner)
DECLARE SUB Tread (x, y, Radius, StartDEG, StopDEG, Colr)
DECLARE SUB ProjectMENU ()
DECLARE SUB HelpMENU ()
DECLARE SUB HiLIGHT ()
DECLARE SUB DeLIGHT ()
DECLARE SUB MenuBAR (InOUT)
DECLARE SUB LoadPHASE ()
DECLARE SUB Assembly1 ()
DECLARE SUB Assembly2 ()
DECLARE SUB Assembly3 ()
DECLARE SUB HandleBARS (InOUT)
DECLARE SUB PaintSHOP (Mode)

'----------------------------------------------------------------------------
'$DYNAMIC

Dim Shared Box(26000)
Dim Shared MenuBOX(500)
Dim Shared MenuBOX2(500)
Dim Shared MenuBOX3(4000)
Dim Shared CustomCOLORS(9, 20)
Dim Shared FChar(1 To 124)

Dim Shared MouseDATA$
Dim Shared LB, RB, MouseX, MouseY
Dim Shared Menu, TopMENU, Phase, Item, BarBOX, PaintITEM
Dim Shared BikeCOLOR, FlameSTYLE, MenuITEM

Const Degree! = 3.14159 / 180

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

Def Seg = VarSeg(CustomCOLORS(0, 0))
BLoad "chcolors.bsv", VarPtr(CustomCOLORS(0, 0))
Def Seg

Screen 12

BikeCOLOR = 3
FlameSTYLE = 1
SetPALETTE

ChopperIDE
LocateMOUSE 319, 120
ShowMOUSE

Do
    MouseSTATUS LB, RB, MouseX, MouseY

    Select Case MenuITEM
        Case 1: ProjectMENU
        Case 2: HelpMENU
    End Select

    Select Case MouseY
        Case 32 TO 46: MenuBAR 1
        Case 294 TO 479
            Select Case Phase
                Case Is < 8: Assembly1
                Case 8 TO 20: Assembly2
                Case 21: HandleBARS 1
                Case 22 TO 24: Assembly3
                Case 25: PaintSHOP 1
            End Select
        Case Else
            If TopMENU Then MenuBAR 0
            If Item Then DeLIGHT
            If BarBOX Then HandleBARS 0
            If PaintITEM Then PaintSHOP 0
    End Select

    If Splash = 0 And MouseY < 60 Then
        Line (146, 154)-(493, 356), 0, BF
        Line (146, 288)-(493, 293), 1, BF
        Line (146, 288)-(493, 288), 2, BF
        Line (146, 293)-(493, 293), 5, BF
        Line (146, 252)-(493, 280), 2, BF
        SetPALETTE
        Splash = 1
    End If

    ClearMOUSE
    LoadPHASE
Loop

End '************************** PALETTE DATA ********************************

PaletteDATA:
Data 4,2,12,6,4,14,12,12,20
Data 31,31,38,46,46,50,0,0,0

CustomCOLORS:
Data 6,7,8,10,12,13,14

FlameCOLOR:
Data 63,63,63,63,32,12,63,52,0
SilverCOLOR:
Data 63,63,63,38,38,35,53,53,48
GoldCOLOR:
Data 63,63,42,63,42,21,63,52,32
WhiteCOLOR:
Data 63,63,63,48,48,53,53,53,58

Rem $STATIC
Sub Assembly1
    Shared ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR
    Shared ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
    Shared OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY

    Select Case Phase
        Case 1
            Select Case MouseX
                Case 116 TO 310
                    If Item <> 1 Then
                        DeLIGHT
                        ItemX = 156: ItemY = 452
                        HiLIGHT
                        Item = 1
                    End If
                Case 330 TO 523
                    If Item <> 2 Then
                        DeLIGHT
                        ItemX = 390: ItemY = 452
                        HiLIGHT
                        Item = 2
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 2
            Select Case MouseX
                Case 20 TO 234
                    If Item <> 3 Then
                        DeLIGHT
                        ItemX = 90: ItemY = 430
                        HiLIGHT
                        Item = 3
                    End If
                Case 255 TO 384
                    If Item <> 4 Then
                        DeLIGHT
                        ItemX = 271: ItemY = 430
                        HiLIGHT
                        Item = 4
                    End If
                Case 405 TO 560
                    If Item <> 5 Then
                        DeLIGHT
                        ItemX = 431: ItemY = 430
                        HiLIGHT
                        Item = 5
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 3
            Select Case MouseX
                Case 110 TO 240
                    If Item <> 6 Then
                        DeLIGHT
                        ItemX = 112: ItemY = 440
                        HiLIGHT
                        Item = 6
                    End If
                Case 260 TO 390
                    If Item <> 7 Then
                        DeLIGHT
                        ItemX = 270: ItemY = 440
                        HiLIGHT
                        Item = 7
                    End If
                Case 410 TO 540
                    If Item <> 8 Then
                        DeLIGHT
                        ItemX = 420: ItemY = 440
                        HiLIGHT
                        Item = 8
                    End If
            End Select
        Case 4
            If Extension = 1 Or Extension = 2 Then
                Select Case MouseX
                    Case 40 TO 150
                        If Item <> 9 Then
                            DeLIGHT
                            ItemX = 40: ItemY = 445
                            HiLIGHT
                            Item = 9
                        End If
                    Case 170 TO 280
                        If Item <> 10 Then
                            DeLIGHT
                            ItemX = 180: ItemY = 445
                            HiLIGHT
                            Item = 10
                        End If
                    Case 340 TO 450
                        If Item <> 11 Then
                            DeLIGHT
                            ItemX = 330: ItemY = 445
                            HiLIGHT
                            Item = 11
                        End If
                    Case 470 TO 600
                        If Item <> 12 Then
                            DeLIGHT
                            ItemX = 470: ItemY = 445
                            HiLIGHT
                            Item = 12
                        End If
                    Case Else
                        DeLIGHT
                End Select
            Else
                Select Case MouseX
                    Case 20 TO 138
                        If Item <> 13 Then
                            DeLIGHT
                            ItemX = 12: ItemY = 445
                            HiLIGHT
                            Item = 13
                        End If
                    Case 139 TO 232
                        If Item <> 14 Then
                            DeLIGHT
                            ItemX = 140: ItemY = 445
                            HiLIGHT
                            Item = 14
                        End If
                    Case 264 TO 386
                        If Item <> 15 Then
                            DeLIGHT
                            ItemX = 250: ItemY = 445
                            HiLIGHT
                            Item = 15
                        End If
                    Case 387 TO 490
                        If Item <> 16 Then
                            DeLIGHT
                            ItemX = 372: ItemY = 445
                            HiLIGHT
                            Item = 16
                        End If
                    Case 491 TO 600
                        If Item <> 17 Then
                            DeLIGHT
                            ItemX = 490: ItemY = 445
                            HiLIGHT
                            Item = 17
                        End If
                    Case Else
                        DeLIGHT
                End Select
            End If
        Case 5
            Select Case MouseX
                Case 80 TO 198
                    If Item <> 18 Then
                        DeLIGHT
                        ItemX = 70: ItemY = 440
                        HiLIGHT
                        Item = 18
                    End If
                Case 199 TO 318
                    If Item <> 19 Then
                        DeLIGHT
                        ItemX = 190: ItemY = 440
                        HiLIGHT
                        Item = 19
                    End If
                Case 319 TO 438
                    If Item <> 20 Then
                        DeLIGHT
                        ItemX = 320: ItemY = 440
                        HiLIGHT
                        Item = 20
                    End If
                Case 439 TO 560
                    If Item <> 21 Then
                        DeLIGHT
                        ItemX = 440: ItemY = 440
                        HiLIGHT
                        Item = 21
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 6
            Select Case MouseX
                Case 80 TO 198
                    If Item <> 22 Then
                        DeLIGHT
                        ItemX = 70: ItemY = 440
                        HiLIGHT
                        Item = 22
                    End If
                Case 199 TO 318
                    If Item <> 23 Then
                        DeLIGHT
                        ItemX = 190: ItemY = 440
                        HiLIGHT
                        Item = 23
                    End If
                Case 319 TO 438
                    If Item <> 24 Then
                        DeLIGHT
                        ItemX = 320: ItemY = 440
                        HiLIGHT
                        Item = 24
                    End If
                Case 439 TO 560
                    If Item <> 25 Then
                        DeLIGHT
                        ItemX = 440: ItemY = 440
                        HiLIGHT
                        Item = 25
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 7
            Select Case MouseX
                Case 70 TO 169
                    If Item <> 26 Then
                        DeLIGHT
                        ItemX = 50: ItemY = 442
                        HiLIGHT
                        Item = 26
                    End If
                Case 170 TO 269
                    If Item <> 27 Then
                        DeLIGHT
                        ItemX = 150: ItemY = 442
                        HiLIGHT
                        Item = 27
                    End If
                Case 270 TO 369
                    If Item <> 28 Then
                        DeLIGHT
                        ItemX = 250: ItemY = 442
                        HiLIGHT
                        Item = 28
                    End If
                Case 370 TO 469
                    If Item <> 29 Then
                        DeLIGHT
                        ItemX = 350: ItemY = 442
                        HiLIGHT
                        Item = 29
                    End If
                Case 470 TO 569
                    If Item <> 30 Then
                        DeLIGHT
                        ItemX = 450: ItemY = 442
                        HiLIGHT
                        Item = 30
                    End If
                Case Else
                    DeLIGHT
            End Select
    End Select

    If LB = -1 And Item <> 0 Then
        Select Case Item
            Case 1, 2
                Frame = Item
                DeLIGHT
                Phase = 2
            Case 3, 4, 5
                FrameCOLOR = Item - 2
                DeLIGHT
                Phase = 3
            Case 6, 7, 8
                Extension = Item - 5
                DeLIGHT
                GoSub SetFRAME
                DeLIGHT
            Case 9 TO 17
                GoSub SetFORK
            Case 18 TO 21
                GoSub SetTIREF
                Phase = 6
            Case 22 TO 25
                GoSub SetTIRER
                Phase = 7
            Case 26 TO 30
                GoSub SetWHEELS
                Phase = 8
        End Select
    End If

    Exit Sub

    '************************* SUBROUTINE SECTION BEGINS ************************

    SetFRAME:
    HideMOUSE
    Select Case Frame
        Case 1
            Select Case Extension
                Case 1
                    If FrameCOLOR = 1 Then LoadIMAGE 255, 130, "CHFrmRP": LoadFILE "CHNkRP"
                    If FrameCOLOR = 2 Then LoadIMAGE 255, 130, "CHFrmRB": LoadFILE "CHNkRB"
                    If FrameCOLOR = 3 Then LoadIMAGE 255, 130, "CHFrmRC": LoadFILE "CHNkRC"
                    FrameX = 245: FrameY = 115
                    Put (247, 125), Box(), And
                    Put (247, 125), Box(150)
                    Circle (270, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR40 D R40 D L40"
                    PSet (316, 258), 5: Draw "R120 F L121"
                    PSet (316, 266), 5: Draw "R126 F L127"
                    Line (310, 258)-(318, 262), 5, BF
                    Line (311, 263)-(319, 267), 5, BF
                    Line (380, 258)-(388, 262), 5, BF
                    Line (382, 263)-(390, 267), 5, BF
                Case 2
                    If FrameCOLOR = 1 Then LoadIMAGE 261, 130, "CHFrmRP": LoadFILE "CHNkXP"
                    If FrameCOLOR = 2 Then LoadIMAGE 261, 130, "CHFrmRB": LoadFILE "CHNkXB"
                    If FrameCOLOR = 3 Then LoadIMAGE 261, 130, "CHFrmRC": LoadFILE "CHNkXC"
                    FrameX = 251: FrameY = 115
                    Put (252, 124), Box(), And
                    Put (252, 124), Box(150)
                    Circle (270, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR47 D R47 D L47"
                    PSet (324, 258), 5: Draw "R120 F L121"
                    PSet (324, 266), 5: Draw "R126 F L127"
                    Line (316, 258)-(324, 262), 5, BF
                    Line (318, 263)-(326, 267), 5, BF
                    Line (386, 258)-(394, 262), 5, BF
                    Line (389, 263)-(396, 267), 5, BF
                Case 3
                    If FrameCOLOR = 1 Then LoadIMAGE 275, 130, "CHFrmRP": LoadFILE "CHNkXXP"
                    If FrameCOLOR = 2 Then LoadIMAGE 275, 130, "CHFrmRB": LoadFILE "CHNkXXB"
                    If FrameCOLOR = 3 Then LoadIMAGE 275, 130, "CHFrmRC": LoadFILE "CHNkXXC"
                    FrameX = 265: FrameY = 115
                    Put (267, 125), Box(), And
                    Put (267, 125), Box(150)
                    Circle (270, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR65 D R65 D L65"
                    PSet (339, 258), 5: Draw "R120 F L121"
                    PSet (339, 266), 5: Draw "R126 F L127"
                    Line (331, 258)-(339, 262), 5, BF
                    Line (333, 263)-(341, 267), 5, BF
                    Line (401, 258)-(409, 262), 5, BF
                    Line (404, 263)-(411, 267), 5, BF
            End Select
        Case 2
            Select Case Extension
                Case 1
                    If FrameCOLOR = 1 Then LoadIMAGE 250, 126, "CHFrmXP": LoadFILE "CHNkRP"
                    If FrameCOLOR = 2 Then LoadIMAGE 250, 126, "CHFrmXB": LoadFILE "CHNkRB"
                    If FrameCOLOR = 3 Then LoadIMAGE 250, 126, "CHFrmXC": LoadFILE "CHNkRC"
                    FrameX = 250: FrameY = 126: DropSHADOW = 0
                    Put (245, 124), Box(), And
                    Put (245, 124), Box(150)
                    Circle (270, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR50 D R50 D L50"
                    PSet (324, 258), 5: Draw "R130 F L131"
                    PSet (324, 266), 5: Draw "R136 F L137"
                    Line (316, 258)-(324, 262), 5, BF
                    Line (317, 263)-(325, 267), 5, BF
                    Line (360, 258)-(396, 262), 5, BF
                    Line (362, 263)-(398, 267), 5, BF
                Case 2
                    If FrameCOLOR = 1 Then LoadIMAGE 256, 126, "CHFrmXP": LoadFILE "CHNkXP"
                    If FrameCOLOR = 2 Then LoadIMAGE 256, 126, "CHFrmXB": LoadFILE "CHNkXB"
                    If FrameCOLOR = 3 Then LoadIMAGE 256, 126, "CHFrmXC": LoadFILE "CHNkXC"
                    FrameX = 256: FrameY = 126: DropSHADOW = 0
                    Put (251, 124), Box(), And
                    Put (251, 124), Box(150)
                    Circle (276, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR50 D R50 D L50"
                    PSet (328, 258), 5: Draw "R130 F L131"
                    PSet (328, 266), 5: Draw "R136 F L137"
                    Line (324, 258)-(332, 262), 5, BF
                    Line (325, 263)-(333, 267), 5, BF
                    Line (368, 258)-(404, 262), 5, BF
                    Line (370, 263)-(406, 267), 5, BF
                Case 3
                    If FrameCOLOR = 1 Then LoadIMAGE 270, 126, "CHFrmXP": LoadFILE "CHNkXXP"
                    If FrameCOLOR = 2 Then LoadIMAGE 270, 126, "CHFrmXB": LoadFILE "CHNkXXB"
                    If FrameCOLOR = 3 Then LoadIMAGE 270, 126, "CHFrmXC": LoadFILE "CHNkXXC"
                    FrameX = 270: FrameY = 126: DropSHADOW = 0
                    Put (265, 126), Box(), And
                    Put (265, 126), Box(150)
                    Circle (278, 262), 6, 5, , , .3
                    Paint Step(0, 0), 5
                    Draw "U nR58 D R58 D L58"
                    PSet (338, 258), 5: Draw "R130 F L131"
                    PSet (338, 266), 5: Draw "R138 F L139"
                    Line (333, 258)-(341, 262), 5, BF
                    Line (335, 263)-(343, 267), 5, BF
                    Line (380, 258)-(416, 262), 5, BF
                    Line (383, 263)-(419, 267), 5, BF
            End Select
    End Select
    ShowMOUSE
    Phase = 4
    Return

    SetFORK:
    If Frame = 1 Then
        Select Case Extension
            Case 1
                Select Case Item
                    Case 9: LoadFILE "CHSprRP.BSI": ForkX = 194: ForkY = 108
                    Case 10: LoadFILE "CHSprRC.BSI": ForkX = 194: ForkY = 108
                    Case 11: LoadFILE "CHFrkGRP.BSI": ForkX = 203: ForkY = 114
                    Case 12: LoadFILE "CHFrkGRC.BSI": ForkX = 203: ForkY = 114
                End Select
            Case 2
                Select Case Item
                    Case 9: LoadFILE "CHSprXP.BSI": ForkX = 184: ForkY = 108
                    Case 10: LoadFILE "CHSprXC.BSI": ForkX = 184: ForkY = 108
                    Case 11: LoadFILE "CHFrkGXP.BSI": ForkX = 193: ForkY = 113
                    Case 12: LoadFILE "CHFrkGXC.BSI": ForkX = 193: ForkY = 113
                End Select
            Case 3
                Select Case Item
                    Case 13: LoadFILE "CHSprXXP.BSI": ForkX = 176: ForkY = 113
                    Case 14: LoadFILE "CHSprXXC.BSI": ForkX = 176: ForkY = 113
                    Case 15: LoadFILE "CHFrkXXP.BSI": ForkX = 183: ForkY = 116
                    Case 16: LoadFILE "CHFrkXXM.BSI": ForkX = 183: ForkY = 116
                    Case 17: LoadFILE "CHFrkXXC.BSI": ForkX = 183: ForkY = 116
                End Select
        End Select
    Else
        Select Case Extension
            Case 1
                Select Case Item
                    Case 9: LoadFILE "CHSprRP.BSI": ForkX = 192: ForkY = 108
                    Case 10: LoadFILE "CHSprRC.BSI": ForkX = 192: ForkY = 108
                    Case 11: LoadFILE "CHFrkGRP.BSI": ForkX = 203: ForkY = 114
                    Case 12: LoadFILE "CHFrkGRC.BSI": ForkX = 203: ForkY = 114
                End Select
            Case 2
                Select Case Item
                    Case 9: LoadFILE "CHSprXP.BSI": ForkX = 182: ForkY = 108
                    Case 10: LoadFILE "CHSprXC.BSI": ForkX = 182: ForkY = 108
                    Case 11: LoadFILE "CHFrkGXP.BSI": ForkX = 190: ForkY = 113
                    Case 12: LoadFILE "CHFrkGXC.BSI": ForkX = 190: ForkY = 113
                End Select
            Case 3
                Select Case Item
                    Case 13: LoadFILE "CHSprXXP.BSI": ForkX = 175: ForkY = 113
                    Case 14: LoadFILE "CHSprXXC.BSI": ForkX = 175: ForkY = 113
                    Case 15: LoadFILE "CHFrkXXP.BSI": ForkX = 181: ForkY = 116
                    Case 16: LoadFILE "CHFrkXXM.BSI": ForkX = 181: ForkY = 116
                    Case 17: LoadFILE "CHFrkXXC.BSI": ForkX = 181: ForkY = 116
                End Select
        End Select
    End If
    HideMOUSE
    Put (ForkX + Box(0), ForkY + Box(1)), Box(3), And
    Put (ForkX, ForkY), Box(Box(2))
    PSet (ForkX + 12, 258), 5
    Select Case Extension
        Case 1
            Draw "R78 d9 L84 E R82 u7 L76 R64"
            Line Step(-10, 0)-Step(24, 7), 5, BF
        Case 2
            Draw "R88 d9 L94 E R92 u7 L86 R74"
            Line Step(-10, 0)-Step(24, 7), 5, BF
        Case 3
            Draw "R98 d9 L104 E R102 u7 L96 R84"
            Line Step(-10, 0)-Step(24, 7), 5, BF
    End Select
    DeLIGHT
    ShowMOUSE
    Phase = 5
    For x = 254 To 300
        For y = 110 To 130
            If Point(x, y) = 11 Then
                BarX = x: BarY = y
                Return
            End If
        Next y
    Next x
    Return

    SetTIREF:
    HideMOUSE
    Select Case ForkX
        Case 176: WheelFX = 179: WheelFY = 217
        Case 183: WheelFX = 188: WheelFY = 217
        Case 184: WheelFX = 188: WheelFY = 217
        Case 175: WheelFX = 178: WheelFY = 217 '
        Case 181: WheelFX = 186: WheelFY = 217 '
        Case 182: WheelFX = 186: WheelFY = 217 '
        Case 193: WheelFX = 199: WheelFY = 217
        Case 194: WheelFX = 197: WheelFY = 217
        Case 190: WheelFX = 196: WheelFY = 217 '
        Case 192: WheelFX = 195: WheelFY = 217 '
        Case 203: WheelFX = 208: WheelFY = 217
        Case 203: WheelFX = 208: WheelFY = 217 '
    End Select
    Select Case Item
        Case 18: InnerRADIUS = 38: FrontINDEX = 0
        Case 19: InnerRADIUS = 35: FrontINDEX = 1800
        Case 20: InnerRADIUS = 33: FrontINDEX = 3600
        Case 21: InnerRADIUS = 30: FrontINDEX = 5400
    End Select
    Tire WheelFX - 100, WheelFY - 100, 48, InnerRADIUS
    ShowMOUSE
    DeLIGHT
    Return

    SetTIRER:
    HideMOUSE
    If Frame = 1 Then
        Select Case Extension
            Case 1: WheelRX = 435: WheelRY = 217
            Case 2: WheelRX = 441: WheelRY = 217
            Case 3: WheelRX = 455: WheelRY = 217
        End Select
        OuterRADIUS = 48
        Select Case Item
            Case 22: InnerRADIUS = 33: RearINDEX = 3600
            Case 23: InnerRADIUS = 30: RearINDEX = 5400
            Case 24: InnerRADIUS = 27: RearINDEX = 7200
            Case 25: InnerRADIUS = 24: RearINDEX = 9000
        End Select
    Else
        Select Case Extension
            Case 1: WheelRX = 440: WheelRY = 223
            Case 2: WheelRX = 446: WheelRY = 223
            Case 3: WheelRX = 460: WheelRY = 223
        End Select
        OuterRADIUS = 42
        Select Case Item
            Case 22: InnerRADIUS = 27: RearINDEX = 10800
            Case 23: InnerRADIUS = 25: RearINDEX = 12600
            Case 24: InnerRADIUS = 23: RearINDEX = 14400
            Case 25: InnerRADIUS = 21: RearINDEX = 16200
        End Select
    End If
    Tire WheelRX + 100, WheelRY - 100, OuterRADIUS, InnerRADIUS
    DeLIGHT
    ShowMOUSE
    Return

    SetWHEELS:
    Select Case Item
        Case 26: File$ = "CHSpokes"
        Case 27: File$ = "CHMag1"
        Case 28: File$ = "CHMag2"
        Case 29: File$ = "CHMag3"
        Case 30: File$ = "CHMag4"
    End Select
    LoadFILE File$
    HideMOUSE
    Put (WheelFX - 140, WheelFY - 140), Box(FrontINDEX), PSet
    Put (WheelRX + 60, WheelRY - 140), Box(RearINDEX), PSet
    DeLIGHT
    ShowMOUSE
    Return

End Sub

Sub Assembly2
    Shared ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR, Cover, Tank
    Shared ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
    Shared OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY
    Shared MotorSTYLE, HighMEG, HighPIPE, OT, LightX, LightY, FenderSTYLE
    Shared FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, GPaint, TX, TY, TTY

    Select Case Phase
        Case 8
            Select Case MouseX
                Case 95 TO 225
                    If Item <> 31 Then
                        DeLIGHT
                        ItemX = 95: ItemY = 445
                        HiLIGHT
                        Item = 31
                    End If
                Case 255 TO 385
                    If Item <> 32 Then
                        DeLIGHT
                        ItemX = 255: ItemY = 445
                        HiLIGHT
                        Item = 32
                    End If
                Case 415 TO 545
                    If Item <> 33 Then
                        DeLIGHT
                        ItemX = 415: ItemY = 445
                        HiLIGHT
                        Item = 33
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 9
            Select Case MouseX
                Case 135 TO 235
                    If Item <> 34 Then
                        DeLIGHT
                        ItemX = 110: ItemY = 420
                        HiLIGHT
                        Item = 34
                    End If
                Case 268 TO 368
                    If Item <> 35 Then
                        DeLIGHT
                        ItemX = 246: ItemY = 420
                        HiLIGHT
                        Item = 35
                    End If
                Case 400 TO 500
                    If Item <> 36 Then
                        DeLIGHT
                        ItemX = 382: ItemY = 420
                        HiLIGHT
                        Item = 36
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 10
            Select Case MouseX
                Case 124 TO 234
                    If Item <> 37 Then
                        DeLIGHT
                        ItemX = 114: ItemY = 424
                        HiLIGHT
                        Item = 37
                    End If
                Case 278 TO 358
                    If Item <> 38 Then
                        DeLIGHT
                        ItemX = 268: ItemY = 424
                        HiLIGHT
                        Item = 38
                    End If
                Case 406 TO 516
                    If Item <> 39 Then
                        DeLIGHT
                        ItemX = 396: ItemY = 424
                        HiLIGHT
                        Item = 39
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 11
            Select Case MouseX
                Case 120 TO 219
                    If Item <> 40 Then
                        DeLIGHT
                        ItemX = 100: ItemY = 398
                        HiLIGHT
                        Item = 40
                    End If
                Case 220 TO 319
                    If Item <> 41 Then
                        DeLIGHT
                        ItemX = 210: ItemY = 398
                        HiLIGHT
                        Item = 41
                    End If
                Case 320 TO 419
                    If Item <> 42 Then
                        DeLIGHT
                        ItemX = 310: ItemY = 398
                        HiLIGHT
                        Item = 42
                    End If
                Case 420 TO 519
                    If Item <> 43 Then
                        DeLIGHT
                        ItemX = 420: ItemY = 398
                        HiLIGHT
                        Item = 43
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 12
            Select Case MouseX
                Case 120 TO 219
                    If Item <> 44 Then
                        DeLIGHT
                        ItemX = 100: ItemY = 398
                        HiLIGHT
                        Item = 44
                    End If
                Case 220 TO 319
                    If Item <> 45 Then
                        DeLIGHT
                        ItemX = 200: ItemY = 398
                        HiLIGHT
                        Item = 45
                    End If
                Case 320 TO 419
                    If Item <> 46 Then
                        DeLIGHT
                        ItemX = 300: ItemY = 398
                        HiLIGHT
                        Item = 46
                    End If
                Case 420 TO 519
                    If Item <> 146 Then
                        DeLIGHT
                        ItemX = 400: ItemY = 398
                        HiLIGHT
                        Item = 146
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 13
            Select Case MouseX
                Case 110 TO 219
                    If Item <> 47 Then
                        DeLIGHT
                        ItemX = 100: ItemY = 390
                        HiLIGHT
                        Item = 47
                    End If
                Case 220 TO 329
                    If Item <> 48 Then
                        DeLIGHT
                        ItemX = 220: ItemY = 390
                        HiLIGHT
                        Item = 48
                    End If
                Case 330 TO 439
                    If Item <> 49 Then
                        DeLIGHT
                        ItemX = 330: ItemY = 390
                        HiLIGHT
                        Item = 49
                    End If
                Case 440 TO 549
                    If Item <> 50 Then
                        DeLIGHT
                        ItemX = 430: ItemY = 390
                        HiLIGHT
                        Item = 50
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 14
            Select Case MouseX
                Case 178 TO 308
                    If Item <> 51 Then
                        DeLIGHT
                        ItemX = 178: ItemY = 408
                        HiLIGHT
                        Item = 51
                    End If
                Case 338 TO 468
                    If Item <> 52 Then
                        DeLIGHT
                        ItemX = 338: ItemY = 408
                        HiLIGHT
                        Item = 52
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 15
            Select Case MouseX
                Case 90 TO 220
                    If Item <> 53 Then
                        DeLIGHT
                        ItemX = 90: ItemY = 411
                        HiLIGHT
                        Item = 53
                    End If
                Case 250 TO 380
                    If Item <> 54 Then
                        DeLIGHT
                        ItemX = 250: ItemY = 411
                        HiLIGHT
                        Item = 54
                    End If
                Case 412 TO 542
                    If Item <> 55 Then
                        DeLIGHT
                        ItemX = 412: ItemY = 411
                        HiLIGHT
                        Item = 55
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 16
            Select Case MouseX
                Case 40 TO 223
                    If Item <> 56 Then
                        DeLIGHT
                        ItemX = 70: ItemY = 410
                        HiLIGHT
                        Item = 56
                    End If
                Case 224 TO 409
                    If Item <> 57 Then
                        DeLIGHT
                        ItemX = 250: ItemY = 410
                        HiLIGHT
                        Item = 57
                    End If
                Case 410 TO 600
                    If Item <> 58 Then
                        DeLIGHT
                        ItemX = 430: ItemY = 410
                        HiLIGHT
                        Item = 58
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 17
            Select Case MouseX
                Case 50 TO 200
                    If Item <> 59 Then
                        DeLIGHT
                        ItemX = 60: ItemY = 428
                        HiLIGHT
                        Item = 59
                    End If
                Case 230 TO 380
                    If Item <> 60 Then
                        DeLIGHT
                        ItemX = 240: ItemY = 428
                        HiLIGHT
                        Item = 60
                    End If
                Case 410 TO 560
                    If Item <> 61 Then
                        DeLIGHT
                        ItemX = 420: ItemY = 428
                        HiLIGHT
                        Item = 61
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 18
            Select Case MouseX
                Case 65 TO 164
                    If Item <> 62 Then
                        DeLIGHT
                        ItemX = 50: ItemY = 412
                        HiLIGHT
                        Item = 62
                    End If
                Case 165 TO 264
                    If Item <> 63 Then
                        DeLIGHT
                        ItemX = 150: ItemY = 412
                        HiLIGHT
                        Item = 63
                    End If
                Case 265 TO 364
                    If Item <> 64 Then
                        DeLIGHT
                        ItemX = 250: ItemY = 412
                        HiLIGHT
                        Item = 64
                    End If
                Case 365 TO 464
                    If Item <> 65 Then
                        DeLIGHT
                        ItemX = 350: ItemY = 412
                        HiLIGHT
                        Item = 65
                    End If
                Case 465 TO 564
                    If Item <> 66 Then
                        DeLIGHT
                        ItemX = 450: ItemY = 412
                        HiLIGHT
                        Item = 66
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 19
            Select Case MouseX
                Case 60 TO 139
                    If Item <> 67 Then
                        DeLIGHT
                        ItemX = 20: ItemY = 396
                        HiLIGHT
                        Item = 67
                    End If
                Case 140 TO 219
                    If Item <> 68 Then
                        DeLIGHT
                        ItemX = 125: ItemY = 396
                        HiLIGHT
                        Item = 68
                    End If
                Case 240 TO 319
                    If Item <> 69 Then
                        DeLIGHT
                        ItemX = 202: ItemY = 396
                        HiLIGHT
                        Item = 69
                    End If
                Case 320 TO 399
                    If Item <> 70 Then
                        DeLIGHT
                        ItemX = 304: ItemY = 396
                        HiLIGHT
                        Item = 70
                    End If
                Case 420 TO 499
                    If Item <> 71 Then
                        DeLIGHT
                        ItemX = 384: ItemY = 396
                        HiLIGHT
                        Item = 71
                    End If
                Case 500 TO 579
                    If Item <> 72 Then
                        DeLIGHT
                        ItemX = 490: ItemY = 396
                        HiLIGHT
                        Item = 72
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 20
            Select Case MouseX
                Case 140 TO 219
                    If Item <> 67 Then
                        DeLIGHT
                        ItemX = 100: ItemY = 396
                        HiLIGHT
                        Item = 67
                    End If
                Case 220 TO 299
                    If Item <> 68 Then
                        DeLIGHT
                        ItemX = 210: ItemY = 396
                        HiLIGHT
                        Item = 68
                    End If
                Case 340 TO 419
                    If Item <> 69 Then
                        DeLIGHT
                        ItemX = 290: ItemY = 396
                        HiLIGHT
                        Item = 69
                    End If
                Case 420 TO 499
                    If Item <> 70 Then
                        DeLIGHT
                        ItemX = 420: ItemY = 396
                        HiLIGHT
                        Item = 70
                    End If
                Case Else
                    DeLIGHT
            End Select
    End Select

    If LB = -1 And Item <> 0 Then
        Select Case Item
            Case 31
                LoadFILE "CHFndrFS": GoSub FrontWHEEL
                LoadFILE "CHFndrRS": GoSub RearWHEEL
                FenderSTYLE = 1
                GoSub Transfer
            Case 32
                LoadFILE "CHFndrFC": GoSub FrontWHEEL
                LoadFILE "CHFndrRC": GoSub RearWHEEL
                FenderSTYLE = 2
                GoSub Transfer
            Case 33
                LoadFILE "CHFndrFF": GoSub FrontWHEEL
                LoadFILE "CHFndrRF": GoSub RearWHEEL
                FenderSTYLE = 3
                GoSub Transfer
            Case 34
                HideMOUSE
                If Frame = 2 Then
                    Get (FrameX + 100, FrameY + 40)-Step(20, 30), Box()
                    Put (FrameX + 70, FrameY + 25), Box(), PSet
                    Line (FrameX + 90, FrameY + 110)-Step(40, 2), 0, BF
                    Circle (FrameX + 53, FrameY + 108), 3, 2
                    Paint Step(0, 0), 4, 2
                    Circle (FrameX + 53, FrameY + 108), 2, 15, 0, 3
                    Line (FrameX + 50, FrameY + 101)-Step(1, 1), 4, B
                    Circle (FrameX + 53, FrameY + 108), 3, 5, 3, 0
                    Line Step(-2, 0)-Step(4, 0), 3
                End If
                LoadFILE "CHMtr750.BSI"
                MotorSTYLE = 1
                GoSub InstallMOTOR
                DeLIGHT
                ShowMOUSE
                Phase = 15
            Case 35
                HideMOUSE
                DeLIGHT
                ShowMOUSE
                MotorSTYLE = 2
                Phase = 10
            Case 36
                HideMOUSE
                DeLIGHT
                ShowMOUSE
                MotorSTYLE = 3
                Phase = 10
            Case 37
                If MotorSTYLE = 2 Then
                    LoadFILE "CHMtrVKP.BSI"
                Else
                    LoadFILE "CHMtrVBP.BSI"
                End If
                GoSub InstallMOTOR
            Case 38
                If MotorSTYLE = 2 Then
                    LoadFILE "CHMtrVKB.BSI"
                Else
                    LoadFILE "CHMtrVBB.BSI"
                End If
                GoSub InstallMOTOR
            Case 39
                If MotorSTYLE = 2 Then
                    LoadFILE "CHMtrVKC.BSI"
                Else
                    LoadFILE "CHMtrVBC.BSI"
                End If
                GoSub InstallMOTOR
            Case 40
                HideMOUSE
                LoadBSI FrameX, FrameY, "CHDrvCH"
                LoadFILE "CHShdowD.BSI"
                Put (FrameX + Box(0), 268), Box(3), And
                Put (FrameX + Box(0), 268), Box(Box(2))
                DeLIGHT
                ShowMOUSE
                Phase = 13
            Case 41 TO 43
                HideMOUSE
                If Item = 41 Then LoadBSI FrameX, FrameY, "CHDrvBP"
                If Item = 42 Then LoadBSI FrameX, FrameY, "CHDrvBB"
                If Item = 43 Then LoadBSI FrameX, FrameY, "CHDrvBC"
                LoadFILE "CHShdowD.BSI"
                Put (FrameX + Box(0), 268), Box(3), And
                Put (FrameX + Box(0), 268), Box(Box(2))
                DeLIGHT
                ShowMOUSE
                Phase = 12
            Case 44, 45, 46, 146
                HideMOUSE
                If Item = 44 Then LoadBSI FrameX, FrameY, "CHDrvCP": Cover = 1
                If Item = 45 Then LoadBSI FrameX, FrameY, "CHDrvCB"
                If Item = 46 Then LoadBSI FrameX, FrameY, "CHDrvCC"
                DeLIGHT
                ShowMOUSE
                Phase = 13
            Case 47 TO 50
                HideMOUSE
                If Item = 47 Then LoadBSI FrameX, FrameY, "CHBrthr3"
                If Item = 48 Then LoadBSI FrameX, FrameY, "CHBrthr4"
                If Item = 49 Then LoadBSI FrameX, FrameY, "CHBrthr1"
                If Item = 50 Then LoadBSI FrameX, FrameY, "CHBrthr2"
                DeLIGHT
                ShowMOUSE
                Phase = 14
            Case 51, 52
                If Frame = 1 Then
                    If Item = 51 Then FileNAME$ = "CHRDrRVC"
                    If Item = 52 Then FileNAME$ = "CHRDrRVB"
                Else
                    If Item = 51 Then FileNAME$ = "CHRDrXVC"
                    If Item = 52 Then FileNAME$ = "CHRDrXVB"
                End If
                HideMOUSE
                LoadBSI FrameX, FrameY, FileNAME$
                DeLIGHT
                ShowMOUSE
                Phase = 17
            Case 53 TO 55
                If Frame = 1 Then
                    If Item = 53 Then FileNAME$ = "CHRDrR7O"
                    If Item = 54 Then FileNAME$ = "CHRDrR7P": GPaint = 1
                    If Item = 55 Then FileNAME$ = "CHRDrR7C"
                Else
                    If Item = 53 Then FileNAME$ = "CHRDrX7O"
                    If Item = 54 Then FileNAME$ = "CHRDrX7P": GPaint = 1
                    If Item = 55 Then FileNAME$ = "CHRDrX7C"
                End If
                HideMOUSE
                LoadBSI FrameX, FrameY, FileNAME$
                DeLIGHT
                ShowMOUSE
                Phase = 16
            Case 56 TO 58
                HideMOUSE
                If Item = 56 Then LoadBSI FrameX, FrameY, "CHExBLST"
                If Item = 57 Then LoadBSI FrameX, FrameY, "CHExBHMG": HighMEG = 1
                If Item = 58 Then LoadBSI FrameX, FrameY, "CHExBLMG"
                If Frame = 1 Then ShadowDROP = 11 Else ShadowDROP = 0
                LoadBSI FrameX, FrameY + ShadowDROP, "CHShdo7X"
                DeLIGHT
                ShowMOUSE
                Phase = 18
            Case 59 TO 61
                HideMOUSE
                If Item = 59 Then LoadBSI FrameX, FrameY, "CHExVLMG": Extend = 0
                If Item = 60 Then LoadBSI FrameX, FrameY, "CHExVLSH": Extend = -20
                If Item = 61 Then LoadBSI FrameX, FrameY, "CHExVHOS": Extend = 60: HighPIPE = 1
                If Frame = 1 Then ShadowDROP = 11 Else ShadowDROP = 0
                LoadBSI FrameX + 12, FrameY + 44 + ShadowDROP, "CHShdoVX"
                Line (FrameX + 120, FrameY + 143 + ShadowDROP)-(FrameX + 200 + Extend, FrameY + 147 + ShadowDROP), 5, BF
                Draw "R5 H5 D5 R bU p5,5"
                DeLIGHT
                ShowMOUSE
                Phase = 18
            Case 62 TO 66
                If Frame = 1 Then TankY = 5 Else TankY = 0
                HideMOUSE
                If Item = 62 Then
                    LoadBSI FrameX, FrameY + TankY, "CHFTnkTD"
                    Tank = 1: TX = 2: TY = 2 + TankY
                    If Frame = 1 Then TTY = 5 Else TTY = 0
                End If
                If Item = 63 Then
                    LoadBSI FrameX, FrameY, "CHFTnkSC"
                    TX = 4: Tank = 2: TY = 6 + TankY
                    TTY = 0
                End If
                If Item = 64 Then
                    LoadBSI FrameX, FrameY + TankY, "CHFTnkOS"
                    Tank = 3: TX = 0: TY = TankY
                    If Frame = 1 Then TTY = 4 Else TTY = 0
                End If
                If Item = 65 Then
                    LoadBSI FrameX, FrameY + TankY, "CHFTnkCB"
                    Tank = 4: TX = 10: TY = 3 + TankY
                    If Frame = 1 Then TTY = 4 Else TTY = 0
                End If
                If Item = 66 Then
                    LoadBSI FrameX, FrameY + TankY, "CHFTnkBR"
                    Tank = 5
                    TX = 2
                    TTY = 4
                    If Frame = 1 Then TY = 12 Else TY = 7
                    If Frame = 1 Then TTY = 4 Else TTY = 0
                End If
                DeLIGHT
                ClearBOX
                If MotorSTYLE = 1 And Frame = 1 Then
                    Phase = 19
                Else
                    Phase = 20
                End If
                ShowMOUSE
            Case 67 TO 72
                HideMOUSE
                If Item = 67 Then LoadBSI FrameX, FrameY, "CHOTnkHP": OT = 1
                If Item = 68 Then LoadBSI FrameX, FrameY, "CHOTnkHC": OT = 2
                If Item = 69 Then LoadBSI FrameX, FrameY, "CHOTnkCP": OT = 3
                If Item = 70 Then LoadBSI FrameX, FrameY, "CHOTnkCC": OT = 4
                If Item = 71 Then LoadBSI FrameX, FrameY, "CHOTnkBP": OT = 5
                If Item = 72 Then LoadBSI FrameX, FrameY, "CHOTnkBC": OT = 6
                If HighMEG = 1 Then
                    LoadBSI FrameX, FrameY, "CHExBHMG"
                    HighMEG = 0
                End If
                DeLIGHT
                For x = BarX - 40 To BarX - 10
                    For y = BarY + 10 To BarY + 40
                        If Point(x, y) = 14 Then
                            LightX = x
                            LightY = y
                            PSet (x, y), 15
                            GoTo Continue
                        End If
                    Next y
                Next x
                Continue:
                ShowMOUSE
                Phase = 21
        End Select
    End If

    Exit Sub

    '************************* SUBROUTINE SECTION BEGINS ************************

    FrontWHEEL:
    HideMOUSE
    Put (WheelFX - 153, WheelFY - 157), Box(3200), And
    Put (WheelFX - 153, WheelFY - 157), Box()
    ShowMOUSE
    Return

    RearWHEEL:
    HideMOUSE
    Put (WheelRX + 45, WheelRY - 155), Box(3200), And
    Put (WheelRX + 45, WheelRY - 155), Box()
    DeLIGHT
    ShowMOUSE
    Return

    Transfer:
    HideMOUSE
    LoadIMAGE 170, 80, "CHPrepAR"
    LoadIMAGE 170, 80, "CHInstW"
    FFLX = Seeker(WheelFX - 153, WheelFY - 157, 0)
    FFRX = Seeker(WheelFX - 153, WheelFY - 157, 1)
    FFTY = Seeker(WheelFX - 153, WheelFY - 157, 2)
    FFBY = Seeker(WheelFX - 153, WheelFY - 157, 3)
    Open "ff.dat" For Output As #1
    Write #1, FFLX + 100, FFRX - FFLX, FFTY + 100, FFBY - FFTY
    For x = FFLX To FFRX
        For y = FFTY To FFBY
            If Point(x + 100, y + 100) = 0 Then Write #1, 1 Else Write #1, 0
        Next y
    Next x
    Close #1
    PSet (WheelFX - 43, WheelFY + 48), 5
    Draw "R91 M+2,-5 L85 M-8,+5 R10 BU2 P5,5"
    For x = WheelFX - 153 To WheelFX - 43
        For y = WheelFY - 157 To WheelFY - 47
            If Point(x, y) <> 0 Then
                If y < WheelFY - 72 Then
                    If Point(x + 100, y + 100) = 0 Then
                        PSet (x + 100, y + 100), Point(x, y)
                    End If
                Else
                    PSet (x + 100, y + 100), Point(x, y)
                End If
                PSet (x, y), 0
            End If
        Next y
    Next x
    RFLX = Seeker(WheelRX + 45, WheelRY - 157, 0)
    RFRX = Seeker(WheelRX + 45, WheelRY - 157, 1)
    RFTY = Seeker(WheelRX + 45, WheelRY - 157, 2)
    RFBY = Seeker(WheelRX + 45, WheelRY - 157, 3)
    Open "rf.dat" For Output As #1
    Write #1, RFLX - 100, RFRX - RFLX, RFTY + 100, RFBY - RFTY
    For x = RFLX To RFRX
        For y = RFTY To RFBY
            If Point(x - 100, y + 100) = 0 Then Write #1, 1 Else Write #1, 0
        Next y
    Next x
    Close #1
    If Frame = 2 Then
        PSet (WheelRX - 43, WheelRY + 42), 5
    Else
        PSet (WheelRX - 43, WheelRY + 48), 5
    End If
    Draw "R91 M-8,-5 L88 F5 R20 BU3 P5,5"
    For x = WheelRX + 45 To WheelRX + 155
        For y = WheelRY - 155 To WheelRY - 45
            If Point(x, y) <> 0 Then
                If y < WheelRY - 72 Then
                    If Point(x - 100, y + 100) = 0 Then
                        PSet (x - 100, y + 100), Point(x, y)
                    End If
                Else
                    PSet (x - 100, y + 100), Point(x, y)
                End If
                PSet (x, y), 0
            End If
        Next y
    Next x
    LoadIMAGE 170, 80, "CHInstW"
    ShowMOUSE
    Phase = 9
    Return

    InstallMOTOR:
    HideMOUSE
    Put (FrameX + Box(0), FrameY + Box(1)), Box(3), And
    Put (FrameX + Box(0), FrameY + Box(1)), Box(Box(2))
    If MotorSTYLE = 1 Then
        LoadFILE "CHShdow7.BSI"
        Put (FrameX + Box(0), 251), Box(3), And
        Put (FrameX + Box(0), 251), Box(Box(2))
    Else
        If Frame = 1 Then
            Select Case FrameCOLOR
                Case 1: Colr1 = 6: Colr2 = 13
                Case 2: Colr1 = 5: Colr2 = 2
                Case 3: Colr1 = 4: Colr2 = 15
            End Select
            PSet (FrameX + Box(0) + 32, FrameY + Box(1)), Colr1
            Draw "U8 M+4,+2 D6 L4 BE2 P" + LTrim$(Str$(Colr1)) + "," + LTrim$(Str$(Colr1))
            PSet (FrameX + Box(0) + 32, FrameY + Box(1)), Colr2
            Draw "U7"
        End If
        LoadBSI FrameX, FrameY, "CHLnkage"
        LoadFILE "CHShdowP.BSI"
        Put (FrameX + Box(0), 254), Box(3), And
        Put (FrameX + Box(0), 254), Box(Box(2))
        LoadFILE "CHShdowV.BSI"
        Put (FrameX + Box(0), 254), Box(3), And
        Put (FrameX + Box(0), 254), Box(Box(2))
    End If
    DeLIGHT
    If MotorSTYLE > 1 Then
    End If
    ShowMOUSE
    Phase = 11
    Return

End Sub

Sub Assembly3
    Shared ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR
    Shared ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
    Shared OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY
    Shared MotorSTYLE, HighMEG, HighPIPE, OT, LightX, LightY, FenderSTYLE
    Shared FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY

    Select Case Phase
        Case 22
            Select Case MouseX
                Case 15 TO 114
                    If Item <> 73 Then
                        DeLIGHT
                        ItemX = 12: ItemY = 406
                        HiLIGHT
                        Item = 73
                    End If
                Case 115 TO 214
                    If Item <> 74 Then
                        DeLIGHT
                        ItemX = 98: ItemY = 406
                        HiLIGHT
                        Item = 74
                    End If
                Case 215 TO 314
                    If Item <> 75 Then
                        DeLIGHT
                        ItemX = 200: ItemY = 406
                        HiLIGHT
                        Item = 75
                    End If
                Case 315 TO 409
                    If Item <> 76 Then
                        DeLIGHT
                        ItemX = 300: ItemY = 406
                        HiLIGHT
                        Item = 76
                    End If
                Case 410 TO 519
                    If Item <> 77 Then
                        DeLIGHT
                        ItemX = 400: ItemY = 406
                        HiLIGHT
                        Item = 77
                    End If
                Case 520 TO 624
                    If Item <> 78 Then
                        DeLIGHT
                        ItemX = 497: ItemY = 406
                        HiLIGHT
                        Item = 78
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 23
            Select Case MouseX
                Case 60 TO 139
                    If Item <> 79 Then
                        DeLIGHT
                        ItemX = 20: ItemY = 394
                        HiLIGHT
                        Item = 79
                    End If
                Case 140 TO 219
                    If Item <> 80 Then
                        DeLIGHT
                        ItemX = 126: ItemY = 394
                        HiLIGHT
                        Item = 80
                    End If
                Case 240 TO 319
                    If Item <> 81 Then
                        DeLIGHT
                        ItemX = 204: ItemY = 394
                        HiLIGHT
                        Item = 81
                    End If
                Case 320 TO 399
                    If Item <> 82 Then
                        DeLIGHT
                        ItemX = 306: ItemY = 394
                        HiLIGHT
                        Item = 82
                    End If
                Case 420 TO 499
                    If Item <> 83 Then
                        DeLIGHT
                        ItemX = 386: ItemY = 394
                        HiLIGHT
                        Item = 83
                    End If
                Case 500 TO 580
                    If Item <> 84 Then
                        DeLIGHT
                        ItemX = 486: ItemY = 394
                        HiLIGHT
                        Item = 84
                    End If
                Case Else
                    DeLIGHT
            End Select
        Case 24
            Select Case MouseX
                Case 125 TO 235
                    If Item <> 85 Then
                        DeLIGHT
                        ItemX = 115: ItemY = 420
                        HiLIGHT
                        Item = 85
                    End If
                Case 265 TO 375
                    If Item <> 86 Then
                        DeLIGHT
                        ItemX = 255: ItemY = 420
                        HiLIGHT
                        Item = 86
                    End If
                Case 405 TO 515
                    If Item <> 87 Then
                        DeLIGHT
                        ItemX = 395: ItemY = 420
                        HiLIGHT
                        Item = 87
                    End If
                Case Else
                    DeLIGHT
            End Select
    End Select

    If LB = -1 And Item <> 0 Then
        Select Case Item
            Case 73 TO 78
                If Frame = 1 Then SeatUP = -2 Else SeatUP = 0
                HideMOUSE
                If Item = 73 Then LoadBSI FrameX, FrameY + SeatUP, "CHStOSHP"
                If Item = 74 Then LoadBSI FrameX, FrameY + SeatUP, "CHStOSHS"
                If Item = 75 Then LoadBSI FrameX, FrameY + SeatUP, "CHStOSLP"
                If Item = 76 Then LoadBSI FrameX, FrameY + SeatUP, "CHStOSLS"
                If Item = 77 Then
                    If Frame = 1 Then
                        LoadBSI FrameX + 10, FrameY + 15, "CHStBNAR"
                        Circle (FrameX + 156, FrameY + 64), 4, 15, 1, 3
                        PSet Step(2, -4), 3
                        PSet Step(-4, 0), 3
                    Else
                        Select Case FrameCOLOR
                            Case 1: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAP"
                            Case 2: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAB"
                            Case 3: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAC"
                        End Select
                    End If
                End If
                If Item = 78 Then
                    If Frame = 1 Then
                        Select Case FrameCOLOR
                            Case 1: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPP"
                            Case 2: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPB"
                            Case 3: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPC"
                        End Select
                        If OT > 4 Then
                            If OT = 5 Then LoadBSI FrameX, FrameY, "CHOTnkBP"
                            If OT = 6 Then LoadBSI FrameX, FrameY, "CHOTnkBC"
                            If HighMEG Then LoadBSI FrameX, FrameY, "CHExBHMG"
                        End If
                    Else
                        LoadBSI FrameX + 8, FrameY + 4, "CHStCHPE"
                    End If
                End If
                DeLIGHT
                ShowMOUSE
                Phase = 23
            Case 79 TO 84
                HideMOUSE
                If Item = 79 Then LoadBSI LightX, LightY, "CHHDLTLP"
                If Item = 80 Then LoadBSI LightX, LightY, "CHHDLTLC"
                If Item = 81 Then LoadBSI LightX, LightY, "CHHDLTSP"
                If Item = 82 Then LoadBSI LightX, LightY, "CHHDLTSC"
                If Item = 83 Then LoadBSI LightX, LightY, "CHHDLTCP"
                If Item = 84 Then LoadBSI LightX, LightY, "CHHDLTCC"
                DeLIGHT
                ShowMOUSE
                Phase = 24
            Case 85 TO 87
                HideMOUSE
                Select Case FenderSTYLE
                    Case 1
                        If Item = 85 Then LoadBSI WheelRX, WheelRY, "CHTLLTSP"
                        If Item = 86 Then LoadBSI WheelRX, WheelRY, "CHTLLTSC"
                        If HighPIPE = 1 Then LoadBSI FrameX, FrameY, "CHExVHOS"
                    Case 2
                        If Item = 85 Then LoadBSI WheelRX, WheelRY, "CHTLLTCP"
                        If Item = 86 Then LoadBSI WheelRX, WheelRY, "CHTLLTCC"
                    Case 3
                        If Item = 85 Then LoadBSI WheelRX, WheelRY, "CHTLLTFP"
                        If Item = 86 Then LoadBSI WheelRX, WheelRY, "CHTLLTFC"
                End Select
                DeLIGHT
                ShowMOUSE
                Phase = 25
        End Select
    End If

End Sub

Sub ChopperIDE

    For Colr = 8 To 14
        Out &H3C8, Colr
        Out &H3C9, 63 - nn / 4
        Out &H3C9, 24 - nn
        Out &H3C9, 0
        nn = nn + 4
    Next Colr

    Def Seg = VarSeg(Box(0))
    For y = 0 To 320 Step 160
        FileCOUNT = FileCOUNT + 1
        FileNAME$ = "chide" + LTrim$(Str$(FileCOUNT)) + ".bsv"
        BLoad FileNAME$, VarPtr(Box(0))
        Put (0, y), Box()
    Next y
    Def Seg

End Sub

Sub ClearBOX

    Line (11, 295)-(628, 469), 0, BF

End Sub

Sub ClearMOUSE

    While LB Or RB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub DeLIGHT
    Shared ItemX, ItemY

    If Item Then
        HideMOUSE
        Put (ItemX, ItemY), MenuBOX(), PSet
        ShowMOUSE
        Item = 0
    End If

End Sub

Sub FieldMOUSE (x1, y1, x2, y2)

    MouseDRIVER 7, 0, x1, x2
    MouseDRIVER 8, 0, y1, y2

End Sub

Sub FourBIT (x1%, y1%, x2%, y2%, FileNAME$)

    Dim FileCOLORS%(1 To 48)
    Dim Colors4%(15)
    GraphX = 314

    For x = x1% To x2%
        For y = y1% To y2%
            Colors4%(Point(x, y)) = 1
        Next y
        Line (GraphX, 323)-(GraphX, 331), 11
        If x Mod 11 = 0 Then GraphX = GraphX + 1
    Next x
    For n = 0 To 15
        If Colors4%(n) = 1 Then SigCOLORS& = SigCOLORS& + 1
    Next n
 
    FileTYPE$ = "BM"
    Reserved1% = 0
    Reserved2% = 0
    OffsetBITS& = 118
    InfoHEADER& = 40
    PictureWIDTH& = x2% - x1% + 1
    PictureDEPTH& = y2% - y1% + 1
    NumPLANES% = 1
    BPP% = 4
    Compression& = 0
    WidthPELS& = 3780
    DepthPELS& = 3780
    NumCOLORS& = 16

    If PictureWIDTH& Mod 8 <> 0 Then
        ZeroPAD$ = Space$((8 - PictureWIDTH& Mod 8) \ 2)
    End If

    ImageSIZE& = (((ImageWIDTH& + Len(ZeroPAD$)) * ImageDEPTH&) + .1) / 2
    FileSIZE& = ImageSIZE& + OffsetBITS&

    Colr = 0
    For n = 1 To 48 Step 3
        Out &H3C7, Colr
        FileCOLORS%(n) = Inp(&H3C9)
        FileCOLORS%(n + 1) = Inp(&H3C9)
        FileCOLORS%(n + 2) = Inp(&H3C9)
        Colr = Colr + 1
    Next n

    Open FileNAME$ For Binary As #1

    Put #1, , FileTYPE$
    Put #1, , FileSIZE&
    Put #1, , Reserved1% 'should be zero
    Put #1, , Reserved2% 'should be zero
    Put #1, , OffsetBITS&
    Put #1, , InfoHEADER&
    Put #1, , PictureWIDTH&
    Put #1, , PictureDEPTH&
    Put #1, , NumPLANES%
    Put #1, , BPP%
    Put #1, , Compression&
    Put #1, , ImageSIZE&
    Put #1, , WidthPELS&
    Put #1, , DepthPELS&
    Put #1, , NumCOLORS&
    Put #1, , SigCOLORS&

    u$ = " "
    For n% = 1 To 46 Step 3
        Colr$ = Chr$(FileCOLORS%(n% + 2) * 4)
        Put #1, , Colr$
        Colr$ = Chr$(FileCOLORS%(n% + 1) * 4)
        Put #1, , Colr$
        Colr$ = Chr$(FileCOLORS%(n%) * 4)
        Put #1, , Colr$
        Put #1, , u$ 'Unused byte
    Next n%
 
    For y = y2% To y1% Step -1
        For x = x1% To x2% Step 2
            HiX = Point(x, y)
            LoX = Point(x + 1, y)
            HiNIBBLE$ = Hex$(HiX)
            LoNIBBLE$ = Hex$(LoX)
            HexVAL$ = "&H" + HiNIBBLE$ + LoNIBBLE$
            a$ = Chr$(Val(HexVAL$))
            Put #1, , a$
        Next x

        Put #1, , ZeroPAD$

        If y Mod 3 = 0 Then
            Line (GraphX, 323)-(GraphX, 331), 11
            GraphX = GraphX + 1
        End If

    Next y

    Close #1

End Sub

Sub HandleBARS (InOUT)
    Shared BarX, BarY, GotBOX

    If InOUT = 0 Then GoSub DeBOX: Exit Sub

    Select Case MouseY
        Case 332 TO 414
            Select Case MouseX
                Case 12 TO 87
                    If BarBOX <> 1 Then
                        GoSub DeBOX
                        BarBOX = 1
                        GoSub BoxIT
                    End If
                Case 89 TO 164
                    If BarBOX <> 2 Then
                        GoSub DeBOX
                        BarBOX = 2
                        GoSub BoxIT
                    End If
                Case 166 TO 241
                    If BarBOX <> 3 Then
                        GoSub DeBOX
                        BarBOX = 3
                        GoSub BoxIT
                    End If
                Case 243 TO 318
                    If MouseY < 374 Then
                        If BarBOX <> 4 Then
                            GoSub DeBOX
                            BarBOX = 4
                            GoSub BoxIT
                        End If
                    Else
                        If BarBOX <> 5 Then
                            GoSub DeBOX
                            BarBOX = 5
                            GoSub BoxIT
                        End If
                    End If
                Case 320 TO 395
                    If BarBOX <> 6 Then
                        GoSub DeBOX
                        BarBOX = 6
                        GoSub BoxIT
                    End If
                Case 397 TO 472
                    If BarBOX <> 7 Then
                        GoSub DeBOX
                        BarBOX = 7
                        GoSub BoxIT
                    End If
                Case 474 TO 549
                    If BarBOX <> 8 Then
                        GoSub DeBOX
                        BarBOX = 8
                        GoSub BoxIT
                    End If
                Case 551 TO 626
                    If BarBOX <> 9 Then
                        GoSub DeBOX
                        BarBOX = 9
                        GoSub BoxIT
                    End If
            End Select
        Case 423 TO 439
            If MouseX > 277 And MouseX < 349 Then
                If LB = -1 Then
                    HideMOUSE
                    Get (278, 423)-(358, 439), MenuBOX()
                    Line (278, 423)-(358, 439), 4, BF
                    Line (278, 423)-(278, 439), 3
                    Line (278, 423)-(358, 423), 3
                    PrintSTRING 302, 426, "Accept"
                    ShowMOUSE
                    Interval .1
                    HideMOUSE
                    Put (278, 423), MenuBOX(), PSet
                    ShowMOUSE
                    If GotBOX = 1 Then
                        DeLIGHT
                        GoSub DeBOX
                        HideMOUSE
                        Open "chcable.dat" For Input As #1
                        Input #1, xx, yy
                        For x = 0 To xx
                            For y = 0 To yy
                                Input #1, Colr
                                If Colr <> 0 Then
                                    If Point(x + BarX - 16, y + BarY + 24) = 0 Then
                                        PSet (x + BarX - 16, y + BarY + 24), Colr
                                    End If
                                End If
                            Next y
                        Next x
                        Close #1
                        ShowMOUSE
                        Phase = 22
                        Exit Sub
                    End If
                End If
            End If
        Case Else
            GoSub DeBOX
    End Select

    If BarBOX <> 0 And LB = -1 Then
        HideMOUSE
        If GotBOX = 1 Then Put (BarX - 10, BarY - 45), Box(24000), PSet: GotBOX = 0
        Get (BarX - 10, BarY - 45)-(BarX + 66, BarY + 30), Box(24000): GotBOX = 1
        Select Case BarBOX
            Case 1: LoadFILE "CHBar1.BSI"
            Case 2: LoadFILE "CHBar2.BSI"
            Case 3: LoadFILE "CHBar3.BSI"
            Case 4: LoadFILE "CHBar4.BSI"
            Case 5: LoadFILE "CHBar5.BSI"
            Case 6: LoadFILE "CHBar6.BSI"
            Case 7: LoadFILE "CHBar7.BSI"
            Case 8: LoadFILE "CHBar8.BSI"
            Case 9: LoadFILE "CHBar9.BSI"
        End Select
        Put (BarX - Box(0), BarY - Box(1)), Box(3), And
        Put (BarX - Box(0), BarY - Box(1)), Box(Box(2))
        ShowMOUSE
    End If

    Exit Sub

    DeBOX:
    If BarBOX Then
        HideMOUSE
        Select Case BarBOX
            Case 1: Line (12, 332)-(87, 414), 3, B
            Case 2: Line (89, 332)-(164, 414), 3, B
            Case 3: Line (166, 332)-(241, 414), 3, B
            Case 4: Line (243, 332)-(318, 372), 3, B
            Case 5: Line (243, 374)-(318, 414), 3, B
            Case 6: Line (320, 332)-(395, 414), 3, B
            Case 7: Line (397, 332)-(472, 414), 3, B
            Case 8: Line (474, 332)-(549, 414), 3, B
            Case 9: Line (551, 332)-(626, 414), 3, B
        End Select
        ShowMOUSE
        BarBOX = 0
    End If
    Return

    BoxIT:
    HideMOUSE
    Select Case BarBOX
        Case 1: Line (12, 332)-(87, 414), 15, B
        Case 2: Line (89, 332)-(164, 414), 15, B
        Case 3: Line (166, 332)-(241, 414), 15, B
        Case 4: Line (243, 332)-(318, 372), 15, B
        Case 5: Line (243, 374)-(318, 414), 15, B
        Case 6: Line (320, 332)-(395, 414), 15, B
        Case 7: Line (397, 332)-(472, 414), 15, B
        Case 8: Line (474, 332)-(549, 414), 15, B
        Case 9: Line (551, 332)-(626, 414), 15, B
    End Select
    ShowMOUSE
    Return

End Sub

Sub HelpMENU
    Static HelpITEM, HelpY, Instructions, CornerON

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        If Instructions Then
            Select Case MouseX
                Case 428 TO 456
                    Select Case MouseY
                        Case 104 TO 118
                            If CornerON <> 1 Then
                                GoSub LightINSTR
                                CornerON = 1
                            End If
                        Case Else
                            GoSub DarkINSTR
                    End Select
                Case Else
                    GoSub DarkINSTR
            End Select
            If CornerON And LB = -1 Then
                Select Case Instructions
                    Case 1
                        LoadFILE "CHInstr2.BSV"
                        Instructions = 2
                        HideMOUSE
                        Put (180, 100), Box(), PSet
                        ShowMOUSE
                        ClearMOUSE
                        CornerON = 0
                    Case 2
                        HideMOUSE
                        Put (180, 100), Box(13000), PSet
                        ShowMOUSE
                        Instructions = 0
                End Select
            End If
        Else
            Select Case MouseX
                Case 492 TO 584
                    Select Case MouseY
                        Case 34 TO 55
                            GoSub DarkHELP
                            If MouseX < 500 Or MouseX > 544 Then GoSub CloseHELP
                        Case 56 TO 71
                            If HelpITEM <> 1 Then
                                GoSub DarkHELP
                                HelpY = 59
                                GoSub LightHELP
                                HelpITEM = 1
                            End If
                        Case 72 TO 87
                            If HelpITEM <> 2 Then
                                GoSub DarkHELP
                                HelpY = 75
                                GoSub LightHELP
                                HelpITEM = 2
                            End If
                        Case Else: GoSub CloseHELP
                    End Select
                Case Else: GoSub CloseHELP
            End Select
            If HelpITEM > 0 And LB = -1 Then
                Select Case HelpITEM
                    Case 1
                        GoSub DarkHELP
                        MenuITEM = 0
                        MenuBAR 0
                        HideMOUSE
                        Get (180, 100)-(460, 272), Box(13000)
                        LoadFILE "CHInstr1.BSV"
                        Put (180, 100), Box(), PSet
                        ShowMOUSE
                        Instructions = 1
                    Case 2
                        GoSub DarkHELP
                        MenuITEM = 0
                        MenuBAR 0
                        HideMOUSE
                        Get (180, 100)-(460, 272), Box(13000)
                        LoadFILE "CHAbout.BSV"
                        Put (180, 100), Box(), PSet
                        ShowMOUSE
                        Instructions = 2
                End Select
            End If
        End If
    Loop

    Exit Sub

    LightHELP:
    HideMOUSE
    Get (498, HelpY)-(598, HelpY + 10), MenuBOX2()
    For x = 498 To 598
        For y = HelpY To HelpY + 10
            If Point(x, y) = 3 Then PSet (x, y), 15
        Next y
    Next x
    ShowMOUSE
    Return

    DarkHELP:
    If HelpITEM Then
        HideMOUSE
        Put (498, HelpY), MenuBOX2(), PSet
        ShowMOUSE
        HelpITEM = 0
    End If
    Return

    LightINSTR:
    HideMOUSE
    For x = 428 To 456
        For y = 104 To 118
            If Point(x, y) = 3 Then PSet (x, y), 15
        Next y
    Next x
    ShowMOUSE
    Return

    DarkINSTR:
    If CornerON <> 0 Then
        HideMOUSE
        For x = 428 To 456
            For y = 104 To 118
                If Point(x, y) = 15 Then PSet (x, y), 3
            Next y
        Next x
        ShowMOUSE
        CornerON = 0
    End If
    Return

    CloseHELP:
    GoSub DarkHELP
    MenuITEM = 0
    MenuBAR 0
    Exit Sub
    Return

End Sub

Sub HideMOUSE

    LB = 2
    MouseDRIVER LB, 0, 0, 0

End Sub

Sub HiLIGHT
    Shared ItemX, ItemY

    HideMOUSE
    Get (ItemX, ItemY)-(ItemX + 130, ItemY + 10), MenuBOX()
    For x = ItemX To ItemX + 130
        For y = ItemY To ItemY + 10
            If Point(x, y) <> 0 Then PSet (x, y), 15
        Next y
    Next x
    ShowMOUSE

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
Sub LoadBSI (x, y, FileNAME$)

    FileNAME$ = FileNAME$ + ".BSI"
    LoadFILE FileNAME$
    Wait &H3DA, 8
    Put (x + Box(0), y + Box(1)), Box(3), And
    Put (x + Box(0), y + Box(1)), Box(Box(2))

End Sub

Sub LoadFILE (FileNAME$)

    If InStr(FileNAME$, ".") = 0 Then FileNAME$ = FileNAME$ + ".BSV"
    Def Seg = VarSeg(Box(0))
    BLoad LCase$(FileNAME$), VarPtr(Box(0))
    Def Seg

End Sub

Sub LoadIMAGE (x, y, FileNAME$)

    If InStr(FileNAME$, ".") = 0 Then FileNAME$ = FileNAME$ + ".BSV"
    Def Seg = VarSeg(Box(0))
    BLoad LCase$(FileNAME$), VarPtr(Box(0))
    Def Seg
    Wait &H3DA, 8
    Put (x, y), Box()

End Sub

Sub LoadPHASE
    Static ExPHASE
    Shared PX, PY, Trimmed, Style, MotorSTYLE
    Shared Frame, FrameCOLOR, Extension, FenderSTYLE, BarBOX, GotBOX

    If Phase <> ExPHASE Then
        If Phase = 1 Then
            HideMOUSE
            Line (20, 56)-(620, 200), 0, BF
            Line (90, 201)-(549, 280), 0, BF
            Line (90, 252)-(549, 280), 2, BF
            ShowMOUSE
        End If
        HideMOUSE
        ClearBOX
        Select Case Phase
            Case 1
                BarBOX = 0: GotBOX = 0: ImageLOADED = 0
                PX = 0: PY = 0: Trimmed = 0: Style = 0
                BikeCOLOR = 3: FlameSTYLE = 1: SetPALETTE
                LoadIMAGE 116, 300, "CHFrames"
            Case 2
                If Frame = 1 Then
                    LoadIMAGE 18, 300, "CHFrmCLR"
                Else
                    LoadIMAGE 18, 300, "CHFrmCLX"
                End If
            Case 3
                Select Case FrameCOLOR
                    Case 1
                        If Frame = 1 Then
                            LoadIMAGE 112, 300, "CHExtRP"
                        Else
                            LoadIMAGE 112, 300, "CHExtXP"
                        End If
                    Case 2
                        If Frame = 1 Then
                            LoadIMAGE 112, 300, "CHExtRB"
                        Else
                            LoadIMAGE 112, 300, "CHExtXB"
                        End If
                    Case 3
                        If Frame = 1 Then
                            LoadIMAGE 112, 300, "CHExtRC"
                        Else
                            LoadIMAGE 112, 300, "CHExtXC"
                        End If
                End Select
            Case 4
                Select Case Extension
                    Case 1: LoadIMAGE 53, 300, "CHFrksR"
                    Case 2: LoadIMAGE 53, 300, "CHFrksX"
                    Case 3: LoadIMAGE 20, 300, "CHFrksXX"
                End Select
            Case 5
                LoadIMAGE 89, 312, "CHTiresF"
            Case 6
                LoadIMAGE 170, 80, "CHPrepAR"
                If Frame = 1 Then
                    LoadIMAGE 89, 312, "CHTireRR"
                Else
                    LoadIMAGE 89, 312, "CHTireRX"
                End If
            Case 7
                LoadIMAGE 70, 310, "CHWheels"
            Case 8
                LoadIMAGE 88, 305, "CHFndrs"
            Case 9
                LoadIMAGE 140, 320, "CHMotors"
            Case 10
                If MotorSTYLE = 2 Then
                    LoadIMAGE 144, 320, "CHMtrKCL"
                Else
                    LoadIMAGE 144, 320, "CHMtrBCL"
                End If
            Case 11
                LoadIMAGE 137, 320, "CHDrives"
            Case 12
                LoadIMAGE 142, 330, "CHBDCvrs"
            Case 13
                LoadIMAGE 118, 330, "CHIntaks"
            Case 14
                LoadIMAGE 190, 320, "CHRDrvV"
            Case 15
                LoadIMAGE 102, 320, "CHRDrv7"
            Case 16
                LoadIMAGE 60, 310, "CHExBR"
            Case 17
                LoadIMAGE 42, 310, "CHExVs"
            Case 18
                LoadIMAGE 88, 320, "CHFTanks"
            Case 19
                LoadIMAGE 76, 330, "CHOTnksR"
            Case 20
                LoadIMAGE 167, 330, "CHOTnksX"
            Case 21
                LoadIMAGE 12, 310, "CHHBars"
            Case 22
                LoadIMAGE 38, 320, "CHSeats"
            Case 23
                LoadIMAGE 80, 324, "CHHDLts"
            Case 24
                Select Case FenderSTYLE
                    Case 1: LoadIMAGE 122, 320, "CHTLLTSS"
                    Case 2: LoadIMAGE 122, 320, "CHTLLTSC"
                    Case 3: LoadIMAGE 122, 320, "CHTLLTSF"
                End Select
            Case 25
                LoadIMAGE 20, 300, "CHPaint"
        End Select
        ShowMOUSE

        ExPHASE = Phase
    End If

End Sub

Sub LocateMOUSE (x, y)

    LB = 4
    MX = x
    MY = y
    MouseDRIVER LB, 0, MX, MY

End Sub

Sub MenuBAR (InOUT)
    Static MenuX, Choice, Opening, BoxX
    Shared FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, TX, TY
    Shared FrameX, FrameY, FenderSTYLE, HighPIPE, OT, GPaint, Frame

    If BoxX <> 0 Then GoSub CloseBOX
    If InOUT = 0 Then GoSub MenuDARK: Exit Sub

    Select Case MouseX
        Case 431 TO 464
            If TopMENU <> 1 Then
                GoSub MenuDARK
                MenuX = 432
                GoSub MenuLIGHT
                TopMENU = 1
            End If
        Case 513 TO 532
            If TopMENU <> 2 Then
                GoSub MenuDARK
                MenuX = 513
                GoSub MenuLIGHT
                TopMENU = 2
            End If
        Case 582 TO 602
            If TopMENU <> 3 Then
                GoSub MenuDARK
                MenuX = 582
                GoSub MenuLIGHT
                TopMENU = 3
            End If
        Case Else
            GoSub MenuDARK
    End Select

    If TopMENU And LB = -1 Then
        Select Case TopMENU
            Case 1
                HideMOUSE
                Get (416, 46)-(563, 148), MenuBOX3()
                LoadFILE "CHProMNU.BSV"
                Wait &H3DA, 8
                Put (416, 46), Box(), PSet
                BoxX = 416
                ShowMOUSE
                MenuITEM = 1
            Case 2
                HideMOUSE
                Get (472, 46)-(598, 100), MenuBOX3()
                LoadFILE "CHHlpMNU.BSV"
                Wait &H3DA, 8
                Put (492, 46), Box(), PSet
                ShowMOUSE
                BoxX = 472
                MenuITEM = 2
            Case 3: GoSub MenuDARK: System
        End Select
    End If
 
    Exit Sub

    MenuLIGHT:
    HideMOUSE
    Get (MenuX, 34)-(MenuX + 31, 44), MenuBOX()
    For x = MenuX To MenuX + 31
        For y = 34 To 44
            If Point(x, y) <> 1 Then PSet (x, y), 15
        Next y
    Next x
    ShowMOUSE
    Return

    MenuDARK:
    If TopMENU Then
        HideMOUSE
        Put (MenuX, 34), MenuBOX(), PSet
        TopMENU = 0
        ShowMOUSE
    End If
    Return

    CloseBOX:
    If BoxX Then
        HideMOUSE
        Put (BoxX, 46), MenuBOX3(), PSet
        ShowMOUSE
        BoxX = 0
    End If
    Return

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

Sub PaintSHOP (Mode)
    Shared PX, PY, Trimmed, Style
    Shared FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, TX, TY
    Shared FrameX, FrameY, FenderSTYLE, HighPIPE, OT, GPaint, Frame
    Shared WheelFX, WheelFY, WheelRX, WheelRY, Cover, Tank, TTY, TTTY

    If Mode = 0 Then GoSub UnLIGHT: Exit Sub

    Select Case MouseX
        Case 82 TO 106
            Select Case MouseY
                Case 353 TO 364
                    If PaintITEM <> 1 Then
                        GoSub UnLIGHT
                        PX = 85: PY = 356
                        GoSub LIGHT
                        PaintITEM = 1
                    End If
                Case 367 TO 378
                    If PaintITEM <> 2 Then
                        GoSub UnLIGHT
                        PX = 85: PY = 370
                        GoSub LIGHT
                        PaintITEM = 2
                    End If
                Case 381 TO 392
                    If PaintITEM <> 3 Then
                        GoSub UnLIGHT
                        PX = 85: PY = 384
                        GoSub LIGHT
                        PaintITEM = 3
                    End If
                Case 395 TO 406
                    If PaintITEM <> 4 Then
                        GoSub UnLIGHT
                        PX = 85: PY = 398
                        GoSub LIGHT
                        PaintITEM = 4
                    End If
                Case 409 TO 420
                    If PaintITEM <> 5 Then
                        GoSub UnLIGHT
                        PX = 85: PY = 412
                        GoSub LIGHT
                        PaintITEM = 5
                    End If
                Case Else
                    GoSub UnLIGHT
            End Select
        Case 172 TO 196
            Select Case MouseY
                Case 353 TO 364
                    If PaintITEM <> 6 Then
                        GoSub UnLIGHT
                        PX = 175: PY = 356
                        GoSub LIGHT
                        PaintITEM = 6
                    End If
                Case 367 TO 378
                    If PaintITEM <> 7 Then
                        GoSub UnLIGHT
                        PX = 175: PY = 370
                        GoSub LIGHT
                        PaintITEM = 7
                    End If
                Case 381 TO 392
                    If PaintITEM <> 8 Then
                        GoSub UnLIGHT
                        PX = 175: PY = 384
                        GoSub LIGHT
                        PaintITEM = 8
                    End If
                Case 395 TO 406
                    If PaintITEM <> 9 Then
                        GoSub UnLIGHT
                        PX = 175: PY = 398
                        GoSub LIGHT
                        PaintITEM = 9
                    End If
                Case 409 TO 420
                    If PaintITEM <> 10 Then
                        GoSub UnLIGHT
                        PX = 175: PY = 412
                        GoSub LIGHT
                        PaintITEM = 10
                    End If
                Case Else
                    GoSub UnLIGHT
            End Select
        Case 304 TO 328
            Select Case MouseY
                Case 353 TO 364
                    If PaintITEM <> 11 Then
                        GoSub UnLIGHT
                        PX = 307: PY = 356
                        GoSub LIGHT
                        PaintITEM = 11
                    End If
                Case 367 TO 378
                    If PaintITEM <> 12 Then
                        GoSub UnLIGHT
                        PX = 307: PY = 370
                        GoSub LIGHT
                        PaintITEM = 12
                    End If
                Case 381 TO 392
                    If PaintITEM <> 13 Then
                        GoSub UnLIGHT
                        PX = 307: PY = 384
                        GoSub LIGHT
                        PaintITEM = 13
                    End If
                Case 409 TO 420
                    If PaintITEM <> 14 Then
                        GoSub UnLIGHT
                        PX = 307: PY = 412
                        GoSub LIGHT
                        PaintITEM = 14
                    End If
                Case Else
                    GoSub UnLIGHT
            End Select
        Case 420 TO 444
            Select Case MouseY
                Case 353 TO 364
                    If PaintITEM <> 15 Then
                        GoSub UnLIGHT
                        PX = 423: PY = 356
                        GoSub LIGHT
                        PaintITEM = 15
                    End If
                Case 367 TO 378
                    If PaintITEM <> 16 Then
                        GoSub UnLIGHT
                        PX = 423: PY = 370
                        GoSub LIGHT
                        PaintITEM = 16
                    End If
                Case 381 TO 392
                    If PaintITEM <> 17 Then
                        GoSub UnLIGHT
                        PX = 423: PY = 384
                        GoSub LIGHT
                        PaintITEM = 17
                    End If
                Case 395 TO 406
                    If PaintITEM <> 18 Then
                        GoSub UnLIGHT
                        PX = 423: PY = 398
                        GoSub LIGHT
                        PaintITEM = 18
                    End If
                Case 409 TO 420
                    If PaintITEM <> 19 Then
                        GoSub UnLIGHT
                        PX = 423: PY = 412
                        GoSub LIGHT
                        PaintITEM = 19
                    End If
                Case Else
                    GoSub UnLIGHT
            End Select
        Case Else
            GoSub UnLIGHT
    End Select

    If PaintITEM And LB = -1 Then
        Select Case PaintITEM
            Case 1 TO 10: BikeCOLOR = PaintITEM - 1: SetPALETTE
            Case 11
                If Style <> 1 Then
                    If Frame = 1 And Tank = 2 Then TTTY = -6
                    GoSub NoTRIM
                    Open "ff.dat" For Input As #1
                    Select Case FenderSTYLE
                        Case 1: Open "ffsf.dat" For Input As #2
                        Case 2: Open "ffcf.dat" For Input As #2
                        Case 3: Open "ffff.dat" For Input As #2
                    End Select
                    Open "ffw.dat" For Output As #3
                    Input #1, x1, xx, y1, yy
                    Write #3, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Input #1, Value
                            Input #2, Colr
                            Write #3, Point(x, y)
                            If Value = 1 And Colr <> 0 Then PSet (x, y), Colr
                        Next y
                    Next x
                    Close #1, #2, #3
                    Open "ftnkf.dti" For Input As #1
                    Open "tnkw.dat" For Output As #2
                    Input #1, x1, xx, y1, yy
                    x1 = FrameX + x1 + TX
                    y1 = FrameY + y1 + TY + TTTY
                    Write #2, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Write #2, Point(x, y)
                            Input #1, Colr
                            If Colr <> 0 Then
                                If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 13 Then PSet (x, y), Colr
                            End If
                        Next y
                    Next x
                    Close #1, #2
                    If Cover Then
                        Open "dcpb.dat" For Input As #1
                        Open "dcw.dat" For Output As #2
                        Input #1, x1, xx, y1, yy
                        x1 = FrameX + x1
                        y1 = FrameY + y1
                        Write #2, x1, xx, y1, yy
                        For x = x1 To x1 + xx
                            For y = y1 To y1 + yy
                                Write #2, Point(x, y)
                                Input #1, Colr
                                If Colr <> 0 Then
                                    If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 10 Then PSet (x, y), Colr
                                End If
                            Next y
                        Next x
                        Close #1, #2
                    End If
                    GoSub OilTANK
                    Open "rf.dat" For Input As #1
                    Select Case FenderSTYLE
                        Case 1
                            If OT = 5 Then
                                Open "rfsrfb.dat" For Input As #2
                            Else
                                If GPaint = 1 Or FenderSTYLE = 1 Then
                                    If Frame = 1 Then
                                        Open "rfsrcg.dat" For Input As #2
                                    Else
                                        Open "rfsxcg.dat" For Input As #2
                                    End If
                                Else
                                    Open "rfs.dat" For Input As #2
                                End If
                            End If
                        Case 2
                            If OT = 5 Then
                                Open "rfcrfb.dat" For Input As #2
                            Else
                                If GPaint = 1 Then
                                    If Frame = 1 Then
                                        Open "rfcrcg.dat" For Input As #2
                                    Else
                                        Open "rfcxcg.dat" For Input As #2
                                    End If
                                Else
                                    Open "rfc.dat" For Input As #2
                                End If
                            End If
                        Case 3: Open "rff.dat" For Input As #2
                    End Select
                    Open "rfw.dat" For Output As #3
                    Input #1, x1, xx, y1, yy
                    Write #3, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Input #1, Value
                            Input #2, Colr
                            If Point(x, y) = 8 Or Point(x, y) = 12 Or Point(x, y) = 14 Then
                                Write #3, 7
                            Else
                                Write #3, Point(x, y)
                            End If
                            If Point(x, y) = 7 Or Point(x, y) = 6 Then
                                If Value = 1 And Colr <> 0 Then PSet (x, y), Colr
                            End If
                        Next y
                    Next x
                    Close #1, #2, #3
                    Trimmed = 1
                    Style = 1
                End If
            Case 12
                If Style <> 2 Then
                    If Frame = 1 And Tank = 2 Then TTTY = -6
                    GoSub NoTRIM
                    Open "ftnkf2.dti" For Input As #1
                    Open "tnkw.dat" For Output As #2
                    Input #1, xx, yy
                    x1 = FrameX + 30 + TX
                    y1 = FrameY + 12 + TY + TTTY
                    Write #2, x1, xx, y1, yy
                    For x = 0 To xx
                        For y = 0 To yy
                            Write #2, Point(x + x1, y + y1)
                            Input #1, Colr
                            If Colr <> 0 Then
                                If Point(x + x1, y + y1) = 6 Or Point(x + x1, y + y1) = 7 Or Point(x + x1, y + y1) = 13 Then PSet (x + x1, y + y1), Colr
                            End If
                        Next y
                    Next x
                    Close #1, #2
                    If Cover Then
                        Open "drcvrf2.dti" For Input As #1
                        Open "cvrw.dat" For Output As #2
                        Input #1, xx, yy
                        x1 = FrameX + 74
                        y1 = FrameY + 101
                        Write #2, x1, xx, y1, yy
                        For x = 0 To xx
                            For y = 0 To yy
                                Write #2, Point(x + x1, y + y1)
                                Input #1, Colr
                                If Colr <> 0 Then
                                    If Point(x + x1, y + y1) > 5 And Point(x + x1, y + y1) < 11 Then PSet (x + x1, y + y1), Colr
                                End If
                            Next y
                        Next x
                        Close #1, #2
                    End If
                    Style = 2
                    Trimmed = 1
                End If
            Case 13
                If Style <> 3 Then
                    GoSub NoTRIM
                    Select Case FenderSTYLE
                        Case 1: Open "ffsp.dat" For Input As #1
                        Case 2: Open "ffcp.dat" For Input As #1
                        Case 3: Open "fffp.dat" For Input As #1
                    End Select
                    Open "ff.dat" For Input As #2
                    Open "ffw.dat" For Output As #3
                    Input #2, x1, xx, y1, yy
                    Write #3, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Write #3, Point(x, y)
                            Input #1, Colr
                            Input #2, Value
                            If Value = 1 Then
                                If Colr <> 0 Then PSet (x, y), Colr
                            End If
                        Next y
                    Next x
                    Close #1, #2, #3
                    If Frame = 1 Then
                        Open "dtr.dat" For Input As #1
                    Else
                        Open "dtx.dat" For Input As #1
                    End If
                    Open "dtw.dat" For Output As #2
                    Input #1, x1, xx, y1, yy
                    x1 = FrameX + x1
                    y1 = FrameY + y1
                    Write #2, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Write #2, Point(x, y)
                            Input #1, Colr
                            If Colr <> 0 Then
                                If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 13 Then PSet (x, y), Colr
                            End If
                        Next y
                    Next x
                    Close #1, #2
                    Select Case Tank
                        Case 1: Open "ftnktdp.dat" For Input As #1
                        Case 2: Open "ftnkscp.dat" For Input As #1
                        Case 3: Open "ftnkosp.dat" For Input As #1
                        Case 4: Open "ftnkcbp.dat" For Input As #1
                        Case 5: Open "ftnkbrp.dat" For Input As #1
                    End Select
                    Open "tnkw.dat" For Output As #2
                    Input #1, x1, xx, y1, yy
                    x1 = x1 + FrameX
                    y1 = y1 + FrameY + TTY
                    Write #2, x1, xx, y1, yy
                    HideMOUSE
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            Write #2, Point(x, y)
                            Input #1, Colr
                            If Colr <> 0 Then
                                If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 13 Then PSet (x, y), Colr
                            End If
                        Next y
                    Next x
                    ShowMOUSE
                    Close #1, #2
                    If Cover Then
                        Open "dcpb.dat" For Input As #1
                        Open "dcw.dat" For Output As #2
                        Input #1, x1, xx, y1, yy
                        x1 = FrameX + x1
                        y1 = FrameY + y1
                        Write #2, x1, xx, y1, yy
                        For x = x1 To x1 + xx
                            For y = y1 To y1 + yy
                                Write #2, Point(x, y)
                                Input #1, Colr
                                If Colr <> 0 Then
                                    If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 10 Then PSet (x, y), Colr
                                End If
                            Next y
                        Next x
                        Close #1, #2
                    End If
                    GoSub OilTANK
                    Select Case FenderSTYLE
                        Case 1: Open "rfsp.dat" For Input As #1
                        Case 2: Open "rfcp.dat" For Input As #1
                        Case 3: Open "rffp.dat" For Input As #1
                    End Select
                    Open "rf.dat" For Input As #2
                    Open "rfw.dat" For Output As #3
                    Input #2, x1, xx, y1, yy
                    Write #3, x1, xx, y1, yy
                    For x = x1 To x1 + xx
                        For y = y1 To y1 + yy
                            If Point(x, y) = 8 Or Point(x, y) = 12 Or Point(x, y) = 14 Then
                                Write #3, 7
                            Else
                                Write #3, Point(x, y)
                            End If
                            Input #1, Colr
                            Input #2, Value
                            If Value = 1 Then
                                If Colr <> 0 Then
                                    If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 13 Then PSet (x, y), Colr
                                End If
                            End If
                        Next y
                    Next x
                    Close #1, #2, #3
                    Style = 3
                    Trimmed = 1
                End If
            Case 14
                GoSub NoTRIM
            Case 15: FlameSTYLE = 1: SetPALETTE
            Case 16: FlameSTYLE = 0: SetPALETTE
            Case 17: FlameSTYLE = 2: SetPALETTE
            Case 18: FlameSTYLE = 3: SetPALETTE
            Case 19: FlameSTYLE = 4: SetPALETTE
        End Select
    End If

    Exit Sub

    UnLIGHT:
    If PaintITEM Then
        HideMOUSE
        Put (PX, PY), MenuBOX(), PSet
        ShowMOUSE
        PaintITEM = 0
    End If
    Return

    LIGHT:
    HideMOUSE
    Get (PX, PY)-(PX + 18, PY + 5), MenuBOX()
    Line (PX + 1, PY + 1)-(PX + 17, PY + 4), 15, BF
    ShowMOUSE
    Return

    NoTRIM:
    If Trimmed Then
        Select Case Style
            Case 1
                HideMOUSE
                Open "ffw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                Open "tnkw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                If Cover Then
                    Open "dcw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                If OT = 1 Or OT = 3 Or OT = 5 Then
                    Open "otw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                Open "rfw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                ShowMOUSE
            Case 2
                HideMOUSE
                Open "tnkw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                If Cover Then
                    Open "dcw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                If OT = 1 Or OT = 3 Or OT = 5 Then
                    Open "otw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                ShowMOUSE
            Case 3
                HideMOUSE
                Open "ffw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                Open "dtw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                Open "tnkw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                If Cover Then
                    Open "dcw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                If OT = 1 Or OT = 3 Or OT = 5 Then
                    Open "otw.dat" For Input As #1
                    GoSub FileDAT
                    Close #1
                End If
                Open "rfw.dat" For Input As #1
                GoSub FileDAT
                Close #1
                ShowMOUSE
        End Select
        Trimmed = 0
        Style = 0
    End If
    Return

    OilTANK:
    If OT = 1 Or OT = 3 Or OT = 5 Then
        If OT = 1 Then
            Open "oth.dat" For Input As #1
            Input #1, x1, xx, y1, yy
        End If
        If OT = 3 Then
            Open "otc.dat" For Input As #1
            Input #1, x1, xx, y1, yy
        End If
        If OT = 5 Then
            Open "otbp.dat" For Input As #1
            Input #1, x1, xx, y1, yy
        End If
        Open "otw.dat" For Output As #2
        x1 = FrameX + x1
        y1 = FrameY + y1
        Write #2, x1, xx, y1, yy
        For x = x1 To x1 + xx
            For y = y1 To y1 + yy
                Write #2, Point(x, y)
                Input #1, Colr
                If Colr <> 0 Then
                    If Point(x, y) = 6 Or Point(x, y) = 7 Or Point(x, y) = 13 Then PSet (x, y), Colr
                End If
            Next y
        Next x
        Close #1, #2
    End If
    Return

    FileDAT:
    Input #1, x1, xx, y1, yy
    For x = x1 To x1 + xx
        For y = y1 To y1 + yy
            Input #1, Colr
            PSet (x, y), Colr
        Next y
    Next x
    Return

End Sub

Sub PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


    Shared Key$

    Do
        Key$ = UCase$(InKey$)
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB <> OldLB Or RB <> OldRB Or MouseX <> OldMX Or MouseY <> OldMY Or Key$ <> ""

End Sub

Sub PrintSTRING (x, y, Prnt$)

    Def Seg = VarSeg(Box(0))
    BLoad "chmssr.fbs", VarPtr(Box(0))
    Def Seg

    For i = 1 To Len(Prnt$)
        Char$ = Mid$(Prnt$, i, 1)
        If Char$ = " " Then
            x = x + Box(1)
        Else
            Index = (Asc(Char$) - 33) * Box(0) + 2
            Put (x, y), Box(Index)
            x = x + Box(Index)
        End If
    Next i

End Sub

Sub ProjectMENU
    Static ProITEM, ProY

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        Select Case MouseX
            Case 423 TO 552
                Select Case MouseY
                    Case 34 TO 55
                        GoSub DarkPRO
                        If MouseX > 464 Then GoSub ClosePRO
                    Case 56 TO 71
                        If ProITEM <> 1 Then
                            GoSub DarkPRO
                            ProY = 59
                            GoSub LightPRO
                            ProITEM = 1
                        End If
                    Case 72 TO 87
                        If ProITEM <> 2 Then
                            GoSub DarkPRO
                            ProY = 75
                            GoSub LightPRO
                            ProITEM = 2
                        End If
                    Case Else: GoSub ClosePRO
                End Select
            Case Else: GoSub ClosePRO
        End Select

        If ProITEM <> 0 And LB = -1 Then
            Select Case ProITEM
                Case 1
                    Phase = 1
                    GoSub ClosePRO
                Case 2
                    GoSub DarkPRO
                    MenuITEM = 0
                    MenuBAR 0
                    HideMOUSE
                    Get (178, 60)-(460, 152), Box(10000)
                    LoadFILE "CHSaveBM.BSV"
                    Put (178, 60), Box(), PSet
                    ShowMOUSE
                    GoSub GetNAME
                    HideMOUSE
                    Put (178, 60), Box(10000), PSet
                    ShowMOUSE
                    If Len(FileNAME$) Then
                        FileNAME$ = LTrim$(RTrim$(FileNAME$))
                        If InStr(FileNAME$, " ") Or Len(FileNAME$) > 8 Then
                            LongNAME = 1
                            LongFILENAME$ = FileNAME$ + ".BMP"
                            For n = 1 To Len(FileNAME$)
                                Char$ = Mid$(FileNAME$, n, 1)
                                If Char$ <> " " Then NewFILENAME$ = NewFILENAME$ + Char$
                            Next n
                            FileNAME$ = RTrim$(Left$(NewFILENAME$, 6)) + "~1"
                            FileNAME$ = FileNAME$ + ".TBM"
                        Else
                            FileNAME$ = FileNAME$ + ".BMP"
                        End If
                        HideMOUSE
                        Get (90, 250)-(549, 348), Box(5000)
                        Line (90, 250)-(100, 310), 0, BF
                        Line (539, 250)-(549, 310), 0, BF
                        Line (90, 285)-(549, 310), 0, BF
                        Line (95, 55)-(544, 305), 3, B
                        Line (115, 310)-(524, 348), 0, BF
                        LoadFILE "CHGenBMP.BSV"
                        Put (90, 310), Box(), PSet

                        FourBIT 90, 50, 549, 310, FileNAME$

                        Line (95, 55)-(544, 305), 0, B
                        Put (90, 250), Box(5000), PSet
                        ShowMOUSE
                        If LongNAME = 1 Then
                            Shell "REN " + FileNAME$ + " TMP.TBM"
                            Shell "REN TMP.TBM " + Chr$(34) + LongFILENAME$ + Chr$(34)
                            LongNAME = 0
                        End If
                    End If
                    Exit Sub
            End Select
        End If

    Loop

    Exit Sub

    LightPRO:
    HideMOUSE
    Get (430, ProY)-(560, ProY + 10), MenuBOX2()
    For x = 430 To 560
        For y = ProY To ProY + 10
            If Point(x, y) = 3 Then PSet (x, y), 15
        Next y
    Next x
    ShowMOUSE
    Return

    DarkPRO:
    If ProITEM Then
        HideMOUSE
        Put (430, ProY), MenuBOX2(), PSet
        ShowMOUSE
        ProITEM = 0
    End If
    Return

    ClosePRO:
    GoSub DarkPRO
    MenuITEM = 0
    MenuBAR 0
    Exit Sub
    Return

    GetNAME:
    CheckCHAR$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
    n$ = "": ky$ = "": PrintX = 242: CharNUM = 1

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        ky$ = InKey$
        Line (PrintX + 2, 118)-(PrintX + 2, 128), 5
        If Len(ky$) Then
            Select Case Asc(ky$)
                Case 8
                    If Len(n$) > 0 Then
                        HideMOUSE
                        CharNUM = CharNUM - 1
                        Line (FChar(CharNUM), 118)-(PrintX + 2, 129), 15, BF
                        PrintX = FChar(CharNUM)
                        n$ = Mid$(n$, 1, Len(n$) - 1)
                        Line (PrintX + 2, 118)-(PrintX + 2, 128), 5
                        ShowMOUSE
                    End If
                Case 13
                    FileNAME$ = n$
                    n$ = ""
                    ky$ = ""
                    Return
                Case Else
                    If InStr(CheckCHAR$, ky$) Then
                        If PrintX < 390 Then
                            FChar(CharNUM) = PrintX
                            CharNUM = CharNUM + 1
                            HideMOUSE
                            Line (PrintX + 2, 118)-(PrintX + 2, 128), 15
                            PrintSTRING PrintX, 118, ky$
                            Line (PrintX + 2, 118)-(PrintX + 2, 128), 5
                            ShowMOUSE
                            n$ = n$ + ky$
                        End If
                    End If
            End Select
        End If
    Loop
    Return

End Sub

Function Seeker (x, y, Mode)

    Select Case Mode
        Case 0 'left side
            For xx = x To x + 140
                For yy = y To y + 100
                    If Point(xx, yy) = 6 Or Point(xx, yy) = 7 Then Seeker = xx: Exit Function
                Next yy
            Next xx
        Case 1 'right side
            For xx = x + 140 To x Step -1
                For yy = y To y + 100
                    If Point(xx, yy) = 6 Or Point(xx, yy) = 7 Then Seeker = xx: Exit Function
                Next yy
            Next xx
        Case 2 'top
            For yy = y To y + 100
                For xx = x To x + 140
                    If Point(xx, yy) = 6 Or Point(xx, yy) = 7 Then Seeker = yy: Exit Function
                Next xx
            Next yy
        Case 3 'bottom
            For yy = y + 100 To y Step -1
                For xx = x To x + 140
                    If Point(xx, yy) = 6 Or Point(xx, yy) = 7 Then Seeker = yy: Exit Function
                Next xx
            Next yy
    End Select

End Function

Sub SetPALETTE

    Restore PaletteDATA
    Out &H3C8, 0
    For n = 1 To 18
        Read Colr
        Out &H3C9, Colr
    Next n

    Restore CustomCOLORS
    ReDim Colors(6)
    For n = 0 To 6
        Read Colors(n)
    Next n

    CColor = 0
    For n = 0 To 6
        Out &H3C8, Colors(n)
        For i = 1 To 3
            Out &H3C9, CustomCOLORS(BikeCOLOR, CColor)
            CColor = CColor + 1
        Next i
    Next n

    If FlameSTYLE Then
        Select Case FlameSTYLE
            Case 1: Restore FlameCOLOR
            Case 2: Restore SilverCOLOR
            Case 3: Restore GoldCOLOR
            Case 4: Restore WhiteCOLOR
        End Select
        Out &H3C8, 8
        For i = 1 To 3
            Read Colr: Out &H3C9, Colr
        Next i
        Out &H3C8, 12
        For i = 1 To 3
            Read Colr: Out &H3C9, Colr
        Next i
        Out &H3C8, 14
        For i = 1 To 3
            Read Colr: Out &H3C9, Colr
        Next i
    End If

    Out &H3C8, 9: Out &H3C9, 21: Out &H3C9, 21: Out &H3C9, 63
    Out &H3C8, 11: Out &H3C9, 63: Out &H3C9, 0: Out &H3C9, 0

End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
End Sub

Sub Tire (x, y, Outer, Inner)

    Circle (x, y), Outer, 2
    Circle Step(0, 0), Inner, 2
    PaintSPOT = Outer - 4
    Paint (x, y - PaintSPOT), 1, 2
    Circle (x, y), Outer, 1
    Circle (x, y), Outer - 1, 2, 30 * Degree!, 210 * Degree!
    Circle (x, y), Outer - 3, 2, 30 * Degree!, 210 * Degree!
    Tread x, y, Outer - 1, 120, 300, 5
    Tread x, y, Outer - 3, 120, 300, 5
    Tread x, y, Outer - 1, 300, 475, 2
    Tread x, y, Outer - 3, 300, 475, 2
    If Outer - Inner > 14 Then
        Circle (x, y), Outer - 6, 2, 30 * Degree!, 210 * Degree!
        Tread x, y, Outer - 6, 120, 300, 5
        Tread x, y, Outer - 6, 300, 475, 2
    End If

End Sub

Sub Tread (x, y, Radius, StartDEG, StopDEG, Colr)

    For n = StartDEG To StopDEG Step 5
        Adj = Radius * Sin(n * Degree!)
        Opp = Radius * Cos(n * Degree!)
        PSet (x + Adj, y + Opp), Colr
    Next n

End Sub

