'----------------------------------------------------------------------------
'SNOOPY V.4.0 (C) 1996 Thomas Hirsch / Quaxx Media. All rights reserved.
'----------------------------------------------------------------------------
'
'IMPORTANT NOTES:
'Please distribute this files unchanged.
'If you have changed the source-code and you mean it's good, so mail me the
'files. If I mean it's good, too, I'll use them.
'
'If you are interested in the developement of this game mail me. I can send
'you for example a level editor etc.
'
'If you have encountered any problem, mail me. I'll *try* to solve it.
'(Only problems who concern this game. I'm not your psychodoc;)
'
'If you have no adlib compatible soundcard change the "playadlib" command
'in SUB bgsound to "play".
'If you don't want to have sounds at all, disable the "playbg"command in
'lines 23? and 23(?+6).
'
'If you know how I can get some SFX-effects in, mail me. I'll be grateful.
'
'If you have a joystick, run the program by typing "snoopy_j". This will
'enable it.
'
'thomasalh@aol.com
'thomasalh@geocities.com
'http://www.geocities.com/SiliconValley/3982
'----------------------------------------------------------------------------
DECLARE SUB vorspann ()
DECLARE SUB abrech ()
DECLARE SUB catdetect ()
DECLARE SUB showbones ()
DECLARE SUB loadlev (lev$)
DECLARE FUNCTION wasisda% (x%, y%)
DECLARE SUB putdog (x%, y%)
DECLARE FUNCTION nextdogmvt% (dogmvt%)
DECLARE SUB putscreen (x%, y%)
DECLARE SUB playbg ()
DECLARE SUB WriteReg (reg AS INTEGER, value AS INTEGER)
DECLARE SUB playadlib (comand$)
DEFINT A-Z
catdetect
CHDIR "jarimg"

SCREEN 0: CLS
COLOR 4
speedy! = .1
PRINT "SPEED:"
PRINT
COLOR 7
PRINT "THE SPEED DOESN'T DEPEND ON YOUR COMPUTER SPEED, IT JUST THE GAMESPEED !!!"
PRINT "(I'm not as stupid as other Qbasic-programmers who can't make run their"
PRINT "games on a constant gamespeed. Well, if you are one of 'em, look in the source"
PRINT "code. It's sooo easy, but I seem to be the first one who has got that idea."
PRINT "The only problem (?) is that you can't play this game at midnight (BOHOOOO!!!))"
COLOR 4
DO
LOCATE 1, 8: PRINT STRING$(20 - speedy! / .01, "Û"); STRING$(speedy! / .01, "°")
a$ = INKEY$
IF a$ = CHR$(0) + CHR$(75) AND speedy! < .2 THEN speedy! = speedy! + .01
IF a$ = CHR$(0) + CHR$(77) AND speedy! > .01 THEN speedy! = speedy! - .01
LOOP UNTIL a$ = CHR$(27) OR a$ = CHR$(13) OR a$ = CHR$(32)
gamespeed! = speedy!

'vorspann
DIM SHARED dp1&(60), dp2&(60), ban11&(60), ban12&(60), ban13&(60), ban14&(60)
DIM SHARED ban15&(60), ban21&(60), ban22&(60), ban31&(60), ban32&(60), ban33&(60)
DIM SHARED ban34&(60), banl&(60), banr&(60), front&(60), pfeil1&(60)

'dogimages
DIM SHARED dogr1&(60), dogr2&(60), dogr3&(60)
DIM SHARED dogl1&(60), dogl2&(60), dogl3&(60)
DIM SHARED ouch1&(60), ouch2&(60), ouch3&(60)
DIM SHARED ouch1l&(60), ouch2l&(60), ouch3l&(60)
DIM SHARED fallr&(60), falll&(60), jumpr&(60), jumpl&(60)
DIM SHARED sleepy&(60), half&(60), explo4&(60)

'otherimages
DIM SHARED boden&(60), knochen&(60), haus&(60), athome&(60), spitz&(60)
DIM SHARED maus&(60), maus2&(60), maus3&(60), mausr&(60), maus2r&(60), maus3r&(60)
DIM SHARED hamml&(60), hammr&(60), napf&(60), kv&(40), flyl1&(60)
DIM SHARED flyr1&(60), bomb&(30), explo1&(60), explo2&(60), explo3&(60)

'other vars
CONST maxgeg = 50
DIM SHARED bgsound$
DIM SHARED dogmvt, f(1 TO 28, 1 TO 18), dx, dy, startx, starty, zielx, ziely
DIM SHARED li$, ob$, re$, un$, nx$, toti, geg(1 TO maxgeg, 3), geganz, knochen, napf
DIM SHARED pu, lv$
DIM SHARED start!, ender!
bgsound$ = "..\starwars.dat"
playadlib "{INIT}"

'readimages
LOCATE 15, 1
COLOR 15: PRINT "Please Wait, I'm loading..."
OPEN "kno_vert._52" FOR BINARY AS #1
OPEN "bomb.n21" FOR BINARY AS #2
FOR a = 0 TO 40
GET #1, a * 4 + 1, kv&(a)
NEXT
FOR a = 0 TO 30
GET #2, a * 4 + 1, bomb&(a)
NEXT
CLOSE
OPEN "dog.n22" FOR BINARY AS #1
OPEN "dogwalkr.n22" FOR BINARY AS #2
OPEN "dogwlkr2.n22" FOR BINARY AS #3
OPEN "dogl.n22" FOR BINARY AS #4
OPEN "dogwalkl.n22" FOR BINARY AS #5
OPEN "dogwlkl2.n22" FOR BINARY AS #6
OPEN "boden.n22" FOR BINARY AS #7
OPEN "knochen.n22" FOR BINARY AS #8
FOR a = 0 TO 60
GET #1, a * 4 + 1, dogr1&(a)
GET #2, a * 4 + 1, dogr2&(a)
GET #3, a * 4 + 1, dogr3&(a)
GET #4, a * 4 + 1, dogl1&(a)
GET #5, a * 4 + 1, dogl2&(a)
GET #6, a * 4 + 1, dogl3&(a)
GET #7, a * 4 + 1, boden&(a)
GET #8, a * 4 + 1, knochen&(a)
NEXT
CLOSE

