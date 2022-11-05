DEFINT A-Z

DECLARE SUB buttonEnd ()
DECLARE SUB buttonEndPush ()
DECLARE SUB buttonHelp ()
DECLARE SUB buttonHelpPush ()
DECLARE SUB buttonNew ()
DECLARE SUB buttonNewPush ()
DECLARE SUB buttonOK ()
DECLARE SUB buttonOKPush ()
DECLARE SUB buttonPlay ()
DECLARE SUB buttonPlayPush ()
DECLARE SUB buttonQuit ()
DECLARE SUB buttonQuitPush ()
DECLARE SUB buttonSetup ()
DECLARE SUB buttonSetupPush ()
DECLARE SUB confirm ()
DECLARE SUB drawMenu ()
DECLARE SUB drawView ()
DECLARE SUB instructions ()
DECLARE SUB intro ()
DECLARE SUB mazeIni ()
DECLARE SUB mouse (cx, dx, bx)
DECLARE SUB mousePointer (sw)
DECLARE SUB playMaze ()
DECLARE SUB setup ()

COMMON SHARED x, y, u$, l$, r$, d$, facing$, facing2$, coordinates$, direction$, mudMap$

DIM SHARED maze(26, 26)

DIM SHARED xVal(25)
DIM SHARED yVal(25)

DIM SHARED col(4)
DIM SHARED y2(4)

DIM SHARED text(50) AS STRING

DIM SHARED a(9)                         'Set up array for code
                                                         
DEF SEG = VARSEG(a(0))                  'Get array segment (nnnn:    )
                                        '    (two 8 bit)
FOR i = 0 TO 17                         'length of DATA to
   READ r                               'read
   POKE VARPTR(a(0)) + i, r             'into array/2 (nnnn:iiii) (one 8 bit)
NEXT i                                  'until 17

ON ERROR GOTO errorTrap

u$ = CHR$(0) + CHR$(72)
l$ = CHR$(0) + CHR$(75)
r$ = CHR$(0) + CHR$(77)
d$ = CHR$(0) + CHR$(80)

OPEN "amazeing.ini" FOR INPUT AS #1

FOR i = 1 TO 4
   INPUT #1, col(i)
NEXT i

INPUT #1, coordinates$
INPUT #1, direction$
INPUT #1, mudMap$

CLOSE #1

RANDOMIZE TIMER

mousePointer 0

SCREEN 12
CLS

intro

WINDOW SCREEN (-320, -240)-(320, 240)

DO
  mazeIni

  facing$ = "down": facing2$ = "South"

  x = 1: y = 1

  drawMenu
  playMaze

  FOR i = 1 TO 25
     FOR j = 1 TO 25
        maze(i, j) = 0
     NEXT j
  NEXT i

  CLS
LOOP

errorTrap:
col(1) = 9
col(2) = 1
col(3) = 11
col(4) = 7

coordinates$ = "yes"
direction$ = "yes"
mudMap$ = "yes"

OPEN "amazeing.ini" FOR OUTPUT AS #1

WRITE #1, col(1), col(2), col(3), col(4)

WRITE #1, coordinates$
WRITE #1, direction$
WRITE #1, mudMap$

CLOSE #1

RESUME NEXT

DATA &HB8,&H00,&H00   : ' mov  AX,[n]       [Swap code-(L),(H)] in AX
DATA &H55             : ' push BP           Save BP
DATA &H8B,&HEC        : ' mov  BP,SP        Get BP to (variable) Seg
DATA &HCD,&H33        : ' int  33           Interrupt 33
DATA &H92             : ' xchg AX,[reg]     [Swap code-reg] in AX
DATA &H8B,&H5E,&H06   : ' mov  BX,[BP+6]    Point to (variable)
DATA &H89,&H07        : ' mov  [BX],AX      Put AX in (variable)
DATA &H5D             : ' pop  BP           Restore BP
DATA &HCA,&H02,&H00   : ' ret  2            Far return

SUB buttonEnd

LINE (500, 400)-(600, 450), 10, BF
LINE (500, 400)-(599, 449), 2, BF
LINE (501, 401)-(599, 449), 5, BF

LINE (520, 405)-(520, 445), 0
LINE (520, 405)-(535, 405), 0
LINE (520, 425)-(528, 425), 0
LINE (520, 445)-(535, 445), 0

LINE (540, 405)-(540, 445), 0
LINE (540, 405)-(555, 445), 0
LINE (555, 445)-(555, 405), 0

LINE (560, 405)-(560, 445), 0
CIRCLE (560, 425), 20, 0, 4.7, 1.5, 1.3

END SUB

SUB buttonEndPush

LINE (500, 400)-(600, 450), 2, BF
LINE (500, 400)-(599, 449), 10, BF
LINE (501, 401)-(599, 449), 5, BF

LINE (520, 405)-(520, 445), 0
LINE (520, 405)-(535, 405), 0
LINE (520, 425)-(528, 425), 0
LINE (520, 445)-(535, 445), 0

LINE (540, 405)-(540, 445), 0
LINE (540, 405)-(555, 445), 0
LINE (555, 445)-(555, 405), 0

LINE (560, 405)-(560, 445), 0
CIRCLE (560, 425), 20, 0, 4.7, 1.5, 1.3

END SUB

SUB buttonHelp

LINE (350, 400)-(450, 450), 10, BF
LINE (350, 400)-(449, 449), 2, BF
LINE (351, 401)-(449, 449), 5, BF

LINE (360, 405)-(360, 445), 0
LINE (375, 405)-(375, 445), 0
LINE (360, 425)-(375, 425), 0

LINE (380, 405)-(380, 445), 0
LINE (380, 405)-(395, 405), 0
LINE (380, 425)-(388, 425), 0
LINE (380, 445)-(395, 445), 0

LINE (400, 405)-(400, 445), 0
LINE (400, 445)-(415, 445), 0

LINE (420, 405)-(420, 445), 0
CIRCLE (420, 415), 15, 0, 4.7, 1.6, .7

END SUB

SUB buttonHelpPush

LINE (350, 400)-(450, 450), 2, BF
LINE (350, 400)-(449, 449), 10, BF
LINE (351, 401)-(449, 449), 5, BF

LINE (360, 405)-(360, 445), 0
LINE (375, 405)-(375, 445), 0
LINE (360, 425)-(375, 425), 0

LINE (380, 405)-(380, 445), 0
LINE (380, 405)-(395, 405), 0
LINE (380, 425)-(388, 425), 0
LINE (380, 445)-(395, 445), 0

LINE (400, 405)-(400, 445), 0
LINE (400, 445)-(415, 445), 0

