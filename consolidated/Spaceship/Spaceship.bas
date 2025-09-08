'Spaceship, by @FellippeHeitor (2016)
'--------------------------------------------------------------------------
$RESIZE:SMOOTH

DECLARE LIBRARY
    FUNCTION GetUptime ALIAS GetTicks
END DECLARE

CONST godMode = -1

IF godMode THEN _FULLSCREEN
$EXEICON:'.\ship.ico'
_ICON
_SCREENMOVE _MIDDLE
_TITLE "Spaceship"
DEFLNG A-Z

DIM SHARED SONG(1 TO 3) AS LONG
Path$ = "Audio\"
SONG(1) = _SNDOPEN(Path$ + "levelintro.ogg", "SYNC,PAUSE")
PlaySong SONG(1)

' declare constants and types
CONST MaxStars = 15
CONST MaxBeams = 10
CONST MaxEnemyBeams = 10

CONST ScreenMap.Bonus = 1
CONST ScreenMap.Enemy = 2
CONST ScreenMap.EnemyLaser = 3

TYPE ObjectsTYPE
    ID AS INTEGER
    X AS SINGLE
    Y AS INTEGER
    Width AS INTEGER
    Height AS INTEGER
    Color AS INTEGER
    LastFrameUpdate AS DOUBLE
    ColorPattern AS STRING * 256
    ColorSteps AS INTEGER
    CurrentColorStep AS INTEGER
    Shape AS STRING * 4000
    TotalShapes AS INTEGER
    CurrentShape AS INTEGER
    Points AS INTEGER
    Hits AS INTEGER
    IsVisible AS _BYTE
    RelativeSpeed AS INTEGER
    Char AS STRING * 1
    Size AS INTEGER
    StartTime AS DOUBLE
    MovePattern AS STRING * 256
    MoveSteps AS INTEGER
    CanReverse AS _BYTE
    Chase AS _BYTE
    CurrentMoveStep AS INTEGER
    CanShoot AS _BYTE
END TYPE

'Variable declaration
DIM i, StartTime#, x, Found AS _BYTE, a$, TotalControllers AS INTEGER
DIM ReturnedButton$, SavedDevice%, Dummy
DIM SHARED GetButton.NotFound AS _BYTE, GetButton.Found AS _BYTE, GetButton.Multiple AS _BYTE

DIM x AS INTEGER, y AS INTEGER
DIM SHARED ScreenMap(1 TO 80, 1 TO 25) AS DOUBLE
DIM SHARED GoalAchieved AS _BYTE, ChapterGoal AS INTEGER
DIM SHARED KilledEnemies AS INTEGER, Countdown#
DIM SHARED WeKilledFirst AS _BYTE
DIM SHARED GameMode AS _BYTE
DIM SHARED BossFight AS _BYTE
DIM SHARED VisibleEnemies AS INTEGER
DIM Collision AS _BYTE
DIM row AS SINGLE, RoundRow AS INTEGER
DIM SHARED BackupStarFieldSpeed AS DOUBLE, StarFieldSpeed AS DOUBLE
DIM SHARED EnemiesSpeed AS DOUBLE, BackupEnemiesSpeed AS DOUBLE
DIM ShieldImages(1 TO 10) AS LONG
DIM SmokeImages(1 TO 3) AS LONG
DIM ShieldInitiated#, LastShieldImage AS INTEGER
DIM x(1 TO 8) AS INTEGER, y(1 TO 8) AS INTEGER
DIM SHARED MaxEnemies AS INTEGER
DIM SHARED Starfield(MaxStars) AS ObjectsTYPE
DIM SHARED Enemies(200) AS ObjectsTYPE
DIM SHARED Beams(MaxBeams) AS ObjectsTYPE
DIM SHARED EnemyBeams(MaxEnemyBeams) AS ObjectsTYPE
DIM SHARED Chapter, Energy AS SINGLE, Level
DIM ShieldCanvas, c, Boom$
DIM CarefulMessage#, EnergyWarning#
DIM Points, Lives AS INTEGER, EnergyBars AS INTEGER
DIM SHARED Recharge AS _BYTE, Alive AS _BYTE, ShipSize AS _BYTE
DIM UpperLimit AS INTEGER, LowerLimit AS INTEGER, LeftLimit AS INTEGER
DIM SHARED ShipColor AS INTEGER
DIM k$
DIM SHARED Pause AS _BYTE
DIM Shield AS _BYTE, LastRecharge#
DIM SHARED LastPause#, PauseOffset#
DIM Stars AS _BYTE, id AS INTEGER, RechargeTime#
DIM move_stars_Last#, move_enemies_Last#
DIM LastEngineEnergy#, prevX AS INTEGER, prevY AS INTEGER
DIM Smoke AS _BYTE, Char$, ShotsFired AS _BYTE
DIM LaserAnimationStep AS _BYTE, Laser.X AS INTEGER
DIM Laser.Y AS INTEGER, j AS INTEGER, drawIt AS INTEGER
DIM Visible AS _BYTE, CheckEnemy AS INTEGER, Boom.X AS INTEGER
DIM Boom.Y AS INTEGER, EnemyExplosion AS _BYTE
DIM ExplosionAnimationStep AS _BYTE, l AS INTEGER
DIM L1 AS _BYTE, L2 AS _BYTE, L3 AS _BYTE
DIM NewBeam AS INTEGER, LastBeam#, EnergyStat$
DIM LastEnemyBeam#
DIM EnergyWarningText AS _BYTE
DIM SHARED Mute AS _BYTE
DIM SHARED UseKeyboard AS _BYTE

DIM SHARED Bonus.Active AS _BYTE, Bonus.Color AS INTEGER
DIM SHARED Bonus.X AS INTEGER, Bonus.Y AS INTEGER, Bonus.Shape$
DIM SHARED Bonus.Speed#
DIM SHARED Bonus.Width AS INTEGER, Bonus.Height AS INTEGER
DIM SHARED Bonus.Type$
DIM SHARED Bonus.ColorPattern AS STRING
DIM SHARED Bonus.ColorSteps AS INTEGER
DIM SHARED Bonus.CurrentColorStep AS INTEGER

DIM ShieldColorIndex AS INTEGER, LastShieldColor#
DIM x.offset!, Damage AS _BYTE, DeathMessage$
DIM PauseMessage$, bx AS INTEGER, by AS INTEGER
DIM brow!

'Animation uses ASCII character 7, which normally beeps when printed to the screen.
'Let's turn this behavior off:
_CONTROLCHR OFF

'Custom types:
TYPE DevType
    ID AS INTEGER
    Name AS STRING * 256
END TYPE

TYPE ButtonMapType
    ID AS LONG
    Name AS STRING * 10
END TYPE

REDIM SHARED MyDevices(0) AS DevType
DIM SHARED ChosenController

'Initialize ButtonMap for the assignment routine
DIM SHARED ButtonMap(1 TO 8) AS ButtonMapType
i = 1
ButtonMap(i).Name = "START": i = i + 1
ButtonMap(i).Name = "SELECT": i = i + 1
ButtonMap(i).Name = "UP": i = i + 1
ButtonMap(i).Name = "DOWN": i = i + 1
ButtonMap(i).Name = "LEFT": i = i + 1
ButtonMap(i).Name = "RIGHT": i = i + 1
ButtonMap(i).Name = "FIRE": i = i + 1
ButtonMap(i).Name = "SPECIAL": i = i + 1

'Detection routine:
PRINT "Detecting your controller. Press any button..."
PRINT "(If you don't have a controller, press any key on your keyboard)"
StartTime# = GetTICKS
DO
    x& = _DEVICEINPUT
    IF x& = 1 OR x& > 2 THEN
        'Keyboard is 1, Mouse is 2. Anything after that could be a controller.
        Found = -1
        EXIT DO
    END IF
    k = _KEYHIT
    IF k = 27 THEN EXIT DO
    IF k <> 0 THEN UseKeyboard = -1: Found = -1: EXIT DO
LOOP UNTIL GetTICKS - StartTime# > 10

IF Found = 0 THEN
    PRINT "No controller detected."
    END
END IF

IF UseKeyboard = 0 THEN
    FOR i = 1 TO _DEVICES
        a$ = _DEVICE$(i)
        IF INSTR(a$, "CONTROLLER") > 0 OR INSTR(a$, "KEYBOARD") > 0 THEN
            TotalControllers = TotalControllers + 1
            REDIM _PRESERVE SHARED MyDevices(1 TO TotalControllers) AS DevType
            MyDevices(TotalControllers).ID = i
            MyDevices(TotalControllers).Name = a$
        END IF
    NEXT i

    'IF godMode THEN ChosenController = 2: GOTO AssignKeys
    IF TotalControllers > 1 THEN
        'More than one controller found, user can choose which will be used
        '(though I highly suspect this bit will never be run)
        PRINT "Controllers found:"
        FOR i = 1 TO TotalControllers
            PRINT i, MyDevices(i).Name
        NEXT i
        DO
            INPUT "Your choice (0 to quit): ", ChosenController
            IF ChosenController = 0 THEN END
        LOOP UNTIL ChosenController <= TotalControllers
    ELSE
        ChosenController = 1
    END IF
ELSE
    TotalControllers = TotalControllers + 1
    REDIM _PRESERVE SHARED MyDevices(1 TO TotalControllers) AS DevType
    MyDevices(TotalControllers).ID = 1
    MyDevices(TotalControllers).Name = "KEYBOARD"
    ChosenController = 1
END IF

IF ChosenController = 1 AND INSTR(_OS$, "WIN") = 0 THEN UseKeyboard = -1

AssignKeys:
CLS
LOCATE 25, 1
COLOR 8
IF NOT UseKeyboard THEN
    PRINT "Using "; RTRIM$(MyDevices(ChosenController).Name);
ELSE
    PRINT "Using KEYBOARD";
END IF
PRINT
IF _FILEEXISTS("controller.dat") = 0 THEN
    i = 0

    IF UseKeyboard THEN
        _KEYCLEAR
    ELSE
        'Wait until all buttons in the deviced are released:
        DO
        LOOP UNTIL GetButton("", MyDevices(ChosenController).ID) = GetButton.NotFound
    END IF

    'Start assignment
    DO
        i = i + 1
        IF i > UBOUND(ButtonMap) THEN EXIT DO
        Redo:
        IF NOT UseKeyboard THEN
            PRINT "PRESS BUTTON FOR '" + RTRIM$(ButtonMap(i).Name) + "'...";

            'Read a button
            ReturnedButton$ = ""
            DO
            LOOP UNTIL GetButton(ReturnedButton$, 0) = GetButton.Found

            'Wait until all buttons in the deviced are released:
            DO
            LOOP UNTIL GetButton("", 0) = GetButton.NotFound

            ButtonMap(i).ID = CVI(ReturnedButton$)
        ELSE
            PRINT "PRESS A KEY FOR '" + RTRIM$(ButtonMap(i).Name) + "'...";

            'Read a key
            k = 0
            DO WHILE k <= 0: k = _KEYHIT: LOOP
            _KEYCLEAR
            ReturnedButton$ = MKL$(k)
            ButtonMap(i).ID = CVL(ReturnedButton$)
        END IF
        PRINT
    LOOP
    OPEN "controller.dat" FOR BINARY AS #1
    PUT #1, 1, MyDevices(ChosenController).ID
    PUT #1, , ButtonMap()
    CLOSE #1
ELSE
    OPEN "controller.dat" FOR BINARY AS #1
    GET #1, 1, SavedDevice%
    GET #1, , ButtonMap()
    CLOSE #1
    IF SavedDevice% <> MyDevices(ChosenController).ID THEN
        ON ERROR GOTO FileError
        KILL "controller.dat"
        ON ERROR GOTO 0
        GOTO AssignKeys
    END IF
    'FOR i = 1 TO UBOUND(Buttonmap)
    '    PRINT ButtonMap(i).Name; "="; ButtonMap(i).ID
    'NEXT
END IF
GOTO DemoStart
PRINT
PRINT "Push START..."
PRINT "(DELETE to reassign keys)"
DO
    IF _KEYHIT = 21248 THEN
        ON ERROR GOTO FileError
        KILL "controller.dat"
        ON ERROR GOTO 0
        GOTO AssignKeys
    END IF
LOOP UNTIL GetButton("START", MyDevices(ChosenController).ID)

'Demo goes here: -----------------------------------------------------------------------------------
DemoStart:
Dummy = GetButton("", MyDevices(ChosenController).ID)
RANDOMIZE TIMER

'Load audio
_PALETTECOLOR 0, _RGBA32(0, 0, 0, 0)
_PALETTECOLOR 1, _RGB32(55, 55, 55)
_DISPLAYORDER _HARDWARE , _SOFTWARE

RESTORE SpaceshipLogo
titlecard& = RestoreImage&(_RGB32(233, 200, 94))
_PUTIMAGE (((_WIDTH * _FONTWIDTH) \ 2) - (_WIDTH(titlecard&) \ 2), 100), titlecard&, 0