OPEN bgsound$ FOR INPUT AS #255
vorspann
CLOSE #255
SELECT CASE gamespeed!
CASE IS > .1
bgsound$ = "..\zhivago.dat"
CASE .07 TO .1
bgsound$ = "..\jbond.dat"
CASE .02 TO .06
bgsound$ = "..\adaams.dat"
CASE ELSE
bgsound$ = "..\elise.dat"
END SELECT
ERASE dp1&, dp2&, ban11&, ban12&, ban13&, ban14&
ERASE ban15&, ban21&, ban22&, ban31&, ban32&, ban33&
ERASE ban34&, banl&, banr&, front&, pfeil1&

OPEN "ouch1.n22" FOR BINARY AS #1
OPEN "ouch2.n22" FOR BINARY AS #2
OPEN "ouch3.n22" FOR BINARY AS #3
OPEN "ouch1l.n22" FOR BINARY AS #4
OPEN "ouch2l.n22" FOR BINARY AS #5
OPEN "ouch3l.n22" FOR BINARY AS #6
OPEN "dogfall.n22" FOR BINARY AS #7
OPEN "dogfalll.n22" FOR BINARY AS #8
FOR a = 0 TO 60
GET #1, a * 4 + 1, ouch1&(a)
GET #2, a * 4 + 1, ouch2&(a)
GET #3, a * 4 + 1, ouch3&(a)
GET #4, a * 4 + 1, ouch1l&(a)
GET #5, a * 4 + 1, ouch2l&(a)
GET #6, a * 4 + 1, ouch3l&(a)
GET #7, a * 4 + 1, fallr&(a)
GET #8, a * 4 + 1, falll&(a)
NEXT
CLOSE
OPEN "dogjump.n22" FOR BINARY AS #1
OPEN "dogjumpl.n22" FOR BINARY AS #2
OPEN "haus.n22" FOR BINARY AS #3
OPEN "dogzhaus.n22" FOR BINARY AS #4
OPEN "dogsleep.n22" FOR BINARY AS #5
OPEN "spitze!!.n22" FOR BINARY AS #6
OPEN "spitze!.n22" FOR BINARY AS #7
OPEN "peeps.n22" FOR BINARY AS #8
OPEN "peeps!.n22" FOR BINARY AS #9
FOR a = 0 TO 60
GET #1, a * 4 + 1, jumpr&(a)
GET #2, a * 4 + 1, jumpl&(a)
GET #3, a * 4 + 1, haus&(a)
GET #4, a * 4 + 1, athome&(a)
GET #5, a * 4 + 1, sleepy&(a)
GET #6, a * 4 + 1, half&(a)
GET #7, a * 4 + 1, spitz&(a)
GET #8, a * 4 + 1, maus&(a)
GET #9, a * 4 + 1, maus2&(a)
NEXT
CLOSE
OPEN "pip1.n22" FOR BINARY AS #1
OPEN "pip2.n22" FOR BINARY AS #2
OPEN "peepsr.n22" FOR BINARY AS #3
OPEN "peepsr!.n22" FOR BINARY AS #4
OPEN "pip1r.n22" FOR BINARY AS #5
OPEN "pip2r.n22" FOR BINARY AS #6
OPEN "fresnapf.n22" FOR BINARY AS #7
OPEN "flymouse.n22" FOR BINARY AS #8
FOR a = 0 TO 60
GET #1, a * 4 + 1, maus3&(a)
GET #2, a * 4 + 1, hamml&(a)
GET #3, a * 4 + 1, mausr&(a)
GET #4, a * 4 + 1, maus2r&(a)
GET #5, a * 4 + 1, maus3r&(a)
GET #6, a * 4 + 1, hammr&(a)
GET #7, a * 4 + 1, napf&(a)
GET #8, a * 4 + 1, flyl1&(a)
NEXT
CLOSE
OPEN "flymausr.n22" FOR BINARY AS #1
OPEN "explo1.n22" FOR BINARY AS #2
OPEN "explo2.n22" FOR BINARY AS #3
OPEN "explo3.n22" FOR BINARY AS #4
OPEN "explo4.n22" FOR BINARY AS #5
FOR a = 0 TO 60
GET #1, a * 4 + 1, flyr1&(a)
GET #2, a * 4 + 1, explo1&(a)
GET #3, a * 4 + 1, explo2&(a)
GET #4, a * 4 + 1, explo3&(a)
GET #5, a * 4 + 1, explo4&(a)
NEXT
CLOSE
CHDIR ".."
CHDIR "levels"
'soundfile:
OPEN bgsound$ FOR INPUT AS #255

'initgraph
SCREEN 12
LINE (20, 20)-(619, 419), 8, BF
LINE (40, 40)-(599, 399), 7, BF

'loadlevel
'INPUT "Level :", lv$
lv$ = "demo.lev"
loadlev lv$

'initsomevars
napf = 3
nextlev:
n = 0
IF f(startx, starty + 1) = 2 THEN dogmvt = 0 ELSE dogmvt = 14
dx = startx * 20 + 20
dy = starty * 20 + 20
wart! = TIMER: slept! = TIMER

'klappe & action
showbones
DO
putdog dx, dy
playbg
IF TIMER > wart! + gamespeed! THEN
        GOSUB gegmov
        GOSUB automov
        a$ = INKEY$
        IF a$ <> "" AND (dogmvt < 8 OR dogmvt = 24) THEN GOSUB doit
        playbg
        IF TIMER > slept! + 30 THEN dogmvt = 24
        wart! = TIMER
END IF
LOOP

