'
'  Copyright 2021 Arnold Kramer, T&T SOFTWARE
'
'  Contact:   tijdelijkkistjeskerel@gmail.com
'
'  VERSION 20210426 2.23
'
DECLARE SUB Mouse (Funk)
DEFINT A-Z
IF _FILEEXISTS("..\REPLAY.MCR") = 0 THEN BEEP: CHAIN "Menu.exe"


PlayDemo = 1

OPEN "..\TXTFiles\VOLUME.TXT" FOR INPUT AS #1
INPUT #1, Volume
CLOSE #1
Pct$ = LTRIM$(STR$(Volume))

Zoom# = 1.2 'Belangrijk bij vervorming perspectief

SchadeTailRotor = 0
SchadeFuel = 0

RandomSeed = 48
ShowBlades = 1
ShowCursor = 1
ShowCursorOrg = 0
ShowCoordinates = 1
Rotorcolor = 120
HitHightPerson = 5
HitBallPerson = 10

'
VmaxLanding = 25
KantelmaxLanding# = .06

tk1 = 0: tk2 = 1

Hithoogtemax = 10
HitBallSportscar = 16
HitBallJeep = 16
HitBallTank = 20
HitBallSupplytruck = 20

RFileNr = 0 '     START RESCUES = LEVEL 1


griddensity = 100



FOR k = 1 TO RandomSeed: l = RND: NEXT

Controller$ = "MOUSE"
ThrottleDeadZone! = 0 '      25% deadzone
StickDeadZone! = 0

'     You start off with, at the Base:
BaseBullets = 0
BaseFuel = 0 '         Gallons

CONST FPSTarget = 50

CONST pi# = 3.14159265358979323846264338327950288
CONST pf# = (180 / pi#)
CONST worldx# = 5000 '           '\
'                                  | Afmetingen raster-wereld
CONST worldz# = 5000 '            /
CONST maxkogelweg# = 5000
CONST gravitatie# = .00025 '     [Feet^2 per (n-cycles)^2]
CONST MaxKogels = 50
CONST kogelsnelheid# = 24
CONST camspeed# = 2.75
CONST camhoekspeed# = .125
CONST helgrensvooruit# = .55
CONST helgrensachteruit# = .35
CONST aantalsterren = 50
CONST hoekjesstap = 3 '                             radar stap, grafisch
CONST straaltje = 32 '               radar-
CONST straaltje2 = 64 '                    cirkels
Knippert1 = 1: Knippert2 = 0
Knipper1 = 1: Knipper2 = 0
KnipperTR1 = 1: KnipperTR2 = 0
KnipperFL1 = 1: KnipperFL2 = 0
Knipper3 = 1: Knipper4 = 0
KnipperTellerMax& = FPSTarget / 4
AantalObjecten = 40
MaximaleObjectAfstand = 2000
REDIM bulk1(0 TO 150000)
REDIM bulk2(0 TO 150000)
REDIM pauseback(0 TO 2000)
REDIM xlo0#(0 TO 499): REDIM ylo0#(0 TO 499): REDIM zlo0#(0 TO 499)
REDIM xlo1#(0 TO 499): REDIM ylo1#(0 TO 499): REDIM zlo1#(0 TO 499)
REDIM xlo2#(0 TO 499): REDIM ylo2#(0 TO 499): REDIM zlo2#(0 TO 499)
REDIM xlo3#(0 TO 499): REDIM ylo3#(0 TO 499): REDIM zlo3#(0 TO 499)
REDIM xlo4#(0 TO 499): REDIM ylo4#(0 TO 499): REDIM zlo4#(0 TO 499)
REDIM klo(0 TO 499)
REDIM xlp0#(1 TO 4, 0 TO 99): REDIM ylp0#(1 TO 4, 0 TO 99): REDIM zlp0#(1 TO 4, 0 TO 99)
REDIM xlp1#(1 TO 4, 0 TO 99): REDIM ylp1#(1 TO 4, 0 TO 99): REDIM zlp1#(1 TO 4, 0 TO 99)
REDIM xlp2#(1 TO 4, 0 TO 99): REDIM ylp2#(1 TO 4, 0 TO 99): REDIM zlp2#(1 TO 4, 0 TO 99)
REDIM xlp3#(1 TO 4, 0 TO 99): REDIM ylp3#(1 TO 4, 0 TO 99): REDIM zlp3#(1 TO 4, 0 TO 99)
REDIM xlp4#(1 TO 4, 0 TO 99): REDIM ylp4#(1 TO 4, 0 TO 99): REDIM zlp4#(1 TO 4, 0 TO 99)
REDIM klp(1 TO 4, 0 TO 99)
af = 1
REDIM rescue(0 TO 100)
REDIM afstandwp#(0 TO 100)
REDIM xwp#(0 TO 100)
REDIM ywp#(0 TO 100)
REDIM zwp#(0 TO 100)
REDIM txt$(0 TO 100)
REDIM xk#(0 TO MaxKogels - 1)
REDIM yk#(0 TO MaxKogels - 1)
REDIM zk#(0 TO MaxKogels - 1)
REDIM sxk#(0 TO MaxKogels - 1)
REDIM syk#(0 TO MaxKogels - 1)
REDIM szk#(0 TO MaxKogels - 1)
REDIM schietstatus(0 TO MaxKogels - 1)
REDIM x#(0 TO 1999, 0 TO 4)
REDIM y#(0 TO 1999, 0 TO 4)
REDIM z#(0 TO 1999, 0 TO 4)
REDIM kleur(0 TO 1999)
REDIM RoosMask(0 TO 5000)
REDIM Roos(0 TO 5000)


OPEN "..\TXTFiles\DIFF.TXT" FOR INPUT AS #8
INPUT #8, NumberOfEnemiesActive
CLOSE #8

OPEN "..\TXTFiles\MODE.TXT" FOR INPUT AS #1
INPUT #1, Mode$
CLOSE #1

OPEN "..\TXTFiles\" + "SPEED.TXT" FOR INPUT AS #1
INPUT #1, fastslow$
CLOSE #1

AEN = 1
AENmax = 19

REDIM xvijand#(1 TO AENmax, 0 TO 1999, 0 TO 4)
REDIM yvijand#(1 TO AENmax, 0 TO 1999, 0 TO 4)
REDIM zvijand#(1 TO AENmax, 0 TO 1999, 0 TO 4)
REDIM kleurvijand(1 TO AENmax, 0 TO 1999)

REDIM xITMZwaartepunt#(1 TO AENmax)
REDIM yITMZwaartepunt#(1 TO AENmax)
REDIM zITMZwaartepunt#(1 TO AENmax)
REDIM HitAfstand#(1 TO AENmax)
REDIM vijanddx#(1 TO AENmax)
REDIM vijanddy#(1 TO AENmax)
REDIM vijanddz#(1 TO AENmax)
REDIM vijandType(1 TO AENmax)
REDIM sxvijand#(1 TO AENmax)
REDIM syvijand#(1 TO AENmax)
REDIM szvijand#(1 TO AENmax)
REDIM jndamage(1 TO AENmax)
REDIM yU(1 TO AENmax)
REDIM enemydamage(1 TO AENmax)
REDIM firstTimeWarnNOT(1 TO AENmax)
REDIM l(1 TO AENmax)
REDIM hoek(1 TO AENmax)
REDIM VijandSpeed#(1 TO AENmax)
REDIM VijandAfstand#(1 TO AENmax)
REDIM VijandHoek#(1 TO AENmax)
REDIM RadarDotType(1 TO AENmax)
REDIM vijand$(1 TO AENmax)
REDIM Distance#(1 TO AENmax)
REDIM Radarhoek#(1 TO AENmax)
REDIM xRadar(1 TO AENmax)
REDIM yRadar(1 TO AENmax)
REDIM Wreck(1 TO AENmax)
REDIM roodflits(1 TO AENmax)
REDIM xobject#(0 TO AantalObjecten, 0 TO 499, 0 TO 4)
REDIM yobject#(0 TO AantalObjecten, 0 TO 499, 0 TO 4)
REDIM zobject#(0 TO AantalObjecten, 0 TO 499, 0 TO 4)
REDIM kleurobject(0 TO AantalObjecten, 0 TO 499)
REDIM v(0 TO 10000)
REDIM xster#(1 TO aantalsterren)
REDIM yster#(1 TO aantalsterren)
REDIM zster#(1 TO aantalsterren)
REDIM sterkleur(1 TO aantalsterren)
REDIM PlayerName$(1 TO 10)
REDIM PlayerScore&(1 TO 10)
REDIM PlayerLevel(1 TO 10)
REDIM PlayerSeconds&(1 TO 10)
REDIM PS$(1 TO 10)
REDIM min$(1 TO 10)
REDIM sec$(1 TO 10)
REDIM FuelTotal#(1 TO 10)
REDIM VinkMask(0 TO 200)
REDIM Vink(0 TO 200)
REDIM CursorMask(0 TO 800)
REDIM Cursor(0 TO 800)
REDIM R(0 TO 3000)
REDIM Rmask(0 TO 3000)
REDIM Muis0Mask(0 TO 3000)
REDIM Muis0(0 TO 3000)
REDIM Muis1Mask(0 TO 3000)
REDIM Muis1(0 TO 3000)
REDIM Muis2Mask(0 TO 3000)
REDIM Muis2(0 TO 3000)
REDIM Spacebar0Mask(0 TO 1000)
REDIM Spacebar0(0 TO 1000)
REDIM Spacebar1Mask(0 TO 1000)
REDIM Spacebar1(0 TO 1000)
REDIM objectdx#(1 TO AantalObjecten)
REDIM objectdy#(1 TO AantalObjecten)
REDIM objectdz#(1 TO AantalObjecten)
REDIM ObjectYesNo(1 TO AantalObjecten)
REDIM moon(0 TO 5000)
REDIM mux(0 TO 2500)


GOSUB NewObjects

GOSUB loadperson

DamageTextElevation = 24

Damage = 0
DelayTime# = .002 '              sec. Delay
vertraging = 0 '                      DELAY ja of nee
full = 0 '                       Fullscreen=off (1=on)

OPEN "..\TXTFiles\CURRENT.TXT" FOR INPUT AS #8
INPUT #8, Bestand$
CLOSE #8
OPEN "..\TXTFiles\" + "FPS.TXT" FOR INPUT AS #1
INPUT #1, OverallFramerate
CLOSE #1
muxer! = 1

NumberOfBullets = 0

FuelTotalUsed# = 0

fuelmax# = 230 '                230 gallon max.

itmscale = 4 '                   Schaal Item        (zie 'loaditm:')
itmdx = -14 * itmscale '         Item offset              \
itmdy = 0 * itmscale '           van                       } BJC.exe Geldt voor Scene en Enemy
itmdz = -14 * itmscale '         item                     /

xoffset# = 10
yoffset# = 0
zoffset# = 10

verbruik# = .005
schaaly# = 5
schaalx# = 8
cambreedte# = 2
camhoogte# = 1.125

levelhoogte$ = "off"
os# = .048 '                     versnelling up
ds# = .008 '                     versnelling down
refuelspeed# = 300

ymin = 6 '                                  grondlevel
yc3ondergrens# = ymin + .1

landingstolerantie# = 25
waypointstolerantie# = 50
grootte = 50 '                              array karakters
hoekje = 0
hoekje2 = 45
maan = 1 '                            maan aan of uit
maankleur = 11
maanstraal = 7
frames = 0
FPSShow = 0
s1 = 1: s0 = 0

GOSUB LoadRescues

waypoint = 0
xland# = xwp#(waypoint) + .00000001 '        \   <>0 (vervorming bij start)
yland# = ywp#(waypoint) '                    | Thuisbasis (zonder hitbox)
zland# = zwp#(waypoint) '                    /

