'CHDIR ".\samples\qb45com\action\arqanoid"

DECLARE SUB DoEnding ()
DECLARE SUB DoLogos ()
DECLARE SUB LoadTitle ()
DECLARE SUB DoIntro ()
DECLARE SUB DoStory ()
DECLARE SUB LoadFlyExpImage ()
DECLARE SUB DoLangaw (Stat%)
DECLARE SUB CheckforLangaw (X%, Y%)
DECLARE SUB CalcLangawCoord ()
DECLARE SUB PutLangaw (X%, Y%, Axn%)
DECLARE SUB LoadLangawImage ()
DECLARE FUNCTION DoTimer% (MaxTime%)
DECLARE SUB PrintLives (EraseIt%)
DECLARE SUB CalcBombCoord (RandFactor%)
DECLARE SUB CheatError ()
DECLARE FUNCTION RGBCounter% (MaxCounter%)
DECLARE SUB EraseSaveFiles ()
DECLARE SUB Check4HoF ()
DECLARE SUB SortIt ()
DECLARE FUNCTION SubMenu% ()
DECLARE FUNCTION PullDown% (X%, Y%, Item$(), Italic%)
DECLARE SUB NameEntry ()
DECLARE SUB DoHallOfFame ()
DECLARE SUB LoadSaveFiles ()
DECLARE SUB DialogBox (X%, Y%, MaxLen%, MinColor%, Title$, Text$, Italic%, Sysmod%)
DECLARE SUB LoadGame ()
DECLARE SUB SaveGame ()
DECLARE SUB ScrollKgenTT (TopY%, Text$, Xscale%, Yscale%, MinColor%, Shadow%, OverTop%, OverTopY%, Italic%, FirstTime%)
DECLARE SUB DoCredits ()
DECLARE SUB DoGameOver ()
DECLARE SUB KgenTTFont (X%, Y%, Font$, MinColor%, Xscale%, Yscale%, Italic%)
DECLARE SUB GetDirection ()
DECLARE SUB SfxOpenDialog ()
DECLARE FUNCTION SpecialStage% (DX%, DY%, MaxLen%, Tmin%, Title$, Text$)
DECLARE SUB SfxPowerUp ()
DECLARE FUNCTION CheckPowerCaps% (X%, Y%)
DECLARE SUB DoPowerCaps (PowType%)
DECLARE SUB PutPowerCapsBG ()
DECLARE SUB GetPowerCapsBG ()
DECLARE SUB PutPowerCaps (X%, Y%, PowType%)
DECLARE SUB DoPadLsr ()
DECLARE SUB PutPadLsrBG (Image1%(), Image2%())
DECLARE SUB GetPadLsrBG (Image1%(), Image2%())
DECLARE SUB GetPadLsrCoord (I%)
DECLARE SUB PutPadLsr (X%, Y%)
DECLARE SUB LoadPadLsrImage ()
DECLARE SUB DrawBoss (BossX%, BossY%, BossFile$)
DECLARE SUB HazyFx ()
DECLARE SUB LoadPowerCapsImage ()
DECLARE SUB DoBallExp ()
DECLARE SUB LoadBallExpImage ()
DECLARE SUB LoadBallImage ()
DECLARE SUB LoadPaddleImage ()
DECLARE SUB DrawSpike (X%, Y%)
DECLARE FUNCTION MenuSub% ()
DECLARE SUB SndExplode ()
DECLARE SUB PutPointer (X%, Y%, X2%, Y2%)
DECLARE FUNCTION Menu% ()
DECLARE SUB LoadPointerImage ()
DECLARE SUB EraseKgen ()
DECLARE SUB FadeStep (R%, g%, B%)
DECLARE SUB GetBlkHoleBG ()
DECLARE SUB PutBlkHoleBG ()
DECLARE SUB GetBG (X1%, Y1%, X2%, Y2%, Image%())
DECLARE SUB DoExplode ()
DECLARE SUB LoadExplodeImage ()
DECLARE SUB PutBombBG ()
DECLARE SUB PutBomb (X%, Y%, Switch%)
DECLARE SUB DoBlkHole ()
DECLARE SUB DoBomb ()
DECLARE SUB PutBlkHole (X%, Y%)
DECLARE SUB PrintLevel ()
DECLARE SUB RefreshKey ()
DECLARE SUB MakeImageIndex (ImageArray%(), IndexArray%())
DECLARE SUB InitImageData (FileName$, ImageArray%())
DECLARE SUB LevelDoneBox ()
DECLARE SUB InitTrans ()
DECLARE SUB TransLuc (n%, X1%, Y1%, X2%, Y2%)
DECLARE SUB CheckBounceCounter (BounceCounter%)
DECLARE SUB ReInitBallSpd ()
DECLARE SUB RotateRGB ()
DECLARE SUB PrintScore ()
DECLARE SUB KgenFont (X%, Y%, Font$, MinColor%, Italic%)
DECLARE SUB LimitScore ()
DECLARE SUB ReinitValues ()
DECLARE SUB SelectLevel ()
DECLARE FUNCTION BossHit% (X%, Y%)
DECLARE SUB BlinkTile (Switch%)
DECLARE SUB CheckTile (X%, Y%)
DECLARE FUNCTION HitSpike% (X%, Y%)
DECLARE SUB StartGame ()
DECLARE SUB BlinkBoss ()
DECLARE SUB Init ()
DECLARE SUB RestoreColors ()
DECLARE SUB HideBuild ()
DECLARE SUB SaveColors ()
DECLARE SUB ReadRGB (C%, R%, g%, B%)
DECLARE SUB Fade (R%, g%, B%)
DECLARE SUB OpenLvlFile (File$)
DECLARE SUB DrawTile (X%, Y%, Clr%)
DECLARE SUB PlayGame ()
DECLARE SUB InitNums ()
DECLARE SUB PrintNum (X%, Y%, n$)
DECLARE FUNCTION Format$ (Score&)
DECLARE SUB PrintFonts (X%, Y%, n$)
DECLARE SUB DrawFonts ()
DECLARE SUB InitFonts ()
DECLARE FUNCTION Inside% (X%, Y%, X1%, Y1%, X2%, Y2%)
DECLARE SUB ReadLevel (Lvl%)
DECLARE SUB GetTileBackGround ()
DECLARE SUB InitValues ()
DECLARE SUB DrawBorder ()
DECLARE FUNCTION Collide% ()
DECLARE SUB GetBallCenter (BallCenterX%, BallCenterY%)
DECLARE SUB PutPaddle (PadX%, PadY%)
DECLARE FUNCTION MovePaddle% (PadX%, PadY%)
DECLARE SUB GetPaddleBG (PadX%, PadY%)
DECLARE FUNCTION FastKB% ()
DECLARE SUB PutBall (BallX%, BallY%)
DECLARE SUB GetBallBG (BallX%, BallY%)
DECLARE SUB PutBallBG (BallOldX%, BallOldY%)
DECLARE SUB DrawLevelBG (BGMode%, ColorStep%, ColorAttr%)
DECLARE SUB WriteRGB (C%, R%, g%, B%)
DECLARE SUB InitColors ()
DECLARE SUB MilliDelay (msecs%)
DECLARE SUB PutPaddleBG (PadOldX%, PadOldY%)
DECLARE SUB LoadBombImage ()
DECLARE SUB LoadBlkHoleImage ()
DefInt A-Z
Rem $DYNAMIC


'==========Type declarations====================================
Type TileType
    X As Integer
    Y As Integer
    C As Integer
    F As Integer
End Type

Type RGBtype
    R As Integer
    g As Integer
    B As Integer
End Type

Type CoordType
    X As Integer
    Y As Integer
End Type

Type SaveType
    Num As Integer
    Namer As String * 12
    Score As Long
    Level As Integer
    Lives As Integer
End Type

Type HallOfFameType
    Rank As Integer
    Namer As String * 12
    Score As Long
End Type



'====================Constants==================================
'Misc Const
Const False = 0, True = Not False

'Screen const
Const MinX = 0, MaxX = 260, MinY = 0, MaxY = 200

'KeyConstants
Const KRight = 77, KLeft = 75, KDown = 80, KUp = 72, KEsc = 1
Const KW = &H11, KA = &H1E, KS = &H1F, KD = &H20, KPgd = &H51
Const KSpc = &H39, KEnt = &H1C, KCtrl = &H1D, KTab = &HF, KEnd = &H4F


'Paddle Const
Const PadSpd = 3
'Ball Const
Const BallRadius = 4

'Color Const
Const PadColorMin = 30, PadColorMax = 39
Const BorderMin = 40, Bordermax = 47
Const SpikeMin = 50, SpikeMax = 57
Const TcolorMin = 60, TcolorMax = 93
Const FColorMin = 96, FcolorMax = 100
Const KgenMin = 220, KgenMax = 227
Const KgenBlueMin = 228, KgenBlueMax = 235
Const KgenGreenMin = 236, KgenGreenMax = 243
Const SnColorMin = 101, SnColorMax = 105
Const BossColorMin = 106, BossColorMax = 121

'Offset and Tile Const
Const OffsetBG = 122 'TileY=19(0 to 180/6), TileX=12(0 to 220/20)
Const TileMax = 227 '0 to 227
Const TileW = 19, TileH = 5 ' 0 to 19, 0 to 5 (20*6)

'Font constant
Const FontOffset = 12 'Size of SmallFonts

'Directional Const
Const UR = 1, UL = 2, DR = 3, DL = 4

'RGBCounter
Const RGBC = 7 'for Counter of RotateRGB/RGBCounter function


'==================Shared Arrays===================
Dim Shared Ball(1), BallBG(30), BallIndex(1)
Dim Shared Paddle(1), PaddleIndex(1), PaddleBG(181 * 2)
Dim Shared BackGround(27816) 'BackGround for erasing tiles
Dim Shared SpikeBG(1) 'BackGround for erasing tiles
Dim Shared Tile(TileMax) As TileType
Dim Shared Trans(256)
Dim Shared SavRGB(0 To 255) As RGBtype
Dim Shared Boss(1), BossMask(1), BossBG(1)
Dim Shared BlkHole(1), BlkHoleMsk(1), BlkHoleIndex(1)
Dim Shared BlkHoleXY(1 To 4) As CoordType
Dim Shared BlkHoleBG(130 * 4)
Dim Shared Bomb(1), BombMsk(1), BombIndex(1)
Dim Shared BombXY(1 To 91) As CoordType
Dim Shared BombBG(130 * 91)
Dim Shared Explode(1 To 1), Explodemsk(1 To 1), ExplodeIndex(1 To 1)
Dim Shared BallExp(1 To 1), BallExpmsk(1 To 1), BallExpIndex(1 To 1)
Dim Shared Pointer(1 To 1), PointerIndex(1 To 1)
Dim Shared PowerCaps(1), PowerCapsIndex(1)
Dim Shared PowerCapsBG(1), PowerCapsCoord(0) As CoordType, PowerCapsOldCoord(0) As CoordType
Dim Shared Padlsr(1), PadlsrIndex(1), PadLsrCoord(1) As CoordType '(0 to 1)
Dim Shared PadLsrBG1(1), PadLsrBG2(1), PadLsrOldCoord(1) As CoordType
Dim Shared Save(1 To 8) As SaveType
Dim Shared Hall(1 To 5) As HallOfFameType
Dim Shared Langaw(1 To 1), LangawIndex(1 To 1), LangawCoord(1) As CoordType
Dim Shared LangawOldCoord(1) As CoordType, LangawBG1(1), LangawBG2(1), FlyExp(1)
Dim Shared FlyExpIndex(1)

'==================Non-Global Arrays===============
Dim SmallFonts(396) As Integer
Dim SmallNum(132) As Integer

'==================Shared Variables
Dim Shared BallOldX, BallOldY, BallX, BallY, BallXV, BallYV, Direction
Dim Shared BallCenterX, BallCenterY 'Used to Process collission detection
Dim Shared PadX, PadY, PadOldX, PadOldY
Dim Shared Finished, BallSpd, Score&, OutStart, BounceCounter
Dim Shared ColorAttr, ColorStep
Dim Shared Level, TileNumber, GameOver, BossLife, BombNum, BombDes, MaxBomb, Lives
Dim Shared PadPower, Replicant, BombSTG, BossStg
Dim Shared SdHitPad, SdHitBoss, SdHitTile
Dim Shared BossX, BossY, BossEnter, SpStage
Dim Shared Shooting, Power, PowerType, Lshot, Rshot, AutoFire
Dim Shared Path$


Randomize Timer

Cls
Screen 13

'Path$ = "C:\qbasic\Arqanoid\"
'Path$ = "c:\rel\arqanoid\"
Path$ = ""
Init



Do

    PlayGame

Loop Until GameOver

Fade 0, 0, 0

DoGameOver


Cls
Screen 0
End

'====Data statements
Credits:


Data "GOD/Jesus Christ"
Data "   Gave me everything I have. LIFE."
Data ""

Data "Richard Eric M. Lope BSN RN"
Data "   Coding/Story/Sound/Grafix(Mostly)."
Data ""

Data "Anya Therese Lope"
Data "   Cutest & Loudest baby in the world!"
Data ""

Data "Pedro & Lily Lope"
Data "   For their undying support."
Data ""

Data "Marie & Cristina Lope"
Data "   Twinblades of Sara,Iloilo."
Data ""

Data "Loreni Farillon"
Data "   Kitiki-TXT.2k dtym 2snd SMS L8@Nyt."
Data ""

Data "WIC I-net/Jason Babila,Alan,Shote&Tin2"
Data "   Mabini St. Iloilo city."
Data ""
                     
Data "Archie Aurelio/Joey of Zap Zone"
Data "   Arcade Game buddies."
Data ""

Data "Special Thanks!!!"
Data ""
Data ""


Data "Andrew Ayers (Blast Lib maker)"
Data "   For his tutor on Get/Put offsetting."
Data ""

Data "Chris Chadwick (PP256 Developer)"
Data "   PP256 made my life easier!!!"
Data ""

Data "Vance Velez (Vplanet)"
Data "   Best Review site!!!"
Data ""

Data "Gianncarlo (GBGames)"
Data "   Best QB link ever!!!"
Data ""

Data "Jorden Chamid (FutureSoft)"
Data "   Best QB site. Period!!!"
Data ""

Data "Vic Luce (VQB Maker)"
Data "   Great tutorial on Masking."
Data ""

Data "Danny Gump (VirtuaSoft-Dash Lib Maker)"
Data "   Taught me the Get/Put Array system."
Data ""

Data "ZKman (?????)"
Data "   Translucency(Non Alpha) Tutorial."
Data ""


Data "Steven Sivek (stevensivek@hotmail.com)"
Data "   For the ROM address/Offset of text."
Data ""

Data "Dark Dread (Darkness Etherial)"
Data "   DCrown perked me up 2 make a QBGame."
Data ""

Data "Andre(who are you?)"
Data "   Used his MilliDelay in this game."
Data ""

Data "Nesticle"
Data "   Heaven sent emulator!"
Data ""

Data "Kgen and LoopyNes"
Data "   Great emulators!"
Data ""

Data "The QB Times"
Data "   Provided me with BMP file system."
Data ""

Data "NeoZones"
Data "   Got a lot of tutorials there!"
Data ""

Data "KONAMI(tm)"
Data "   Ripped their LifeForce sprites."
Data ""

Data "IREM(tm),COMPILE(tm) & Broderbund(tm)"
Data "   Ripped their Guardian Legend sprs."
Data ""

Data "TAXAN(tm)"
Data "   Ripped their Burai Fighter sprites."
Data ""

Data "The Smashing Pumpkins"
Data "   Best band in the world. Forever!"
Data ""

Data "PSYKYO"
Data "   Strikers Series...Best Arcade Game!"
Data ""

Data "Samurai X & DragonBall Z"
Data "   Animes I like very much."
Data ""

Data ""
Data ""
Data ""
Data ""
Data ""

Data "End"



Story:

Data "    From days of long ago, from the "
Data "uncharted regions fo the universe, "
Data "comes a legend... the Legend of"
Data "BALOTRON!(Yeah, right. sounds familiar)"
Data ""
Data "    One day, while the people of"
Data "BALOTLAND were living peacefully,"
Data "Ten long years post the victory of their"
Data "Gredius,Goardic, and Buray missions, a"
Data "Balotland shattering BALOTQUAKE occured!"
Data ""
Data "    The inhabitants of BalotLand(Paddle-"
Data "Like beings) panicked! And in the "
Data "confusion the bacterial beings,"
Data "imprisoned underground for ten years, "
Data "led by the ever charming GIGA, seized"
Data "control of the planet and imprisoned"
Data "most of the BalotLings.  While the"
Data "others were forced to do mining at"
Data "the Obsidian lake which has precious"
Data "stones below it, including Balotron's"
Data "love, Balotae! BTW, Balotron wasn't"
Data "captured(He was taking a nap outside"
Data "the city. Or else we won't have a story)."
Data ""
Data "     Now armed w/ his trusty BALOTBALL,"
Data "both embarked on a journey to save the "
Data "people of Balotland.  But before they "
Data "could save them and face GIGA, they"
Data "must defeat his governors of Pain, and"
Data "his army of... well, what else... "
Data "COLORFUL BLOCKS!"
Data "Nuff said! Let's begin..."
Data ""
Data ""
Data ""
Data ""
Data ""
Data ""
Data "END"