LINE (420, 405)-(420, 445), 0
CIRCLE (420, 415), 15, 0, 4.7, 1.6, .7

END SUB

SUB buttonNew

LINE (-310, -230)-(-10, -190), 10, BF
LINE (-310, -230)-(-11, -191), 2, BF
LINE (-309, -229)-(-11, -191), 5, BF

LINE (-260, -225)-(-260, -195), 0
LINE (-260, -225)-(-200, -195), 0
LINE (-200, -195)-(-200, -225), 0

LINE (-190, -225)-(-190, -195), 0
LINE (-190, -225)-(-130, -225), 0
LINE (-190, -210)-(-160, -210), 0
LINE (-190, -195)-(-130, -195), 0

LINE (-120, -225)-(-100, -195), 0
LINE (-100, -195)-(-90, -210), 0
LINE (-90, -210)-(-80, -195), 0
LINE (-80, -195)-(-60, -225), 0

END SUB

SUB buttonNewPush

LINE (-310, -230)-(-10, -190), 2, BF
LINE (-310, -230)-(-11, -191), 10, BF
LINE (-309, -229)-(-11, -191), 5, BF

LINE (-260, -225)-(-260, -195), 0
LINE (-260, -225)-(-200, -195), 0
LINE (-200, -195)-(-200, -225), 0

LINE (-190, -225)-(-190, -195), 0
LINE (-190, -225)-(-130, -225), 0
LINE (-190, -210)-(-160, -210), 0
LINE (-190, -195)-(-130, -195), 0

LINE (-120, -225)-(-100, -195), 0
LINE (-100, -195)-(-90, -210), 0
LINE (-90, -210)-(-80, -195), 0
LINE (-80, -195)-(-60, -225), 0

END SUB

SUB buttonOK

LINE (380, 250)-(550, 340), 0, BF
LINE (380, 250)-(549, 339), 8, BF
LINE (380, 250)-(548, 338), 15, BF
LINE (381, 251)-(548, 338), 7, BF

CIRCLE (440, 295), 35, 0, , , 2

LINE (480, 261)-(480, 329), 0
LINE (514, 261)-(480, 295), 0
LINE (514, 329)-(480, 295), 0

END SUB

SUB buttonOKPush

LINE (380, 250)-(550, 340), 0, BF
LINE (381, 251)-(550, 340), 8, BF
LINE (382, 252)-(550, 340), 15, BF
LINE (382, 252)-(549, 339), 7, BF

CIRCLE (441, 296), 35, 0, , , 2

LINE (481, 262)-(481, 330), 0
LINE (515, 262)-(481, 296), 0
LINE (515, 330)-(481, 296), 0

END SUB

SUB buttonPlay

LINE (50, 400)-(150, 450), 10, BF
LINE (50, 400)-(149, 449), 2, BF
LINE (51, 401)-(149, 449), 5, BF

LINE (60, 405)-(60, 445), 0
CIRCLE (60, 415), 15, 0, 4.8, 1.6, .75

LINE (80, 405)-(80, 445), 0
LINE (80, 445)-(95, 445), 0

LINE (100, 445)-(108, 405), 0
LINE (108, 405)-(116, 445), 0
LINE (104, 425)-(111, 425), 0

LINE (121, 405)-(129, 425), 0
LINE (129, 425)-(137, 405), 0
LINE (129, 425)-(129, 445), 0

END SUB

SUB buttonPlayPush

LINE (50, 400)-(150, 450), 2, BF
LINE (50, 400)-(149, 449), 10, BF
LINE (51, 401)-(149, 449), 5, BF

LINE (60, 405)-(60, 445), 0
CIRCLE (60, 415), 15, 0, 4.8, 1.6, .75

LINE (80, 405)-(80, 445), 0
LINE (80, 445)-(95, 445), 0

LINE (100, 445)-(108, 405), 0
LINE (108, 405)-(116, 445), 0
LINE (104, 425)-(111, 425), 0

LINE (121, 405)-(129, 425), 0
LINE (129, 425)-(137, 405), 0
LINE (129, 425)-(129, 445), 0

END SUB

SUB buttonQuit

LINE (310, -230)-(10, -190), 10, BF
LINE (309, -230)-(10, -191), 2, BF
LINE (309, -229)-(11, -191), 5, BF

CIRCLE (70, -210), 25, 0, , , .65
LINE (70, -210)-(95, -195), 0

LINE (105, -225)-(105, -200), 0
LINE (155, -225)-(155, -200), 0
CIRCLE (130, -209), 30, 0, 3.7, 5.7, .5

LINE (165, -225)-(215, -225), 0
LINE (165, -195)-(215, -195), 0
LINE (190, -225)-(190, -195), 0

LINE (225, -225)-(275, -225), 0
LINE (250, -225)-(250, -195), 0

END SUB

SUB buttonQuitPush

LINE (310, -230)-(10, -190), 2, BF
LINE (309, -230)-(10, -191), 10, BF
LINE (309, -229)-(11, -191), 5, BF

CIRCLE (70, -210), 25, 0, , , .65
LINE (70, -210)-(95, -195), 0

LINE (105, -225)-(105, -200), 0
LINE (155, -225)-(155, -200), 0
CIRCLE (130, -209), 30, 0, 3.7, 5.7, .5

LINE (165, -225)-(215, -225), 0
LINE (165, -195)-(215, -195), 0
LINE (190, -225)-(190, -195), 0

LINE (225, -225)-(275, -225), 0
LINE (250, -225)-(250, -195), 0

END SUB

SUB buttonSetup

LINE (200, 400)-(300, 450), 10, BF
LINE (200, 400)-(299, 449), 2, BF
LINE (201, 401)-(299, 449), 5, BF

CIRCLE (220, 415), 10, 0, 0, 4.6, 2
CIRCLE (220, 435), 10, 0, 3, 1.6, 2

LINE (230, 405)-(230, 445), 0
LINE (230, 405)-(240, 405), 0
LINE (230, 425)-(235, 425), 0
LINE (230, 445)-(240, 445), 0

LINE (245, 405)-(255, 405), 0
LINE (250, 405)-(250, 445), 0

LINE (260, 405)-(260, 440), 0
LINE (270, 405)-(270, 440), 0
CIRCLE (265, 435), 10, 0, 3, 0, 2

LINE (275, 405)-(275, 445), 0
CIRCLE (275, 415), 10, 0, 4.7, 1.6

END SUB

SUB buttonSetupPush

LINE (200, 400)-(300, 450), 2, BF
LINE (200, 400)-(299, 449), 10, BF
LINE (201, 401)-(299, 449), 5, BF