PRINT
COLOR 15
Load$ = "LOADING AUDIO"
_PRINTSTRING (41 - LEN(Load$) / 2, 12), Load$
_DISPLAY

DIM SNDCatchEnergy, SNDFullRecharge, SNDShieldAPPEAR, SNDShieldON
DIM SNDLaser1, SNDLaser2, SNDShipDamage, SNDShipGrow, SNDEnergyUP
DIM SNDExplosion, SNDOutOfEnergy, SNDExtraLife, SNDShieldOFF
DIM SNDIntercom, SNDBlizzard

SNDBlizzard = _SNDOPEN(Path$ + "Blizzard.wav", "SYNC")
SNDIntercom = _SNDOPEN(Path$ + "Intercom.wav", "SYNC")
SNDCatchEnergy = _SNDOPEN(Path$ + "CatchEnergy.wav", "SYNC")
SNDFullRecharge = _SNDOPEN(Path$ + "FullRecharge.wav", "SYNC")
SNDShieldAPPEAR = _SNDOPEN(Path$ + "ShieldAPPEAR.wav", "SYNC")
SNDShieldON = _SNDOPEN(Path$ + "ShieldON.wav", "SYNC")
SNDShieldOFF = _SNDOPEN(Path$ + "ShieldOFF.wav", "SYNC")
SNDLaser1 = _SNDOPEN(Path$ + "Laser1.wav", "SYNC")
SNDLaser2 = _SNDOPEN(Path$ + "Laser2.wav", "SYNC")
SNDShipDamage = _SNDOPEN(Path$ + "ShipDamage.wav", "SYNC")
SNDShipGrow = _SNDOPEN(Path$ + "ShipGrow.wav", "SYNC")
SNDEnergyUP = _SNDOPEN(Path$ + "EnergyUP.wav", "SYNC")
SNDExplosion = _SNDOPEN(Path$ + "Explosion1.wav", "SYNC")
SNDOutOfEnergy = _SNDOPEN(Path$ + "OutOfEnergy.wav", "SYNC")
SNDExtraLife = _SNDOPEN(Path$ + "ExtraLife.wav", "SYNC")
SONG(2) = _SNDOPEN(Path$ + "bossfight.ogg", "SYNC,PAUSE")
SONG(3) = _SNDOPEN(Path$ + "level1.ogg", "SYNC,PAUSE")

PlaySong SONG(3)

'Generate smoke images --------------------------------------------
SmokeCanvas = _NEWIMAGE(3 * _FONTWIDTH, _FONTHEIGHT, 32)
_DEST SmokeCanvas

COLOR _RGB32(89, 89, 89), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(176) + CHR$(177)
COLOR _RGB32(144, 144, 144), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(32) + CHR$(32) + CHR$(178)
SmokeImages(3) = _COPYIMAGE(SmokeCanvas, 33)
CLS
COLOR _RGB32(89, 89, 89), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(32) + CHR$(177) + CHR$(178)
COLOR _RGB32(144, 144, 144), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(32) + CHR$(32) + CHR$(178)
SmokeImages(2) = _COPYIMAGE(SmokeCanvas, 33)
CLS
COLOR _RGB32(89, 89, 89), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(32) + CHR$(32) + CHR$(178)
COLOR _RGB32(144, 144, 144), _RGBA32(0, 0, 0, 0)
_PRINTSTRING (0, 0), CHR$(32) + CHR$(32) + CHR$(178)
SmokeImages(1) = _COPYIMAGE(SmokeCanvas, 33)
_DEST 0
_FREEIMAGE SmokeCanvas

'Generate shield images --------------------------------------------
ShieldCanvas = _NEWIMAGE(7 * _FONTWIDTH, 4 * _FONTHEIGHT, 32)
_DEST ShieldCanvas
FOR c = 1 TO 10
    COLOR _RGBA32(RND * 200 + 50, RND * 200 + 50, RND * 200 + 50, 25.5 * c)
    FOR i = 1 TO 4
        _PRINTSTRING (0, _FONTHEIGHT * i - _FONTHEIGHT), STRING$(7, 176)
    NEXT i
    ShieldImages(c) = _COPYIMAGE(ShieldCanvas, 33)
NEXT c
_FREEIMAGE ShieldCanvas
_DEST 0

'Generate "life bar" image ------------------------------------------
LifeBarCanvas = _NEWIMAGE(80 * _FONTWIDTH, _FONTHEIGHT, 32)
_DEST LifeBarCanvas
FOR i = 1 TO 80
    COLOR _RGBA32(255, 0, 0, (150 * (i / 80)) + 105)
    _PRINTSTRING (i * _FONTWIDTH - _FONTWIDTH, 0), CHR$(219)
NEXT
LifeBarImage = _COPYIMAGE(LifeBarCanvas, 33)
_FREEIMAGE LifeBarCanvas
_DEST 0

Boom$ = CHR$(219) + CHR$(178) + CHR$(177) + CHR$(176) + CHR$(15) + CHR$(7) + CHR$(249) + CHR$(250)

CONST Acceleration = .005
CONST GraceTime = 2

CONST EASY = 1
CONST HARD = 2

RestartGame:
ERASE Enemies
CarefulMessage# = -1.5
EnergyWarning# = -1
ShieldONMessage# = -1
ShieldOFFMessage# = -1
ShieldColorIndex = 1
x = 5
y = 25
Points = 0
Lives = 3
Energy = 0
EnergyBars = 0
Recharge = -1
Level = 1
Chapter = 1
SetLevel Chapter
Alive = -1
ShipSize = 2: UpperLimit = 6: LowerLimit = 47: LeftLimit = 5
InitialSetup = -1
ShipColor = 14
StarFieldSpeed = .08
WeKilledFirst = 0
GameMode = HARD

'Wait until all buttons are released:
DO
LOOP UNTIL GetButton("", 0) = GetButton.NotFound