Ending:

Data 0,"--THE END--",220
Data 20,"Balotron together w/ his friend",228
Data 30,"Boy Balot, rescued princess",228
Data 40,"Balotae from the clutches",228
Data 50,"of GIGA, and his minions.",228
Data 60,"the people of Balotland",228
Data 70,"rejoiced and made our hero",228
Data 80,"their king! (He wasn't",228
Data 90,"supposed to be, but he married",228
Data 100,"the princess so he will be.)",228
Data 110,"Lucky him....",228
Data 130,"However....",236
Data 140,"this is an arcade game.",236
Data 150,"so you have to continue your",236
Data 160,"quest. Right from the start...",236
Data 190,"End",228

'====End data



'=================temp

'-===================================================


Temp:

End

Rem $STATIC
Sub BlinkBoss Static

    Wait &H3DA, 8
    Sound 1000, .2
    Sound 500, .4

    For I = 106 To 121
        WriteRGB I, 0, 63, Int(Rnd * 63)
    Next I

    Sound 1000, .3
    Sound 700, .2
    Wait &H3DA, 8

    For I = 106 To 121
        R = SavRGB(I).R
        g = SavRGB(I).g
        B = SavRGB(I).B
        WriteRGB I, R, g, B
    Next I

    Sound 1000, .2

End Sub

Sub BlinkTile (Switch%) Static

    If Switch Then
        For I = 84 To 86
            WriteRGB I, 63, 0, Int(Rnd * 63)
        Next I
    Else
        For I = 84 To 86
            R = SavRGB(I).R
            g = SavRGB(I).g
            B = SavRGB(I).B
            WriteRGB I, R, g, B
        Next I
    End If

End Sub

Function BossHit (X, Y) Static



    BossHit = False
    If Point(X, Y) >= BossColorMin And Point(X, Y) <= BossColorMax Then
        BossHit = True
        BlinkBoss
        Score& = Score& + 2000&
        LimitScore
        PrintScore
        BossLife = BossLife - 100
        Rem GOSUB InitPwrCaps   'Disabled for OverKill Reasons unrem if u want 2 have powerups on bosses
        GoSub CheckBossKilled
    End If


    Exit Function


    '=========Subs===============

    CheckBossKilled:

    If BossLife <= 0 Then

        PutBlkHoleBG
        PutBombBG
        LevelDoneBox
        EraseKgen
        PrintLives True

        T1& = Timer
                       
        Do
            T2& = Timer
            KK$ = InKey$
            If KK$ = Chr$(13) Then Exit Do

            DoExplode
            FadeStep 0, 0, 0

            SndExplode
        Loop Until T2& - T1& > 9&

        Finished = True
        If Level = 50 Then
            DoEnding
        End If

    End If

    Return

    '==================
    InitPwrCaps:

    If Not Power Then

        PowPow = Int(Rnd * 5)
        If PowPow = 1 Then
            Power = True
            PowerCapsCoord(0).X = 10 + Int(Rnd * 220)
            PowerCapsCoord(0).Y = 10 + Int(Rnd * 50)
            PutPadLsrBG PadLsrBG1(), PadLsrBG2()
            GetPowerCapsBG
            PowerType = 1 + Int(Rnd * 3)
        End If
    End If

    Return


End Function

Sub CalcBombCoord (RandFactor) Static

    I = 0
    For Y = 10 To 108 Step 16
        For X = 26 To 220 Step 16
            Rand = 1 + Int(Rnd * RandFactor)
            If Rand = 1 Then
                If I < 100 Then
                    I = I + 1
                    BombXY(I).X = X
                    BombXY(I).Y = Y
                End If
            End If
        Next X
    Next Y

    BombNum = I
    MaxBomb = BombNum
    BombSTG = True


End Sub

Sub CalcLangawCoord Static

    LangawCoord(0).X = BlkHoleXY(1 + Int(Rnd * 4)).X
    LangawCoord(0).Y = BlkHoleXY(1 + Int(Rnd * 4)).Y
    LangawCoord(1).X = BlkHoleXY(1 + Int(Rnd * 4)).X
    LangawCoord(1).Y = BlkHoleXY(1 + Int(Rnd * 4)).Y

    GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
    GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()

End Sub

Sub CheatError Static

    DX = 26
    DY = 40
    MaxLen = 26
    Title$ = "     Cheat Error!!!"
    Tmin = PadColorMin
    Sysmod = True
    Text$ = Chr$(11) + " Sorry! I intentionally disabled this cheat code on SPECIAL STAGES because I think it would be an overkill... ie. 2 easy a game."
    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod


End Sub

Sub Check4HoF Static

    If Score& > Hall(5).Score Then
        NameEntry
    End If

End Sub

Sub CheckBounceCounter (BounceCounter) Static

    If BounceCounter < 50 Then
        BounceCounter = BounceCounter + 1
    End If
    Select Case BounceCounter
        Case Is <= 40
            BallSpd = 1
            ReInitBallSpd
        Case Is = 41
            BallSpd = 2
            ReInitBallSpd
        Case Else
    End Select


End Sub

Sub CheckforLangaw (X, Y) Static

    If Inside(X, Y, LangawCoord(0).X, LangawCoord(0).Y, LangawCoord(0).X + 16, LangawCoord(0).Y + 16) Then
        Put (LangawOldCoord(0).X, LangawOldCoord(0).Y), LangawBG1(), PSet
        GoSub XFlies
        LangawCoord(0).X = BlkHoleXY(1 + Int(Rnd * 4)).X
        LangawCoord(0).Y = BlkHoleXY(1 + Int(Rnd * 4)).Y
        GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
    ElseIf Inside(X, Y, LangawCoord(1).X, LangawCoord(1).Y, LangawCoord(1).X + 16, LangawCoord(1).Y + 16) Then
        Put (LangawOldCoord(1).X, LangawOldCoord(1).Y), LangawBG2(), PSet
        GoSub XFlies
        LangawCoord(1).X = BlkHoleXY(1 + Int(Rnd * 4)).X
        LangawCoord(1).Y = BlkHoleXY(1 + Int(Rnd * 4)).Y
        GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()
    End If

    Exit Sub


    XFlies:
    ReDim Temp(1)
    GetBG X - 5, Y - 5, (X - 5) + 25, (Y - 5) + 25, Temp()
    Put (X - 5, Y - 5), FlyExp(FlyExpIndex(2)), And
    Put (X - 5, Y - 5), FlyExp(FlyExpIndex(1)), Or
    For J = 0 To 3
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        Sound 1500 - (J * 150), .3
    Next J
    BounceCounter = 40
    Score& = Score& + 11
    LimitScore
    PrintScore
    Put (X - 5, Y - 5), Temp(), PSet
    Erase Temp

    Return


End Sub

Function CheckPowerCaps (X, Y) Static


    CheckPowerCaps = False

    If Inside(X, Y, PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowerCapsCoord(0).X + 20, PowerCapsCoord(0).Y + 10) Then
        CheckPowerCaps = True
    End If

End Function

Sub CheckTile (X, Y) Static

    For I = 0 To 227
        If Tile(I).F Then
            If Inside(X, Y, Tile(I).X, Tile(I).Y, Tile(I).X + TileW, Tile(I).Y + TileH) Then
                GoSub FindType
                LimitScore
                PrintScore
                GoSub InitPowerCaps
            End If
        End If
    Next I

    Exit Sub

    '===========================================================================
    FindType:
    Select Case Tile(I).C
        Case 1
            Sound 700, .5
            Score& = Score& + 100&
            GoSub DestroyTiles
        Case 2
            Sound 900, .5
            Score& = Score& + 200&
            GoSub DestroyTiles
        Case 3
            Sound 1100, .5
            Score& = Score& + 300&
            GoSub DestroyTiles
        Case 4
            Sound 1300, .5
            Score& = Score& + 400&
            GoSub DestroyTiles
        Case 5
            Sound 1500, .5
            Score& = Score& + 500&
            GoSub DestroyTiles
        Case 6
            Sound 1700, .5
            Score& = Score& + 600&
            GoSub DestroyTiles
        Case 7
            Sound 1900, .5
            Score& = Score& + 700&
            Tile(I).C = Tile(I).C - 1 'Change Tile
            DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
        Case 8
            Sound 2100, .5
            Score& = Score& + 800&
            Tile(I).C = Tile(I).C - 1 'Change Tile
            DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
        Case 9
            SdHitTile = True
            BlinkTile True
        Case Else
    End Select
    Return


    DestroyTiles:


    If Power Then
        If CheckPowerCaps(X, Y) Then
            PutPowerCapsBG
            Power = False
        End If
    End If

    Put (Tile(I).X, Tile(I).Y), BackGround(I * OffsetBG), PSet
    Tile(I).F = False

    'Check if all Tiles are Destroyed
    TileNumber = TileNumber - 1

    If TileNumber < 1 Then

        LevelDoneBox
        Shooting = False
        Lshot = False
        Rshot = False
        T1& = Timer
        Do
            T2& = Timer
            KK$ = InKey$
            If KK$ = Chr$(13) Then Exit Do
            Wait &H3DA, 8
            Wait &H3DA, 8, 8
            If RGBCounter(RGBC * 5) Then
                RotateRGB
            End If

        Loop Until T2& - T1& > 7&

        Finished = True
        OutStart = True
    End If

    Return

    '========
    InitPowerCaps:

    If Not Power Then
        If Tile(I).C <> 9 Then
            PowPow = Int(Rnd * 10)
            If PowPow = 1 Then
                Power = True
                PowerCapsCoord(0).X = Tile(I).X
                PowerCapsCoord(0).Y = Tile(I).Y
                PutPadLsrBG PadLsrBG1(), PadLsrBG2()
                GetPowerCapsBG
                PowerType = 1 + Int(Rnd * 3)
            End If
        End If
    End If

    Return


End Sub