doit:
slept! = TIMER
IF dogmvt = 24 THEN dogmvt = 0
SELECT CASE a$
CASE "q"
GOTO ende
CASE CHR$(0) + CHR$(77)
GOTO laufre
CASE CHR$(0) + CHR$(75)
GOTO laufli
CASE CHR$(0) + CHR$(72)
GOTO hophoch
CASE CHR$(0) + CHR$(115)
GOTO hopli
CASE CHR$(0) + CHR$(116)
GOTO hopre
END SELECT
RETURN

laufre:
IF dx >= 579 THEN IF re$ = "            " THEN dogmvt = 8: RETURN ELSE dx = 1 * 20 + 20: x = 2: loadlev re$: RETURN
IF dx MOD 20 = 0 THEN
        vormir = wasisda((dx - 20) / 20 + 1, (dy - 20) / 20)
        IF f((dx - 20) / 20 + 1, (dy - 20) / 20) = 4 THEN GOTO ziel
        IF vormir = 1 THEN dogmvt = 8: RETURN
END IF
IF (dx + 4) MOD 20 = 0 AND dy <> 380 THEN
        untermir = wasisda((dx - 16) / 20, (dy - 20) / 20 + 1)
        IF untermir = 0 THEN dogmvt = 14
END IF
LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
dx = dx + 4
dogmvt = nextdogmvt(dogmvt)
IF dogmvt >= 4 AND dogmvt <= 7 THEN dogmvt = 0
RETURN

laufli:
IF dx <= 40 THEN IF li$ = "            " THEN dogmvt = 11: RETURN ELSE dx = 28 * 20 + 20: x = 28: loadlev li$: RETURN
IF dx MOD 20 = 0 THEN
        vormir = wasisda((dx - 20) / 20 - 1, (dy - 20) / 20)
        IF f((dx - 20) / 20 - 1, (dy - 20) / 20) = 4 THEN GOTO ziel
        IF vormir = 1 THEN dogmvt = 11: RETURN
END IF
IF (dx - 4) MOD 20 = 0 AND dy <> 380 THEN
        untermir = wasisda((dx - 24) / 20, (dy - 20) / 20 + 1)
        IF untermir = 0 THEN dogmvt = 15
END IF
LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
dx = dx - 4
dogmvt = nextdogmvt(dogmvt)
IF dogmvt >= 0 AND dogmvt <= 3 THEN dogmvt = 4
RETURN

hophoch:
IF dy <= 40 THEN RETURN
IF wasisda((dx - (dx MOD 20) - 20) / 20, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dy MOD 20 = 0 AND wasisda((dx - dx MOD 20 - 20) / 20 + 1, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dogmvt < 4 THEN dogmvt = 16 ELSE dogmvt = 17
RETURN

hopli:
IF dx <= 40 THEN dogmvt = 11: RETURN
IF dx MOD 20 = 0 THEN
        vormir = wasisda((dx - (dx MOD 20) - 20) / 20 - 1, (dy - 20) / 20)
        IF vormir = 1 THEN dogmvt = 11: RETURN
END IF
IF wasisda((dx - (dx MOD 20) - 20) / 20, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dx MOD 20 <> 0 AND wasisda((dx - (dx MOD 20) - 20) / 20 + 1, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dx MOD 20 = 0 AND wasisda((dx - (dx MOD 20) - 20) / 20 - 1, (dy - 20) / 20 - 1) = 1 THEN RETURN
dogmvt = 18
RETURN

hopre:
IF dx >= 579 THEN dogmvt = 8: RETURN
IF dx MOD 20 = 0 THEN
        IF dx MOD 20 <> 0 THEN vormir = wasisda((dx - (dx MOD 20)) / 20 + 1, (dy - 20) / 20) ELSE vormir = wasisda((dx - 20) / 20 + 1, (dy - 20) / 20)
        IF vormir = 1 THEN dogmvt = 8: RETURN
END IF
IF wasisda((dx - (dx MOD 20)) / 20, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dx MOD 20 <> 0 AND wasisda((dx - (dx MOD 20) - 20) / 20, (dy - 20) / 20 - 1) = 1 THEN RETURN
IF dx MOD 20 = 0 AND wasisda((dx - (dx MOD 20) - 20) / 20 + 1, (dy - 20) / 20 - 1) = 1 THEN RETURN
dogmvt = 21
RETURN


automov:
IF dogmvt > 7 THEN dogmvt = nextdogmvt(dogmvt)
SELECT CASE dogmvt
CASE 14 TO 15
        vorhernapf = napf
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dy = dy + 5
        IF dy MOD 20 = 0 THEN
                IF wasisda((dx - 20 - (dx MOD 20)) / 20, (dy - 20) / 20 + 1) = 1 THEN dogmvt = (dogmvt - 14) * 4:  GOTO hops1
                IF dx MOD 20 <> 0 THEN IF wasisda((dx - 20 - (dx MOD 20)) / 20 + 1, (dy - 20) / 20 + 1) = 1 THEN dogmvt = (dogmvt - 14) * 4
        END IF
        IF dy = 380 THEN dogmvt = (dogmvt - 14) * 4:  GOTO hops1
hops1:
IF napf < vorhernapf THEN IF f(startx, starty + 1) = 2 THEN dogmvt = 0 ELSE dogmvt = 14 'bl”des geschummele!
CASE 16 TO 17
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dy = dy - 5
        IF dy MOD 20 = 0 THEN dogmvt = dogmvt - 2
CASE 18
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dy = dy - 5: dx = dx - 4
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 - 1, (dy - 20 - (dy MOD 20)) / 20) = 1 THEN dogmvt = 15
        IF dx MOD 20 <> 0 AND dy MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 - 1, (dy - 20 - (dy MOD 20)) / 20 + 1) = 1 THEN dogmvt = 15
        IF dy MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 - 1, (dy - 20) / 20) = 0 THEN dogmvt = 19 ELSE dogmvt = 15
CASE 19
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dx = dx - 4: ger = ger + 1
        IF wasisda((dx - 20 - (dx MOD 20)) / 20, (dy - 20) / 20 + 1) = 1 THEN ger = 0: dogmvt = 4
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 - 1, (dy - 20) / 20) = 1 THEN ger = 0: dogmvt = 15
        IF ger = 6 THEN
                ger = 0
                IF wasisda((dx - 20 - (dx MOD 20)) / 20 - 1, (dy - 20) / 20 + 1) = 1 THEN dogmvt = 15 ELSE dogmvt = 20
        END IF
CASE 20
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dx = dx - 4: dy = dy + 5
        IF dy MOD 20 = 0 THEN
                IF wasisda((dx - 20 - (dx MOD 20)) / 20, (dy - 20) / 20 + 1) = 1 OR (dx MOD 20 <> 0 AND wasisda((dx - 20 - (dx MOD 20)) / 20 + 1, (dy - 20) / 20 + 1) = 1) THEN
                dogmvt = 4
                GOTO hops2
                ELSE dogmvt = 15
                GOTO hops2
                END IF
        END IF
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 - 1, (dy - 20 - (dy MOD 20)) / 20) = 1 THEN dogmvt = 15
hops2:
CASE 21
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dy = dy - 5: dx = dx + 4
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 + 1, (dy - 20 - (dy MOD 20)) / 20) = 1 THEN dogmvt = 14
        IF dx MOD 20 <> 0 AND dy MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 + 1, (dy - 20 - (dy MOD 20)) / 20 + 1) = 1 THEN dogmvt = 14
        IF dy MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 + 1, (dy - 20) / 20) = 0 THEN dogmvt = 22 ELSE dogmvt = 14