DO
    k$ = INKEY$
    IF k$ = CHR$(27) THEN EscExit = -1: EXIT DO
    IF UCASE$(k$) = "M" THEN Mute = NOT Mute
    IF godMode AND UCASE$(k$) = "F" THEN Freeze = NOT Freeze: IF Freeze THEN FreezeInitiated# = GetTICKS
    IF Mute THEN
        IF NOT Pause THEN
            PauseSong
        END IF
    ELSE
        IF NOT Pause THEN
            IF NOT BossFight THEN PlaySong SONG(Level + 2) ELSE PlaySong SONG(2)
        END IF
    END IF
    IF godMode AND UCASE$(k$) = "L" THEN PlaySound SNDFullRecharge: SetLevel Chapter + 1

    'Grab _BUTTON states using custom function GetButton:
    IF Pause = 0 AND Alive = -1 AND Recharge = 0 THEN
        IF GetButton("UP", 0) THEN IF Energy AND y > UpperLimit THEN y = y - 1: Energy = Energy - .001
        IF GetButton("DOWN", 0) THEN IF Energy AND y < LowerLimit THEN y = y + 1: Energy = Energy - .001
        IF GetButton("LEFT", 0) THEN
            IF Energy AND x > LeftLimit THEN x = x - 1: Energy = Energy - .001
            MovingLeft = -1
        ELSE
            MovingLeft = 0
        END IF

        IF GetButton("RIGHT", 0) THEN
            IF Energy AND x < 80 THEN x = x + 1: Energy = Energy - .001
            MovingRight = -1
        ELSE
            MovingRight = 0
        END IF

        IF GetButton("FIRE", 0) THEN GOSUB ShotsFired

        IF GetButton("SPECIAL", 0) AND GetTICKS - LastSpecialUsed# > .3 AND Alive THEN
            SELECT CASE CurrentSpecial
                CASE 0 'Freeze
                    IF totalfreeze > 0 THEN
                        totalfreeze = totalfreeze - 1
                        Freeze = -1
                        FreezeInitiated# = GetTICKS
                        LastSpecialUsed# = GetTICKS
                    END IF
            END SELECT
        END IF

        IF GetButton("SELECT", 0) AND GetTICKS - LastSelect# > .3 AND Alive THEN
            LastSelect# = GetTICKS
        END IF
    END IF

    IF GetButton("START", 0) AND (GetUptime / 1000) - LastPause# > .3 THEN
        Pause = NOT Pause
        IF Pause THEN
            LastPause# = (GetUptime / 1000)
            PauseSong
            _DISPLAYORDER _SOFTWARE , _HARDWARE
        ELSE
            PauseOffset# = PauseOffset# + ((GetUptime / 1000) - LastPause#)
            LastPause# = (GetUptime / 1000)
            IF NOT Mute THEN
                IF NOT BossFight THEN PlaySong SONG(Level + 2) ELSE PlaySong SONG(2)
            END IF
            _DISPLAYORDER _HARDWARE , _SOFTWARE
        END IF
    END IF

    'Display routines:
    CLS , 0
    COLOR , 0
    'Star field ------------------------------------------------------
    IF Recharge THEN
        StarFieldSpeed = StarFieldSpeed - Acceleration
        IF StarFieldSpeed < 0 THEN StarFieldSpeed = 0
        IF Stars = 0 THEN
            PlaySound SNDFullRecharge
            Stars = -1
            'actions
            FOR id = 1 TO MaxStars
                CreateStar id, 0
            NEXT
        END IF
        IF GetTICKS - RechargeTime# > .03 THEN
            RechargeTime# = GetTICKS
            Energy = Energy + 5
            IF InitialSetup THEN x = x + 1
        END IF
        IF Energy >= 100 THEN Recharge = 0: InitialSetup = 0
    ELSE
        IF MovingRight AND NOT Freeze THEN
            StarFieldSpeed = StarFieldSpeed - Acceleration
            IF StarFieldSpeed < 0 THEN StarFieldSpeed = 0
            'EnemiesSpeed = EnemiesSpeed - Acceleration
            'IF EnemiesSpeed < 0 THEN EnemiesSpeed = 0
        ELSEIF NOT Freeze THEN
            StarFieldSpeed = StarFieldSpeed + Acceleration
            IF StarFieldSpeed > BackupStarFieldSpeed THEN StarFieldSpeed = BackupStarFieldSpeed
            'EnemiesSpeed = EnemiesSpeed + Acceleration
            'IF EnemiesSpeed > BackupEnemiesSpeed THEN EnemiesSpeed = BackupEnemiesSpeed
        END IF
    END IF

    IF GetTICKS - move_stars_Last# > StarFieldSpeed AND Pause = 0 AND Alive = -1 AND Energy > 0 AND Freeze = 0 THEN
        move_stars_Last# = GetTICKS
        'move stars in the starfield array
        FOR id = 1 TO MaxStars
            'move individual star
            Starfield(id).X = Starfield(id).X - Starfield(id).RelativeSpeed

            'if the star came out of the left edge, create a new star at the right edge
            IF Starfield(id).X < 1 THEN
                CreateStar id, -1
            END IF
        NEXT

        ''Ship goes back if not intentionally moving forward:
        'IF x > LeftLimit AND MovingRight = 0 AND MovingLeft = 0 THEN x = x - 1
    END IF

    IF GetTICKS - move_enemies_Last# > EnemiesSpeed AND Pause = 0 AND Alive = -1 AND Recharge = 0 AND Freeze = 0 THEN
        move_enemies_Last# = GetTICKS
        'move enemies
        FOR id = 1 TO MaxEnemies
            'move individual enemy
            IF Enemies(id).Hits > 0 THEN
                Enemies(id).X = Enemies(id).X - Enemies(id).RelativeSpeed

                MoveY = CVI(MID$(Enemies(id).MovePattern, (Enemies(id).CurrentMoveStep * 2) - 1, 2))
                IF Enemies(id).Chase AND Enemies(id).X <= x + 25 THEN
                    IF Enemies(id).Y < y / 2 THEN MoveY = _CEIL(RND * 3) ELSE MoveY = -_CEIL(RND * 3)
                END IF
                Enemies(id).CurrentMoveStep = Enemies(id).CurrentMoveStep MOD Enemies(id).MoveSteps + 1
                Enemies(id).Y = Enemies(id).Y + MoveY
                IF MoveY <> 0 AND GameMode = HARD THEN Enemies(id).X = Enemies(id).X - 1

                IF Enemies(id).CanReverse THEN
                    'Enemies that reach a screen boundary will have their
                    'direction reversed
                    IF Enemies(id).Y < 2 THEN Enemies(id).Y = 2: ReverseEnemyPattern id
                    IF Enemies(id).Y + (Enemies(id).Height - 1) > 24 THEN
                        Enemies(id).Y = 24 - (Enemies(id).Height - 1)
                        ReverseEnemyPattern id
                    END IF

                    'Sometimes their direction will be reversed randomly too
                    a% = _CEIL(RND * Enemies(id).MoveSteps)
                    IF a% = Enemies(id).CurrentMoveStep THEN ReverseEnemyPattern id
                END IF

                'if the enemy came out of the screen or was killed,
                'create a new one at the right edge
                IF Enemies(id).X + Enemies(id).Width < 1 OR _
                    Enemies(id).Y + Enemies(id).Height < 2 OR _
                    Enemies(id).Y > 25 THEN
                    Enemies(id).Hits = 0
                    CreateEnemy id, Chapter
                END IF

                IF Enemies(id).CanShoot AND WeKilledFirst THEN
                    'Enemy shoots when aligned (or close to aligning) with hero:
                    '(Enemies only shoot if they've been attacked first)
                    'IF Enemies(id).X > x AND Enemies(id).X <= x + 30 THEN
                    '    IF Enemies(id).Y >= INT(y / 2) - 6 AND Enemies(id).Y <= INT(y / 2) + 6 THEN
                    '        ShootingID = id
                    '        GOSUB EnemyShotsFired
                    '    END IF
                    'END IF

                    'If enemy is visible, make it shoot:
                    IF Enemies(id).IsVisible THEN
                        ShootingID = id
                        GOSUB EnemyShotsFired
                    END IF
                END IF
            END IF
        NEXT
    END IF

    IF GetTICKS - LastEngineEnergy# > 10 THEN
        LastEngineEnergy# = GetTICKS
        Energy = Energy - 0.001
    END IF

    DrawElements

    'Recalculate ship position after move: -----------------------------
    IF (x <> prevX OR y <> prevY) AND Alive = -1 THEN
        prevY = y
        IF prevX < x THEN Smoke = 3 ELSE Smoke = 0
        prevX = x

        row = y / 2
    END IF

    RoundRow = _CEIL(row)
    IF RoundRow <> row THEN
        Char$ = CHR$(223)
    ELSE
        Char$ = CHR$(220)
    END IF

    IF ShotsFired AND Alive THEN
        'Diagonal fire animation - follows the ship
        LaserAnimationStep = LaserAnimationStep + 1
        Laser.X = x: Laser.Y = RoundRow

        IF LaserAnimationStep > LEN(Boom$) THEN
            ShotsFired = 0
            LaserAnimationStep = 0
        ELSE
            j = 1
            x(j) = Laser.X + LaserAnimationStep: y(j) = Laser.Y + LaserAnimationStep: j = j + 1
            x(j) = Laser.X + LaserAnimationStep: y(j) = Laser.Y - LaserAnimationStep: j = j + 1

            'Diagonal fire
            FOR drawIt = 1 TO 2
                Visible = -1
                IF x(drawIt) < 1 OR x(drawIt) > 80 THEN Visible = 0
                IF y(drawIt) < 1 OR y(drawIt) > 25 THEN Visible = 0
                COLOR ShipColor - 8
                IF Visible THEN
                    _PRINTSTRING (x(drawIt), y(drawIt)), MID$(Boom$, LaserAnimationStep, 1)
                    'IF ScreenMap(x(drawIt), y(drawIt)) < 0 THEN
                    '    CheckEnemy = -ScreenMap(x(drawIt), y(drawIt))
                    '    Boom.X = Enemies(CheckEnemy).X
                    '    Boom.Y = Enemies(CheckEnemy).Y * 2
                    '    EnemyExplosion = -1
                    '    ExplosionAnimationStep = 0
                    '    KillEnemy CheckEnemy, ShipSize
                    '    Points = Points + Enemies(CheckEnemy).Points
                    '    PlaySound SNDExplosion
                    'ELSEIF ScreenMap(x(drawIt), y(drawIt)) = ScreenMap.Bonus THEN
                    '    Boom.X = x(drawIt)
                    '    Boom.Y = y(drawIt)
                    '    EnemyExplosion = -1
                    '    ExplosionAnimationStep = 0
                    '    Bonus.Active = 0
                    '    Points = Points + 50
                    '    PlaySound SNDExplosion
                    'END IF
                END IF
            NEXT
        END IF
    END IF

    'Enemies' lasers:
    IF Alive = -1 AND Recharge = 0 AND Pause = 0 AND GameMode = HARD THEN
        FOR i = 1 TO MaxEnemyBeams
            IF GetTICKS - EnemyBeams(i).StartTime < .8 OR Freeze THEN 'Enemy laser beams last for .8 seconds
                l = 0
                FOR l = 0 TO EnemyBeams(i).Size
                    IF EnemyBeams(i).X + l <= 80 THEN
                        IF Enemies(EnemyBeams(i).ID).Color = -1 THEN
                            COLOR _CEIL(RND * 14) + 1
                        ELSEIF Enemies(EnemyBeams(i).ID).Color = -2 THEN 'Custom color pattern
                            COLOR CVI(MID$(Enemies(EnemyBeams(i).ID).ColorPattern, (Enemies(EnemyBeams(i).ID).CurrentColorStep * 2) - 1, 2))
                        ELSE
                            COLOR Enemies(EnemyBeams(i).ID).Color
                        END IF
                        IF GetTICKS - EnemyBeams(i).StartTime > .5 THEN COLOR 1
                        IF EnemyBeams(i).X + l > 0 AND EnemyBeams(i).Y >= 2 AND EnemyBeams(i).Y <= 25 THEN
                            _PRINTSTRING (EnemyBeams(i).X + l, EnemyBeams(i).Y), EnemyBeams(i).Char
                            ScreenMap(EnemyBeams(i).X + l, EnemyBeams(i).Y) = ScreenMap.EnemyLaser + (i / 100)
                        END IF
                    END IF
                NEXT l
                IF NOT Freeze THEN EnemyBeams(i).X = EnemyBeams(i).X - 1
            ELSE
                IF NOT Freeze THEN EnemyBeams(i).X = -EnemyBeams(i).Size 'Invalidate this beam so a new one can be generated
            END IF
        NEXT i
    END IF

    'Front lasers:
    IF Alive = -1 AND Recharge = 0 AND Pause = 0 THEN
        FOR i = 1 TO MaxBeams
            IF GetTICKS - Beams(i).StartTime < .8 THEN 'Laser beams last for .8 seconds
                FOR l = 0 TO Beams(i).Size - 1
                    IF Beams(i).X + l <= 80 THEN
                        COLOR ShipColor - 8
                        IF GetTICKS - Beams(i).StartTime < .2 THEN COLOR 14
                        IF GetTICKS - Beams(i).StartTime < .1 THEN COLOR 15
                        IF GetTICKS - Beams(i).StartTime > .5 THEN COLOR 1
                        _PRINTSTRING (Beams(i).X + l, Beams(i).Y), Beams(i).Char
                        ThisPoint = FIX(ScreenMap(Beams(i).X + l, Beams(i).Y))
                        IF ThisPoint < 0 THEN
                            CheckEnemy = -ScreenMap(Beams(i).X + l, Beams(i).Y)
                            'Killed an enemy
                            Boom.X = Enemies(CheckEnemy).X
                            Boom.Y = Enemies(CheckEnemy).Y * 2
                            EnemyExplosion = -1
                            ExplosionAnimationStep = 0
                            KillEnemy CheckEnemy, ShipSize
                            'This laser beam can't kill another enemy,
                            'so we'll throw it out the screen:
                            Beams(i).X = 81
                            Points = Points + Enemies(CheckEnemy).Points
                            PointGoesUp! = 0: LastEarnedPoints = Enemies(CheckEnemy).Points
                            PlaySound SNDExplosion
                        ELSEIF ThisPoint = ScreenMap.Bonus AND GameMode = HARD THEN
                            Boom.X = Beams(i).X + l
                            Boom.Y = Beams(i).Y * 2
                            EnemyExplosion = -1
                            ExplosionAnimationStep = 0
                            Bonus.Active = 0
                            'This laser beam can't kill another enemy,
                            'so we'll throw it out the screen:
                            Beams(i).X = 81
                            Points = Points + 50
                            PointGoesUp! = 0: LastEarnedPoints = 50
                            PlaySound SNDExplosion
                        ELSEIF ThisPoint = ScreenMap.EnemyLaser THEN
                            ThisEnemyBeam = (ScreenMap(Beams(i).X + l, Beams(i).Y) - ThisPoint) * 100
                            EnemyBeams(ThisEnemyBeam).X = -EnemyBeams(ThisEnemyBeam).Size
                            _DISPLAY
                        END IF
                    END IF
                NEXT l
                Beams(i).X = Beams(i).X + 1
            ELSE
                Beams(i).X = 81 'Invalidate this beam so a new one can be generated
            END IF
        NEXT i
    END IF

    'Draw ship:
    'Ü                              Ü
    ' ßÜÜ    ßÜ               ßÜ    Üß
    '  ÛÛß     ÛÛÜ            ß
    'Üß       Üßß
    '        ß
    IF GetTICKS - LastShipGrow# < 1 THEN
        COLOR _CEIL(RND * 14) + 1
    ELSE
        COLOR ShipColor
    END IF

    IF GetTICKS - LastDamage# < GraceTime THEN
        BlinkShip%% = NOT BlinkShip%%
        IF BlinkShip%% THEN COLOR 0
    END IF

    IF Alive THEN
        IF ShipSize = 1 THEN
            IF _CEIL(row) <> row THEN
                _PRINTSTRING (x - 1, RoundRow - 1), CHR$(220)
                _PRINTSTRING (x - 1, RoundRow), CHR$(220) + CHR$(223)
                ShipMap$ = MKI$(x - 1) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x) + MKI$(RoundRow)
            ELSE
                _PRINTSTRING (x - 1, RoundRow), CHR$(223) + CHR$(220)
                _PRINTSTRING (x - 1, RoundRow + 1), CHR$(223)
                ShipMap$ = MKI$(x - 1) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow + 1)
            END IF
        ELSEIF ShipSize = 2 THEN
            IF _CEIL(row) <> row THEN
                _PRINTSTRING (x - 4, RoundRow - 2), CHR$(220)
                _PRINTSTRING (x - 3, RoundRow - 1), CHR$(223) + CHR$(220) + CHR$(220)
                _PRINTSTRING (x - 2, RoundRow), CHR$(219) + CHR$(219) + CHR$(223)
                _PRINTSTRING (x - 4, RoundRow + 1), CHR$(220) + CHR$(223)
                ShipMap$ = MKI$(x - 4) + MKI$(RoundRow - 2)
                ShipMap$ = ShipMap$ + MKI$(x - 3) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 2) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 2) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x - 4) + MKI$(RoundRow + 1)
                ShipMap$ = ShipMap$ + MKI$(x - 3) + MKI$(RoundRow + 1)
            ELSE
                _PRINTSTRING (x - 4, RoundRow - 1), CHR$(223) + CHR$(220)
                _PRINTSTRING (x - 2, RoundRow), CHR$(219) + CHR$(219) + CHR$(220)
                _PRINTSTRING (x - 3, RoundRow + 1), CHR$(220) + CHR$(223) + CHR$(223)
                _PRINTSTRING (x - 4, RoundRow + 2), CHR$(223)
                ShipMap$ = MKI$(x - 4) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 3) + MKI$(RoundRow - 1)
                ShipMap$ = ShipMap$ + MKI$(x - 2) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x) + MKI$(RoundRow)
                ShipMap$ = ShipMap$ + MKI$(x - 3) + MKI$(RoundRow + 1)
                ShipMap$ = ShipMap$ + MKI$(x - 2) + MKI$(RoundRow + 1)
                ShipMap$ = ShipMap$ + MKI$(x - 1) + MKI$(RoundRow + 1)
                ShipMap$ = ShipMap$ + MKI$(x - 4) + MKI$(RoundRow + 2)

            END IF
        END IF
        IF Bonus.Active THEN
            IF Bonus.Color = -1 THEN
                COLOR _CEIL(RND * 14) + 1
            ELSEIF Bonus.Color = -2 THEN
                COLOR CVI(MID$(Bonus.ColorPattern, (Bonus.CurrentColorStep * 2) - 1, 2))
            ELSE
                COLOR Bonus.Color
            END IF
            _PRINTSTRING (x, RoundRow), Char$
        END IF
    END IF
    COLOR , 0

    'Collision detection (ship)
    IF Alive THEN
        Collision = 0
        StartCheck = 1
        DO
            Ship.X = CVI(MID$(ShipMap$, StartCheck, 2))
            Ship.Y = CVI(MID$(ShipMap$, StartCheck + 2, 2))
            Collision = ScreenMap(Ship.X, Ship.Y)
            IF Collision THEN EXIT DO
            StartCheck = StartCheck + 4
            IF StartCheck > LEN(ShipMap$) THEN EXIT DO
        LOOP

        'Check bonuses
        IF Bonus.Active = -1 AND Collision = ScreenMap.Bonus THEN
            SELECT CASE Bonus.Type$
                CASE "LIFE"
                    Bonus.Active = 0
                    IF ShipSize = 1 THEN
                        PlaySound SNDShipGrow
                        ShipSize = 2: UpperLimit = 6: LowerLimit = 47: LeftLimit = 5
                        Energy = Energy + 5
                        IF y < UpperLimit THEN y = UpperLimit
                        IF y > LowerLimit THEN y = LowerLimit
                        IF x < LeftLimit THEN x = LeftLimit
                        LastShipGrow# = GetTICKS
                    ELSE
                        Lives = Lives + 1
                        PlaySound SNDExtraLife
                    END IF
                CASE "ENERGY"
                    IF Bonus.Color = 10 THEN
                        IF GetTICKS - LastEnergyUP# > .2 THEN
                            LastEnergyUP# = GetTICKS
                            PlaySound SNDEnergyUP
                            Energy = Energy + 5

                            IF Energy >= 100 THEN Bonus.Color = 8
                        END IF
                    END IF
                CASE "SHIELD"
                    PlaySound SNDShieldON
                    ShieldColorIndex = 1
                    Shield = -1
                    ShieldONMessage# = GetTICKS
                    ShieldInitiated# = GetTICKS
                    Bonus.Active = 0
                CASE "FREEZE"
                    IF totalfreeze < 3 THEN
                        PlaySound SNDShieldON
                        totalfreeze = totalfreeze + 1
                        Bonus.Active = 0
                    END IF
            END SELECT
        END IF

        'Check enemies
        IF Collision < 0 AND GetTICKS - LastDamage# > GraceTime THEN
            'Negative value is the hit enemy id, with negative sign
            CheckEnemy = -Collision
            'Death by enemy (or severe damage)
            Points = Points + Enemies(CheckEnemy).Points
            PointGoesUp! = 0: LastEarnedPoints = Enemies(CheckEnemy).Points
            IF ShipSize = 1 THEN
                PlaySound SNDExplosion
                Bonus.Active = 0
                ExplosionAnimationStep = 0
                'Center explosion around collision area:
                Boom.X = Enemies(CheckEnemy).X
                Boom.Y = Enemies(CheckEnemy).Y * 2
                'Enemy dies too:
                KillEnemy CheckEnemy, ShipSize
                IF Shield THEN
                    ShieldOFFMessage# = GetTICKS
                    Shield = 0
                    Damage = -1
                    EnemyExplosion = -1
                ELSE
                    Alive = 0
                    DeathMessage$ = "    BUSTED!!   "
                    EnemyExplosion = 0
                END IF
            ELSE
                PlaySound SNDExplosion
                Boom.X = Enemies(CheckEnemy).X
                Boom.Y = Enemies(CheckEnemy).Y * 2
                ExplosionAnimationStep = 0
                'Enemy dies too:
                KillEnemy CheckEnemy, ShipSize
                IF Shield THEN
                    ShieldOFFMessage# = GetTICKS
                    Shield = 0
                    Damage = -1
                    EnemyExplosion = -1
                ELSE
                    LastLife# = GetTICKS
                    LastDamage# = GetTICKS
                    Damage = -1
                    PlaySound SNDShipDamage
                    IF Bonus.Type$ = "LIFE" THEN Bonus.Color = 4
                    EnemyExplosion = -1
                    CarefulMessage# = GetTICKS
                    ShipSize = 1: UpperLimit = 4: LowerLimit = 49: LeftLimit = 2
                    Energy = Energy / 2
                END IF
            END IF 'Shipsize = 1
        ELSEIF Collision = ScreenMap.EnemyLaser AND GetTICKS - LastDamage# > GraceTime AND Shield = 0 THEN
            'Death by enemy laser (or severe damage)
            IF ShipSize = 1 THEN
                PlaySound SNDExplosion
                Bonus.Active = 0
                ExplosionAnimationStep = 0
                'Center explosion around collision area:
                Boom.X = Enemies(CheckEnemy).X
                Boom.Y = Enemies(CheckEnemy).Y * 2
                Alive = 0
                DeathMessage$ = "    BUSTED!!   "
                EnemyExplosion = 0
            ELSE
                PlaySound SNDExplosion
                Boom.X = Enemies(CheckEnemy).X
                Boom.Y = Enemies(CheckEnemy).Y * 2
                ExplosionAnimationStep = 0
                LastLife# = GetTICKS
                LastDamage# = GetTICKS
                Damage = -1
                PlaySound SNDShipDamage
                IF Bonus.Type$ = "LIFE" THEN Bonus.Color = 4
                EnemyExplosion = -1
                CarefulMessage# = GetTICKS
                ShipSize = 1: UpperLimit = 4: LowerLimit = 49: LeftLimit = 2
                Energy = Energy / 2
            END IF 'Shipsize = 1
        END IF 'Collision < 0
    END IF 'Alive

    'Is a shield active?
    IF Shield THEN
        'Shields last for 30 seconds
        SELECT CASE GetTICKS - ShieldInitiated#
            CASE IS < 20: LastShieldImage = UBOUND(ShieldImages)
            CASE IS < 25: LastShieldImage = UBOUND(ShieldImages) / 2
            CASE IS < 30: LastShieldImage = 3
        END SELECT

        IF (GetUptime / 1000) - LastShieldColor# > .05 THEN
            LastShieldColor# = (GetUptime / 1000)
            ShieldColorIndex = ShieldColorIndex + 1
            IF ShieldColorIndex > LastShieldImage THEN ShieldColorIndex = 1
        END IF
        IF ShipSize = 1 THEN x.offset! = 3.5 ELSE x.offset! = 5
        _PUTIMAGE ((x - x.offset!) * _FONTWIDTH - _FONTWIDTH, (row - 1.3) * _FONTHEIGHT - _FONTHEIGHT), ShieldImages(ShieldColorIndex), 0

        IF GetTICKS - ShieldInitiated# > 30 THEN Shield = 0: PlaySound SNDShieldOFF: ShieldOFFMessage# = GetTICKS
    END IF

    IF Freeze THEN
        'Freeze mode lasts for 10 seconds
        IF GetTICKS - FreezeInitiated# > 10 THEN Freeze = 0: PlaySound SNDBlizzard

        'Or until no more enemies are on screen
        IF VisibleEnemies = 0 THEN Freeze = 0: PlaySound SNDBlizzard
    END IF

    'If moving forward, draw a smoke trail behind the ship
    IF Smoke THEN
        IF ShipSize = 1 THEN x.offset! = 3.5 ELSE x.offset! = 5
        _PUTIMAGE ((x - x.offset!) * _FONTWIDTH - _FONTWIDTH, (row + .3) * _FONTHEIGHT - _FONTHEIGHT), SmokeImages(Smoke), 0
        Smoke = Smoke - 1
        IF Smoke < 1 THEN Smoke = 0
    END IF

    '_TITLE STR$(x) + "," + STR$(y)

    IF GetTICKS - CarefulMessage# < 1.5 THEN
        COLOR 15, 4
        PauseMessage$ = " UNIT DAMAGED! "
        _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, _HEIGHT \ 2), PauseMessage$
    END IF

    IF Pause THEN
        COLOR 15, 1
        PauseMessage$ = "    PAUSED     "
        _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, _HEIGHT \ 2), PauseMessage$

        IF FadeStep = 0 THEN FadeStep = 10
        Fade = Fade + FadeStep
        IF Fade < 100 THEN FadeStep = 10: Fade = 100
        IF Fade > 255 THEN FadeStep = -10: Fade = 255
        IF titlecard& < -1 THEN _FREEIMAGE titlecard&
        RESTORE SpaceshipLogo
        titlecard& = RestoreImage&(_RGBA32(233, 200, 94, Fade))
        _PUTIMAGE (((_WIDTH * _FONTWIDTH) \ 2) - (_WIDTH(titlecard&) \ 2), 100), titlecard&, 0
    END IF

    GOSUB UpdateStats

    'Check energy:
    IF Alive = -1 AND Energy = 0 THEN
        Alive = 0
        EnemyExplosion = 0
        Shield = 0
        DeathMessage$ = " NO MORE ENERGY! "
        PlaySound SNDExplosion
        PlaySound SNDOutOfEnergy
        Bonus.Active = 0
        ExplosionAnimationStep = 0
        Boom.X = x
        Boom.Y = y / 2
    END IF

    IF Alive = 0 OR EnemyExplosion = -1 THEN 'GO BOOM!
        bx = x: by = y: brow! = row
        x = Boom.X: y = Boom.Y: row = y / 2: RoundRow = _CEIL(row)
        'Explosion animation
        ExplosionAnimationStep = ExplosionAnimationStep + 1
        j = 1
        x(j) = x + ExplosionAnimationStep: y(j) = RoundRow + ExplosionAnimationStep: j = j + 1
        x(j) = x + ExplosionAnimationStep: y(j) = RoundRow - ExplosionAnimationStep: j = j + 1
        x(j) = x + ExplosionAnimationStep: y(j) = RoundRow: j = j + 1
        x(j) = x - ExplosionAnimationStep: y(j) = RoundRow - ExplosionAnimationStep: j = j + 1
        x(j) = x - ExplosionAnimationStep: y(j) = RoundRow + ExplosionAnimationStep: j = j + 1
        x(j) = x - ExplosionAnimationStep: y(j) = RoundRow: j = j + 1
        x(j) = x: y(j) = RoundRow - ExplosionAnimationStep: j = j + 1
        x(j) = x: y(j) = RoundRow + ExplosionAnimationStep: j = j + 1

        FOR drawIt = 1 TO 8
            Visible = -1
            IF x(drawIt) < 1 OR x(drawIt) > 80 THEN Visible = 0
            IF y(drawIt) < 1 OR y(drawIt) > 25 THEN Visible = 0
            IF EnemyExplosion OR Damage THEN
                SELECT CASE ExplosionAnimationStep
                    CASE 1 TO 4: COLOR 12: IF Damage THEN _PALETTECOLOR 0, _RGB32(28, 28, 28)
                    CASE 5 TO 8: COLOR 4: IF Damage THEN _PALETTECOLOR 0, _RGBA32(0, 0, 0, 0)
                END SELECT
                IF ExplosionAnimationStep = 8 THEN Damage = 0
            ELSE
                SELECT CASE ExplosionAnimationStep
                    CASE 1 TO 3: COLOR 15: _PALETTECOLOR 0, _RGB32(120, 120, 120)
                    CASE 4 TO 6: COLOR 11: _PALETTECOLOR 0, _RGB32(255, 255, 255)
                    CASE 7 TO 8: COLOR 3: _PALETTECOLOR 0, _RGBA32(0, 0, 0, 0)
                END SELECT
            END IF
            IF Visible THEN
                _PRINTSTRING (x(drawIt), y(drawIt)), MID$(Boom$, ExplosionAnimationStep, 1)
            END IF
        NEXT
        COLOR , 0
        SELECT CASE ExplosionAnimationStep
            CASE 1 TO 4
                COLOR 8
                IF x > 0 AND x <= 80 AND RoundRow > 0 AND RoundRow <= 25 THEN _
                    _PRINTSTRING (x, RoundRow), CHR$(176)
            CASE 5 TO 7
                COLOR 8
                IF x > 0 AND x <= 80 AND RoundRow > 0 AND RoundRow <= 25 THEN _
                    _PRINTSTRING (x, RoundRow), CHR$(15)
            CASE 8
                IF x > 0 AND x <= 80 AND RoundRow > 0 AND RoundRow <= 25 THEN _
                    _PRINTSTRING (x, RoundRow), " "
        END SELECT

        'Show earned points
        PointGoesUp! = PointGoesUp! - .3
        IF RoundRow + PointGoesUp! >= 2 AND RoundRow + PointGoesUp! <= 25 AND x >= 1 AND x <= 77 THEN
            SELECT CASE ABS(INT(PointGoesUp!))
                CASE 1 TO 2: COLOR 15
                CASE 3: COLOR 7
                CASE 4: COLOR 8
            END SELECT
            _PRINTSTRING (x, RoundRow + PointGoesUp!), LTRIM$(RTRIM$(STR$(LastEarnedPoints)))
        END IF

        x = bx: y = by: row = brow!: RoundRow = _CEIL(row)
        IF EnemyExplosion THEN
            IF ExplosionAnimationStep = 8 THEN EnemyExplosion = 0
        ELSE
            COLOR 15, 4
            _PRINTSTRING (_WIDTH \ 2 - LEN(DeathMessage$) \ 2, _HEIGHT \ 2), DeathMessage$
            IF ExplosionAnimationStep = 8 THEN
                Energy = 0
                GOSUB UpdateStats
                _DISPLAY
                StopSong
                _DELAY 1
                Lives = Lives - 1
                LastShipGrow# = GetTICKS
                Alive = -1
                Shield = 0
                Freeze = 0
                Bonus.Active = 0
                ShipSize = 2: UpperLimit = 6: LowerLimit = 47: LeftLimit = 5
                Stars = 0
                Recharge = -1: InitialSetup = -1
                FOR id = 1 TO MaxEnemies
                    Enemies(id).Hits = 0
                    CreateEnemy id, Chapter
                NEXT
                ShowChapterName# = GetTICKS
                PlaySong SONG(Level + 2)
                x = 5
                y = 25
            ELSE
                _DISPLAY
                _DELAY .05
            END IF
        END IF
    END IF

    IF Pause = 0 AND Alive = -1 THEN
        IF GoalAchieved THEN Countdown# = GetTICKS: GoalAchieved = 0
        IF Countdown# > 0 AND GetTICKS - Countdown# > 5 THEN PlaySound SNDFullRecharge: SetLevel Chapter + 1
    END IF

    _DISPLAY
    _LIMIT 30
