' Gravity 1.0 by Molnar \ Kucalaba Productions. Not the cologne, the QBasic
' demo. Email your comments to Blood 225 (aol) or Blood225@aol.com (internet)
' Check out our WWW and FTP sites.
'   FTP = ftp://members.aol.com/blood225
'   WWW = http://members.aol.com/blood225

' If a new version of Gravity is released, it will have additional pages.

' The EXE is included for those who don't have QuickBASIC and want to see the
' demo how it was meant to be seen.

' Coming Soon : SubQuest, Fury, Tank War, Ambush ]I[

DECLARE FUNCTION GetDelay% ()
DECLARE SUB ReGenerate (TIMes%)
DECLARE SUB PlotStart (TIMes%)
DECLARE SUB CloseUp ()
DECLARE FUNCTION RandNum! (u%)

TYPE PixelType
 XPos AS INTEGER
 Ypos AS INTEGER
 Dir AS INTEGER
 Xincr AS INTEGER
 yincr AS INTEGER
 Col AS INTEGER
END TYPE

TYPE Pixel
 x AS SINGLE
 y AS SINGLE
 height AS INTEGER
 gradient AS SINGLE
 vdir AS INTEGER
 hdir AS INTEGER
 Col AS INTEGER
END TYPE

TYPE StarType
 XPos AS DOUBLE
 Ypos AS DOUBLE
 Xincr AS DOUBLE
 yincr AS DOUBLE
 Total AS INTEGER
 Dir AS INTEGER
 Size AS INTEGER
 Active AS INTEGER
 Switcher AS INTEGER
END TYPE


NumPoints% = 60 ' Bouncing pixels #
SMax% = 35      ' # of stars in 3D star field
Max% = 20       ' # of bouncing pixels

DIM Pixel(Max%) AS Pixel
DIM SHARED Stars(SMax%) AS StarType
DIM Vector(4) AS PixelType
DIM Points(NumPoints%) AS PixelType
DIM Circ%(8841)

'$DYNAMIC
DEFINT A-Z
RANDOMIZE TIMER

scrollspeed% = GetDelay%

CLS
SCREEN 7

GOSUB Initialize

' Start of Main Routine
LoopAgain:
DO UNTIL AA$ <> ""
AA$ = INKEY$
 PCOPY 3, 2
 SCREEN , , 2, 0
   
    GOSUB UpdateText
    GOSUB TriVector
    GOSUB StarWarp
    GOSUB LED

 PCOPY 2, 0
 SCREEN , , 2, 0
LOOP
IF AA$ = CHR$(27) THEN CloseUp
AA$ = ""
IF PagePtr% = 1 THEN
 GOSUB InitOptical
 scrollspeed% = scrollspeed% - 1
ELSEIF PagePtr% = 2 THEN
 scrollspeed% = scrollspeed% + 1
END IF

DO UNTIL AA$ <> ""
AA$ = INKEY$
 PCOPY 3, 2
 SCREEN , , 2, 0

   IF PagePtr% = 1 THEN GOSUB Optical
   GOSUB UpdateText
   IF PagePtr% = 2 THEN GOSUB Bouncing
   IF PagePtr% = 3 THEN GOSUB SquareBouncer
   GOSUB LED
   

 PCOPY 2, 0
 SCREEN , , 2, 0
LOOP
IF PagePtr% = 1 THEN
 scrollspeed% = scrollspeed% + 1
ELSEIF PagePtr% = 2 THEN
 scrollspeed% = scrollspeed% - 1
END IF
PagePtr% = PagePtr% + 1
IF PagePtr% = MaxPages% THEN PagePtr% = 1
AA$ = ""
GOTO LoopAgain
' End of Main Routine