Function Collide Static
    'This is the heart and soul of the game! this may be long and confusing but
    'I made great effort in trying to make this as comprehensive as possible!
    'If you still don't understand, print it!


    If BombSTG Then
        If DoTimer(61) Then
            Perfect = False
            GoSub Endit
        End If
    End If

    Collide = False
    BallSS = BallSpd

    BallX = BallX + BallXV
    BallY = BallY + BallYV

    GetBallCenter BallCenterX, BallCenterY

    GetDirection

    Select Case Direction
        Case UR
            If Point(BallCenterX + (BallRadius + BallSS), BallCenterY) < 129 Then 'Right
                X = BallCenterX + (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            ElseIf Point(BallCenterX, BallCenterY - (BallRadius + BallSS)) < 129 Then 'Up
                X = BallCenterX
                Y = BallCenterY - (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            Else
            End If

        Case UL
            If Point(BallCenterX - (BallRadius + BallSS), BallCenterY) < 129 Then 'Left
                X = BallCenterX - (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            ElseIf Point(BallCenterX, BallCenterY - (BallRadius + BallSS)) < 129 Then 'Up
                X = BallCenterX
                Y = BallCenterY - (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            Else
            End If

        Case DR
            If Point(BallCenterX + (BallRadius + BallSS), BallCenterY) < 129 Then 'Right
                X = BallCenterX + (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            ElseIf Point(BallCenterX, BallCenterY + (BallRadius + BallSS)) < 129 Then 'Up
                X = BallCenterX
                Y = BallCenterY + (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            Else
            End If

        Case DL
            If Point(BallCenterX - (BallRadius + BallSS), BallCenterY) < 129 Then 'Left
                X = BallCenterX - (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            ElseIf Point(BallCenterX, BallCenterY + (BallRadius + BallSS)) < 129 Then 'Up
                X = BallCenterX
                Y = BallCenterY + (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GoSub CheckForSpike
                If BossStg Then GoSub CheckForBossHit
                GoSub CheckForPadHit
                GoSub CheckForPowerHit
                GoSub CheckForTile
                If BombSTG Then GoSub Check4Bomb
                If BossStg Then CheckforLangaw X, Y
            Else
            End If


        Case Else
    End Select



    Exit Function

    '=======================Subroutines=====================================


    CheckForBossHit:
    If BossHit(X, Y) Then
    End If
    Return

    CheckForTile:
    CheckTile X, Y
    Return


    CheckForSpike:

    If HitSpike(X, Y) Then

        Sound 900, 1

        PutBallBG BallOldX, BallOldY
        PutPaddleBG PadOldX, PadOldY
        DoBallExp
        StartGame
        Exit Function
    End If

    Return

    '==============
    CheckForPadHit:

    If Point(X, Y) >= PadColorMin And Point(X, Y) <= PadColorMax Then
        SdHitPad = True
    End If


    Return

    '===============
    CheckForPowerHit:

    If CheckPowerCaps(X, Y) Then

        If Power Then
            PutPowerCapsBG
            Power = False
            PutPaddleBG PadOldX, PadOldY
            Select Case PowerType
                Case 1 'PadPower
                    If Not PadPower Then
                        PadPower = True
                        GetPadLsrCoord 0
                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                        SfxPowerUp
                    End If
                Case 2 'Replicant
                    Replicant = True
                    SfxPowerUp
                Case 3 '1Up
                    Lives = Lives + 1
                    If Lives > 100 Then Lives = 100
                    PrintLives False
                    SfxPowerUp
                Case Else
            End Select
        End If
    End If

    Return


    '=========================
    Check4Bomb:

    For I = 1 To UBound(BombXY)
        If BombXY(I).X <> 0 Then

            If Inside(X, Y, BombXY(I).X, BombXY(I).Y, BombXY(I).X + 16, BombXY(I).Y + 16) Then
                Put (BombXY(I).X, BombXY(I).Y), BombBG(130 * (I - 1)), PSet
                II = 1 + Int(Rnd * UBound(ExplodeIndex))
                ReDim Temp(1)
                GetBG BombXY(I).X, BombXY(I).Y, BombXY(I).X + 25, BombXY(I).Y + 25, Temp()
                Put (BombXY(I).X, BombXY(I).Y), Explodemsk(ExplodeIndex(II)), And
                Put (BombXY(I).X, BombXY(I).Y), Explode(ExplodeIndex(II)), Or
                For J = 0 To 3
                    Wait &H3DA, 8
                    Wait &H3DA, 8, 8
                    Sound 400 - (J * 50), .3
                Next J
                Put (BombXY(I).X, BombXY(I).Y), Temp(), PSet
                BombXY(I).X = 0
                BombXY(I).Y = 0
                Erase Temp
                BombNum = BombNum - 1
                BombDes = BombDes + 1


                If BombNum < 1 Then
                    Perfect = True
                    GoSub Endit
                End If
            End If

        End If

    Next I

    Return

    '=-==========

    Endit:

    '=======================

    DX = 47
    DY = 10
    MaxLen = 21
    Tmin = PadColorMin
    Sysmod = False
    If Not Perfect Then
        Title$ = "       Bonus"
        Text$ = "2000   x   =       "
    Else
        Title$ = "     Perfect!!!"
        Text$ = "2000   x   =       "
        Text$ = Text$ + "**Bonus   +20,000**"
    End If

    ReDim DBTemp(1) 'for DialogBox
    ReDim BTemp(1) 'For num BG

    GetBG DX, DY, DX + MaxLen * 8, DY + 37, DBTemp()
    Sound 500, 1
    Sound 1300, 2
    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
    GetBG DX + (13 * 8) - 3, DY + 13, (DX + (13 * 8)) + 8 * 7, DY + 13 + 8, BTemp()
    KgenFont DX + 8 * 9, DY + 14, LTrim$(Str$(BombDes)), KgenMin, False

    VL& = BombDes * 2000&

    Inc = 200

    Do

        KgenFont DX + 86 + (9 * 8) - (Len(LTrim$(Str$(VL&))) * 8), DY + 14, LTrim$(Str$(VL&)), KgenBlueMin, False
        If RGBCounter(RGBC * 4) Then RotateRGB
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        Sound 2500, .5
        Sound 3000, .2
        VL& = VL& - Inc
        Score& = Score& + Inc
        LimitScore
        PrintScore

        Wait &H3DA, 8
        Wait &H3DA, 8, 8

        Put (DX + (13 * 8) - 3, DY + 13), BTemp(), PSet
        If VL& <= 0 Then
            If Perfect Then
                VL& = VL& + 20000&
                Perfect = False
                KgenFont DX + 86 + (9 * 8) - (Len(LTrim$(Str$(VL&))) * 8), DY + 14, LTrim$(Str$(VL&)), KgenBlueMin, False
                Sound 1500, 1
                Sound 3500, 1
                For II = 1 To 10
                    RotateRGB
                    MilliDelay 100
                Next II
            End If
        End If

    Loop Until VL& <= 0 And Not Perfect


    Put (DX, DY), DBTemp(), PSet

    '=======================

    LevelDoneBox
    Shooting = False
    Lshot = False
    Rshot = False
    T1& = Timer
    Do
        T2& = Timer
        KK$ = InKey$
        If KK$ = Chr$(13) Then Exit Do
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        If RGBCounter(RGBC * 3) Then
            RotateRGB
        End If

    Loop Until T2& - T1& > 7&

    Finished = True
    OutStart = True

    Return



End Function

Sub DialogBox (X, Y, MaxLen, MinColor, Title$, Text$, Italic, Sysmod)

    '========Draws an auto wrap text DialogBox
    '=========Sample code=====================
    'Note: to Indent first row, Pls use "~~~~" instead of Space
    'DX = 22
    'DY = 70
    'MaxLen = 27
    'Title$ = "SAVOT"
    'Tmin = PadColorMin
    'SysMod=True
    'Text$ = "~~~~This would be your last stop! Ull die here 4 sure. I Savot will shave all of your hair! Mwa ha ha ha..."
    'DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False,Sysmod
    '=========End Sample=======================

    Dim Row$(24) 'Maximum number of Rows
    ReDim Dtemp(1) 'Array for background

    P = 1
    CurrentRow = 1
    Leng = Len(Text$)

    While P < Leng + 1
        While Char$ <> " " And P < Leng + 1
            Char$ = Mid$(Text$, P, 1)
            If Char$ <> " " Then
                Word$ = Word$ + Char$
            End If
            P = P + 1
        Wend
       
        If Len(Row$(CurrentRow)) + Len(Word$) + 1 < MaxLen Then
            Row$(CurrentRow) = Row$(CurrentRow) + " " + Word$
        Else
            CurrentRow = CurrentRow + 1
            Row$(CurrentRow) = Row$(CurrentRow) + " " + Word$
        End If
        Word$ = ""
        Char$ = ""

    Wend


    X1 = X + 5
    Y1 = Y + 5

    If Title$ <> "" Then
        CurrentRow = CurrentRow + 1
        PosStart = 2
        Y1 = Y1 + 9
    Else
        PosStart = 1
    End If


    'DrawTrnsBox

    TX1 = X
    TY1 = Y
    If Italic Then
        TX2 = (MaxLen * 8) + TX1 + 8
    Else
        TX2 = (MaxLen * 8) + TX1
    End If

    TY2 = (CurrentRow * 9) + TY1 + 9

    GetBG TX1, TY1, TX2, TY2, Dtemp()

    TransLuc 170, TX1, TY1, TX2, TY2 '170 best


    'Print it
    'Title
    If PosStart > 1 Then
        Font$ = Title$
        KgenFont X1 - 2, Y + 5, Font$, PadColorMin, Italic
        KgenFont X1 - 1, Y + 4, Font$, KgenGreenMin, Italic
    End If



    For I = 1 To CurrentRow
        If I = 1 Then
            Font$ = LTrim$(Row$(I))
            If Left$(Font$, 4) = "~~~~" Then
                Font$ = Space$(4) + Right$(Font$, Len(Font$) - 4)
            End If
        Else
            Font$ = LTrim$(Row$(I))
        End If
        KgenFont X1, Y1, Font$, MinColor, Italic
        Y1 = Y1 + (9)
    Next I

    Do
        If RGBCounter(RGBC * 5) Then RotateRGB
        Wait &H3DA, 8
        K$ = InKey$
    Loop Until K$ = Chr$(13) Or K$ = Chr$(27) Or Not Sysmod

    SfxOpenDialog

    If Sysmod Then
        Put (TX1, TY1), Dtemp(), PSet
    Else

    End If

    RefreshKey

    Erase Row$, Dtemp

End Sub

Sub DoBallExp Static


    Lives = Lives - 1

    GetPaddleBG PadX, PadY

    PutPaddle PadX, PadY

    ReDim ExpTemp(1)

    For J = 1 To 2

        GetBG BallX - 5, BallY - 5, (BallX - 5) + 19, (BallY - 5) + 19, ExpTemp()
        SD = 110
        For I = 1 To UBound(BallExpIndex)
            SD = SD * (2 + (Int(Rnd * 3)))
            Put (BallX - 5, BallY - 5), BallExpmsk(BallExpIndex(I)), And
            Put (BallX - 5, BallY - 5), BallExp(BallExpIndex(I)), Or

            Wait &H3DA, 8
            MilliDelay 50

            Sound SD, .5

        Next I

        Put (BallX - 5, BallY - 5), ExpTemp(), PSet

    Next J


    If PadPower Then
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
        PadPower = False
    End If
    If Replicant Then
        Replicant = False
    End If


    PutPaddleBG PadOldX, PadOldY

    If PadPower Then
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
    End If

    If Power Then
        PutPowerCapsBG
    End If


End Sub

Sub DoBlkHole Static

    For I = 1 To 4
        If BlkHoleXY(I).X <> 0 Then
            PutBlkHole BlkHoleXY(I).X, BlkHoleXY(I).Y
        End If
    Next I

End Sub

Sub DoBomb Static


    For I = 1 To UBound(BombXY)
        If BombXY(I).X <> 0 Then
            Get (BombXY(I).X, BombXY(I).Y)-Step(15, 15), BombBG(130 * (I - 1))
        End If
    Next I

    SW = Not SW
    If SW Then
        Switch = 1
    Else
        Switch = 2
    End If

    For I = 1 To UBound(BombXY)
        If BombXY(I).X <> 0 Then
            PutBomb BombXY(I).X, BombXY(I).Y, Switch
        End If
    Next I

End Sub

Sub DoCredits


    Fade 0, 0, 0
    Line (0, 0)-(319, 199), 0, BF

    VS = 4
    VE = 23
    View Print VS To VE
    Restore Credits

    X = 320
    Y = 0
    Xscale = 1
    Yscale = 1
    Font$ = "-Shameless Self-Promotion-"
    Italic = False
    KgenTTFont 159 - (4 * Xscale * Len(Font$)), Y - 1, Font$, PadColorMin, Xscale, Yscale, Italic
    KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic


    Text$ = "Pls. visit these sites.... 1.[WWW.QB45.com]   2.[GBGames.com]  "
    Text$ = Text$ + "3.[WWW.Hulla-Balloo.Com/Members/Vplanet/Index.Shtml]   4.[NeoZones.teksCode.com]  "
    Text$ = Text$ + "4.[WWW.ChainMailSales.com/Virtuasoft/] 5.[WWW.BasicGuru.com/abc]  "
    Text$ = Text$ + "6.[Members.Aol.Com/RadioHands/Index.Html 7.[www.geocities.com/TimesSquare/Ring/1683/Index.Html/     "
    Xscale = 2
    Yscale = 1
    TopY = 199 - ((Yscale) * 9)
    MinColor = KgenBlueMin
    Shadow = True
    OverTop = True
    OtY = 10
    Italic = True
    FirstTime = True

    RestoreColors

    Do

        K$ = InKey$
        ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime

        If RGBCounter(RGBC * 5) Then RotateRGB

        KC = KC Mod 188 + 1
        If KC = 1 Then
            Read T$
            If UCase$(T$) = "END" Then
                Exit Do
            End If

            Locate VE, 1
            Print
            FC = FC Mod 3 + 1
            If FC = 1 Then
                KgenFont 0, 176, T$, KgenGreenMin, False
            Else
                KgenFont 0, 176, T$, PadColorMin, True
            End If
        End If

    Loop Until K$ = Chr$(13)


    OutStart = True
    Finished = True
    Level = Level - 1



End Sub

Sub DoEnding Static

    ReDim Font(1)
    Line (0, 0)-(319, 199), 0, BF
    RestoreColors

    Txt$ = "Congratulations!!! You have beaten the game!  "
    Txt$ = Txt$ + "My hats off to you. Relsoft 2000.  "
    Xscale = 1
    Yscale = 3
    TopY = 199 - ((Yscale) * 9)
    MinColor = KgenBlueMin
    Shadow = True
    OverTop = False
    OtY = 0
    Italic = True
    FirstTime = True

    X = 0
    Restore Ending
    EndRead = False

    Do
        If Not EndRead Then
            Read Y
            Read Text$
            Read Clr
        Else
            ScrollKgenTT TopY, Txt$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
            If RGBCounter(RGBC * 5) Then RotateRGB
        End If
        If UCase$(Text$) = "END" Then
            EndRead = True
        Else
            GoSub MoveIt
        End If
    Loop Until InKey$ <> ""

    HazyFx
    Fade 0, 0, 0
    Line (0, 0)-(319, 199), 0, BF

    Exit Sub

    MoveIt:

    For I = 1 To Len(Text$)

        Font$ = Mid$(Text$, (Len(Text$) + 1) - I, 1)

        If Font$ <> " " Then
            KgenFont X, Y, Font$, Clr, False
            Center = (160 + (Len(Text$) * 9) \ 2) - (9 * I)
            GetBG 0, Y, 9, Y + 9, Font()
            For J = 0 To Center
                Put (J, Y), Font(), PSet
                Scount = Scount Mod 16 + 1
                If Scount = 1 Then
                    ScrollKgenTT TopY, Txt$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
                    If RGBCounter(RGBC * 5) Then RotateRGB
                End If
                K$ = InKey$
                If K$ = Chr$(13) Then
                    HazyFx
                    Fade 0, 0, 0
                    Line (0, 0)-(319, 199), 0, BF
                    Exit Sub
                End If
            Next J
        End If

    Next I


    Return




End Sub

Sub DoExplode Static


    Xmax = (Boss(0) \ 8 - 1) - 25
    Ymax = (Boss(1) - 1) - 25
    I = I Mod UBound(ExplodeIndex) + 1

    X = BossX + Int(Rnd * Xmax)
    Y = BossY + Int(Rnd * Ymax)
    X1 = BossX + Int(Rnd * Xmax)
    Y1 = BossY + Int(Rnd * Ymax)
    X2 = BossX + Int(Rnd * Xmax)
    Y2 = BossY + Int(Rnd * Ymax)
    X3 = BossX + Int(Rnd * Xmax)
    Y3 = BossY + Int(Rnd * Ymax)


    Put (X, Y), Explodemsk(ExplodeIndex(I)), And
    Put (X, Y), Explode(ExplodeIndex(I)), Or
    Put (X1, Y1), Explodemsk(ExplodeIndex(I)), And
    Put (X1, Y1), Explode(ExplodeIndex(I)), Or
    Put (X2, Y2), Explodemsk(ExplodeIndex(I)), And
    Put (X2, Y2), Explode(ExplodeIndex(I)), Or
    Put (X3, Y3), Explodemsk(ExplodeIndex(I)), And
    Put (X3, Y3), Explode(ExplodeIndex(I)), Or

    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    MilliDelay 100

    Put (BossX, BossY), BossBG(), PSet
    Put (BossX, BossY), BossMask(), And
    Put (BossX, BossY), Boss(), Or

    RotateRGB



End Sub

Sub DoGameOver Static

    Line (0, 0)-(320, 199), 0, BF
    HideBuild


    X = 320
    Y = 80
    Xscale = 3
    Yscale = 4
    Font$ = "Game Over!"
    Italic = False
    KgenTTFont 159 - (4 * Xscale * Len(Font$)), Y - 1, Font$, KgenMin, Xscale, Yscale, Italic
    KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic

    X = 320
    Y = 60
    Font$ = "Press [ESC] while playing 4 the MENU."
    Italic = False
    KgenFont X, Y, Font$, KgenMin, Italic

    X = 320
    Y = 130
    Font$ = "vic_viperph@yahoo.com"
    Italic = False
    KgenFont X, Y, Font$, KgenMin, Italic

    X = 320
    Y = 120
    Font$ = "Info on Level Designer is in Readme.Txt"
    Italic = False
    KgenFont X, Y, Font$, KgenMin, Italic



    Text$ = " You lost!!! Pls. try again.... Go for the Record!!! You may become the first Hall Of Famer!!!   "
    Xscale = 3
    Yscale = 5
    TopY = 199 - ((Yscale) * 9)
    MinColor = KgenBlueMin
    Shadow = True
    OverTop = True
    OtY = 0
    Italic = True
    FirstTime = True

    RestoreColors

    Do
        K$ = InKey$
        ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
        If RGBCounter(RGBC * 5) Then RotateRGB
    Loop Until K$ = Chr$(13) Or K$ = Chr$(27)



End Sub

Sub DoHallOfFame Static

    DX = 32
    DY = 50
    MaxLen = 25
    Title$ = "Power Players:    Score:"
    Tmin = PadColorMin
    Sysmod = True

    Rnk$ = LTrim$(Str$(Hall(1).Rank))
    Nm$ = "." + LTrim$(RTrim$(Hall(1).Namer))
    If Len(Nm$) < 12 Then
        Nm$ = Nm$ + Space$(13 - Len(Nm$))
    End If
    Nm$ = Nm$ + ":"
    Scr$ = LTrim$(Str$(Hall(1).Score))
    Text$ = Rnk$ + Nm$ + String$(8 - (Len(Scr$)), "-") + Scr$

    For I = 2 To 5
        Rnk$ = " " + LTrim$(Str$(Hall(I).Rank))
        Nm$ = "." + LTrim$(RTrim$(Hall(I).Namer))
        If Len(Nm$) < 12 Then
            Nm$ = Nm$ + Space$(13 - Len(Nm$))
        End If
        Nm$ = Nm$ + ":"
        Scr$ = LTrim$(Str$(Hall(I).Score))
        Text$ = Text$ + Rnk$ + Nm$ + String$(8 - (Len(Scr$)), "-") + Scr$
    Next I


    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod

End Sub

Sub DoIntro Static

    LoadTitle


    DoStory

End Sub

Sub DoLangaw (Stat) Static

    '"Langaw" means Fly as in the insect in our country.

    Put (LangawOldCoord(0).X, LangawOldCoord(0).Y), LangawBG1(), PSet
    Put (LangawOldCoord(1).X, LangawOldCoord(1).Y), LangawBG2(), PSet

    If Not Stat Then
        J = J Mod 10 + 1

        For I = 0 To 1
            If J = 1 Then
                LXR! = Rnd * 5
                LYR! = Rnd * 5
            End If

            If LXR! < 2.5 Then
                LX = -2
            Else
                LX = 2
            End If

            If LYR! < 2.5 Then
                LY = -2
            Else
                LY = 2
            End If
            If I = 1 Then
                LX = -LX
                LY = -LY
            End If
            LangawCoord(I).X = LangawCoord(I).X + LX
            If LangawCoord(I).X > 230 Then
                LangawCoord(I).X = 230
            ElseIf LangawCoord(I).X < 10 Then
                LangawCoord(I).X = 10
            End If

            LangawCoord(I).Y = LangawCoord(I).Y + LY
            If LangawCoord(I).Y > 140 Then
                LangawCoord(I).Y = 140
            ElseIf LangawCoord(I).Y < 50 Then
                LangawCoord(I).Y = 50
            End If

            LangawOldCoord(I).X = LangawCoord(I).X
            LangawOldCoord(I).Y = LangawCoord(I).Y
        Next I

    End If

    GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
    GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()

    Axn = Axn Mod 2 + 1
    PutLangaw LangawCoord(0).X, LangawCoord(0).Y, Axn
    PutLangaw LangawCoord(1).X, LangawCoord(1).Y, Axn

End Sub

Sub DoLogos Static

    SaveColors
    HideBuild

    X = 320
    Y = 20
    Xscale = 4
    Yscale = 2
    Font$ = "RelSoft"
    Italic = False
    KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic


    X = 320
    Y = 77
    Xscale = 2
    Yscale = 1
    Font$ = "and"
    Italic = False
    KgenTTFont X, Y, Font$, 80, Xscale, Yscale, Italic


    X = 52
    Y = 120
    Xscale = 3
    Yscale = 4
    Font$ = "AnyaTech"
    Italic = True
    KgenTTFont 50, 118, Font$, 24, Xscale, Yscale, Italic
    KgenTTFont X, Y, Font$, 59, Xscale, Yscale, Italic


    RestoreColors
    T& = Timer
    Do
        T2& = Timer
    Loop Until T2& - T& > 2
    Fade 0, 0, 0

    Line (0, 0)-(320, 199), 0, BF


    X = 320
    Y = 50
    Xscale = 1
    Yscale = 2
    Font$ = "Proudly"
    Italic = False
    KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic

    X = 320
    Y = 100
    Xscale = 3
    Yscale = 1
    Font$ = "Presents"
    Italic = False
    KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic


    RestoreColors
    T& = Timer
    Do
        T2& = Timer
    Loop Until T2& - T& > 1

    Fade 0, 0, 0

    Line (0, 0)-(320, 199), 0, BF

    RestoreColors


End Sub

Sub DoPadLsr Static

    LsrSpeed = 2


    If AutoFire Then
        Lshot = True
        Rshot = True
    End If

    If Lshot Then
        PadLsrCoord(0).Y = PadLsrCoord(0).Y - LsrSpeed
    Else
        GetPadLsrCoord 1
    End If
    If Rshot Then
        PadLsrCoord(1).Y = PadLsrCoord(1).Y - LsrSpeed
    Else
        GetPadLsrCoord 2
    End If


    GetPadLsrBG PadLsrBG1(), PadLsrBG2()

    PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
    PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y

    I = 1
    X = PadLsrCoord(0).X + 2
    Y = PadLsrCoord(0).Y - 3
    GoSub CheckForHit
    I = 2
    X = PadLsrCoord(1).X + 2
    Y = PadLsrCoord(1).Y - 3
    GoSub CheckForHit


    Exit Sub
    ''=========
    CheckForHit:

    If Point(X, Y) < 129 Then
        Select Case I
            Case 1
                Lshot = False
                GetPadLsrCoord 1
            Case 2
                Rshot = False
                GetPadLsrCoord 2
            Case Else
        End Select

        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY


        PutBall BallX, BallY
        PutPaddle PadX, PadY

        CheckTile X, Y

        PutPaddleBG PadOldX, PadOldY
        PutBallBG BallOldX, BallOldY

        If Not Lshot And Not Rshot Then
            Shooting = False
        End If

    End If


    Return


End Sub

Sub DoPowerCaps (PowType) Static

    PowSpeed = 1


    PowerCapsCoord(0).Y = PowerCapsCoord(0).Y + PowSpeed

    GetPowerCapsBG

    PutPowerCaps PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowType






    X = PowerCapsCoord(0).X + 9
    Y = PowerCapsCoord(0).Y + 13
    GoSub Check4Hit

    X = PowerCapsCoord(0).X
    Y = PowerCapsCoord(0).Y + 13
    GoSub Check4Hit

    X = PowerCapsCoord(0).X + 9
    Y = PowerCapsCoord(0).Y + 13
    GoSub Check4Hit






    Exit Sub
    ''=========
    Check4Hit:



    If Point(X, Y) < 129 Then

        'Spike
        If Point(X, Y) >= SpikeMin And Point(X, Y) <= SpikeMax Then

            PutPowerCapsBG
            Power = False

        End If

        'Border
        If Point(X, Y) >= BorderMin And Point(X, Y) <= Bordermax Then

            PutPowerCapsBG
            Power = False

        End If


    End If


    'Check for Paddle

    If Replicant Then
        PadXXStep = 72
    Else
        PadXXStep = 38
    End If

    If Inside(X, Y, PadX - 5, PadY, PadX + PadXXStep, PadY + 8) Then

        If Power Then
            PutPowerCapsBG
            Power = False

            Select Case PowerType
                Case 1 'PadPower
                    If Not PadPower Then
                        PadPower = True
                        GetPadLsrCoord 0
                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                        SfxPowerUp
                    End If
                Case 2 'Replicant
                    Replicant = True
                    SfxPowerUp
                Case 3 '1Up
                    Lives = Lives + 1
                    If Lives > 100 Then Lives = 100
                    PrintLives False
                    SfxPowerUp
                Case Else
            End Select
        End If

    End If


    Return


End Sub

Sub DoStory Static


    VS = 4
    VE = 23
    View Print VS To VE
    Restore Story

    X = 320
    Y = 0
    Xscale = 1
    Yscale = 2
    Font$ = "-ARQANOID... the untold story-"
    Italic = False
    KgenTTFont 159 - (4 * Xscale * Len(Font$)), Y - 1, Font$, PadColorMin, Xscale, Yscale, Italic
    KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic


    Text$ = "    This story has been passed from generation to generation... Damn! I really suck at storytelling. (Actually, I made the game before the story... hehehehehe. Note: I intentionally mispelled some words. ie game titles.  FYI, BALOT is a"
    Text$ = Text$ + " native delicacy in our country made from duck eggs."
    Xscale = 2
    Yscale = 1
    TopY = 199 - ((Yscale) * 9)
    MinColor = KgenBlueMin
    Shadow = True
    OverTop = False
    OtY = 10
    Italic = False
    FirstTime = True

    RestoreColors

    Do

        K$ = InKey$
        ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime

        If RGBCounter(RGBC * 5) Then RotateRGB

        KC = KC Mod 288 + 1
        If KC = 1 Then
            Read T$
            If UCase$(T$) = "END" Then
                Exit Do
            End If

            Locate VE, 1
            Print
            KgenFont 0, 176, T$, PadColorMin, False
        End If

    Loop Until K$ = Chr$(13)

    HazyFx
    Fade 0, 0, 0
    Line (0, 0)-(319, 199), 0, BF

End Sub

Function DoTimer (MaxTime) Static

    If BombNum = MaxBomb Then
        SecondTime = False
        MaxBomb = MaxBomb + 1
    End If

    If Not SecondTime Then
        TT = 0
        T = 0
    End If

    SecondTime = True

    T& = Timer
    DoTimer = False
    If T& > OldTime& Then
        GoSub PrintTime
    End If

    Exit Function

    '==========================
    PrintTime:
    T = T Mod MaxTime + 1
    TT = MaxTime - T

    X = 289
    Y = 125
    Font$ = Str$(TT)
    Italic = False
    Line (X + 8, Y)-Step(24, 9), 0, BF
    KgenFont X - 1, Y + 1, Font$, KgenMin, Italic

    If TT = 0 Then
        DoTimer = True
        SfxOpenDialog
        SecondTime = False
    End If

    OldTime& = Timer

    Return



End Function

Sub DrawBorder Static

    For I = 0 To 6
        Line (I, I)-(260 - I, 200 - I), BorderMin + I, B
    Next I


End Sub

Sub DrawBoss (BossX, BossY, BossFile$) Static

    BossFileSpr$ = Path$ + "Images\" + BossFile$ + ".QBN"
    BossFileMsk$ = Path$ + "Images\" + BossFile$ + ".Msk"

    Open BossFileSpr$ For Input As #1

    Input #1, ArrSize

    ReDim Boss(ArrSize)
    ReDim BossMask(ArrSize)


    For I = 0 To ArrSize

        Input #1, Boss(I)


    Next I


    Close

    Open BossFileMsk$ For Input As #1
    Input #1, ArrSize

    For I = 0 To ArrSize

        Input #1, BossMask(I)


    Next I

    Close

    ReDim BossBG(ArrSize)

    Get (BossX, BossY)-Step(Boss(0) \ 8 - 1, Boss(1) - 1), BossBG()

    Put (BossX, BossY), BossMask(), And
    Put (BossX, BossY), Boss(), Or


End Sub

Sub DrawFonts Static

    X = 268
    Y = 2
    Txt$ = "i Score:"
    PrintFonts X, Y, Txt$
    X = 265
    Y = 0
    Font$ = "H"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic
        

    If Score& < 100000 Then
        X = 280
        Y = 12
        PrintNum X, Y, "100,000"
    Else
        PrintScore
    End If




    X = 268
    Y = 27
    Txt$ = "core:"
    PrintFonts X, Y, Txt$
    X = 265
    Y = 25
    Font$ = "S"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic


    'SCORE
    Temp$ = LTrim$(Format$(Score&))
    PrintNum 315 - (Len(Temp$) * 5), 35, Temp$


    X = 268
    Y = 52
    Txt$ = "evel:"
    PrintFonts X, Y, Txt$
    X = 265
    Y = 50
    Font$ = "L"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic


    X = 268
    Y = 67
    Txt$ = "ives:"
    PrintFonts X, Y, Txt$

    X = 265
    Y = 65
    Font$ = "L"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic


    X = 268
    Y = 127
    Txt$ = "ime:"
    PrintFonts X, Y, Txt$

    X = 265
    Y = 125
    Font$ = "T"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic

    X = 289
    Y = 125
    Font$ = Str$(60)
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenMin, Italic



    X = 268
    Y = 155
    Txt$ = "mail:"
    PrintFonts X, Y, Txt$

    X = 265
    Y = 153
    Font$ = "E"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
    KgenFont X, Y, Font$, KgenMin, Italic

    X = 261
    Y = 167
    Txt$ = "vic viperph"
    PrintFonts X, Y, Txt$

    Line (281, 171)-Step(3, 0), FcolorMax, BF

    X = 261
    Y = 174
    Txt$ = "@Yahoo.Com"
    PrintFonts X, Y, Txt$



    X = 261
    Y = 183
    Font$ = "RelSoft"
    Italic = True
    KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
    KgenFont X, Y, Font$, KgenBlueMin, Italic

    X = 271
    Y = 193
    Font$ = "2001"
    Italic = True
    KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
    KgenFont X, Y, Font$, KgenBlueMin, Italic





End Sub

Sub DrawLevelBG (BGMode, ColorStep, ColorAttr) Static

    Line (0, 0)-(319, 199), 255, BF 'Bug Fix

    Clr = 145

    For Y = 0 To 199 Step 5
        For X = 0 To 320 Step 5

            If CC = 0 Then
                Clr = Clr + ColorStep
            Else
                Clr = Clr - ColorStep
            End If
            If BGMode = 1 Then
                Line (X, Y)-(X + 4, Y + 4), Clr, BF
                Line (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, BF
                Line (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, BF
            Else
                Line (X, Y)-(X + 4, Y + 4), Clr, B
                Line (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, B
                Line (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, B
            End If
            If Clr >= 180 Then CC = 1
            If Clr <= 150 Then CC = 0
        Next X
    Next Y

    'Erase RightSide for Info,Scores,Etc.

    Line (MaxX, MinY)-(320, 200), 255, BF
    Line (0, 200)-(320, 200), 255, BF



    GetBG 7, 183, 253, 193, SpikeBG()

    'Draw Spikes

    For X = 5 To 250 Step 10
        DrawSpike X, 205
    Next X

    DrawBorder
    DrawFonts


End Sub

Sub DrawSpike (X, Y) Static

    For I = 1 To 5
        Line (X + I, Y)-Step(0, -(I * 4.5)), SpikeMax - I
        Line ((X + 10) - I, Y)-Step(0, -(I * 4.5)), SpikeMax - I
    Next I


End Sub

Sub DrawTile (X, Y, Clr)

    Select Case Clr
        Case 1
            TB = 60
            TC = 61
            TM = 62
        Case 2
            TB = 63
            TC = 64
            TM = 65
        Case 3
            TB = 66
            TC = 67
            TM = 68
        Case 4
            TB = 69
            TC = 70
            TM = 71
        Case 5
            TB = 72
            TC = 73
            TM = 74
        Case 6
            TB = 75
            TC = 76
            TM = 77
        Case 7
            TB = 78
            TC = 79
            TM = 80
        Case 8
            TB = 81
            TC = 82
            TM = 83
        Case 9
            TB = 84
            TC = 85
            TM = 86
        Case Else
    End Select


    Line (X, Y)-Step(TileW, TileH), TC, BF
    Line (X, Y)-Step(TileW, TileH), TM, B
    Line (X, Y)-Step(0, TileH), TB
    Line (X, Y + TileH)-Step(TileW - 1, 0), TB



End Sub

Sub EraseKgen Static

    KgenStart = 49

    X = 265
    Y = 0
    Font$ = "H"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


    X = 265
    Y = 25
    Font$ = "S"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


    X = 265
    Y = 50
    Font$ = "L"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic



    X = 265
    Y = 65
    Font$ = "L"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic



    X = 265
    Y = 125
    Font$ = "T"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


    X = 289
    Y = 125
    Font$ = Str$(60)
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic


    X = 265
    Y = 153
    Font$ = "E"
    Italic = False
    KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


    X = 261
    Y = 183
    Font$ = "RelSoft"
    Italic = True
    KgenFont X - 1, Y - 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic

    X = 271
    Y = 193
    Font$ = "2001"
    Italic = True
    KgenFont X - 1, Y - 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


    X = 297
    Y = 51

    If Level < 10 Then
        LV$ = "0" + LTrim$(Str$(Level))
    Else
        LV$ = LTrim$(Str$(Level))
    End If

    Font$ = LV$
    Italic = True
    KgenFont X - 2, Y + 1, Font$, KgenStart, Italic
    KgenFont X, Y, Font$, KgenStart, Italic


End Sub

Sub EraseSaveFiles Static


    GoSub ConfirmErase

    If K$ = Chr$(27) Then
        Exit Sub
    End If

    GoSub MakeBackUp

    '===================================Hall of Fame
    For I = 1 To 5
        Hall(I).Rank = I
        Hall(I).Namer = "Relsoft 2000"
        Hall(I).Score = 0
    Next I

    Open Path$ + "saves\" + "qbnoid.hof" For Output As #1

    For I = 1 To 5
        Print #1, Hall(I).Rank
        Print #1, Hall(I).Namer
        Print #1, Hall(I).Score
    Next I

    Close



    '=================================='SaveFiles for Loading




    For I = 1 To 8
        Save(I).Num = I
        Save(I).Namer = "Relsoft 2000"
        Save(I).Score = 0
        Save(I).Level = 1
        Save(I).Lives = 2

    Next I

    Open Path$ + "saves\" + "qbnoid.qsv" For Output As #1


    For I = 1 To 8

        Print #1, Save(I).Num
        Print #1, Save(I).Namer
        Print #1, Save(I).Score
        Print #1, Save(I).Level
        Print #1, Save(I).Lives
    Next I

    Close
    Exit Sub


    '================Subs==================
    MakeBackUp:

    '===========Hall of Fame
    Open Path$ + "saves\" + "qbnbck.hof" For Output As #1

    For I = 1 To 5
        Print #1, Hall(I).Rank
        Print #1, Hall(I).Namer
        Print #1, Hall(I).Score
    Next I

    Close



    '=================================='SaveFiles for Loading

    Open Path$ + "saves\" + "qbnbck.qsv" For Output As #1


    For I = 1 To 8

        Print #1, Save(I).Num
        Print #1, Save(I).Namer
        Print #1, Save(I).Score
        Print #1, Save(I).Level
        Print #1, Save(I).Lives
    Next I

    Close

    Return

    '==============================

    ConfirmErase:

    ReDim Temp(1)
    DX = 40
    DY = 40
    MaxLen = 21
    Title$ = "     WARNING!!!"
    Tmin = PadColorMin
    Sysmod = False
    Text$ = "~~~~This will erase your Hi-Scores and Load/Save file datas!!! Press [Escape] to undo or [Enter] to confirm."
    GetBG DX, DY, DX + MaxLen * 8, DY + 9 * 8, Temp()
    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
    Do
        K$ = InKey$
        If RGBCounter(RGBC * 5) Then RotateRGB
        Wait &H3DA, 8
    Loop Until K$ = Chr$(27) Or K$ = Chr$(13)

    SfxOpenDialog
    Put (DX, DY), Temp(), PSet
    Erase Temp

    Return


End Sub

Sub Fade (R%, g%, B%)



    For I = 0 To 63


        For X = 0 To 255

            RefreshKey

            ReadRGB X, RD, GN, BLL


            If R% > RD Then
                RD = RD + 1
            ElseIf R% < RD Then
                RD = RD - 1
            Else
                'Do nothing
            End If

            If g% > GN Then
                GN = GN + 1
            ElseIf g% < GN Then
                GN = GN - 1
            Else
                'Do nothing
            End If

            If B% > BLL Then
                BLL = BLL + 1
            ElseIf B% < BLL Then
                BLL = BLL - 1
            Else
                'Do nothing
            End If

            WriteRGB X, RD, GN, BLL

        Next X

        MilliDelay 30
        Wait &H3DA, 8
        Wait &H3DA, 8, 8

    Next I

End Sub

Sub FadeStep (R%, g%, B%) Static



    I = I + 1

    If I > 63 Then
        I = 0
        Exit Sub
    End If

    For X = 0 To 255

        RefreshKey

        ReadRGB X, RD, GN, BLL

        If R% > RD Then
            RD = RD + 1
        ElseIf R% < RD Then
            RD = RD - 1
        Else
            'Do nothing
        End If

        If g% > GN Then
            GN = GN + 1
        ElseIf g% < GN Then
            GN = GN - 1
        Else
            'Do nothing
        End If

        If B% > BLL Then
            BLL = BLL + 1
        ElseIf B% < BLL Then
            BLL = BLL - 1
        Else
            'Do nothing
        End If

        WriteRGB X, RD, GN, BLL

    Next X

End Sub

Function FastKB Static
    FastKB = Inp(&H60)
    Do While Len(InKey$): Loop

End Function

Function Format$ (Score&) Static

    Score$ = RTrim$(LTrim$(Str$(Score&)))

    L = Len(Score$)
    Temp$ = ""
    II = 0

    For I = L To 1 Step -1
        I$ = Mid$(Score$, I, 1)

        If II = 3 Then
            Temp$ = Temp$ + "," + I$
        Else
            Temp$ = Temp$ + I$
        End If
        II = (II Mod 3) + 1

    Next I

    'Reverse it

    L = Len(Temp$)
    Temp2$ = ""

    For I = L To 1 Step -1
        I$ = Mid$(Temp$, I, 1)
        Temp2$ = Temp2$ + I$
    Next I

    Format$ = LTrim$(RTrim$(Temp2$))

End Function

Sub GetBallBG (BallX, BallY) Static
    BallOldX = BallX
    BallOldY = BallY
    Get (BallX, BallY)-Step(6, 6), BallBG()
End Sub

Sub GetBallCenter (BallCenterX, BallCenterY) Static
    BallCenterX = BallX + BallRadius - 1
    BallCenterY = BallY + BallRadius - 1
End Sub

Sub GetBG (X1, Y1, X2, Y2, Image())

    'Image() Must be Dynamic

    Size = (((((((X2 + 1) - X1) * ((Y2 + 1) - Y1))))) \ 2) + 2

    ReDim Image(Size)

    Get (X1, Y1)-(X2, Y2), Image()


End Sub

Sub GetBlkHoleBG Static

    For I = 1 To 4
        If BlkHoleXY(I).X <> 0 Then
            Get (BlkHoleXY(I).X, BlkHoleXY(I).Y)-Step(15, 15), BlkHoleBG(130 * (I - 1))
        End If
    Next I

End Sub

Sub GetDirection Static

    Select Case Sgn(BallXV)
        Case 1
            If Sgn(BallYV) = -1 Then
                Direction = UR
            Else
                Direction = DR
            End If
        Case -1
            If Sgn(BallYV) = -1 Then
                Direction = UL
            Else
                Direction = DL
            End If

        Case Else
    End Select

    Select Case Sgn(BallYV)
        Case 1
            If Sgn(BallXV) = -1 Then
            Else
            End If

        Case -1
            If Sgn(BallXV) = -1 Then
            Else
            End If

        Case Else
    End Select

End Sub

Sub GetPaddleBG (PadX, PadY) Static
    PadOldX = PadX
    PadOldY = PadY

    If Not Replicant Then
        Get (PadX, PadY)-Step(39, 8), PaddleBG()
    Else
        Get (PadX, PadY)-Step(39 * 2, 8), PaddleBG()
    End If
End Sub

Sub GetPadLsrBG (Image1(), Image2()) Static


    PadLsrOldCoord(0).X = PadLsrCoord(0).X
    PadLsrOldCoord(0).Y = PadLsrCoord(0).Y
    PadLsrOldCoord(1).X = PadLsrCoord(1).X
    PadLsrOldCoord(1).Y = PadLsrCoord(1).Y


    GetBG PadLsrCoord(0).X, PadLsrCoord(0).Y, PadLsrCoord(0).X + 4, PadLsrCoord(0).Y + 8, Image1()
    GetBG PadLsrCoord(1).X, PadLsrCoord(1).Y, PadLsrCoord(1).X + 4, PadLsrCoord(1).Y + 8, Image2()

End Sub

Sub GetPadLsrCoord (I) Static

    Select Case I
        Case 0
            PadLsrCoord(0).X = PadX + 1
            PadLsrCoord(0).Y = PadY - 9
            If Replicant Then
                PadLsrCoord(1).X = PadX + 71
            Else
                PadLsrCoord(1).X = PadX + 33
            End If
            PadLsrCoord(1).Y = PadY - 9
        Case 1
            PadLsrCoord(0).X = PadX + 1
            PadLsrCoord(0).Y = PadY - 9
        Case 2
            If Replicant Then
                PadLsrCoord(1).X = PadX + 71
            Else
                PadLsrCoord(1).X = PadX + 33
            End If
            PadLsrCoord(1).Y = PadY - 9
        Case Else
            PadLsrCoord(0).X = PadX + 1
            PadLsrCoord(0).Y = PadY - 9
            If Replicant Then
                PadLsrCoord(1).X = PadX + 71
            Else
                PadLsrCoord(1).X = PadX + 33
            End If
            PadLsrCoord(1).Y = PadY - 9
    End Select


End Sub

Sub GetPowerCapsBG Static

    PowerCapsOldCoord(0).X = PowerCapsCoord(0).X
    PowerCapsOldCoord(0).Y = PowerCapsCoord(0).Y


    GetBG PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowerCapsCoord(0).X + 19, PowerCapsCoord(0).Y + 9, PowerCapsBG()


End Sub

Sub GetTileBackGround Static

    I = 0
    For Y = 0 To 108 Step 6
        For X = 0 To 220 Step 20
            Get (10 + X, 10 + Y)-Step(19, 5), BackGround(OffsetBG * I)
            I = I + 1
        Next X
    Next Y

End Sub

Sub HazyFx Static

    StepX = 2
    StepY = 2

    For I = 1 To 8

        StepX = StepX + 2
        StepY = StepY + 2

        For Y = 0 To 199 Step StepY
            For X = 0 To 319 Step StepX
                C = Point(X, Y)
                Line (X, Y)-Step(StepX - 1, StepY - 1), C, BF
            Next X
        Next Y

        MilliDelay 140

    Next I

End Sub

Sub HideBuild

    For I = 0 To 255
        R = 0
        g = 0
        B = 0
        WriteRGB I, R, g, B
    Next I

End Sub

Function HitSpike (X, Y) Static

    HitSpike = False

    If Point(X, Y) >= SpikeMin And Point(X, Y) <= SpikeMax Then
        HitSpike = True
    End If

End Function

Sub Init Static

    LoadSaveFiles

    InitValues

    DoLogos

    InitColors

    InitTrans


    SaveColors

    HideBuild

    DoIntro

    InitFonts
    InitNums


    'Load Images

    LoadBallImage
    LoadBallExpImage
    LoadPaddleImage
    LoadBlkHoleImage
    LoadBombImage
    LoadExplodeImage
    LoadPointerImage
    LoadPadLsrImage
    LoadPowerCapsImage
    LoadLangawImage
    LoadFlyExpImage



End Sub

Sub InitColors Static

    WriteRGB 254, 63, 63, 63
    'Color for Menu Pointer=============
    WriteRGB 244, 0, 0, 0
    WriteRGB 245, 0, 0, 0


    'Color for Border============================================
    R = 25
    g = 25
    B = 40

    For I = BorderMin To Bordermax
        If I <= BorderMin + 3 Then
            R = R + 5
            g = g + 3
        Else
            R = R - 5
            g = g - 3
        End If

        WriteRGB I, R, g, B
    Next I

    'FontColors================================
    R = 63
    g = 63
    B = 63

    For I = FColorMin To FcolorMax
        R = R - 7
        B = B - 7
        WriteRGB I, R, g, B
    Next I

    'SmallNum colors============================
    R = 63
    g = 63
    B = 63

    For I = SnColorMin To SnColorMax
        R = R - 7
        g = g - 7
        WriteRGB I, R, g, B
    Next I

    'Tile Colors=================================

    '60-93

    For I = TcolorMin To TcolorMax
        II = II Mod 3 + 1

        If II = 1 Then
            IC = IC Mod 9 + 1
        End If
        Select Case II
            Case 1
                R = 10: g = 10: B = 10 'Dark Borders
            Case 2
                R = 30: g = 30: B = 30 'Tilecolor
            Case 3
                R = 50: g = 50: B = 50 'Light Borders
            Case Else
        End Select
        'Tile color
        Select Case IC
            Case 1
                g = 0
                B = 0
            Case 2
                R = 0
                B = 0
            Case 3
                R = 0
                g = 0
            Case 4
                R = 0
            Case 5
                g = 0
            Case 6
                B = 0
            Case 7
                R = 25
            Case 8
                g = 25
            Case 9
                B = 25
            Case Else
        End Select

        WriteRGB I, R, g, B
    Next I

    'BackGround Colors==============================================
    I = 0

    For I = 130 To 193
        Select Case ColorAttr
            Case 1 'Red
                SavRGB(I).R = I \ 2
                SavRGB(I).g = 0
                SavRGB(I).B = 0
            Case 2 'Green
                SavRGB(I).R = 0
                SavRGB(I).g = I \ 2
                SavRGB(I).B = 0

            Case 3 'Blue
                SavRGB(I).R = 0
                SavRGB(I).g = 0
                SavRGB(I).B = I \ 2

            Case 4 'Yellow
                SavRGB(I).R = I \ 2
                SavRGB(I).g = I \ 2
                SavRGB(I).B = 0

            Case 5 'Purple
                SavRGB(I).R = I \ 2
                SavRGB(I).g = 0
                SavRGB(I).B = I \ 2

            Case 6 'Metallic Blue
                SavRGB(I).R = 0
                SavRGB(I).g = I \ 2
                SavRGB(I).B = I \ 2

            Case 7 'White
                SavRGB(I).R = I \ 2
                SavRGB(I).g = I \ 2
                SavRGB(I).B = I \ 2

            Case Else
                SavRGB(I).R = I \ 2
                SavRGB(I).g = I \ 2
                SavRGB(I).B = I \ 2
        End Select

    Next I
    I = 0
    For I = 130 To 193
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    '=========Boss Colors 106-121================
    II = 0
    For I = 106 To 121
        ReadRGB II, R, g, B
        WriteRGB I, R, g, B
        II = II + 1
    Next I


    '====================Kgen Colors==============================
    'Red
    R = 63
    g = 63
    B = 63
    For I = KgenMin To KgenMax
        If I <= KgenMin + 3 Then
            g = g - 13
            B = B - 13
        Else
            g = g + 13
            B = B + 13
        End If
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    'Blue
    R = 63
    g = 63
    B = 63
    For I = KgenBlueMin To KgenBlueMax
        If I <= KgenBlueMin + 3 Then
            g = g - 13
            R = R - 13
        Else
            g = g + 13
            R = R + 13
        End If
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    'Green
    R = 63
    g = 63
    B = 63
    For I = KgenGreenMin To KgenGreenMax
        If I <= KgenGreenMin + 3 Then
            B = B - 13
            R = R - 13
        Else
            B = B + 13
            R = R + 13
        End If
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    '===========Paddle==========

    R = 63
    g = 63
    B = 63

    For I = PadColorMin To PadColorMax
        If I <= PadColorMin + 5 Then
            R = R - 4
            g = g - 4
        Else
            R = R + 4
            g = g + 4
        End If
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    '==========pointer
    WriteRGB 244, 0, 63, 33 'Inside of pointer
    WriteRGB 245, 63, 33, 63 'Border of pointer


End Sub

Sub InitFonts Static

    Shared SmallFonts() As Integer
    Cls
    Open Path$ + "images\" + "small.fnt" For Input As #1

    Input #1, Maxfont



    'Small numbers 0 to 4 height, 0 to 3 wide

    For I = 1 To Maxfont
        For Y = 0 To 4
            JC = JC Mod 5 + 1
            For X = 0 To 3
                Input #1, J
                If J <> 0 Then
                    PSet (X + XX, Y), JC + (FColorMin - 1)
                End If
            Next X
        Next Y
        XX = XX + 5
    Next I

    Close

    NI = 0
    X = 0
    Y = 0
    For I = 1 To Maxfont
        Get (X, Y)-Step(3, 4), SmallFonts(NI * FontOffset%)
        NI = NI + 1
        X = X + 5
    Next I

End Sub

Sub InitImageData (FileName$, ImageArray())

    If FileName$ <> "" Then
        '***** Read image data from file *****

        'Establish size of integer array required.
        FileNo = FreeFile
        Open FileName$ For Binary As #FileNo
        Ints = (LOF(FileNo) - 7) \ 2
        Close #FileNo
        ReDim ImageArray(1 To Ints)

        'Load image data directly into array memory.
        Def Seg = VarSeg(ImageArray(1))
        BLoad FileName$, 0
        Def Seg
    Else
        '***** Read image data from DATA statements *****

        'Establish size of integer array required.
        Read IntCount
        ReDim ImageArray(1 To IntCount)

        'READ image DATA into array.
        For n = 1 To IntCount
            Read X
            ImageArray(n) = X
        Next n
    End If

End Sub

Sub InitNums Static
    Shared SmallNum() As Integer
    Cls

    Open Path$ + "images\" + "smallnum.fnt" For Input As #1

    Input #1, MaxNum


    'Small numbers 0 to 4 height, 0 to 3 wide
    For I = 1 To MaxNum
        For Y = 0 To 4
            JC = JC Mod 5 + 1
            For X = 0 To 3
                Input #1, J
                If J <> 0 Then
                    PSet (X + XX, Y), JC + (SnColorMin - 1)
                End If
            Next X
        Next Y
        XX = XX + 5
    Next I

    Close

    NI = 0
    X = 0
    Y = 0
    For I = 1 To 11
        Get (X, Y)-Step(3, 4), SmallNum(NI * FontOffset)
        NI = NI + 1
        X = X + 5
    Next I

End Sub

Sub InitTrans
    'init Trans

    For I = 0 To 255
        ReadRGB I, R, g, B

        If R >= B And R >= g Then
            Trans(I) = Fix(R / 4)
        ElseIf B >= g And B >= R Then
            Trans(I) = Fix(B / 4)
        ElseIf g >= R And g >= B Then
            Trans(I) = Fix(g / 4)
        Else
            Trans(I) = Fix(g / 4)
        End If
        'Trans(I) = (r + g + b) \ 2     '16 NORMAL
    Next I


End Sub

Sub InitValues Static

    BallSpd = 1 'Change for Speed

    BallXV = BallSpd
    BallYV = -BallSpd
    PadX = 100
    PadY = 170
    PadOldX = PadX
    PadOldY = PadY

    Score& = 0
    Lives = 2

    ColorAttr = 1 + Int(Rnd * 7)
    ColorStep = 1 + Int(Rnd * 50)
    Level = 0

End Sub

Function Inside (X, Y, X1, Y1, X2, Y2) Static

    Inside = False


    If X >= X1 And X <= X2 Then
        If Y >= Y1 And Y <= Y2 Then
            Inside = True
        End If
    End If

    If Y >= Y1 And Y < Y2 Then
        If X >= X1 And X <= X2 Then
            Inside = True
        End If
    End If


End Function

Sub KgenFont (X, Y, Font$, MinColor, Italic) Static

    '=======Prints system fonts on screen  specified by X,Y
    '=======Uses 8 colors from mincolor to Mincolor+8
    '=======Font$ is the string, italic? Duh!!!!!
    '=====Sample Code
    'Note Kgen....Min are constants
    'X = 261
    'Y = 183
    'Font$ = "RelSoft"
    'Italic = True
    'KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
    'KgenFont X, Y, Font$, KgenBlueMin, Italic
    'End Sample
    '======================================================

    Dim E(7): E(0) = 1: For F = 1 To 7: E(F) = E(F - 1) + E(F - 1): Next F

    XXX = X
    YYY = Y

    If X = 320 Then X = 160 - (4 * Len(Font$))




    Def Seg = &HFFA6
    For A = 1 To Len(Font$)
        KC = 0
        If Italic Then
            Ita = 8
        Else
            Ita = 0
        End If

        X = X + 8
        D = Asc(Mid$(Font$, A, 1)) * 8 + 14
        For B = 0 To 7
            For C = 0 To 7
                If Peek(B + D) And E(C) Then PSet ((X - C) + Ita, Y + B), MinColor + KC
            Next C
            KC = KC Mod 8 + 1
            If Italic Then
                Ita = Ita - 1
            End If
        Next B
    Next A

    Def Seg

    X = XXX
    Y = YYY

End Sub

Sub KgenTTFont (X, Y, Font$, MinColor, Xscale, Yscale, Italic) Static

    '=======Prints scalable system fonts on screen  specified by X,Y
    '=======Uses 8 colors from mincolor to Mincolor+8
    '=======Font$ is the string, italic? Duh!!!!!
    '=======Xscale/Yscale are scale to enlarge the font
    '=====Sample Code
    'Note Kgen....Min are constants
    'X = 261
    'Y = 183
    'Xscale=3
    'Yscale=2
    'Font$ = "RelSoft"
    'Italic = True
    'KgenTTFont X - 1, Y - 1, Font$, KgenGreenMin,Xscale,Yscale Italic
    'KgenTTFont X, Y, Font$, KgenBlueMin,,Xscale,Yscale Italic
    'End Sample
    '======================================================

    Dim E(7): E(0) = 1: For F = 1 To 7: E(F) = E(F - 1) + E(F - 1): Next F

    XXX = X
    YYY = Y
    XSS = Xscale
    YSS = Yscale

    If X = 320 Then X = 160 - ((4 * Xscale * Len(Font$)))



    If Italic Then
        Ita = 8
    Else
        Ita = 0
    End If


    Def Seg = &HFFA6
    For A = 1 To Len(Font$)

        KC = 0
        YY = 0
        XX = 0

        X = X + (8 * Xscale)
        D = Asc(Mid$(Font$, A, 1)) * 8 + 14
        For B = 0 To 7
            YY = YY + Yscale
            XX = 0
            For C = 0 To 7
                If Peek(B + D) And E(C) Then Line (X - (C * Xscale) + Ita, Y + YY)-Step(-(Xscale - 1), Yscale - 1), MinColor + KC, BF
                XX = XX + Xscale
            Next C
            KC = KC Mod 8 + 1

            If Italic Then
                Ita = Ita - 1
                If Ita < 1 Then Ita = 8
            End If

        Next B

    Next A

    Def Seg

    X = XXX
    Y = YYY
    Xscale = XSS
    Yscale = YSS

End Sub

Sub LevelDoneBox Static

    PutBall BallX, BallY

    Select Case Level
        Case 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
            X1 = 20
            Y1 = 140
            X2 = 240
            Y2 = Y1 + 40
        Case Else
            X1 = 20
            Y1 = 115
            X2 = 240
            Y2 = Y1 + 40
    End Select

    TransLuc 170, X1, Y1, X2, Y2 '170 best


    X = X1 + 41
    Y = Y1 + 4
    Font$ = Chr$(1) + " Well done!!!! " + Chr$(1)
    Italic = False
    KgenFont X, Y, Font$, KgenMin, Italic

    X = X1 + 42
    Y = Y1 + 5
    Font$ = Chr$(1) + " Well done!!!! " + Chr$(1)
    Italic = False
    KgenFont X, Y, Font$, KgenGreenMin, Italic



    X = X1 + 5
    Y = Y1 + 15
    Font$ = "You have defeated LEVEL:" + LTrim$(Str$(Level))
    Italic = False
    KgenFont X, Y, Font$, KgenBlueMin, Italic

    X = X1 + 32
    Y = Y1 + 28
    Font$ = "Press <Enter> key..."
    Italic = True
    KgenFont X, Y, Font$, KgenBlueMin, Italic

    X = X1 + 33
    Y = Y1 + 29
    Font$ = "Press <Enter> key..."
    Italic = True
    KgenFont X, Y, Font$, KgenGreenMin, Italic


    SfxOpenDialog

End Sub

Sub LimitScore Static

    If Score& >= 99999999 Then
        Score& = 99999999

    End If

End Sub

Sub LoadBallExpImage Static

    ReDim BallExp(1 To 1)
    ReDim BallExpmsk(1 To 1)
    ReDim BallExpIndex(1 To 1)

    FileName$ = "BallExp.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, BallExp()
    FileName$ = "BallExp.msk"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, BallExpmsk()

    MakeImageIndex BallExp(), BallExpIndex()

End Sub

Sub LoadBallImage Static

    ReDim Ball(1 To 1) '1st image=Mask, 2nd=Ball
    ReDim BallIndex(1 To 1)

    FileName$ = "QbBall.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Ball()

    MakeImageIndex Ball(), BallIndex()

End Sub

Sub LoadBlkHoleImage Static


    ReDim BlkHole(1 To 1)
    ReDim BlkHoleMask(1 To 1)

    ReDim BlkHoleIndex(1 To 1)

    FileName$ = "BlkHole.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, BlkHole()
    FileName$ = "BlkHole.Msk"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, BlkHoleMsk()


    MakeImageIndex BlkHole(), BlkHoleIndex()


End Sub

Sub LoadBombImage Static

    ReDim Bomb(1 To 1)
    ReDim BombMsk(1 To 1)
    ReDim BombIndex(1 To 1)

    FileName$ = "Bomb.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Bomb()
    FileName$ = "Bomb.msk"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, BombMsk()

    MakeImageIndex Bomb(), BombIndex()

End Sub

Sub LoadExplodeImage Static

    ReDim Explode(1 To 1)
    ReDim Explodemsk(1 To 1)
    ReDim ExplodeIndex(1 To 1)

    FileName$ = "Explode.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Explode()
    FileName$ = "Explode.msk"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Explodemsk()


    MakeImageIndex Explode(), ExplodeIndex()

End Sub

Sub LoadFlyExpImage Static
    ReDim FlyExp(1 To 1) '1st image=Spr, 2nd =Mask
    ReDim FlyExpIndex(1 To 1)
    FileName$ = "FlyExp.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, FlyExp()

    MakeImageIndex FlyExp(), FlyExpIndex()

End Sub

Sub LoadGame Static

    X = 0
    Y = 0
    ReDim Item$(8)

    Item$(0) = "* * Load * *"
    For I = 1 To UBound(Item$)
        Item$(I) = LTrim$(Str$(Save(I).Num)) + "." + Save(I).Namer
    Next I

    P = PullDown(X, Y, Item$(), False)

    If P <> 0 Then
        'Loadit
        Score& = Save(P).Score
        Level = Save(P).Level - 1
        Lives = Save(P).Lives
        OutStart = True
        Finished = True
    End If


End Sub

Sub LoadLangawImage Static

    ReDim Langaw(1 To 1) '1st/2nd image=Spr, 3/4 =Masks
    ReDim LangawIndex(1 To 1)

    FileName$ = "Langaw.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Langaw()

    MakeImageIndex Langaw(), LangawIndex()

End Sub

Sub LoadPaddleImage Static

    ReDim Paddle(1 To 1) '1st image=Mask, 2nd=paddle,3rd & 4th= PoweredUp Paddle
    ReDim PaddleIndex(1 To 1)

    FileName$ = "Paddle.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Paddle()

    MakeImageIndex Paddle(), PaddleIndex()

End Sub

Sub LoadPadLsrImage Static

    ReDim Padlsr(1 To 1) '1st image=Laser, 2nd =Mask
    ReDim PadlsrIndex(1 To 1)

    FileName$ = "PadLasr.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Padlsr()

    MakeImageIndex Padlsr(), PadlsrIndex()

End Sub

Sub LoadPointerImage Static

    ReDim Pointer(1 To 1) '1st image=Mask, 2nd =pointer
    ReDim PointerIndex(1 To 1)

    FileName$ = "Pointer.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, Pointer()

    MakeImageIndex Pointer(), PointerIndex()

End Sub

Sub LoadPowerCapsImage Static

    ReDim PowerCaps(1 To 1) '1st  to 3rd image=PowerCaps, 4nd =Mask
    ReDim PowerCapsIndex(1 To 1)

    FileName$ = "PwerCaps.put"
    FileName$ = Path$ + "Images\" + FileName$
    InitImageData FileName$, PowerCaps()

    MakeImageIndex PowerCaps(), PowerCapsIndex()

End Sub

Sub LoadSaveFiles Static


    'Saved Games for Loading and Saving
    Open Path$ + "saves\" + "qbnoid.qsv" For Input As #1

    For I = 1 To 8
        Input #1, SaveNum
        Input #1, Name$
        Input #1, ScoreTemp&
        Input #1, LevelTemp
        Input #1, LivesTemp
        Save(I).Num = SaveNum
        Save(I).Namer = Name$
        Save(I).Score = ScoreTemp&
        Save(I).Level = LevelTemp
        Save(I).Lives = LivesTemp
    Next I

    Close

    'Hall of Fame

    Open Path$ + "saves\" + "qbnoid.hof" For Input As #1

    For I = 1 To 5
        Input #1, Rank
        Input #1, Name$
        Input #1, ScoreTemp&
        Hall(I).Rank = Rank
        Hall(I).Namer = Name$
        Hall(I).Score = ScoreTemp&
    Next I

    Close

    SortIt


End Sub

Sub LoadTitle Static

    Line (0, 0)-(320, 199), 0, BF

    Def Seg = &HA000
    BLoad Path$ + "images\" + "arqanoid.bsv", 0

    RestoreColors

    Do
        If RGBCounter(RGBC * 5) Then RotateRGB
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
    Loop Until InKey$ <> ""
    Def Seg

    HazyFx
    Fade 0, 0, 0

    Line (0, 0)-(319, 199), 0, BF

End Sub

Sub MakeImageIndex (ImageArray(), IndexArray())

    'The index will initially be built in a temporary array, allowing
    'for the maximum 1000 images per file.
    Dim Temp(1 To 1000)
    Ptr& = 1: IndexNo = 1: LastInt = UBound(ImageArray)
    Do
        Temp(IndexNo) = Ptr&
        IndexNo = IndexNo + 1

        'Evaluate descriptor of currently referenced image to
        'calculate the beginning of the next image.
        X& = (ImageArray(Ptr&) \ 8) * (ImageArray(Ptr& + 1)) + 4
        If X& Mod 2 Then X& = X& + 1
        Ptr& = Ptr& + (X& \ 2)
    Loop While Ptr& < LastInt

    LastImage = IndexNo - 1

    'Copy the image index values into the actual index array.
    ReDim IndexArray(1 To LastImage)
    For n = 1 To LastImage
        IndexArray(n) = Temp(n)
    Next n

End Sub

Function Menu Static

    Menu = 0

    X = 48
    Y = 10
    ReDim Item$(7)

    Item$(0) = Chr$(2) + Chr$(2) + " Menu " + Chr$(2) + Chr$(2)

    Item$(1) = "New Game"
    Item$(2) = "Save Game"
    Item$(3) = "Load Game"
    Item$(4) = "Special(???)" + Chr$(1)
    Item$(5) = "View Credits"
    Item$(6) = "Hall of Fame"
    Item$(7) = "Exit Game"


    M = PullDown(X, Y, Item$(), True)

    Menu = M

End Function

Sub MilliDelay (msecs) Static

    If sysfact& Then 'calc- system speed yet?
        If msecs Then 'have to want a delay
            COUNT& = (sysfact& * msecs) \ -54 'calc- # of loops needed
            Do
                COUNT& = COUNT& + 1 'negative - add to get to 0
                If COUNT& = z Then Exit Do 'when its 0 we're done
            Loop Until T2 = Peek(&H6C) 'make it the same as below
        End If
    Else 'calc- system speed
        Def Seg = &H40 'point to low memory
        T1 = Peek(&H6C) 'get tick count
        Do
            T2 = Peek(&H6C) 'get tick count
        Loop Until T2 <> T1 'wait 'til its a new tick
        Do
            sysfact& = sysfact& + 1 'count number of loops
            If sysfact& = z Then Exit Do 'make it the same as above
        Loop Until T2 <> Peek(&H6C) 'wait 'til its a new tick
        T2 = 256 'prevent the above UNTIL
    End If

End Sub

Function MovePaddle (PadX, PadY) Static

    GoSub CheckLives

    If Replicant Then
        PadXMax = 180
        If PadX > PadXMax Then
            PutPaddleBG PadOldX, PadOldY
            PadX = PadXMax
        End If
    Else
        PadXMax = 217
    End If


    MovePaddle = False
    Select Case FastKB
        Case KRight, KD
            If PadX < PadXMax - PadSpd Then
                PadX = PadX + PadSpd
                MovePaddle = True
            End If
        Case KLeft, KA
            If PadX > PadSpd + 5 Then
                PadX = PadX - PadSpd
                MovePaddle = True
            End If
        Case KDown, KS, KEnd
            AutoFire = False
            Shooting = False
            Lshot = False
            Rshot = False
        Case KUp, KW, KCtrl
            AutoFire = True
            Shooting = True
            Lshot = True
            Rshot = True
        Case KSpc, KPgd, KTab
            OutStart = True
            AutoFire = False
            Shooting = True
            Lshot = True
            Rshot = True
        Case KEsc
            M = Menu
            GoSub CheckMval
            RefreshKey
        Case KEnt
        Case Else
    End Select


    Exit Function



    '=====================subs=================
    CheckMval:

    Select Case M
        Case 0 'Pressed esc do nothing
        Case 1 'New game
            Score& = 0
            Level = 0
            Lives = 2
            OutStart = True
            Finished = True
        Case 2 'Save Game
            SaveGame
        Case 3 'Load Game
            LoadGame
        Case 4 'Special
            MS = SubMenu
            GoSub CheckMSval
        Case 5 'Credits
            DoCredits
        Case 6 'HallofFame
            DoHallOfFame
        Case 7 'Exit Game
            OutStart = True
            Finished = True
            GameOver = True
            Check4HoF
        Case Else
    End Select

    Return
    '==========
    CheckMSval:
    Select Case MS
        Case 0
        Case 1 'Skip Level
            OutStart = True
            Finished = True
        Case 2 'MoreLives
            Lives = 99
            PrintLives False
        Case 3 'NoSpikes
            Put (7, 183), SpikeBG(), PSet
        Case 4 'PadPower
            If Not SpStage Then
                If Not PadPower Then
                    PadPower = True
                    GoSub InitPadlsr
                End If
            Else
                CheatError
            End If
        Case 5 'Replicant
            If Not SpStage Then
                Replicant = True
            Else
                CheatError
            End If
        Case 6 'EraseFiles
            EraseSaveFiles
        Case Else
    End Select
    Return

    '==========
    CheckLives:

    If Lives < -1 Then
        Finished = True
        GameOver = True
        OutStart = True
        Check4HoF
    End If

    Return


    '=========
    InitPadlsr:

    GetPadLsrCoord 0
    GetPadLsrBG PadLsrBG1(), PadLsrBG2()

    Return



End Function

Sub NameEntry Static


    DX = 10
    DY = 10
    MaxLen = 24
    Title$ = "Ace Player!!!"
    Tmin = PadColorMin
    Sysmod = False
    Text$ = "~~~~Congratulations!!! Kambal! You have a new record! Pls. Send your score to me and I'll give you money.  Just jokin' hehehehe.  "
    Text$ = Text$ + "Actually, you earn NOTHING by playing this game. Just  bragging rights....                                                          "

    ReDim Temp(1)
    GetBG DX, DY, DX + 192, DY + 135, Temp()
    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
    KgenFont DX + 10, DY + 106, "Your Score:", KgenBlueMin, False
    KgenFont DX + 10 + (8 * 11), DY + 106, LTrim$(Str$(Score&)), KgenMin, False
    KgenFont DX + 10, DY + 116, "EnterName:", KgenBlueMin, False


    GoSub EnterName
    SfxOpenDialog

    If P$ = Chr$(13) Then
        'SaveHiscore
        If Len(Item$) > 0 Then
            Hall(5).Namer = Item$
            Hall(5).Score = Score&
            SortIt
            GoSub SaveHOF
        End If
    End If


    DoHallOfFame

    Exit Sub

    '=======================

    EnterName:

    ReDim ST(1)
    GetBG DX + 10 + (10 * 8), DY + 116, (DX + 10 + (10 * 8)) + (12 * 8), DY + 116 + 8, ST()
    Put (DX + 10 + (10 * 8), DY + 116), ST(), PSet
    Item$ = ""


    Do

        Do
            P$ = InKey$
            If Len(Item$) < 12 Then
                KgenFont DX + 10 + (10 * 8) + (Len(Item$) * 8), DY + 116, "_", KgenGreenMin, False
            End If
            If RGBCounter(RGBC * 5) Then RotateRGB
            Wait &H3DA, 8
        Loop Until P$ <> ""

        If Asc(P$) >= 32 And Asc(P$) <= 127 Then
            If Len(Item$) < 12 Then
                Item$ = Item$ + (P$)
                Put (DX + 10 + (10 * 8), DY + 116), ST(), PSet
                KgenFont DX + 10 + (10 * 8), DY + 116, Item$, KgenMin, False
                Sound 1200, 1
                RefreshKey
            Else
                RefreshKey
            End If
        Else
            If P$ = Chr$(8) Then
                If Len(Item$) > 0 Then
                    Item$ = Left$(Item$, Len(Item$) - 1)
                    Put (DX + 10 + (10 * 8), DY + 116), ST(), PSet
                    KgenFont DX + 10 + (10 * 8), DY + 116, Item$, KgenMin, False
                    Sound 1200, 1
                    RefreshKey
                Else
                    RefreshKey
                End If
            End If
        End If

    Loop Until P$ = Chr$(13) Or P$ = Chr$(27)

    Put (DX, DY), Temp(), PSet

    Return

    '=======================
    SaveHOF:

    Open Path$ + "saves\" + "qbnoid.hof" For Output As #1
                
    For I = 1 To 5
        Print #1, Hall(I).Rank
        Print #1, Hall(I).Namer
        Print #1, Hall(I).Score
    Next I


    Close

    Return

End Sub

Sub OpenLvlFile (File$) Static
    Open File$ For Input As #1

    For I = 0 To TileMax
        Input #1, Tile(I).X
        Input #1, Tile(I).Y
        Input #1, Tile(I).C
        If Tile(I).C = 0 Then
            Tile(I).F = False
        Else
            Tile(I).F = True
        End If
    Next I

    Close


End Sub

Sub PlayGame Static


    ReinitValues


    DrawLevelBG Level, ColorStep, ColorAttr 'Bgmode(Unused),Type(looks),color

    GetTileBackGround




    SelectLevel

    DoBlkHole
    DoBomb


    RestoreColors

    Finished = False


    GetBallCenter BallCenterX, BallCenterY


    StartGame


    Do


        GoSub CheckForPowerCaps
        GoSub CheckForPadPwr



        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY


        PutBall BallX, BallY
        PutPaddle PadX, PadY



        GoSub CheckSDHit

        Flag = MovePaddle(PadX, PadY)


        Wait &H3DA, 8
        Wait &H3DA, 8, 8

        GoSub BugFix:


        PutBallBG BallOldX, BallOldY



        If Collide Then
            CheckBounceCounter BounceCounter
        End If



        PutPaddleBG PadOldX, PadOldY


        If PadPower Then
            PutPadLsrBG PadLsrBG1(), PadLsrBG2()
        End If

        If Power Then
            PutPowerCapsBG
        End If

        GoSub RotRGBETC
        'IF BossSTG THEN
        '        DoLangaw False
        'END IF


    Loop Until Finished

    HazyFx

    GoSub CheckFadeTo

    Exit Sub

    '===========subs===========================



    BugFix:


    If BallY < 40 Then
        MilliDelay 5
    End If


    Return


    CheckFadeTo:

    Select Case Level
        Case 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
            Fade 0, 0, 0
        Case Else
            Fade Int(Rnd * 63), Int(Rnd * 63), Int(Rnd * 63)
    End Select

    Return
    '===========
    CheckSDHit:

    If SdHitPad Then
        Sound 3000, 1
        Sound 3400, 1
        SdHitPad = False
    End If

    If SdHitTile Then
        Sound 2300, 1
        SdHitTile = False
        Wait &H3DA, 8
        Wait &H3DA, 8, 8
        BlinkTile False
    End If


    Return

    '=================
    CheckForPadPwr:

    If PadPower Then
        If Not Shooting Then
            GetPadLsrCoord 0
            GetPadLsrBG PadLsrBG1(), PadLsrBG2()
            PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
            PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y
        Else
            DoPadLsr
        End If
    Else

    End If


    Return

    '===========
    CheckForPowerCaps:
    If Power Then
        DoPowerCaps PowerType
    End If
    Return


    '========
    RotRGBETC:
    BlkCount = BlkCount Mod 5 + 1
    BombCount = BombCount Mod 50 + 1
    LangawCount = LangawCount Mod 2 + 1

    If LangawCount = 1 Then
        If BossStg Then
            DoLangaw False
        End If
    End If


    If BlkCount = 1 Then
        DoBlkHole
    End If

    If BombCount = 1 Then

        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY

        PutBall BallX, BallY
        PutPaddle PadX, PadY

        PutBombBG
        DoBomb

        PutPaddleBG PadOldX, PadOldY
        PutBallBG BallOldX, BallOldY
    End If

    If RGBCounter(RGBC) Then RotateRGB

    Return


End Sub

Sub PrintFonts (X, Y, n$) Static

    Shared SmallFonts() As Integer

    n$ = LTrim$(RTrim$(UCase$(n$)))

    Letter$ = "@.,:!?ABCDEFGHIJKLMNOPQRSTUVWXYZ "


    For I = 1 To Len(n$)
        II$ = Mid$(n$, I, 1)
        OffSet = InStr(Letter$, II$)
        Put ((I * 5) + X, Y), SmallFonts((OffSet - 1) * FontOffset), PSet
    Next I


End Sub

Sub PrintLevel Static

    X = 297
    Y = 51

    If Level < 10 Then
        LV$ = "0" + LTrim$(Str$(Level))
    Else
        LV$ = LTrim$(Str$(Level))
    End If

    Font$ = LV$
    Italic = True
    KgenFont X - 2, Y + 1, Font$, KgenMin, Italic
    KgenFont X, Y, Font$, KgenBlueMin, Italic


End Sub

Sub PrintLives (EraseIt) Static



    LY = 76
    LX = 265
    Line (LX, LY - 1)-(320, 122), 0, BF
    For I = 0 To Lives
        If Not EraseIt Then
            Put (LX, LY), Ball(BallIndex(2)), PSet
        Else
            Put (LX, LY), Ball(BallIndex(1)), PSet
        End If

        LX = LX + 7
        If LX > 313 Then
            LX = 265
            LY = LY + 7
        End If

        If I > 40 Then Exit For

    Next I


End Sub

Sub PrintNum (X, Y, n$) Static
    Shared SmallNum() As Integer

    For I = 1 To Len(n$)
        II$ = Mid$(n$, I, 1)
        OffSet = InStr("1234567890,", II$)
        Put ((I * 5) + X, Y), SmallNum((OffSet - 1) * FontOffset), PSet
    Next I


End Sub

Sub PrintScore Static

    Temp$ = LTrim$(Format$(Score&))
    PrintNum 315 - (Len(Temp$) * 5), 35, Temp$

    If Score& >= 100000 Then
        PrintNum 315 - (Len(Temp$) * 5), 12, Temp$
    End If

End Sub

Function PullDown (X, Y, Item$(), Italic) Static

    '=========Draws a PullDown menu==========
    '=========Returns an integer (Value of I)
    '======Sample Code=======================
    'X = 10
    'Y = 20
    'REDIM Item$(8)
    'Item$(0) = "* * Save * *"
    'FOR I = 1 TO UBOUND(Item$)
    'Item$(I) = LTRIM$(STR$(I)) + ".RelSoft 2000"
    'NEXT I
    'P = PullDown(X, Y, Item$(),True)
    '========End Sample========================

    MaxItem = UBound(Item$)
    ReDim PointerCoord(0 To MaxItem) As CoordType
    ReDim PointerCoord2(0 To MaxItem) As CoordType

    ReDim PTemp(34), Ptemp2(34)
    ReDim Temp(1)

    PullDown = 0
    KgenStart = 30

    For I = 0 To MaxItem
        Item$(I) = LTrim$(RTrim$(Item$(I)))
    Next I

    'Calculate how big our box is
    X1 = X
    Y1 = Y

    GoSub CalcBox


    GetBG X1, Y1, X2, Y2, Temp()

    TransLuc 170, X1, Y1, X2, Y2 '170 best

    '=Title
    XX = ((X2 - X1) \ 2) - (4 * (Len(Item$(0))))
    KgenFont X1 + XX - 8, Y1 + 11, Item$(0), KgenMin, Not Italic
    KgenFont X1 + (XX - 8) + 1, Y1 + 12, Item$(0), KgenBlueMin, Not Italic

    GoSub InitCoord
    GoSub DrawItem
    OutPullDown = False

    I = 1
    GoSub GetPLtemp
    PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y


    Do


        If RGBCounter(RGBC * 6) Then RotateRGB
        Wait &H3DA, 8
        GoSub CheckKey


    Loop Until OutPullDown

    Put (X1, Y1), Temp(), PSet

    RefreshKey

    Erase PointerCoord, PointerCoord2, PTemp, Ptemp2, Temp

    Exit Function

    ''==============Subs=========
    '============

    CheckKey:

    Select Case FastKB
        Case KRight, KD
        Case KLeft, KA
        Case KDown, KS
            GoSub PutPLtemp
            I = I Mod MaxItem + 1
            GoSub GetPLtemp
            PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y
            GoSub DosoundP
        Case KUp, KW
            GoSub PutPLtemp
            I = (I + MaxItem - 2) Mod MaxItem + 1
            GoSub GetPLtemp
            PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y
            GoSub DosoundP
        Case KEsc
            OutPullDown = True
            PullDown = 0
            GoSub Dosound2P
        Case KEnt, KSpc
            OutPullDown = True
            GoSub Dosound2P
            PullDown = I
        Case Else
    End Select

    Return

    '============
    InitCoord:

    Ystep = 14
    YY = Y1 + Ystep + 16

    For I = 1 To MaxItem

        PointerCoord(I).X = X1 + 30
        PointerCoord(I).Y = YY
        YY = YY + Ystep

    Next I

    Return




    '==========
    DrawItem:

    For I = 1 To MaxItem

        Font$ = Left$(LTrim$(Item$(I)), 1)
        Font2$ = Right$(LTrim$(Item$(I)), Len(Item$(I)) - 1)

        KgenFont PointerCoord(I).X + 1, PointerCoord(I).Y - 1, Font$, KgenMin, False
        KgenFont PointerCoord(I).X, PointerCoord(I).Y, Font$, KgenGreenMin, False
        KgenFont PointerCoord(I).X + 10, PointerCoord(I).Y, Font2$, KgenStart, Italic
        If Italic Then
            PointerCoord2(I).X = PointerCoord(I).X + ((Len(Font2$) + 2) * 8) + 5
        Else
            PointerCoord2(I).X = PointerCoord(I).X + ((Len(Font2$) + 2) * 8)
        End If
        PointerCoord2(I).Y = PointerCoord(I).Y

    Next I

    Return

    '========
    DosoundP:
    For SI = 500 To 2000 Step 100
        Sound SI, .1
    Next SI
    For SI = 1000 To 500 Step -100
        Sound SI, .1
    Next SI

    Return
    '=======
    Dosound2P:

    Dim Dsi As Single
    Dsi = .9

    For SI = 300 To 3000 Step 50
        If Dsi > .1 Then Dsi = Dsi - .1
        Sound SI, Dsi
    Next SI

    Return



    '========

    GetPLtemp:
    Get (PointerCoord(I).X - 12, PointerCoord(I).Y)-Step(8, 6), PTemp()
    Get (PointerCoord2(I).X, PointerCoord2(I).Y)-Step(8, 6), Ptemp2()
    Return

    PutPLtemp:
    Put (PointerCoord(I).X - 12, PointerCoord(I).Y), PTemp(), PSet
    Put (PointerCoord2(I).X, PointerCoord2(I).Y), Ptemp2(), PSet

    Return


    '===========

    CalcBox:


    For I = 0 To MaxItem
        If Len(Item$(I)) > 18 Then
            Item$(I) = Left$(Item$(I), 18)
        End If
    Next I

    Longest = Len(Item$(0))

    For I = 1 To MaxItem
        If Len(Item$(I)) > Longest Then
            Longest = Len(Item$(I))
        End If
    Next I

    If Italic Then
        LL = 16
    Else
        LL = 12
    End If

    Y2 = (Y1 + 20 + 14 + (MaxItem * 14))
    X2 = (X1 + (Longest * 8)) + 55 + LL

    Return


End Function

Sub PutBall (BallX, BallY) Static


    Put (BallX, BallY), Ball(BallIndex(1)), And
    Put (BallX, BallY), Ball(BallIndex(2)), Xor

End Sub

Sub PutBallBG (BallOldX, BallOldY) Static
    Put (BallOldX, BallOldY), BallBG(), PSet
End Sub

Sub PutBlkHole (X, Y) Static

    I = I Mod UBound(BlkHoleIndex) + 1
    Put (X, Y), BlkHoleMsk(BlkHoleIndex(I)), And
    Put (X, Y), BlkHole(BlkHoleIndex(I)), Or

End Sub

Sub PutBlkHoleBG Static

    For I = 1 To 4
        If BlkHoleXY(I).X <> 0 Then
            Put (BlkHoleXY(I).X, BlkHoleXY(I).Y), BlkHoleBG(130 * (I - 1)), PSet
        End If
    Next I

End Sub

Sub PutBomb (X, Y, Switch) Static

    'Switch must be 1 or 2

    Put (X, Y), BombMsk(BombIndex(Switch)), And
    Put (X, Y), Bomb(BombIndex(Switch)), Or

End Sub

Sub PutBombBG Static

    For I = 1 To UBound(BombXY)
        If BombXY(I).X <> 0 Then
            Put (BombXY(I).X, BombXY(I).Y), BombBG(130 * (I - 1)), PSet
        End If
    Next I

End Sub

Sub PutLangaw (X, Y, Axn) Static

    'Axn=1 or 2
    Put (X, Y), Langaw(LangawIndex(Axn + 2)), And
    Put (X, Y), Langaw(LangawIndex(Axn)), Or


End Sub

Sub PutPaddle (PadX, PadY) Static

    If PadPower Then
        If Replicant Then
            Put (PadX, PadY), Paddle(PaddleIndex(3)), And
            Put (PadX, PadY), Paddle(PaddleIndex(4)), Or
            Put (PadX + 38, PadY), Paddle(PaddleIndex(3)), And
            Put (PadX + 38, PadY), Paddle(PaddleIndex(4)), Or
        Else
            Put (PadX, PadY), Paddle(PaddleIndex(3)), And
            Put (PadX, PadY), Paddle(PaddleIndex(4)), Or
        End If
    Else
        If Replicant Then
            Put (PadX, PadY), Paddle(PaddleIndex(1)), And
            Put (PadX, PadY), Paddle(PaddleIndex(2)), Or
            Put (PadX + 38, PadY), Paddle(PaddleIndex(1)), And
            Put (PadX + 38, PadY), Paddle(PaddleIndex(2)), Or
        Else
            Put (PadX, PadY), Paddle(PaddleIndex(1)), And
            Put (PadX, PadY), Paddle(PaddleIndex(2)), Or
        End If

    End If

End Sub

Sub PutPaddleBG (PadOldX, PadOldY) Static
    Put (PadOldX, PadOldY), PaddleBG(), PSet
End Sub

Sub PutPadLsr (X, Y) Static

    Put (X, Y), Padlsr(PadlsrIndex(2)), And
    Put (X, Y), Padlsr(PadlsrIndex(1)), Or

End Sub

Sub PutPadLsrBG (Image1(), Image2()) Static

    Put (PadLsrOldCoord(0).X, PadLsrOldCoord(0).Y), Image1(), PSet
    Put (PadLsrOldCoord(1).X, PadLsrOldCoord(1).Y), Image2(), PSet

End Sub

Sub PutPointer (X, Y, X2, Y2) Static

    Put (X, Y), Pointer(PointerIndex(1)), And
    Put (X, Y), Pointer(PointerIndex(2)), Or

    Put (X2, Y2), Pointer(PointerIndex(3)), And
    Put (X2, Y2), Pointer(PointerIndex(4)), Or



End Sub

Sub PutPowerCaps (X, Y, PowType) Static

    Put (X, Y), PowerCaps(PowerCapsIndex(4)), And
    Put (X, Y), PowerCaps(PowerCapsIndex(PowType)), Or

End Sub

Sub PutPowerCapsBG Static
    Put (PowerCapsOldCoord(0).X, PowerCapsOldCoord(0).Y), PowerCapsBG(), PSet
End Sub

Sub ReadLevel (Lvl) Static

    OpenLvlFile Path$ + "levels\" + "qbnoid" + LTrim$(Str$(Lvl)) + "." + "lvl"

    TileNumber = 0


    For I = 0 To TileMax
        If Tile(I).F Then
            DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
            If Tile(I).C <> 9 Then
                TileNumber = TileNumber + 1
            End If
        End If
    Next I

End Sub

Sub ReadRGB (C%, R%, g%, B%)

    Out &H3C7, C%
    R% = Inp(&H3C9)
    g% = Inp(&H3C9)
    B% = Inp(&H3C9)

End Sub

Sub RefreshKey Static

    Def Seg = &H40
    Poke &H1A, Peek(&H1C)
    Def Seg


End Sub

Sub ReInitBallSpd Static

    Select Case Sgn(BallXV)
        Case -1
            BallXV = -BallSpd
        Case 1
            BallXV = BallSpd
        Case Else
    End Select

    Select Case Sgn(BallYV)
        Case -1
            BallYV = -BallSpd
        Case 1
            BallYV = BallSpd
        Case Else
    End Select



End Sub

Sub ReinitValues Static

    BallSpd = 1 'Change for Speed


    BallXV = BallSpd
    BallYV = -BallSpd



    PadX = 105
    PadY = 170
    PadOldX = PadX
    PadOldY = PadY


    ColorAttr = 1 + Int(Rnd * 7)
    ColorStep = 1 + Int(Rnd * 50)
    Level = Level Mod 50 + 1

    'Power ups
    PadPower = False 'Paddle changes and can shoot
    Replicant = False 'Replicates ur paddle
    MultiBall = False '?????? not a power up makes d game harder
    Shooting = False
    Lshot = False
    Rshot = False
    Power = False
    BossEnter = False


    'Sounds
    SdHitPad = False 'Sound for PaddleHit
    SdHitTile = False
    SdHitBoss = False

    LimitScore


End Sub

Sub RestoreColors
    II = 0
    I = 0


    For II = 0 To 63


        For I = 0 To 255
            RefreshKey

            ReadRGB I, RR, GG, BB
            R = SavRGB(I).R
            g = SavRGB(I).g
            B = SavRGB(I).B

            If R > RR Then
                RR = RR + 1
            ElseIf R < RR Then
                RR = RR - 1
            Else
                'Do nothing
            End If

            If g > GG Then
                GG = GG + 1
            ElseIf g < GG Then
                GG = GG - 1
            Else
                'Do nothing
            End If

            If B > BB Then
                BB = BB + 1
            ElseIf B < BB Then
                BB = BB - 1
            Else
                'Do nothing
            End If

            WriteRGB I, RR, GG, BB

        Next I

        MilliDelay 30
        Wait &H3DA, 8
        Wait &H3DA, 8, 8

    Next II


End Sub

Function RGBCounter (MaxCounter) Static

    '==========Counts until reaches MaxCounter then True is returned else False
    '==========Used to make Color rotation at same speed

    RGBCounter = False

    I = I Mod MaxCounter + 1
    If I = MaxCounter Then
        RGBCounter = True
    End If

End Function

Sub RotateRGB Static

    '==KGen==================
    'red
    For I = KgenMin To KgenMax - 1
        Swap SavRGB(I), SavRGB(I + 1)
    Next I
    For I = KgenMin To KgenMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    'blue
    For I = KgenBlueMax To KgenBlueMin + 1 Step -1 'Shift Direction Down
        Swap SavRGB(I), SavRGB(I - 1)
    Next I
    For I = KgenBlueMin To KgenBlueMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    'Green
    For I = KgenGreenMin To KgenGreenMax - 1
        Swap SavRGB(I), SavRGB(I + 1)
    Next I
    For I = KgenGreenMin To KgenGreenMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I


    '==End Kgen==========================

    '======Pointer=======================

    If PointerC > 57 Then ClrDir = 1
    If PointerC < 20 Then ClrDir = 0

    If ClrDir = 0 Then PointerC = PointerC + 5
    If ClrDir = 1 Then PointerC = PointerC - 5

    WriteRGB 244, 0, PointerC, 33 'Inside of pointer
    WriteRGB 245, PointerC, 33, PointerC 'Border of pointer

    '======End pointer===================

    '======Paddle========================

    For I = PadColorMin To PadColorMax - 1
        Swap SavRGB(I), SavRGB(I + 1)
    Next I
    For I = PadColorMin To PadColorMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
    Next I

    '=====end paddle====================

End Sub

Sub SaveColors

    For I = 0 To 255
        ReadRGB I, R, g, B
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
    Next I

End Sub

Sub SaveGame Static


    X = 0
    Y = 0
    ReDim Item$(8)

    Item$(0) = "* * Save * *"
    For I = 1 To UBound(Item$)
        Item$(I) = LTrim$(Str$(Save(I).Num)) + "." + Save(I).Namer
    Next I


    P = PullDown(X, Y, Item$(), False)

    If P <> 0 Then

        GoSub EnterLevel

        If Len(LTrim$(Item$(P))) > 1 And P$ = Chr$(13) Then
            'Saveit
            Save(P).Num = P
            Save(P).Namer = Item$(P)
            Save(P).Score = Score&
            Save(P).Level = Level
            Save(P).Lives = Lives
            GoSub Saveit
        End If

    End If


    Exit Sub


    '================Subs========================

    EnterLevel:

    DX = 0
    DY = 150
    MaxLen = 39
    Title$ = ""
    Tmin = PadColorMin
    Text$ = "Save this game as..." + "#" + LTrim$(Str$(P)) + "[" + Space$(12) + "]"
    Sysmod = False
    ReDim Temp(1)
    GetBG DX, DY, DX + 319, DY + 20, Temp()
    DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
    Item$(P) = ""

    ReDim ST(1)
    GetBG DX + 188, DY + 4, DX + 188 + (12 * 8), DY + 4 + 8, ST()
    Put (DX + 188, DY + 4), ST(), PSet


    Do

        Do
            P$ = InKey$
            If Len(Item$(P)) < 12 Then
                KgenFont DX + 188 + (Len(Item$(P)) * 8), DY + 5, "_", KgenMin, False
            End If
            If RGBCounter(RGBC * 5) Then RotateRGB
            Wait &H3DA, 8

        Loop Until P$ <> ""

        If Asc(P$) >= 32 And Asc(P$) <= 127 Then
            If Len(Item$(P)) < 12 Then
                Item$(P) = Item$(P) + (P$)
                Put (DX + 188, DY + 4), ST(), PSet
                KgenFont DX + 188, DY + 5, Item$(P), KgenBlueMin, False
                Sound 1200, 1
                RefreshKey
            Else
                RefreshKey
            End If
        Else
            If P$ = Chr$(8) Then
                If Len(Item$(P)) > 0 Then
                    Item$(P) = Left$(Item$(P), Len(Item$(P)) - 1)
                    Put (DX + 188, DY + 4), ST(), PSet
                    KgenFont DX + 188, DY + 5, Item$(P), KgenBlueMin, False
                    Sound 1200, 1
                    RefreshKey
                Else
                    RefreshKey
                End If
            End If
        End If

    Loop Until P$ = Chr$(13) Or P$ = Chr$(27)

    Put (DX, DY), Temp(), PSet
    SfxOpenDialog

    Return

    '=====================

    Saveit:

    Open Path$ + "saves\" + "qbnoid.qsv" For Output As #1

    For I = 1 To 8

        SaveNum = Save(I).Num
        Name$ = Save(I).Namer
        ScoreTemp& = Save(I).Score
        LevelTemp = Save(I).Level
        LivesTemp = Save(I).Lives

        Print #1, SaveNum
        Print #1, Name$
        Print #1, ScoreTemp&
        Print #1, LevelTemp
        Print #1, LivesTemp
    Next I

    Close

    Return


End Sub

Sub ScrollKgenTT (TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OverTopY, Italic, FirstTime) Static

    '==========Scrolls Scalable KgenTT Fonts on screen=========================
    'Sample code
    'Text$ = "Richard Eric M. Lope Bsn Rn WVSU College of Nursing.  This is Very Cool!!!!!!    "
    'Xscale = 2
    'YScale = 5
    'TopY = 199 - ((YScale) * 9)
    'MinColor = KgenBlueMin
    'Shadow = True
    'OverTop = True
    'OtY = 0
    'Italic = True
    'FirstTime=True  'always True
    'DO
    'ScrollKgenTT TopY, Text$, Xscale, YScale, MinColor, Shadow, OverTop, OtY, Italic
    'CC = CC MOD 8 + 1
    'IF CC = 1 THEN RotateRGB
    'LOOP UNTIL INKEY$ <> ""
    'End sample
    '========================================================================

    If FirstTime Then
        P = 0
        PP = 0
        Counter = 0
        FirstTime = Not FirstTime
    End If



    Y = TopY
    Y2 = OverTopY
    X = 1
    T$ = Text$
    Xs = Xscale
    YS = Yscale
    C = MinColor
    L = Len(Text$)

    ReDim Scroll(1)
    ReDim Scroll2(1)
    ReDim L$(L)

    For I = 1 To L
        L$(I) = Mid$(T$, I, 1)
    Next I


    XX = 312 - (Xs * 9)

    If Shadow Then
        XXX = (8 * Xs) + 1
    Else
        XXX = 8 * Xs
    End If


    GetBG X, Y, 319, Y + (8 * YS) + YS, Scroll()
    Put (X - 1, Y), Scroll(), PSet
    If OverTop Then
        GetBG 0, Y2, 318, Y2 + (8 * YS) + YS, Scroll2()
        Put (1, Y2), Scroll2(), PSet
    End If

    Counter = (Counter Mod (Xs * 8)) + 1


    If Counter = 1 Then
        P = P Mod L + 1
        PP = (PP + L - 2) Mod L + 1
        If Shadow Then
            KgenTTFont XX - 1, Y - 1, L$(P), KgenMin, Xs, YS, Italic
            If OverTop Then
                KgenTTFont XXX - 1, Y2, L$(PP), KgenMin, Xs, YS, Italic
            End If
        End If

        KgenTTFont XX, Y, L$(P), C, Xs, YS, Italic
        If OverTop Then
            KgenTTFont XXX, Y2 + 1, L$(PP), C, Xs, YS, Italic
        End If


    End If

End Sub

Sub SelectLevel


    ReadLevel Level


    For I = 1 To UBound(BombXY)
        BombXY(I).X = 0
        BombXY(I).Y = 0
    Next I

    BombNum = UBound(BombXY)

    For I = 1 To UBound(BlkHoleXY)
        BlkHoleXY(I).X = 0
        BlkHoleXY(I).Y = 0
    Next I
    BombSTG = False
    BossStg = False


    Select Case Level
        Case 5
            'Bonus 1
            CalcBombCoord 5
        Case 10
            'Boss 1

            BossX = 73
            BossY = 9
            DrawBoss BossX, BossY, "Rotator"
            TileNumber = 1
            BossLife = 2000
            BlkHoleXY(1).X = 24
            BlkHoleXY(1).Y = 95
            BlkHoleXY(2).X = 60
            BlkHoleXY(2).Y = 55
            BlkHoleXY(3).X = 185
            BlkHoleXY(3).Y = 55
            BlkHoleXY(4).X = 220
            BlkHoleXY(4).Y = 95
            BossStg = True
            CalcLangawCoord
        Case 15
            'Bonus 2
            CalcBombCoord 4
        Case 20
            'Boss 2
            BossX = 85
            BossY = 9
            DrawBoss BossX, BossY, "TGL"
            TileNumber = 1
            BossLife = 2500
            BlkHoleXY(1).X = 22
            BlkHoleXY(1).Y = 59
            BlkHoleXY(2).X = 230
            BlkHoleXY(2).Y = 59
            BlkHoleXY(3).X = 70
            BlkHoleXY(3).Y = 91
            BlkHoleXY(4).X = 180
            BlkHoleXY(4).Y = 91
            BossStg = True
            CalcLangawCoord
        Case 25
            'Bonus 3
            CalcBombCoord 3

        Case 30
            'Boss 3
            BossX = 45
            BossY = 11
            DrawBoss BossX, BossY, "Ku2"
            TileNumber = 1
            BossLife = 3000
            BlkHoleXY(1).X = 95
            BlkHoleXY(1).Y = 110
            BlkHoleXY(2).X = 150
            BlkHoleXY(2).Y = 110
            BlkHoleXY(3).X = 72
            BlkHoleXY(3).Y = 90
            BlkHoleXY(4).X = 176
            BlkHoleXY(4).Y = 90
            BossStg = True
            CalcLangawCoord
        Case 35
            'Bonus 4
            CalcBombCoord 2
        Case 40
            'Boss 4
            BossX = 63
            BossY = 9
            DrawBoss BossX, BossY, "Mummy"
            TileNumber = 1
            BossLife = 4000
            BlkHoleXY(1).X = 23
            BlkHoleXY(1).Y = 100
            BlkHoleXY(2).X = 23
            BlkHoleXY(2).Y = 80
            BlkHoleXY(3).X = 226
            BlkHoleXY(3).Y = 80
            BlkHoleXY(4).X = 226
            BlkHoleXY(4).Y = 100

            BossStg = True
            CalcLangawCoord
        Case 45
            'Bonus 5
            CalcBombCoord 1

        Case 50
            'Boss 5

            BossX = 97
            BossY = 11
            DrawBoss BossX, BossY, "SkullQB"
            TileNumber = 1
            BossLife = 5000
            BlkHoleXY(1).X = 17
            BlkHoleXY(1).Y = 130
            BlkHoleXY(2).X = 112
            BlkHoleXY(2).Y = 130
            BlkHoleXY(3).X = 133
            BlkHoleXY(3).Y = 130
            BlkHoleXY(4).X = 226
            BlkHoleXY(4).Y = 130

            BossStg = True
            CalcLangawCoord
        Case Else
            'load Normal Levels
            BossLife = 1
            For I = 1 To 4
                BlkHoleXY(I).X = 0
                BlkHoleXY(I).Y = 0
            Next




    End Select

    PrintLevel
    GetBlkHoleBG

End Sub

Sub SfxOpenDialog Static

    For II = 400 To 900 Step 10
        Sound II, .1
    Next II


End Sub

Sub SfxPowerUp Static

    Dim Dsi As Single

    GetBallBG BallX, BallY
    GetPaddleBG PadX, PadY

    PutBall BallX, BallY
    PutPaddle PadX, PadY
    For SI = 500 To 1400 Step 100
        Dsi = Rnd
        Sound SI, Dsi
    Next SI
    PutPaddleBG PadOldX, PadOldY
    PutBallBG BallOldX, BallOldY
End Sub

Sub SndExplode Static


    For SI = 3000 To 400 Step -250
        Sound SI, .1
    Next SI

End Sub

Sub SortIt Static
    'Dont Bother with this. It's bubble sort Slow but gets the job done this time

    Do
        Switcher = False
        For I = 1 To 4
            If Hall(I).Score < Hall(I + 1).Score Then

                Hall(I + 1).Rank = I
                Hall(I).Rank = I + 1
                Swap Hall(I), Hall(I + 1)

                Switcher = True

            End If
        Next I
    Loop While Switcher


End Sub

Function SpecialStage (DX, DY, MaxLen, Tmin, Title$, Text$)

    SpecialStage = False
    DX = 0
    DY = 0
    MaxLen = 0
    Title$ = ""
    Tmin = PadColorMin
    Text$ = ""


    Select Case Level
        '====Bosses=================
        Case 10
            DX = 22
            DY = 70
            MaxLen = 27
            Title$ = "Rotator:"
            Tmin = PadColorMin
            Text$ = "~~~~You have beat me first to have a chance at defeating GIGA!!! Not even KONAMI(tm) could stop me!"
            SpecialStage = True
        Case 20
            DX = 22
            DY = 70
            MaxLen = 27
            Title$ = "ZAVOT:"
            Tmin = PadColorMin
            Text$ = "~~~~This would be your last stop! Ull die here 4 sure. I Zavot will shave all of your hair! Mwa ha ha ha..."
            SpecialStage = True
        Case 30
            DX = 22
            DY = 70
            MaxLen = 27
            Title$ = "Ku2:"
            Tmin = PadColorMin
            Text$ = "~~~~Hik hik hik hik... I you dare challenge me?! The parasites of all parasites?! Ha! I'll kill you now..."
            SpecialStage = True
        Case 40
            DX = 22
            DY = 70
            MaxLen = 27
            Title$ = "The Rock:"
            Tmin = PadColorMin
            Text$ = "~~~~Time will never stop me from conquering ur world. Without Brendan Frasier and his extremely vivacious wife 2 help u... I, the Scorpion King will be victorious!!!"
            SpecialStage = True

        Case 50
            DX = 22
            DY = 70
            MaxLen = 27
            Title$ = "GIGA:"
            Tmin = PadColorMin
            Text$ = "~~~~You idiot!!! How many times do I have to kill one of your race 4 u 2 understand that even ur whole army can't withstand the wrath of Gago?! Now Die!!!"
            SpecialStage = True

            '======Bonus stages=========
        Case 5
            GoSub BonusDialog
        Case 15
            GoSub BonusDialog
        Case 25
            GoSub BonusDialog
        Case 35
            GoSub BonusDialog
        Case 45
            GoSub BonusDialog
        Case Else
    End Select


    Exit Function


    '==================

    BonusDialog:


    Put (7, 183), SpikeBG(), PSet

    DX = 22
    DY = 70
    MaxLen = 27
    Title$ = "       Bonus Stage!"
    Tmin = PadColorMin
    Text$ = "~~~~Pop as much BOMBS as possible before time runs out! Good luck!"
    SpecialStage = True
    BombDes = 0

    Return

End Function

Sub StartGame Static


    PrintLives False

    OutStart = False
    BallSpd = 1
    BounceCounter = 0


    BallX = PadX + (16)



    GetPadLsrCoord 0
    GetPadLsrBG PadLsrBG1(), PadLsrBG2()


    If SpecialStage(DX, DY, MaxLen, MinColor, Title$, Text$) Then
        If Not BossEnter Then
            Sysmod = True
            DialogBox DX, DY, MaxLen, MinColor, Title$, Text$, False, Sysmod
            BossEnter = True
        End If
        SpStage = True
    Else
        SpStage = False
    End If


    '''==========Start Loop===============

    Do

        Shooting = False
        Lshot = False
        Rshot = False

        GoSub CheckForPadPower:


        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY



        PutBall BallX, BallY
        PutPaddle PadX, PadY

        Flag = MovePaddle(PadX, PadY)
        BallX = PadX + (16)


        'Millidelay 2


        Wait &H3DA, 8



        PutBallBG BallOldX, BallOldY

        PutPaddleBG PadOldX, PadOldY

        If PadPower Then
            PutPadLsrBG PadLsrBG1(), PadLsrBG2()
        End If


        GoSub RotMisc


    Loop Until OutStart

    ''===================End loop=========================

    PutBombBG
    DoBomb


    BallXV = BallSpd
    BallYV = -BallSpd

    Exit Sub

    '==============Subs========================
    CheckForPadPower:

    If PadPower Then
        If Not Shooting Then
            GetPadLsrCoord 0
            GetPadLsrBG PadLsrBG1(), PadLsrBG2()
            PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
            PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y
        Else
            DoPadLsr
        End If
        BallY = PadY - 7
    Else
        BallY = PadY - 4
    End If

    Return

    '==============
    RotMisc:

    If RGBCounter(RGBC) Then RotateRGB

    BlkCount = BlkCount Mod 5 + 1
    BombCount = BombCount Mod 50 + 1
    LangawCount = LangawCount Mod 2 + 1

    If LangawCount = 1 Then
        If BossStg Then
            DoLangaw False
        End If
    End If

    If BlkCount = 1 Then
        DoBlkHole

    End If

    If BombCount = 1 Then
        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY

        PutBall BallX, BallY
        PutPaddle PadX, PadY

        PutBombBG
        DoBomb

        PutPaddleBG PadOldX, PadOldY
        PutBallBG BallOldX, BallOldY

    End If

    Return




End Sub

Function SubMenu Static


    SubMenu = 0

    X = 35
    Y = 20
    ReDim Item$(6)

    Item$(0) = Chr$(2) + " Debug Code " + Chr$(2)

    Item$(1) = "Skip Level!!!"
    Item$(2) = "More Lives!!!"
    Item$(3) = "No Spikes!!!"
    Item$(4) = "Power Paddle!!!"
    Item$(5) = "Replicant!!!"
    Item$(6) = "Erase Saves!"


    S = PullDown(X, Y, Item$(), True)

    SubMenu = S

End Function

Sub TransLuc (n, X1, Y1, X2, Y2)
    'N= Test Value of Color
    'X1=MinX
    'X2=MaxX
    'Y1=MinY
    'Y2=MaxY


    Def Seg = &HA000
    For I = 0 To 2
        Line (X1 + I, Y1 + I)-(X2 - I, Y1 + I), KgenMin + I + 1
        Line (X1 + I, Y1 + I)-Step(0, I + 2), KgenMin + I + 1
        Line (X2 - I, Y1 + I)-Step(0, I + 2), KgenMin + I + 1
    Next I

    For Y = Y1 + 3 To Y2 - 3
        Poke (Y * 320& + X1), KgenMin + 1
        Poke (Y * 320& + X1 + 1), KgenMin + 2
        Poke (Y * 320& + X1 + 2), KgenMin + 3
        For X = X1 + 3 To X2 - 3
            C = Peek(Y * 320& + X)
            Poke (Y * 320& + X), Trans(C) + n
        Next X
        Poke (Y * 320& + X2), KgenMin + 1
        Poke (Y * 320& + X2 - 1), KgenMin + 2
        Poke (Y * 320& + X2 - 2), KgenMin + 3
    Next Y
    For I = 0 To 2
        Line (X1 + I, Y2 - I)-(X2 - I, Y2 - I), KgenMin + I + 1
        Line (X1 + I, Y2 - I)-Step(0, I - 2), KgenMin + I + 1
        Line (X2 - I, Y2 - I)-Step(0, I - 2), KgenMin + I + 1

    Next I

    Def Seg

End Sub

Sub WriteRGB (C%, R%, g%, B%)

    Out &H3C8, C%

    Out &H3C9, R%
    Out &H3C9, g%
    Out &H3C9, B%

End Sub