CIRCLE (220, 415), 10, 0, 0, 4.6, 2
CIRCLE (220, 435), 10, 0, 3, 1.6, 2

LINE (230, 405)-(230, 445), 0
LINE (230, 405)-(240, 405), 0
LINE (230, 425)-(235, 425), 0
LINE (230, 445)-(240, 445), 0

LINE (245, 405)-(255, 405), 0
LINE (250, 405)-(250, 445), 0

LINE (260, 405)-(260, 440), 0
LINE (270, 405)-(270, 440), 0
CIRCLE (265, 435), 10, 0, 3, 0, 2

LINE (275, 405)-(275, 445), 0
CIRCLE (275, 415), 10, 0, 4.7, 1.6

END SUB

SUB confirm

LINE (-100, -50)-(100, 50), 8, BF
LINE (-100, -50)-(99, 49), 15, BF
LINE (-99, -49)-(99, 49), 7, BF
LINE (-95, -45)-(95, 45), 8, BF
LINE (-94, -44)-(95, 45), 15, BF
LINE (-94, -44)-(94, 44), 0, BF

LOCATE 14, 30: PRINT "Are you sure you want"

LINE (-75, 15)-(-60, 30), 15, B
LINE (5, 15)-(20, 30), 15, B

LOCATE 17, 34: PRINT "Yes"
LOCATE 17, 44: PRINT "No"

END SUB

SUB drawMenu

LINE (-320, -180)-(320, -180), 15
LINE (-320, 180)-(320, 180), 15

buttonNew
buttonQuit

END SUB

SUB drawView

LINE (-320, -179)-(320, 179), 0, BF
LINE (-320, -179)-(320, -179), col(3)
LINE (-320, 179)-(320, 179), col(4)
LINE (-320, -179)-(-320, 179), 15
LINE (320, -179)-(320, 179), 15

dist = 1
endX = 320
endY = -170

DO
  left = 0: right = 0: back = 0: front = 0
 
  SELECT CASE facing$
         CASE "down"
             IF x = 1 THEN
               right = 0
             ELSE
               IF maze(x - 1, y + dist - 1) = 1 THEN
                 right = 1
               ELSE
                 right = 0
               END IF
             END IF

             IF y - dist + 1 = 1 THEN
               back = 0
             ELSE
               IF maze(x, y - 1 + dist - 1) = 1 THEN
                 back = 1
               ELSE
                 back = 0
               END IF
             END IF

             IF x = 25 THEN
               left = 0
             ELSE
               IF maze(x + 1, y + dist - 1) = 1 THEN
                 left = 1
               ELSE
                 left = 0
               END IF
             END IF

             IF y + dist - 1 = 25 THEN
               front = 0
             ELSE
               IF maze(x, y + 1 + dist - 1) = 1 THEN
                 front = 1
               ELSE
                 front = 0
               END IF
             END IF
         CASE "right"
             IF x - dist + 1 = 1 THEN
               back = 0
             ELSE
               IF maze(x - 1 + dist - 1, y) = 1 THEN
                 back = 1
               ELSE
                 back = 0
               END IF
             END IF

             IF y = 1 THEN
               left = 0
             ELSE
               IF maze(x + dist - 1, y - 1) = 1 THEN
                 left = 1
               ELSE
                 left = 0
               END IF
             END IF

             IF x + dist - 1 = 25 THEN
               front = 0
             ELSE
               IF maze(x + 1 + dist - 1, y) = 1 THEN
                 front = 1
               ELSE
                 front = 0
               END IF
             END IF

             IF y = 25 THEN
               right = 0
             ELSE
               IF maze(x + dist - 1, y + 1) = 1 THEN
                 right = 1
               ELSE
                 right = 0
               END IF
             END IF
         CASE "left"
             IF x - dist + 1 = 1 THEN
               front = 0
             ELSE
               IF maze(x - 1 - dist + 1, y) = 1 THEN
                 front = 1
               ELSE
                 front = 0
               END IF
             END IF

             IF y = 1 THEN
               right = 0
             ELSE
               IF maze(x - dist + 1, y - 1) = 1 THEN
                 right = 1
               ELSE
                 right = 0
               END IF
             END IF

             IF x + dist - 1 = 25 THEN
               back = 0
             ELSE
               IF maze(x + 1 - dist + 1, y) = 1 THEN
                 back = 1
               ELSE
                 back = 0
               END IF
             END IF

             IF y = 25 THEN
               left = 0
             ELSE
               IF maze(x - dist + 1, y + 1) = 1 THEN
                 left = 1
               ELSE
                 left = 0
               END IF
             END IF
         CASE "up"
             IF x = 1 THEN
               left = 0
             ELSE
               IF maze(x - 1, y - dist + 1) = 1 THEN
                 left = 1
               ELSE
                 left = 0
               END IF
             END IF
            
             IF y - dist + 1 = 1 THEN
               front = 0
             ELSE
               IF maze(x, y - 1 - dist + 1) = 1 THEN
                 front = 1
               ELSE
                 front = 0
               END IF
             END IF
            
             IF x = 25 THEN
               right = 0
             ELSE
               IF maze(x + 1, y - dist + 1) = 1 THEN
                 right = 1
               ELSE
                 right = 0
               END IF
             END IF
            
             IF y + dist - 1 = 25 THEN
               back = 0
             ELSE
               IF maze(x, y + 1 - dist + 1) = 1 THEN
                 back = 1
               ELSE
                 back = 0
               END IF
             END IF
  END SELECT

  x1 = 200 / dist
  y1 = -90 - 50 / dist

  LINE (-x1, y1)-(-endX, endY), 15
  LINE (-x1, ABS(y1))-(-endX, ABS(endY)), 15
  LINE (x1, y1)-(endX, endY), 15
  LINE (x1, ABS(y1))-(endX, ABS(endY)), 15
  LINE (-x1, y1)-(x1, y1), col(3)
  LINE (-x1, ABS(y1))-(x1, ABS(y1)), col(4)
  LINE (-x1, y1)-(-x1, ABS(y1)), 15
  LINE (x1, y1)-(x1, ABS(y1)), 15
  PAINT (0, y1 - 1), col(3), 15
  PAINT (0, ABS(y1) + 1), col(4), 15
  PAINT (-x1 - 1, y1 + 1), col(1), 15
  PAINT (x1 + 1, y1 + 1), col(1), 15
  LINE (-x1, y1 + 1)-(-x1, ABS(y1) - 1), col(1)
  LINE (x1, y1 + 1)-(x1, ABS(y1) - 1), col(1)
 
  IF left = 1 THEN
    LINE (-x1, y1)-(-endX, y1), 15
    LINE (-x1, ABS(y1))-(-endX, ABS(y1)), 15
    LINE (-x1, y1)-(-x1, ABS(y1)), 15
    LINE (-endX, endY)-(-endX, ABS(endY)), 15
    PAINT (-x1 - 1, y1 + 1), col(2), 15
    PAINT (-endX + 1, y1 - 1), col(3), 15
    PAINT (-endX + 1, ABS(y1) + 1), col(4), 15
    LINE (-x1, y1)-(-endX, endY), col(3)
    LINE (-x1, ABS(y1))-(-endX, ABS(endY)), col(4)
  END IF
 
  IF right = 1 THEN
    LINE (x1, y1)-(endX, y1), 15
    LINE (x1, ABS(y1))-(endX, ABS(y1)), 15
    LINE (x1, y1)-(x1, ABS(y1)), 15
    LINE (endX, endY)-(endX, ABS(endY)), 15
    PAINT (x1 + 1, y1 + 1), col(2), 15
    PAINT (endX - 1, y1 - 1), col(3), 15
    PAINT (endX - 1, ABS(y1) + 1), col(4), 15
    LINE (x1, y1)-(endX, endY), col(3)
    LINE (x1, ABS(y1))-(endX, ABS(endY)), col(4)
  END IF
 
  dist = dist + 1
  endX = x1 - 1
  endY = y1