Bouncing:
 FOR T = 1 TO Max%
  PSET (Pixel(T).x, (Pixel(T).y * Pixel(T).y) + Pixel(T).height), 0
   SELECT CASE Pixel(T).vdir
    CASE 2: Pixel(T).y = Pixel(T).y + Pixel(T).gradient
    CASE 1: Pixel(T).y = Pixel(T).y - Pixel(T).gradient
   END SELECT
   SELECT CASE Pixel(T).hdir
    CASE 2: Pixel(T).x = Pixel(T).x + 1
    CASE 1: Pixel(T).x = Pixel(T).x - 1
   END SELECT
   SELECT CASE (Pixel(T).y * Pixel(T).y) - Pixel(T).height
    CASE IS >= down%: Pixel(T).vdir = 1
   END SELECT
   IF Pixel(T).y < 0 THEN
    IF Pixel(T).vdir = 2 THEN Pixel(T).vdir = 1 ELSE Pixel(T).vdir = 2
   END IF
   SELECT CASE Pixel(T).x
    CASE IS >= right%: Pixel(T).hdir = 1
    CASE IS <= left%: Pixel(T).hdir = 2
   END SELECT
  py% = Pixel(T).y * Pixel(T).y + Pixel(T).height
  PSET (Pixel(T).x, py%), Pixel(T).Col
 NEXT
RETURN


UpdateText:
slow% = slow% + 1
IF slow% = 32767 THEN slow% = 0
IF slow% \ scrollspeed% = slow% / scrollspeed% THEN
 IF TPos% = 0 THEN
  text$ = SPACE$(40)
  READ Filter$
  TPos% = 1
 ELSE
  Spos% = Spos% + 1
  text$ = RIGHT$(text$, LEN(text$) - 1)
  text$ = LEFT$(text$, 40 - Spos%) + LEFT$(Filter$, Spos%)
  IF Spos% = 40 THEN
   text$ = Filter$
   READ Filter$
   IF Filter$ = "          Now Looping!                  " THEN RESTORE
   Spos% = 0
  END IF
 END IF
END IF
 COLOR 1
 LOCATE 2, 1: PRINT text$
RETURN


TriVector:
FOR TIMes% = 1 TO 4
  SELECT CASE Vector(TIMes%).Dir
    CASE 1: Vector(TIMes%).XPos = Vector(TIMes%).XPos - Vector(TIMes%).Xincr
            Vector(TIMes%).Ypos = Vector(TIMes%).Ypos - Vector(TIMes%).yincr
    CASE 2: Vector(TIMes%).XPos = Vector(TIMes%).XPos + Vector(TIMes%).Xincr
            Vector(TIMes%).Ypos = Vector(TIMes%).Ypos - Vector(TIMes%).yincr
    CASE 3: Vector(TIMes%).XPos = Vector(TIMes%).XPos - Vector(TIMes%).Xincr
            Vector(TIMes%).Ypos = Vector(TIMes%).Ypos + Vector(TIMes%).yincr
    CASE 4: Vector(TIMes%).XPos = Vector(TIMes%).XPos + Vector(TIMes%).Xincr
            Vector(TIMes%).Ypos = Vector(TIMes%).Ypos + Vector(TIMes%).yincr
  END SELECT
  SELECT CASE Vector(TIMes%).XPos
   CASE IS <= 0: SELECT CASE Vector(TIMes%).Dir
                          CASE 1: Vector(TIMes%).Dir = 2
                          CASE 3: Vector(TIMes%).Dir = 4
                        END SELECT
   CASE IS >= 320: SELECT CASE Vector(TIMes%).Dir
                          CASE 2: Vector(TIMes%).Dir = 1
                          CASE 4: Vector(TIMes%).Dir = 3
                        END SELECT
  END SELECT
  SELECT CASE Vector(TIMes%).Ypos
   CASE IS <= 20: SELECT CASE Vector(TIMes%).Dir
                          CASE 1: Vector(TIMes%).Dir = 3
                          CASE 2: Vector(TIMes%).Dir = 4
                         END SELECT
   CASE IS >= 200: SELECT CASE Vector(TIMes%).Dir
                          CASE 3: Vector(TIMes%).Dir = 1
                          CASE 4: Vector(TIMes%).Dir = 2
                         END SELECT
  END SELECT