CASE 22
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dx = dx + 4: ger = ger + 1
        IF wasisda((dx - (dx MOD 20)) / 20, (dy - 20) / 20 + 1) = 1 THEN ger = 0: dogmvt = 0
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 + 1, (dy - 20) / 20) = 1 THEN ger = 0: dogmvt = 14
        IF ger = 6 THEN
                ger = 0
                IF wasisda((dx - 20 - (dx MOD 20)) / 20 + 1, (dy - 20) / 20 + 1) = 1 THEN dogmvt = 14 ELSE dogmvt = 23
        END IF
CASE 23
        LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
        dx = dx + 4: dy = dy + 5
        IF dy MOD 20 = 0 THEN
                IF wasisda((dx - (dx MOD 20)) / 20 - 1, (dy - 20) / 20 + 1) = 1 OR wasisda((dx - (dx MOD 20)) / 20, (dy - 20) / 20 + 1) = 1 THEN  'dx MOD 20 = 0 AND
                dogmvt = 0
                GOTO hops3
                ELSE
                dogmvt = 14
                GOTO hops3
                END IF
        END IF
        IF dx MOD 20 = 0 THEN IF wasisda((dx - 20) / 20 + 1, (dy - 20 - (dy MOD 20)) / 20) = 1 THEN dogmvt = 14
hops3:
END SELECT
RETURN

gegmov:
IF geganz = 0 THEN RETURN
FOR a = 1 TO geganz
SELECT CASE geg(a, 2)

CASE 0                                  'hammerratte
 LINE (geg(a, 0), geg(a, 1))-(geg(a, 0) + 19, geg(a, 1) + 19), 7, BF
 geg(a, 0) = geg(a, 0) + (8 * geg(a, 3) - 4)
 IF geg(a, 3) = 0 THEN
  PUT (geg(a, 0), geg(a, 1)), maus&, PSET
  IF dy = geg(a, 1) AND dx > geg(a, 0) - 25 AND dx < geg(a, 0) THEN GOTO hau1
 ELSE
  PUT (geg(a, 0), geg(a, 1)), mausr&, PSET
  IF dy = geg(a, 1) AND dx < geg(a, 0) + 25 AND dx > geg(a, 0) THEN GOTO hau2
 END IF
 IF geg(a, 0) MOD 20 = 0 THEN
  IF f(geg(a, 0) / 20 - 2 + 2 * geg(a, 3), geg(a, 1) / 20 - 1) = 2 OR f(geg(a, 0) / 20 - 2 + 2 * geg(a, 3), geg(a, 1) / 20) = 255 THEN geg(a, 3) = 1 - geg(a, 3)
 END IF

CASE 1                                  'fledermaus
 LINE (geg(a, 0), geg(a, 1))-(geg(a, 0) + 19, geg(a, 1) + 19), 7, BF
 geg(a, 0) = geg(a, 0) + (8 * geg(a, 3) - 4)
 IF geg(a, 3) = 0 THEN
  PUT (geg(a, 0), geg(a, 1)), flyl1&, PSET
 ELSE
  PUT (geg(a, 0), geg(a, 1)), flyr1&, PSET
 END IF
 IF dx > geg(a, 0) - 5 AND dx < geg(a, 0) + 5 AND dy > geg(a, 1) THEN GOSUB bomb
 IF geg(a, 0) MOD 20 = 0 THEN
  IF f(geg(a, 0) / 20 - 2 + 2 * geg(a, 3), geg(a, 1) / 20 - 1) = 2 THEN geg(a, 3) = 1 - geg(a, 3)
 END IF

CASE 2                                  'bombe
 LINE (geg(a, 0), geg(a, 1))-(geg(a, 0) + 19, geg(a, 1) + 9), 7, BF
 geg(a, 1) = geg(a, 1) + 5
 PUT (geg(a, 0), geg(a, 1)), bomb&, PSET
 IF geg(a, 0) > dx - 15 AND geg(a, 0) < dx + 15 AND geg(a, 1) > dy - 10 AND geg(a, 1) < dy + 20 THEN GOTO expldog
 IF geg(a, 1) MOD 20 = 10 THEN
  IF f((geg(a, 0) - (geg(a, 0) MOD 20)) / 20 - 1, (geg(a, 1) - (geg(a, 1) MOD 20)) / 20) = 2 THEN GOSUB expl: GOTO hop4
  IF geg(a, 0) MOD 20 <> 0 AND f((geg(a, 0) - (geg(a, 0) MOD 20)) / 20, (geg(a, 1) - (geg(a, 1) MOD 20)) / 20) = 2 THEN GOSUB expl
 END IF