LOOP UNTIL front = 0

LINE (-x1 + 1, y1 + 1)-(x1 - 1, ABS(y1) - 1), col(2), BF

IF facing$ = "right" THEN
  IF y = 25 THEN
    IF x + dist - 1 = 26 THEN
      CIRCLE (0, 0), 150 / dist, 0, , , 2
      PAINT (0, 0), 0, 0
    END IF
  END IF
ELSEIF facing$ = "down" THEN
  IF x = 25 THEN
    IF y + dist - 1 = 26 THEN
      CIRCLE (0, 0), 150 / dist, 0, , , 2
      PAINT (0, 0), 0, 0
    END IF
  END IF
END IF

END SUB

SUB instructions

lineNo = 1

text(1) = "                      Amazeing Instructions                       "
text(2) = "                                                                  "
text(3) = "     The object of Amazeing is to find your way through a complex "
text(4) = "three dimensional maze.  The maze is 25 squares by 25 and the     "
text(5) = "entrance is always located at the square on row 1, column 1 or    "
text(6) = "at coordinates (1, 1).  The exit of the maze is always located at "
text(7) = "the square on row 25, column 25 or coordinates (25, 25).  The     "
text(8) = "object of the game is to find your way to coordinates (25, 25).   "
text(9) = "When the exit is in sight you will see a hole in the wall which   "
text(10) = "you must escape through.  Once through the hole, you finish the   "
text(11) = "maze.                                                             "
text(12) = "                                                                  "
text(13) = "The Controls:                                                     "
text(14) = "        Up arrow: move one square forward                         "
text(15) = "        Down arrow: turn around                                   "
text(16) = "        Left arrow: face left                                     "
text(17) = "        Right arrow: face right                                   "
text(18) = "                                                                  "
text(19) = "   NOTE: To quit during a game or to get a new maze if your lost  "
text(20) = "         click with the left mouse button of your mouse on the    "
text(21) = "         buttons at the top of the screen.                        "
text(22) = "                                                                  "
text(23) = "Adjustable Features:                                              "
text(24) = "        Coordinates display: this displays your current position  "
text(25) = "                             in the maze at the bottom left corner"
text(26) = "                             of your screen.                      "
text(27) = "        Direction display: this displays the direction that you   "
text(28) = "                           are heading at any given time in the   "
text(29) = "                           maze (either north, east, south, or    "
text(30) = "                           west).                                 "
text(31) = "        Mud Map: this shows a map of the maze and where you are in"
text(32) = "                 it.  But wait, there's a catch, it only shows    "
text(33) = "                 the places you've already been.                  "
text(34) = "                                                                  "
text(35) = "   To choose whether or not you want these features shown, click  "
text(36) = "   the setup button at the title screen and adjust them by        "
text(37) = "   in the box by their name.  An X in the box indicates that the  "
text(38) = "   item is on.  You can also customize the colors of the walls,   "
text(39) = "   ceiling, and floor.                                            "
text(40) = "                                                                  "
text(41) = "                               ENJOY!                             "

CLS

LINE (50, 50)-(600, 450), 8, BF
LINE (50, 50)-(599, 449), 15, BF
LINE (51, 51)-(599, 449), 7, BF
LINE (55, 55)-(595, 445), 15, BF
LINE (55, 55)-(594, 444), 8, BF
LINE (56, 56)-(594, 444), 0, BF

LINE (55, 400)-(595, 405), 8, BF
LINE (55, 400)-(595, 404), 15, BF
LINE (55, 401)-(595, 404), 7, BF

LOCATE 27, 18: PRINT "Use up and down arrows to scroll, ESC to exit."

DO
  counter = 1

  FOR i = lineNo TO lineNo + 20
     LOCATE counter + 4, 9
     PRINT text(i)
     counter = counter + 1
  NEXT i

  DO: a$ = INKEY$: LOOP UNTIL a$ = ""

  DO
    a$ = INKEY$
  LOOP UNTIL a$ = u$ OR a$ = d$ OR a$ = CHR$(27)

  SELECT CASE a$
         CASE u$
             IF lineNo > 1 THEN
               lineNo = lineNo - 1
             END IF
         CASE d$
             IF lineNo < 21 THEN
               lineNo = lineNo + 1
             END IF
         CASE CHR$(27)
             EXIT DO
  END SELECT

  FOR i = 5 TO 25
     LOCATE i, 9: PRINT SPC(66);
  NEXT i
LOOP UNTIL a$ = CHR$(27)

mousePointer 2

CLS

LINE (50, 150)-(200, 300), 2, BF
LINE (300, 150)-(600, 300), 2, BF
LINE (50, 150)-(200, 50), 2
LINE (200, 50)-(200, 90), 2
LINE (600, 150)-(450, 50), 2
LINE (450, 50)-(450, 105), 2
LINE (200, 50)-(450, 50), 2
LINE (200, 150)-(250, 105), 2
LINE (200, 300)-(250, 240), 2
LINE (250, 105)-(250, 240), 2
LINE (250, 105)-(451, 105), 2
LINE (451, 105)-(451, 150), 2
LINE (250, 240)-(300, 240), 2
LINE (451, 105)-(400, 75), 2
LINE (400, 75)-(400, 105), 2
LINE (400, 75)-(220, 75), 2
LINE (220, 75)-(220, 132), 2
LINE (220, 75)-(160, 120), 2
LINE (160, 120)-(160, 150), 2
PAINT (225, 225), 3, 2
PAINT (275, 200), 3, 2
PAINT (475, 125), 6, 2
PAINT (100, 125), 6, 2
PAINT (175, 125), 5, 2
PAINT (225, 100), 5, 2
PAINT (425, 100), 5, 2
PAINT (300, 70), 10, 2