NEXT TIMes%
 LINE (Vector(1).XPos, Vector(1).Ypos)-(Vector(2).XPos, Vector(2).Ypos), 8
 LINE (Vector(1).XPos, Vector(1).Ypos)-(Vector(3).XPos, Vector(3).Ypos), 8
 LINE (Vector(3).XPos, Vector(3).Ypos)-(Vector(4).XPos, Vector(4).Ypos), 8
 LINE (Vector(2).XPos, Vector(2).Ypos)-(Vector(4).XPos, Vector(4).Ypos), 8
 LINE (Vector(1).XPos, Vector(1).Ypos)-(Vector(4).XPos, Vector(4).Ypos), 8
 LINE (Vector(2).XPos, Vector(2).Ypos)-(Vector(3).XPos, Vector(3).Ypos), 8
RETURN

LED:
    SlowLed% = SlowLed% + 1
    IF SlowLed% = 32767 THEN SlowLed% = 0
    IF SlowLed% \ leddelay% = SlowLed% / leddelay% THEN
      IF CurLed% = 3 THEN Send% = &H10: CurLed% = 1: GOTO NoBug
      IF CurLed% = 2 THEN Send% = &H40: CurLed% = 3
      IF CurLed% = 1 THEN Send% = &H20: CurLed% = 2
NoBug:
       DEF SEG = 0
       Status% = PEEK(&H417)
       POKE &H417, (Status% XOR Send%)
    END IF
RETURN

InitOptical:
SCREEN , , 0, 0
CLS
FOR Size% = 1 TO 100 STEP 7
 CIRCLE (160, 100), Size%, 15
NEXT
GET (59, 16)-(261, 185), Circ%
PCOPY 0, 5
Mode% = 1
x% = 20
RETURN


Optical:
   PCOPY 5, 2
   PUT (x%, 16), Circ%, OR
   SELECT CASE Mode%
    CASE 1: x% = x% + 1
    CASE 2: x% = x% - 1
   END SELECT
   SELECT CASE x%
    CASE IS >= 100: Mode% = 2
    CASE IS <= 20: Mode% = 1
   END SELECT
RETURN


StarWarp:
 FOR TIMes% = 1 TO SMax%
   PSET (Stars(TIMes%).XPos, Stars(TIMes%).Ypos), 0
   Stars(TIMes%).Active = Stars(TIMes%).Active + 1
   SELECT CASE Stars(TIMes%).Dir
     CASE 1: Stars(TIMes%).XPos = Stars(TIMes%).XPos - Stars(TIMes%).Xincr
             Stars(TIMes%).Ypos = Stars(TIMes%).Ypos - Stars(TIMes%).yincr
     CASE 2: Stars(TIMes%).XPos = Stars(TIMes%).XPos + Stars(TIMes%).Xincr
             Stars(TIMes%).Ypos = Stars(TIMes%).Ypos - Stars(TIMes%).yincr
     CASE 3: Stars(TIMes%).XPos = Stars(TIMes%).XPos - Stars(TIMes%).Xincr
             Stars(TIMes%).Ypos = Stars(TIMes%).Ypos + Stars(TIMes%).yincr
     CASE 4: Stars(TIMes%).XPos = Stars(TIMes%).XPos + Stars(TIMes%).Xincr
             Stars(TIMes%).Ypos = Stars(TIMes%).Ypos + Stars(TIMes%).yincr
    END SELECT
    SELECT CASE Stars(TIMes%).XPos
     CASE IS <= 0, IS >= 320: GOSUB ReGenerate
    END SELECT
    SELECT CASE Stars(TIMes%).Ypos
     CASE IS <= 0, IS >= 200: GOSUB ReGenerate
    END SELECT
    SELECT CASE Stars(TIMes%).Active
     CASE Stars(TIMes%).Switcher: Stars(TIMes%).Size = Stars(TIMes%).Size + 1
                                  Stars(TIMes%).Active = 0
    END SELECT
    SELECT CASE Stars(TIMes%).Size
     CASE 5: GOSUB ReGenerate
    END SELECT
       Stars(TIMes%).Xincr = Stars(TIMes%).Xincr + Stars(TIMes%).Xincr * .08
       Stars(TIMes%).yincr = Stars(TIMes%).yincr + Stars(TIMes%).yincr * .08
   PSET (Stars(TIMes%).XPos, Stars(TIMes%).Ypos), 15
  NEXT TIMes%
RETURN