hop4:

END SELECT
NEXT
RETURN

hau1:
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (geg(a, 0), geg(a, 1)), maus2&, PSET
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (geg(a, 0), geg(a, 1)), maus3&, PSET
PUT (geg(a, 0) - 20, geg(a, 1)), hamml&, PSET
IF napf > 0 THEN
napf = napf - 1
showbones
GOTO nextlev
ELSE
GOTO ende
END IF

hau2:
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (geg(a, 0), geg(a, 1)), maus2r&, PSET
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (geg(a, 0), geg(a, 1)), maus3r&, PSET
PUT (geg(a, 0) + 20, geg(a, 1)), hammr&, PSET
IF napf > 0 THEN
napf = napf - 1
showbones
GOTO nextlev
ELSE
GOTO ende
END IF

ende:
DO: LOOP WHILE INKEY$ = ""
CLEAR
CHDIR ".."
SYSTEM

ziel:
LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
PUT (zielx * 20 + 20, ziely * 20 + 20), athome&, PSET
FOR a = 1 TO 20: a$ = INKEY$: NEXT
DO: LOOP WHILE INKEY$ = ""
abrech
IF nx$ <> "            " THEN loadlev nx$: GOTO nextlev
CLEAR
SYSTEM

bomb:
IF bomb > 2 THEN RETURN
geganz = geganz + 1: bomb = bomb + 1
geg(geganz, 0) = geg(a, 0)
geg(geganz, 1) = geg(a, 1)
geg(geganz, 2) = 2
geg(geganz, 3) = 0
RETURN
expl:
LINE (geg(a, 0), geg(a, 1))-(geg(a, 0) + 19, geg(a, 1) + 9), 7, BF
FOR n = a TO geganz - 1
geg(n, 0) = geg(n + 1, 0)
geg(n, 1) = geg(n + 1, 1)
geg(n, 2) = geg(n + 1, 2)
geg(n, 3) = geg(n + 1, 3)
NEXT
geganz = geganz - 1: bomb = bomb - 1
RETURN
expldog:
GOSUB expl
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (dx, dy), explo1&, PSET
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (dx, dy), explo2&, PSET
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (dx, dy), explo3&, PSET
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .02
PUT (dx, dy), explo4&, PSET
IF napf > 0 THEN
napf = napf - 1
showbones
GOTO nextlev
ELSE
GOTO ende
END IF

SUB abrech
FOR a = knochen TO 1 STEP -1
LINE (napf * 20 + 40 + a * 5, 420)-(napf * 20 + 45 + a * 5, 440), 0, BF
pu = pu + 100
LOCATE 1: PRINT pu
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .1
NEXT
knochen = 0
LOCATE 1
PRINT pu
END SUB

SUB catdetect
OUT &H388, &H4
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &H60
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
OUT &H388, &H4
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &H80
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
isda1 = INP(&H388)
OUT &H388, &H2
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &HFF
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
OUT &H388, &H4
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &H21
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
wart! = TIMER: DO: LOOP UNTIL TIMER > wart! + .8
isda2 = INP(&H388)
OUT &H388, &H4
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &H60
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
OUT &H388, &H4
FOR lop = 1 TO 6
in = INP(&H388)
NEXT
OUT &H389, &H80
FOR lop = 1 TO 35
in = INP(&H388)
NEXT
daisse1 = isda1 AND &HE0: daisse2 = isda2 AND &HE0
adl% = 0: IF daisse1 = 0 AND daisse2 = 192 THEN adl% = 1
END SUB