COLOR 10: LOCATE 21, 35: PRINT "A"
COLOR 6: LOCATE 21, 36: PRINT "m"
COLOR 5: LOCATE 21, 37: PRINT "a"
COLOR 3: LOCATE 21, 38: PRINT "z"
COLOR 2: LOCATE 21, 39: PRINT "e"
COLOR 3: LOCATE 21, 40: PRINT "i"
COLOR 5: LOCATE 21, 41: PRINT "n"
COLOR 6: LOCATE 21, 42: PRINT "g"
COLOR 10: LOCATE 23, 32: PRINT "By"
COLOR 5: LOCATE 23, 35: PRINT "Aaron"
COLOR 2: LOCATE 23, 41: PRINT "Severn "

buttonPlay
buttonSetup
buttonHelp
buttonEnd

COLOR 15

mousePointer 1
mousePointer 3

END SUB

SUB intro

PALETTE 2, 25
PALETTE 3, 20
PALETTE 5, 15
PALETTE 6, 10
PALETTE 10, 5

LINE (50, 150)-(200, 300), 2, BF
LINE (300, 150)-(600, 300), 2, BF
LINE (50, 150)-(200, 50), 2
LINE (200, 50)-(200, 90), 2
LINE (600, 150)-(450, 50), 2
LINE (450, 50)-(450, 105), 2
LINE (200, 50)-(450, 50), 2
LINE (200, 150)-(250, 105), 2
LINE (200, 300)-(250, 240), 2
LINE (250, 105)-(250, 240), 2
LINE (250, 105)-(451, 105), 2
LINE (451, 105)-(451, 150), 2
LINE (250, 240)-(300, 240), 2
LINE (451, 105)-(400, 75), 2
LINE (400, 75)-(400, 105), 2
LINE (400, 75)-(220, 75), 2
LINE (220, 75)-(220, 132), 2
LINE (220, 75)-(160, 120), 2
LINE (160, 120)-(160, 150), 2
PAINT (225, 225), 3, 2
PAINT (275, 200), 3, 2
PAINT (475, 125), 6, 2
PAINT (100, 125), 6, 2
PAINT (175, 125), 5, 2
PAINT (225, 100), 5, 2
PAINT (425, 100), 5, 2
PAINT (300, 70), 10, 2

COLOR 10: LOCATE 21, 35: PRINT "A"
COLOR 6: LOCATE 21, 36: PRINT "m"
COLOR 5: LOCATE 21, 37: PRINT "a"
COLOR 3: LOCATE 21, 38: PRINT "z"
COLOR 2: LOCATE 21, 39: PRINT "e"
COLOR 3: LOCATE 21, 40: PRINT "i"
COLOR 5: LOCATE 21, 41: PRINT "n"
COLOR 6: LOCATE 21, 42: PRINT "g"
COLOR 10: LOCATE 23, 32: PRINT "By"
COLOR 5: LOCATE 23, 35: PRINT "Aaron"
COLOR 2: LOCATE 23, 41: PRINT "Severn "
                               
buttonPlay
buttonSetup
buttonHelp
buttonEnd

FOR i = 6 TO 43
   PALETTE 2, i + 20
   PALETTE 3, i + 15
   PALETTE 5, i + 10
   PALETTE 6, i + 5
   PALETTE 10, i
  
   a$ = INKEY$
   IF a$ <> "" THEN EXIT FOR

   FOR u = 1 TO 5
      FOR t = 1 TO 25000: NEXT t
   NEXT u
NEXT i

PALETTE 2, 63
PALETTE 3, 58
PALETTE 5, 53
PALETTE 6, 48
PALETTE 10, 43

COLOR 15

mousePointer 1
mousePointer 3

DO
  mouse cx, dx, bx

  IF bx = 1 THEN
    IF cx >= 400 AND cx <= 450 THEN
      IF dx >= 50 AND dx <= 150 THEN
        mousePointer 2

        buttonPlayPush

        FOR t = 1 TO 25000: NEXT t
       
        EXIT DO
      ELSEIF dx >= 200 AND dx <= 300 THEN
        mousePointer 2

        buttonSetupPush

        FOR t = 1 TO 25000: NEXT t

        setup

        buttonSetup

        mousePointer 1
        mousePointer 3
      ELSEIF dx >= 350 AND dx <= 450 THEN
        mousePointer 2

        buttonHelpPush

        FOR t = 1 TO 25000: NEXT t

        instructions

        buttonHelp

        mousePointer 1
        mousePointer 3
      ELSEIF dx >= 500 AND dx <= 600 THEN
        mousePointer 2

        buttonEndPush

        FOR u = 1 TO 5
           FOR t = 1 TO 25000: NEXT t
        NEXT u

        buttonEnd

        END
      END IF
    END IF
  END IF
LOOP
   
mousePointer 2

CLS

END SUB

SUB mazeIni

LOCATE 15, 28: PRINT "Initializing...Please Wait"

FOR a = 1 TO 25 STEP 3
   y = a
   x = 1
   beside = 0

   maze(x, y) = 1
  
   FOR i = 1 TO 1500
      dir = INT(RND * 5)

      SELECT CASE dir
             CASE 0
                 IF x < 25 THEN
                   x = x + 1
                 END IF
             CASE 1
                 IF y < 25 THEN
                   y = y + 1
                 END IF
             CASE 2
                 IF y > 1 THEN
                   y = y - 1
                 END IF
             CASE 3
                 IF x > 1 THEN
                   x = x - 1
                 END IF
      END SELECT

      IF x > 1 THEN
        IF maze(x - 1, y) = 1 THEN beside = beside + 1
      END IF
      IF y > 1 THEN
        IF maze(x, y - 1) = 1 THEN
          beside = beside + 1
     
          IF beside = 2 THEN
            y = y - 1
          END IF
        END IF
      END IF
      IF x < 25 THEN
        IF maze(x + 1, y) = 1 THEN
          beside = beside + 1

          IF beside >= 2 THEN
            x = x + 1
          END IF
        END IF
      END IF
      IF y < 25 THEN
        IF maze(x, y + 1) = 1 THEN
          beside = beside + 1
      
          IF beside >= 2 THEN
            y = y + 1
          END IF
        END IF
      END IF
  
      IF beside < 2 THEN
        IF x > 0 AND x < 26 AND y > 0 AND y < 26 THEN
          maze(x, y) = 1
          beside = 0
        END IF
      ELSE
        beside = 0
      END IF

      IF x = 25 AND y = 25 THEN EXIT FOR
   NEXT i