LOOP UNTIL Lives < 0

IF Lives < 0 THEN
    COLOR 15, 4
    PauseMessage$ = "   GAME OVER   "
    _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, _HEIGHT \ 2), PauseMessage$
END IF

PauseMessage$ = "  Press Start  "
_PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, _HEIGHT \ 2 + 1), PauseMessage$
_DISPLAY

DO
    IF _KEYHIT = 27 THEN SYSTEM
LOOP UNTIL GetButton("START", MyDevices(ChosenController).ID)

GOTO RestartGame

END

ShotsFired:
'Find an empty laser beam slot
FOR NewBeam = 1 TO MaxBeams
    IF Beams(NewBeam).X = 0 OR Beams(NewBeam).X > 80 THEN EXIT FOR
NEXT
IF NewBeam > MaxBeams THEN RETURN 'No available beam slots

'Check for the last beam StartTime so
'we don't fire multiple lasers too quickly:
IF GetTICKS - LastBeam# < .2 THEN RETURN
LastBeam# = GetTICKS

IF ShipSize = 1 THEN Energy = Energy - .5 ELSE Energy = Energy - .8

'Laser sound:
IF ShipSize = 1 THEN PlaySound SNDLaser1 ELSE PlaySound SNDLaser2

ShotsFired = -1
Beams(NewBeam).X = x
Beams(NewBeam).Y = RoundRow
Beams(NewBeam).Size = ShipSize * 2
Beams(NewBeam).StartTime = GetTICKS
Beams(NewBeam).Char = Char$
RETURN