SUB loadlev (lev$)
geganz = 0
OPEN lev$ FOR BINARY AS #1
FOR x = 1 TO 28 STEP 4
FOR y = 1 TO 18
GET #1, n * 4 + 1, pt&
pt$ = MKL$(pt&)
f(x, y) = ASC(LEFT$(pt$, 1))
f(x + 1, y) = ASC(MID$(pt$, 2, 1))
f(x + 2, y) = ASC(MID$(pt$, 3, 1))
f(x + 3, y) = ASC(MID$(pt$, 4, 1))
n = n + 1
NEXT
NEXT
li$ = INPUT$(12, #1)
re$ = INPUT$(12, #1)
ob$ = INPUT$(12, #1)
un$ = INPUT$(12, #1)
nx$ = INPUT$(12, #1)
startx = dx / 20 - 1: starty = dy / 20 - 1
FOR x = 1 TO 28
FOR y = 1 TO 18
putscreen x, y
SELECT CASE f(x, y)
CASE 1
f(x, y) = 255: startx = x: starty = y
IF f(x, y + 1) = 255 THEN dogmvt = 14
CASE 4
zielx = x: ziely = y
CASE 6
f(x, y) = 255
geganz = geganz + 1
geg(geganz, 0) = x * 20 + 20
geg(geganz, 1) = y * 20 + 20
geg(geganz, 2) = 0
geg(geganz, 3) = 0
CASE 7
f(x, y) = 255
geganz = geganz + 1
geg(geganz, 0) = x * 20 + 20
geg(geganz, 1) = y * 20 + 20
geg(geganz, 2) = 0
geg(geganz, 3) = 1
CASE 9
f(x, y) = 255
geganz = geganz + 1
geg(geganz, 0) = x * 20 + 20
geg(geganz, 1) = y * 20 + 20
geg(geganz, 2) = 1
geg(geganz, 3) = 0
CASE 10
f(x, y) = 255
geganz = geganz + 1
geg(geganz, 0) = x * 20 + 20
geg(geganz, 1) = y * 20 + 20
geg(geganz, 2) = 1
geg(geganz, 3) = 1
END SELECT
NEXT
NEXT
CLOSE #1
END SUB

FUNCTION nextdogmvt (mvt)
SELECT CASE mvt
CASE 3
newdog = 0
CASE 7
newdog = 4
CASE 10
newdog = 0
CASE 13
newdog = 4
CASE 14 TO 24
newdog = mvt
CASE ELSE
newdog = mvt + 1
END SELECT
nextdogmvt = newdog
END FUNCTION

SUB playadlib (comand$)
STATIC tempo, length, music, octave
IF comand$ = "{INIT}" THEN
 tempo = 120
 length = 4
 music = 7 / 8
 octave = 4
 EXIT SUB
END IF
comand$ = UCASE$(comand$)
FOR i% = 0 TO 224
 WriteReg i%, 0
NEXT i%
WriteReg &H20, &H1
WriteReg &H23, &H1
WriteReg &H40, &H1F
WriteReg &H43, &H0
WriteReg &H60, &HE4
WriteReg &H63, &HE4
WriteReg &H80, &H9D
WriteReg &H83, &H9D
c% = 1
max% = LEN(comand$)
WHILE c% <= max%
 x$ = MID$(comand$, c%, 1): c% = c% + 1
 IF INSTR("ABCDEFG", x$) <> 0 AND (c% <> max% AND INSTR("+#-", MID$(comand$, c%, 1))) THEN
  x$ = x$ + MID$(comand$, c%, 1): c% = c% + 1
  IF RIGHT$(x$, 1) = "+" THEN x$ = LEFT$(x$, 1) + "#"
  IF x$ = "D-" THEN x$ = "C#"
  IF x$ = "E-" THEN x$ = "D#"
  IF x$ = "G-" THEN x$ = "F#"
  IF x$ = "A-" THEN x$ = "G#"
  IF x$ = "B-" THEN x$ = "A#"
 ELSEIF x$ = "O" THEN
  adj% = VAL(MID$(comand$, c%, 1)): c% = c% + 1
  IF adj% >= 0 AND adj% <= 6 THEN octave = adj%
 ELSEIF x$ = "<" AND octave > 0 THEN
  octave = octave - 1
 ELSEIF x$ = ">" AND octave < 6 THEN
  octave = octave + 1
 ELSEIF x$ = "L" THEN
  num$ = ""
  WHILE INSTR("0123456789", MID$(comand$, c%, 1))
   num$ = num$ + MID$(comand$, c%, 1): c% = c% + 1
  WEND
  IF VAL(LTRIM$(num$)) >= 1 AND VAL(LTRIM$(num$)) <= 64 THEN length = VAL(LTRIM$(num$))
 ELSEIF x$ = "P" THEN
  dotfac = 1
  num$ = ""
  num$ = MID$(comand$, c%, 1): c% = c% + 1
  WHILE MID$(comand$, c%, 1) = "."
   dotfac = dotfac * 1.5: c% = c% + 1
  WEND
  IF VAL(num$) >= 1 AND VAL(num$) <= 64 THEN
   start! = TIMER
   ender! = start! + (((1 / VAL(num$)) * dotfac) * ((tempo / 120) * 2) * music) / 2'/2 weg
   EXIT SUB
   END IF
 ELSEIF x$ = "M" THEN
  next$ = MID$(comand$, c%, 1): c% = c% + 1
  x$ = x$ + next$
  IF x$ = "MN" THEN music = 7 / 8
  IF x$ = "MS" THEN music = 3 / 4
  IF x$ = "ML" THEN music = 1
 END IF
 IF INSTR("ABCDEFG", LEFT$(x$, 1)) THEN
  dotfac = 1
  WHILE MID$(comand$, c%, 1) = "."
   dotfac = dotfac * 1.5: c% = c% + 1
  WEND
  SELECT CASE x$
  CASE "C#"
   WriteReg &HA0, &H6B
   WriteReg &HB0, &H21 + 4 * octave
  CASE "D"
   WriteReg &HA0, &H81
   WriteReg &HB0, &H21 + 4 * octave
  CASE "D#"
   WriteReg &HA0, &H98
   WriteReg &HB0, &H21 + 4 * octave
  CASE "E"
   WriteReg &HA0, &HB0
   WriteReg &HB0, &H21 + 4 * octave
  CASE "F"
   WriteReg &HA0, &HCA
   WriteReg &HB0, &H21 + 4 * octave
  CASE "F#"
   WriteReg &HA0, &HE5
   WriteReg &HB0, &H21 + 4 * octave
  CASE "G"
   WriteReg &HA0, &H2
   WriteReg &HB0, &H22 + 4 * octave
  CASE "G#"
   WriteReg &HA0, &H20
   WriteReg &HB0, &H22 + 4 * octave
  CASE "A"
   WriteReg &HA0, &H41
   WriteReg &HB0, &H22 + 4 * octave
  CASE "A#"
   WriteReg &HA0, &H63
   WriteReg &HB0, &H22 + 4 * octave
  CASE "B"
   WriteReg &HA0, &H87
   WriteReg &HB0, &H22 + 4 * octave
  CASE "C"
   WriteReg &HA0, &HAE
   WriteReg &HB0, &H22 + 4 * (octave - 1)
  END SELECT
  start! = TIMER
  ender! = start! + ((1 / length) * dotfac) * ((tempo / 120) * 2) * music / 2'/2 weg
  EXIT SUB
  END IF
WEND
END SUB

SUB playbg
IF TIMER < ender! THEN EXIT SUB
IF EOF(255) THEN CLOSE #255:  OPEN bgsound$ FOR INPUT AS #255
LINE INPUT #255, ply$
WriteReg &HB0, 0
playadlib ply$  'PLAY ply$ if you don't possess an adlib-compatible
END SUB

SUB putdog (x, y)
SELECT CASE dogmvt
  CASE 0
  PUT (x, y), dogr1&, PSET
  CASE 1
  PUT (x, y), dogr2&, PSET
  CASE 2
  PUT (x, y), dogr1&, PSET
  CASE 3
  PUT (x, y), dogr3&, PSET
  CASE 4
  PUT (x, y), dogl1&, PSET
  CASE 5
  PUT (x, y), dogl2&, PSET
  CASE 6
  PUT (x, y), dogl1&, PSET
  CASE 7
  PUT (x, y), dogl3&, PSET
  CASE 8
  PUT (x, y), ouch1&, PSET
  CASE 9
  PUT (x, y), ouch2&, PSET
  CASE 10
  PUT (x, y), ouch3&, PSET
  CASE 11
  PUT (x, y), ouch1l&, PSET
  CASE 12
  PUT (x, y), ouch2l&, PSET
  CASE 13
  PUT (x, y), ouch3l&, PSET
  CASE 14
  PUT (x, y), fallr&, PSET
  CASE 15
  PUT (x, y), falll&, PSET
  CASE 16
  PUT (x, y), jumpr&, PSET
  CASE 17 TO 19
  PUT (x, y), jumpl&, PSET
  CASE 20
  PUT (x, y), falll&, PSET
  CASE 21 TO 22
  PUT (x, y), jumpr&, PSET
  CASE 23
  PUT (x, y), fallr&, PSET
  CASE 24
  PUT (x, y), sleepy&, PSET
END SELECT
END SUB

SUB putscreen (x, y)
SELECT CASE f(x, y)
CASE 1
PUT (x * 20 + 20, y * 20 + 20), dogr1&, PSET
CASE 2
PUT (x * 20 + 20, y * 20 + 20), boden&, PSET
CASE 3
PUT (x * 20 + 20, y * 20 + 20), knochen&, PSET
CASE 4
PUT (x * 20 + 20, y * 20 + 20), haus&, PSET
CASE 5
PUT (x * 20 + 20, y * 20 + 20), spitz&, PSET
CASE 6
PUT (x * 20 + 20, y * 20 + 20), maus&, PSET
CASE 7
PUT (x * 20 + 20, y * 20 + 20), mausr&, PSET
CASE 8
PUT (x * 20 + 20, y * 20 + 20), napf&, PSET
CASE 9
PUT (x * 20 + 20, y * 20 + 20), flyl1&, PSET
CASE 10
PUT (x * 20 + 20, y * 20 + 20), flyr1&, PSET
CASE ELSE
LINE (x * 20 + 20, y * 20 + 20)-(x * 20 + 39, y * 20 + 39), 7, BF
END SELECT
END SUB

SUB showbones
FOR a = 1 TO napf
PUT (a * 20 + 20, 420), napf&, PSET
NEXT
LINE (napf * 20 + 40, 420)-(napf * 20 + 60, 440), 0, BF
FOR a = 1 TO knochen
PUT (napf * 20 + 40 + a * 5, 420), kv&, PSET
NEXT
LINE (napf * 20 + 45 + knochen * 5, 420)-(640, 440), 0, BF
END SUB

SUB vorspann
SCREEN 12
OPEN "dogpull1.n22" FOR BINARY AS #1
OPEN "dogpull2.n22" FOR BINARY AS #2
OPEN "banner1.n22" FOR BINARY AS #3
OPEN "banner2.n22" FOR BINARY AS #4
OPEN "banner3.n22" FOR BINARY AS #5
OPEN "banner4.n22" FOR BINARY AS #6
OPEN "banner5.n22" FOR BINARY AS #7
OPEN "bannerl.n22" FOR BINARY AS #8
FOR a = 0 TO 60
GET #1, a * 4 + 1, dp1&(a)
GET #2, a * 4 + 1, dp2&(a)
GET #3, a * 4 + 1, ban11&(a)
GET #4, a * 4 + 1, ban12&(a)
GET #5, a * 4 + 1, ban13&(a)
GET #6, a * 4 + 1, ban14&(a)
GET #7, a * 4 + 1, ban15&(a)
GET #8, a * 4 + 1, banl&(a)
NEXT
CLOSE #1, #2, #3, #4, #5, #6, #7, #8
OPEN "banner21.n22" FOR BINARY AS #1
OPEN "banner22.n22" FOR BINARY AS #2
OPEN "banner31.n22" FOR BINARY AS #3
OPEN "banner32.n22" FOR BINARY AS #4
OPEN "banner33.n22" FOR BINARY AS #5
OPEN "banner34.n22" FOR BINARY AS #6
OPEN "bannerr.n22" FOR BINARY AS #7
OPEN "dogfront.n22" FOR BINARY AS #8
OPEN "pfeil1.n22" FOR BINARY AS #9
FOR a = 0 TO 60
GET #1, a * 4 + 1, ban21&(a)
GET #2, a * 4 + 1, ban22&(a)
GET #3, a * 4 + 1, ban31&(a)
GET #4, a * 4 + 1, ban32&(a)
GET #5, a * 4 + 1, ban33&(a)
GET #6, a * 4 + 1, ban34&(a)
GET #7, a * 4 + 1, banr&(a)
GET #8, a * 4 + 1, front&(a)
GET #9, a * 4 + 1, pfeil1&(a)
NEXT
CLOSE #1, #2, #3, #4, #5, #6, #7, #8, #9
PAINT (320, 240), 7

FOR a = 620 TO 0 STEP -5
playbg
dm = 1 - dm
IF a > 250 THEN
IF dm = 1 THEN PUT (a, 100), dp1&, PSET ELSE PUT (a, 100), dp2&, PSET
ELSE
LINE (a + 20, 100)-(a + 25, 119), 7, BF
PUT (256, 100), banl&, PSET
IF dm = 1 THEN PUT (a, 100), dogl1&, PSET ELSE PUT (a, 100), dogl2&, PSET
END IF
IF a <= 600 AND a > 250 THEN PUT (a + 20, 100), ban11&, PSET
IF a <= 580 AND a > 250 THEN PUT (a + 40, 100), ban12&, PSET
IF a <= 560 AND a > 250 THEN PUT (a + 60, 100), ban13&, PSET
IF a <= 540 AND a > 250 THEN PUT (a + 80, 100), ban14&, PSET
IF a <= 520 AND a > 250 THEN
PUT (a + 100, 100), ban15&, PSET
LINE (a + 120, 100)-(a + 139, 119), 7, BF
END IF
warte! = TIMER: DO: LOOP UNTIL TIMER > warte! + gamespeed! + .1
NEXT
LINE (0, 100)-(19, 119), 7, BF

FOR a = 620 TO 0 STEP -5
playbg
dm = 1 - dm
IF a > 300 THEN
IF dm = 1 THEN PUT (a, 150), dp1&, PSET ELSE PUT (a, 150), dp2&, PSET
ELSE
LINE (a + 20, 150)-(a + 25, 169), 7, BF
PUT (306, 150), banl&, PSET
IF dm = 1 THEN PUT (a, 150), dogl1&, PSET ELSE PUT (a, 150), dogl2&, PSET
END IF
IF a <= 600 AND a > 300 THEN PUT (a + 20, 150), ban21&, PSET
IF a <= 580 AND a > 300 THEN
PUT (a + 40, 150), ban22&, PSET
LINE (a + 60, 150)-(a + 79, 169), 7, BF
END IF
warte! = TIMER: DO: LOOP UNTIL TIMER > warte! + gamespeed! + .1
NEXT
LINE (0, 150)-(19, 169), 7, BF

FOR a = 620 TO 0 STEP -5
playbg
dm = 1 - dm
IF a > 220 THEN
IF dm = 1 THEN PUT (a, 200), dp1&, PSET ELSE PUT (a, 200), dp2&, PSET
ELSE
LINE (a + 20, 200)-(a + 25, 219), 7, BF
PUT (226, 200), banl&, PSET
IF dm = 1 THEN PUT (a, 200), dogl1&, PSET ELSE PUT (a, 200), dogl2&, PSET
END IF
IF a <= 600 AND a > 220 THEN PUT (a + 20, 200), ban31&, PSET
IF a <= 580 AND a > 220 THEN PUT (a + 40, 200), ban32&, PSET
IF a <= 560 AND a > 220 THEN PUT (a + 60, 200), ban33&, PSET
IF a <= 540 AND a > 220 THEN PUT (a + 80, 200), ban34&, PSET
IF a <= 520 AND a > 220 THEN
PUT (a + 100, 200), banr&, PSET
LINE (a + 120, 200)-(a + 139, 219), 7, BF
END IF
warte! = TIMER: DO: LOOP UNTIL TIMER > warte! + gamespeed! + .1
NEXT
LINE (0, 200)-(19, 219), 7, BF
COLOR 7: LOCATE 17, 30: PRINT "Proudly presents:"

FOR a = 620 TO 310 STEP -5
playbg
dm = 1 - dm
IF dm = 1 THEN LINE (a + 20, 300)-(a + 39, 319), 7, BF: PUT (a, 300), dogl1&, PSET ELSE LINE (a + 20, 300)-(a + 39, 319), 7, BF: PUT (a, 300), dogl2&, PSET
warte! = TIMER: DO: LOOP UNTIL TIMER > warte! + gamespeed! + .1
NEXT
PUT (310, 300), front&, PSET
warte! = TIMER: DO: LOOP UNTIL TIMER > warte! + gamespeed! + 1
PUT (330, 320), pfeil1&, PSET
LOCATE 21, 45: PRINT "!SNOOPY!"

FOR a = 0 TO 20
a$ = INKEY$
NEXT
DO
playbg
LOOP WHILE INKEY$ = ""
CLS
END SUB

FUNCTION wasisda (x, y)
IF y > 18 THEN
IF un$ = "            " THEN daiswas = 1: GOTO hopda ELSE dy = 1 * 20 + 20: y = 2: loadlev un$
ELSEIF y < 1 THEN
IF ob$ = "            " THEN daiswas = 1: GOTO hopda ELSE dy = 18 * 20 + 20: y = 17: loadlev ob$
ELSEIF x > 28 THEN
IF re$ = "            " THEN daiswas = 1: GOTO hopda ELSE dx = 1 * 20 + 20: x = 2: loadlev re$
ELSEIF x < 1 THEN
IF li$ = "            " THEN daiswas = 1: GOTO hopda ELSE dx = 28 * 20 + 20: x = 27: loadlev li$
END IF
SELECT CASE f(x, y)
CASE 2
daiswas = 1
CASE 3
knochen = knochen + 1
f(x, y) = 255
LINE (x * 20 + 20, y * 20 + 20)-(x * 20 + 39, y * 20 + 39), 7, BF
showbones
CASE 4
daiswas = 1'ZIEL!!!
CASE 5
IF dogmvt <> 23 AND dogmvt <> 20 THEN GOTO toti1
CASE 8
napf = napf + 1
f(x, y) = 255
LINE (x * 20 + 20, y * 20 + 20)-(x * 20 + 39, y * 20 + 39), 7, BF
showbones
END SELECT
GOTO hopda
toti1:
LINE (dx, dy)-(dx + 19, dy + 19), 7, BF
PUT (x * 20 + 20, y * 20 + 20), half&, PSET
IF napf > 0 THEN
napf = napf - 1
dx = startx * 20 + 20
dy = starty * 20 + 20
putdog dx, dy
showbones
EXIT FUNCTION'GOTO nextlev
END IF
DO: LOOP WHILE INKEY$ = ""
SYSTEM

hopda:
wasisda = daiswas
END FUNCTION

SUB WriteReg (reg AS INTEGER, value AS INTEGER)
OUT &H388, reg
FOR c% = 0 TO 5
a% = INP(&H388)
NEXT c%
OUT &H389, value
FOR c% = 0 TO 34
a% = INP(&H388)
NEXT c%
END SUB