NEXT a

FOR a = 1 TO 25 STEP 3
   x = a
   y = 1
   beside = 0

   maze(x, y) = 1
       
   FOR i = 1 TO 1500
      dir = INT(RND * 5)

      SELECT CASE dir
             CASE 0
                 IF x < 25 THEN
                   x = x + 1
                 END IF
             CASE 1
                 IF y < 25 THEN
                   y = y + 1
                 END IF
             CASE 2
                 IF y > 1 THEN
                   y = y - 1
                 END IF
             CASE 3
                 IF x > 1 THEN
                   x = x - 1
                 END IF
      END SELECT

      IF x > 1 THEN
        IF maze(x - 1, y) = 1 THEN beside = beside + 1
      END IF
      IF y > 1 THEN
        IF maze(x, y - 1) = 1 THEN
          beside = beside + 1
    
          IF beside = 2 THEN
            y = y - 1
          END IF
        END IF
      END IF
      IF x < 25 THEN
        IF maze(x + 1, y) = 1 THEN
          beside = beside + 1

          IF beside >= 2 THEN
            x = x + 1
          END IF
        END IF
      END IF
      IF y < 25 THEN
        IF maze(x, y + 1) = 1 THEN
          beside = beside + 1
     
          IF beside >= 2 THEN
            y = y + 1
          END IF
        END IF
      END IF
 
      IF beside < 2 THEN
        IF x > 0 AND x < 26 AND y > 0 AND y < 26 THEN
          maze(x, y) = 1
          beside = 0
        END IF
      ELSE
        beside = 0
      END IF

      IF x = 25 AND y = 25 THEN EXIT FOR
   NEXT i
NEXT a

x = 25: y = 25

maze(x, y) = 1

CLS

END SUB

SUB mouse (cx, dx, bx)

POKE VARPTR(a(4)), &H92                         'Swap code,Get CX setup
CALL absolute(cx, VARPTR(a(0)))                 'Run Code
POKE VARPTR(a(4)), &H91                         'Swap code,Get DX setup
CALL absolute(dx, VARPTR(a(0)))                 'Run Code
POKE VARPTR(a(4)), &H93                         'Swap code,Get BX setup
CALL absolute(bx, VARPTR(a(0)))                 'Run Code

END SUB

SUB mousePointer (sw)
        
POKE VARPTR(a(0)) + 1, sw               'Swap code,Set AX = (SW)
CALL absolute(c, VARPTR(a(0)))          'Run Code

END SUB

SUB playMaze

drawView

IF mudMap$ = "yes" THEN
  LINE (250, 185)-(300, 235), 4, BF
  LINE (250, 185)-(251, 186), 14, BF
END IF

IF coordinates$ = "yes" THEN
  LOCATE 28, 1: PRINT "Coordinates: 1, 1"
END IF

IF direction$ = "yes" THEN
  LOCATE 28, 30: PRINT "Heading "; facing2$
END IF

mousePointer 0
mousePointer 1
mousePointer 3

DO
  a$ = INKEY$
  mouse cx, dx, bx

  IF bx = 1 THEN
    IF cx >= 10 AND dx >= 10 AND cx <= 50 AND dx <= 310 THEN
      mousePointer 2
      buttonNewPush
      confirm
      LOCATE 15, 35: PRINT "a new maze?"
      mousePointer 1
      mousePointer 3
      DO
        mouse cx, dx, bx
    
        IF bx = 1 THEN
          IF cx >= 253 AND dx >= 245 AND cx <= 268 AND dx <= 260 THEN
            mousePointer 2
           
            LINE (-75, 15)-(-60, 30), 15
            LINE (-75, 30)-(-60, 15), 15
           
            buttonNew

            EXIT SUB
          ELSEIF cx >= 253 AND dx >= 324 AND cx <= 268 AND dx <= 339 THEN
            mousePointer 2
            LINE (5, 15)-(20, 30), 15
            LINE (5, 30)-(20, 15), 15

            buttonNew
            drawView

            mousePointer 1
            mousePointer 3
            EXIT DO
          END IF
        END IF
      LOOP
    ELSEIF cx >= 10 AND dx >= 329 AND cx <= 50 AND dx <= 629 THEN
      mousePointer 2
      buttonQuitPush
      confirm
      LOCATE 15, 37: PRINT "to quit?"
      mousePointer 1
      mousePointer 3
      DO
        mouse cx, dx, bx
     
        IF bx = 1 THEN
          IF cx >= 253 AND dx >= 245 AND cx <= 268 AND dx <= 260 THEN
            mousePointer 2
           
            LINE (-75, 15)-(-60, 30), 15
            LINE (-75, 30)-(-60, 15), 15

            END
          ELSEIF cx >= 253 AND dx >= 324 AND cx <= 268 AND dx <= 339 THEN
            mousePointer 2
            LINE (5, 15)-(20, 30), 15
            LINE (5, 30)-(20, 15), 15
            buttonQuit
            drawView
            mousePointer 1
            mousePointer 3
            EXIT DO
          END IF
        END IF
      LOOP
    END IF
  END IF
 
  SELECT CASE a$
         CASE u$
             IF facing$ = "down" AND y < 25 THEN
               IF maze(x, y + 1) = 1 THEN
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 12, BF
                 y = y + 1
                 change = 1
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 14, BF
               END IF
             ELSEIF facing$ = "up" AND y > 1 THEN
               IF maze(x, y - 1) = 1 THEN
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 12, BF
                 y = y - 1
                 change = 1
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 14, BF
               END IF
             ELSEIF facing$ = "left" AND x > 1 THEN
               IF maze(x - 1, y) = 1 THEN
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 12, BF
                 x = x - 1
                 change = 1
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 14, BF
               END IF
             ELSEIF facing$ = "right" AND x < 25 THEN
               IF maze(x + 1, y) = 1 THEN
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 12, BF
                 x = x + 1
                 change = 1
                 IF mudMap$ = "yes" THEN LINE (x * 2 + 248, y * 2 + 183)-(x * 2 + 250, y * 2 + 185), 14, BF
               END IF
             END IF
         CASE l$
             IF facing$ = "down" THEN
               facing$ = "right"
               facing2$ = "East"
             ELSEIF facing$ = "right" THEN
               facing$ = "up"
               facing2$ = "North"
             ELSEIF facing$ = "up" THEN
               facing$ = "left"
               facing2$ = "West"
             ELSE
               facing$ = "down"
               facing2$ = "South"
             END IF
             change = 1
         CASE r$
             IF facing$ = "down" THEN
               facing$ = "left"
               facing2$ = "West"
             ELSEIF facing$ = "right" THEN
               facing$ = "down"
               facing2$ = "South"
             ELSEIF facing$ = "up" THEN
               facing$ = "right"
               facing2$ = "East"
             ELSE
               facing$ = "up"
               facing2$ = "North"
             END IF
             change = 1
         CASE d$
             IF facing$ = "down" THEN
               facing$ = "up"
               facing2$ = "North"
             ELSEIF facing$ = "right" THEN
               facing$ = "left"
               facing2$ = "West"
             ELSEIF facing$ = "up" THEN
               facing$ = "down"
               facing2$ = "South"
             ELSE
               facing$ = "right"
               facing2$ = "East"
             END IF
             change = 1
  END SELECT

  IF change = 1 THEN
    mousePointer 2
    drawView
    
    IF coordinates$ = "yes" THEN
      LOCATE 28, 13: PRINT SPC(10);
      x$ = RTRIM$(STR$(x))
      LOCATE 28, 13: PRINT x$; ","; y
    END IF

    IF direction$ = "yes" THEN
      LOCATE 28, 30: PRINT SPC(20);
      LOCATE 28, 30: PRINT "Heading "; facing2$
    END IF

    mousePointer 1
    mousePointer 3
  END IF

  change = 0