EnemyShotsFired:
'Find an empty laser beam slot
FOR NewBeam = 1 TO MaxEnemyBeams
    IF EnemyBeams(NewBeam).X <= 0 OR GetTICKS - EnemyBeams(NewBeam).StartTime > .8 THEN EXIT FOR
NEXT
IF NewBeam > MaxEnemyBeams THEN RETURN 'No available beam slots

'Check for the last beam StartTime so
'we don't fire multiple lasers too quickly:
IF GetTICKS - LastEnemyBeam# < .5 THEN RETURN
LastEnemyBeam# = GetTICKS

EnemyBeams(NewBeam).ID = ShootingID
EnemyBeams(NewBeam).X = Enemies(ShootingID).X
EnemyBeams(NewBeam).Y = Enemies(ShootingID).Y
EnemyBeams(NewBeam).Size = 2
EnemyBeams(NewBeam).StartTime = GetTICKS
EnemyBeams(NewBeam).Char = CHR$(220)
RETURN

UpdateStats:
COLOR , 1
_PRINTSTRING (1, 1), STRING$(80, 32)
COLOR ShipColor
_PRINTSTRING (2, 1), CHR$(220) + CHR$(223) + CHR$(220)
COLOR 15
IF Lives >= 0 THEN _PRINTSTRING (6, 1), "x" + STR$(Lives) ELSE _PRINTSTRING (6, 1), "x 0"
_PRINTSTRING (12, 1), STR$(Points)
IF Energy > 100 THEN Energy = 100
IF INT(Energy) <= 0 THEN Energy = 0
IF Mute THEN COLOR 0, 7: _PRINTSTRING (20, 1), " MUTE ": COLOR , 1

IF totalfreeze > 0 THEN
    COLOR 11
    _PRINTSTRING (65, 1), STRING$(totalfreeze, 15)
END IF

