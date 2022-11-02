OPTION _EXPLICIT

DO UNTIL _SCREENEXISTS: LOOP
_TITLE "PlasmaDoodle"

' Meta
RANDOMIZE TIMER

' Hardware
DIM ScreenOffsetX
DIM ScreenOffsetY
ScreenOffsetX = -3
ScreenOffsetY = -26

DIM Desktop AS _UNSIGNED LONG
Desktop = _SCREENIMAGE
SCREEN _NEWIMAGE(INT(_WIDTH(Desktop) * .5), INT(_HEIGHT(Desktop) * .5), 32)
_PUTIMAGE (-_SCREENX + ScreenOffsetX, -_SCREENY + ScreenOffsetY), Desktop

' Constants
DIM SHARED pi AS DOUBLE
pi = 4 * ATN(1)

' Structures and variables
TYPE ShadeVector
    VelocityRed AS INTEGER
    VelocityGreen AS INTEGER
    VelocityBlue AS INTEGER
END TYPE

DIM SHARED MainPhase(_WIDTH, _HEIGHT) AS ShadeVector

DIM i AS DOUBLE
DIM j AS DOUBLE

DIM r AS INTEGER
DIM g AS INTEGER
DIM b AS INTEGER

DIM p AS DOUBLE
DIM q AS DOUBLE
DIM w AS INTEGER

_DISPLAY

FOR i = 1 TO _WIDTH
    FOR j = 1 TO _HEIGHT
        MainPhase(i, j).VelocityRed = 9
        MainPhase(i, j).VelocityGreen = 8
        MainPhase(i, j).VelocityBlue = 7
    NEXT
NEXT

DIM t2
DIM mx
DIM my

' Main loop
DO
    IF _KEYHIT = ASC(" ") THEN
        _PUTIMAGE (-_SCREENX + ScreenOffsetX, -_SCREENY + ScreenOffsetY), Desktop
    END IF
    DO WHILE _MOUSEINPUT
        mx = _MOUSEX
        my = _MOUSEY
        IF _MOUSEBUTTON(1) THEN
            GOSUB DrawIt
        END IF
    LOOP
    _DISPLAY
    _LIMIT 60
LOOP

' Graphics
DrawIt:
FOR i = mx - 40 TO mx + 40
    FOR j = my - 40 TO my + 40
        IF ((i > 0) AND (i < _WIDTH) AND (j > 0) AND (j < _HEIGHT)) THEN
            t2 = (i - mx) * (i - mx) + (j - my) * (j - my)
            'IF (t2 < 1600) THEN
            r = _RED32(POINT(i, j))
            g = _GREEN32(POINT(i, j))
            b = _BLUE32(POINT(i, j))
            p = MainPhase(i, j).VelocityRed
            q = MainPhase(i, j).VelocityGreen
            w = MainPhase(i, j).VelocityBlue
            r = r + p
            IF (r > 255) OR (r < 1) THEN MainPhase(i, j).VelocityRed = -p
            g = g + q
            IF (g > 255) OR (g < 1) THEN MainPhase(i, j).VelocityGreen = -q
            b = b + w
            IF (b > 255) OR (b < 1) THEN MainPhase(i, j).VelocityBlue = -w
            PSET (i, j), _RGB32(r, g, b, 255 * (1 - t2 / 1600))
            'END IF
        END IF
    NEXT
NEXT
RETURN