PlotStart:
        FOR T% = 1 TO 2
         Void% = RandNum(2)
         PlusMinus% = RandNum(10)
          SELECT CASE T%
           CASE 1: Acr% = Void%
                   SELECT CASE Void%
                     CASE 1: Stars(TIMes%).XPos = 160 + PlusMinus%
                     CASE 2: Stars(TIMes%).XPos = 160 - PlusMinus%
                   END SELECT
           CASE 2: Vert% = Void%
                   SELECT CASE Void%
                     CASE 1: Stars(TIMes%).Ypos = 100 + PlusMinus%
                     CASE 2: Stars(TIMes%).Ypos = 100 - PlusMinus%
                   END SELECT
          END SELECT
        NEXT
 SELECT CASE Vert%
  CASE 1: IF Acr% = 1 THEN Stars(TIMes%).Dir = 4 ELSE Stars(TIMes%).Dir = 3
  CASE 2: IF Acr% = 1 THEN Stars(TIMes%).Dir = 2 ELSE Stars(TIMes%).Dir = 1
 END SELECT
RETURN

ReGenerate:
       GOSUB PlotStart
       Stars(TIMes%).Ypos = RandNum(5) + 100
       Stars(TIMes%).Size = 0
       Stars(TIMes%).Active = 0
       Stars(TIMes%).Xincr = RND(1) * RandNum(1)
       Stars(TIMes%).yincr = RND(1) * RandNum(1)
       RETURN

SquareBouncer:
FOR TIMes% = 1 TO NumPoints%
PSET (Points(TIMes%).XPos, Points(TIMes%).Ypos), 0

 SELECT CASE Points(TIMes%).Dir
    CASE 1: Points(TIMes%).XPos = Points(TIMes%).XPos - Points(TIMes%).Xincr
            Points(TIMes%).Ypos = Points(TIMes%).Ypos - Points(TIMes%).yincr
    CASE 2: Points(TIMes%).XPos = Points(TIMes%).XPos + Points(TIMes%).Xincr
            Points(TIMes%).Ypos = Points(TIMes%).Ypos - Points(TIMes%).yincr
    CASE 3: Points(TIMes%).XPos = Points(TIMes%).XPos - Points(TIMes%).Xincr
            Points(TIMes%).Ypos = Points(TIMes%).Ypos + Points(TIMes%).yincr
    CASE 4: Points(TIMes%).XPos = Points(TIMes%).XPos + Points(TIMes%).Xincr
            Points(TIMes%).Ypos = Points(TIMes%).Ypos + Points(TIMes%).yincr
 END SELECT

  SELECT CASE Points(TIMes%).XPos
   CASE IS <= MaxWest% + 2: SELECT CASE Points(TIMes%).Dir
                          CASE 1: Points(TIMes%).Dir = 2
                          CASE 3: Points(TIMes%).Dir = 4
                        END SELECT
   CASE IS >= Maxeast% - 2: SELECT CASE Points(TIMes%).Dir
                          CASE 2: Points(TIMes%).Dir = 1
                          CASE 4: Points(TIMes%).Dir = 3
                        END SELECT
  END SELECT

  SELECT CASE Points(TIMes%).Ypos
   CASE IS <= MaxNorth% + 2: SELECT CASE Points(TIMes%).Dir
                          CASE 1: Points(TIMes%).Dir = 3
                          CASE 2: Points(TIMes%).Dir = 4
                         END SELECT
   CASE IS >= Maxsouth% - 2: SELECT CASE Points(TIMes%).Dir
                          CASE 3: Points(TIMes%).Dir = 1
                          CASE 4: Points(TIMes%).Dir = 2
                         END SELECT
  END SELECT


PSET (Points(TIMes%).XPos, Points(TIMes%).Ypos), Points(TIMes%).Col

NEXT
IF slow% / scrollspeed% - 1 = slow% \ scrollspeed% - 1 THEN
SELECT CASE Trip%
 CASE 1: LINE (MaxWest%, MaxNorth%)-(Maxeast%, Maxsouth%), 0, B
         MaxWest% = MaxWest% + 1: MaxNorth% = MaxNorth% + 1
         Maxeast% = Maxeast% - 1: Maxsouth% = Maxsouth% - 1
 CASE 2: LINE (MaxWest%, MaxNorth%)-(Maxeast%, Maxsouth%), 0, B
         MaxWest% = MaxWest% - 1: MaxNorth% = MaxNorth% - 1
         Maxeast% = Maxeast% + 1: Maxsouth% = Maxsouth% + 1