COLOR 15
TimeRemaining# = GetTICKS - Countdown#
IF Countdown# > 0 AND TimeRemaining# > 0 AND TimeRemaining# <= 5 THEN
    _PRINTSTRING (60, 25), " NEXT MISSION IN" + STR$(INT(5 - TimeRemaining#)) + " "
ELSE
    IF GetTICKS - ShowChapterName# < 2 THEN
        COLOR 15, 1
        PauseMessage$ = " Chapter" + STR$(Chapter) + " "
        _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, _HEIGHT \ 2 - 1), PauseMessage$
        Pipe = INSTR(ChapterName$, "|")
        IF Pipe = 0 THEN
            _PRINTSTRING (_WIDTH \ 2 - LEN(ChapterName$) \ 2, _HEIGHT \ 2), ChapterName$
        ELSE
            SecondLine$ = LEFT$(ChapterName$, Pipe - 1) + " "
            ThirdLine$ = " " + MID$(ChapterName$, Pipe + 1)
            _PRINTSTRING (_WIDTH \ 2 - LEN(SecondLine$) \ 2, _HEIGHT \ 2), SecondLine$
            _PRINTSTRING (_WIDTH \ 2 - LEN(ThirdLine$) \ 2, _HEIGHT \ 2 + 1), ThirdLine$
        END IF
    ELSE
        IF GetTICKS - LastTipUpdate# > 15 THEN
            LastTipUpdate# = GetTICKS
            LastTipShown# = GetTICKS
            IF ChapterTips.Position > 0 THEN
                Start.Position = ChapterTips.Position + 1
                ChapterTips.Position = INSTR(Start.Position, ChapterTips$, CHR$(0))
                IF ChapterTips.Position > 0 THEN
                    NextTip$ = MID$(ChapterTips$, Start.Position, ChapterTips.Position - Start.Position)
                ELSE
                    NextTip$ = MID$(ChapterTips$, Start.Position)
                END IF
                PlaySound SNDIntercom
            ELSE
                NextTip$ = ""
            END IF
        END IF

        IF GetTICKS - LastTipShown# < 5 THEN
            IF LEN(NextTip$) THEN
                ThirdLine$ = ""
                Colon = INSTR(NextTip$, ":")
                Pipe = INSTR(NextTip$, "|")
                IF Pipe THEN
                    SecondLine$ = MID$(NextTip$, Colon + 1, Pipe - Colon - 1)
                    ThirdLine$ = MID$(NextTip$, Pipe + 1)
                ELSE
                    SecondLine$ = MID$(NextTip$, Colon + 1)
                END IF
                COLOR 15, 1
                _PRINTSTRING (1, 22), " " + LEFT$(NextTip$, Colon) + " "
                _PRINTSTRING (1, 23), " " + SecondLine$ + " "
                IF Pipe THEN
                    _PRINTSTRING (1, 24), " " + ThirdLine$ + " "
                END IF
            END IF
        END IF
    END IF

    IF Freeze AND Alive THEN
        FreezeLeft = 10 - (GetTICKS - FreezeInitiated#)
        COLOR 9, 0
        IF FreezeLeft <= 3 THEN COLOR 9 + 16
        _PRINTSTRING (2, 3), STRING$(FreezeLeft, 219) + STRING$(10 - FreezeLeft, 220)
        COLOR 11
        IF FreezeLeft <= 3 THEN COLOR 11 + 16
        _PRINTSTRING (2, 4), "TIME FREEZE"
    END IF
END IF

IF GetTICKS - ShieldONMessage# < 1 THEN
    COLOR 0, 7
    PauseMessage$ = " SHIELD ENGAGED "
    _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, 1), PauseMessage$
END IF

IF GetTICKS - ShieldOFFMessage# < 1 THEN
    COLOR 0, 7
    IF GetTICKS - ShieldInitiated# > 20 THEN PauseMessage$ = " SHIELD RELEASED " ELSE PauseMessage$ = " SHIELD DESTROYED "
    _PRINTSTRING (_WIDTH \ 2 - LEN(PauseMessage$) \ 2, 1), PauseMessage$
END IF

COLOR , 1

IF Energy <= 10 AND Alive = -1 AND Recharge = 0 THEN
    COLOR 15, 4
    IF GetTICKS - EnergyWarning# > 1 THEN
        EnergyWarning# = GetTICKS
        EnergyWarningText = NOT EnergyWarningText
        IF EnergyWarningText THEN
            WarningMessage$ = " LOW RESOURCES "
        ELSE
            WarningMessage$ = "    DANGER!    "
        END IF
    END IF
    _PRINTSTRING (_WIDTH \ 2 - LEN(WarningMessage$) \ 2, 1), WarningMessage$
END IF

EnergyStat$ = STRING$(Energy / 10, 254)
EnergyStat$ = EnergyStat$ + STRING$(10 - LEN(EnergyStat$), 249)
SELECT CASE Energy
    CASE 0 TO 10: COLOR 28, 1
    CASE 11 TO 30: COLOR 12, 1
    CASE 31 TO 60: COLOR 14, 1
    CASE 61 TO 100: COLOR 10, 1
END SELECT
IF GetTICKS - LastEnergyUP# <= .2 THEN
    IF EnergyBlinkColor = 10 THEN EnergyBlinkColor = 9 ELSE EnergyBlinkColor = 10
    COLOR EnergyBlinkColor
END IF
_PRINTSTRING (70, 1), EnergyStat$

IF KilledEnemies < ChapterGoal THEN
    '_PRINTSTRING (30, 1), STR$(KilledEnemies) + "/" + STR$(ChapterGoal)
    'EnemiesLeft$ = STRING$((KilledEnemies / ChapterGoal) * 80, 219)
    'COLOR 4
    '_PRINTSTRING (1, 25), EnemiesLeft$
    _PUTIMAGE (0, 24 * _FONTHEIGHT), LifeBarImage, 0, (0, 0)-STEP((KilledEnemies / ChapterGoal) * (80 * _FONTWIDTH), _FONTHEIGHT)
    HideLifeBar! = 0
ELSE
    IF HideLifeBar! < _FONTHEIGHT THEN
        HideLifeBar! = HideLifeBar! + .3
        _PUTIMAGE (0, 24 * _FONTHEIGHT + HideLifeBar!), LifeBarImage, 0
    END IF
END IF

COLOR , 0
RETURN

FileError:
RESUME NEXT

'Images: ---------------------------------------------------------------------------
SpaceshipLogo:
DATA 313,56,15B,34W,188B,5W,32B,6W,33B,*
DATA 13B,37W,185B,8W,30B,8W,32B,*
DATA 11B,39W,185B,8W,30B,8W,32B,*
DATA 11B,40W,183B,9W,29B,9W,32B,*
DATA 10B,41W,183B,9W,29B,9W,32B,*
DATA 9B,42W,183B,9W,29B,9W,32B,*
DATA 9B,42W,182B,9W,30B,8W,33B,*
DATA 8B,43W,182B,9W,30B,8W,33B,*
DATA 8B,42W,183B,9W,30B,7W,34B,*
DATA 8B,42W,183B,9W,31B,4W,36B,*
DATA 7B,10W,24B,9W,182B,9W,72B,*
DATA 7B,9W,25B,9W,3B,26W,11B,23W,14B,26W,13B,20W,14B,28W,4B,26W,15B,3W,6B,26W,5B,*
DATA 7B,9W,25B,8W,4B,28W,8B,26W,9B,31W,8B,25W,9B,32W,3B,28W,11B,7W,4B,28W,3B,*
DATA 7B,8W,26B,8W,3B,30W,6B,28W,7B,33W,6B,27W,7B,33W,3B,29W,9B,8W,3B,30W,2B,*
DATA 6B,9W,26B,7W,4B,31W,4B,29W,6B,34W,5B,28W,6B,34W,2B,31W,7B,9W,3B,31W,1B,*
DATA 6B,9W,28B,2W,7B,31W,4B,30W,5B,35W,4B,28W,5B,35W,2B,31W,7B,9W,3B,31W,1B,*
DATA 6B,9W,37B,32W,3B,30W,4B,36W,3B,30W,3B,36W,2B,32W,6B,9W,3B,32W,*
DATA 5B,37W,9B,33W,3B,30W,4B,36W,3B,30W,3B,36W,1B,33W,5B,9W,3B,33W,*
DATA 5B,39W,7B,33W,3B,29W,4B,36W,3B,30W,3B,36W,2B,33W,5B,9W,3B,33W,*
DATA 5B,40W,6B,33W,3B,29W,4B,36W,3B,30W,3B,36W,2B,33W,5B,9W,3B,33W,*
DATA 5B,40W,6B,33W,3B,29W,4B,36W,3B,30W,3B,34W,4B,33W,5B,9W,3B,33W,*
DATA 5B,41W,4B,9W,15B,10W,22B,10W,3B,10W,18B,9W,2B,10W,12B,9W,2B,9W,29B,9W,15B,10W,4B,9W,3B,9W,15B,10W,*
DATA 5B,41W,4B,9W,15B,9W,23B,9W,4B,9W,19B,9W,2B,9W,12B,9W,3B,9W,29B,9W,15B,9W,5B,9W,3B,9W,15B,9W,1B,*
DATA 6B,40W,4B,9W,15B,9W,5B,27W,4B,9W,19B,8W,3B,30W,3B,32W,6B,9W,15B,9W,5B,9W,3B,9W,15B,9W,1B,*
DATA 6B,40W,4B,9W,15B,9W,4B,28W,4B,9W,19B,7W,4B,30W,3B,33W,5B,9W,15B,9W,5B,9W,3B,9W,15B,9W,1B,*
DATA 7B,39W,3B,9W,16B,9W,3B,29W,3B,9W,21B,5W,4B,31W,3B,34W,3B,9W,16B,9W,4B,9W,3B,9W,16B,9W,1B,*
DATA 9B,37W,3B,9W,15B,9W,3B,29W,4B,9W,30B,30W,4B,34W,3B,9W,15B,9W,5B,9W,3B,9W,15B,9W,2B,*
DATA 36B,9W,4B,9W,15B,9W,2B,30W,4B,9W,30B,30W,4B,34W,3B,9W,15B,9W,5B,9W,3B,9W,15B,9W,2B,*
DATA 6B,2W,28B,9W,3B,9W,16B,9W,2B,30W,3B,9W,30B,30W,5B,34W,2B,9W,16B,9W,4B,9W,3B,9W,16B,9W,2B,*
DATA 3B,7W,26B,9W,3B,9W,16B,9W,1B,31W,3B,9W,22B,2W,6B,30W,5B,34W,2B,9W,16B,9W,4B,9W,3B,9W,16B,9W,2B,*
DATA 2B,8W,26B,9W,3B,9W,15B,9W,2B,30W,4B,9W,19B,7W,4B,29W,7B,33W,2B,9W,15B,9W,5B,9W,3B,9W,15B,9W,3B,*
DATA 2B,8W,25B,9W,4B,9W,15B,9W,2B,30W,4B,9W,19B,7W,4B,27W,10B,32W,2B,9W,15B,9W,5B,9W,3B,9W,15B,9W,3B,*
DATA 1B,9W,25B,9W,3B,9W,16B,9W,1B,31W,3B,9W,19B,9W,2B,26W,15B,29W,1B,9W,16B,9W,4B,9W,3B,9W,16B,9W,3B,*
DATA 1B,9W,24B,10W,3B,9W,15B,9W,2B,9W,13B,8W,4B,9W,19B,8W,3B,9W,52B,9W,1B,9W,16B,9W,4B,9W,3B,9W,15B,9W,4B,*
DATA 1B,42W,4B,33W,2B,30W,4B,36W,3B,28W,7B,34W,2B,9W,15B,9W,5B,9W,3B,33W,4B,*
DATA 1B,42W,4B,33W,2B,30W,4B,36W,3B,29W,4B,36W,2B,9W,15B,9W,5B,9W,3B,33W,4B,*
DATA 43W,3B,33W,2B,31W,3B,37W,2B,30W,4B,36W,1B,9W,16B,9W,4B,9W,3B,33W,5B,*
DATA 42W,4B,33W,2B,30W,4B,36W,3B,30W,3B,36W,2B,9W,16B,8W,5B,9W,3B,33W,5B,*
DATA 42W,4B,32W,3B,30W,4B,36W,3B,30W,3B,36W,2B,9W,15B,9W,5B,9W,3B,32W,6B,*
DATA 41W,5B,31W,4B,30W,4B,36W,3B,30W,3B,35W,3B,9W,15B,9W,5B,9W,3B,31W,7B,*
DATA 40W,5B,32W,4B,30W,4B,35W,4B,30W,2B,35W,3B,9W,16B,9W,4B,9W,3B,32W,7B,*
DATA 1B,38W,6B,31W,6B,28W,6B,33W,6B,28W,3B,34W,4B,9W,16B,8W,5B,9W,3B,31W,8B,*
DATA 1B,37W,7B,29W,8B,28W,6B,32W,7B,27W,5B,32W,6B,7W,17B,8W,6B,7W,4B,29W,10B,*
DATA 2B,34W,8B,28W,11B,27W,7B,29W,10B,25W,6B,30W,8B,6W,19B,5W,8B,6W,4B,28W,12B,*
DATA 44B,9W,220B,9W,31B,*
DATA 44B,9W,220B,9W,31B,*
DATA 44B,9W,220B,9W,31B,*
DATA 43B,9W,220B,9W,32B,*
DATA 43B,9W,220B,9W,32B,*
DATA 43B,9W,220B,9W,32B,*
DATA 43B,9W,220B,9W,32B,*
DATA 42B,9W,220B,9W,33B,*
DATA 42B,9W,220B,9W,33B,*
DATA 42B,8W,221B,8W,34B,*
DATA 43B,6W,223B,6W,35B,*
DATA 44B,3W,226B,3W,37B,*

FUNCTION GetButton (Name$, DeviceID AS INTEGER)
    DIM i AS INTEGER
    STATIC LastDevice AS INTEGER

    'Initialize SHARED variables used for return codes
    GetButton.NotFound = 0
    GetButton.Found = -1
    GetButton.Multiple = -2

    'DeviceID must always be passed in case there are multiple
    'devices to query; If only one, 0 can be passed in subsequent
    'calls to this function.
    IF DeviceID THEN
        LastDevice = DeviceID
    ELSE
        IF LastDevice = 0 THEN ERROR 5
    END IF

    IF UseKeyboard = 0 THEN
        'Read the device's buffer:
        DO WHILE _DEVICEINPUT(LastDevice): LOOP

        IF LEN(Name$) THEN
            'If button Name$ is passed, we look for that specific ID.
            'If pressed, we return -1
            FOR i = 1 TO UBOUND(ButtonMap)
                IF UCASE$(RTRIM$(ButtonMap(i).Name)) = UCASE$(Name$) THEN
                    'Found the requested button's ID.
                    'Time to query the controller:
                    GetButton = _BUTTON(ButtonMap(i).ID) 'Return result maps to .NotFound = 0 or .Found = -1
                    EXIT FUNCTION
                END IF
            NEXT i
        ELSE
            'Otherwise we return every button whose state is -1
            'Return is passed by changing Name$ and GetButton then returns -2
            FOR i = 1 TO _LASTBUTTON(LastDevice)
                IF _BUTTON(i) THEN Name$ = Name$ + MKI$(i)
            NEXT i
            IF LEN(Name$) = 0 THEN EXIT FUNCTION
            IF LEN(Name$) = 2 THEN GetButton = GetButton.Found ELSE GetButton = GetButton.Multiple
        END IF
    ELSE
        IF LEN(Name$) THEN
            'If button Name$ is passed, we look for that specific ID.
            'If pressed, we return -1
            FOR i = 1 TO UBOUND(ButtonMap)
                IF UCASE$(RTRIM$(ButtonMap(i).Name)) = UCASE$(Name$) THEN
                    'Found the requested button's ID.
                    'Time to query the controller:
                    GetButton = _KEYDOWN(ButtonMap(i).ID) 'Return result maps to .NotFound = 0 or .Found = -1
                    EXIT FUNCTION
                END IF
            NEXT i
        END IF
    END IF
END FUNCTION

SUB CreateStar (id, create_at_edge)
    IF create_at_edge THEN
        'will create star at right edge, create values based on that
        Starfield(id).X = 80
    ELSE
        'will create stars scattered to fill the first frame, create values based on that
        Starfield(id).X = INT(RND * 80 + 1)
    END IF
    Starfield(id).Y = INT(RND * 24 + 1) + 1
    'speed in pixels per frame, will be used later to have layers of stars that appear to move at different speeds.
    Starfield(id).RelativeSpeed = INT(RND * 3 + 1)

    SELECT CASE Starfield(id).RelativeSpeed
        CASE 1: Starfield(id).Color = 8: Starfield(id).Char = CHR$(250)
        CASE 2: Starfield(id).Color = 8: Starfield(id).Char = CHR$(249)
        CASE 3: Starfield(id).Color = 7: Starfield(id).Char = CHR$(249)
    END SELECT
END SUB

SUB CreateBonus
    DIM B%
    SHARED ShipSize AS _BYTE, Shield AS _BYTE, SNDShieldAPPEAR, Recharge AS _BYTE
    SHARED Freeze, SNDBlizzard
    SHARED LastLife#, LastEnergy#, LastShield#, LastFreeze#
    SHARED totalfreeze

    IF Recharge THEN EXIT SUB

    B% = _CEIL(RND * 4)
    SELECT CASE B%
        CASE 1 'Life
            IF (GetTICKS - LastLife# > 60 AND ShipSize = 2) OR _
               (GetTICKS - LastLife# > 15 AND ShipSize = 1) THEN
                LastLife# = GetTICKS
                Bonus.Type$ = "LIFE"
                Bonus.Active = -1
                IF ShipSize = 1 THEN Bonus.Color = 4 ELSE Bonus.Color = 2
                Bonus.X = 80
                Bonus.Height = 3
                Bonus.Width = 7
                Bonus.Shape$ = CHR$(220) + CHR$(219) + CHR$(219) + CHR$(220) + CHR$(219) + CHR$(219) + CHR$(220) + CHR$(223) + CHR$(219) + CHR$(219) + CHR$(219) + CHR$(219) + CHR$(219) + CHR$(223) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(219) + CHR$(223) + CHR$(32) + CHR$(32)
                Bonus.Y = _CEIL(RND * (24 - Bonus.Height)) + 1
                Bonus.Speed# = .2
            END IF
        CASE 2 'Energy
            IF GetTICKS - LastEnergy# > 20 OR Energy < 10 THEN
                LastEnergy# = GetTICKS
                Bonus.Type$ = "ENERGY"
                Bonus.Active = -1
                Bonus.X = 80
                Bonus.Color = 10
                Bonus.Height = 3
                Bonus.Width = 10
                'Bonus.Shape$ = CHR$(218) + STRING$(4, 196) + CHR$(191) + " "
                'Bonus.Shape$ = Bonus.Shape$ + CHR$(179) + STRING$(4, 254) + CHR$(198) + CHR$(240)
                'Bonus.Shape$ = Bonus.Shape$ + CHR$(192) + STRING$(4, 196) + CHR$(217)
                Bonus.Shape$ = CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(219) + CHR$(254) + CHR$(254) + CHR$(254) + CHR$(254) + CHR$(254) + CHR$(254) + CHR$(254) + CHR$(219) + CHR$(8) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32)
                Bonus.Y = _CEIL(RND * (24 - Bonus.Height)) + 1
                Bonus.Speed# = .05
            END IF
        CASE 3 'Shield
            IF GetTICKS - LastShield# > 120 AND Shield = 0 THEN
                PlaySound SNDShieldAPPEAR
                LastShield# = GetTICKS
                Bonus.Type$ = "SHIELD"
                Bonus.Active = -1
                Bonus.X = 80
                Bonus.Color = -1 'Makes it random
                Bonus.Height = 4
                Bonus.Width = 7
                Bonus.Shape$ = STRING$(7, 176)
                Bonus.Shape$ = Bonus.Shape$ + CHR$(176) + "     " + CHR$(176)
                Bonus.Shape$ = Bonus.Shape$ + CHR$(176) + "     " + CHR$(176)
                Bonus.Shape$ = Bonus.Shape$ + STRING$(7, 176)
                Bonus.Y = _CEIL(RND * (24 - Bonus.Height)) + 1
                Bonus.Speed# = .08
            END IF
        CASE 4 'Freeze power
            IF GetTICKS - LastFreeze# > 90 AND Freeze = 0 AND totalfreeze < 3 THEN
                PlaySound SNDBlizzard
                LastFreeze# = GetTICKS
                Bonus.Type$ = "FREEZE"
                Bonus.Active = -1
                Bonus.X = 80
                Bonus.Color = -2 'Custom colors
                m$ = MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(3) + MKI$(9) + MKI$(3) + MKI$(9) + MKI$(3)
                Bonus.ColorPattern = m$
                Bonus.ColorSteps = LEN(m$) / 2
                Bonus.CurrentColorStep = 1
                Bonus.Height = 7
                Bonus.Width = 11
                Bonus.Shape$ = CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(4) + CHR$(249) + CHR$(92) + CHR$(32) + CHR$(31) + CHR$(32) + CHR$(47) + CHR$(249) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(196) + CHR$(16) + CHR$(15) + CHR$(17) + CHR$(196) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(249) + CHR$(47) + CHR$(32) + CHR$(30) + CHR$(32) + CHR$(92) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(32) + CHR$(4) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(9) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32)
                Bonus.Y = _CEIL(RND * (24 - Bonus.Height)) + 1
                Bonus.Speed# = .08
            END IF
    END SELECT
END SUB

SUB ReverseEnemyPattern (id)
    FOR i = 1 TO Enemies(id).MoveSteps
        MoveY = CVI(MID$(Enemies(id).MovePattern, (i * 2) - 1, 2))
        MID$(Enemies(id).MovePattern, (i * 2) - 1, 2) = MKI$(-MoveY)
    NEXT i
END SUB

SUB MakeEnemyEscape (id)
    'Some will go up, some will go down.
    IF Enemies(id).Y > 12 THEN
        m$ = MKI$(-1)
    ELSE
        m$ = MKI$(1)
    END IF
    Enemies(id).CanReverse = 0
    Enemies(id).MovePattern = m$
    Enemies(id).MoveSteps = LEN(m$) / 2
    Enemies(id).CurrentMoveStep = 1
    Enemies(id).CanShoot = 0
END SUB

SUB CreateEnemy (id, Chapter)
    SHARED Energy AS SINGLE, RoundRow AS INTEGER

    DIM a AS _BYTE
    IF Bonus.Active = 0 THEN CreateBonus
    SELECT CASE Chapter
        CASE 1
            IF Enemies(id).Hits <= 0 THEN
                Enemies(id).X = 80 + _CEIL(RND * 80)
                Enemies(id).Y = _CEIL(RND * 24) + 1
                Enemies(id).Color = 12
                Enemies(id).Points = 50
                Enemies(id).RelativeSpeed = 1 'INT(RND * 2 + 1)
                Enemies(id).Hits = 2
                RESTORE EnemyShip1
                GOSUB LoadShape
                Enemies(id).CurrentShape = _CEIL(RND * 2)
                'Some will go up, some will go down.
                IF Enemies(id).Y > 12 THEN
                    m$ = MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1)
                ELSE
                    m$ = MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(1) + MKI$(1) + MKI$(1) + MKI$(1)
                END IF
                Enemies(id).MovePattern = m$
                Enemies(id).CanReverse = -1
                Enemies(id).Chase = 0
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = -1
            ELSE
                'Enemy not yet killed, so we'll turn it into its second form
                Enemies(id).Color = 4
                Enemies(id).Points = 25
                Enemies(id).RelativeSpeed = 2 'INT(RND * 2 + 1)
                Enemies(id).Shape = CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(222) + CHR$(219) + CHR$(176) + CHR$(221) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32)
                Enemies(id).TotalShapes = 1
                Enemies(id).CurrentShape = 1
                Enemies(id).Width = 5
                Enemies(id).Height = 3
                'Some will go up, some will go down.
                IF Enemies(id).Y > 12 THEN
                    m$ = MKI$(-1)
                ELSE
                    m$ = MKI$(1)
                END IF
                Enemies(id).CanReverse = 0
                Enemies(id).MovePattern = m$
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = 0
            END IF
        CASE 2
            IF Enemies(id).Hits <= 0 THEN
                Enemies(id).X = 80 + _CEIL(RND * 80)
                Enemies(id).Y = _CEIL(RND * 24) + 1
                Enemies(id).Color = -2
                DO
                    RandomColor = _CEIL(RND * 8) + 7
                LOOP WHILE RandomColor = ShipColor OR RandomColor = 8
                m$ = MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(8) + MKI$(8) + MKI$(8) + MKI$(8) + MKI$(8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8) + MKI$(RandomColor - 8)
                Enemies(id).ColorPattern = m$
                Enemies(id).ColorSteps = LEN(m$) / 2
                Enemies(id).CurrentColorStep = 1
                Enemies(id).Points = 100
                Enemies(id).RelativeSpeed = _CEIL(RND * 2)
                Enemies(id).Hits = 2
                ThisDesign$ = CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(222) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(221) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32)
                ThisDesign$ = ThisDesign$ + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(222) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(8) + CHR$(219) + CHR$(221) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32) + CHR$(32) + CHR$(32) + CHR$(32)
                Enemies(id).Shape = ThisDesign$
                Enemies(id).TotalShapes = 2
                Enemies(id).CurrentShape = _CEIL(RND * 2)
                Enemies(id).Width = 15
                Enemies(id).Height = 5
                IF Enemies(id).Y > 12 THEN
                    m$ = MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(-1)
                ELSE
                    m$ = MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(1)
                END IF
                Enemies(id).MovePattern = m$
                Enemies(id).CanReverse = -1
                Enemies(id).Chase = 0
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = -1
            ELSE
                'Enemy not yet killed, will try to run away wounded
                Enemies(id).Color = 8
                Enemies(id).Points = 50
                Enemies(id).RelativeSpeed = 3 'INT(RND * 2 + 1)
                'Some will go up, some will go down.
                IF Enemies(id).Y > 12 THEN
                    m$ = MKI$(-1)
                ELSE
                    m$ = MKI$(1)
                END IF
                Enemies(id).CanReverse = 0
                Enemies(id).MovePattern = m$
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = 0
            END IF
        CASE 3
            IF Enemies(id).Hits <= 0 THEN
                Enemies(id).X = 80 + _CEIL(RND * 20)
                Enemies(id).Y = _CEIL(RND * 24) + 1
                Enemies(id).Color = 5
                Enemies(id).Hits = 1
                Enemies(id).Points = 50
                Enemies(id).RelativeSpeed = 1
                Enemies(id).Shape = CHR$(32) + CHR$(220) + CHR$(220) + CHR$(220) + CHR$(32) + CHR$(222) + CHR$(219) + CHR$(176) + CHR$(221) + CHR$(32) + CHR$(32) + CHR$(223) + CHR$(223) + CHR$(223) + CHR$(32)
                Enemies(id).TotalShapes = 1
                Enemies(id).CurrentShape = 1
                Enemies(id).Width = 5
                Enemies(id).Height = 3
                'Some will go up, some will go down.
                IF Enemies(id).Y > 12 THEN
                    m$ = MKI$(0) + MKI$(0) + MKI$(-1)
                ELSE
                    m$ = MKI$(0) + MKI$(0) + MKI$(1)
                END IF
                Enemies(id).Chase = -1
                Enemies(id).CanReverse = -1
                Enemies(id).MovePattern = m$
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = 0
            END IF
        CASE 4
            IF Enemies(id).Hits <= 0 THEN
                Enemies(id).X = 80 + _CEIL(RND * 80)
                Enemies(id).Y = _CEIL(RND * 24) + 1
                Enemies(id).Color = -2
                m$ = MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(9) + MKI$(3) + MKI$(9) + MKI$(3) + MKI$(9) + MKI$(3)
                Enemies(id).ColorPattern = m$
                Enemies(id).ColorSteps = LEN(m$) / 2
                Enemies(id).CurrentColorStep = 1
                Enemies(id).Hits = 100
                Enemies(id).Points = 50
                Enemies(id).RelativeSpeed = 1
                Enemies(id).CurrentShape = 1 '_CEIL(RND * 2)
                RESTORE SpaceAmoeba
                GOSUB LoadShape:
                'Some will go up, some will go down.
                m$ = MKI$(0) + MKI$(0) + MKI$(0) + MKI$(0) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1) + MKI$(-1)
                Enemies(id).Chase = 0
                Enemies(id).CanReverse = -1
                Enemies(id).MovePattern = m$
                IF Enemies(id).Y <= 12 THEN
                    ReverseEnemyPattern id
                END IF
                Enemies(id).MoveSteps = LEN(m$) / 2
                Enemies(id).CurrentMoveStep = _CEIL(RND * Enemies(id).MoveSteps)
                Enemies(id).CanShoot = -1
            END IF
    END SELECT

    EXIT SUB
    LoadShape:
    READ Enemies(id).Width, Enemies(id).Height, Enemies(id).TotalShapes
    FOR i = 1 TO (Enemies(id).Width * Enemies(id).Height * Enemies(id).TotalShapes)
        READ ThisChar
        ASC(Enemies(id).Shape, i) = ThisChar
    NEXT
    RETURN

    EnemyShip1:
    DATA 5,3,2,32,32,220,220,220,222,219,178,177,221,32,32,223,223,223,32,32,220,220,220,222,219,176,176,221,32,32,223,223,223

    SpaceAmoeba:
    DATA 32,14,8
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,223,223,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,223,223,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,223,223,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,220,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,223,223,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,32,32,220,220,220,176,176,176,176,176,176,220,220,220,32,32,220,220,32,32,32,32,32,32,32,32,32,32,32,222,176,176,220,220,176,176,176,176,176,176,176,176,176,176,176,176,220,220,176,176,222,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,222,176,176,176,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,223,176,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,223,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,223,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,223,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,223,223,223,223,176,176,176,176,176,176,223,223,176,176,176,176,176,176,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,32,32,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,4,4,4,4,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,32,32,4,4,4,176,176,176,176,176,176,4,4,4,32,32,4,4,32,32,32,32,32,32,32,32,32,32,32,4,176,176,4,4,176,176,176,176,176,176,176,176,176,176,176,176,4,4,176,176,4,32,32,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,32,4,4,4,4,176,176,176,176,176,176,4,4,176,176,176,176,176,176,4,4,4,4,32,32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,4,4,4,4,32,32,4,4,4,4,4,4,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,220,220,220,220,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,220,220,32,32,220,220,220,176,176,176,176,176,176,220,220,220,32,32,220,220,32,32,32,32,32,32,32,32,32,32,32,222,176,176,220,220,176,176,176,176,176,176,176,176,176,176,176,176,220,220,176,176,222,32,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,222,176,176,176,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,223,176,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,223,32,32,32,32,32,32,32,32,220,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,220,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,223,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,223,32,32,32,32,32,32,32,32,222,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,222,32,32,32,32,32,32,32,32,32,223,223,223,223,176,176,176,176,176,176,223,223,176,176,176,176,176,176,223,223,223,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,223,223,223,223,223,32,32,223,223,223,223,223,223,32,32,32,32,32,32,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,4,4,4,4,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,32,32,4,4,4,176,176,176,176,176,176,4,4,4,32,32,4,4,32,32,32,32,32,32,32,32,32,32,32,4,176,176,4,4,176,176,176,176,176,176,176,176,176,176,176,176,4,4,176,176,4,32,32,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,251,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,251,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,8,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,4,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,176,4,32,32,32,32,32,32,32,32,32,4,4,4,4,176,176,176,176,176,176,4,4,176,176,176,176,176,176,4,4,4,4,32,32,32,32,32,32,32,32,32,32,32,32,32,32,4,4,4,4,4,4,32,32,4,4,4,4,4,4,32,32,32,32,32,32,32,32,32

    Cockroach:
    DATA 28,14,4
    DATA 32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,220,220,220,220,220,220,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,220,176,176,176,176,176,176,220,32,178,32,32,32,32,32,32,32,32,178,178,178,178,32,32,32,32,178,220,176,176,178,176,176,178,176,176,220,178,32,32,32,32,178,178,178,178,32,32,32,32,178,178,178,32,220,176,176,178,176,176,176,176,178,176,176,220,32,178,178,178,32,32,32,32,32,32,32,32,32,32,32,178,176,176,178,176,176,176,176,176,176,178,176,176,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,176,176,176,178,176,176,176,176,178,176,176,176,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,176,176,176,178,176,176,178,176,176,176,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,223,176,178,176,176,176,176,178,176,223,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,223,176,178,176,176,178,176,223,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,178,32,32,32,223,223,223,223,223,223,32,32,32,178,32,32,32,32,178,178,178,32,32,32,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,178,178,178,32,32,32
    DATA 32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,220,220,220,220,220,220,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,220,176,176,176,176,176,176,220,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,32,178,220,176,176,178,176,176,178,176,176,220,178,32,32,32,32,32,178,178,178,32,32,32,178,32,32,32,32,220,176,176,178,176,176,176,176,178,176,176,220,32,32,32,32,178,32,32,32,32,32,32,32,178,178,178,178,176,176,178,176,176,176,176,176,176,178,176,176,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,176,176,176,178,176,176,176,176,178,176,176,176,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,176,176,176,178,176,176,178,176,176,176,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,223,176,178,176,176,176,176,178,176,223,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,223,176,178,176,176,178,176,223,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,178,32,32,32,223,223,223,223,223,223,32,32,32,178,32,32,32,32,178,178,178,32,32,32,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,178,178,178,32,32,32
    DATA 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,178,178,32,32,32,32,32,32,32,220,220,220,220,220,220,32,32,32,32,32,32,32,178,178,178,32,32,32,32,32,178,178,178,32,32,32,220,176,176,176,176,176,176,220,32,32,32,178,178,178,32,32,32,32,178,178,178,32,32,32,32,178,178,220,176,176,178,176,176,178,176,176,220,178,178,32,32,32,32,178,178,178,32,32,32,178,32,32,32,32,220,176,176,178,176,176,176,176,178,176,176,220,32,32,32,32,178,32,32,32,32,32,32,32,178,178,178,178,176,176,178,176,176,176,176,176,176,178,176,176,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,176,176,176,178,176,176,176,176,178,176,176,176,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,176,176,176,178,176,176,178,176,176,176,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,223,176,178,176,176,176,176,178,176,223,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,223,176,178,176,176,178,176,223,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,178,32,32,32,223,223,223,223,223,223,32,32,32,178,32,32,32,32,178,178,178,32,32,32,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,178,178,178,32,32,32
    DATA 32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,32,32,220,220,220,220,220,220,32,32,32,32,178,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,220,176,176,176,176,176,176,220,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,32,178,220,176,176,178,176,176,178,176,176,220,178,32,32,32,32,32,178,178,178,32,32,32,178,32,32,32,32,220,176,176,178,176,176,176,176,178,176,176,220,32,32,32,32,178,32,32,32,32,32,32,32,178,178,178,178,176,176,178,176,176,176,176,176,176,178,176,176,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,176,176,176,178,176,176,176,176,178,176,176,176,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,223,176,176,176,178,176,176,178,176,176,176,223,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,223,176,178,176,176,176,176,178,176,223,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,32,32,223,176,178,176,176,178,176,223,32,32,178,32,32,32,32,32,32,32,178,178,178,32,32,32,32,178,32,32,32,223,223,223,223,223,223,32,32,32,178,32,32,32,32,178,178,178,32,32,32,178,178,178,178,32,32,32,32,32,32,32,32,32,32,32,32,32,32,178,178,178,178,32,32,32