FOR S = 1 TO aantalsterren
    hulp:
    xster#(S) = 50000000 - 100000000 * RND
    yster#(S) = 50000000 * RND
    zster#(S) = 50000000 - 100000000 * RND
    sterkleur(S) = 9 + 4 * RND
    IF SQR((xster#(S) - worldx# / 2) ^ 2 + (yster#(S) - 0) ^ 2 + (zster#(S) - worldz# / 2) ^ 2) < 10000000 GOTO hulp
NEXT
xmaan# = -300000
ymaan# = 150000
zmaan# = 700000

xc1# = xland# - cambreedte# / 2: yc1# = ymin + camhoogte#: zc1# = zland#
xc2# = xland# + cambreedte# / 2: yc2# = ymin + camhoogte#: zc2# = zland#
xc3# = xland# + cambreedte# / 2: yc3# = ymin: zc3# = zland#
xc4# = xland# - cambreedte# / 2: yc4# = ymin: zc4# = zland#

xc5# = (xc1# + xc2#) / 2: yc5# = (yc2# + yc3#) / 2: zc5# = zland# - Zoom# * camhoogte# 'ZOOM

Gun& = _SNDOPEN("..\OGGFiles\" + "Gun.ogg", "VOL,SYNC")
HitEnemy& = _SNDOPEN("..\OGGFiles\" + "HitEnemy.ogg", "VOL,SYNC")
HitPlay& = _SNDOPEN("..\OGGFiles\" + "HitPlay.ogg", "VOL,SYNC")
Bonus1& = _SNDOPEN("..\OGGFiles\" + "Bonus1.ogg", "VOL,SYNC")
Bonus2& = _SNDOPEN("..\OGGFiles\" + "Bonus2.ogg", "VOL,SYNC")
Bonus3& = _SNDOPEN("..\OGGFiles\" + "Bonus3.ogg", "VOL,SYNC")
Bonus4& = _SNDOPEN("..\OGGFiles\" + "Bonus4.ogg", "VOL,SYNC")
Bonus5& = _SNDOPEN("..\OGGFiles\" + "Bonus5.ogg", "VOL,SYNC")
Bonus6& = _SNDOPEN("..\OGGFiles\" + "Bonus6.ogg", "VOL,SYNC")
Fail& = _SNDOPEN("..\OGGFiles\" + "Fail.ogg", "VOL,SYNC")
Dingdong& = _SNDOPEN("..\OGGFiles\" + "Dingdong.ogg", "VOL,SYNC")
Rescue& = _SNDOPEN("..\OGGFiles\" + "Rescue.ogg", "VOL,SYNC")
Blades& = _SNDOPEN("..\OGGFiles\" + "Blades.ogg", "VOL,SYNC")
Damage& = _SNDOPEN("..\OGGFiles\" + "Damage.ogg", "VOL,SYNC")
Garage& = _SNDOPEN("..\OGGFiles\" + "Garage.ogg", "VOL,SYNC")
Theme& = _SNDOPEN("..\OGGFiles\" + "Theme.ogg", "VOL,SYNC")
Click& = _SNDOPEN("..\OGGFiles\" + "Click.ogg", "VOL,SYNC")
_SNDVOL Gun&, Volume / 100
_SNDVOL HitEnemy&, Volume / 100
_SNDVOL HitPlay&, Volume / 100
_SNDVOL Bonus1&, Volume / 100
_SNDVOL Bonus2&, Volume / 100
_SNDVOL Bonus3&, Volume / 100
_SNDVOL Bonus4&, Volume / 100
_SNDVOL Bonus5&, Volume / 100
_SNDVOL Bonus6&, Volume / 100
_SNDVOL Fail&, Volume / 100
_SNDVOL Dingdong&, Volume / 100
_SNDVOL Rescue&, Volume / 100
_SNDVOL Blades&, Volume / 100
_SNDVOL Damage&, Volume / 100
_SNDVOL Garage&, Volume / 100
_SNDVOL Theme&, Volume / 100
_SNDVOL Click&, Volume / 100


_DELAY .25
SCREEN _NEWIMAGE(800, 450, 256)
_SCREENMOVE _MIDDLE
_DELAY .25

FOR altco = 0 TO 255: PALETTE altco, 0: NEXT

OPEN "..\TXTFiles\DISPLAY.TXT" FOR INPUT AS #4
INPUT #4, screen$
CLOSE #4
IF screen$ = "FULLSCREEN" THEN full = 1
IF screen$ = "WINDOWED" THEN full = 0
IF full = 1 THEN
    _FULLSCREEN
ELSE
    _FULLSCREEN _OFF
    _SCREENMOVE _MIDDLE
END IF
'
CLS
RESTORE Rdata
FOR y = 0 TO 31
    READ line$
    FOR x = 0 TO LEN(line$) - 1
        IF MID$(line$, x + 1, 1) = "1" THEN PSET (x, y), 163
        IF MID$(line$, x + 1, 1) = "2" THEN PSET (x, y), 150
        IF MID$(line$, x + 1, 1) = "." THEN PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(LEN(line$) - 1, 31), R(0)

FOR y = 0 TO 31
    FOR x = 0 TO LEN(line$) - 1
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(LEN(line$) - 1, 31), Rmask(0)

CLS



PALETTE 163, 63 * 65536 + 63 * 256 + 63



'            18x8

RESTORE MuxerData
FOR nrr = 0 TO 4
    FOR y = 0 TO 7
        READ line$
        FOR x = 0 TO LEN(line$) - 1
            IF MID$(line$, x + 1, 1) = "1" THEN PSET (x, y + nrr * 8), 163
        NEXT
    NEXT
NEXT

GET (0, 0)-(17, 7), mux(0)
GET (0, 8)-(17, 15), mux(500)
GET (0, 16)-(17, 23), mux(1000)
GET (0, 24)-(17, 31), mux(1500)
GET (0, 32)-(17, 39), mux(2000)

CLS

RESTORE spacebar0
FOR y = 0 TO 11
    READ line$
    FOR x = 0 TO 47
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$ '                     8=rood        100->163 = grijstinten zwart->wit
            CASE "1": PSET (x, y), 1
            CASE "2": PSET (x, y), 2
            CASE "3": PSET (x, y), 3
            CASE "4": PSET (x, y), 4
            CASE "5": PSET (x, y), 5
            CASE "6": PSET (x, y), 6
        END SELECT
    NEXT
NEXT
GET (0, 0)-(47, 11), Spacebar0(0)
FOR y = 0 TO 11
    FOR x = 0 TO 47
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(47, 11), Spacebar0Mask(0)
CLS
RESTORE spacebar1
FOR y = 0 TO 11
    READ line$
    FOR x = 0 TO 47
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$ '                     8=rood        100->163 = grijstinten zwart->wit
            CASE "1": PSET (x, y), 1
            CASE "2": PSET (x, y), 2
            CASE "3": PSET (x, y), 3
            CASE "4": PSET (x, y), 4
            CASE "5": PSET (x, y), 5
            CASE "6": PSET (x, y), 6
        END SELECT
    NEXT
NEXT
GET (0, 0)-(47, 11), Spacebar1(0)
FOR y = 0 TO 11
    FOR x = 0 TO 47
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(47, 11), Spacebar1Mask(0)
CLS
RESTORE muis0 '
FOR y = 0 TO 31
    READ line$
    FOR x = 0 TO 23
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$ '                     8=rood        100->163 = grijstinten zwart->wit
            CASE "1": PSET (x, y), 1
            CASE "2": PSET (x, y), 2
            CASE "3": PSET (x, y), 3
            CASE "4": PSET (x, y), 4
            CASE "5": PSET (x, y), 5
            CASE "6": PSET (x, y), 6
        END SELECT
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis0(0)
FOR y = 0 TO 31
    FOR x = 0 TO 23
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis0Mask(0)
CLS
RESTORE muis1 '
FOR y = 0 TO 31
    READ line$
    FOR x = 0 TO 23
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$ '                     8=rood        100->163 = grijstinten zwart->wit
            CASE "1": PSET (x, y), 1
            CASE "2": PSET (x, y), 2
            CASE "3": PSET (x, y), 3
            CASE "4": PSET (x, y), 4
            CASE "5": PSET (x, y), 5
            CASE "6": PSET (x, y), 6
        END SELECT
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis1(0)
FOR y = 0 TO 31
    FOR x = 0 TO 23
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis1Mask(0)
CLS
RESTORE muis2 '
FOR y = 0 TO 31
    READ line$
    FOR x = 0 TO 23
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$ '                     8=rood        100->163 = grijstinten zwart->wit
            CASE "1": PSET (x, y), 1
            CASE "2": PSET (x, y), 2
            CASE "3": PSET (x, y), 3
            CASE "4": PSET (x, y), 4
            CASE "5": PSET (x, y), 5
            CASE "6": PSET (x, y), 6
        END SELECT
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis2(0)
FOR y = 0 TO 31
    FOR x = 0 TO 23
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(23, 31), Muis2Mask(0)
CLS
RESTORE cursor
FOR y = 0 TO 18
    READ line$
    FOR x = 0 TO 11
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$
            CASE "1": PSET (x, y), 17
            CASE "2": PSET (x, y), 16
        END SELECT
    NEXT
NEXT
GET (0, 0)-(11, 18), Cursor(0)
FOR y = 0 TO 18
    FOR x = 0 TO 11
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(11, 18), CursorMask(0)
CLS
RESTORE vink
FOR y = 0 TO 7
    READ line$
    FOR x = 0 TO 8
        Column$ = MID$(line$, x + 1, 1)
        SELECT CASE Column$
            CASE "1": PSET (x, y), 8
        END SELECT
    NEXT
NEXT
GET (0, 0)-(8, 7), Vink(0)
FOR y = 0 TO 7
    FOR x = 0 TO 8
        IF POINT(x, y) = 0 THEN PSET (x, y), 255 ELSE PSET (x, y), 0
    NEXT
NEXT
GET (0, 0)-(8, 7), VinkMask(0)
CLS

RESTORE roos
FOR y = 0 TO 55
    READ a$
    FOR x = 0 TO LEN(a$) - 1
        b$ = MID$(a$, x + 1, 1)
        SELECT CASE b$
            CASE "1": PSET (x, y), 164
            CASE ELSE: PSET (x, y), 0
        END SELECT
    NEXT
NEXT
GET (0, 0)-(55, 55), Roos(0)
LINE (0, 0)-(55, 55), 0, BF
RESTORE roos
FOR y = 0 TO 55
    READ a$
    FOR x = 0 TO LEN(a$) - 1
        b$ = MID$(a$, x + 1, 1)
        SELECT CASE b$
            CASE "0": PSET (x, y), 255
            CASE ELSE: PSET (x, y), 0
        END SELECT
    NEXT
NEXT
GET (0, 0)-(55, 55), RoosMask(0)
CLS

RESTORE Set2 '                           Character set (2 of 2)
FOR nch = 32 TO 38
    dxch = (nch - 32) * 6
    dych = 10
    FOR ych = 0 TO 6
        READ pch$
        FOR xch = 0 TO 5
            flag$ = MID$(pch$, xch + 1, 1)
            IF flag$ = "1" THEN PSET (dxch + xch, dych + ych), 255
        NEXT
    NEXT
    GET (dxch, dych)-(dxch + 5, dych + 6), v(nch * grootte)
NEXT
FOR nch = 40 TO 41
    dxch = (nch - 32) * 6
    dych = 10
    FOR ych = 0 TO 6
        READ pch$
        FOR xch = 0 TO 5
            flag$ = MID$(pch$, xch + 1, 1)
            IF flag$ = "1" THEN PSET (dxch + xch, dych + ych), 255
        NEXT
    NEXT
    GET (dxch, dych)-(dxch + 5, dych + 6), v(nch * grootte)
NEXT
FOR nch = 43 TO 58
    dxch = (nch - 43) * 6
    FOR ych = 0 TO 6
        READ pch$
        FOR xch = 0 TO 5
            flag$ = MID$(pch$, xch + 1, 1)
            IF flag$ = "1" THEN PSET (dxch + xch, ych), 255
        NEXT
    NEXT
    GET (dxch, 0)-(dxch + 5, 6), v(nch * grootte)
NEXT
FOR nch = 64 TO 92
    dxch = (nch - 45) * 6
    FOR ych = 0 TO 6
        READ pch$
        FOR xch = 0 TO 5
            flag$ = MID$(pch$, xch + 1, 1)
            IF flag$ = "1" THEN PSET (dxch + xch, ych), 255
        NEXT
    NEXT
    GET (dxch, 0)-(dxch + 5, 6), v(nch * grootte)
NEXT

RESTORE moondata '
FOR yyy = 0 TO 15
    READ aaa$
    FOR xxx = 0 TO LEN(aaa$) - 1
        bbb$ = MID$(aaa$, xxx + 1, 1)
        SELECT CASE bbb$
            CASE "a": PSET (xxx, yyy), 200
            CASE "b": PSET (xxx, yyy), 201
            CASE "c": PSET (xxx, yyy), 202
            CASE "d": PSET (xxx, yyy), 203
            CASE "e": PSET (xxx, yyy), 204
            CASE "f": PSET (xxx, yyy), 205
            CASE "g": PSET (xxx, yyy), 206
            CASE "h": PSET (xxx, yyy), 207
            CASE "i": PSET (xxx, yyy), 208
            CASE "j": PSET (xxx, yyy), 209
            CASE "k": PSET (xxx, yyy), 210
            CASE "l": PSET (xxx, yyy), 211
            CASE "m": PSET (xxx, yyy), 212
            CASE "n": PSET (xxx, yyy), 213
            CASE "o": PSET (xxx, yyy), 214
            CASE "p": PSET (xxx, yyy), 215
            CASE "q": PSET (xxx, yyy), 216
            CASE "r": PSET (xxx, yyy), 217
            CASE ELSE: PSET (xxx, yyy), 0
        END SELECT
    NEXT
NEXT
GET (0, 0)-(15, 15), moon(0)
CLS

PALETTE 0, 65536 * 0 + 256 * 0 + 0 '   zwart
PALETTE 1, 65536 * 10 + 256 * 10 + 10 '-
PALETTE 2, 65536 * 20 + 256 * 20 + 20 ' |
PALETTE 3, 65536 * 30 + 256 * 30 + 30 ' |grijstinten tot bijna wit
PALETTE 4, 65536 * 40 + 256 * 40 + 40 ' |
PALETTE 5, 65536 * 50 + 256 * 50 + 50 '-
PALETTE 6, 65536 * 47 + 256 * 0 + 0 '  blauw
PALETTE 7, 65536 * 0 + 256 * 63 + 0 '  groen
PALETTE 8, 65536 * 0 + 256 * 0 + 63 '  rood
PALETTE 9, 65536 * 0 + 256 * 31 + 0 '  HighScoreBox Groen
PALETTE 10, 65536 * 0 + 256 * 50 + 55 ' |
PALETTE 11, 65536 * 0 + 256 * 45 + 50 ' |vlamtinten
PALETTE 12, 65536 * 0 + 256 * 35 + 45 ' |
PALETTE 13, 65536 * 0 + 256 * 25 + 63 '-
PALETTE 14, 65536 * 0 + 256 * 15 + 0 ' donkergroen
PALETTE 15, 65536 * 0 + 256 * 63 + 0 'hoofdkleur
PALETTE 16, 65536 * 63 + 256 * 63 + 63 'wit
PALETTE 17, 65536 * 0 + 256 * 0 + 0 '   zwart


FOR grey = 100 TO 163
    PALETTE grey, 65536 * (grey - 100) + 256 * (grey - 100) + (grey - 100)
NEXT
PALETTE 164, 65536 * 0 + 256 * 31 + 0 'midden-groen
PALETTE 255, 65536 * 0 + 256 * 63 + 0 'Maxkleur

'Maanpalet  bgr   groen+10 rood+16
PALETTE 200, 65536 * 40 + 256 * 42 + 48 'a
PALETTE 201, 65536 * 32 + 256 * 42 + 48 'b
PALETTE 202, 65536 * 48 + 256 * 58 + 63 'c
PALETTE 203, 65536 * 48 + 256 * 55 + 63 'd
PALETTE 204, 65536 * 40 + 256 * 50 + 48 'e
PALETTE 205, 65536 * 48 + 256 * 50 + 48 'f
PALETTE 206, 65536 * 24 + 256 * 34 + 32 'g
PALETTE 207, 65536 * 32 + 256 * 42 + 32 'h
PALETTE 208, 65536 * 48 + 256 * 58 + 48 'i
PALETTE 209, 65536 * 32 + 256 * 34 + 32 'j
PALETTE 210, 65536 * 16 + 256 * 18 + 16 'k
PALETTE 211, 65536 * 16 + 256 * 26 + 32 'l
PALETTE 212, 65536 * 24 + 256 * 26 + 32 'm
PALETTE 213, 65536 * 48 + 256 * 58 + 48 'n
PALETTE 214, 65536 * 16 + 256 * 26 + 32 'o
PALETTE 215, 65536 * 16 + 256 * 18 + 32 'p
PALETTE 216, 65536 * 8 + 256 * 18 + 32 'q
PALETTE 217, 65536 * 21 + 256 * 34 + 50 'r
'
FOR altroodflits = 218 TO 248
    rwrd = altroodflits - 218
    PALETTE altroodflits, 2 * rwrd
NEXT
PALETTE 249, 65536 * 31 + 256 * 31 + 63

FOR altAEN = 1 TO AENmax: roodflits(altAEN) = 249: NEXT


GOSUB loaditm

OPEN "..\TXTFiles\VEHICLES.TXT" FOR INPUT AS #7
FOR altAEN = 1 TO NumberOfEnemiesActive
    AEN = altAEN: GOSUB NextEnemy
NEXT
sec& = 0
resec& = 0
'****************************************************************** CACHE
'OPEN "..\REPLAY.MCR" FOR INPUT AS #13
'WHILE NOT EOF(13)
'  PRINT ".";
'  INPUT #13, VMuis, BMuis, TR
'  IF HMuis = 999 THEN DonderOp = 1: EXIT WHILE
'WEND
'CLOSE #13
'************************************************************************

ON TIMER(1) GOSUB pulse
TIMER ON
IF ShowCursorOrg = 0 THEN _MOUSEHIDE
IF _FILEEXISTS("..\REPLAY.MCR") = 0 THEN
    OPEN "..\REPLAY.MCR" FOR OUTPUT AS #13
    PRINT #13, 999, 999, 999, 999
    CLOSE #13
END IF

OPEN "..\REPLAY.MCR" FOR INPUT AS #13

'*****************************************************************************
'*****************************************************************************
'                                                BESTURING
startlabel:
i$ = INKEY$
_LIMIT OverallFramerate '  HOOFD-SNELHEIDSBEGRENZING IN Frames Per Second

IF i$ = CHR$(9) THEN GOSUB swapScreen

IF i$ = "+" AND muxer! < 4 THEN yesss = 1: _SNDPLAYCOPY Click&: muxer! = muxer! * 2: ShowSpeed = 1: OverallFramerate = OverallFramerate * 2: yesssteller& = 0
IF i$ = "-" AND muxer! > 1 / 4 THEN yesss = 1: _SNDPLAYCOPY Click&: muxer! = muxer! / 2: ShowSpeed = 1: OverallFramerate = OverallFramerate / 2: yesssteller& = 0
IF UCASE$(i$) = "B" THEN GOSUB swapBlades
IF UCASE$(i$) = "Q" THEN GOSUB SwapCursor
SELECT CASE Controller$
    CASE "MOUSE"
        Mouse 3 '
        IF PlayDemo = 1 THEN
            IF NOT EOF(13) THEN INPUT #13, HMuis
            IF HMuis = 999 THEN DonderOp = 1 ELSE INPUT #13, VMuis, BMuis, TR
        END IF
        IF status$ <> "LANDED" THEN
            SELECT CASE SchadeTailRotor
                CASE 0
                    w1 = .9 * (w1 + .05 * ((HMuis - 400) / 3.2))
                    w2 = (VMuis - 225) / 4.8
                CASE 1
                    w1 = .9 * (w1 + .05 * ((HMuis - 700) / 3.2))
                    w2 = (VMuis - 225) / 4.8
            END SELECT
        END IF
        IF TR = 57 THEN GOSUB schiet
    CASE "JOYSTICK"
        d& = _DEVICEINPUT
        IF d& = 3 THEN
            trigger = -_BUTTON(1)
            SELECT CASE SchadeTailRotor
                CASE 0
                    XStick! = _AXIS(1)
                CASE 1
                    XStick! = _AXIS(1) + .75
                    IF XStick! > 1 THEN XStick! = 1
            END SELECT
            YStick! = _AXIS(2)
            Throttle! = -_AXIS(3)
            IF ABS(XStick!) < StickDeadZone! THEN XStick! = 0
            IF ABS(YStick!) < StickDeadZone! THEN YStick! = 0
            IF ABS(Throttle!) < ThrottleDeadZone! THEN Throttle! = 0
        END IF
        IF trigger = 1 THEN GOSUB schiet
        IF status$ <> "LANDED" THEN
            w1 = .9 * (w1 + .05 * (125 * XStick!))
            w2 = 63.5 * YStick!
        END IF
END SELECT

speedfactor# = -helhoek# * 1.5
IF speedfactor# < -.75 THEN speedfactor# = -.75
IF speedfactor# > .75 THEN speedfactor# = .75

SELECT CASE Controller$
    CASE "MOUSE"
        '
        IF fuel# > 0 AND BMuis = 1 THEN w4 = 1: levelhoogte$ = "off" ELSE w4 = 0
        IF BMuis = 2 THEN w4 = 0: power$ = "on": levelhoogte$ = "off"
    CASE "JOYSTICK"
        d& = _DEVICEINPUT
        IF d& = 3 THEN
            trigger = -_BUTTON(1)
            Throttle! = -_AXIS(3)
            IF ABS(Throttle!) < ThrottleDeadZone! THEN Throttle! = 0: BMuis = 0
        END IF
        IF fuel# > 0 AND Throttle! > .75 THEN w4 = 1: levelhoogte$ = "off" ELSE w4 = 0

        IF Throttle! >= .25 AND Throttle! <= .75 THEN
            w4 = 0: levelhoogte$ = "on"
        END IF

        IF Throttle! < .25 THEN w4 = 0: power$ = "on": levelhoogte$ = "off"
        IF Throttle! = 0 THEN levelhoogte$ = "on": BMuis = 0
END SELECT
IF levelhoogte$ = "on" THEN
    IF yc0# <= yl# THEN w4 = 1 ELSE w4 = 0
END IF
IF w1 < -100 THEN w1 = -100
IF w1 > 100 THEN w1 = 100
IF w2 < -100 THEN w2 = -100
IF w2 > 100 THEN w2 = 100
IF w3 < 0 THEN w3 = 0
IF w3 > 100 THEN w3 = 100
IF w4 = 1 THEN
    stijgkracht# = stijgkracht# + os#
    GOSUB stijgendalen
END IF
IF w4 = 0 AND levelhoogte$ = "off" THEN
    stijgkracht# = stijgkracht# - ds#
    GOSUB stijgendalen
END IF
IF yc3# > ymin THEN var1# = w1 / 400 ELSE
IF w1 <> 0 THEN
    IF yc3# > yc3ondergrens# THEN GOSUB linksrechts
END IF
kantel# = var1#

IF status$ = "LANDED" THEN
    _MOUSESHOW: yh1 = 225: yh2 = 225: yh3 = 225: kantel# = 0
END IF

SELECT CASE ShowCursorOrg
    CASE 0: _MOUSEHIDE
    CASE 1: _MOUSESHOW
END SELECT
'
IF kantel# > .15 THEN kantel# = .15
IF kantel# < -.15 THEN kantel# = -.15
IF w2 <> 0 AND hh# >= 0 THEN
    var2# = w2 / 400
    GOSUB omhoogomlaag
END IF
GOSUB vooruit
status$ = ""

IF yc3# <= ymin OR yc4# <= ymin THEN
    IF INT(210 * speedfactor# * .54) > VmaxLanding THEN Speedcrash = 1 ELSE Speedcrash = 0 'maximale landsnelheid 10 kts
    IF ABS(kantel#) > KantelmaxLanding# THEN Kantelcrash = 1

    yc1# = ymin + camhoogte#: yc2# = ymin + camhoogte#: yc3# = ymin: yc4# = ymin: yc5# = ymin + .5 * camhoogte#
    speedfactor# = 0: helhoek# = 0: kantel# = 0: stijgkracht# = 0: spy# = ymin: hh# = 0
    GOSUB landcheck
END IF
xc0# = (xc1# + xc2# + xc3# + xc4#) / 4: yc0# = (yc1# + yc2# + yc3# + yc4#) / 4: zc0# = (zc1# + zc2# + zc3# + zc4#) / 4

'*****************************************************************************
'                                                     GRID
FOR xp# = -worldx# / 2 + (xc0# \ 100) * 100 TO worldx# / 2 + (xc0# \ 100) * 100 STEP griddensity
    FOR zp# = -worldz# / 2 + (zc0# \ 100) * 100 TO worldz# / 2 + (zc0# \ 100) * 100 STEP griddensity
        yp# = 0
        jnplaat = 0: GOSUB bbd
        qx# = 400 + schaalx# * pf# * horhoek# ' qx#=400+schaalx#*
        qy# = 225 - schaaly# * pf# * verhoek#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xplaat# = qx#: yplaat# = qy#: jnplaat = 1
        END IF
        gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
        IF gridcolor < 100 THEN gridcolor = 100
        IF gridcolor > 163 THEN gridcolor = 163
        IF gridcolor > 100 AND jnplaat = 1 THEN PSET (xplaat#, yplaat#), gridcolor: jnplaat = 0
    NEXT
NEXT
'*****************************************************************************
'                                                STARS
FOR S = 1 TO aantalsterren
    xp# = xster#(S)
    yp# = yster#(S)
    zp# = zster#(S)
    jnster = 0: GOSUB bbd
    qx# = 400 + schaalx# * pf# * horhoek#
    qy# = 225 - schaaly# * pf# * verhoek#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xster# = qx#: yster# = qy#: jnster = 1
    END IF
    IF jnster = 1 THEN PSET (xster#, yster#), sterkleur(S): jnster = 0
NEXT
'*****************************************************************************
'                                               MOON
IF maan = 1 THEN
    xp# = xmaan#
    yp# = ymaan#
    zp# = zmaan#
    jnmaan = 0: GOSUB bbd
    qx# = 400 + schaalx# * pf# * horhoek#
    qy# = 225 - schaaly# * pf# * verhoek#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= -maanstraal AND qx# <= 799 + maanstraal AND qy# >= -maanstraal AND qy# <= 449 + maanstraal THEN
        xmt# = qx#: ymt# = qy#: jnmaan = 1
    END IF
    IF jnmaan = 1 THEN '
        ''CIRCLE (xmt#, ymt#), maanstraal, maankleur
        ''PAINT (xmt#, ymt# - 1 + maanstraal), maankleur
        ''PAINT (xmt#, ymt# + 1 - maanstraal), maankleur
        ''PAINT (xmt# - 1 + maanstraal, ymt#), maankleur
        ''PAINT (xmt# + 1 - maanstraal, ymt#), maankleur
        PUT (xmt# - maanstraal, ymt# - maanstraal), moon(0), _CLIP PSET
        jnmaan = 0
    END IF
END IF
'*****************************************************************************
'                                                 FRIENDLY BULLETS
FOR akn = 0 TO MaxKogels - 1
    syk#(akn) = syk#(akn) - gravitatie#
    gunkogelafstand# = SQR((xk#(akn) - xc0#) ^ 2 + (yk#(akn) - yc0#) ^ 2 + (zk#(akn) - zc0#) ^ 2)

    IF schietstatus(akn) = 1 THEN
        FOR AEN = 1 TO NumberOfEnemiesActive
            DoelAfstand# = SQR((xk#(akn) - xITMZwaartepunt#(AEN)) ^ 2 + (yk#(akn) - yITMZwaartepunt#(AEN)) ^ 2 + (zk#(akn) - zITMZwaartepunt#(AEN)) ^ 2)
            IF DoelAfstand# < HitAfstand#(AEN) AND yk#(akn) < Hithoogtemax THEN schietstatus(akn) = 0: GOSUB raak
        NEXT

        IF yk#(akn) < 10 THEN
            FOR objectnummer = 1 TO AantalObjecten
                d# = SQR((objectdx#(objectnummer) - xk#(akn)) ^ 2 + (objectdz#(objectnummer) - zk#(akn)) ^ 2)
                IF d# < ObjectHitBall AND ObjectYesNo(objectnummer) = 1 THEN
                    ObjectYesNo(objectnummer) = 0
                    _SNDPLAYCOPY HitEnemy&
                    ObjectsHit = ObjectsHit + 1: score& = score& + 10
                    ShowObjects = 1
                    IF ObjectsHit = 1 * (AantalObjecten \ 4) AND Bonus1 = 0 THEN score& = score& + 200: Bonus1 = 1: _SNDPLAYCOPY Bonus1&
                    IF ObjectsHit = 2 * (AantalObjecten \ 4) AND Bonus2 = 0 THEN score& = score& + 200: Bonus2 = 1: _SNDPLAYCOPY Bonus2&
                    IF ObjectsHit = 3 * (AantalObjecten \ 4) AND Bonus3 = 0 THEN score& = score& + 200: Bonus3 = 1: _SNDPLAYCOPY Bonus3&
                    IF ObjectsHit = 4 * (AantalObjecten \ 4) AND Bonus4 = 0 THEN
                        score& = score& + 2000: Bonus4 = 1: _SNDPLAYCOPY Bonus4&: GOSUB NewObjects

                    END IF
                END IF
            NEXT
        END IF
        FOR altpsn = 1 TO waypoints
            IF rescue(altpsn) = 0 THEN
                d# = SQR((xwp#(altpsn) - xk#(akn)) ^ 2 + (zwp#(altpsn) - zk#(akn)) ^ 2)
                IF d# < HitBallPerson AND yk#(akn) < HitHightPerson THEN
                    Exit$ = "- YOU KILLED SOMEONE -": gameover = 1
                END IF
            END IF
        NEXT
        xk#(akn) = xk#(akn) + sxk#(akn)
        yk#(akn) = yk#(akn) + syk#(akn)
        zk#(akn) = zk#(akn) + szk#(akn)
        xp# = xk#(akn): yp# = yk#(akn): zp# = zk#(akn): GOSUB bbd
        qx# = 400 + schaalx# * pf# * horhoek#
        qy# = 225 - schaaly# * pf# * verhoek#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie = qx#: ykprojectie = qy#
        END IF


        IF gunkogelafstand# > maxkogelweg# OR yk#(akn) < 0 THEN
            '
            IF TypeObjecten MOD 2 = 1 AND POINT(xkprojectie, ykprojectie) >= 200 AND POINT(xkprojectie, ykprojectie) <= 217 AND EaE2 = 0 THEN
                EaE2 = 1
                score& = score& + 2000: _SNDPLAYCOPY Bonus6&
            END IF
            sxk#(akn) = 0: syk#(akn) = 0: szk#(akn) = 0: schietstatus(akn) = 0: yk#(akn) = 0
        END IF
        IF gunkogelafstand# < maxkogelweg# / 2 THEN
            LINE (xkprojectie, ykprojectie)-(xkprojectie + 1, ykprojectie + 1), 8, BF
        ELSE
            PSET (xkprojectie, ykprojectie), 8
        END IF

    END IF
NEXT
'*****************************************************************************
'                                                   ENEMY BULLETS
'
FOR AEN = 1 TO NumberOfEnemiesActive
    DistancePlayerEnemy = SQR((xc0# - vijanddx#(AEN)) ^ 2 + (yc0# - vijanddy#(AEN)) ^ 2 + (zc0# - vijanddz#(AEN)) ^ 2)
    SELECT CASE vijandType(AEN)
        CASE 2 '                                                    SPORTSCAR
            Grens = 800 'FT
            IF DistancePlayerEnemy <= Grens THEN
                raakkans = 800 * (DistancePlayerEnemy / Grens) * RND
                IF raakkans <= 2 THEN
                    IF devmode = 0 THEN _SNDPLAYCOPY HitPlay&: PlayerDamage = PlayerDamage + 1: flits = 1
                END IF
            END IF
        CASE 3 '                                                    JEEP
            Grens = 1200 'FT
            IF DistancePlayerEnemy <= Grens THEN
                raakkans = 200 * (DistancePlayerEnemy / Grens) * RND
                IF raakkans <= 2 THEN
                    IF devmode = 0 THEN _SNDPLAYCOPY HitPlay&: PlayerDamage = PlayerDamage + 1: flits = 1
                END IF
            END IF
        CASE 4 '                                                    TANK
            Grens = 1500 'FT
            IF DistancePlayerEnemy <= Grens THEN
                raakkans = 140 * (DistancePlayerEnemy / Grens) * RND
                IF raakkans <= 3 THEN
                    IF devmode = 0 THEN _SNDPLAYCOPY HitPlay&: PlayerDamage = PlayerDamage + 2: flits = 1
                END IF
            END IF
        CASE 1 '                                                    SUPPLY TRUCK
    END SELECT
NEXT
'  DAMAGE Gevolgen ********************************************************
IF PlayerDamage >= 100 THEN
    IF SchadeTailRotor = 1 AND SchadeFuel = 1 THEN Totalloss = 1
    IF SchadeTailRotor = 1 THEN SchadeFuel = 1
    IF SchadeFuel = 1 THEN SchadeTailRotor = 1
    SchadeType = INT(2 * RND)
    SELECT CASE SchadeType
        CASE 0
            SchadeTailRotor = 1
        CASE 1
            SchadeFuel = 1
    END SELECT
    PlayerDamage = 0
END IF
IF DamSound = 0 AND (SchadeTailRotor = 1 OR SchadeFuel = 1) THEN _SNDLOOP Damage&: DamSound = 1
IF SchadeTailRotor = 0 AND SchadeFuel = 0 THEN _SNDSTOP Damage&: DamSound = 0
'*****************************************************************************
'                                                 SCENE
FOR V = 0 TO k - 1
    jn0 = 0: jn1 = 0: jn2 = 0: jn3 = 0: jn4 = 0
    xp# = itmdx + itmscale * x#(V, 0): yp# = itmdy + itmscale * y#(V, 0): zp# = itmdz + itmscale * z#(V, 0): GOSUB bbd
    gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
    IF gridcolor < 100 THEN gridcolor = 100
    IF gridcolor > 163 THEN gridcolor = 163
    horhoek0# = horhoek#: verhoek0# = verhoek#
    xp# = itmdx + itmscale * x#(V, 1): yp# = itmdy + itmscale * y#(V, 1): zp# = itmdz + itmscale * z#(V, 1): GOSUB bbd
    horhoek1# = horhoek#: verhoek1# = verhoek#
    xp# = itmdx + itmscale * x#(V, 2): yp# = itmdy + itmscale * y#(V, 2): zp# = itmdz + itmscale * z#(V, 2): GOSUB bbd
    horhoek2# = horhoek#: verhoek2# = verhoek#
    xp# = itmdx + itmscale * x#(V, 3): yp# = itmdy + itmscale * y#(V, 3): zp# = itmdz + itmscale * z#(V, 3): GOSUB bbd
    horhoek3# = horhoek#: verhoek3# = verhoek#
    xp# = itmdx + itmscale * x#(V, 4): yp# = itmdy + itmscale * y#(V, 4): zp# = itmdz + itmscale * z#(V, 4): GOSUB bbd
    horhoek4# = horhoek#: verhoek4# = verhoek#
    qx# = 400 + schaalx# * pf# * horhoek0#
    qy# = 225 - schaaly# * pf# * verhoek0#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xkprojectie0 = qx#: ykprojectie0 = qy#: jn0 = 1
    END IF
    qx# = 400 + schaalx# * pf# * horhoek1#
    qy# = 225 - schaaly# * pf# * verhoek1#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xkprojectie1 = qx#: ykprojectie1 = qy#: jn1 = 1
    END IF
    qx# = 400 + schaalx# * pf# * horhoek2#
    qy# = 225 - schaaly# * pf# * verhoek2#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xkprojectie2 = qx#: ykprojectie2 = qy#: jn2 = 1
    END IF
    qx# = 400 + schaalx# * pf# * horhoek3#
    qy# = 225 - schaaly# * pf# * verhoek3#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xkprojectie3 = qx#: ykprojectie3 = qy#: jn3 = 1
    END IF
    qx# = 400 + schaalx# * pf# * horhoek4#
    qy# = 225 - schaaly# * pf# * verhoek4#
    khoek# = kantel# * 3: GOSUB kantel
    IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
        xkprojectie4 = qx#: ykprojectie4 = qy#: jn4 = 1
    END IF
    IF jn0 = 1 AND jn1 = 1 AND jn2 = 1 AND jn3 = 1 AND jn4 = 1 AND gridcolor > 100 THEN
        LINE (xkprojectie1, ykprojectie1)-(xkprojectie2, ykprojectie2), gridcolor
        LINE (xkprojectie2, ykprojectie2)-(xkprojectie3, ykprojectie3), gridcolor
        LINE (xkprojectie3, ykprojectie3)-(xkprojectie4, ykprojectie4), gridcolor
        LINE (xkprojectie4, ykprojectie4)-(xkprojectie1, ykprojectie1), gridcolor
    END IF
NEXT

'*****************************************************************************
'                                             PERSONS

'af:       ANIMATIEFRAME DRENKELING 1-4
animatieteller = animatieteller + 1
IF animatieteller = 20 THEN af = af + 1: animatieteller = 0
IF af = 5 THEN af = 1
TotalPersonsRescued = 0
FOR persoonnummer = 1 TO waypoints

    IF rescue(persoonnummer) = 0 THEN

        'teken persoon persoonnummer
        persoondx# = xwp#(persoonnummer)
        persoondy# = ywp#(persoonnummer)
        persoondz# = zwp#(persoonnummer)
        FOR pV = 0 TO apv - 1
            jn0 = 0: jn1 = 0: jn2 = 0: jn3 = 0: jn4 = 0
            xp# = persoondx# + itmscale * xlp0#(af, pV): yp# = persoondy# + itmscale * ylp0#(af, pV): zp# = persoondz# + itmscale * zlp0#(af, pV): GOSUB bbd
            gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
            IF gridcolor < 100 THEN gridcolor = 100
            IF gridcolor > 163 THEN gridcolor = 163
            horhoek0# = horhoek#: verhoek0# = verhoek#
            xp# = persoondx# + itmscale * xlp1#(af, pV): yp# = persoondy# + itmscale * ylp1#(af, pV): zp# = persoondz# + itmscale * zlp1#(af, pV): GOSUB bbd
            horhoek1# = horhoek#: verhoek1# = verhoek#
            xp# = persoondx# + itmscale * xlp2#(af, pV): yp# = persoondy# + itmscale * ylp2#(af, pV): zp# = persoondz# + itmscale * zlp2#(af, pV): GOSUB bbd
            horhoek2# = horhoek#: verhoek2# = verhoek#
            xp# = persoondx# + itmscale * xlp3#(af, pV): yp# = persoondy# + itmscale * ylp3#(af, pV): zp# = persoondz# + itmscale * zlp3#(af, pV): GOSUB bbd
            horhoek3# = horhoek#: verhoek3# = verhoek#
            xp# = persoondx# + itmscale * xlp4#(af, pV): yp# = persoondy# + itmscale * ylp4#(af, pV): zp# = persoondz# + itmscale * zlp4#(af, pV): GOSUB bbd
            horhoek4# = horhoek#: verhoek4# = verhoek#
            qx# = 400 + schaalx# * pf# * horhoek0#
            qy# = 225 - schaaly# * pf# * verhoek0#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie0 = qx#: ykprojectie0 = qy#: jn0 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek1#
            qy# = 225 - schaaly# * pf# * verhoek1#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie1 = qx#: ykprojectie1 = qy#: jn1 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek2#
            qy# = 225 - schaaly# * pf# * verhoek2#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie2 = qx#: ykprojectie2 = qy#: jn2 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek3#
            qy# = 225 - schaaly# * pf# * verhoek3#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie3 = qx#: ykprojectie3 = qy#: jn3 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek4#
            qy# = 225 - schaaly# * pf# * verhoek4#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie4 = qx#: ykprojectie4 = qy#: jn4 = 1
            END IF
            IF jn0 = 1 AND jn1 = 1 AND jn2 = 1 AND jn3 = 1 AND jn4 = 1 AND gridcolor > 100 THEN
                LINE (xkprojectie1, ykprojectie1)-(xkprojectie2, ykprojectie2), gridcolor
                LINE (xkprojectie2, ykprojectie2)-(xkprojectie3, ykprojectie3), gridcolor
                LINE (xkprojectie3, ykprojectie3)-(xkprojectie4, ykprojectie4), gridcolor
                LINE (xkprojectie4, ykprojectie4)-(xkprojectie1, ykprojectie1), gridcolor
            END IF
        NEXT pV
    ELSE
        TotalPersonsRescued = TotalPersonsRescued + 1
    END IF
NEXT
'*****************************************************************************
'                                             REMOTE OBJECTS (TREES, ROCKS, ETC.)
FOR objectnummer = 1 TO AantalObjecten
    IF ObjectYesNo(objectnummer) = 1 THEN
        FOR V = 0 TO aov - 1
            jn0 = 0: jn1 = 0: jn2 = 0: jn3 = 0: jn4 = 0
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 0): yp# = objectdy#(objectnummer) + itmscale * yobject#(objectnummer, V, 0): zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 0): GOSUB bbd
            gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
            IF gridcolor < 100 THEN gridcolor = 100
            IF gridcolor > 163 THEN gridcolor = 163
            horhoek0# = horhoek#: verhoek0# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 1): yp# = objectdy#(objectnummer) + itmscale * yobject#(objectnummer, V, 1): zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 1): GOSUB bbd
            horhoek1# = horhoek#: verhoek1# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 2): yp# = objectdy#(objectnummer) + itmscale * yobject#(objectnummer, V, 2): zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 2): GOSUB bbd
            horhoek2# = horhoek#: verhoek2# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 3): yp# = objectdy#(objectnummer) + itmscale * yobject#(objectnummer, V, 3): zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 3): GOSUB bbd
            horhoek3# = horhoek#: verhoek3# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 4): yp# = objectdy#(objectnummer) + itmscale * yobject#(objectnummer, V, 4): zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 4): GOSUB bbd
            horhoek4# = horhoek#: verhoek4# = verhoek#
            qx# = 400 + schaalx# * pf# * horhoek0#
            qy# = 225 - schaaly# * pf# * verhoek0#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie0 = qx#: ykprojectie0 = qy#: jn0 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek1#
            qy# = 225 - schaaly# * pf# * verhoek1#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie1 = qx#: ykprojectie1 = qy#: jn1 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek2#
            qy# = 225 - schaaly# * pf# * verhoek2#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie2 = qx#: ykprojectie2 = qy#: jn2 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek3#
            qy# = 225 - schaaly# * pf# * verhoek3#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie3 = qx#: ykprojectie3 = qy#: jn3 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek4#
            qy# = 225 - schaaly# * pf# * verhoek4#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie4 = qx#: ykprojectie4 = qy#: jn4 = 1
            END IF
            IF jn0 = 1 AND jn1 = 1 AND jn2 = 1 AND jn3 = 1 AND jn4 = 1 AND gridcolor > 100 THEN
                LINE (xkprojectie1, ykprojectie1)-(xkprojectie2, ykprojectie2), gridcolor
                LINE (xkprojectie2, ykprojectie2)-(xkprojectie3, ykprojectie3), gridcolor
                LINE (xkprojectie3, ykprojectie3)-(xkprojectie4, ykprojectie4), gridcolor
                LINE (xkprojectie4, ykprojectie4)-(xkprojectie1, ykprojectie1), gridcolor
            END IF
        NEXT
    ELSE
        ' OP DE GROND, Geraakt, y = 0
        FOR V = 0 TO aov - 1
            jn0 = 0: jn1 = 0: jn2 = 0: jn3 = 0: jn4 = 0
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 0): yp# = 0: zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 0): GOSUB bbd
            gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
            IF gridcolor < 100 THEN gridcolor = 100
            IF gridcolor > 163 THEN gridcolor = 163
            horhoek0# = horhoek#: verhoek0# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 1): yp# = 0: zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 1): GOSUB bbd
            horhoek1# = horhoek#: verhoek1# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 2): yp# = 0: zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 2): GOSUB bbd
            horhoek2# = horhoek#: verhoek2# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 3): yp# = 0: zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 3): GOSUB bbd
            horhoek3# = horhoek#: verhoek3# = verhoek#
            xp# = objectdx#(objectnummer) + itmscale * xobject#(objectnummer, V, 4): yp# = 0: zp# = objectdz#(objectnummer) + itmscale * zobject#(objectnummer, V, 4): GOSUB bbd
            horhoek4# = horhoek#: verhoek4# = verhoek#
            qx# = 400 + schaalx# * pf# * horhoek0#
            qy# = 225 - schaaly# * pf# * verhoek0#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie0 = qx#: ykprojectie0 = qy#: jn0 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek1#
            qy# = 225 - schaaly# * pf# * verhoek1#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie1 = qx#: ykprojectie1 = qy#: jn1 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek2#
            qy# = 225 - schaaly# * pf# * verhoek2#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie2 = qx#: ykprojectie2 = qy#: jn2 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek3#
            qy# = 225 - schaaly# * pf# * verhoek3#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie3 = qx#: ykprojectie3 = qy#: jn3 = 1
            END IF
            qx# = 400 + schaalx# * pf# * horhoek4#
            qy# = 225 - schaaly# * pf# * verhoek4#
            khoek# = kantel# * 3: GOSUB kantel
            IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
                xkprojectie4 = qx#: ykprojectie4 = qy#: jn4 = 1
            END IF
            IF jn0 = 1 AND jn1 = 1 AND jn2 = 1 AND jn3 = 1 AND jn4 = 1 AND gridcolor > 100 THEN
                LINE (xkprojectie1, ykprojectie1)-(xkprojectie2, ykprojectie2), gridcolor
                LINE (xkprojectie2, ykprojectie2)-(xkprojectie3, ykprojectie3), gridcolor
                LINE (xkprojectie3, ykprojectie3)-(xkprojectie4, ykprojectie4), gridcolor
                LINE (xkprojectie4, ykprojectie4)-(xkprojectie1, ykprojectie1), gridcolor
            END IF
        NEXT

    END IF
NEXT
'*****************************************************************************
'                                       ROTOR BLADES
IF ShowBlades = 1 THEN
    'CIRCLE (400, -100), 600, Rotorcolor, 3.2, 6.2, .25
    SELECT CASE Blade
        CASE 0: LINE (600, 0)-(800, 12), Rotorcolor: LINE (0, 12)-(25, 21), Rotorcolor
        CASE 1: LINE (550, 0)-(700, 29), Rotorcolor: LINE -(725, 25), Rotorcolor
        CASE 2: LINE (500, 0)-(600, 41), Rotorcolor: LINE -(625, 38), Rotorcolor
        CASE 3: LINE (450, 0)-(500, 48), Rotorcolor: LINE -(525, 47), Rotorcolor
        CASE 4: LINE (400, 0)-(400, 50), Rotorcolor: LINE -(425, 50), Rotorcolor
        CASE 5: LINE (350, 0)-(300, 48), Rotorcolor: LINE -(325, 49), Rotorcolor
        CASE 6: LINE (300, 0)-(200, 41), Rotorcolor: LINE -(225, 43), Rotorcolor
        CASE 7: LINE (250, 0)-(100, 29), Rotorcolor: LINE -(125, 32), Rotorcolor
        CASE 8: LINE (200, 0)-(0, 12), Rotorcolor: LINE -(25, 17), Rotorcolor
    END SELECT
    IF bladesturn$ = "on" THEN Blade = Blade + 1
    IF Blade = 9 THEN Blade = 0
END IF
'*****************************************************************************
'                                       ENEMY-MOVEMENT AND DAMAGE-COUNTER
'
FOR AEN = 1 TO NumberOfEnemiesActive

    IF devmode = 0 THEN 'QWERTY
        vijanddx#(AEN) = vijanddx#(AEN) + sxvijand#(AEN)
        vijanddy#(AEN) = vijanddy#(AEN) + syvijand#(AEN)
        vijanddz#(AEN) = vijanddz#(AEN) + szvijand#(AEN)
        xITMZwaartepunt#(AEN) = xITMZwaartepunt#(AEN) + sxvijand#(AEN)
        yITMZwaartepunt#(AEN) = yITMZwaartepunt#(AEN) + syvijand#(AEN)
        zITMZwaartepunt#(AEN) = zITMZwaartepunt#(AEN) + szvijand#(AEN)
    END IF
    xp# = xITMZwaartepunt#(AEN)
    yp# = yITMZwaartepunt#(AEN)
    zp# = zITMZwaartepunt#(AEN)
    jndamage(AEN) = 0
    GOSUB bbd
    '
    qx# = 400 + schaalx# * pf# * horhoek#
    qy# = 225 - schaaly# * pf# * verhoek# '225 was 300
    khoek# = kantel# * 3: GOSUB kantel
    'IF qx# >= -20 AND qx# <= 819 AND qy# - DamageTextElevation >= -20 AND qy# - DamageTextElevation <= 469 THEN
    dx = qx#
    dy = yU(AEN) - DamageTextElevation: jndamage(AEN) = 1
    'END IF
    IF jndamage(AEN) = 1 AND enemydamage(AEN) < 100 AND enemydamage(AEN) > 0 AND firstTimeWarnNOT(AEN) = 1 THEN
        IF enemydamage(AEN) > 100 THEN EenemyDamage(AEN) = 100
        waarde$ = STR$(100 - enemydamage(AEN)) + "%"
        GOSUB PlaatsTekstCentered
    END IF
    '                                                    ENEMY

    yU(AEN) = 600 'voorlopige y-waarde Elevation

    FOR V = 0 TO l(AEN) - 1
        jn0 = 0: jn1 = 0: jn2 = 0: jn3 = 0: jn4 = 0
        xp# = vijanddx#(AEN) + itmscale * xvijand#(AEN, V, 0): yp# = vijanddy#(AEN) + itmscale * yvijand#(AEN, V, 0): zp# = vijanddz#(AEN) + itmscale * zvijand#(AEN, V, 0): GOSUB bbd
        gridcolor = 163 - INT((SQR((xc0# - xp#) ^ 2 + (yc0# - yp#) ^ 2 + (zc0# - zp#) ^ 2)) / 40)
        IF gridcolor < 100 THEN gridcolor = 100
        IF gridcolor > 163 THEN gridcolor = 163
        horhoek0# = horhoek#: verhoek0# = verhoek#
        xp# = vijanddx#(AEN) + itmscale * xvijand#(AEN, V, 1): yp# = vijanddy#(AEN) + itmscale * yvijand#(AEN, V, 1): zp# = vijanddz#(AEN) + itmscale * zvijand#(AEN, V, 1): GOSUB bbd
        horhoek1# = horhoek#: verhoek1# = verhoek#
        xp# = vijanddx#(AEN) + itmscale * xvijand#(AEN, V, 2): yp# = vijanddy#(AEN) + itmscale * yvijand#(AEN, V, 2): zp# = vijanddz#(AEN) + itmscale * zvijand#(AEN, V, 2): GOSUB bbd
        horhoek2# = horhoek#: verhoek2# = verhoek#
        xp# = vijanddx#(AEN) + itmscale * xvijand#(AEN, V, 3): yp# = vijanddy#(AEN) + itmscale * yvijand#(AEN, V, 3): zp# = vijanddz#(AEN) + itmscale * zvijand#(AEN, V, 3): GOSUB bbd
        horhoek3# = horhoek#: verhoek3# = verhoek#
        xp# = vijanddx#(AEN) + itmscale * xvijand#(AEN, V, 4): yp# = vijanddy#(AEN) + itmscale * yvijand#(AEN, V, 4): zp# = vijanddz#(AEN) + itmscale * zvijand#(AEN, V, 4): GOSUB bbd
        horhoek4# = horhoek#: verhoek4# = verhoek#
        qx# = 400 + schaalx# * pf# * horhoek0#
        qy# = 225 - schaaly# * pf# * verhoek0#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie0 = qx#: ykprojectie0 = qy#: jn0 = 1
        END IF
        qx# = 400 + schaalx# * pf# * horhoek1#
        qy# = 225 - schaaly# * pf# * verhoek1#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie1 = qx#: ykprojectie1 = qy#: jn1 = 1
        END IF
        qx# = 400 + schaalx# * pf# * horhoek2#
        qy# = 225 - schaaly# * pf# * verhoek2#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie2 = qx#: ykprojectie2 = qy#: jn2 = 1
        END IF
        qx# = 400 + schaalx# * pf# * horhoek3#
        qy# = 225 - schaaly# * pf# * verhoek3#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie3 = qx#: ykprojectie3 = qy#: jn3 = 1
        END IF
        qx# = 400 + schaalx# * pf# * horhoek4#
        qy# = 225 - schaaly# * pf# * verhoek4#
        khoek# = kantel# * 3: GOSUB kantel
        IF qx# >= 0 AND qx# <= 799 AND qy# >= 0 AND qy# <= 449 THEN
            xkprojectie4 = qx#: ykprojectie4 = qy#: jn4 = 1
        END IF
        IF jn0 = 1 AND jn1 = 1 AND jn2 = 1 AND jn3 = 1 AND jn4 = 1 AND gridcolor > 100 THEN
            LINE (xkprojectie1, ykprojectie1)-(xkprojectie2, ykprojectie2), gridcolor
            LINE (xkprojectie2, ykprojectie2)-(xkprojectie3, ykprojectie3), gridcolor
            LINE (xkprojectie3, ykprojectie3)-(xkprojectie4, ykprojectie4), gridcolor
            LINE (xkprojectie4, ykprojectie4)-(xkprojectie1, ykprojectie1), gridcolor
        END IF
        '   Aanpassen grens Elevation
        IF ykprojectie0 < yU(AEN) THEN yU(AEN) = ykprojectie0
        IF ykprojectie1 < yU(AEN) THEN yU(AEN) = ykprojectie1
        IF ykprojectie2 < yU(AEN) THEN yU(AEN) = ykprojectie2
        IF ykprojectie3 < yU(AEN) THEN yU(AEN) = ykprojectie3
        IF ykprojectie4 < yU(AEN) THEN yU(AEN) = ykprojectie4
    NEXT
NEXT AEN
'*****************************************************************************
'                                           CROSSHAIR

'Horizontaal
LINE (393, 225)-(398, 225), 15
LINE (402, 225)-(407, 225), 15

'Verticaal
LINE (400, 223)-(400, 218), 15
LINE (400, 227)-(400, 232), 15


'*****************************************************************************
'                                               HUD    + Geluidjes (blades en schade)
GOSUB gumviewTekenHud
'*****SOMMIGE DINGEN VOOR LANDCHECK
IF status$ = "LANDED" AND afstand# < landingstolerantie# THEN
    IF fuel# < fuelmax# THEN GOSUB fuelplus
    IF didammo = 0 THEN didammo = 1: GOSUB VulWapensAan

    IF TotalPersonsRescued = ToBeRescued THEN '
        score& = score& + 5000
        _SNDPLAYCOPY Bonus4& '
        GOSUB LoadRescues
        TotalPersonsRescued = 0
        FOR apsn = 1 TO waypoints
            rescue(apsn) = 0
        NEXT
        rescue(0) = 1
        TempSec& = 0
    END IF
END IF

IF status$ <> "LANDED" THEN
    didammo = 0
    GOSUB fuelmin
    'ROTORSOUND MAAKT ENKEL GELUID ALS status$ <> "LANDED"
    IF rsf = 0 THEN _SNDLOOP Blades&: rsf = 1: bladesturn$ = "on"
ELSE
    IF rsf = 1 AND fuel# <= 0 THEN _SNDSTOP Blades&: bladesturn$ = "off": rsf = 0
    '**************
END IF

'*****************************************************************************
'                                               BESTURING
_DISPLAY


IF gameover = 1 GOTO gameover 'Pas naar gameover na ververst scherm

Mouse 3

IF UCASE$(i$) = "M" THEN GOSUB map '
IF UCASE$(i$) = "R" THEN ShowRescue = 1
IF UCASE$(i$) = "F" THEN GOSUB swapFPSShow
IF DonderOp = 1 THEN Exit$ = " ": gameover = 1
IF BMuis <> 0 THEN gameover = 1
IF i$ = CHR$(27) OR i$ = " " THEN Exit$ = "- ABORTED -": gameover = 1 '!@#
IF Totalloss = 1 THEN gameover = 1

'********************************************************************************
' Voorwaarde INVASIE (xITMZwaartepunt#,...,zITMZwaartepunt#)   en   (0,...,0)
FOR AEN = 1 TO NumberOfEnemiesActive
    d& = SQR(xITMZwaartepunt#(AEN) ^ 2 + zITMZwaartepunt#(AEN) ^ 2)
    IF d& < 24 AND vijandType(AEN) <> 1 THEN Exit$ = "- YOUR BASE HAS BEEN OVERRUN -": gameover = 1
    IF d& < 24 AND vijandType(AEN) = 1 GOTO Delivered
NEXT

' ********************************************************************************
IF Speedcrash = 1 THEN
    Exit$ = "- YOU CRASHED -": gameover = 1
END IF
IF Kantelcrash = 1 THEN
    Exit$ = "- YOU CRASHED -": gameover = 1: Kantelcrash = 0
END IF
'********************************************************************************



IF vertraging = 1 THEN _DELAY (DelayTime#)
IF flits = 0 THEN
    CLS
ELSE
    LINE (0, 0)-(799, 449), 131, BF: 'de grote gummer
    flits = 0
END IF

rescue(0) = 1
FOR altwaypoint = 0 TO waypoints
    afstandwp#(altwaypoint) = SQR((xc0# - xwp#(altwaypoint)) ^ 2 + (zc0# - zwp#(altwaypoint)) ^ 2)
    IF afstandwp#(altwaypoint) < waypointstolerantie# AND status$ = "LANDED" AND rescue(altwaypoint) = 0 THEN
        rescue(altwaypoint) = 1
        score& = score& + 1000
        _SNDPLAYCOPY Rescue&
        ShowRescue = 1
    END IF
NEXT

'
IF TypeObjecten MOD 2 = 0 AND INT(xc0#) = 1313 AND INT(zc0#) = 1313 AND EaE1 = 0 THEN EaE1 = 1: score& = score& + 5000: _SNDPLAYCOPY Bonus5&

frames = frames + 1
IF frames > 999 THEN frames = 0
GOTO startlabel
'*****************************************************************************
'*****************************************************************************
'
'   Fuel reeds afgewikkeld, nu de wapens
VulWapensAan:
IF BaseBullets >= 1200 THEN
    NumberOfBullets = 1200
    BaseBullets = BaseBullets - 1200
    ammo = NumberOfBullets
END IF
RETURN


gameover:

_SNDSTOP Damage&
_SNDSTOP Blades&
bladesturn$ = "off"
CLOSE #1 'QWEQWE
_SNDPLAYCOPY Fail&
_MOUSESHOW
x1 = 255: y1 = 115: x2 = 544: y2 = 319: GOSUB TekenBlok
x1 = 260: y1 = 120: x2 = 539: y2 = 314: GOSUB TekenGat
waarde$ = "END OF REPLAY": dx = 400: dy = 130: GOSUB PlaatsTekstCentered
waarde$ = "---------------------------------------": dx = 400: dy = 140: GOSUB PlaatsTekstCentered
IF Exit$ = "" THEN Exit$ = "- TOTAL LOSS -" '!@#
waarde$ = Exit$: dx = 400: dy = 210: GOSUB PlaatsTekstCentered '     210 was 170
_DISPLAY
WHILE INKEY$ <> "": WEND
_DELAY 2
GOTO ExitMenu
'**************************************************************************


Delivered:
'
_SNDPLAYCOPY Dingdong&
BaseFuel = BaseFuel + TransportFuel
BaseBullets = BaseBullets + TransportBullets
GOSUB NextEnemy '
TIMER ON
ShowCargo = 1
GOTO startlabel


ExtraLabel:
WHILE BMuis <> 0
    _LIMIT OverallFramerate
    Mouse 3
WEND
didammo = 0 '              Check opnieuw de stash
GOTO startlabel

NextEnemy:
level = level + 1 '! Level is niet het rescuelevel maar het voertuignummer,  rescuelevel = RFileNr  !!!!!
firstTimeWarnNOT(AEN) = 0 'RESET RADAR STIP OP 'NOOIT GEZIEN '
'
vijanddx#(AEN) = 0
vijanddy#(AEN) = 0
vijanddz#(AEN) = 0

Herstel:

INPUT #7, vijandType(AEN), hoek(AEN), VijandAfstand#(AEN), VijandSpeed#(AEN)
VijandHoek#(AEN) = (90 - hoek(AEN)) / (180 / pi#)


IF vijandType(AEN) = 1 THEN
    INPUT #7, TransportFuel, TransportBullets
END IF

IF vijandType(AEN) = 99 THEN
    CLOSE #7
    Exit$ = "- CONGRATULATIONS! -": gameover = 1
END IF

SELECT CASE vijandType(AEN) '
    CASE 2 'SPORTSCAR
        RadarDotType(AEN) = 1 '***************** 1 is enemy, 0 is friend
        SELECT CASE fastslow$
            CASE "FASTCPU": vijand$(AEN) = "ENEMY02.ITM": HitAfstand#(AEN) = HitBallSportscar: enemydamage(AEN) = 0 ' HitAfstand#(AEN) is de hitboxgrootte
            CASE "SLOWCPU": vijand$(AEN) = "ENEMY02A.ITM": HitAfstand#(AEN) = HitBallSportscar: enemydamage(AEN) = 0
        END SELECT
    CASE 3 'JEEP
        RadarDotType(AEN) = 1
        SELECT CASE fastslow$
            CASE "FASTCPU": vijand$(AEN) = "ENEMY03.ITM": HitAfstand#(AEN) = HitBallJeep: enemydamage(AEN) = 0
            CASE "SLOWCPU": vijand$(AEN) = "ENEMY03A.ITM": HitAfstand#(AEN) = HitBallJeep: enemydamage(AEN) = 0
        END SELECT
    CASE 4 'TANK
        RadarDotType(AEN) = 1

        '
        _SNDPLAYCOPY Theme&

        SELECT CASE fastslow$
            CASE "FASTCPU": vijand$(AEN) = "ENEMY04.ITM": HitAfstand#(AEN) = HitBallTank: enemydamage(AEN) = 0
            CASE "SLOWCPU": vijand$(AEN) = "ENEMY04A.ITM": HitAfstand#(AEN) = HitBallTank: enemydamage(AEN) = 0
        END SELECT
    CASE 1 'SUPPLY TRUCK
        RadarDotType(AEN) = 0
        SELECT CASE fastslow$
            CASE "FASTCPU": vijand$(AEN) = "ENEMY01.ITM": HitAfstand#(AEN) = HitBallSupplytruck: enemydamage(AEN) = 0
            CASE "SLOWCPU": vijand$(AEN) = "ENEMY01A.ITM": HitAfstand#(AEN) = HitBallSupplytruck: enemydamage(AEN) = 0
        END SELECT
END SELECT

vijanddx#(AEN) = VijandAfstand#(AEN) * COS(VijandHoek#(AEN))
vijanddy#(AEN) = 0
vijanddz#(AEN) = VijandAfstand#(AEN) * SIN(VijandHoek#(AEN))

sxvijand#(AEN) = -VijandSpeed#(AEN) * COS(VijandHoek#(AEN))
syvijand#(AEN) = 0
szvijand#(AEN) = -VijandSpeed#(AEN) * SIN(VijandHoek#(AEN))

GOSUB loadvijand

'ROTEER VIJAND

xb# = xITMZwaartepunt#(AEN)
yb# = yITMZwaartepunt#(AEN)
zb# = zITMZwaartepunt#(AEN)


FOR vn = 0 TO l(AEN) - 1
    FOR pn = 0 TO 4 '
        hs# = -VijandHoek#(AEN)
        xa# = itmscale * xvijand#(AEN, vn, pn): ya# = itmscale * yvijand#(AEN, vn, pn): za# = itmscale * zvijand#(AEN, vn, pn)
        GOSUB DraaiY
        xvijand#(AEN, vn, pn) = xa# / itmscale: yvijand#(AEN, vn, pn) = ya# / itmscale: zvijand#(AEN, vn, pn) = za# / itmscale
    NEXT
NEXT
xITMZwaartepunt#(AEN) = 0
yITMZwaartepunt#(AEN) = 0
zITMZwaartepunt#(AEN) = 0
FOR vn = 0 TO l(AEN) - 1
    xITMZwaartepunt#(AEN) = xITMZwaartepunt#(AEN) + xvijand#(AEN, vn, 0)
    yITMZwaartepunt#(AEN) = yITMZwaartepunt#(AEN) + yvijand#(AEN, vn, 0)
    zITMZwaartepunt#(AEN) = zITMZwaartepunt#(AEN) + zvijand#(AEN, vn, 0)
NEXT
xITMZwaartepunt#(AEN) = vijanddx#(AEN) + itmscale * (xITMZwaartepunt#(AEN) / l(AEN))
yITMZwaartepunt#(AEN) = vijanddy#(AEN) + itmscale * (yITMZwaartepunt#(AEN) / l(AEN))
zITMZwaartepunt#(AEN) = vijanddz#(AEN) + itmscale * (zITMZwaartepunt#(AEN) / l(AEN))
Wreck(AEN) = 0

RETURN

'****************************************8
loadvijand:
OPEN "..\ITMFiles\" + vijand$(AEN) FOR INPUT AS #3
INPUT #3, a$
INPUT #3, l(AEN)
FOR vn = 0 TO l(AEN) - 1
    FOR pn = 0 TO 4 '                                  pn=0  -->  zwaartepunt
        INPUT #3, xvijand#(AEN, vn, pn), yvijand#(AEN, vn, pn), zvijand#(AEN, vn, pn) ' 1-4   -->  hoekpunten
        xvijand#(AEN, vn, pn) = xvijand#(AEN, vn, pn) - xoffset#
        yvijand#(AEN, vn, pn) = yvijand#(AEN, vn, pn) - yoffset#
        zvijand#(AEN, vn, pn) = zvijand#(AEN, vn, pn) - zoffset#
    NEXT
    INPUT #3, kleurvijand(AEN, vn)
NEXT
INPUT #3, a$
CLOSE #3

xITMZwaartepunt#(AEN) = 0
yITMZwaartepunt#(AEN) = 0
zITMZwaartepunt#(AEN) = 0
FOR vn = 0 TO l(AEN) - 1
    xITMZwaartepunt#(AEN) = xITMZwaartepunt#(AEN) + xvijand#(AEN, vn, 0)
    yITMZwaartepunt#(AEN) = yITMZwaartepunt#(AEN) + yvijand#(AEN, vn, 0)
    zITMZwaartepunt#(AEN) = zITMZwaartepunt#(AEN) + zvijand#(AEN, vn, 0)
NEXT
xITMZwaartepunt#(AEN) = itmscale * (xITMZwaartepunt#(AEN) / l(AEN))
yITMZwaartepunt#(AEN) = itmscale * (yITMZwaartepunt#(AEN) / l(AEN))
zITMZwaartepunt#(AEN) = itmscale * (zITMZwaartepunt#(AEN) / l(AEN))

RETURN
'*************************************

ShowObjectsLeft:
ShowObjects = 1
RETURN

ShowController:
ShowController = 1
RETURN

loadperson:
FOR animatieframe = 1 TO 4
    animatiefile$ = "..\ITMFiles\PERSON" + LTRIM$(STR$(animatieframe)) + ".ITM"
    OPEN animatiefile$ FOR INPUT AS #10
    INPUT #10, a$
    INPUT #10, apv 'aantal person-vlakken
    FOR pvn = 0 TO apv - 1
        INPUT #10, xlp0#(animatieframe, pvn), ylp0#(animatieframe, pvn), zlp0#(animatieframe, pvn)
        INPUT #10, xlp1#(animatieframe, pvn), ylp1#(animatieframe, pvn), zlp1#(animatieframe, pvn)
        INPUT #10, xlp2#(animatieframe, pvn), ylp2#(animatieframe, pvn), zlp2#(animatieframe, pvn)
        INPUT #10, xlp3#(animatieframe, pvn), ylp3#(animatieframe, pvn), zlp3#(animatieframe, pvn)
        INPUT #10, xlp4#(animatieframe, pvn), ylp4#(animatieframe, pvn), zlp4#(animatieframe, pvn)
        INPUT #10, klp(animatieframe, pvn)
    NEXT
    INPUT #10, a$
    CLOSE #10
NEXT
RETURN


NewObjects:
TypeObjecten = TypeObjecten + 1
IF TypeObjecten = 4 THEN TypeObjecten = 1

object$ = "OBJECT0" + LTRIM$(STR$(TypeObjecten)) + ".ITM"
IF TypeObjecten = 1 THEN ObjectHitBall = 10
IF TypeObjecten = 2 THEN ObjectHitBall = 16
IF TypeObjecten = 3 THEN ObjectHitBall = 12

OPEN "..\ITMFiles\" + object$ FOR INPUT AS #9
INPUT #9, a$
INPUT #9, aov 'aantal object-vlakken
FOR vn = 0 TO aov - 1
    INPUT #9, xlo0#(vn), ylo0#(vn), zlo0#(vn)
    INPUT #9, xlo1#(vn), ylo1#(vn), zlo1#(vn)
    INPUT #9, xlo2#(vn), ylo2#(vn), zlo2#(vn)
    INPUT #9, xlo3#(vn), ylo3#(vn), zlo3#(vn)
    INPUT #9, xlo4#(vn), ylo4#(vn), zlo4#(vn)
    INPUT #9, klo(vn)
NEXT
INPUT #9, a$
CLOSE #9
FOR obn = 1 TO AantalObjecten 'Roteren object
    hs# = 2 * pi# * RND
    xb# = 0: yb# = 0: zb# = 0
    FOR vn = 0 TO aov - 1
        xa# = xlo0#(vn): ya# = ylo0#(vn): za# = zlo0#(vn): GOSUB DraaiY: xlo0#(vn) = xa#: ylo0#(vn) = ya#: zlo0#(vn) = za#
        xa# = xlo1#(vn): ya# = ylo1#(vn): za# = zlo1#(vn): GOSUB DraaiY: xlo1#(vn) = xa#: ylo1#(vn) = ya#: zlo1#(vn) = za#
        xa# = xlo2#(vn): ya# = ylo2#(vn): za# = zlo2#(vn): GOSUB DraaiY: xlo2#(vn) = xa#: ylo2#(vn) = ya#: zlo2#(vn) = za#
        xa# = xlo3#(vn): ya# = ylo3#(vn): za# = zlo3#(vn): GOSUB DraaiY: xlo3#(vn) = xa#: ylo3#(vn) = ya#: zlo3#(vn) = za#
        xa# = xlo4#(vn): ya# = ylo4#(vn): za# = zlo4#(vn): GOSUB DraaiY: xlo4#(vn) = xa#: ylo4#(vn) = ya#: zlo4#(vn) = za#
    NEXT
    FOR vn = 0 TO aov - 1
        xobject#(obn, vn, 0) = xlo0#(vn): yobject#(obn, vn, 0) = ylo0#(vn): zobject#(obn, vn, 0) = zlo0#(vn)
        xobject#(obn, vn, 1) = xlo1#(vn): yobject#(obn, vn, 1) = ylo1#(vn): zobject#(obn, vn, 1) = zlo1#(vn)
        xobject#(obn, vn, 2) = xlo2#(vn): yobject#(obn, vn, 2) = ylo2#(vn): zobject#(obn, vn, 2) = zlo2#(vn)
        xobject#(obn, vn, 3) = xlo3#(vn): yobject#(obn, vn, 3) = ylo3#(vn): zobject#(obn, vn, 3) = zlo3#(vn)
        xobject#(obn, vn, 4) = xlo4#(vn): yobject#(obn, vn, 4) = ylo4#(vn): zobject#(obn, vn, 4) = zlo4#(vn)
        kleurobject(obn, vn) = klo(vn)
    NEXT
NEXT
FOR ojn = 1 TO AantalObjecten
    objectdx#(ojn) = -MaximaleObjectAfstand + 2 * MaximaleObjectAfstand * RND
    objectdy#(ojn) = 0
    objectdz#(ojn) = -MaximaleObjectAfstand + 2 * MaximaleObjectAfstand * RND
    ObjectYesNo(ojn) = 1
NEXT
ObjectsHit = 0
Bonus1 = 0
Bonus2 = 0
Bonus3 = 0
Bonus4 = 0
EaE1 = 0
EaE2 = 0
RETURN




landcheck:

xx1# = (xc3# + xc4#) / 2
zz1# = (zc3# + zc4#) / 2
afstand# = SQR((xx1# - xland#) ^ 2 + (zz1# - zland#) ^ 2)
IF status$ <> "CRASHED" THEN
    dx = 400: dy = 370: waarde$ = "LANDED": GOSUB PlaatsTekstCentered
    dx = 400: dy = 80: waarde$ = "KEEP THE MOUSE CURSOR NEAR THE CROSSHAIR": GOSUB PlaatsTekstCentered
    dx = 400: dy = 90: waarde$ = "AND HOLD LEFT MOUSEBUTTON": GOSUB PlaatsTekstCentered
    dx = 400: dy = 100: waarde$ = "FOR VERTICAL TAKE-OFF": GOSUB PlaatsTekstCentered
    dx = 400: dy = 110: waarde$ = "RELEASE TO LEVEL": GOSUB PlaatsTekstCentered
    dx = 400: dy = 120: waarde$ = "START DESCENDING WITH RIGHT MOUSEBUTTON": GOSUB PlaatsTekstCentered
    dx = 400: dy = 140: waarde$ = "PRESS \H\ FOR IN-GAME KEYS": GOSUB PlaatsTekstCentered
    dx = 400: dy = 150: waarde$ = "PRESS ESC TO ABORT GAME": GOSUB PlaatsTekstCentered
    dx = 200: dy = 15: waarde$ = UCASE$(Bestand$): GOSUB PlaatsTekstCentered
    w1$ = RIGHT$(STR$(tiles), LEN(STR$(tiles)) - 1) '
    WHILE LEN(w1$) < 5: w1$ = "0" + w1$: WEND
    waarde$ = w1$ + " TILES"
    dx = 600: dy = 15: GOSUB PlaatsTekstCentered
    status$ = "LANDED"
END IF
RETURN

linksrechts:
GOSUB bepalenkoers
hs# = var1# * camhoekspeed# * (1 - speedfactor#)
xb# = xc0#: yb# = yc0#: zb# = zc0#
xa# = xc1#: ya# = yc1#: za# = zc1#: GOSUB DraaiY: xc1# = xa#: yc1# = ya#: zc1# = za#
xa# = xc2#: ya# = yc1#: za# = zc2#: GOSUB DraaiY: xc2# = xa#: yc1# = ya#: zc2# = za#
xa# = xc3#: ya# = yc3#: za# = zc3#: GOSUB DraaiY: xc3# = xa#: yc3# = ya#: zc3# = za#
xa# = xc4#: ya# = yc3#: za# = zc4#: GOSUB DraaiY: xc4# = xa#: yc3# = ya#: zc4# = za#
xa# = xc5#: ya# = yc5#: za# = zc5#: GOSUB DraaiY: xc5# = xa#: yc5# = ya#: zc5# = za#
RETURN

omhoogomlaag:
GOSUB bepalenkoers
hs# = Koers#
xb# = xc0#: yb# = yc0#: zb# = zc0#
xa# = xc1#: ya# = yc1#: za# = zc1#: GOSUB DraaiY: xc1# = xa#: yc1# = ya#: zc1# = za#
xa# = xc2#: ya# = yc2#: za# = zc2#: GOSUB DraaiY: xc2# = xa#: yc2# = ya#: zc2# = za#
xa# = xc3#: ya# = yc3#: za# = zc3#: GOSUB DraaiY: xc3# = xa#: yc3# = ya#: zc3# = za#
xa# = xc4#: ya# = yc4#: za# = zc4#: GOSUB DraaiY: xc4# = xa#: yc4# = ya#: zc4# = za#
xa# = xc5#: ya# = yc5#: za# = zc5#: GOSUB DraaiY: xc5# = xa#: yc5# = ya#: zc5# = za#
hs# = SGN(xc2# - xc1#) * var2# * camhoekspeed#
helhoek# = helhoek# + hs#
'IF helhoek# <= -helgrensvooruit# THEN helhoek# = -helgrensvooruit#: hs# = 0 '
'IF helhoek# >= helgrensachteruit# THEN helhoek# = helgrensvooruit#: hs# = 0
IF helhoek# <= -helgrensvooruit# THEN helhoek# = helhoek# - hs#: hs# = 0 '
IF helhoek# >= helgrensachteruit# THEN helhoek# = helhoek# - hs#: hs# = 0

xb# = xc0#: yb# = yc0#: zb# = zc0#
xa# = xc1#: ya# = yc1#: za# = zc1#: GOSUB draaix: xc1# = xa#: yc1# = ya#: zc1# = za#
xa# = xc2#: ya# = yc2#: za# = zc2#: GOSUB draaix: xc2# = xa#: yc2# = ya#: zc2# = za#
xa# = xc3#: ya# = yc3#: za# = zc3#: GOSUB draaix: xc3# = xa#: yc3# = ya#: zc3# = za#
xa# = xc4#: ya# = yc4#: za# = zc4#: GOSUB draaix: xc4# = xa#: yc4# = ya#: zc4# = za#
xa# = xc5#: ya# = yc5#: za# = zc5#: GOSUB draaix: xc5# = xa#: yc5# = ya#: zc5# = za#
hs# = -Koers#
xb# = xc0#: yb# = yc0#: zb# = zc0#
xa# = xc1#: ya# = yc1#: za# = zc1#: GOSUB DraaiY: xc1# = xa#: yc1# = ya#: zc1# = za#
xa# = xc2#: ya# = yc2#: za# = zc2#: GOSUB DraaiY: xc2# = xa#: yc2# = ya#: zc2# = za#
xa# = xc3#: ya# = yc3#: za# = zc3#: GOSUB DraaiY: xc3# = xa#: yc3# = ya#: zc3# = za#
xa# = xc4#: ya# = yc4#: za# = zc4#: GOSUB DraaiY: xc4# = xa#: yc4# = ya#: zc4# = za#
xa# = xc5#: ya# = yc5#: za# = zc5#: GOSUB DraaiY: xc5# = xa#: yc5# = ya#: zc5# = za#
RETURN

vooruit:
spx# = ((xc0# - xc5#) / Zoom#) * camspeed# * speedfactor#
spz# = ((zc0# - zc5#) / Zoom#) * camspeed# * speedfactor#
xc1# = xc1# + spx#: xc2# = xc2# + spx#: xc3# = xc3# + spx#: xc4# = xc4# + spx#: xc5# = xc5# + spx#
zc1# = zc1# + spz#: zc2# = zc2# + spz#: zc3# = zc3# + spz#: zc4# = zc4# + spz#: zc5# = zc5# + spz#
RETURN

stijgendalen:
IF stijgkracht# > .15 THEN stijgkracht# = .15
IF stijgkracht# < -.15 THEN stijgkracht# = -.15
spy# = camspeed# * stijgkracht#
IF stijgkracht# <= .8 * os# AND stijgkracht# >= 0 THEN
    IF power$ = "on" AND levelhoogte$ = "off" THEN yl# = yc0#: mbh = 0: levelhoogte$ = "on"
END IF
yc1# = yc1# + spy#: yc2# = yc2# + spy#: yc3# = yc3# + spy#: yc4# = yc4# + spy#: yc5# = yc5# + spy#
RETURN

bepalenkoers:
IF xc2# > xc1# AND zc2# >= zc1# THEN Koers# = (ATN((zc2# - zc1#) / (xc2# - xc1#)))
IF xc2# < xc1# AND zc2# >= zc1# THEN Koers# = (pi# - ATN((zc2# - zc1#) / -(xc2# - xc1#)))
IF xc2# < xc1# AND zc2# < zc1# THEN Koers# = (pi# + ATN(-(zc2# - zc1#) / -(xc2# - xc1#)))
IF xc2# > xc1# AND zc2# < zc1# THEN Koers# = (2 * pi# - ATN(-(zc2# - zc1#) / (xc2# - xc1#)))
IF xc2# = xc1# AND zc2# >= zc1# THEN Koers# = (.5 * pi#)
IF xc2# = xc1# AND zc2# < zc1# THEN Koers# = (1.5 * pi#)
RETURN

gumviewTekenHud:

waarde$ = "WP " + RIGHT$(STR$(waypoint), LEN(STR$(waypoint)) - 1)
dx = 32: dy = 410: GOSUB PlaatsTekstCentered
waarde$ = RIGHT$(STR$(INT(afstandwp#(waypoint) / 10) * 10), LEN(STR$(afstandwp#(waypoint))) - 1) + " FT"
dx = 32: dy = 430: GOSUB PlaatsTekstCentered

IF FPSPrint = 1 THEN dx = 8: dy = 45: waarde$ = LTRIM$(STR$(framespark)) + " FPS": GOSUB PlaatsTekstLinksUitlijn

IF DevModePrint = 1 THEN dx = 8: dy = 35: waarde$ = "DEVMODE": GOSUB PlaatsTekstLinksUitlijn

IF DepotPrint = 1 THEN
    waarde$ = "DEPOT:": dx = 20: dy = 80: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = LTRIM$(STR$(BaseFuel)) + " GL": dx = 20: dy = 100: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = LTRIM$(STR$(BaseBullets)) + " RNDS": dx = 20: dy = 110: GOSUB PlaatsTekstLinksUitlijn
END IF

IF txt$(waypoint) <> "@" THEN dx = 10: dy = 540: waarde$ = txt$(waypoint): GOSUB PlaatsTekstLinksUitlijn
LINE (398, 16)-(402, 16), 15
LINE (400, 16)-(400, 12), 15
horizon = 225 + 576 * helhoek#
IF horizon <= 30 THEN
    LINE (390, 225)-(400, 215), 15
    LINE (400, 215)-(410, 225), 15
END IF
IF horizon >= 590 THEN
    LINE (390, 225)-(400, 235), 15
    LINE (400, 235)-(410, 225), 15
END IF
IF horizon > 30 AND horizon < 420 THEN
    LINE (398, horizon)-(402, horizon), 15
END IF
yh1 = ((18 * kantel# * pf#) + 10 * helhoek# * pf# + 240 + hh# * .1) + ABS(kantel# * 90) - (1 * yc0#)
yh2 = ((-18 * kantel# * pf#) + 10 * helhoek# * pf# + 240 + hh# * .1) + ABS(kantel# * 90) - (1 * yc0#)
yh3 = (yh1 + yh2) / 2
hh# = (yc0# * 5) - 2
dx = 513: dy = 370: waarde$ = STR$(INT(210 * speedfactor# * .54)) + " KTS": snelheid = VAL(waarde$)
GOSUB PlaatsTekstCentered


heading = 360 - INT(Koers# * pf#) MOD 360
waarde$ = LTRIM$(STR$(heading))
IF waarde$ = "360" THEN waarde$ = "0"
dx = 401: dy = 21: GOSUB PlaatsTekstCentered


IF INT(fuel#) <= 23 AND status$ <> "LANDED" THEN FuelLow = 1 ELSE FuelLow = 0
SELECT CASE FuelLow
    CASE 0
        waarde$ = STR$(INT(fuel#)) + " GL" '
        dx = 300: dy = 370: GOSUB PlaatsTekstCentered
    CASE 1
        KnipperTeller& = KnipperTeller& + 1
        IF KnipperTeller& > KnipperTellerMax& THEN SWAP Knipper1, Knipper2: KnipperTeller& = 0
        IF Knipper1 = 1 THEN
            waarde$ = STR$(INT(fuel#)) + " GL" '
            dx = 300: dy = 370: GOSUB PlaatsTekstCentered
        END IF
END SELECT

IF ammo < 100 THEN AmmoLow = 1 ELSE AmmoLow = 0
SELECT CASE AmmoLow
    CASE 0
        waarde$ = STR$(ammo) + " 30MM"
        dx = 300: dy = 410: GOSUB PlaatsTekstCentered
    CASE 1
        KnipperTellert& = KnipperTellert& + 1
        IF KnipperTellert& > KnipperTellerMax& THEN SWAP Knippert1, Knippert2: KnipperTellert& = 0
        IF Knippert1 = 1 THEN
            waarde$ = STR$(ammo) + " 30MM"
            dx = 300: dy = 410: GOSUB PlaatsTekstCentered
        END IF
END SELECT

SELECT CASE SchadeTailRotor
    CASE 0
    CASE 1
        KnipperTellerTR& = KnipperTellerTR& + 1
        IF KnipperTellerTR& > KnipperTellerMax& THEN SWAP KnipperTR1, KnipperTR2: KnipperTellerTR& = 0
        IF KnipperTR1 = 1 THEN
            waarde$ = "TAIL ROTOR"
            dx = 220: dy = 390: GOSUB PlaatsTekstCentered
        END IF
END SELECT
SELECT CASE SchadeFuel
    CASE 0
    CASE 1
        KnipperTellerFL& = KnipperTellerFL& + 1
        IF KnipperTellerFL& > KnipperTellerMax& THEN SWAP KnipperFL1, KnipperFL2: KnipperTellerFL& = 0
        IF KnipperFL1 = 1 THEN
            waarde$ = "FUEL LEAK"
            dx = 220: dy = 410: GOSUB PlaatsTekstCentered
        END IF
END SELECT


'
waarde$ = STR$(INT((hh# + 1) / 5) - ymin)
dx = 500: dy = 410: GOSUB PlaatsTekstCentered

IF hh# < 150 THEN
    yonder = 470 - (hh# / 1.5)
    IF yonder < 371 THEN yonder = 371
    IF yonder < 410 THEN LINE (468, yonder)-(470, 449), 15, BF ELSE LINE (468, yonder)-(470, 449), 8, BF
    LINE (467, 370)-(471, 450), 14, B
END IF

IF levelhoogte$ = "on" THEN LINE (484, 407)-(514, 419), 15, B

waarde$ = "FT"
dx = 528: dy = 410: GOSUB PlaatsTekstCentered
'
'  Grafisch Radar Blok
'
'


Anglecorrection# = .02
CIRCLE (740, 410), 32, 14
CIRCLE (740, 410), 16, 14
CIRCLE (740, 410), 64, 14, .25 * pi# + Anglecorrection#, .75 * pi# - Anglecorrection#
hoekje = hoekje - hoekjesstap
WHILE hoekje < 0: hoekje = hoekje + 360: WEND
LINE (740, 410)-(740 + straaltje * COS(hoekje / pf#), 410 - straaltje * SIN(hoekje / pf#)), 14
IF s1 = 1 THEN hoekje2 = hoekje2 + hoekjesstap
IF s1 = 0 THEN hoekje2 = hoekje2 - hoekjesstap
IF hoekje2 > 134 OR hoekje2 < 46 THEN SWAP s1, s0
LINE (740, 410)-(740 + straaltje2 * COS(hoekje2 / pf#), 410 - straaltje2 * SIN(hoekje2 / pf#)), 14
LINE (737, 407)-(695, 365), 14
LINE (743, 407)-(785, 365), 14
LINE (740, 408)-(740, 412), 14
LINE (738, 410)-(742, 410), 14
LINE (740, 381)-(740, 346), 14
LINE (740, 391)-(740, 397), 14
LINE (708, 410)-(711, 410), 14
LINE (772, 410)-(769, 410), 14
LINE (721, 410)-(727, 410), 14
LINE (753, 410)-(759, 410), 14
LINE (740, 439)-(740, 442), 14
LINE (740, 423)-(740, 429), 14


'xITMZwaartepunt#    xc0# \
'yITMZwaartepunt#    yc0# |   We nemen slechts de x- en de z-waarden
'zITMZwaartepunt#    zc0# /       Verticale radar is voor later.

FOR AEN = 1 TO NumberOfEnemiesActive
    Distance#(AEN) = SQR((xITMZwaartepunt#(AEN) - xc0#) ^ 2 + (zITMZwaartepunt#(AEN) - zc0#) ^ 2)
    Alpha# = 2 * pi# - Koers#
    IF xITMZwaartepunt#(AEN) > xc0# AND zITMZwaartepunt#(AEN) >= zc0# THEN Beta# = (ATN((zITMZwaartepunt#(AEN) - zc0#) / (xITMZwaartepunt#(AEN) - xc0#)))
    IF xITMZwaartepunt#(AEN) < xc0# AND zITMZwaartepunt#(AEN) >= zc0# THEN Beta# = (pi# - ATN((zITMZwaartepunt#(AEN) - zc0#) / -(xITMZwaartepunt#(AEN) - xc0#)))
    IF xITMZwaartepunt#(AEN) < xc0# AND zITMZwaartepunt#(AEN) < zc0# THEN Beta# = (pi# + ATN(-(zITMZwaartepunt#(AEN) - zc0#) / -(xITMZwaartepunt#(AEN) - xc0#)))
    IF xITMZwaartepunt#(AEN) > xc0# AND zITMZwaartepunt#(AEN) < zc0# THEN Beta# = (2 * pi# - ATN(-(zITMZwaartepunt#(AEN) - zc0#) / (xITMZwaartepunt#(AEN) - xc0#)))
    IF xITMZwaartepunt#(AEN) = xc0# AND zITMZwaartepunt#(AEN) >= zc0# THEN Beta# = (.5 * pi#)
    IF xITMZwaartepunt#(AEN) = xc0# AND zITMZwaartepunt#(AEN) < zc0# THEN Beta# = (1.5 * pi#)

    Radarhoek#(AEN) = .5 * pi# - (Alpha# + Beta#)
    WHILE Radarhoek#(AEN) > 2 * pi#: Radarhoek#(AEN) = Radarhoek#(AEN) - 2 * pi#: WEND
    WHILE Radarhoek#(AEN) < 0: Radarhoek#(AEN) = Radarhoek#(AEN) + 2 * pi#: WEND

    IF Distance#(AEN) <= 4000 AND Distance#(AEN) > 2000 THEN '                        Voorwaarden
        IF Radarhoek#(AEN) > 1.75 * pi# OR Radarhoek#(AEN) < .25 * pi# THEN '        grote radar
            xRadar(AEN) = 740 + (SIN(Radarhoek#(AEN)) * Distance#(AEN) / 62.5)
            yRadar(AEN) = 410 - (COS(Radarhoek#(AEN)) * Distance#(AEN) / 62.5)
            '
            roodflits(AEN) = roodflits(AEN) - 1
            IF roodflits(AEN) = 225 THEN roodflits(AEN) = 249

            SELECT CASE RadarDotType(AEN) ' 0=friend 1=enemy ************************
                CASE 0
                    IF Wreck(AEN) = 0 THEN CIRCLE (xRadar(AEN), yRadar(AEN)), 2, 164
                CASE 1
                    IF Wreck(AEN) = 0 THEN LINE (xRadar(AEN) - 1, yRadar(AEN) - 1)-(xRadar(AEN) + 1, yRadar(AEN) + 1), roodflits(AEN), BF
            END SELECT
            IF Wreck(AEN) = 0 AND firstTimeWarnNOT(AEN) = 0 THEN PLAY "v" + Pct$ + "MBl32o4a": firstTimeWarnNOT(AEN) = 1: roodflits(AEN) = 249
        END IF
    END IF

    IF Distance#(AEN) <= 2000 THEN '                 Voorwaarden kleine radar
        xRadar(AEN) = 740 + (SIN(Radarhoek#(AEN)) * Distance#(AEN) / 62.5)
        yRadar(AEN) = 410 - (COS(Radarhoek#(AEN)) * Distance#(AEN) / 62.5)

        '
        roodflits(AEN) = roodflits(AEN) - 1
        IF roodflits(AEN) = 225 THEN roodflits(AEN) = 249

        SELECT CASE RadarDotType(AEN)
            CASE 0
                IF Wreck(AEN) = 0 THEN CIRCLE (xRadar(AEN), yRadar(AEN)), 2, 164
            CASE 1
                IF Wreck(AEN) = 0 THEN LINE (xRadar(AEN) - 1, yRadar(AEN) - 1)-(xRadar(AEN) + 1, yRadar(AEN) + 1), roodflits(AEN), BF
        END SELECT
        IF Wreck(AEN) = 0 AND firstTimeWarnNOT(AEN) = 0 THEN PLAY "v" + Pct$ + "MBl32o4a": firstTimeWarnNOT(AEN) = 1: roodflits(AEN) = 249
    END IF

    IF Distance#(AEN) <= 4000 AND Distance#(AEN) > 2000 THEN '                        Voorwaarden
        IF Radarhoek#(AEN) <= 1.75 * pi# AND Radarhoek#(AEN) >= .25 * pi# THEN '        grote radar
            firstTimeWarnNOT(AEN) = 0
        END IF
    END IF
    IF Distance#(AEN) > 4000 THEN firstTimeWarnNOT(AEN) = 0
NEXT
'
'
'
'***************************************
'
xp# = xwp#(waypoint)
yp# = ywp#(waypoint)
zp# = zwp#(waypoint)
GOSUB bbd
qx# = 400 + schaalx# * pf# * horhoek#
qy# = 225 - schaaly# * pf# * verhoek#
khoek# = kantel# * 3: GOSUB kantel
IF qx# >= 0 AND qx# <= 799 THEN
    LINE (qx# - 5, 0)-(qx#, 10)
    LINE -(qx# + 5, 0)
    arrows = 0
ELSE
    arrows = 1
END IF
w1# = SQR((xwp#(waypoint) - xc1#) ^ 2 + (zwp#(waypoint) - zc1#) ^ 2)
w2# = SQR((xwp#(waypoint) - xc2#) ^ 2 + (zwp#(waypoint) - zc2#) ^ 2)
IF w1# < w2# AND arrows = 1 THEN
    LINE (5, 0)-(0, 5)
    LINE -(5, 10)
    LINE (6, 0)-(1, 5)
    LINE -(6, 10)
    LINE (7, 0)-(2, 5)
    LINE -(7, 10)
END IF
IF w1# > w2# AND arrows = 1 THEN
    LINE (794, 0)-(799, 5)
    LINE -(794, 10)
    LINE (793, 0)-(798, 5)
    LINE -(793, 10)
    LINE (792, 0)-(797, 5)
    LINE -(792, 10)
END IF
IF ShowObjects = 1 THEN
    Shot& = Shot& + 1
    IF Shot& > FPSTarget THEN Shot& = 0: ShowObjects = 0 '       ONE SECOND
    waarde$ = STR$(AantalObjecten - ObjectsHit) + " LEFT": dx = 400: dy = 200
    GOSUB PlaatsTekstCentered
END IF


muxer$ = LTRIM$(RTRIM$(STR$(muxer!) + "x"))
SELECT CASE muxer$
    CASE ".25x": PUT (750, 60), mux(0), PSET
    CASE ".5x": PUT (750, 60), mux(500), PSET
    CASE "1x"
        IF yesss = 1 THEN PUT (750, 60), mux(1000), PSET: yesssteller& = yesssteller& + 1
    CASE "2x": PUT (750, 60), mux(1500), PSET
    CASE "4x": PUT (750, 60), mux(2000), PSET
END SELECT
IF yesssteller& > OverallFramerate * 2 THEN yesss = 0: yesssteller& = 0


IF ShowRescue = 1 THEN
    ShowRteller& = ShowRteller& + 1
    IF ShowRteller& > 2 * FPSTarget THEN ShowRteller& = 0: ShowRescue = 0 ' RESCUES GEVINKT  TWO SECONDS
    FOR awp = 1 TO waypoints
        dx = 20: dy = 140 + (awp - 1) * 10
        waarde$ = "RESCUE " + LTRIM$(STR$(awp))
        GOSUB PlaatsTekstLinksUitlijn
        LINE (90, dy)-(96, dy + 6), , B
        IF rescue(awp) = 1 THEN
            PUT (89, dy - 1), VinkMask(0), AND
            PUT (89, dy - 1), Vink(0), XOR
        END IF
    NEXT
END IF
'
IF ShowCargo = 1 THEN
    waarde$ = Exit$: dx = 600: dy = 80: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = "FUEL:": dx = 600: dy = 100: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = "M230:": dx = 600: dy = 110: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = LTRIM$(STR$(BaseFuel)) + " GL": dx = 635: dy = 100: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = LTRIM$(STR$(BaseBullets)) + " RNDS": dx = 635: dy = 110: GOSUB PlaatsTekstLinksUitlijn
    waarde$ = "AVAILABLE AT BASE": dx = 600: dy = 130: GOSUB PlaatsTekstLinksUitlijn
    ShowCteller& = ShowCteller& + 1
    IF ShowCteller& > 3 * FPSTarget THEN ShowCteller& = 0: ShowCargo = 0 ' Cargo 3 SECONDS
END IF

IF ShowController = 1 THEN
    Shot1& = Shot1& + 1
    IF Shot1& > 2 * FPSTarget THEN Shot1& = 0: ShowController = 0 '       two SECONDs
    waarde$ = Controller$: dx = 400: dy = 200
    GOSUB PlaatsTekstCentered
END IF

IF ShowCoordinates = 1 THEN
    waarde$ = "GPS"
    dx = 400: dy = 400
    GOSUB PlaatsTekstCentered
    waarde$ = LTRIM$(STR$(INT(xc0#))) + "," + LTRIM$(STR$(INT(zc0#)))
    dx = 400: dy = 410
    GOSUB PlaatsTekstCentered
END IF

' score$ = LTRIM$(STR$(score&))
score$ = "------" ' Geen score in demo.
'WHILE LEN(score$) < 6: score$ = "0" + score$: WEND
waarde$ = "SCORE:" + score$
dx = 708: dy = 15
GOSUB PlaatsTekstLinksUitlijn

level$ = LTRIM$(STR$(RFileNr))
WHILE LEN(level$) < 2: level$ = "0" + level$: WEND
waarde$ = "LEVEL:" + level$
dx = 708: dy = 25
GOSUB PlaatsTekstLinksUitlijn

waarde$ = "DAMAGE:" + LTRIM$(STR$(PlayerDamage)) + " %"
dx = 8: dy = 15
GOSUB PlaatsTekstLinksUitlijn
'
min$ = LTRIM$(STR$((AllowedSec& - TempSec&) \ 60))
sec$ = LTRIM$(STR$((AllowedSec& - TempSec&) MOD 60))
WHILE LEN(min$) < 2: min$ = "0" + min$: WEND
WHILE LEN(sec$) < 2: sec$ = "0" + sec$: WEND
'waarde$ = min$ + ":" + sec$
waarde$ = "--:--"
dx = 43: dy = 25
GOSUB PlaatsTekstLinksUitlijn
IF min$ < "02" THEN
    tijdknipper& = tijdknipper& + 1
    IF tijdknipper& >= FPSTarget / 4 THEN tijdknipper& = 0: SWAP tk1, tk2
    IF tk1 = 0 THEN
        waarde$ = "TIME:"
        dx = 8: dy = 25
        GOSUB PlaatsTekstLinksUitlijn
    END IF
ELSE
    waarde$ = "TIME:"
    dx = 8: dy = 25
    GOSUB PlaatsTekstLinksUitlijn
END IF
'DEMO-R
DemoWoordTeller = DemoWoordTeller + 1
IF DemoWoordTeller < 24 THEN
    PUT (740, 20), Rmask(0), AND
    PUT (740, 20), R(0), XOR
END IF
IF DemoWoordTeller > 48 THEN DemoWoordTeller = 0


'
'*************************************** HMuis, VMuis, BMuis (0=steady 1=up 2=downhit), TR (57=<SPC>)
' DEMO-CURSOR            12x19

IF ShowCursor = 1 THEN
    PUT (HMuis, VMuis), CursorMask(0), _CLIP AND
    PUT (HMuis, VMuis), Cursor(0), _CLIP XOR


    'MOUSE-BUTTON             32x40
    IF BMuis = 2 AND Button2On = 0 THEN Button2On = 1
    SELECT CASE BMuis
        CASE 0
            PUT (HMuis + 14, VMuis + 26), Muis0Mask(0), _CLIP AND
            PUT (HMuis + 14, VMuis + 26), Muis0(0), _CLIP XOR
        CASE 1
            PUT (HMuis + 14, VMuis + 26), Muis1Mask(0), _CLIP AND
            PUT (HMuis + 14, VMuis + 26), Muis1(0), _CLIP XOR
    END SELECT
    IF Button2On = 1 THEN
        PUT (HMuis + 14, VMuis + 26), Muis2Mask(0), _CLIP AND
        PUT (HMuis + 14, VMuis + 26), Muis2(0), _CLIP XOR
        ButtonCounter = ButtonCounter + 1
        IF ButtonCounter > OverallFramerate / 2 THEN Button2On = 0: ButtonCounter = 0
    END IF
    'SPACEBAR                48x12
    IF TR = 57 THEN
        PUT (HMuis + 2, VMuis + 62), Spacebar1Mask(0), _CLIP AND
        PUT (HMuis + 2, VMuis + 62), Spacebar1(0), _CLIP XOR
    ELSE
        PUT (HMuis + 2, VMuis + 62), Spacebar0Mask(0), _CLIP AND
        PUT (HMuis + 2, VMuis + 62), Spacebar0(0), _CLIP XOR
    END IF
END IF

'***************************************
'

RETURN

bbd:
'in :xc0#,yc0#,zc0#   Midden tafereel
'    xc5#,yc5#,zc5#   Oog
'    xp#,yp#,zp#      Te projecteren punt
'    pi#
'uit:horhoek#
'    verhoek#
'
'HORIZONTAAL
k1# = 2 * pi# - Koers#
koers1# = _ATAN2((zp# - zc0#), (xp# - xc0#))
k2# = 2 * pi# - koers1#
horhoek# = k2# - k1#
WHILE horhoek# < 0: horhoek# = horhoek# + 2 * pi#: WEND
WHILE horhoek# > 2 * pi#: horhoek# = horhoek# - 2 * pi#: WEND
horhoek# = horhoek# - 1.5 * pi#
'VERTICAAL
overstaande# = yp# - yc5#
aanliggende# = SQR((xp# - xc5#) ^ 2 + (zp# - zc5#) ^ 2)
k1# = helhoek#
k2# = ATN(overstaande# / aanliggende#)
verhoek# = 2 * (k2# - k1#)
RETURN


kantel:
IF Mode$ = "EASY" THEN RETURN
IF qx# = 400 AND qy# <= 225 THEN qalpha# = .5 * pi#: GOTO hu
IF qx# = 400 AND qy# > 225 THEN qalpha# = 1.5 * pi#: GOTO hu
IF qx# >= 400 THEN qalpha# = ATN((225 - qy#) / (qx# - 400))
IF qx# < 400 THEN qalpha# = pi# + ATN((225 - qy#) / (qx# - 400))
ql# = SQR((qx# - 400) ^ 2 + (225 - qy#) ^ 2)
hu:
qalpha# = qalpha# + khoek#
qx# = 400 + ql# * COS(qalpha#)
qy# = 225 - ql# * SIN(qalpha#)
RETURN

fuelplus:
IF ammo < 1200 THEN GOSUB VulWapensAan
IF PlayerDamage > 0 THEN
    _SNDPLAYCOPY Garage&
    PlayerDamage = 0
END IF
SchadeFuel = 0
SchadeTailRotor = 0
Totalloss = 0
IF fuel# >= 0 AND fuel# < fuelmax# THEN
    KnipperTeller& = KnipperTeller& + 1
    IF KnipperTeller& > KnipperTellerMax& THEN SWAP Knipper3, Knipper4: KnipperTeller& = 0
    IF Knipper3 = 1 AND BaseFuel > 0 THEN ' KNIPPERT ALS DE CAPACITEIT NIET HELEMAAL BENUT IS EN DE BASE-VOORRAAD>0 IS!!!
        waarde$ = "REFUELING"
        dx = 220: dy = 370: GOSUB PlaatsTekstCentered
    END IF
END IF
power$ = "on": levelhoogte$ = "off"
'XXX
IF BaseFuel > 0 THEN fuel# = fuel# + 1: FuelTotalUsed# = FuelTotalUsed# + 1: BaseFuel = BaseFuel - 1
IF fuel# >= fuelmax# THEN
    fuel# = fuelmax#
END IF
RETURN

fuelmin:
'                           verbruik# = .004
'                           speedfactor# [-.75, .75]
'                           hh# [0, 5000]
'
SELECT CASE SchadeFuel '****** Verbruik * 5 bij schade
    CASE 0
        fuel# = fuel# - (verbruik# + ABS(speedfactor#) * .008 + hh# * .0000002)
        IF fuel# < 0 THEN fuel# = 0: power$ = "off": levelhoogte$ = "off"
    CASE 1
        fuel# = fuel# - 5 * (verbruik# + ABS(speedfactor#) * .008 + hh# * .0000002)
        IF fuel# < 0 THEN fuel# = 0: power$ = "off": levelhoogte$ = "off"
END SELECT
IF devmode = 1 THEN fuel# = 100 'QWERTY
RETURN

schiet:
IF ammo <= 0 THEN ammo = 0: RETURN
kn = kn + 1
IF kn > MaxKogels - 1 THEN kn = 0

_SNDPLAYCOPY Gun&
schietstatus(kn) = 1
xk#(kn) = xc5#
yk#(kn) = yc5#
zk#(kn) = zc5#
sxk#(kn) = spx# + (xc0# - xc5#) * kogelsnelheid#
syk#(kn) = spy# + (yc0# - yc5#) * kogelsnelheid#
szk#(kn) = spz# + (zc0# - zc5#) * kogelsnelheid#
ammo = ammo - 1
IF devmode = 1 THEN ammo = 1200 'QWERTY
RETURN

swapFPSShow:
IF FPSShow = 1 THEN FPSPrint = 0: FPSShow = 0: RETURN
IF FPSShow = 0 THEN FPSPrint = 1: FPSShow = 1: RETURN

SwapCursor:
IF ShowCursor = 0 THEN ShowCursor = 1: RETURN
IF ShowCursor = 1 THEN ShowCursor = 0: RETURN

pulse:
IF FPSShow = 1 THEN
    framespark = frames: frames = 0
END IF
RETURN

draaix: 'Draai a om b (x-as) met hoek hs#
hoekx# = 0
aa# = xa#
bb# = ya#
cc# = za#
r# = SQR((bb# - yb#) ^ 2 + (cc# - zb#) ^ 2)
hoekx# = _ATAN2((cc# - zb#), (bb# - yb#))
hoekx# = hoekx# - hs#
bb# = r# * COS(hoekx#) + yb#
cc# = r# * SIN(hoekx#) + zb#
xa# = aa#
ya# = bb#
za# = cc#
RETURN

DraaiY: 'Draai a om b (y-as) met hoek hs#
hoeky# = 0
aa# = xa#
bb# = ya#
cc# = za#
r# = SQR((aa# - xb#) ^ 2 + (cc# - zb#) ^ 2)
hoeky# = _ATAN2((cc# - zb#), (aa# - xb#))
hoeky# = hoeky# - hs#
aa# = r# * COS(hoeky#) + xb#
cc# = r# * SIN(hoeky#) + zb#
xa# = aa#
ya# = bb#
za# = cc#
RETURN

TekenBlok:
LINE (x1, y1)-(x2 - 1, y1), 4
LINE (x2, y1)-(x2, y2 - 1), 4
LINE (x2, y2)-(x1 + 1, y2), 2
LINE (x1, y2)-(x1, y1 + 1), 2
LINE (x1 + 1, y1 + 1)-(x2 - 2, y1 + 1), 4
LINE (x2 - 1, y1 + 1)-(x2 - 1, y2 - 2), 4
LINE (x2 - 1, y2 - 1)-(x1 + 2, y2 - 1), 2
LINE (x1 + 1, y2 - 1)-(x1 + 1, y1 + 2), 2
LINE (x1 + 2, y1 + 2)-(x2 - 2, y2 - 2), 3, BF
RETURN

TekenGat:
LINE (x1, y1)-(x2 - 1, y1), 2
LINE (x2, y1)-(x2, y2 - 1), 2
LINE (x2, y2)-(x1 + 1, y2), 4
LINE (x1, y2)-(x1, y1 + 1), 4
LINE (x1 + 1, y1 + 1)-(x2 - 2, y1 + 1), 2
LINE (x2 - 1, y1 + 1)-(x2 - 1, y2 - 2), 2
LINE (x2 - 1, y2 - 1)-(x1 + 2, y2 - 1), 4
LINE (x1 + 1, y2 - 1)-(x1 + 1, y1 + 2), 4
LINE (x1 + 2, y1 + 2)-(x2 - 2, y2 - 2), 0, BF
RETURN

loaditm:
OPEN "..\ITMFiles\" + Bestand$ FOR INPUT AS #2
INPUT #2, a$
INPUT #2, k: tiles = k
FOR vn = 0 TO k - 1
    FOR pn = 0 TO 4 '                                  pn=0  -->  zwaartepunt
        INPUT #2, x#(vn, pn), y#(vn, pn), z#(vn, pn) ' 1-4   -->  hoekpunten
    NEXT
    INPUT #2, kleur(vn)
NEXT
INPUT #2, a$
CLOSE #2
RETURN

swapScreen:
PLAY "v" + Pct$ + "MBl32o3a"
OPEN "..\TXTFiles\DISPLAY.TXT" FOR INPUT AS #4
INPUT #4, screen$
CLOSE #4
IF screen$ = "WINDOWED" THEN screen$ = "FULLSCREEN": GOSUB WriteSettings: GOTO label
IF screen$ = "FULLSCREEN" THEN screen$ = "WINDOWED": GOSUB WriteSettings: GOTO label
label:
IF full = 1 THEN _FULLSCREEN _OFF: _SCREENMOVE _MIDDLE: full = 0: RETURN
IF full = 0 THEN _FULLSCREEN: full = 1: RETURN
WriteSettings:
OPEN "..\TXTFiles\DISPLAY.TXT" FOR OUTPUT AS #4
PRINT #4, screen$
CLOSE #4
RETURN

swapBlades:
IF ShowBlades = 0 THEN ShowBlades = 1: RETURN
IF ShowBlades = 1 THEN ShowBlades = 0: RETURN

raak:
IF enemydamage(AEN) >= 100 THEN RETURN
SELECT CASE vijandType(AEN)
    CASE 2: enemydamage(AEN) = enemydamage(AEN) + 4: score& = score& + 4: _SNDPLAYCOPY HitEnemy&
    CASE 3: enemydamage(AEN) = enemydamage(AEN) + 2: score& = score& + 3: _SNDPLAYCOPY HitEnemy&
    CASE 4: enemydamage(AEN) = enemydamage(AEN) + 1: score& = score& + 2: _SNDPLAYCOPY HitEnemy&
    CASE 1: enemydamage(AEN) = enemydamage(AEN) + 10: _SNDPLAYCOPY Fail&
END SELECT
IF enemydamage(AEN) >= 100 AND vijandType(AEN) <> 1 THEN
    sxvijand#(AEN) = 0
    syvijand#(AEN) = 0
    szvijand#(AEN) = 0
    enemydamage(AEN) = 0
    GOSUB NextEnemy '
END IF
IF enemydamage(AEN) >= 100 AND vijandType(AEN) = 1 THEN
    sxvijand#(AEN) = 0
    syvijand#(AEN) = 0
    szvijand#(AEN) = 0
    enemydamage(AEN) = 0
    GOSUB NextEnemy
END IF
RETURN


map: '
TIMER OFF
_SNDSTOP Damage&
_SNDSTOP Blades&
_MOUSESHOW
WHILE INKEY$ <> "": WEND
x1 = 195: y1 = 25: x2 = 604: y2 = 434: GOSUB TekenBlok
x1 = 200: y1 = 30: x2 = 599: y2 = 429: GOSUB TekenGat
FOR ystip = -2400 TO 2400 STEP 100
    FOR xstip = -2400 TO 2400 STEP 100
        PSET (400 + (400 / 5000) * xstip, 230 + (400 / 5000) * ystip) '     RASTER
    NEXT
NEXT


' Teken "..\ITMFiles\"+Bestand$ in Map
FOR vn = 0 TO kVlakken - 1
    'ITMscale is niet zeker weten
    xvlakinmap1# = 400 + (400 / 5000) * (itmscale * x#(vn, 1) + itmdx)
    yvlakinmap1# = 230 - (400 / 5000) * (itmscale * z#(vn, 1) + itmdz)
    xvlakinmap2# = 400 + (400 / 5000) * (itmscale * x#(vn, 2) + itmdx)
    yvlakinmap2# = 230 - (400 / 5000) * (itmscale * z#(vn, 2) + itmdz)
    xvlakinmap3# = 400 + (400 / 5000) * (itmscale * x#(vn, 3) + itmdx)
    yvlakinmap3# = 230 - (400 / 5000) * (itmscale * z#(vn, 3) + itmdz)
    xvlakinmap4# = 400 + (400 / 5000) * (itmscale * x#(vn, 4) + itmdx)
    yvlakinmap4# = 230 - (400 / 5000) * (itmscale * z#(vn, 4) + itmdz)
    LINE (xvlakinmap1#, yvlakinmap1#)-(xvlakinmap2#, yvlakinmap2#), 5
    LINE -(xvlakinmap3#, yvlakinmap3#), 5
    LINE -(xvlakinmap4#, yvlakinmap4#), 5
    LINE -(xvlakinmap1#, yvlakinmap1#), 5
NEXT


'teken kompasroos
'
PUT (230, 60), RoosMask(0), AND
PUT (230, 60), Roos(0), XOR
dx = 205: dy = 35: waarde$ = "INTEL": GOSUB PlaatsTekstLinksUitlijn

FOR awp = 0 TO waypoints
    xdraw# = 400 + (400 / 5000) * xwp#(awp)
    ydraw# = 230 - (400 / 5000) * zwp#(awp)
    ddx# = xdraw# - 3
    ddy# = ydraw# - 3
    LINE (ddx#, ddy#)-(ddx# + 6, ddy# + 6), , B '                               RESCUES
    waarde$ = LTRIM$(STR$(awp))
    dx = ddx# + 4: dy = ddy# + 9
    GOSUB PlaatsTekstCentered
    IF awp = 0 THEN
        waarde$ = "BASE"
        dx = ddx# + 4: dy = ddy# - 9
        GOSUB PlaatsTekstCentered
    END IF
    IF rescue(awp) = 1 AND awp <> 0 THEN
        PUT (ddx# - 1, ddy# - 1), VinkMask(0), AND
        PUT (ddx# - 1, ddy# - 1), Vink(0), XOR
    END IF
NEXT

FOR AEN = 1 TO NumberOfEnemiesActive
    xredcircle = 400 + (400 / 5000) * xITMZwaartepunt#(AEN)
    yredcircle = 230 - (400 / 5000) * zITMZwaartepunt#(AEN)
    IF xredcircle > 205 AND xredcircle < 592 AND yredcircle > 35 AND yredcircle < 422 THEN
        '
        IF vijandType(AEN) = 1 THEN
            CIRCLE (xredcircle, yredcircle), 2, 7, BF
            PAINT (xredcircle, yredcircle), 7
            PSET (xredcircle + 1, yredcircle - 1), 5
        ELSE
            CIRCLE (xredcircle, yredcircle), 2, 8, BF
            PAINT (xredcircle, yredcircle), 8
            PSET (xredcircle + 1, yredcircle - 1), 5
        END IF
    END IF
NEXT

xcopter# = 400 + (400 / 5000) * xc0#
ycopter# = 230 - (400 / 5000) * zc0#

IF xcopter# > 205 AND xcopter# < 592 AND ycopter# > 35 AND ycopter# < 422 THEN
    CIRCLE (xcopter#, ycopter#), 4, 10
    xcopter2# = xcopter# - 16 * SIN(Koers#)
    ycopter2# = ycopter# - 16 * COS(Koers#)
    IF xcopter2# > 205 AND xcopter2# < 592 AND ycopter2# > 35 AND ycopter2# < 422 THEN
        LINE (xcopter#, ycopter#)-(xcopter2#, ycopter2#), 10
    END IF
END IF
WHILE INKEY$ = ""
    Mouse 3
    IF BMuis = 1 GOTO exwh1
    _LIMIT OverallFramerate
    _DISPLAY
WEND
exwh1:
WHILE INKEY$ <> "": WEND
WHILE BMuis <> 0: Mouse 3: _LIMIT OverallFramerate: WEND
IF ShowCursor = 0 THEN _MOUSEHIDE
IF fuel# > 0 OR status$ <> "LANDED" THEN _SNDLOOP Blades&: rsf = 1: bladesturn$ = "on"
IF DamSound = 1 THEN _SNDLOOP Damage&
TIMER ON
RETURN


ExitMenu:
CLOSE #13
GOSUB Systeemeinde2
CHAIN "Menu.exe"


PlaatsTekstCentered:
IF LEFT$(waarde$, 1) = " " THEN waarde$ = RIGHT$(waarde$, LEN(waarde$) - 1)
'IF waarde$ = "" THEN waarde$ = "TEXT ERROR"
ddx = dx - LEN(waarde$) * 3.5
FOR strp = 1 TO LEN(waarde$)
    nch = ASC(MID$(waarde$, strp, 1))
    PUT (ddx + (strp - 1) * 7, dy), v(nch * grootte), _CLIP PSET
NEXT
waarde$ = ""
RETURN

PlaatsTekstLinksUitlijn:
FOR strp = 1 TO LEN(waarde$)
    nch = ASC(MID$(waarde$, strp, 1))
    PUT (dx + (strp - 1) * 7, dy), v(nch * grootte), _CLIP PSET
NEXT
waarde$ = ""
RETURN





LoadRescues:
RFileNr = RFileNr + 1
IF RFileNr = 10 GOTO Uitgespeeld
PlusTime& = AllowedSec& - resec&
OPEN "..\TXTFiles\LEVEL" + LTRIM$(STR$(RFileNr)) + ".TXT" FOR INPUT AS #5
INPUT #5, test$
INPUT #5, AllowedSec&
INPUT #5, waypoints
ToBeRescued = waypoints
FOR waypoint = 0 TO waypoints
    INPUT #5, xwp#(waypoint)
    INPUT #5, ywp#(waypoint)
    INPUT #5, zwp#(waypoint)
    INPUT #5, txt$(waypoint)
NEXT
INPUT #5, test$
CLOSE #5
waypoint = 0
AllowedSec& = AllowedSec& + PlusTime&
resec& = 0
RETURN

Uitgespeeld:
TIMER OFF
GOTO ExitMenu

Systeemeinde2:
_AUTODISPLAY
TIMER OFF
dikte = 8
LINE (400 - dikte, 0)-(400 + dikte, 449), 0, BF
FOR k = 1 TO 50
    _LIMIT 10 * OverallFramerate
    GET (400, 0)-(799 - dikte, 449), bulk1(0)
    GET (dikte, 0)-(399, 449), bulk2(0)
    PUT (0, 0), bulk2(0), PSET
    PUT (400 + dikte, 0), bulk1(0), PSET
    LINE (399 - (k - 1) * dikte, 0)-(399 - (k - 1) * dikte, 449), 0
    LINE (400 + (k - 1) * dikte, 0)-(400 + (k - 1) * dikte, 449), 0
    _DISPLAY
NEXT
RETURN
'
moondata:
DATA .....befebo.....
DATA ...bifeaabeep...
DATA ..aeeaaefeaafo..
DATA .ghehjhaehhefeq.
DATA .ahhjjheejhheeg.
DATA ghehhhhaehhjgeak
DATA bjbbeeebbbagjhbl
DATA ejheafabenfbaagm
DATA nhhaaeeeenncefhg
DATA eahhaaeefnncfael
DATA gnaabaaannnnnfnk
DATA .dnfbeahfccnnnn.
DATA .rdcaefndccnnnp.
DATA ..ecnnncdccncg..
DATA ...gcnccdccco...
DATA .....gefneg.....
'
Rdata:
DATA 1111111111111111111111111112...........
DATA 111111111111111111111111111112.........
DATA 1111111111111111111111111111112........
DATA 11111111111111111111111111111112.......
DATA ...111111111112....11111111111112......
DATA ....11111111112......111111111112......
DATA ....11111111112.......11111111112......
DATA ....11111111112.......11111111112......
DATA ....11111111112.......11111111112......
DATA ....11111111112.......11111111112......
DATA ....11111111112.......11111111112......
DATA ....11111111112......111111111112......
DATA ....11111111112....1111111111112.......
DATA ....111111111111111111111111112........
DATA ....11111111111111111111111112.........
DATA ....111111111111111111111112...........
DATA ....111111111111111111112..............
DATA ....1111111111111111111112.............
DATA ....11111111111111111111112............
DATA ....111111111111111111111112...........
DATA ....11111111112.1111111111112..........
DATA ....11111111112..1111111111112.........
DATA ....11111111112...1111111111112........
DATA ....11111111112....1111111111112.......
DATA ....11111111112.....1111111111112......
DATA ....11111111112......1111111111112.....
DATA ....11111111112.......1111111111112....
DATA ...1111111111112.......11111111111112..
DATA 11111111111111111112....111111111111112
DATA 11111111111111111112....111111111111112
DATA 11111111111111111112....111111111111112
DATA 11111111111111111112....111111111111112

MuxerData:
DATA 010000000000000000
DATA 110000100001100011
DATA 010001000000110110
DATA 111010000000011100
DATA 000101000000011100
DATA 001001010000110110
DATA 010001111001100011
DATA 000000010000000000

DATA 010000000000000000
DATA 110000100001100011
DATA 010001000000110110
DATA 111010000000011100
DATA 000101100000011100
DATA 001000010000110110
DATA 010000100001100011
DATA 000001110000000000

DATA 000011000000000000
DATA 000111000001100011
DATA 000011000000110110
DATA 000011000000011100
DATA 000011000000011100
DATA 000011000000110110
DATA 000011000001100011
DATA 000111100000000000

DATA 000111110000000000
DATA 001100011001100011
DATA 000000011000110110
DATA 000011110000011100
DATA 000110000000011100
DATA 001100000000110110
DATA 001100000001100011
DATA 001111111000000000

DATA 001100000000000000
DATA 001100000001100011
DATA 001100000000110110
DATA 001100110000011100
DATA 001111111000011100
DATA 000000110000110110
DATA 000000110001100011
DATA 000000110000000000
roos: '  56x56
DATA 00000000000000000000000001000010000000000000000000000000
DATA 00000000000000000000000001100010000000000000000000000000
DATA 00000000000000000000000001010010000000000000000000000000
DATA 00000000000000000000000001001010000000000000000000000000
DATA 00000000000000000000000001000110000000000000000000000000
DATA 00000000000000000000000001000010000000000000000000000000
DATA 00000000000000000000000001000010000000000000000000000000
DATA 00000000000000000000000000000000000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000110100000000000000000000000000
DATA 00000000000000000000000000110100000000000000000000000000
DATA 00000000000000000000000000110100000000000000000000000000
DATA 00000000000000000000000001110010000000000000000000000000
DATA 00000000000000000000000001110010000000000000000000000000
DATA 00000000000000001110000001110010000001110000000000000000
DATA 00000000000000001101110011110001001111110000000000000000
DATA 00000000000000001110001111110001111111010000000000000000
DATA 00000000000000000111000011110001111110100000000000000000
DATA 00000000000000000111100111110000111100100000000000000000
DATA 00000000000000000111110111110000111000100000000000000000
DATA 00000000000000000011111111110000110001000000000000000000
DATA 00000000000000000011111111110000111101000000000000000000
DATA 00000000000000000111000011110001111111100000000000000000
DATA 01000010000000111000000001110011111111111100000001111110
DATA 01000010000111000000000000110111111111111111100001000000
DATA 01000010111000000000000000011111111111111111111101000000
DATA 01000010111111111111111111111000000000000000011101111000
DATA 01011010000111111111111111101100000000000011100001000000
DATA 01011010000000111111111111001110000000011100000001000000
DATA 01100110000000000111111110001111000011100000000001111110
DATA 00000000000000000010111100001111111111000000000000000000
DATA 00000000000000000010001100001111111111000000000000000000
DATA 00000000000000000100011100001111101111100000000000000000
DATA 00000000000000000100111100001111100111100000000000000000
DATA 00000000000000000101111110001111000011100000000000000000
DATA 00000000000000001011111110001111110001110000000000000000
DATA 00000000000000001111110010001111001110110000000000000000
DATA 00000000000000001110000001001110000001110000000000000000
DATA 00000000000000000000000001001110000000000000000000000000
DATA 00000000000000000000000001001110000000000000000000000000
DATA 00000000000000000000000000101100000000000000000000000000
DATA 00000000000000000000000000101100000000000000000000000000
DATA 00000000000000000000000000101100000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000011000000000000000000000000000
DATA 00000000000000000000000000000000000000000000000000000000
DATA 00000000000000000000000000111100000000000000000000000000
DATA 00000000000000000000000001000010000000000000000000000000
DATA 00000000000000000000000001000000000000000000000000000000
DATA 00000000000000000000000000111100000000000000000000000000
DATA 00000000000000000000000000000010000000000000000000000000
DATA 00000000000000000000000001000010000000000000000000000000
DATA 00000000000000000000000000111100000000000000000000000000


spacebar0: '48x12           ||
DATA 044444444444444444444444444444444444444444444440
DATA 224444444444444444444444444444444444444444444444
DATA 223333333333333333333333333333333333333333333344
DATA 223333333333333333333333333333333333333333333344
DATA 223333333333355535555335533355535555333333333344
DATA 223333333333555335555355553533335533333333333344
DATA 223333333333333535333353353533335333333333333344
DATA 223333333333555335333353353355535555333333333344
DATA 223333333333333333333333333333333333333333333344
DATA 223333333333333333333333333333333333333333333344
DATA 222222222222222222222222222222222222222222222244
DATA 022222222222222222222222222222222222222222222220
spacebar1: '48x12           ||
DATA 022222222222222222222222222222222222222222222220
DATA 442222222222222222222222222222222222222222222222
DATA 443333333333333333333333333333333333333333333322
DATA 443333333333333333333333333333333333333333333322
DATA 443333333333355535555336633355535555333333333322
DATA 443333333333555335555366663533335533333333333322
DATA 443333333333333535333366663533335333333333333322
DATA 443333333333555335333356653355535555333333333322
DATA 443333333333333333333333333333333333333333333322
DATA 443333333333333333333333333333333333333333333322
DATA 444444444444444444444444444444444444444444444422
DATA 044444444444444444444444444444444444444444444440
muis0: ' 24x32
DATA 000044444443344444440000
DATA 004433333334233333334400
DATA 023333333334233333333340
DATA 023333333334233333333340
DATA 233333333324443333333334
DATA 233333333323343333333334
DATA 233333333323343333333334
DATA 233333333323343333333334
DATA 233333333323343333333334
DATA 233333333322243333333334
DATA 233333333334233333333334
DATA 233333333334233333333334
DATA 233333333334233333333334
DATA 222222222222222222222222
DATA 444444444444444444444444
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 002333333333333333333400
DATA 002333333333333333333400
DATA 000233333333333333334000
DATA 000023333333333333320000
DATA 000002223333333322200000
DATA 000000002222222200000000
muis1:
DATA 000022222223344444440000
DATA 002233333332233333334400
DATA 043333333332233333333340
DATA 043333333332233333333340
DATA 433333333324443333333334
DATA 433336633323343333333334
DATA 433366663323343333333334
DATA 433366663323343333333334
DATA 433336633323343333333334
DATA 433333333322243333333334
DATA 433333333332233333333334
DATA 433333333332233333333334
DATA 433333333332233333333334
DATA 444444444444222222222222
DATA 444444444444444444444444
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 002333333333333333333400
DATA 002333333333333333333400
DATA 000233333333333333334000
DATA 000023333333333333320000
DATA 000002223333333322200000
DATA 000000002222222200000000
muis2: '
DATA 000044444443322222220000
DATA 004433333334433333332200
DATA 023333333334433333333320
DATA 023333333334433333333320
DATA 233333333324443333333332
DATA 233333333323343336633332
DATA 233333333323343366663332
DATA 233333333323343366663332
DATA 233333333323343336633332
DATA 233333333322243333333332
DATA 233333333334433333333332
DATA 233333333334433333333332
DATA 233333333334433333333332
DATA 222222222222444444444444
DATA 444444444444444444444444
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 233333333333333333333334
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 023333333333333333333340
DATA 002333333333333333333400
DATA 002333333333333333333400
DATA 000233333333333333334000
DATA 000023333333333333320000
DATA 000002223333333322200000
DATA 000000002222222200000000
cursor: '12x19
DATA 100000000000
DATA 110000000000
DATA 121000000000
DATA 122100000000
DATA 122210000000
DATA 122221000000
DATA 122222100000
DATA 122222210000
DATA 122222221000
DATA 122222222100
DATA 122222222210
DATA 122222222221
DATA 122222211111
DATA 122212210000
DATA 122101221000
DATA 121001221000
DATA 110000122100
DATA 000000122100
DATA 000000011000


vink:
DATA 000000011
DATA 000000110
DATA 000000110
DATA 110001100
DATA 011001100
DATA 001111000
DATA 000110000
DATA 000010000

Set2:

'        (32 - 38) SPC-&
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
'
DATA 001100
DATA 011110
DATA 011110
DATA 001100
DATA 001100
DATA 000000
DATA 001100

DATA 010100
DATA 010100
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000

DATA 011110
DATA 100001
DATA 101101
DATA 101001
DATA 101101
DATA 100001
DATA 011110

DATA 011110
DATA 101000
DATA 101000
DATA 011100
DATA 001010
DATA 001010
DATA 111100

DATA 110001
DATA 110011
DATA 000110
DATA 001100
DATA 011000
DATA 110011
DATA 100011

DATA 001000
DATA 010100
DATA 010100
DATA 001001
DATA 010110
DATA 100010
DATA 011101


'  ()    (40-41)
DATA 000010
DATA 000100
DATA 001000
DATA 001000
DATA 001000
DATA 000100
DATA 000010

DATA 010000
DATA 001000
DATA 000100
DATA 000100
DATA 000100
DATA 001000
DATA 010000


'  -     (43-47)

DATA 000000
DATA 001000
DATA 001000
DATA 111110
DATA 001000
DATA 001000
DATA 000000

DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000100
DATA 001000


DATA 000000
DATA 000000
DATA 000000
DATA 011110
DATA 000000
DATA 000000
DATA 000000

DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 001100
DATA 001100

DATA 000000
DATA 000001
DATA 000010
DATA 000100
DATA 001000
DATA 010000
DATA 100000
'  0 - : (48-58)
DATA 011110
DATA 100011
DATA 100101
DATA 100001
DATA 101001
DATA 110001
DATA 011110

DATA 000100
DATA 001100
DATA 000100
DATA 000100
DATA 000100
DATA 000100
DATA 001110

DATA 011110
DATA 100001
DATA 000001
DATA 001110
DATA 010000
DATA 100000
DATA 111111

DATA 011110
DATA 100001
DATA 000001
DATA 001110
DATA 000001
DATA 100001
DATA 011110

DATA 100000
DATA 100000
DATA 100100
DATA 111111
DATA 000100
DATA 000100
DATA 000100

DATA 111111
DATA 100000
DATA 111100
DATA 000010
DATA 000001
DATA 100001
DATA 011110

DATA 000110
DATA 001000
DATA 010000
DATA 111110
DATA 100001
DATA 100001
DATA 011110

DATA 111111
DATA 000001
DATA 000001
DATA 000110
DATA 001000
DATA 001000
DATA 001000

DATA 011110
DATA 100001
DATA 100001
DATA 011110
DATA 100001
DATA 100001
DATA 011110

DATA 011110
DATA 100001
DATA 100001
DATA 011111
DATA 000010
DATA 000100
DATA 001000

DATA 000000
DATA 001100
DATA 001100
DATA 000000
DATA 001100
DATA 001100
DATA 000000

'  @ - Z (64-90)
DATA 001110
DATA 110001
DATA 100101
DATA 101011
DATA 100111
DATA 110000
DATA 001111

DATA 001100
DATA 010010
DATA 100001
DATA 111111
DATA 100001
DATA 100001
DATA 100001

DATA 111110
DATA 100001
DATA 100001
DATA 111110
DATA 100001
DATA 100001
DATA 111110

DATA 011111
DATA 100000
DATA 100000
DATA 100000
DATA 100000
DATA 100000
DATA 011111

DATA 111110
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 111110

DATA 111111
DATA 100000
DATA 100000
DATA 111100
DATA 100000
DATA 100000
DATA 111111

DATA 111111
DATA 100000
DATA 100000
DATA 111100
DATA 100000
DATA 100000
DATA 100000

DATA 011110
DATA 100001
DATA 100000
DATA 100110
DATA 100001
DATA 100001
DATA 011110

DATA 100001
DATA 100001
DATA 100001
DATA 111111
DATA 100001
DATA 100001
DATA 100001

DATA 011100
DATA 001000
DATA 001000
DATA 001000
DATA 001000
DATA 001000
DATA 011100

DATA 111111
DATA 000001
DATA 000001
DATA 000001
DATA 100001
DATA 100001
DATA 011110

DATA 100001
DATA 100010
DATA 100100
DATA 111000
DATA 100100
DATA 100010
DATA 100001

DATA 100000
DATA 100000
DATA 100000
DATA 100000
DATA 100000
DATA 100000
DATA 111111

DATA 100001
DATA 110011
DATA 101101
DATA 100001
DATA 100001
DATA 100001
DATA 100001

DATA 100001
DATA 110001
DATA 101001
DATA 100101
DATA 100011
DATA 100001
DATA 100001

DATA 011110
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 011110

DATA 111110
DATA 100001
DATA 100001
DATA 111110
DATA 100000
DATA 100000
DATA 100000

DATA 011110
DATA 100001
DATA 100001
DATA 100001
DATA 100101
DATA 100011
DATA 011111

DATA 111110
DATA 100001
DATA 100001
DATA 111110
DATA 100001
DATA 100001
DATA 100001

DATA 011110
DATA 100001
DATA 100000
DATA 011110
DATA 000001
DATA 100001
DATA 011110

DATA 111110
DATA 001000
DATA 001000
DATA 001000
DATA 001000
DATA 001000
DATA 001000

DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 011110

DATA 100001
DATA 100001
DATA 100001
DATA 010010
DATA 010010
DATA 010010
DATA 001100

DATA 100001
DATA 100001
DATA 100001
DATA 100001
DATA 101101
DATA 110011
DATA 100001

DATA 100001
DATA 100001
DATA 010010
DATA 001100
DATA 010010
DATA 100001
DATA 100001

DATA 100010
DATA 100010
DATA 100010
DATA 011100
DATA 001000
DATA 001000
DATA 001000

DATA 111111
DATA 000001
DATA 000010
DATA 000100
DATA 001000
DATA 010000
DATA 111111

DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000
DATA 000000

DATA 000100
DATA 000100
DATA 001000
DATA 000000
DATA 000000
DATA 000000
DATA 000000

'        "MOUSE" Sub-Routine Copyright 1999 by: Daryl R. Dubbs
SUB Mouse (Funk) STATIC '                   Define sub & parameter(s) passed.
    SHARED BMuis, HMuis, VMuis '                            Share variables with main sub.
    IF Funk = 1 THEN Crsr = 1 '                 Show Cursor.
    IF Funk = 2 AND Crsr = 0 THEN EXIT SUB '    Don't hide Cursor more than once.
    IF Funk = 2 AND Crsr = 1 THEN Crsr = 0 '    Hide Cursor.
    POKE 100, 184: POKE 101, Funk: POKE 102, 0 'Poke machine code necessary for
    POKE 103, 205: POKE 104, 51: POKE 105, 137 'using the mouse into memory
    POKE 106, 30: POKE 107, 170: POKE 108, 10 ' starting at offset 100 in the
    POKE 109, 137: POKE 110, 14: POKE 111, 187 'current segment.  This code is
    POKE 112, 11: POKE 113, 137: POKE 114, 22 ' then executed as a unit, via the
    POKE 115, 204: POKE 116, 12: POKE 117, 203 'statement " Call Absolute ".
    CALL ABSOLUTE(100) '                        Call machine code.
    BMuis = PEEK(&HAAA) '                           Get values for: Buttons
    HMuis = PEEK(&HBBB) + PEEK(&HBBC) * 256 '       Horizontal position ( 2 bytes )
    VMuis = PEEK(&HCCC) + PEEK(&HCCD) * 256 '       Vertical position ( 2 bytes )
END SUB '                                   End of sub-program.