END SELECT
END IF
slow% = slow% + 1
IF slow% = 32767 THEN slow% = 0
STrip% = STrip% + 1
IF STrip% >= 60 AND Trip% = 1 THEN Trip% = 2: STrip% = 0
IF STrip% >= 60 AND Trip% = 2 THEN Trip% = 1: STrip% = 0

LINE (MaxWest%, MaxNorth%)-(Maxeast%, Maxsouth%), 15, B

RETURN






DATA " Hello, and welcome to  Gravity, a Molna"
DATA "r \ Kucalaba Productions demo.      If y"
DATA "ou are running this on anything under a "
DATA "486 dx 33, then it will really suck, esp"
DATA "ecially if your are running it through Q"
DATA "Basic and not QuickBASIC...             "
DATA "This is a little different from other de"
DATA "mos in that it is really many demos in o"
DATA "ne. Read the controls!!................."
DATA "  Here's how you control the demo : Hit "
DATA "a key to view the first special page. Af"
DATA "ter you are done looking at that, hit a "
DATA "key to return here. Then, to exit, hit e"
DATA "scape to leave the program, or hit any o"
DATA "ther key to view the next special page. "
DATA "After you have seen all the special page"
DATA "s, (there are 2 of them) Gravity will lo"
DATA "op you back to the first one, and so on."
DATA " We recommend that you view each special"
DATA " page, because they are all pretty cool "
DATA "And worth your time. Unfortunately, the "
DATA "Scroller's speed is inconsistent with th"
DATA "e main page because of the variation in "
DATA "calculations needed. However, we tried t"
DATA "o remedy this by changing delay values a"
DATA "t certain times, but we can't guarantee "
DATA "anything. To contact us, email at: Blood"
DATA " 225 (America Online), or blood225@aol.c"
DATA "om. (everyone else) We would love to rec"
DATA "eive your comments, suggestions, or comp"
DATA "laints. Send 'em on over!               "
DATA "Now, a little more info on each demo : M"
DATA "ain Page (3D Star Field, Triangular Pris"
DATA "m) The 3D Star Field didn't quite work o"
DATA "ut how we hoped, but it ain't that bad. "
DATA "The prism was a spawn of a different pro"
DATA "gram we made. 1) Circular Optical Illusi"
DATA "on : Simple routine, we got the idea fro"
DATA "m some Finnish demo, they all have these"
DATA " things. ...aren't you glad you're getti"
DATA "ng the life story of this program?... 2)"
DATA "Gravitational Pixels : We made this from"
DATA " trial and error. It was the main point "
DATA "of the demo, but a friend advised us tha"
DATA "t we should use something else so we sla"
DATA "pped the star field on. ....did you noti"
DATA "the flashing Lock keys yet?... 3) Bounci"
DATA "ng pixels within changing box : The boun"
DATA "cing part was made a really long time ag"
DATA "o, and we couldn't think of anything els"
DATA "e to put in the demo, so we added a chan"
DATA "ging barrier type thing, which makes it "
DATA "a little better. Now, for the credits..."
DATA "Main Programmer : Luke Molnar  Ideas : L"
DATA "uke Molnar, Luke Kucalaba  A Molnar \ Ku"
DATA "calaba Productions' Presentation. Watch "
DATA "for new M \ K games coming soon! Visit u"
DATA "s on the Internet : WWW : http://members"
DATA ".aol.com/blood225   FTP : ftp://members."
DATA "aol.com/blood225. Now, some greetings..."
DATA "Ben Johnson, Ansolaris, ReinierZ, SWC Te"
DATA "am 2, Yipyow, MarKKKim, and everyone tha"
DATA "t had enough patience to sit through thi"
DATA "s whole freakin thing! Do you realize th"
DATA "at you saw 2, 560 characters scroll by? "
DATA "          Now Looping!                  "






