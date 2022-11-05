'''''''''''''''''''''''''''PRESS SHIFT+F5 TO PLAY''''''''''''''''''''''''''

'   Programmed(mostly) by LaPeste. With no freakin help from anyone except
'     maybe QBASIC.COM.
'
'   E-Mail me: LaPeste <bryan@flinet.com>
'
'   Note to Mr. Mallard: I am interested in the QB CD. Please send
'     me some information
'
'   VENTURE.BAS
'   Started as QB challenge. Ended up with a solid program.
'   Couldn't see any good use of the BMP loader. Trashed it.
'   Totally drew the board with a string system.
'   Started a different engine that uses "POINT" to check.
'   Added some new sprites.
'   Added collection of gems and also a score counter.
'   Made new boards. Put them into MAP.DAT file.
'   Added a counter for number of moves to complete level. Or die.
'   Added various console items.
'   Put the sprites and a highscore table(fake) into DAT files.
'
'   So,.. You use the arrow keys to move. Use the space bar to attack
'     an enemy when he is on any immediate side of you.
'   Collect all gems, kill all bad guys(snakes and red dudes), and get
'     the gold key in a minimum amount of moves to beat the level.
'   10(ten) Levels...1 thru 5 are same board, just different ammount of stuff
'     same thing with 6 thru 10.  Levels can be added or edited if you have
'     a basic understanding of the program, through the MAP.DAT file.
'
'  <<<<<<<<<<<<<<<<<<<<<<<<<<LEGAL STUFF SAYS I>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'  -------------------------------------------------------------------------
'  RESTRICTED RIGHTS. Use by the U.S. Government subject to restrictions of
'  (c) (1) (ii) of DFARS 252.227-7013.
'
'        Q-BASIC IS (C) Copyright Microsoft Corporation, 1987-1992.
'                         All rights reserved.
'  -------------------------------------------------------------------------
'  ^^^^^^^^^^^^^<<<<BASICALLY....DONT FUCK WITH MY SHIT>>>>^^^^^^^^^^^^^^^^
'   Just kidding. Since this game is part of the great society of Q-basic
'     programming, I really dont care if you change stuff, as long as it's
'     for the better of mankind   (HA HA HA HA HA)
'                                                         -LaPeste







DECLARE SUB high.scores ()
DECLARE SUB start.init ()
DECLARE SUB kbd.init ()
DECLARE SUB random.characters ()
DECLARE SUB level.intro ()
DECLARE SUB init.variables ()
DECLARE SUB main.loop ()
DECLARE SUB ending ()
DECLARE SUB load.board ()
DECLARE SUB temp ()
DECLARE SUB load.sprites ()
CLS : SCREEN 13
RANDOMIZE TIMER
CLEAR
DIM SHARED wall(190), gg(190), plant(190), board$(1000), gem(190), gkey(190)
DIM SHARED blank(190), bg(190), snake(190), dude$(100), boom(190)
DIM SHARED spritename$(1000), level, levopen, maxmoves, move, rock, kills
DIM SHARED gems, maxgems, maxbadguys, x, y, k$, rght$, lft$, up$, down$
DIM SHARED badguys, i, s, score, intro, atck$, scorer$(1000), hiscor(1000)
DIM SHARED keys, pickup, t, keyclock, dir$


'dir$ = "c:\basics\rpgs\" '<<<<<<<<<<<<<<<<<<<< Change this to the folder that
                          '<<<<<<<<<<<<<<<<<<<< program was unzipped into!!!!!!

high.scores


OPEN dir$ + "map.dat" FOR INPUT AS #2

start.init
load.sprites

gameloop:
init.variables
load.board
level.intro
random.characters
kbd.init
main.loop

 IF (level / 5) = 1 OR (level / 5) = 2 THEN
  INPUT #2, levnum$
  IF levnum$ = "last" THEN GOTO leave
 END IF

 opener = opener + 1
GOTO gameloop

leave:
 CLOSE #2

SUB ending
CLS
PRINT "YOU LOST"

FOR i = 1 TO 5
 IF score >= hiscor(i) THEN
  PRINT "You got a high score!!!"
  INPUT "Enter your name.", myscore$
  scorer$(i) = myscore$
  hiscor = score
  high.scores
  EXIT FOR
 END IF
NEXT i

PRINT "Press ESC to exit."
DO: LOOP WHILE INKEY$ <> CHR$(27)

SYSTEM
END SUB

SUB high.scores
CLS
PRINT "            HIGH SCORES"
PRINT
PRINT
PRINT
PRINT
OPEN dir$ + "scores.dat" FOR INPUT AS #3
 FOR higher = 1 TO 5
  INPUT #3, scorer$(higher), hiscor(higher)
  COLOR (31 - (higher * 2.5))
  LOCATE (higher + 5), 4: PRINT USING "#. \                   \"; higher; scorer$(higher)
  LOCATE (higher + 5), 26: PRINT USING "##,###"; hiscor(higher)
 NEXT
CLOSE #3
DO: f = f + 1: LOOP UNTIL f = 24000 OR INKEY$ <> ""
COLOR 15
CLS
END SUB

SUB init.variables

level = level + 1
maxgems = 8 + level
maxbadguys = 10 + level
maxmoves = 220 - (2 * (2 * level))
move = 0: kills = 0: badguys = 0: gems = 0
time = 0: rock = 0: gem = 0: totalstuff = 0
levopen = levopen + 1: keys = 0: pickup = 0
keyclock = 0

END SUB

SUB kbd.init

atck$ = CHR$(32)
down$ = CHR$(0) + CHR$(80)
lft$ = CHR$(0) + CHR$(75)
rght$ = CHR$(0) + CHR$(77)
up$ = CHR$(0) + CHR$(72)

END SUB

SUB level.intro

IF level <= 5 THEN
  horz = 14
  lr = 1
 h = 1: hue = 20
 DO
  IF h = 1 THEN hue = hue + 1: IF hue = 63 THEN h = 0
  IF h = 0 THEN hue = hue - 1: IF hue = 23 THEN h = 1
  COLOR 3
  PALETTE 3, 0 + (256 * (-hue + 63)) + (hue * (256 ^ 2))
  IF lr = 1 THEN horz = horz + 1: IF horz = 25 THEN horz = 24: lr = 0
  IF lr = 0 THEN horz = horz - 1: IF horz = 7 THEN lr = 1
  FOR delay = 1 TO 1000: NEXT delay
  LOCATE 11, horz: PRINT " LEVEL"; level; " "
 LOOP WHILE INKEY$ = ""
  LOCATE 11, horz: PRINT "         "

END IF

END SUB

SUB load.board


IF (levopen / 5) = 1 OR (levopen / 5) = 2 THEN
 FOR i = 1 TO 17
  INPUT #2, board$(i)
 NEXT i
END IF


FOR y = 1 TO 17
 FOR x = 1 TO 32
  SELECT CASE MID$(board$(y), x, 1)
   CASE "w": PUT (x * 10 - 10, y * 10 - 10), wall
   CASE "p": PUT (x * 10 - 10, y * 10 - 10), plant
   CASE "g": PUT (x * 10 - 10, y * 10 - 10), gem: gems = gems + 1
   CASE "b":  PUT (x * 10 - 10, y * 10 - 10), bg: badguys = badguys + 1
   CASE "s":  PUT (x * 10 - 10, y * 10 - 10), snake: badguys = badguys + 1
   CASE "k": PUT (x * 10 - 10, y * 10 - 10), gkey
   CASE "*": PUT (x * 10 - 10, y * 10 - 10), boom
   CASE " ": PUT (x * 10 - 10, y * 10 - 10), blank
  END SELECT
 NEXT
NEXT

PUT (10, 173), gem, PSET
PUT (60, 173), bg, PSET
stat$ = ""

LOCATE 23, 4: PRINT USING ":##"; rock
LOCATE 23, 10: PRINT USING ":##"; kills
LOCATE 23, 26: PRINT "SC:"; score
LOCATE 23, 15: PRINT "LEFT:"; (maxmoves - move)
LOCATE 23, 40: PRINT stat$
LOCATE 23, 37: PRINT level


END SUB

SUB load.sprites

OPEN dir$ + "sprites.dat" FOR INPUT AS #1
FOR sprite = 1 TO 9
 FOR y = 1 TO 10
  FOR x = 1 TO 9
   INPUT #1, col
   PSET (x, y), col
   IF sprite = 1 THEN GET (0, 1)-(9, 10), wall
   IF sprite = 2 THEN GET (0, 1)-(9, 10), gg
   IF sprite = 3 THEN GET (0, 1)-(9, 10), bg
   IF sprite = 4 THEN GET (0, 1)-(9, 10), plant
   IF sprite = 5 THEN GET (0, 1)-(9, 10), snake
   IF sprite = 6 THEN GET (0, 1)-(9, 10), gem
   IF sprite = 7 THEN GET (0, 1)-(9, 10), boom
   IF sprite = 8 THEN GET (0, 1)-(9, 10), gkey
   IF sprite = 9 THEN GET (0, 1)-(9, 10), blank
  NEXT x
 NEXT y

NEXT sprite

END SUB

SUB main.loop

totalstuff = gems + badguys
x = 10: y = 10
PUT (x, y), gg
PUT (10, 173), gem, PSET
PUT (60, 173), bg, PSET
stat.color = 15: stat$ = ""
hue = 22
h = 1
t = 0
DO
 IF h = 1 THEN hue = hue + 1: IF hue = 63 THEN h = 0
 IF h = 0 THEN hue = hue - 1: IF hue = 23 THEN h = 1
 PALETTE 3, 0 + (256 * (-hue + 63)) + (hue * (256 ^ 2))
 k$ = INKEY$
 
  IF k$ <> "" THEN move = move + 1
 
  IF timmy > 60 THEN stat$ = " ": timmy = 0

  IF k$ = atck$ THEN
   stat$ = "": stat.color = 4
   IF POINT(x + 15, y + 5) = 4 THEN : PUT (x + 10, y), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x + 10, y), blank, PSET: kills = kills + 1: score = score + 100
   IF POINT(x - 5, y + 5) = 4 THEN : PUT (x - 10, y), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x - 10, y), blank, PSET: kills = kills + 1: score = score + 100
   IF POINT(x + 5, y + 15) = 4 THEN : PUT (x, y + 10), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x, y + 10), blank, PSET: kills = kills + 1: score = score + 100
   IF POINT(x + 5, y - 5) = 4 THEN : PUT (x, y - 10), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x, y - 10), blank, PSET: kills = kills + 1:  score = score + 100

   IF POINT(x + 15, y + 5) = 6 THEN : PUT (x + 10, y), boom, PSET: FOR delay = 1 TO 2000: NEXT delay: PUT (x + 10, y), blank, PSET: kills = kills + 1: score = score + 50
   IF POINT(x - 5, y + 5) = 6 THEN : PUT (x - 10, y), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x - 10, y), blank, PSET: kills = kills + 1:  score = score + 50
   IF POINT(x + 5, y + 15) = 6 THEN : PUT (x, y + 10), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x, y + 10), blank, PSET: kills = kills + 1:  score = score + 50
   IF POINT(x + 5, y - 5) = 6 THEN : PUT (x, y - 10), boom, PSET: : FOR delay = 1 TO 2000: NEXT delay: PUT (x, y - 10), blank, PSET: kills = kills + 1: score = score + 50
  END IF
  
  IF stat$ <> "" THEN timmy = timmy + 1
  

  IF k$ = up$ THEN
   IF timmy > 30 OR timmy = 0 THEN stat$ = "": stat.color = 12: timmy = 0
   IF POINT(x + 5, y - 5) = 0 OR POINT(x + 5, y - 5) = 3 THEN
    y = y - 10: PUT (x, y + 10), blank, PSET: PUT (x, y), gg
   END IF
  END IF

  IF k$ = down$ THEN
   IF timmy > 30 OR timmy = 0 THEN stat$ = "": stat.color = 12: timmy = 0
   IF POINT(x + 5, y + 15) = 0 OR POINT(x + 5, y + 15) = 3 THEN
    y = y + 10: PUT (x, y - 10), blank, PSET: PUT (x, y), gg
   END IF
  END IF

  IF k$ = lft$ THEN
   IF timmy > 30 OR timmy = 0 THEN stat$ = "": stat.color = 12: timmy = 0
   IF POINT(x - 5, y + 5) = 0 OR POINT(x - 5, y + 5) = 3 THEN
    x = x - 10: PUT (x + 10, y), blank, PSET: PUT (x, y), gg
   END IF
  END IF

  IF k$ = rght$ THEN
   IF timmy > 30 OR timmy = 0 THEN stat$ = CHR$(26): stat.color = 12: timmy = 0
   IF POINT(x + 15, y + 5) = 0 OR POINT(x + 15, y + 5) = 3 THEN
    x = x + 10: PUT (x - 10, y), blank, PSET: PUT (x, y), gg
   END IF
  END IF

  IF POINT(x + 1, y + 3) = 1 THEN
   rock = rock + 1: score = score + 10: PUT (x, y), gg, PSET: stat$ = "": stat.color = 3
  END IF
 
  IF POINT(x + 1, y + 1) = 14 THEN
   score = score + 1500: PUT (x, y), gg, PSET: stat$ = "": stat.color = 14
   pickup = 1
  END IF
 
  test = test + 1: IF test > 5 THEN test = 1
  IF score > hiscor(test) THEN scorclr = test ELSE scorclr = 10


 IF keys = 1 THEN
keycoors:
  keyx = INT(RND * 27) + 3
  keyy = INT(RND * 12) + 3
  IF POINT(keyx * 10 + 5, keyy * 10 + 5) <> 0 THEN GOTO keycoors
  PUT (keyx * 10, keyy * 10), gkey
  totalstuff = totalstuff + 1: keys = 0
 END IF

 
  LOCATE 23, 4: COLOR 3: PRINT USING ":##"; rock
  LOCATE 23, 10: COLOR 4: PRINT USING ":##"; kills
  LOCATE 23, 15: COLOR 13: PRINT "LEFT:"; (maxmoves - move)
  LOCATE 23, 26: COLOR 10: PRINT "SC:": LOCATE 23, 30: COLOR scorclr: PRINT score
  LOCATE 23, 40: COLOR stat.color: PRINT stat$
  LOCATE 23, 36: COLOR 11: PRINT level
  IF rock = gems THEN score = score + 1000: gems = gems + 1
  IF kills = badguys THEN score = score + 500: badguys = badguys + 1
  IF move = maxmoves THEN ending
  IF rock + kills = totalstuff THEN keys = 1
  IF pickup = 1 THEN t = t + 1: IF t >= 30 THEN EXIT DO
LOOP
 
IF (level + 1) = 11 THEN ending
 IF (level / 5) = 1 OR (level / 5) = 2 THEN
  INPUT #1, levnum$
  IF levnum$ = "last" THEN ending
 END IF


CLS
END SUB

SUB random.characters

IF badguys = 0 THEN
 FOR baddies = 1 TO INT(RND * (maxbadguys - 10)) + INT(RND * level) + 3
  guy = INT(RND * 2) + 1
badcoors:
  badx = INT(RND * 27) + 3
  bady = INT(RND * 12) + 3
  IF POINT(badx * 10 + 5, bady * 10 + 5) <> 0 THEN GOTO badcoors
  IF guy = 1 THEN PUT (badx * 10, bady * 10), snake
  IF guy = 2 THEN PUT (badx * 10, bady * 10), bg
  badguys = badguys + 1
  IF badguys > maxbadguys THEN EXIT FOR
 NEXT baddies
END IF

IF gems = 0 THEN
 FOR rocks = 1 TO INT(RND * (maxgems - 8)) + INT(RND * level) + 3
gemcoors:
  gemx = INT(RND * 27) + 3
  gemy = INT(RND * 12) + 3
  IF POINT(gemx * 10 + 5, gemy * 10 + 5) <> 0 THEN GOTO gemcoors
  PUT (gemx * 10, gemy * 10), gem
  gems = gems + 1
  IF gems > maxgems THEN EXIT FOR
 NEXT rocks
END IF


END SUB

SUB start.init

level = 0
intro = 1
levopen = 4
s = CDBL(s)
keys = 0: pickup = 0

END SUB

SUB temp

     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), wall

     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), gg

     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), bg
  
     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), plant

     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), snake
  
     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), gem
  
     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), boom
  
     FOR y = 1 TO 10
         FOR x = 1 TO 9
             READ col
             PSET (x, y), col
         NEXT
     NEXT

GET (0, 1)-(9, 10), blank

END SUB