LOOP UNTIL a$ = CHR$(27) OR (x = 25 AND y = 25)

mousePointer 2

IF x = 25 AND y = 25 THEN
  CLS
  LOCATE 15, 25: PRINT "Congratulations! You win!"
 
  DO: a$ = INKEY$: LOOP UNTIL a$ <> ""
 
  WINDOW SCREEN (0, 0)-(640, 480)
 
  intro
 
  WINDOW SCREEN (-320, -240)-(320, 240)
 
  EXIT SUB
END IF

END SUB

SUB setup

wallCol = 1
y1 = 160

SELECT CASE col(1)
       CASE 0
           y2(1) = 160
       CASE 1
           y2(1) = 176
       CASE 4
           y2(1) = 192
       CASE 7
           y2(1) = 208
       CASE 8
           y2(1) = 224
       CASE 9
           y2(1) = 240
       CASE 11
           y2(1) = 256
       CASE 12
           y2(1) = 272
       CASE 13
           y2(1) = 288
       CASE 14
           y2(1) = 304
END SELECT

CLS

LINE (50, 50)-(600, 400), 8, BF
LINE (50, 50)-(599, 399), 15, BF
LINE (51, 51)-(599, 399), 7, BF

LINE (250, 75)-(365, 100), 15, BF
LINE (250, 75)-(364, 99), 8, BF
LINE (251, 76)-(364, 99), 0, BF
LOCATE 6, 33: PRINT "Setup Options"

LINE (105, 122)-(165, 147), 15, BF
LINE (105, 122)-(164, 146), 8, BF
LINE (106, 123)-(164, 146), 0, BF
LOCATE 9, 15: PRINT "Colors"

LINE (60, 155)-(140, 230), 15, BF
LINE (60, 155)-(139, 229), 8, BF
LINE (61, 156)-(139, 229), 0, BF
LOCATE 11, 9: PRINT "Side wall"
LOCATE 12, 9: PRINT "Far wall"
LOCATE 13, 9: PRINT "Ceiling"
LOCATE 14, 9: PRINT "Floor"
LINE (62, y1)-(138, y1 + 15), 15, B, &H5555

LINE (145, 155)-(240, 325), 15, BF
LINE (145, 155)-(239, 324), 8, BF
LINE (146, 156)-(239, 324), 0, BF
LOCATE 11, 20: PRINT "Black"
LOCATE 12, 20: PRINT "Blue"
LOCATE 13, 20: PRINT "Red"
LOCATE 14, 20: PRINT "Light Grey"
LOCATE 15, 20: PRINT "Dark Grey"
LOCATE 16, 20: PRINT "Light Blue"
LOCATE 17, 20: PRINT "Cyan"
LOCATE 18, 20: PRINT "Light Red"
LOCATE 19, 20: PRINT "Pink"
LOCATE 20, 20: PRINT "Yellow"
LINE (147, y2(1))-(238, y2(1) + 15), 15, B, &H5555
                 
LINE (425, 122)-(500, 147), 15, BF
LINE (425, 122)-(499, 146), 8, BF
LINE (426, 123)-(499, 146), 0, BF
LOCATE 9, 55: PRINT "Features"

LINE (380, 155)-(550, 215), 15, BF
LINE (380, 155)-(549, 214), 8, BF
LINE (381, 156)-(549, 214), 0, BF
LOCATE 11, 53: PRINT "Show coordinates"
LOCATE 12, 53: PRINT "Show direction"
LOCATE 13, 53: PRINT "Show mud map"
LINE (390, 162)-(400, 171), 15, B
IF coordinates$ = "yes" THEN
  LINE (391, 163)-(399, 170), 15
  LINE (391, 170)-(399, 163), 15
END IF
LINE (390, 178)-(400, 187), 15, B
IF direction$ = "yes" THEN
  LINE (391, 179)-(399, 186), 15
  LINE (391, 186)-(399, 179), 15
END IF
LINE (390, 194)-(400, 203), 15, B
IF mudMap$ = "yes" THEN
  LINE (391, 195)-(399, 202), 15
  LINE (391, 202)-(399, 195), 15
END IF
    
buttonOK

mousePointer 1
mousePointer 3