Initialize:
            
FOR T = 1 TO Max%                     ' Gravity Bouncing pixel initialization
 DO UNTIL Pixel(T).gradient < .3 AND Pixel(T).gradient >= .1
  Pixel(T).gradient = RND(1)
 LOOP
  Pixel(T).vdir = RandNum(2)
  Pixel(T).hdir = RandNum(2)
  Pixel(T).x = RandNum(320)
  Pixel(T).Col = RandNum(16)
NEXT


FOR T = 1 TO 4                        ' Vector Initialization
 Vector(T).XPos = RandNum(320)
 Vector(T).Ypos = RandNum(200)
 Vector(T).Dir = RandNum(4)
 Vector(T).Xincr = RandNum(4) + 1
 Vector(T).yincr = RandNum(4) + 1
NEXT

CurLed% = 1                           ' LED \ Lock Flashing Initialization
leddelay% = scrollspeed%
DEF SEG = &H40
POKE &H17, PEEK(&H17) AND 223
POKE &H17, PEEK(&H17) AND 171
POKE &H17, PEEK(&H17) AND 275
DEF SEG


                                            
FOR TIMes% = 1 TO SMax%               ' 3D Starfield Initialization
 GOSUB PlotStart
 Stars(TIMes%).Size = 0
 Stars(TIMes%).Xincr = RND(1) * RandNum(2)
 Stars(TIMes%).yincr = RND(1) * RandNum(2)
 Stars(TIMes%).Switcher = RandNum(27) + 20
NEXT TIMes%


MaxNorth% = 20                        ' Bouncing Pixels Initialization
Maxsouth% = 199
MaxWest% = 0
Maxeast% = 319
Trip% = 1
FOR TIMes% = 1 TO NumPoints%
 Points(TIMes%).XPos = RandNum(Maxeast%)
 Points(TIMes%).Ypos = RandNum(190) + 10
 Points(TIMes%).Col = RandNum(15)
 Points(TIMes%).Dir = RandNum(4)
 Points(TIMes%).Xincr = RandNum(2)
 Points(TIMes%).yincr = RandNum(2)
NEXT TIMes%



up% = 0                               ' General Intialization
down% = 200
left% = 0
right% = 320
TPos% = 0
Upd% = 0
PagePtr% = 1
MaxPages% = 4
OUT &H3C8, 1
 OUT &H3C9, 0
 OUT &H3C9, 0
 OUT &H3C9, 63
COLOR 1
RETURN

REM $STATIC
SUB CloseUp
CLS
SCREEN 0
WIDTH 80
DEF SEG = &H40: POKE &H17, PEEK(&H17) AND 223  'turns off caps lock
DEF SEG = &H40: POKE &H17, PEEK(&H17) AND 171  'turns off num lock
DEF SEG = &H40: POKE &H17, PEEK(&H17) AND 275  'turns off scroll lock
SYSTEM
END SUB

FUNCTION GetDelay%
CLS
SCREEN 0
WIDTH 80
COLOR 13
PRINT "G R A V I T Y  by ";
COLOR 12
PRINT "Molnar \ Kucalaba Productions!"
COLOR 14
PRINT
PRINT "Please select the computer speed that best fits you : "
PRINT
COLOR 10
PRINT "1) 386"
PRINT "2) 486 dx 33"
PRINT "3) 486 dx 66"
PRINT "4) 586 (pentium) 75"
PRINT "5) Pentium 100"
PRINT "6) Pentium 133"
PRINT "7) Pentium 166"
PRINT "8) Something ungodly fast"
INPUT Choice%
SELECT CASE Choice%
 CASE 1: GetDelay% = 2
 CASE 2: GetDelay% = 3
 CASE 3: GetDelay% = 4
 CASE 4: GetDelay% = 5
 CASE 5: GetDelay% = 6
 CASE 6: GetDelay% = 7
 CASE 7: GetDelay% = 8
 CASE 8: GetDelay% = 9
 CASE ELSE: GetDelay% = 4
END SELECT
END FUNCTION

DEFSNG A-Z
FUNCTION RandNum (u%)
RandNum = INT(RND * u%) + 1
END FUNCTION