END SUB

SUB DrawElements
    'Besides drawing elements, this sub fills the array ScreenMap,
    'which is used for lazy collision detection in the main game loop.

    DIM x AS INTEGER, y AS INTEGER, c AS INTEGER
    DIM id AS INTEGER, Char$
    SHARED Pause AS _BYTE, Alive AS _BYTE, Visible AS _BYTE
    SHARED StarFieldSpeed AS DOUBLE, LastEnergyUP#
    SHARED EnergyBlinkColor AS _BYTE
    STATIC LastBonusUpdate#

    'Stars
    FOR id = 1 TO MaxStars
        Visible = -1
        IF Starfield(id).X < 1 OR Starfield(id).X > 80 THEN Visible = 0
        IF Starfield(id).Y < 1 OR Starfield(id).Y > 25 THEN Visible = 0
        IF Visible THEN
            COLOR Starfield(id).Color
            Char$ = Starfield(id).Char
            IF StarFieldSpeed = 0 THEN Char$ = CHR$(196)
            _PRINTSTRING (Starfield(id).X, Starfield(id).Y), Char$
        END IF
    NEXT

    ERASE ScreenMap
    'any bonus?
    IF Bonus.Active = -1 THEN
        IF Bonus.Color = -1 THEN
            'Random colors
            COLOR _CEIL(RND * 14) + 1
        ELSEIF Bonus.Color = -2 THEN 'Custom color pattern
            COLOR CVI(MID$(Bonus.ColorPattern, (Bonus.CurrentColorStep * 2) - 1, 2))
            Bonus.CurrentColorStep = Bonus.CurrentColorStep MOD Bonus.ColorSteps + 1
        ELSEIF (Bonus.Type$ = "ENERGY" AND GetTICKS - LastEnergyUP# <= .2) THEN
            IF EnergyBlinkColor = 10 THEN EnergyBlinkColor = 9 ELSE EnergyBlinkColor = 10
            COLOR EnergyBlinkColor
        ELSE
            COLOR Bonus.Color
        END IF
        x = 1
        y = 1
        c = 1
        DO
            IF Bonus.X + (x - 1) > 0 AND Bonus.X + (x - 1) <= 80 THEN 'Visible?
                Char$ = MID$(Bonus.Shape$, c, 1)
                IF Char$ = " " THEN Char$ = ""
                _PRINTSTRING (Bonus.X + x - 1, Bonus.Y + y - 1), Char$
                IF Char$ <> CHR$(32) THEN ScreenMap(Bonus.X + x - 1, Bonus.Y + y - 1) = ScreenMap.Bonus
            END IF
            c = c + 1
            IF c > LEN(Bonus.Shape$) THEN EXIT DO 'Incomplete shape
            x = x + 1
            IF x > Bonus.Width THEN x = 1: y = y + 1
            IF y > Bonus.Height THEN EXIT DO
        LOOP
    END IF

    IF GetTICKS - LastBonusUpdate# > Bonus.Speed# AND Pause = 0 AND Alive = -1 THEN
        LastBonusUpdate# = GetTICKS
        Bonus.X = Bonus.X - 1
        IF Bonus.X + Bonus.Width < 0 THEN Bonus.Active = 0
    END IF

    'enemies too
    VisibleEnemies = 0
    FOR id = 1 TO MaxEnemies
        'Rotate enemy's shape frames
        IF (GetUptime / 1000) - Enemies(id).LastFrameUpdate > .3 THEN
            Enemies(id).LastFrameUpdate = (GetUptime / 1000)
            Enemies(id).CurrentShape = Enemies(id).CurrentShape MOD Enemies(id).TotalShapes + 1
        END IF

        IF Enemies(id).Color = -1 THEN
            COLOR _CEIL(RND * 14) + 1
        ELSEIF Enemies(id).Color = -2 THEN 'Custom color pattern
            COLOR CVI(MID$(Enemies(id).ColorPattern, (Enemies(id).CurrentColorStep * 2) - 1, 2))
            Enemies(id).CurrentColorStep = Enemies(id).CurrentColorStep MOD Enemies(id).ColorSteps + 1
        ELSE
            COLOR Enemies(id).Color
        END IF
        x = 1
        y = 1
        c = 1
        AnyPartVisible = 0
        Enemies(id).IsVisible = 0
        TotalShapeChars = (Enemies(id).Width * Enemies(id).Height)
        ThisShape$ = MID$(Enemies(id).Shape, Enemies(id).CurrentShape * TotalShapeChars - TotalShapeChars + 1, TotalShapeChars)
        DO
        IF Enemies(id).X + (x - 1) > 0 AND Enemies(id).X + (x - 1) <= 80 AND _
            Enemies(id).Y + (y - 1) > 1 AND Enemies(id).Y + (y - 1) <= 25 THEN 'Visible?
                AnyPartVisible = -1
                Char$ = MID$(ThisShape$, c, 1)
                IF Char$ <> " " THEN
                    _PRINTSTRING (Enemies(id).X + x - 1, Enemies(id).Y + y - 1), Char$
                    ScreenMap(Enemies(id).X + x - 1, Enemies(id).Y + y - 1) = -id
                END IF
            END IF
            c = c + 1
            x = x + 1
            IF x > Enemies(id).Width THEN x = 1: y = y + 1
            IF y > Enemies(id).Height THEN EXIT DO
        LOOP
        IF AnyPartVisible THEN VisibleEnemies = VisibleEnemies + 1
        Enemies(id).IsVisible = -1
    NEXT
END SUB

SUB PlaySound (Handle&)
    IF Handle& = 0 OR Mute THEN EXIT SUB

    _SNDPLAYCOPY Handle&
END SUB

SUB PlaySong (Handle&)
    IF Handle& = 0 OR Mute THEN EXIT SUB

    FOR i = 1 TO UBOUND(SONG)
        IF Handle& <> SONG(i) THEN
            IF SONG(i) THEN _SNDSTOP SONG(i)
        END IF
    NEXT

    IF NOT _SNDPLAYING(Handle&) THEN _SNDLOOP Handle&
END SUB

SUB PauseSong
    FOR i = 1 TO UBOUND(SONG)
        IF SONG(i) THEN _SNDPAUSE SONG(i)
    NEXT
END SUB

SUB StopSong
    FOR i = 1 TO UBOUND(SONG)
        IF SONG(i) THEN _SNDSTOP SONG(i)
    NEXT
END SUB

SUB SetLevel (Which)
    SHARED StarFieldSpeed AS DOUBLE, EnemiesSpeed AS DOUBLE
    SHARED BackupStarFieldSpeed AS DOUBLE
    SHARED MaxEnemies AS INTEGER, ShowChapterName#
    SHARED ChapterName$
    SHARED ChapterTips$, ChapterTips.Position

    TotalChapters = 3
    Recharge = -1
    Energy = 0
    GoalAchieved = 0
    KilledEnemies = 0
    Countdown# = 0
    BossFight = 0

    SELECT CASE Which
        CASE 1
            StarFieldSpeed = .08
            EnemiesSpeed = .08
            IF MaxEnemies = 0 THEN MaxEnemies = 10
            MaxEnemies = 10
            Chapter = Which
            FOR id = 1 TO MaxEnemies
                IF Enemies(id).Hits > 0 THEN MakeEnemyEscape id ELSE CreateEnemy id, Chapter
            NEXT
            ChapterName$ = " LET THERE BE WAR! "
            ChapterTips$ = CHR$(0) + "BASE:BEST OF LUCK, CAPTAIN."
            ChapterTips$ = ChapterTips$ + CHR$(0) + "BASE:I SEE TEN OF THEM ON THE RADAR"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "CAPTAIN:IT'S FUNNY... THEIR MOVEMENT|SEEMS RANDOM AT TIMES"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "CAPTAIN:SOMETIMES I CAN ALMOST|BELIEVE THEY'RE COORDINATED"
            ChapterTips.Position = 1
            ShowChapterName# = GetTICKS
            ChapterGoal = 50
        CASE 2
            StarFieldSpeed = .08
            EnemiesSpeed = .1
            ChapterName$ = " LOOKING FOR FLYING SAUCERS|IN THE SKY "
            ChapterTips$ = CHR$(0) + "BASE:WATCH OUT, CAPTAIN!|WE DON'T KNOW WHAT THEY CAN DO."
            ChapterTips$ = ChapterTips$ + CHR$(0) + "CAPTAIN:I CAN'T AFFORD A DAMAGED UNIT NOW"
            ChapterTips.Position = 1
            ShowChapterName# = GetTICKS
            ChapterGoal = 50
            Chapter = Which
            MaxEnemies = 10
            FOR id = 1 TO MaxEnemies
                IF Enemies(id).Hits > 0 THEN MakeEnemyEscape id ELSE CreateEnemy id, Chapter
            NEXT
        CASE 3
            StarFieldSpeed = .08
            EnemiesSpeed = .1
            Chapter = Which
            ChapterName$ = " KAMIKAZE FRENZY "
            ChapterTips$ = CHR$(0) + "BASE:THIS IS MADNESS!"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "BASE:THESE PILOTS AREN'T AFRAID OF DYING"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "CAPTAIN:I MUST NOT USE ALL MY SHIP'S ENERGY"
            ChapterTips.Position = 1
            ShowChapterName# = GetTICKS
            ChapterGoal = 100
            MaxEnemies = 10
            FOR id = 1 TO MaxEnemies
                IF Enemies(id).Hits > 0 THEN MakeEnemyEscape id ELSE CreateEnemy id, Chapter
            NEXT
        CASE 4
            StarFieldSpeed = .08
            EnemiesSpeed = .1
            Chapter = Which
            ChapterName$ = " SPACE AMOEBA "
            ChapterTips$ = CHR$(0) + "BASE:THESE ARE NOT METAL SHIPS, CAPTAIN!"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "BASE:THESE CREATURES ARE RADIOACTIVE!"
            ChapterTips$ = ChapterTips$ + CHR$(0) + "CAPTAIN:I GOTTA DO WHAT I GOTTA DO.|LET THEM EAT LASER!"
            ChapterTips.Position = 1
            ShowChapterName# = GetTICKS
            ChapterGoal = 2
            FOR id = 1 TO MaxEnemies
                IF Enemies(id).Hits > 0 THEN MakeEnemyEscape id
            NEXT
            MaxEnemies = 1
            CreateEnemy MaxEnemies, Chapter
            BossFight = -1
            PlaySong SONG(2)
        CASE ELSE
            Chapter = 1
            SetLevel Chapter
    END SELECT

    BackupStarFieldSpeed = StarFieldSpeed
    BackupEnemiesSpeed = EnemiesSpeed
END SUB

FUNCTION GetTICKS#
    STATIC LastTICKS#

    IF NOT Pause THEN
        LastTICKS# = (GetUptime / 1000) - PauseOffset#
    END IF

    GetTICKS# = LastTICKS#
END FUNCTION

SUB KillEnemy (id, Strength)
    Enemies(id).Hits = Enemies(id).Hits - Strength
    Enemies(id).X = Enemies(id).X + 5
    IF Enemies(id).Hits <= 0 THEN
        KilledEnemies = KilledEnemies + 1
        WeKilledFirst = -1
        IF KilledEnemies = ChapterGoal THEN GoalAchieved = -1
    END IF
    CreateEnemy id, Chapter
END SUB

FUNCTION RestoreImage& (PixelColor~&)
    'This function must be called after RESTORE is used to
    'point to the correct DATA block
    READ w
    READ h
    a& = _NEWIMAGE(w, h, 32)
    PrevDEST& = _DEST
    _DEST a&
    ih = 0: iw = 0
    DO
        READ b$
        IF b$ = "*" THEN
            ih = ih + 1
            iw = 0
            IF ih = h THEN EXIT DO
        END IF
        c% = VAL(LEFT$(b$, LEN(b$) - 1))
        IF RIGHT$(b$, 1) = "W" THEN
            FOR p = iw TO iw + c%
                PSET (p, ih), PixelColor~&
            NEXT
        END IF
        iw = iw + c%
    LOOP
    RestoreImage& = _COPYIMAGE(a&, 33)
    _FREEIMAGE a&
    _DEST PrevDEST&
END FUNCTION