DO
  mouse cx, dx, bx

  IF bx = 1 THEN
    mousePointer 2

    IF cx >= 159 AND dx >= 62 AND cx <= 222 AND dx <= 138 THEN
      LINE (62, y1)-(138, y1 + 15), 0, B, &H5555
      LINE (147, y2(wallCol))-(238, y2(wallCol) + 15), 0, B, &H5555
     
      IF cx >= 159 AND cx <= 174 THEN
        wallCol = 1
        y1 = 160
      ELSEIF cx >= 175 AND cx <= 190 THEN
        wallCol = 2
        y1 = 176
      ELSEIF cx >= 191 AND cx <= 206 THEN
        wallCol = 3
        y1 = 192
      ELSEIF cx >= 207 AND cx <= 222 THEN
        wallCol = 4
        y1 = 208
      END IF
     
      LINE (62, y1)-(138, y1 + 15), 15, B, &H5555

      SELECT CASE col(wallCol)
             CASE 0
                 y2(wallCol) = 160
             CASE 1
                 y2(wallCol) = 176
             CASE 4
                 y2(wallCol) = 192
             CASE 7
                 y2(wallCol) = 208
             CASE 8
                 y2(wallCol) = 224
             CASE 9
                 y2(wallCol) = 240
             CASE 11
                 y2(wallCol) = 256
             CASE 12
                 y2(wallCol) = 272
             CASE 13
                 y2(wallCol) = 288
             CASE 14
                 y2(wallCol) = 304
      END SELECT
     
      LINE (147, y2(wallCol))-(238, y2(wallCol) + 15), 15, B, &H5555
    ELSEIF cx >= 159 AND dx >= 147 AND cx <= 318 AND dx <= 238 THEN
      LINE (147, y2(wallCol))-(238, y2(wallCol) + 15), 0, B, &H5555
     
      IF cx >= 159 AND cx <= 174 THEN
        col(wallCol) = 0
        y2(wallCol) = 160
      ELSEIF cx >= 175 AND cx <= 190 THEN
        col(wallCol) = 1
        y2(wallCol) = 176
      ELSEIF cx >= 191 AND cx <= 206 THEN
        col(wallCol) = 4
        y2(wallCol) = 192
      ELSEIF cx >= 207 AND cx <= 222 THEN
        col(wallCol) = 7
        y2(wallCol) = 208
      ELSEIF cx >= 223 AND cx <= 238 THEN
        col(wallCol) = 8
        y2(wallCol) = 224
      ELSEIF cx >= 239 AND cx <= 254 THEN
        col(wallCol) = 9
        y2(wallCol) = 240
      ELSEIF cx >= 255 AND cx <= 270 THEN
        col(wallCol) = 11
        y2(wallCol) = 256
      ELSEIF cx >= 271 AND cx <= 286 THEN
        col(wallCol) = 12
        y2(wallCol) = 272
      ELSEIF cx >= 287 AND cx <= 302 THEN
        col(wallCol) = 13
        y2(wallCol) = 288
      ELSEIF cx >= 303 AND cx <= 318 THEN
        col(wallCol) = 14
        y2(wallCol) = 304
      END IF
     
      LINE (147, y2(wallCol))-(238, y2(wallCol) + 15), 15, B, &H5555
    ELSEIF cx >= 162 AND dx >= 390 AND cx <= 171 AND dx <= 400 THEN
      IF coordinates$ = "yes" THEN
        LINE (391, 163)-(399, 170), 0, BF
        coordinates$ = "no"
      ELSE
        LINE (391, 163)-(399, 170), 15
        LINE (391, 170)-(399, 163), 15
        coordinates$ = "yes"
      END IF
    ELSEIF cx >= 178 AND dx >= 390 AND cx <= 187 AND dx <= 400 THEN
      IF direction$ = "yes" THEN
        LINE (391, 179)-(399, 186), 0, BF
        direction$ = "no"
      ELSE
        LINE (391, 179)-(399, 186), 15
        LINE (391, 186)-(399, 179), 15
        direction$ = "yes"
      END IF
    ELSEIF cx >= 194 AND dx >= 390 AND cx <= 203 AND dx <= 400 THEN
      IF mudMap$ = "yes" THEN
        LINE (391, 195)-(399, 202), 0, BF
        mudMap$ = "no"
      ELSE
        LINE (391, 195)-(399, 202), 15
        LINE (391, 202)-(399, 195), 15
        mudMap$ = "yes"
      END IF
    ELSEIF cx >= 250 AND dx >= 380 AND cx <= 340 AND dx <= 550 THEN
      mousePointer 2

      buttonOKPush

      mousePointer 1
      mousePointer 3

      DO
        mouse cx, dx, bx
      LOOP UNTIL bx <> 1

      mousePointer 2

      buttonOK

      mousePointer 1
      mousePointer 3

      EXIT DO
    END IF

    mousePointer 1
    mousePointer 3
   
    DO
      mouse cx, dx, bx
    LOOP UNTIL bx <> 1
  END IF
LOOP

OPEN "amazeing.ini" FOR OUTPUT AS #1

WRITE #1, col(1), col(2), col(3), col(4)

WRITE #1, coordinates$
WRITE #1, direction$
WRITE #1, mudMap$

CLOSE #1

mousePointer 2

CLS

LINE (50, 150)-(200, 300), 2, BF
LINE (300, 150)-(600, 300), 2, BF
LINE (50, 150)-(200, 50), 2
LINE (200, 50)-(200, 90), 2
LINE (600, 150)-(450, 50), 2
LINE (450, 50)-(450, 105), 2
LINE (200, 50)-(450, 50), 2
LINE (200, 150)-(250, 105), 2
LINE (200, 300)-(250, 240), 2
LINE (250, 105)-(250, 240), 2
LINE (250, 105)-(451, 105), 2
LINE (451, 105)-(451, 150), 2
LINE (250, 240)-(300, 240), 2
LINE (451, 105)-(400, 75), 2
LINE (400, 75)-(400, 105), 2
LINE (400, 75)-(220, 75), 2
LINE (220, 75)-(220, 132), 2
LINE (220, 75)-(160, 120), 2
LINE (160, 120)-(160, 150), 2
PAINT (225, 225), 3, 2
PAINT (275, 200), 3, 2
PAINT (475, 125), 6, 2
PAINT (100, 125), 6, 2
PAINT (175, 125), 5, 2
PAINT (225, 100), 5, 2
PAINT (425, 100), 5, 2
PAINT (300, 70), 10, 2

COLOR 10: LOCATE 21, 35: PRINT "A"
COLOR 6: LOCATE 21, 36: PRINT "m"
COLOR 5: LOCATE 21, 37: PRINT "a"
COLOR 3: LOCATE 21, 38: PRINT "z"
COLOR 2: LOCATE 21, 39: PRINT "e"
COLOR 3: LOCATE 21, 40: PRINT "i"
COLOR 5: LOCATE 21, 41: PRINT "n"
COLOR 6: LOCATE 21, 42: PRINT "g"
COLOR 10: LOCATE 23, 32: PRINT "By"
COLOR 5: LOCATE 23, 35: PRINT "Aaron"
COLOR 2: LOCATE 23, 41: PRINT "Severn "

buttonPlay
buttonSetup
buttonHelp
buttonEnd

COLOR 15

mousePointer 1
mousePointer 3

END SUB

