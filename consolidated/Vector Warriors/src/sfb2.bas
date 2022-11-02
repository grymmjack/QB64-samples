'CHDIR ".\samples\qb45com\action\sfb2"

'                           SFB2:Vector Warriors                             `
'                              by Kevin Reems                                `
'                                1997--1998                                  `
'                              Created Using,                                `
'                  The Slash Engine by Kevin Reems 1997-1998                 `
'----------------------------------------------------------------------------`
'Press F5 To Play                                                            `
'                                                                            `
'Kevin Reems a.k.a. LBt1st - lbt1st@cyberdude.com                            `
'              Please View SFB2 Guide Part-A.html                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'----------------------------------------------------------------------- SFB2

DECLARE SUB AIsuper (pc%, po%)
DECLARE SUB AIfighter (pc%)
DECLARE SUB AIspecial (pc%, po%)
DECLARE SUB AI (pc%)
DECLARE SUB fightername (n%)
DECLARE SUB options ()
DECLARE SUB settings ()
DECLARE SUB setdetails ()
DECLARE SUB ringout (n)
DECLARE SUB floors ()
DECLARE SUB splash (n)
DECLARE SUB fighterpop (n)
DECLARE SUB fightergoo (wee, d)
DECLARE SUB fighterfreeze (wee)
DECLARE SUB fightercompress (n%)
DECLARE SUB fighterpositions ()
DECLARE SUB fighterinit ()
DECLARE SUB fighterender ()
DECLARE SUB fightermove ()
DECLARE SUB ringoutext (n)
DECLARE SUB fighterlimits ()
DECLARE SUB projectiles ()
DECLARE SUB projectilerender ()
DECLARE SUB setdelay ()
DECLARE SUB smear (x%, y%, Z, c%)
DECLARE SUB smearender ()
DECLARE SUB stagewindow (mode%)
DECLARE SUB ocasional ()
DECLARE SUB camtracking ()
DECLARE SUB newmatch ()
DECLARE SUB Conclusion ()
DECLARE SUB setfightercpu ()
DECLARE SUB setfighter ()
DECLARE SUB fall (n)
DECLARE SUB nokey ()
DECLARE SUB jump (n%, T%)
DECLARE SUB setbody (n%)
DECLARE SUB setko (n)
DECLARE SUB keycheck ()
DECLARE SUB decap (n%)
DECLARE SUB fades ()
DECLARE SUB fighterdirect ()
DECLARE SUB rain2d (c1%, c2%, c3%, l!)
DECLARE SUB rain3d (x1!, y1!, z1!, x2!, y2!, z2!, c1%, c2%, c3%, l!)
DECLARE SUB setstagename (n%)
DECLARE SUB AIgetclose (pc%, po%)
DECLARE SUB AIdefend (pc%, po%)
DECLARE SUB AIattack (pc%, po%)



'------------------------------------------------- Perspective Space Commands

DECLARE SUB pspoint (x, y, Z) : '                                  Point

DECLARE SUB pspset (x, y, Z, c%) : '                               Pset

DECLARE SUB psdpset (x, y, z1, z2, c%) : '                         Deep Pset
                                                                  
DECLARE SUB psline (x1, y1, z1, x2, y2, z2, c%, B%) : '            Line

DECLARE SUB psdline (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, B%) : 'Deep Line

DECLARE SUB pscline (x1, y1, z1, x5, y5, z5, r, c%) : '            Circle Line

DECLARE SUB pslightning (x1, y1, z1, x5, y5, z5, r, c%) : '        Lightning

DECLARE SUB pscircle (x, y, Z, r1, c%) : '                         Circle

DECLARE SUB pscube (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%) : '     Cube

DECLARE SUB psmark1 (x, y, Z, c1%, c2%, c3%) : '                   Mark1

DECLARE SUB psmark2 (x, y, c1%, c2%, c3%) : '                      Mark2

DECLARE SUB particle (x, y, Z, T%, Q%) : '               Spawn particle(s)
DECLARE SUB particle2 (x, y, Z, T%, Q%) : '              Continued Spawning
DECLARE SUB particlerender () : '                        Render particles%

DECLARE SUB setparticles () : '                          Particle Options
DECLARE SUB particlerender () : '                        Renders particles%
DECLARE SUB particlemove () : '                          Moves them
DECLARE SUB particleclear () : '                         Clears them
DECLARE SUB decay () : '                                 Kill them


'------------------------------------------------------------- Slash Commands

'Sound
DECLARE FUNCTION DetectCard% ()
DECLARE SUB sbinit ()
DECLARE SUB SBplay (Freq%, Wave%, Feedback%, Modl%, Clen%)
DECLARE SUB SBWrite (Reg%, Value%)
DECLARE SUB sbfx (fxx%)

'Set Sound Options
DECLARE SUB setsound ()

'Clear Space For Text
'open
DECLARE SUB smallwindow ()
DECLARE SUB bigwindow ()
'close
DECLARE SUB csmallwindow ()
DECLARE SUB cbigwindow ()

'Let User Load/Save/Reset
DECLARE SUB loadsave ()

'n = 1 Load   n = 2 Save   n = 3 Reset Defaults
'mode% = n: CALL file
DECLARE SUB file ()

'Change Screen Resolution
DECLARE SUB setrez ()

'Change Clear Method
DECLARE SUB setcmethod ()

'Change frameskip%
DECLARE SUB setframeskip ()

'Change Stage%
DECLARE SUB setstage ()

'Apply Movement to Camera
DECLARE SUB movecam ()

'Exit the Program
DECLARE SUB quit ()

'Window x/y
DECLARE SUB winxwiny ()

'Slash Mud
DECLARE SUB mud ()

'Temporary Blur
DECLARE SUB blur (l%)

'Reset Camera Defaults
DECLARE SUB camdefaults ()

'Page Flip
DECLARE SUB pflip ()

'Clear Screen
DECLARE SUB clearscreen ()

'Block Clearing
DECLARE SUB clsblock (n)

'Pauses
DECLARE SUB pause ()

'Waits for Input After an Error Trap
DECLARE SUB errorkey ()

'2D Stars
DECLARE SUB stars2d (c1%, c2%, c3%)

'3D Stars
DECLARE SUB stars3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)

'Offset the Stars
DECLARE SUB starsoffset (x, y)

'Randomize Stars
DECLARE SUB starsrnd ()

'Set Number of Stars
DECLARE SUB setstars ()

'Sets defaults for the current stage
DECLARE SUB stageinit ()

'Stage Shifting
DECLARE SUB stageshifting ()

'Render current stage
DECLARE SUB stagebackground ()
DECLARE SUB stageforground ()

'Display i16 Image
DECLARE SUB i16 (x, y, x2, y2, F$)
DECLARE SUB seti16 ()

'Get path$ from file
DECLARE SUB getpath ()

'Set path$
DECLARE SUB setpath ()

'Render Something on Page 2
DECLARE SUB page2 ()

'Test the Video Pages
DECLARE SUB pagetest ()

'Define Window for 2D or 3D Mode
DECLARE SUB window2d ()
DECLARE SUB window3d ()

'----------------------------------------------------------- Shared Variables

Common Shared stars1x, stars1y, stars1z, stars2x, stars2y, stars2z, stars3x, stars3y, stars3z
Common Shared zoom, zoomd, zoomt, panx, pany, panh, panv, midx%, midy%, winx, winy, rez%, xx1, xx2, yy1, yy2, wx, wy, wz, ringoutt%, ringoutp%, victory%, control%, pointc%, refreash, flimits%, dist%, dif%, AImoved%
Common Shared restart%, frameskip%, cmethod%, cfreq%, blurr%, csave%, nstars%, stage%, bob, flash1%, flash2%, flash3%, ver$, trigger1, trigger2, trigger3, solidc%, tpause%, bgcolor%
Common Shared gravity, particles%, floor1, floor2, floor3, fault$, setback%, mode%, odds%, ticker%, bobm, midstage, camode%, i16m%, smears%, stagemode%, stages%, delay%, walkx, stagename$
Common Shared sbsound%, P1d, P2d, soundticker%, soundwait%, path$, wee$, hfade%, ctime%, clsb%, pflip1%, pflip2%, ring%, startfight%, stageset%, stagedetail%, fighterdetail%, hudetail%

On Error GoTo 8
fault$ = "dim"

'------------------------------------------------------------------- Fighters
Dim Shared hairt%(1 To 2)
Dim Shared hairl%(1 To 2)
Dim Shared hairc%(1 To 2)
Dim Shared hairx(1 To 10)
Dim Shared hairy(1 To 10)

Dim Shared projectile%(1 To 6)
Dim Shared projectilex(1 To 6)
Dim Shared projectiley(1 To 6)
Dim Shared projectileh(1 To 6)
Dim Shared projectilev(1 To 6)
Dim Shared projectilet%(1 To 6)

Dim Shared name$(1 To 2)
Dim Shared walkx(1 To 2)
Dim walkh(1 To 2)
Dim Shared health%(1 To 2)
Dim Shared maxhp%(1 To 2)
Dim Shared hpslide%(1 To 2)
Dim Shared sdelay%(1 To 2)
Dim Shared ko(1 To 2)
Dim Shared koslide%(1 To 2)
Dim Shared AIactive%(1 To 2)
Dim Shared AIhs%(1 To 2)
Dim Shared AIhm%(1 To 2)
Dim Shared AIhl%(1 To 2)
Dim Shared AIhh%(1 To 2)
Dim Shared AIfs%(1 To 2)
Dim Shared AIfm%(1 To 2)
Dim Shared AIfl%(1 To 2)
Dim Shared AIfh%(1 To 2)

Dim Shared ahpow%(1 To 2)
Dim Shared akpow%(1 To 2)
Dim Shared lhpow%(1 To 2)
Dim Shared lkpow%(1 To 2)

Dim Shared hc%(1 To 2)
Dim Shared kc%(1 To 2)

Dim Shared attackok%(1 To 2)
Dim Shared rage(1 To 2)
Dim Shared vexed%(1 To 2)
Dim Shared ragecharge(1 To 2)
Dim Shared razers%(1 To 2)
Dim Shared kocharge(1 To 2)
Dim Shared win%(1 To 2)
Dim Shared combo%(1 To 2)
Dim Shared combol%(1 To 2)
Dim Shared Special%(1 To 2)

Dim Shared headless%(1 To 2)
Dim Shared hx(1 To 2)
Dim Shared hy(1 To 2)
Dim Shared hh(1 To 2)
Dim Shared hv(1 To 2)

Dim Shared canjump%(1 To 2)
Dim Shared position%(1 To 2)
Dim Shared d%(1 To 2)
Dim Shared ds%(1 To 2)
Dim Shared pticker%(1 To 2)
Dim Shared psaver%(1 To 2)

Dim Shared fighterz(1 To 2)
Dim Shared fighterd(1 To 2)

Dim Shared headx(1 To 4)
Dim Shared neckx(1 To 4)
Dim Shared buttx(1 To 4)
Dim Shared elbow1x(1 To 4)
Dim Shared elbow2x(1 To 4)
Dim Shared hand1x(1 To 4)
Dim Shared hand2x(1 To 4)
Dim Shared nee1x(1 To 4)
Dim Shared nee2x(1 To 4)
Dim Shared foot1x(1 To 4)
Dim Shared foot2x(1 To 4)

Dim Shared heady(1 To 4)
Dim Shared necky(1 To 4)
Dim Shared butty(1 To 4)
Dim Shared elbow1y(1 To 4)
Dim Shared elbow2y(1 To 4)
Dim Shared hand1y(1 To 4)
Dim Shared hand2y(1 To 4)
Dim Shared nee1y(1 To 4)
Dim Shared nee2y(1 To 4)
Dim Shared foot1y(1 To 4)
Dim Shared foot2y(1 To 4)

Dim Shared headh(1 To 2)
Dim Shared neckh(1 To 2)
Dim Shared butth(1 To 2)
Dim Shared elbow1h(1 To 2)
Dim Shared elbow2h(1 To 2)
Dim Shared hand1h(1 To 2)
Dim Shared hand2h(1 To 2)
Dim Shared nee1h(1 To 2)
Dim Shared nee2h(1 To 2)
Dim Shared foot1h(1 To 2)
Dim Shared foot2h(1 To 2)

Dim Shared headv(1 To 2)
Dim Shared neckv(1 To 2)
Dim Shared buttv(1 To 2)
Dim Shared elbow1v(1 To 2)
Dim Shared elbow2v(1 To 2)
Dim Shared hand1v(1 To 2)
Dim Shared hand2v(1 To 2)
Dim Shared nee1v(1 To 2)
Dim Shared nee2v(1 To 2)
Dim Shared foot1v(1 To 2)
Dim Shared foot2v(1 To 2)

'Body Part Types
Dim Shared head%(1 To 2)
Dim Shared body%(1 To 2)
Dim Shared arms%(1 To 2)
Dim Shared hands%(1 To 2)
Dim Shared legs%(1 To 2)
Dim Shared feet%(1 To 2)

'Body Part Colors
Dim Shared headc%(1 To 2)
Dim Shared bodyc%(1 To 2)
Dim Shared armsc%(1 To 2)
Dim Shared handsc%(1 To 2)
Dim Shared legsc%(1 To 2)
Dim Shared feetc%(1 To 2)

'------------------------------------------------------------------ Particles
Dim Shared p%(1 To 90)
Dim Shared pk%(1 To 90)
Dim Shared pg%(1 To 90)
Dim Shared pf%(1 To 90)
Dim Shared px(1 To 90)
Dim Shared py(1 To 90)
Dim Shared pz(1 To 90)
Dim Shared ph(1 To 90)
Dim Shared pv(1 To 90)
Dim Shared pd(1 To 90)
Dim Shared pc1%(1 To 90)
Dim Shared pc2%(1 To 90)
Dim Shared pc3%(1 To 90)

'---------------------------------------------------------------------- Stars
Dim Shared stars1x(1 To 20)
Dim Shared stars1y(1 To 20)
Dim Shared stars1z(1 To 20)
Dim Shared stars2x(1 To 20)
Dim Shared stars2y(1 To 20)
Dim Shared stars2z(1 To 20)
Dim Shared stars3x(1 To 20)
Dim Shared stars3y(1 To 20)
Dim Shared stars3z(1 To 20)

'--------------------------------------------------------------- Blood Smears
Dim Shared smearl%(1 To 10)
Dim Shared smearx%(1 To 10)
Dim Shared smeary%(1 To 10)
Dim Shared smearz(1 To 10)
Dim Shared smearc%(1 To 10)




'----------------------------------------------------------------------------
'Begin the Program                                         Begin the Program`
'----------------------------------------------------------------------------



'----------------------------------------------------------------- Disclaimer
Screen 8
Color , 0
c% = 4
For wee = 1 To 6
    Color c%, 0
    Locate 10, 36
    Print "WARNING:"
    Print ""
    Print "SFB2: Vector Warriors Contains Graphic Violence And Gore That May Be Offending."
    Locate 14, 27: Print "Player Discretion Advised."

    Select Case wee
        Case Is = 1: c% = 12
        Case Is = 2: c% = 15
        Case Is = 3: c% = 12: Sleep 3
        Case Is = 4: c% = 4
        Case Is = 5: c% = 0
    End Select
    For d% = 0 To 15000: Next d%
Next wee



'---------------------------------------------------------------------------`
'Init ----------------------------------------------------------------- Init`
'---------------------------------------------------------------------------`

4
Clear
fault$ = "init"

'------------------------------------+                                      *
'Error And Version Information
On Error GoTo 8: e% = 1
ver$ = "1.00"
'------------------------------------+                                      *

'Show Error Detection Message
If e% = 0 Then
    Locate 1, 1
    Color 15
    Print "Error Detection is OFF"
    Sleep
End If

Randomize (Timer)

'Set NumLock to ON
Def Seg = 0
KeyFlags = Peek(1047)
Poke 1047, KeyFlags Or 32
If (KeyFlags And 32) = 0 Then Def Seg: Def Seg = 0



'---------------------------------------------------------------------------`
'Defaults -=======================================================- Defaults`
'---------------------------------------------------------------------------`



'-------------------------+ Required by Slash
getpath
mode% = 1: file
setback% = 0
starsrnd
pflip1% = 1
flash1% = 1
mud
camdefaults
If sbsound% = 1 Then sbinit

'-------------------------+ Required by Program
stagemode% = 1
stages% = 15
setfightercpu
stageinit
walkh(1) = .5
walkh(2) = .5

'---------------------------------------------------------------------------`
'End Defaults -===============================================- End Defaults`
'---------------------------------------------------------------------------`


'-------------------------- Ready Screen for Slash
If rez% <> 1 And rez% <> 7 And rez% <> 9 And rez% <> 12 Then rez% = 9
Screen rez%
window3d


'--------------------- Clear Vars.
fault$ = ""
wee$ = ""
neckx(3) = -50
neckx(4) = 50



'----------------------------------------------------------------------------
'Start Loop ===================================================== Start Loop`
'----------------------------------------------------------------------------
Do





    '---------------------
    If restart% = 1 Then
        restart% = 0
        Screen , 1, 1
        Cls
        Screen , 0, 0
        Cls
        GoTo 4
    End If


    '---------------------------------------------------------- Alternating Vars.
    If odds% = 0 Then odds% = 1 Else odds% = 0

    For pc1 = 1 To 2
        If walkx(pc1) < 0 Then walkh(pc1) = .8
        If walkx(pc1) > 4 Then walkh(pc1) = -.8
        walkx(pc1) = walkx(pc1) + walkh(pc1)
    Next pc1
 

    '---------------------
    Select Case flash1%

        Case Is = 9
            flash1% = 1
            flash2% = 9
            flash3% = 4

        Case Is = 1
            flash1% = 9
            flash2% = 15
            flash3% = 12
    End Select

    '---------------------
    If bob < 0 Then bobm = bobm + .01 Else bobm = bobm - .01
    bob = bob + bobm

    '---------------------
    If soundticker% > 0 Then soundticker% = soundticker% - 1



    '----------------------------------------------------------- Keyboard Control
    If wee$ <> "" Then
        Def Seg = &H40
        Poke &H1A, Peek(&H1C)
    End If

    wee$ = UCase$(InKey$)

    'Disable Kicks for Demize
    If legs%(1) = 666 Then
        If wee$ = "A" Then wee$ = "Q"
        If wee$ = "S" Then wee$ = "W"
    End If

    Select Case wee$

        'Game Functions
        Case Is = Chr$(27): options
        Case Is = "P": pause

    End Select

    '-------------------------------------------------------------------- Control
    If position%(1) = 1 Or position%(1) = 12 Then attackok%(1) = 1 Else attackok%(1) = 0
    If position%(2) = 1 Or position%(2) = 12 Then attackok%(2) = 1 Else attackok%(2) = 0

    If control% = 1 And AIactive%(1) = 0 And wee$ <> "" Then

        'Convert Extra Keys To Standard Commands
        Select Case wee$
            Case Is = Chr$(0) + "H": wee$ = "8"
            Case Is = Chr$(0) + "K": wee$ = "4"
            Case Is = Chr$(0) + "P": wee$ = "5"
            Case Is = Chr$(0) + "M": wee$ = "6"
            Case Is = "2": wee$ = "5"
        End Select

        'Standard Commands

        If Special%(1) = 0 Then
            'Normal Moves
            Select Case wee$
                Case Is = "Q": If attackok%(1) = 1 And pticker%(1) > 2 Then position%(1) = 2
                Case Is = "W": If position%(1) = 1 And pticker%(1) > 5 Then position%(1) = 3 Else If position%(1) = 12 Then position%(1) = 13
                Case Is = "A": If attackok%(1) = 1 And pticker%(1) > 2 Then position%(1) = 5
                Case Is = "S": If attackok%(1) = 1 Then position%(1) = 6
            End Select
        Else
            'Special Moves
            Select Case wee$
                Case Is = "Q"
                    Select Case hands%(1)
                        Case 1, 666: If projectile%(1) = 0 Then position%(1) = 30
                        Case 2: position%(1) = 31
                        Case 3: position%(1) = 32
                        Case 4, 1998: position%(1) = 33
                        Case 5: If projectile%(1) = 0 Then position%(1) = 34
                    End Select
                Case Is = "W"
                    Select Case hands%(1)
                        Case 1, 666: If projectile%(2) = 0 Then position%(1) = 35
                        Case 2: position%(1) = 36
                        Case 3: position%(1) = 37
                        Case 4: position%(1) = 38
                        Case 5: position%(1) = 39
                        Case 1998: position%(1) = 82
                    End Select
                Case Is = "A"
                    Select Case feet%(1)
                        Case 1: position%(1) = 40
                        Case 2: position%(1) = 41
                        Case 3: position%(1) = 42
                        Case 4: position%(1) = 43
                        Case 5: position%(1) = 44
                    End Select
                Case Is = "S"
                    Select Case feet%(1)
                        Case 1: position%(1) = 45
                        Case 2: If pticker%(1) > 25 Then position%(1) = 46
                        Case 3: If canjump%(1) = 1 Then position%(1) = 47
                        Case 4: position%(1) = 48
                        Case 5: position%(1) = 49
                    End Select
            End Select
        End If

        'Supers
        If wee$ = "D" And rage(1) >= 100 And attackok%(1) = 1 And pticker%(1) > 5 Then
            Select Case body%(1)
                Case 1: position%(1) = 81
                Case 2: position%(1) = 82
                Case 3: position%(1) = 83
                Case 4: position%(1) = 84
                Case 5: position%(1) = 85
                Case 6: If position%(1) = 1 Then position%(1) = 86
                Case 7: If position%(1) = 1 Then position%(1) = 87
                Case 8: position%(1) = 88
                Case 666: position%(1) = 36
            End Select
        End If

        Select Case wee$
            Case Is = "4": If canjump%(1) = 1 Then butth(1) = butth(1) - .5: If butth(1) > 0 Then butth(1) = 0
            Case Is = "6": If canjump%(1) = 1 Then butth(1) = butth(1) + .5: If butth(1) < 0 Then butth(1) = 0
            Case Is = "7": jump (1), 1
            Case Is = "8": jump (1), 2
            Case Is = "9": jump (1), 3
            Case Is = "5": If canjump%(1) = 1 Then position%(1) = 12
            Case Is = "E": If Special%(1) = 0 Then Special%(1) = 1 Else Special%(1) = 0
            Case Is = "R", " ": If attackok%(1) = 1 And pticker%(1) > 10 Then position%(1) = 99

        End Select
    End If


    '---------- AI
    If control% = 1 Then
        dist% = Abs(buttx(1) - buttx(2))
        If AIactive%(1) = 1 And attackok%(1) = 1 Then AI 1
        If AIactive%(2) = 1 And attackok%(2) = 1 Then AI 2
    End If




    '----------------------------------------------------------------------- Misc

    'Show Ready, Begin Stuff
    If ticker% = startfight% And stage% <> 1000 Then showbegin% = 50
    If showbegin% > 0 Then showbegin% = showbegin% - 1: Color 15: Locate 22, 1: Print stagename$
    If showbegin% > 30 Then Color 4: Locate 4, 38: Print "Ready"
    If showbegin% > 0 And showbegin% < 25 Then Color 12: Locate 4, 38: Print "Begin!": control% = 1


    'Run the Ocasional SUB
    occ% = occ% + 1: If occ% > 5 Then occ% = 0: ocasional

    '------------------------------------+
    For wee = 1 To 2

        'Bleed when low on health
        If health%(wee) < Rnd * 50 And Rnd < .5 Then particle (headx(wee + 2)), (heady(wee + 2) + (Rnd * 30)), (fighterz(wee)), 0, 1


        'Gush blood when headless
        If headless%(wee) = 1 Then
            If Abs(butty(wee) - necky(wee + 2)) > 5 Then particle (neckx(wee + 2)), (necky(wee + 2) - 5), fighterz(wee), 2, 1
        End If


        'Fall When KO or Dead
        If health%(wee) <= 0 Or ko(wee) <= 0 Then
            ocasional
            Conclusion
            If position%(wee) < 8 Or position%(wee) > 11 Then fall (wee)
        End If

        'Keep health & ko within limits
        If health%(wee) < 0 Then health%(wee) = 0
        If ko(wee) < 0 Then ko(wee) = 0
        If rage(wee) > 100 Then rage(wee) = 100

        '-------------------------------------------------------------+
        If ticker% = 1 Then
            Select Case stage%
                Case 1
                    fighterfreeze (wee)
                    position%(wee) = 0
                Case 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1000
                    position%(wee) = 1
            End Select
        End If
        '-------------------------------------------------------------+

        'Combo Life
        If combol%(wee) > 0 Then
            combol%(wee) = combol%(wee) - 1
            If combol%(wee) = 0 Then combo%(wee) = 0
        End If

    Next wee



    '-------------------------------------------------------------- Get Framerate
    cyc% = cyc% + 1
    If Timer - time > .6 Then
        refreash = cyc%
        cyc% = 0
        time = Timer

    End If


    '--------------------------------------------------------------------- Camera
    camtracking
    movecam

    '----------------------------------------------------------------- Move Stuff
    fighterpositions
    floors
    fightermove
    projectiles
    If odds% = 1 Then particlemove




    '---------------------------------------------------------------------------`
    '==================================================================== Display
    '---------------------------------------------------------------------------`

    'Color Fades
    fades

    'Stage Shifting
    stageshifting

    'Page Flipping
    If newdisplay% = 1 Then newdisplay% = 0: pflip

    'Temporary Pausing
    If tpause% > 0 Then tpause% = tpause% - 1: Color , 0: Sleep 1

    'Object Life Decaying
    decay

    'Frame Skipping
    'norender% = norender% + 1
    'IF norender% < frameskip% AND blurr% = 0 THEN 3 ELSE norender% = 0

    'Delays
    'FOR wee = 0 TO delay%: NEXT wee
    'flicker = TIMER: DO UNTIL TIMER - flicker > .00001: LOOP
    _Limit 25

    'Clear Screen
    clearscreen


    '============================================================ Render Graphics

    'Draw Background Image If In Screen 8
    'IF rez% = 8 THEN PCOPY 2, pflip1%

    'Background
    stagebackground

    'Render Smears
    If smears% = 1 Then smearender

    'Render Fighters
    fighterender

    'Render projectiles
    projectilerender

    'Render particals
    If particles% > 0 Then particlerender

    'Forground
    stageforground

    newdisplay% = 1

    3: '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- End of 3D Graphics


    '------------------------------------------------------------------------ HUD
    fault$ = "hud"
    window2d

    'Show VS. Info
    If ticker% < startfight% + 50 Then
        Color 15
        If rez% > 7 Then
            Locate 3: Print name$(1)
            Locate 3, 40: Print "VS."
            Locate 3, 70: Print name$(2)
        Else
            Locate 4: Print name$(1)
            Locate 4, 20: Print "VS."
            Locate 4, 30: Print name$(2)
        End If
    End If

    'refreash rate
    Line (15, 0)-(30, 0), 7, , &H1010
    Line (20, 0)-(25, 0), 7, , &H101
    If refreash < 15 Or refreash > 30 Then c% = 12 Else c% = 9
    Line (refreash - .5, 0)-(refreash + .5, 0), c%
    PSet (refreash, 0), 15

    '--------------------------------------+
    hs1% = 45 - (hpslide%(1) / 4.66)
    ks1% = 45 - (koslide%(1) / 2.33)
    h1% = 45 - (health%(1) / 4.66)
    k1 = 45 - (ko(1) / 2.33)

    hs2% = 55 + (hpslide%(2) / 4.66)
    ks2% = 55 + (koslide%(2) / 2.33)
    h2% = 55 + (health%(2) / 4.66)
    k2 = 55 + (ko(2) / 2.33)


    '--------------------------------------- Damage Bars

    'Health
    If h1% < 45 Then
        Line (hs1%, 2.5)-(h1%, 3.3), flash3%, BF
        Line (h1%, 2)-(45, 4), hc%(1), BF
    End If

    If h2% > 55 Then
        Line (h2%, 2.5)-(hs2%, 3.3), flash3%, BF
        Line (55, 2)-(h2%, 4), hc%(2), BF
    End If

    'KO
    If k1 < 45 Then
        Line (ks1%, 5.5)-(k1, 6.3), flash3%, BF
        Line (k1, 5)-(45, 7), kc%(1), BF
    End If

    If k2 > 55 Then
        Line (ks2%, 5.5)-(k2, 6.3), flash3%, BF
        Line (55, 5)-(k2, 7), kc%(2), BF
    End If

    '--------------------------------------- Eye Candy
    If hudetail% = 1 Then
        Line (45, 1)-(55, 8), 15
        Line (45, 8)-(55, 1), 15

        Line (0, 1.2)-(44, 1.2), 8
        Line (0, 8.3)-(44, 8.3), 8
        Line (56, 1.2)-(100, 1.2), 8
        Line (56, 8.3)-(100, 8.3), 8

        Line (0, 1)-(45, 1), 7
        Line (0, 8)-(45, 8), 7
        Line (55, 1)-(100, 1), 7
        Line (55, 8)-(100, 8), 7

        Line (0, .7)-(44, .7), 15
        Line (0, 7.7)-(44, 7.7), 15
        Line (56, .7)-(100, .7), 15
        Line (56, 7.7)-(100, 7.7), 15
    End If


    'Rage
    If hudetail% = 1 Then
        Line (45 - (rage(1) / 2.5), 97.5)-(55 + (rage(2) / 2.5), 97.5), flash1%
        If rage(1) = 100 Then Line (5, 96.8)-(45, 96.8), flash2%
        If rage(2) = 100 Then Line (55, 96.8)-(95, 96.8), flash2%
        Line (45, 96.5)-(55, 96.5), 8
        Line (45, 97.5)-(55, 97.5), 7
        Line (45, 97.8)-(55, 97.8), 8

        'Health Overlays
        Line (44 - (maxhp%(1) / 4.66), 2)-(45, 4), 7, B
        Line (55, 2)-(56 + (maxhp%(2) / 4.66), 4), 7, B

        'KO Overlays
        Line (2, 5)-(45, 7), 7, B
        Line (55, 5)-(98, 7), 7, B

    End If

    'Rage Meter
    Line (45, 96.8)-(55, 96.8), 7
    Line (45 - (rage(1) / 2.5), 97)-(55 + (rage(2) / 2.5), 97), 15


    'Special Boxes
    If Special%(1) = 1 Then Line (0, 96)-(5, 98), flash1%, BF
    Line (0, 96)-(5, 98), 7, B
    If Special%(2) = 1 Then Line (95, 96)-(100, 98), flash1%, BF
    Line (95, 96)-(100, 98), 7, B


    'Win Icons
    If win%(1) > 0 Then
        Line (47, 3.5)-(47, 5.5), 12
        Line (46.3, 5)-(47.5, 5), 12
    End If

    If win%(2) > 0 Then
        Line (52.7, 3.5)-(52.7, 5.5), 12
        Line (52.1, 5)-(53.3, 5), 12
    End If

    'Display Ringout
    If ringoutt% > 0 Then ringoutt% = ringoutt% - 1: ringoutext (ringoutp%)

    window3d
    fault$ = ""
    '-------------------------------------------------------------------- End HUD


Loop
'+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+ End Loop









'================================================================= Error Code
8
Do Until InKey$ = ""
    wee$ = InKey$
Loop

If fault$ <> "file" And fault$ <> "ps" And fault$ <> "save1" And fault$ <> "nokey" Then
    Close #1
    Screen 9, , 0, 0
    Cls
    Color 15
    Sound 1000, 1: Sound 500, 1
    Locate 1, 1: Print "SLASH ERROR:                                                                          "
    Print "                                                                                      "
    Print "                                                                                      "
    Print "                                                                                      "
    Print "Esc - Terminate Program"
    Print "D   - Delete SLASH.DAT (If the File is Corrupt it May Cause Errors)"
    Print "Any Other Key will Attempt to Continue"

    Locate 1, 14

End If

Select Case fault$

    '----------------------------------------------
    Case Is = "load"

        Print "File " + path$ + "\SLASH.DAT is Bad or Missing."
        Print "Slash Will Attempt to Recover Using Default Settings."
        Print "By Saving the Current Settings a New SLASH.DAT May Be Created."
        setback% = 1
        errorkey
        Resume Next


        '----------------------------------------------
    Case Is = "save1"
        ChDir "\"
        MkDir path$
        Close #1
        setback% = 1
        Resume Next

        '----------------------------------------------
    Case Is = "save2"
        Print "Could Not Write File " + path$ + "\SLASH.DAT"
        Print "Slash Will Attempt to Recover Without Saving."
        mode% = 0
        setback% = 2
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "mud"
        Print "There Was a Problem While Displaying The Opening Mud."
        Print "Slash Will Attempt to Bypass It."
        setback% = 1
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "init"
        Print "Could Not Initalize."
        Print "There is Probably a Memory or Video Problem."
        Print "Slash Can Not Recover From This Error."
        Sleep
        System
        Resume Next

        '----------------------------------------------
    Case Is = "pflip"
        Print "Clearing or Flipping Video"
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "hud"
        Print "There Was a Problem While Displaying The HUD."
        Print "Slash Will Attempt to Continue Anyway"
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "file"
        setback% = 1
        Resume Next

        '----------------------------------------------
    Case Is = "ps"
        Color 15
        Locate 21
        Print "PS ERROR"
        Resume Next

        '----------------------------------------------
    Case Is = "ss"
        Print "Problem With Sound Blaster Sound"
        Print "Slash Will Attempt to Continue With Sound Disabled."
        sbsound% = 0
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "particles"
        Print "Problem Spawning/Rendering Particle(s)"
        Print "Slash Will Attempt to Continue With The Particle Engine Disabled."
        setback% = 1
        errorkey
        Resume Next

        '----------------------------------------------
    Case Is = "pagetest"
        Print "Current Screen Mode Does Not Not Support Page " + wee$
        Print "Slash Will Switch Back to Page 0 and Continue Page Test Mode."
        errorkey
        Screen , 0, 0
        Resume Next


        '----------------------------------------------
    Case Is = "dim"
        Print "Problem Allocating Variables"
        Print "You Have Probably Run Out of Conventional Memory"
        Print "Slash Can Not Recover From This Error."
        Sleep
        Resume Next

        '----------------------------------------------
    Case Is = "nokey"
        Resume Next


        '----------------------------------------------
End Select







'----------------------------------------------
Print "Unknown"
errorkey
zoom = zoom + .01
zoomd = 0
Resume Next

Sub AI (pc%)

    If pc% = 2 Then po% = 1 Else po% = 2
    AImoved% = 0


    '--------------------------------------------- Move Away From Downed Opponent
    If position%(po%) > 7 And position%(po%) < 12 And dist% < 25 And pticker%(pc%) > 5 And pticker%(po%) > 15 Then
        If canjump%(pc%) = 1 Then
            AImoved% = 1
            If buttx(pc%) > 0 Then jump (pc%), (1) Else jump (pc%), (3)
        End If
    End If



    '------------------------------------------------------------ Maintain Action
    wee = 0
    If AImoved% = 0 Then
        If pticker%(pc%) > 75 Or position%(po%) = 81 Or dist% < 2 Then wee = 1
    End If
    If wee = 1 Then If Rnd < .5 Then AIgetclose pc%, po% Else AIattack pc%, po%




 
    '-------------------------------------------------------- Normal AI Functions
    'Determine if in air and deside move accordingly

    If Abs(buttv(pc%)) > .5 Then
        AIattack pc%, po%

    Else
        'Defend
        If AImoved% = 0 And ko(pc%) + health%(pc%) < Rnd * dif% * 10 Then
            AIdefend pc%, po%
        Else
            'Attack
            wee = 0
            If buttx(pc%) < buttx(po%) And d%(pc%) = -1 Then wee = 1
            If buttx(pc%) > buttx(po%) And d%(pc%) = 1 Then wee = 1
            If wee = 0 And AImoved% = 0 And dif% > Rnd * 25 Then AIattack pc%, po%
        End If
        'Get Close
        If AImoved% = 0 And Abs(buttx(po%)) < ring% - 50 And canjump%(pc%) = 1 And dif% > Rnd * 30 And dist% > 18 Then AIgetclose pc%, po%



        '----------------------------------------------------------- Avoid Projectile
        If dif% > Rnd * 25 Then

            If pc% = 2 Then
                If dif% > Rnd * 25 Then
                    If projectile%(1) > 0 And position%(2) = 1 And projectilex(1) > buttx(2) - 75 And projectilex(1) < buttx(2) + 75 Then
                        If Rnd < .5 Then
                            jump 2, 2
                        Else
                            If Rnd < .5 Then position%(2) = 99 Else position%(2) = 12
                        End If
                    End If
                End If
            Else
                If projectile%(4) > 0 And position%(1) = 1 And projectilex(4) > buttx(1) - 75 And projectilex(4) < buttx(1) + 75 Then
                    If Rnd < .5 Then
                        jump 1, 2
                    Else
                        If Rnd < .5 Then position%(1) = 99 Else position%(1) = 12
                    End If
                End If
            End If
        End If





    End If
End Sub

Sub AIattack (pc%, po%)

    If rage(pc%) >= 100 Then
        'Super
        AIsuper pc%, po%
    Else
        'Special
        If ko(pc%) > 25 And dif% > Rnd * 30 And pticker%(pc%) > 20 Then AImoved% = 1: AIspecial pc%, po%
    End If

    'Normal Attack
    If AImoved% = 0 And butty(po%) > butty(pc%) - 15 Then
        If dist% < 18 Then
            'Attack with Normal Move
            AImoved% = 1
            If position%(pc%) = 12 And Rnd < .5 Then
                If Rnd < .5 And dist% < 10 Then position%(pc%) = 13 Else If head%(pc%) <> 666 Then position%(pc%) = 6
            Else
                If pticker%(pc%) > 15 Then
                    Select Case Int(Rnd * 5)
                        Case 0: position%(pc%) = 12
                        Case 1: position%(pc%) = 2
                        Case 2: position%(pc%) = 3
                        Case 3: If stage% <> 15 Then position%(pc%) = 5
                        Case 4: If stage% <> 15 Then position%(pc%) = 6
                    End Select
                End If
            End If
        End If
    End If

End Sub

Sub AIdefend (pc%, po%)

    'Jump or Block if close
    If dist% < 25 Then
        If attackok%(pc%) = 1 And Rnd < .5 And pticker%(pc%) > 10 Then
            position%(pc%) = 99: AImoved% = 1
        Else
            If Abs(buttx(pc%)) < ring% - 50 Then jump (pc%), (Int(Rnd * 3) + 1): AImoved% = 1
        End If
    End If



End Sub

Sub AIfighter (pc%)

    'Determine which moves to use for short/long range etc.

    'Hand Attacks
    Select Case hands%(pc%)
        Case 1
            AIhs%(pc%) = 35
            AIhm%(pc%) = 35
            AIhl%(pc%) = 30
            AIhh%(pc%) = 12
        Case 2
            If Rnd < .5 Then AIhs%(pc%) = 31 Else AIhs%(pc%) = 36
            AIhm%(pc%) = 1
            AIhl%(pc%) = 1
            AIhh%(pc%) = 12
        Case 3
            If Rnd < .5 Then AIhs%(pc%) = 32 Else AIhs%(pc%) = 37
            AIhm%(pc%) = 1
            AIhl%(pc%) = 1
            AIhh%(pc%) = 37
        Case 4
            AIhs%(pc%) = 38
            AIhm%(pc%) = 33
            AIhl%(pc%) = 33
            AIhh%(pc%) = 38
        Case 5
            AIhs%(pc%) = 39
            AIhm%(pc%) = 34
            AIhl%(pc%) = 34
            AIhh%(pc%) = 12
    End Select

    'Foot Attacks
    Select Case feet%(pc%)
        Case 1
            AIfs%(pc%) = 45
            AIfm%(pc%) = 40
            AIfl%(pc%) = 1
            AIfh%(pc%) = 40
        Case 2
            If Rnd < .5 Then AIfs%(pc%) = 41 Else AIfs%(pc%) = 46
            AIfm%(pc%) = 41
            AIfl%(pc%) = 1
            AIfh%(pc%) = 12
        Case 3
            If Rnd < .5 Then AIfs%(pc%) = 42 Else AIfs%(pc%) = 47
            AIfm%(pc%) = 42
            AIfl%(pc%) = 1
            AIfh%(pc%) = 47
        Case 4
            AIfs%(pc%) = 48
            AIfm%(pc%) = 43
            AIfl%(pc%) = 48
            AIfh%(pc%) = 43
        Case 5
            If Rnd < .5 Then AIfs%(pc%) = 44 Else AIfs%(pc%) = 49
            AIfm%(pc%) = 44
            AIfl%(pc%) = 1
            AIfh%(pc%) = 49
    End Select


    If stage% = 15 Then
        AIhs%(pc%) = 35
        AIhm%(pc%) = 35
        AIhl%(pc%) = 30
        AIhh%(pc%) = 13

        AIfs%(pc%) = 3
        AIfm%(pc%) = 30
        AIfl%(pc%) = 30
        AIfh%(pc%) = 2
    End If


End Sub

Sub AIgetclose (pc%, po%)

    If Rnd > .1 Then

        'Walk
        If canjump%(pc%) = 1 Then
            AImoved% = 1
            If buttx(po%) < buttx(pc%) Then butth(pc%) = butth(pc%) - .5 Else butth(pc%) = butth(pc%) + .5
        End If

    Else

        'Jump
        If dist% > 50 And canjump%(pc%) = 1 Then
            AImoved% = 1
            If buttx(po%) < buttx(pc%) Then jump (pc%), (1) Else jump (pc%), (3)
        End If

    End If
End Sub

Sub AIspecial (pc%, po%)

    If Rnd < .5 Then
        If butty(po%) > butty(pc%) - 15 Then
            Select Case dist%
                Case Is < 20: position%(pc%) = AIhs%(pc%)
                Case Is >= 20 <= 75: position%(pc%) = AIhm%(pc%)
                Case Is > 75: position%(pc%) = AIhl%(pc%)
            End Select
        Else
            If dist% < 20 Then position%(pc%) = AIhh%(pc%)
        End If
    Else
        If butty(po%) > butty(pc%) - 15 Then
            Select Case dist%
                Case Is < 25: position%(pc%) = AIfs%(pc%)
                Case Is >= 25 <= 75: position%(pc%) = AIfm%(pc%)
                Case Is > 75: position%(pc%) = AIfl%(pc%)
            End Select
        Else
            If butty(po%) < heady(pc% + 2) And dist% < 20 Then position%(pc%) = AIfh%(pc%)
        End If
    End If


End Sub

Sub AIsuper (pc%, po%)
    Select Case body%(pc%)

        Case 1
            If canjump%(pc%) = 1 Then
                If dist% > 75 Then position%(pc%) = 81: AImoved% = 1
                If position%(po%) >= 8 And position%(po%) <= 11 Then position%(pc%) = 81: AImoved% = 1
            End If

        Case 2
            If dist% > 75 And position%(po%) < 8 Then position%(pc%) = 82: AImoved% = 1

        Case 3
            If dist% < 50 And position%(po%) < 8 Then position%(pc%) = 83: AImoved% = 1

        Case 4
            If health%(pc%) < 100 Then position%(pc%) = 84: AImoved% = 1

        Case 5
            If dist% < 100 Then position%(pc%) = 85: AImoved% = 1

        Case 6
            If dist% < 125 And canjump%(pc%) = 1 Then position%(pc%) = 86: AImoved% = 1

        Case 7
            If dist% < 25 And canjump%(pc%) = 1 Then position%(pc%) = 87: AImoved% = 1

        Case 8
            If dist% < 20 And canjump%(pc%) = 1 Then position%(pc%) = 88: AImoved% = 1

        Case 666
            If dist% < 20 And canjump%(pc%) = 1 Then position%(pc%) = 36: AImoved% = 1

    End Select
End Sub

Sub bigwindow
    Screen , , 0, 0: Color 12, 0

    Locate 1, 29: Print " SFB2: Vector Warriors "

    For wee = 0 To 248 Step 2
        Line (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), Int((Rnd * 2) + 7)
    Next wee

    Line (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), 0, BF
    Line (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), 7, B
    Color 4
    If rez% = 7 Then Locate 22, 35 Else Locate 22, 75
    Print ver$
    wee$ = ""
End Sub

Sub blur (l%)
    If blurr% = 0 Then
        blurr% = l%
        csave% = cfreq%
    End If
End Sub

Sub camdefaults

    panx = 0
    panh = 0
    pany = 0
    panv = 0
    zoom = .1
    zoomd = 0
    midx% = 250
    midy% = 250

    winx = 250
    winy = 250

    winxwiny

End Sub

Sub camtracking

    Select Case camode%

        Case 0
            Exit Sub

        Case 1
            trackx% = (neckx(3) + neckx(4)) / 2
            tracky% = ((necky(3) + necky(4)) / 2) - 10

        Case 2
            trackx% = (buttx(1) + neckx(3)) / 2
            tracky% = ((butty(1) + necky(3)) / 2)

        Case 3
            trackx% = (buttx(2) + neckx(4)) / 2
            tracky% = ((butty(2) + necky(4)) / 2)

    End Select

    '----------------------------------------------------------------------------

    If panx > trackx% + 30 Then panh = panh - .5
    If panx < trackx% - 30 Then panh = panh + .5
    If pany > tracky% + 20 Then panv = panv - 1
    If pany < tracky% - 20 Then panv = panv + 1
    If Abs(panh) > 10 Then panh = panh / 1.1
    If Abs(panv) > 10 Then panv = panv / 1.1
    If panx > trackx% - 25 And panx < trackx% + 25 Then panh = panh / 1.1
    If pany > tracky% - 25 And pany < tracky% + 25 Then panv = panv / 1.5


    'Zoom Control
    If camode% = 1 Then
        If buttx(1) < buttx(2) Then x = (buttx(2) - buttx(1)) / 1000 Else x = (buttx(1) - buttx(2)) / 1000
        If butty(1) < butty(2) Then y = (butty(2) - butty(1)) / 1000 Else y = (butty(1) - butty(2)) / 1000
        F = (x + y) / 2
        If zoom < zoomt + F - .001 Then zoom = zoom + .001
        If zoom > zoomt + F + .001 Then zoom = zoom - .001
        If zoom < zoomt + F - .1 Then zoomd = zoomd + .001
        If zoom > zoomt + F + .1 Then zoomd = zoomd - .001
        If zoomd < -.005 Then zoomd = -.005
    End If

    '------------------
    If zoom < .0000001 Then zoom = .0000001
End Sub

Sub cbigwindow

    Screen , 0, 0
    For wee = 0 To 248 Step 15
        Line (midx% - 248 + wee, midy% - 200)-(midy% + 248 - wee, midy% + 200), Int((Rnd * 2) + 7)
        Line (midx% - 248, midy% - 200)-(midy% + 248, midy% + 200), 15, B
    Next wee

    wee$ = ""
End Sub

Sub clearscreen
    'Blur
    If blurr% > 0 Then
        blurr% = blurr% - 1
        If blurr% = 0 Then cfreq% = csave% Else cfreq% = 1
    End If

    If ctime% > cfreq% Then
        ctime% = 0
        Select Case cmethod%

            Case Is = 1
                Line (xx1, yy1)-(xx2, yy2), 0, BF

            Case Is = 2
                Cls

            Case Is = 3
                window2d
                hfade% = hfade% + 5: If hfade% = 15 Then hfade% = 0
                For wee = hfade% To 95 Step 15
                    Line (0, wee)-(100, wee + 5), 0, BF
                Next wee
                window3d

            Case Is = 4
                If clsb% = 5 Then clsb% = 0
                clsblock (clsb%)
                clsb% = clsb% + 1
        End Select
    Else ctime% = ctime% + 1
    End If

End Sub

Sub clsblock (n)
    window2d
    Select Case n

        Case Is = 1
            For y = 0 To 90 Step 10
                For x = 0 To 90 Step 10
                    Line (x, y)-(x + 5, y + 5), 0, BF
                Next x
            Next y

        Case Is = 2
            For y = 5 To 95 Step 10
                For x = 5 To 95 Step 10
                    Line (x, y)-(x + 5, y + 5), 0, BF
                Next x
            Next y

        Case Is = 3
            For y = 0 To 90 Step 10
                For x = 5 To 95 Step 10
                    Line (x, y)-(x + 5, y + 5), 0, BF
                Next x
            Next y

        Case Is = 4
            For y = 5 To 95 Step 10
                For x = 0 To 90 Step 10
                    Line (x, y)-(x + 5, y + 5), 0, BF
                Next x
            Next y

    End Select
    window3d
End Sub

Sub Conclusion

    '------------------------------------------------------------ Determine Flash
    If victory% = 0 Then
        victory% = 1

        If health%(1) <= 0 Or health%(2) <= 0 Then
            soundticker% = 0: sbfx 14
            Color , 12
            flicker = Timer: Do Until Timer - flicker > .1: Loop
            Color , 0
        End If
 
        If ko(1) <= 0 Or ko(2) <= 0 Then
            soundticker% = 0: sbfx 15
            Color , 9
            flicker = Timer: Do Until Timer - flicker > .1: Loop
            Color , 0
        End If

        If frameskip% < 3 Then tpause% = 2
    End If


    '------------------------------- Determine When to Figure Round / Match Info.
    If position%(1) = 8 And pticker%(1) >= 75 Then victory% = 2
    If position%(2) = 8 And pticker%(2) >= 75 Then victory% = 2
    If position%(1) = 10 And pticker%(1) >= 75 Then victory% = 2
    If position%(2) = 10 And pticker%(2) >= 75 Then victory% = 2

    If victory% = 2 Then
        victory% = 0

        '------------------------------------------------------ Determine Round Info.
        Screen , , 0, 0
        Locate 5
        Color 9
        If ko(1) <= 0 And health%(1) > 0 Then Print name$(1) + " - KO": win%(2) = win%(2) + 1
        If ko(2) <= 0 And health%(2) > 0 Then Print name$(2) + " - KO": win%(1) = win%(1) + 1
        If ko(1) <= 0 And ko(2) <= 0 Then Print "Double KO"
        Color 12
        If health%(1) <= 0 Then Print name$(1) + " - Dead": win%(2) = 2
        If health%(2) <= 0 Then Print name$(2) + " - Dead": win%(1) = 2

        '------------------------------------------------------ Determine Match Info.
        Color 15

        If win%(1) > 1 And win%(2) > 1 Then
            Print "Tie Match": win%(1) = 1: win%(2) = 1
            If health%(1) <= 0 And health%(2) <= 0 Then
                If ringoutp% <> 1 And ringoutp% <> 3 Then
                    Print "Resurrecting Players To Continue"
                    decap 3
                    health%(1) = 100
                    health%(2) = 100
                    particle (headx(3)), (heady(3)), (fighterz(1)), 5, 10
                    particle (headx(4)), (heady(4)), (fighterz(2)), 5, 10
                Else
                    Print name$(2) + " Takes Win"
                    newmatch
                End If
            End If

        Else

            If win%(1) > 1 Or win%(2) > 1 Then
                If win%(1) > 1 And win%(2) < 2 Then Print name$(1) + " Wins the Match": stage% = stage% + 1: setfightercpu
                If win%(2) > 1 And win%(1) < 2 Then Print name$(2) + " Wins the Match": If stage% > stages% Then setfightercpu
                newmatch
            End If
        End If

        '----------------------------------------------------------------------------

        wee = Timer
        34 If Timer - wee < 3 Then 34

        setko (1): setko (2)

    End If
End Sub

Sub csmallwindow


    Screen , 0, 0
    For wee = 0 To 248 Step 3
        Line (midx% - 248 + wee, midy% - 75)-(midy% + 248 - wee, midy% + 75), Int((Rnd * 2) + 7)
        Line (midx% - 248, midy% - 75)-(midy% + 248, midy% + 75), 15, B
    Next wee

    wee$ = ""
End Sub

Sub decap (n%)

    If n% = 3 Then
        headless%(1) = 0: headless%(2) = 0
    Else
        If headless%(n%) = 0 Then
            bgcolor% = 15
            camode% = n% + 1
            zoomd = zoomd + .001
            headless%(n%) = 1
            hx(n%) = headx(n% + 2)
            hy(n%) = heady(n% + 2)
            hh(n%) = (Rnd - .5) * 2
            hv(n%) = -12
        End If
    End If
End Sub

Sub decay
    For wee = 1 To particles%

        If p%(wee) > 0 Then
            p%(wee) = p%(wee) - 1
            If p%(wee) = 15 Then pc1%(wee) = pc2%(wee)
            If p%(wee) = 5 Then pc1%(wee) = pc3%(wee)

            If pk%(wee) = 1 And py(wee) > floor1 - pv(wee) And Abs(px(wee)) < ring% - 8 Then
                If py(wee) < floor1 + 15 And Rnd < .4 Then smear (px(wee) + ((Rnd - .5) * 8)), (floor1), (pz(wee) + (Rnd - .5)), (pc1%(wee))
                p%(wee) = 0
            End If

            If pk%(wee) = 2 And py(wee) > floor2 - pv(wee) Then p%(wee) = 0
        End If
    Next wee

    For wee = 1 To 10
        If smearl%(wee) > 0 Then
            smearl%(wee) = smearl%(wee) + 1
            If smearl%(wee) = 60 And smearc%(wee) = 12 Then smearc%(wee) = 4
        End If
    Next wee

    'Razer Arms
    For wee = 1 To 2
        If razers%(wee) > 0 Then
            razers%(wee) = razers%(wee) - 1
            If razers%(wee) = 1 Then
                pc2 = wee + 2
                particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(wee) + .2), 15, 5
                particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(wee) - .2), 15, 5
            End If
        End If
    Next wee

End Sub

DefInt A-Z
Function DetectCard%

    'Returns -1 (true) if detected and 0 (false) if not.
                                                        
    Call SBWrite(&H4, &H60)
    Call SBWrite(&H4, &H80)
    B = Inp(&H388)
    Call SBWrite(&H2, &HFF)
    Call SBWrite(&H4, &H21)
    For x = 0 To 130
        a = Inp(&H388)
    Next x
    c = Inp(&H388)
    Call SBWrite(&H4, &H60)
    Call SBWrite(&H4, &H80)
    SUCCESS = 0
    If (B And &HE0) = &H0 Then
        If (c And &HE0) = &HC0 Then
            SUCCESS = -1
        End If
    End If
    DetectCard% = SUCCESS
End Function

DefSng A-Z
Sub errorkey
    wee = 2
    wee$ = ""

    Locate 21, 1
    Print "E-mail lbt1st@cyberdude.com if problem persist. SFB2 Version " + ver$
    Print "[                  ] - System may be halted if inanimate"
    24
    wee$ = UCase$(InKey$)

    wee = wee + .005
    If Int(wee) = 20 Then wee = 2: Locate 22, 19: Print " "
    Locate 22, Int(wee): Print "*"
    If Int(wee) > 2 Then Locate 22, Int(wee) - 1: Print " "

    If wee$ = "" Then 24
    If wee$ = Chr$(27) Then System

    If UCase$(wee$) = "D" Then
        Shell "del slash.dat"
        Shell "echo Slash Attempted to Delete SLASH.DAT"
        Shell "echo You May Now Try to Restart the Program."
        System
    End If


End Sub

Sub fades
    If bgcolor% <> 0 Then

        Select Case bgcolor%
            Case 19
                Color , 15
                bgcolor% = 9

            Case 15
                Color , 15
                bgcolor% = 12

            Case 12
                Color , 12
                bgcolor% = 4

            Case 9
                Color , 9
                bgcolor% = 1

            Case 4
                Color , 4
                bgcolor% = -1

            Case 1
                Color , 1
                bgcolor% = -1

            Case -1
                Color , 0
                bgcolor% = 0

        End Select
    End If
End Sub

Sub fall (n)

    If d%(n) = 1 And butth(n) < 0 Then position%(n) = 10
    If d%(n) = -1 And butth(n) < 0 Then position%(n) = 8
    If d%(n) = 1 And butth(n) > 0 Then position%(n) = 8
    If d%(n) = -1 And butth(n) > 0 Then position%(n) = 10
    If position%(n) < 8 Or position%(n) > 11 Then position%(n) = 10

End Sub

Sub fightercompress (n%)
    headx(n%) = 0
    neckx(n%) = 0

    elbow1x(n%) = 0
    elbow2x(n%) = 0
    hand1x(n%) = 0
    hand2x(n%) = 0

    nee1x(n%) = 0
    nee2x(n%) = 0
    foot1x(n%) = 0
    foot2x(n%) = 0

    heady(n%) = 0
    necky(n%) = 0

    elbow1y(n%) = 0
    elbow2y(n%) = 0
    hand1y(n%) = 0
    hand2y(n%) = 0

    nee1y(n%) = 0
    nee2y(n%) = 0
    foot1y(n%) = 0
    foot2y(n%) = 0

End Sub

Sub fighterdirect

    '------------------------------------------------------------- Flip Direction
    For wee = 1 To 2

        If wee = 1 And position%(1) = 1 And pticker%(1) > 20 And canjump%(1) = 1 Then
            If buttx(1) > buttx(2) Then d%(wee) = -1 Else d%(wee) = 1
        End If

        If wee = 2 And position%(2) = 1 And pticker%(2) > 20 And canjump%(2) = 1 Then
            If buttx(1) < buttx(2) Then d%(wee) = -1 Else d%(wee) = 1
        End If

    Next wee
End Sub

Sub fighterender

    For wee = 1 To 2
        wee2 = wee + 2
        fm1 = fighterz(wee) - .1
        fp1 = fighterz(wee) + .1

        If position%(wee) = 0 Then 36

        '----------------------------------------------- High Detail Fighter Graphics
        If fighterdetail% = 1 Then

            midbodx = buttx(wee) + ((neckx(wee2) - buttx(wee)) / 2)
            midbody = necky(wee2) + ((butty(wee) - necky(wee2)) / 2)


            '---------------------------------------------------------------- Render Hair
            'P1
            If position%(1) > 0 And hairl%(1) > 0 And wee = 1 Then
                For n% = 1 To 4
                    Select Case hairt%(1)
                        Case 1: psline (hairx(n%)), (hairy(n%)), (fighterz(1)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(1)), (hairc%(1)), 0
                        Case 2: pscline (hairx(n%)), (hairy(n%)), (fighterz(1)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(1)), .2, (hairc%(1))
                    End Select
                Next n%
            End If

            'P2
            If position%(2) > 0 And hairl%(2) > 0 And wee = 2 Then
                For n% = 6 To 9
                    Select Case hairt%(2)
                        Case 1: psline (hairx(n%)), (hairy(n%)), (fighterz(2)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(2)), (hairc%(2)), 0
                        Case 2: pscline (hairx(n%)), (hairy(n%)), (fighterz(2)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(2)), .2, (hairc%(2))
                    End Select
                Next n%
            End If



            '---------------------------------------------------------------- Razer Arm-1
            If razers%(wee) > 0 Then
                If razers%(wee) > 50 Then c% = flash3% Else c% = 4
                psline (elbow1x(wee2) + (hand1x(wee) / 2) * d%(wee)), (elbow1y(wee2) + (hand1y(wee) / 2)), (fp1 + .1), (elbow1x(wee2) + (hand1x(wee) * 2) * d%(wee)), (elbow1y(wee2) + (hand1y(wee) * 2)), (fp1 + .1), c%, 0
            End If


            '---------------------------------------------------------------------- Heads
            If headless%(wee) = 1 Then headx(wee2) = hx(wee): heady(wee2) = hy(wee)

            Select Case head%(wee)
                Case 1
                    pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

                Case 2
                    psline (headx(wee2) + 1 * d%(wee)), (heady(wee2) - 1), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) + 1 * d%(wee)), (heady(wee2) - 1), (fighterz(wee)), (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), (headx(wee2) - 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0


                Case 3
                    psline (headx(wee2) - 1 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), (headx(wee2) - 1 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), headc%(wee), 0

                Case 4
                    pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)
                    psline (headx(wee2) - 3 * d%(wee)), (heady(wee2)), (fighterz(wee)), (headx(wee2)), (heady(wee2)), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2)), (heady(wee2)), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0

                Case 5
                    psline (headx(wee2)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 3 * d%(wee)), (heady(wee2)), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
                    psline (headx(wee2) - 3 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0

                Case 666
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 1), (fighterz(wee) + .05), (headx(wee2) - 3 * d%(wee)), (heady(wee2) - 3), (fighterz(wee) + .3), 7, 0

                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fp1), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fm1), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
                    psline (headx(wee2) - 3 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
                    pscircle (headx(wee2) - 2.5 * d%(wee)), (heady(wee2) + .1), (fighterz(wee)), 1.5, 12

                    psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 1), (fighterz(wee) - .05), (headx(wee2) - 3 * d%(wee)), (heady(wee2) - 3), (fighterz(wee) - .3), 15, 0


                Case 1998
                    pslightning (headx(wee2) + (Rnd - .5) * 3), (heady(wee2) + (Rnd - .5) * 3), (fighterz(wee)), (headx(wee2) + (Rnd - .5) * 3), (heady(wee2) + (Rnd - .5) * 3), (fighterz(wee)), 5, flash2%



                Case 2000
                    pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), Rnd, headc%(wee)
                    pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

            End Select


            '---------------------------------------------------------------------- Arm-1
            Select Case arms%(wee)
                Case 1
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0

                Case 2
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0

                Case 3
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    psline (midbodx), (necky(wee2) + 1), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + .5), (fp1), armsc%(wee), 0

                Case 4
                    psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2) - .3 * d%(wee)), (elbow1y(wee2) - .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2) + .3 * d%(wee)), (elbow1y(wee2) + .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    pscircle (neckx(wee2) + elbow1x(wee) / 2 * d%(wee)), (necky(wee2) + elbow1y(wee) / 2), (fp1), .8, armsc%(wee)
                    pscircle (elbow1x(wee2) + hand1x(wee) / 2 * d%(wee)), (elbow1y(wee2) + hand1y(wee) / 2), (fp1), .5, armsc%(wee)

                Case 5
                    psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow1x(wee2) + .5 * d%(wee)), (elbow1y(wee2) + .5), (fp1), armsc%(wee), 0
                    psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow1x(wee2) - .5 * d%(wee)), (elbow1y(wee2) - .5), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2) - .3 * d%(wee)), (elbow1y(wee2) - .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2) + .3 * d%(wee)), (elbow1y(wee2) + .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
                    psline (elbow1x(wee2) - .7), (elbow1y(wee2) - .7), (fp1), (elbow1x(wee2) + .7), (elbow1y(wee2) + .7), (fp1), armsc%(wee), 1

                Case 666
                    psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) + 2), (fp1), (elbow1x(wee2)), (elbow1y(wee2)), (fighterz(wee) + .2), 4, 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fighterz(wee) + .2), 4, 0
                    psline (elbow1x(wee2) - .8 * d%(wee)), (elbow1y(wee2) - .8), (fighterz(wee) + .2), (hand1x(wee2)), (hand1y(wee2)), (fighterz(wee) + .2), 4, 0
                    psline (elbow1x(wee2)), (elbow1y(wee2) + .8), (fighterz(wee) + .2), (hand1x(wee2)), (hand1y(wee2)), (fighterz(wee) + .2), 4, 0

                Case 1998
                    pslightning (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), 1, flash2%
                    pslightning (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), 1, flash2%

                Case 2000
                    pscline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), .8, armsc%(wee)
                    pscline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), .5, armsc%(wee)

            End Select



            '--------------------------------------------------------------------- Hand-1
            Select Case hands%(wee)
                Case 1
                    psline (hand1x(wee2) - .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) + .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0
                    psline (hand1x(wee2) + .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) - .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0

                Case 2
                    psline (hand1x(wee2) - .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) + .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 1

                Case 3
                    If position%(wee) = 13 Or position%(wee) = 37 Or position%(wee) = 88 Then
                        psline (hand1x(wee2) - .5), (hand1y(wee2) - 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + 2), (fp1), handsc%(wee), 0
                        psline (hand1x(wee2) + .5), (hand1y(wee2) - 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + 2), (fp1), handsc%(wee), 0
                    Else
                        psline (hand1x(wee2) + 2 * d%(wee)), (hand1y(wee2)), (fp1), (hand1x(wee2) - .5 * d%(wee)), (hand1y(wee2) - .6), (fp1), handsc%(wee), 0
                        psline (hand1x(wee2) + 2 * d%(wee)), (hand1y(wee2)), (fp1), (hand1x(wee2) - .5 * d%(wee)), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0
                    End If

                Case 4, 2000
                    pscircle (hand1x(wee2)), (hand1y(wee2)), (fp1), .5, handsc%(wee)

                Case 5
                    psline (hand1x(wee2)), (hand1y(wee2) - .8), (fp1), (hand1x(wee2) - .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
                    psline (hand1x(wee2)), (hand1y(wee2) + .8), (fp1), (hand1x(wee2) - .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
                    psline (hand1x(wee2)), (hand1y(wee2) - .8), (fp1), (hand1x(wee2) + .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
                    psline (hand1x(wee2)), (hand1y(wee2) + .8), (fp1), (hand1x(wee2) + .8), (hand1y(wee2)), (fp1), handsc%(wee), 0

                Case 666
                    psline (hand1x(wee2) - 1), (hand1y(wee2) - 1), (fp1), (hand1x(wee2) + 1), (hand1y(wee2) + 1), (fp1), 6, 1



            End Select


            '---------------------------------------------------------------------- Bodys
            Select Case body%(wee)
                Case 1
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee)), (butty(wee) + 1), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), bodyc%(wee), 0

                Case 2
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

                Case 3
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2) + 2 * d%(wee)), (necky(wee2)), (fighterz(wee)), (midbodx - 1 * d%(wee)), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2) - 1 * d%(wee)), (necky(wee2)), (fighterz(wee)), (midbodx + 1 * d%(wee)), (midbody), (fighterz(wee)), bodyc%(wee), 0

                Case 4
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx - 1), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx + 1), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    pscircle (neckx(wee2) - (Abs(neckx(wee) / 10) * d%(wee))), (midbody - Abs(necky(wee) / 4)), (fighterz(wee)), 1.3, bodyc%(wee)

                Case 5
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), buttx(wee), (necky(wee2) - 2), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

                Case 6
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) - 1), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2) - 2.5 * d%(wee)), (necky(wee2) + Abs(necky(wee) / 4)), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + Abs(necky(wee) / 4) + 1), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2) - 2 * d%(wee)), (necky(wee2) + Abs(necky(wee) / 2)), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + Abs(necky(wee) / 2) + 1), (fighterz(wee)), bodyc%(wee), 0

                Case 7
                    psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), buttx(wee), (necky(wee2) - 2), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

                Case 8
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0

                Case 666
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), 12, 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), 12, 0
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx - 2 * d%(wee)), (necky(wee2) - 2), (fighterz(wee)), 12, 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx - 2 * d%(wee)), (necky(wee2) - 2), (fighterz(wee)), 12, 0
                    pscube (buttx(wee) - 1 * d%(wee)), (butty(wee) - 3), (fm1), (buttx(wee) + 2 * d%(wee)), (butty(wee)), (fp1), 12, 6, 4

                Case 1998
                    pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), 3, flash1%

                Case 2000
                    pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), 1, bodyc%(wee)

            End Select

            '---------------------------------------------------------------------- Arm-2
            c% = armsc%(wee) + 8

            Select Case arms%(wee)
                Case 1
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0

                Case 2
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    psline (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2) + 1), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0

                Case 3
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    psline (midbodx), (necky(wee2) - 1), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2) + 1), (fm1), c%, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2) - 1), (fm1), (hand2x(wee2)), (hand2y(wee2) + .5), (fm1), c%, 0

                Case 4
                    psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2) - .3 * d%(wee)), (elbow2y(wee2) - .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2) + .3 * d%(wee)), (elbow2y(wee2) + .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    pscircle (neckx(wee2) + elbow2x(wee) / 2 * d%(wee)), (necky(wee2) + elbow2y(wee) / 2), (fm1), .8, c%
                    pscircle (elbow2x(wee2) + hand2x(wee) / 2 * d%(wee)), (elbow2y(wee2) + hand2y(wee) / 2), (fm1), .5, c%

                Case 5
                    psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow2x(wee2) + .5 * d%(wee)), (elbow2y(wee2) + .5), (fm1), c%, 0
                    psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow2x(wee2) - .5 * d%(wee)), (elbow2y(wee2) - .5), (fm1), c%, 0
                    psline (elbow2x(wee2) - .3 * d%(wee)), (elbow2y(wee2) - .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2) + .3 * d%(wee)), (elbow2y(wee2) + .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
                    psline (elbow2x(wee2) - .7), (elbow2y(wee2) - .7), (fm1), (elbow2x(wee2) + .7), (elbow2y(wee2) + .7), (fm1), c%, 1

                Case 666
                    psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) + 2), (fm1), (elbow2x(wee2)), (elbow2y(wee2)), (fighterz(wee) - .2), 12, 0
                    psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fighterz(wee) - .2), 12, 0
                    psline (elbow2x(wee2) - .8 * d%(wee)), (elbow2y(wee2) - .8), (fighterz(wee) - .2), (hand2x(wee2)), (hand2y(wee2)), (fighterz(wee) - .2), 12, 0
                    psline (elbow2x(wee2)), (elbow2y(wee2) + .8), (fighterz(wee) - .2), (hand2x(wee2)), (hand2y(wee2)), (fighterz(wee) - .2), 12, 0

                Case 1998
                    pslightning (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), 1, flash2%
                    pslightning (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), 1, flash2%

                Case 2000
                    pscline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), .8, c%
                    pscline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), .5, c%

            End Select

            '--------------------------------------------------------------------- Hand-2
            c% = handsc%(wee) + 8

            Select Case hands%(wee)
                Case 1
                    psline (hand2x(wee2) - .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) + .6), (hand2y(wee2) + .6), (fm1), c%, 0
                    psline (hand2x(wee2) + .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) - .6), (hand2y(wee2) + .6), (fm1), c%, 0

                Case 2
                    psline (hand2x(wee2) - .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) + .6), (hand2y(wee2) + .6), (fm1), c%, 1

                Case 3
                    If position%(wee) = 13 Or position%(wee) = 37 Or position%(wee) = 88 Then
                        psline (hand2x(wee2)), (hand2y(wee2) - 2), (fm1), (hand2x(wee2) - .5), (hand2y(wee2) + 1), (fm1), c%, 0
                        psline (hand2x(wee2)), (hand2y(wee2) - 2), (fm1), (hand2x(wee2) + .5), (hand2y(wee2) + 1), (fm1), c%, 0
                    Else
                        psline (hand2x(wee2) + 2 * d%(wee)), (hand2y(wee2)), (fm1), (hand2x(wee2) - .5 * d%(wee)), (hand2y(wee2) - .6), (fm1), c%, 0
                        psline (hand2x(wee2) + 2 * d%(wee)), (hand2y(wee2)), (fm1), (hand2x(wee2) - .5 * d%(wee)), (hand2y(wee2) + .6), (fm1), c%, 0
                    End If

                Case 4, 2000
                    pscircle (hand2x(wee2)), (hand2y(wee2)), (fm1), .5, c%

                Case 5
                    psline (hand2x(wee2)), (hand2y(wee2) - .8), (fm1), (hand2x(wee2) - .8), (hand2y(wee2)), (fm1), c%, 0
                    psline (hand2x(wee2)), (hand2y(wee2) + .8), (fm1), (hand2x(wee2) - .8), (hand2y(wee2)), (fm1), c%, 0
                    psline (hand2x(wee2)), (hand2y(wee2) - .8), (fm1), (hand2x(wee2) + .8), (hand2y(wee2)), (fm1), c%, 0
                    psline (hand2x(wee2)), (hand2y(wee2) + .8), (fm1), (hand2x(wee2) + .8), (hand2y(wee2)), (fm1), c%, 0

                Case 666
                    psline (hand2x(wee2) - 1), (hand2y(wee2) - 1), (fm1), (hand2x(wee2) + 1), (hand2y(wee2) + 1), (fm1), 6, 1

            End Select


            '---------------------------------------------------------------- Razer Arm-2
            If razers%(wee) > 0 Then
                If razers%(wee) > 50 Then c% = flash3% Else c% = 4
                psline (elbow2x(wee2) + (hand2x(wee) / 2) * d%(wee)), (elbow2y(wee2) + (hand2y(wee) / 2)), (fm1 - .1), (elbow2x(wee2) + (hand2x(wee) * 2) * d%(wee)), (elbow2y(wee2) + (hand2y(wee) * 2)), (fm1 - .1), c%, 0
            End If



            '---------------------------------------------------------------------- Legs
            c% = legsc%(wee) + 8

            Select Case legs%(wee)
                Case 1
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0


                Case 2
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0


                Case 3
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    psline (buttx(wee)), (butty(wee) - 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    psline (buttx(wee)), (butty(wee) - 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0

                Case 4
                    psline (buttx(wee) - 1 * d%(wee)), (butty(wee) + 1), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2) - .5 * d%(wee)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2) + .5 * d%(wee)), (nee1y(wee2) + .5), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    pscircle (buttx(wee) + (nee1x(wee) / 2) * d%(wee)), (butty(wee) + nee1y(wee) / 2), (fighterz(wee) + .05), 1, legsc%(wee)
                    pscircle (nee1x(wee2) + (foot1x(wee) / 2) * d%(wee)), (nee1y(wee + 2) + foot1y(wee) / 2), (fp1), .8, legsc%(wee)

                    psline (buttx(wee) - 1 * d%(wee)), (butty(wee) + 1), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2) - .5 * d%(wee)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2) + .5 * d%(wee)), (nee2y(wee2) + .5), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    pscircle (buttx(wee) + (nee2x(wee) / 2) * d%(wee)), (butty(wee) + nee2y(wee) / 2), (fighterz(wee) - .05), 1, c%
                    pscircle (nee2x(wee2) + (foot2x(wee) / 2) * d%(wee)), (nee2y(wee + 2) + foot2y(wee) / 2), (fm1), .8, c%

                Case 5
                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2) - 2 * d%(wee)), (nee1y(wee2) - (nee1y(wee) / 3)), (fp1), (nee1x(wee2) + 1 * d%(wee)), (nee1y(wee2)), (fp1), legsc%(wee), 0
                    psline (nee1x(wee2) - 2 * d%(wee)), (nee1y(wee2) + (nee1y(wee) / 3)), (fp1), (nee1x(wee2) + 1 * d%(wee)), (nee1y(wee2)), (fp1), legsc%(wee), 0

                    psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2) - 2 * d%(wee)), (nee2y(wee2) - (nee2y(wee) / 3)), (fm1), (nee2x(wee2) + 1 * d%(wee)), (nee2y(wee2)), (fm1), c%, 0
                    psline (nee2x(wee2) - 2 * d%(wee)), (nee2y(wee2) + (nee2y(wee) / 3)), (fm1), (nee2x(wee2) + 1 * d%(wee)), (nee2y(wee2)), (fm1), c%, 0


                Case 666
                    psline (buttx(wee) + 2 * d%(wee)), (butty(wee) - 2), (fp1), (nee1x(wee2)), (nee1y(wee2) + 2), (fighterz(wee) + .2), 4, 0
                    psline (nee1x(wee2)), (nee1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2)), (foot1y(wee2)), (fighterz(wee) + .2), 4, 0
                    psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fp1), (nee1x(wee2)), (nee1y(wee2)), (fighterz(wee) + .2), 4, 0
                    psline (nee1x(wee2)), (nee1y(wee2) + 2), (fighterz(wee) + .2), (foot1x(wee2)), (foot1y(wee2)), (fighterz(wee) + .2), 4, 0

                    psline (buttx(wee) + 2 * d%(wee)), (butty(wee) - 2), (fm1), (nee2x(wee2)), (nee2y(wee2) + 2), (fighterz(wee) - .2), 6, 0
                    psline (nee2x(wee2)), (nee2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2)), (foot2y(wee2)), (fighterz(wee) - .2), 6, 0
                    psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fm1), (nee2x(wee2)), (nee2y(wee2)), (fighterz(wee) - .2), 6, 0
                    psline (nee2x(wee2)), (nee2y(wee2) + 2), (fighterz(wee) - .2), (foot2x(wee2)), (foot2y(wee2)), (fighterz(wee) - .2), 6, 0


                Case 1998
                    pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), 1, flash2%
                    pslightning (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), 1, flash2%

                    pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), 1, flash2%
                    pslightning (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot1y(wee2)), (fm1), 1, flash2%


                Case 2000
                    pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), .8, legsc%(wee)
                    pscline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), .5, legsc%(wee)

                    pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), .8, c%
                    pscline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), .5, c%

            End Select

            '---------------------------------------------------------------------- Feet
            c% = feetc%(wee) + 8
            tip = 2 * d%(wee)

            If position%(wee) = 49 Then

                psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2) + 2), (fm1), c%, 0
                psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) - tip), (foot1y(wee2) - 2), (fp1), feetc%(wee), 0


            Else

                Select Case feet%(wee)
                    Case 1
                        psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0
                        psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0


                    Case 2
                        psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 1
                        psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 1


                    Case 3
                        psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0
                        psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0

                        psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0
                        psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0


                    Case 4, 2000
                        pscircle (foot1x(wee2) + 1 * d%(wee)), (foot1y(wee2)), (fp1), .5, feetc%(wee)
                        pscircle (foot2x(wee2) + 1 * d%(wee)), (foot2y(wee2)), (fm1), .5, c%

                    Case 5
                        pscircle (foot1x(wee2)), (foot1y(wee2) - .5), (fp1), .5, feetc%(wee)
                        psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + 2 * d%(wee)), (foot1y(wee2)), (fp1), feetc%(wee), 0

                        pscircle (foot2x(wee2)), (foot2y(wee2) - .5), (fm1), .5, c%
                        psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + 2 * d%(wee)), (foot2y(wee2)), (fm1), c%, 0


                    Case 666
                        psline (foot1x(wee2) - .4), (foot1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2) + .4), (foot1y(wee2)), (fighterz(wee) + .2), 8, 1
                        psline (foot1x(wee2) + .4 * d%(wee)), (foot1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2) + 1 * d%(wee)), (foot1y(wee2)), (fighterz(wee) + .2), 8, 0

                        psline (foot2x(wee2) - .4), (foot2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2) + .4), (foot2y(wee2)), (fighterz(wee) - .2), 8, 1
                        psline (foot2x(wee2) + .4 * d%(wee)), (foot2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2) + 1 * d%(wee)), (foot2y(wee2)), (fighterz(wee) - .2), 8, 0

                End Select

            End If

            '============================================================================
            '------------------------------------------------ Low Detail Fighter Graphics
        Else

            'head
            pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

            'body
            psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0

            'arms
            psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
            psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), armsc%(wee) + 8, 0

            psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
            psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), armsc%(wee) + 8, 0

            'legs
            psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
            psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

            psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), legsc%(wee) + 8, 0
            psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), legsc%(wee) + 8, 0

            '----------------------------------------------------------------------------
        End If
        36
    Next wee


End Sub

Sub fighterfreeze (n)
    If canjump%(n) = 1 Or ticker% < 1 Then butth(n) = 0: buttv(n) = 0
    headh(n) = 0
    neckh(n) = 0
    elbow1h(n) = 0
    elbow2h(n) = 0
    hand1h(n) = 0
    hand2h(n) = 0
    nee1h(n) = 0
    nee2h(n) = 0
    foot1h(n) = 0
    foot2h(n) = 0

    headv(n) = 0
    neckv(n) = 0
    elbow1v(n) = 0
    elbow2v(n) = 0
    hand1v(n) = 0
    hand2v(n) = 0
    nee1v(n) = 0
    nee2v(n) = 0
    foot1v(n) = 0
    foot2v(n) = 0
End Sub

Sub fightergoo (wee, d)

    headh(wee) = headh(wee) / d
    neckh(wee) = neckh(wee) / d
    elbow1h(wee) = elbow1h(wee) / d
    elbow2h(wee) = elbow2h(wee) / d
    hand1h(wee) = hand1h(wee) / d
    hand2h(wee) = hand2h(wee) / d
    nee1h(wee) = nee1h(wee) / d
    nee2h(wee) = nee2h(wee) / d
    foot1h(wee) = foot1h(wee) / d
    foot2h(wee) = foot2h(wee) / d

    headv(wee) = headv(wee) / d
    neckv(wee) = neckv(wee) / d
    elbow1v(wee) = elbow1v(wee) / d
    elbow2v(wee) = elbow2v(wee) / d
    hand1v(wee) = hand1v(wee) / d
    hand2v(wee) = hand2v(wee) / d
    nee1v(wee) = nee1v(wee) / d
    nee2v(wee) = nee2v(wee) / d
    foot1v(wee) = foot1v(wee) / d
    foot2v(wee) = foot2v(wee) / d
End Sub

Sub fighterinit


    If stage% = 12 Then
        For wee = 1 To 2
            particle (buttx(wee) + ((Rnd - .5) * 15)), (butty(wee) + ((Rnd - .5) * 15)), fighterz(wee), 15, 20
        Next wee
    End If

    buttx(1) = -ring% / 3
    buttx(2) = ring% / 3
    d%(1) = 1
    d%(2) = -1
    For wee = 1 To 2
        If AIactive%(wee) = 1 Then AIfighter (wee)
        vexed%(wee) = 0
        razers%(wee) = 0
        Special%(wee) = 0
        decap 3
        pticker%(wee) = 0
        butty(wee) = floor1 - 20
        fightercompress (wee)
        fighterz(wee) = midstage
        fighterfreeze (wee)
        koslide%(wee) = ko(wee)
        hpslide%(wee) = health%(wee)

        Select Case arms%(wee)
            Case 1
                ahpow%(wee) = 0
                akpow%(wee) = 5
            Case 2
                ahpow%(wee) = 2
                akpow%(wee) = 3
            Case 3
                ahpow%(wee) = 3
                akpow%(wee) = 2
            Case 4
                ahpow%(wee) = 1
                akpow%(wee) = 4
            Case 5
                ahpow%(wee) = 4
                akpow%(wee) = 1
            Case 1998
                ahpow%(wee) = 4
                akpow%(wee) = 2
            Case 666
                ahpow%(wee) = 5
                akpow%(wee) = 7
            Case 2000
                ahpow%(wee) = 4
                akpow%(wee) = 5
        End Select

        Select Case legs%(wee)
            Case 1
                lhpow%(wee) = 0
                lkpow%(wee) = 5
            Case 2
                lhpow%(wee) = 2
                lkpow%(wee) = 3
            Case 3
                lhpow%(wee) = 3
                lkpow%(wee) = 2
            Case 4
                lhpow%(wee) = 3
                lkpow%(wee) = 1
            Case 5
                lhpow%(wee) = 2
                lkpow%(wee) = 2
            Case 1998
                lhpow%(wee) = 7
                lkpow%(wee) = 3
            Case 2000
                lhpow%(wee) = 7
                lkpow%(wee) = 7
        End Select

        Select Case head%(wee)
            Case 1: kocharge(wee) = .2: ragecharge(wee) = .4
            Case 2: kocharge(wee) = .3: ragecharge(wee) = .3
            Case 3: kocharge(wee) = .4: ragecharge(wee) = .2
            Case 4: kocharge(wee) = .1: ragecharge(wee) = .5
            Case 5: kocharge(wee) = .5: ragecharge(wee) = .1
            Case 666: kocharge(wee) = .5: ragecharge(wee) = .7
            Case 2000: kocharge(wee) = .8: ragecharge(wee) = 1
        End Select
    Next wee

End Sub

Sub fighterlimits
    For wee = 1 To 2

        If Abs(elbow1x(wee)) > 10 Then elbow1x(wee) = 0
        If Abs(hand1x(wee)) > 10 Then hand1x(wee) = 0
        If Abs(nee1x(wee)) > 10 Then nee1x(wee) = 0
        If Abs(foot1x(wee)) > 10 Then foot1x(wee) = 0

        If Abs(elbow2x(wee)) > 10 Then elbow2x(wee) = 0
        If Abs(hand2x(wee)) > 10 Then hand2x(wee) = 0
        If Abs(nee2x(wee)) > 10 Then nee2x(wee) = 0
        If Abs(foot2x(wee)) > 10 Then foot2x(wee) = 0



        If Abs(elbow1y(wee)) > 10 Then elbow1y(wee) = 0
        If Abs(hand1y(wee)) > 10 Then hand1y(wee) = 0
        If Abs(nee1y(wee)) > 10 Then nee1y(wee) = 0
        If Abs(foot1y(wee)) > 10 Then foot1y(wee) = 0

        If Abs(elbow2y(wee)) > 10 Then elbow2y(wee) = 0
        If Abs(hand2y(wee)) > 10 Then hand2y(wee) = 0
        If Abs(nee2y(wee)) > 10 Then nee2y(wee) = 0
        If Abs(foot2y(wee)) > 10 Then foot2y(wee) = 0

    Next wee
End Sub

Sub fightermove

    For pc1 = 1 To 2

        pc2 = pc1 + 2

        '--------------------------------------------------------------- Misc Physics
        'Push Appart

        If position%(1) = 1 And position%(2) = 1 And butty(1) > floor1 - 25 And butty(2) > floor1 - 25 Then
            If fighterz(1) < fighterz(2) + .1 And fighterz(1) > fighterz(2) - .1 Then
                If neckx(3) > neckx(4) - 1 And neckx(3) < neckx(4) + 1 Then
                    If buttx(1) < buttx(2) Then butth(1) = butth(1) - .5: butth(2) = butth(2) + .5 Else butth(1) = butth(1) + .5: butth(2) = butth(2) - .5
                End If
            End If
        End If

        '------------------------------------------------------------- Apply Movement
        buttx(pc1) = buttx(pc1) + butth(pc1)
        headx(pc1) = headx(pc1) + headh(pc1)
        neckx(pc1) = neckx(pc1) + neckh(pc1)
        elbow1x(pc1) = elbow1x(pc1) + elbow1h(pc1)
        elbow2x(pc1) = elbow2x(pc1) + elbow2h(pc1)
        hand1x(pc1) = hand1x(pc1) + hand1h(pc1)
        hand2x(pc1) = hand2x(pc1) + hand2h(pc1)
        nee1x(pc1) = nee1x(pc1) + nee1h(pc1)
        nee2x(pc1) = nee2x(pc1) + nee2h(pc1)
        foot1x(pc1) = foot1x(pc1) + foot1h(pc1)
        foot2x(pc1) = foot2x(pc1) + foot2h(pc1)

        butty(pc1) = butty(pc1) + buttv(pc1)
        heady(pc1) = heady(pc1) + headv(pc1)
        necky(pc1) = necky(pc1) + neckv(pc1)
        elbow1y(pc1) = elbow1y(pc1) + elbow1v(pc1)
        elbow2y(pc1) = elbow2y(pc1) + elbow2v(pc1)
        hand1y(pc1) = hand1y(pc1) + hand1v(pc1)
        hand2y(pc1) = hand2y(pc1) + hand2v(pc1)
        nee1y(pc1) = nee1y(pc1) + nee1v(pc1)
        nee2y(pc1) = nee2y(pc1) + nee2v(pc1)
        foot1y(pc1) = foot1y(pc1) + foot1v(pc1)
        foot2y(pc1) = foot2y(pc1) + foot2v(pc1)

        fighterz(pc1) = fighterz(pc1) + fighterd(pc1)
        hx(pc1) = hx(pc1) + hh(pc1)
        hy(pc1) = hy(pc1) + hv(pc1)

        '------------------------------------------------------------- Flip Direction
        If pc1 = 1 And position%(1) = 1 And pticker%(1) > 20 And canjump%(1) = 1 Then
            If buttx(1) > buttx(2) Then d%(pc1) = -1 Else d%(pc1) = 1
        End If

        If pc1 = 2 And position%(2) = 1 And pticker%(2) > 20 And canjump%(2) = 1 Then
            If buttx(1) < buttx(2) Then d%(pc1) = -1 Else d%(pc1) = 1
        End If


        '----------------------------------------------------------- Create X/Y Cords
        neckx(pc2) = buttx(pc1) + neckx(pc1) * d%(pc1)
        necky(pc2) = butty(pc1) + necky(pc1)

        headx(pc2) = neckx(pc2) + headx(pc1) * d%(pc1)
        heady(pc2) = necky(pc2) + heady(pc1)

        elbow1x(pc2) = neckx(pc2) + elbow1x(pc1) * d%(pc1)
        elbow1y(pc2) = necky(pc2) + elbow1y(pc1)
        elbow2x(pc2) = neckx(pc2) + elbow2x(pc1) * d%(pc1)
        elbow2y(pc2) = necky(pc2) + elbow2y(pc1)

        hand1x(pc2) = elbow1x(pc2) + hand1x(pc1) * d%(pc1)
        hand1y(pc2) = elbow1y(pc2) + hand1y(pc1)
        hand2x(pc2) = elbow2x(pc2) + hand2x(pc1) * d%(pc1)
        hand2y(pc2) = elbow2y(pc2) + hand2y(pc1)

        nee1x(pc2) = buttx(pc1) + nee1x(pc1) * d%(pc1)
        nee1y(pc2) = butty(pc1) + nee1y(pc1)
        nee2x(pc2) = buttx(pc1) + nee2x(pc1) * d%(pc1)
        nee2y(pc2) = butty(pc1) + nee2y(pc1)

        foot1x(pc2) = nee1x(pc2) + foot1x(pc1) * d%(pc1)
        foot1y(pc2) = nee1y(pc2) + foot1y(pc1)
        foot2x(pc2) = nee2x(pc2) + foot2x(pc1) * d%(pc1)
        foot2y(pc2) = nee2y(pc2) + foot2y(pc1)

        '----------------------------------------------------------------------------
    Next pc1


    '----------------------------------------------------------------------- Hair

    'P1
    If hairl%(1) > 0 Then
        If headless%(1) = 1 Then headx(3) = hx(1): heady(3) = hy(1)
        hairx(1) = headx(3) - 2 * d%(1)
        hairy(1) = heady(3) + 1

        For n% = 2 To 5
            hairy(n%) = hairy(n%) + gravity
            If hairx(n%) < hairx(n% - 1) - hairl%(1) Then hairx(n%) = hairx(n% - 1) - hairl%(1)
            If hairy(n%) < hairy(n% - 1) - hairl%(1) Then hairy(n%) = hairy(n% - 1) - hairl%(1)
            If hairx(n%) > hairx(n% - 1) + hairl%(1) Then hairx(n%) = hairx(n% - 1) + hairl%(1)
            If hairy(n%) > hairy(n% - 1) + hairl%(1) Then hairy(n%) = hairy(n% - 1) + hairl%(1)

        Next n%

        For n% = 2 To 5
            If hairx(n%) < hairx(n% - 1) Then hairx(n%) = hairx(n%) + .5
            If hairx(n%) > hairx(n% - 1) Then hairx(n%) = hairx(n%) - .5
        Next n%
    End If


    'P2
    If hairl%(2) > 0 Then
        If headless%(2) = 1 Then headx(4) = hx(2): heady(4) = hy(2)
        hairx(6) = headx(4) - 2 * d%(2)
        hairy(6) = heady(4) + 1

        For n% = 7 To 10
            hairy(n%) = hairy(n%) + gravity
            If hairx(n%) < hairx(n% - 1) - hairl%(2) Then hairx(n%) = hairx(n% - 1) - hairl%(2)
            If hairy(n%) < hairy(n% - 1) - hairl%(2) Then hairy(n%) = hairy(n% - 1) - hairl%(2)
            If hairx(n%) > hairx(n% - 1) + hairl%(2) Then hairx(n%) = hairx(n% - 1) + hairl%(2)
            If hairy(n%) > hairy(n% - 1) + hairl%(2) Then hairy(n%) = hairy(n% - 1) + hairl%(2)
        Next n%

        For n% = 7 To 10
            If hairx(n%) < hairx(n% - 1) Then hairx(n%) = hairx(n%) + .5
            If hairx(n%) > hairx(n% - 1) Then hairx(n%) = hairx(n%) - .5

        Next n%
    End If


End Sub

Sub fightername (n%)

    '-------------------------------------------------------------- Generate Name

    Select Case body%(n%)
        Case 1: n1$ = "Th"
        Case 2: n1$ = "S"
        Case 3: n1$ = "K"
        Case 4: n1$ = "V"
        Case 5: n1$ = "R"
        Case 6: n1$ = "L"
        Case 7: n1$ = "D"
        Case 8: n1$ = "Br"
    End Select

    Select Case head%(n%)
        Case 1: n2$ = "a"
        Case 2: n2$ = "e"
        Case 3: n2$ = "i"
        Case 4: n2$ = "o"
        Case 5: n2$ = "u"
    End Select

    Select Case hands%(n%)
        Case 1: n4$ = "kk"
        Case 2: n4$ = "t"
        Case 3: n4$ = "n"
        Case 4: n4$ = "t"
        Case 5: n4$ = "l"
    End Select

    Select Case feet%(n%)
        Case 1: n6$ = "n"
        Case 2: n6$ = "ly"
        Case 3: n6$ = "th"
        Case 4: n6$ = "ra"
        Case 5: n6$ = "cha"
    End Select

    name$(n%) = n1$ + n2$ + n3$ + n4$ + n5$ + n6$

    If head%(n%) = 666 Then name$(n%) = "Demize"
    If head%(n%) = 1998 Then name$(n%) = "Magnissa"
    If head%(n%) = 2000 Then name$(n%) = "MasterBean"

End Sub

Sub fighterpop (n)
    position%(n) = 1
    buttv(n) = -gravity * 10
End Sub

Sub fighterpositions

    fighterdirect

    For pc1 = 1 To 2

        '------------------------------------------- Player Current / Player Opponent
        If pc1 = 2 Then po1 = 1 Else po1 = 2
        pc2 = pc1 + 2
        po2 = po1 + 2


        '------------------------------------------------------------ position ticker
        If psaver%(pc1) = position%(pc1) Then
            If pticker%(pc1) < 32767 Then pticker%(pc1) = pticker%(pc1) + 1
        Else
            psaver%(pc1) = position%(pc1)
            pticker%(pc1) = 1
        End If





        '======================================================= Position Replacement
        '-------------------------------------------------------------- Punch 2 Elbow
        If pticker%(pc1) = 1 Then
            If neckx(3) > neckx(4) - 6 And neckx(3) < neckx(4) + 6 Then
                If position%(pc1) = 2 Or position%(pc1) = 3 Then position%(pc1) = 4
            End If
            '---------------------------------------------------------------- Short 2 Nee
            If canjump%(pc1) = 1 And neckx(3) > neckx(4) - 3 And neckx(3) < neckx(4) + 3 Then
                If position%(pc1) = 5 Then position%(pc1) = 7
            End If
            '--------------------------------------------------- Roundhouse 2 In-Air Kick
            If position%(pc1) = 6 And canjump%(pc1) = 0 And Abs(butth(pc1)) > .5 Then
                position%(pc1) = 14
            End If
            '-------------------------------------------------------------- ---- --- -- -
        End If


        '------------------------------------------------------ Opponent Target Areas

        If headless%(po1) = 0 Then
            h1x = headx(po2) - 2
            h1y = heady(po2) - 4
            h2x = headx(po2) + 2
            h2y = heady(po2) + 4
        Else
            h1x = neckx(po2)
            h1y = necky(po2)
            h2x = neckx(po2)
            h2y = necky(po2)
        End If
        'psline (h1x), (h1y), (fighterz(po1)), (h2x), (h2y), (fighterz(po1)), 12, 1

        m1x = neckx(po2) - 2
        m1y = h2y
        m2x = neckx(po2) + 2
        m2y = butty(po1)
        'psline (m1x), (m1y), (fighterz(po1)), (m2x), (m2y), (fighterz(po1)), 9, 1

        l1x = buttx(po1) - 5
        l1y = butty(po1)
        l2x = buttx(po1) + 5
        If foot1y(po2) > foot2y(po2) Then l2y = foot1y(po2) Else l2y = foot2y(po2)
        'psline (l1x), (l1y), (fighterz(po1)), (l2x), (l2y), (fighterz(po1)), 14, 1


        'Save Health/KO for Blocking
        If position%(po1) = 99 Then healths% = health%(po1): kos = ko(po1) Else healths% = 0


        '---------------------------------------------------- Turn Off Special Switch
        If position%(pc1) > 29 And position%(pc1) < 81 Then Special%(1) = 0

        '------------------------------------------------------------------ positions
        Select Case position%(pc1)

            '------------------------------------------------------------------- Standing
            Case Is = 1
                droop = (ko(pc1) / 50) + (health%(pc1) / 200)
                If neckx(pc1) > 3 Then neckh(pc1) = neckh(pc1) - .05 Else neckh(pc1) = neckh(pc1) + .05
                If headx(pc1) > 1 Then headh(pc1) = headh(pc1) - .01 Else headh(pc1) = headh(pc1) + .05
                If elbow1x(pc1) > .5 Then elbow1h(pc1) = elbow1h(pc1) - .08 Else elbow1h(pc1) = elbow1h(pc1) + .08
                If elbow2x(pc1) > -3 Then elbow2h(pc1) = elbow2h(pc1) - .08 Else elbow2h(pc1) = elbow2h(pc1) + .08
                If hand1x(pc1) > 2 Then hand1h(pc1) = hand1h(pc1) - .08 Else hand1h(pc1) = hand1h(pc1) + .08
                If hand2x(pc1) > 3 Then hand2h(pc1) = hand2h(pc1) - .08 Else hand2h(pc1) = hand2h(pc1) + .08

                If legs%(pc1) = 666 Then
                    If canjump%(pc1) = 1 And Abs(butth(pc1)) > .05 And Abs(butth(pc1)) < 5 Then
                        nee1x(pc1) = -2 + (walkx(pc1) * Abs(butth(pc1) / 1.8))
                        nee2x(pc1) = 0 - (walkx(pc1) * Abs(butth(pc1) / 1.8))
                    Else
                        If nee1x(pc1) > -3 Then nee1h(pc1) = nee1h(pc1) - .05 Else nee1h(pc1) = nee1h(pc1) + .01
                        If nee2x(pc1) > -3 Then nee2h(pc1) = nee2h(pc1) - .05 Else nee2h(pc1) = nee2h(pc1) + .01
                    End If
                    If foot1x(pc1) > 5 Then foot1h(pc1) = foot1h(pc1) - .1 Else foot1h(pc1) = foot1h(pc1) + .01
                    If foot2x(pc1) > 5 Then foot2h(pc1) = foot2h(pc1) - .05 Else foot2h(pc1) = foot2h(pc1) + .01
                Else
                    If canjump%(pc1) = 1 And Abs(butth(pc1)) > .05 And Abs(butth(pc1)) < 5 Then
                        nee1x(pc1) = -1 + (walkx(pc1) * Abs(butth(pc1) / 1.8))
                        nee2x(pc1) = 3 - (walkx(pc1) * Abs(butth(pc1) / 1.8))
                    Else
                        If nee1x(pc1) > 5 Then nee1h(pc1) = nee1h(pc1) - .05 Else nee1h(pc1) = nee1h(pc1) + .05
                        If nee2x(pc1) > -1 Then nee2h(pc1) = nee2h(pc1) - .05 Else nee2h(pc1) = nee2h(pc1) + .05
                    End If
                    If foot1x(pc1) > -1 Then foot1h(pc1) = foot1h(pc1) - .1 Else foot1h(pc1) = foot1h(pc1) + .01
                    If foot2x(pc1) > -3 Then foot2h(pc1) = foot2h(pc1) - .01 Else foot2h(pc1) = foot2h(pc1) + .05
                End If

                If necky(pc1) > -7 - droop Then neckv(pc1) = neckv(pc1) - .05 Else neckv(pc1) = neckv(pc1) + .05
                If heady(pc1) > -1 - droop Then headv(pc1) = headv(pc1) - .01 Else headv(pc1) = headv(pc1) + .01
                If elbow1y(pc1) > 6 Then elbow1v(pc1) = elbow1v(pc1) - .08 Else elbow1v(pc1) = elbow1v(pc1) + .08
                If elbow2y(pc1) > 5 Then elbow2v(pc1) = elbow2v(pc1) - .08 Else elbow2v(pc1) = elbow2v(pc1) + .08
                If hand1y(pc1) > -2 - droop Then hand1v(pc1) = hand1v(pc1) - .08 Else hand1v(pc1) = hand1v(pc1) + .08
                If hand2y(pc1) > 2.5 - droop Then hand2v(pc1) = hand2v(pc1) - .08 Else hand2v(pc1) = hand2v(pc1) + .08
                If nee1y(pc1) > 8 Then nee1v(pc1) = nee1v(pc1) - .01 Else nee1v(pc1) = nee1v(pc1) + .1
                If nee2y(pc1) > 8 Then nee2v(pc1) = nee2v(pc1) - .01 Else nee2v(pc1) = nee2v(pc1) + .1
                If foot1y(pc1) > 7 Then foot1v(pc1) = foot1v(pc1) - .01 Else foot1v(pc1) = foot1v(pc1) + .05
                If foot2y(pc1) > 7 Then foot2v(pc1) = foot2v(pc1) - .01 Else foot2v(pc1) = foot2v(pc1) + .1


                fightergoo (pc1), 1.3

                '------------------------------------------------------------------------ Jab

            Case Is = 2
                If pticker%(pc1) = 1 Then sbfx 1
                fighterfreeze (pc1)
                If neckx(pc1) < 3.5 Then neckx(pc1) = neckx(pc1) + .5
                elbow1x(pc1) = 4
                elbow1y(pc1) = 0
                hand1x(pc1) = 3
                hand1y(pc1) = 0
                elbow2y(pc1) = 2


                'Momontary Pause / Detect hit
                If pticker%(pc1) = 2 Then
                    fighterfreeze (pc1)

                    If razers%(pc1) > 0 Then ahpow%(pc1) = ahpow%(pc1) + 5

                    'High/Head
                    If hand1x(pc2) > h1x And hand1x(pc2) < h2x And hand1y(pc2) > h1y And hand1y(pc2) < h2y Then
                        health%(po1) = health%(po1) - ahpow%(pc1) * 2
                        ko(po1) = ko(po1) - akpow%(pc1) * 2
                        position%(po1) = 1
                        If headx(po1) > 0 Then headx(po1) = headx(po1) - 1
                        If position%(po1) < 99 Then
                            If buttx(pc1) < buttx(po1) Then particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 4, 3: butth(po1) = butth(po1) + .5 Else particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 3: butth(po1) = butth(po1) - .5
                        End If
                        If razers%(pc1) > 0 Then soundticker% = 0: sbfx 17 Else soundticker% = 0: sbfx 10
                    End If

                    'Medium/Low
                    If hand1x(pc2) > m1x And hand1x(pc2) < m2x And hand1y(pc2) > m1y And hand1y(pc2) < l2y Then
                        health%(po1) = health%(po1) - ahpow%(pc1)
                        ko(po1) = ko(po1) - akpow%(pc1)
                        position%(po1) = 1
                        neckx(po1) = neckx(po1) + 1
                        necky(po1) = necky(po1) + 1
                        If position%(po1) < 99 Then particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 1, 5
                        If razers%(pc1) > 0 Then soundticker% = 0: sbfx 17 Else soundticker% = 0: sbfx 9
                    End If

                    If razers%(pc1) > 0 Then ahpow%(pc1) = ahpow%(pc1) - 5

                End If

                'Return Position
                If pticker%(pc1) > 3 Then
                    elbow1x(pc1) = 2
                    elbow1h(pc1) = -.5
                    elbow1y(pc1) = 1
                    elbow1v(pc1) = 1
                    hand1h(pc1) = -.5
                    hand1v(pc1) = -.5
                    position%(pc1) = 1
                End If

                '--------------------------------------------------------------------- Strong
            Case Is = 3
                If pticker%(pc1) = 1 Then sbfx 2
                fighterfreeze (pc1)
                If neckx(pc1) < 3 Then neckx(pc1) = neckx(pc1) + 1
                elbow2x(pc1) = 4
                elbow2y(pc1) = -1
                hand2x(pc1) = 3
                hand2y(pc1) = -1.5

                'Momontary Pause / Detect hit
                If pticker%(pc1) = 2 Then
                    fighterfreeze (pc1)

                    If razers%(pc1) > 0 Then ahpow%(pc1) = ahpow%(pc1) + 5

                    'High/Head
                    If hand2x(pc2) > h1x And hand2x(pc2) < h2x And hand2y(pc2) > h1y And hand2y(pc2) < h2y Then
                        health%(po1) = health%(po1) - ahpow%(pc1) * 2
                        ko(po1) = ko(po1) - akpow%(pc1)
                        position%(po1) = 1
                        If headx(po1) > 0 Then headx(po1) = headx(po1) - 1
                        If neckx(po1) > 0 Then neckx(po1) = neckx(po1) - 1
                        If position%(po1) < 99 Then
                            If buttx(pc1) < buttx(po1) Then particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 3: butth(po1) = butth(po1) + 1 Else particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 3: butth(po1) = butth(po1) - 1
                        End If
                        If razers%(pc1) > 0 Then soundticker% = 0: sbfx 17 Else soundticker% = 0: sbfx 11
                    End If

                    'Medium/Low
                    If hand2x(pc2) > m1x And hand2x(pc2) < m2x And hand2y(pc2) > m1y And hand2y(pc2) < l2y Then
                        health%(po1) = health%(po1) - ahpow%(pc1) * 3
                        ko(po1) = ko(po1) - akpow%(pc1) * 2
                        position%(po1) = 1
                        neckx(po1) = neckx(po1) + 1
                        necky(po1) = necky(po1) + 1
                        If position%(po1) < 99 Then particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 1, 5
                        If razers%(pc1) > 0 Then soundticker% = 0: sbfx 17 Else soundticker% = 0: sbfx 10
                    End If

                    If razers%(pc1) > 0 Then ahpow%(pc1) = ahpow%(pc1) - 5

                End If

                'Return Position
                If pticker%(pc1) > 3 Then
                    elbow2x(pc1) = 2
                    elbow2h(pc1) = -1.5
                    elbow2v(pc1) = 1
                    hand2h(pc1) = 0
                    hand2v(pc1) = .5
                    position%(pc1) = 1
                End If


                '---------------------------------------------------------------------- Elbow
            Case Is = 4
                If pticker%(pc1) = 1 Then sbfx 3
                fighterfreeze (pc1)
                elbow1x(pc1) = 5
                elbow1y(pc1) = 0
                hand1x(pc1) = -3
                hand1y(pc1) = 1.5

                'Momontary Pause / Detect hit
                If pticker%(pc1) = 2 Then
                    fighterfreeze (pc1)

                    If elbow1x(pc2) > l1x And elbow1x(pc2) < l2x And elbow1y(pc2) > h1y And elbow1y(pc2) < l2y Then
                        health%(po1) = health%(po1) - ahpow%(pc1)
                        ko(po1) = ko(po1) - akpow%(pc1) * 2
                        If buttx(pc1) > buttx(po1) Then butth(po1) = butth(po1) - .3 Else butth(po1) = butth(po1) + .3
                        If position%(po1) < 99 Then particle (elbow1x(pc2)), (elbow1y(pc2)), (fighterz(pc1)), 1, 3
                        soundticker% = 0: sbfx 9
                        position%(po1) = 1
                    End If
                End If

                'Return Position
                If pticker%(pc1) > 3 Then
                    elbow1v(pc1) = 1
                    position%(pc1) = 1
                End If


                '---------------------------------------------------------------------- Short
            Case Is = 5

                fighterfreeze (pc1)

                Select Case combo%(pc1)
                    '----------------------------+
                    Case 0
                        sbfx 2
                        nee1x(pc1) = 6
                        nee1y(pc1) = -1
                        foot1x(pc1) = 6
                        foot1y(pc1) = -1


                        '----------------------------+
                    Case 1
                        sbfx 1
                        neckx(pc1) = neckx(pc1) + 1
                        nee1x(pc1) = 5
                        nee1y(pc1) = 5
                        foot1x(pc1) = 5
                        foot1y(pc1) = 5


                        '----------------------------+
                    Case 2
                        sbfx 2
                        combo%(pc1) = -1

                        buttx(pc1) = buttx(pc1) + (2 * d%(pc1))
                        buttv(pc1) = buttv(pc1) - 3

                        neckx(pc1) = -1
                        nee1x(pc1) = 6
                        nee1y(pc1) = -6
                        foot1x(pc1) = 6
                        foot1y(pc1) = -6

                        nee2x(pc1) = 0
                        foot2x(pc1) = 0

                        nee1v(pc1) = 1
                        foot1v(pc1) = 2

                        elbow1x(pc1) = elbow1x(pc1) + 2
                        elbow1y(pc1) = elbow1y(pc1) - 2
                        hand2x(pc1) = hand2x(pc1) - 2
                        hand2y(pc1) = hand2y(pc1) + 2

                End Select


                tx = buttx(pc1) + nee1x(pc1) * d%(pc1)
                ty = butty(pc1) + nee1y(pc1)
                tx = tx + foot1x(pc1) * d%(pc1)
                ty = ty + foot1y(pc1)

                'Detect Hit
                If tx > l1x And tx < l2x And ty > h1y And ty < l2y Then
                    soundticker% = 0: sbfx 9
                    If position%(po1) < 99 Then
                        health%(po1) = health%(po1) - lhpow%(pc1)
                        ko(po1) = ko(po1) - lkpow%(pc1)
                        position%(po1) = 1
                        If combo%(pc1) = -1 Then particle (tx), (ty), (fighterz(pc1)), 2, 5: buttv(po1) = -8: butth(po1) = d%(pc1): fall (po1) Else If position%(po1) < 99 Then particle (tx), (ty), (fighterz(pc1)), 1, 5
                        combo%(pc1) = combo%(pc1) + 1: combol%(pc1) = 30
                    End If
                End If

                'Return Position
                position%(pc1) = 1
                If foot1x(pc1) > 0 Then foot1h(pc1) = -2


                '----------------------------------------------------------------- Roundhouse
            Case Is = 6

                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    neckx(pc1) = 0
                    buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

                    nee1x(pc1) = 0
                    foot1x(pc1) = 0

                    If foot1y(pc1) < 1 Or nee1y(pc1) > 3 Then
                        nee1y(pc1) = 8
                        foot1y(pc1) = 7
                    End If

                    elbow1h(pc1) = -.5
                    elbow2h(pc1) = .5
                    elbow2v(pc1) = -.5
                End If

                If pticker%(pc1) = 3 Then
                    If buttx(pc1) > buttx(po1) Then
                        d%(pc1) = -1
                    Else
                        d%(pc1) = 1
                    End If
                End If

                If pticker%(pc1) = 5 Then
                    nee2h(pc1) = 2
                    nee2v(pc1) = -2

                    foot2h(pc1) = -1
                    foot2v(pc1) = -1
                End If

                If pticker%(pc1) = 8 Then
                    sbfx 4
                    fighterfreeze (pc1)

                    elbow1x(pc1) = elbow1x(pc1) + 2
                    elbow1y(pc1) = elbow1y(pc1) - 2

                    hand2y(pc1) = hand2y(pc1) + 2
                    elbow2y(pc1) = elbow2y(pc1) + 2

                    nee2x(pc1) = 5
                    nee2y(pc1) = -1


                    foot2x(pc1) = 5
                    foot2y(pc1) = -1
                End If


                'Detect Hit
                If pticker%(pc1) = 9 And foot2x(pc2) > l1x And foot2x(pc2) < l2x And foot2y(pc2) > h1y And foot2y(pc2) < l2y Then
                    combol%(pc1) = 30
                    If position%(po1) < 99 Then
                        health%(po1) = health%(po1) - lhpow%(pc1) * 2
                        soundticker% = 0: sbfx 11
                        ko(po1) = ko(po1) - lkpow%(pc1) * 2
                        particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 1, 5
                        position%(po1) = 1
                        If nee1y(pc1) < 5 Then
                            fall po1
                            buttv(po1) = buttv(po1) - 5
                        Else
                            fighterz(po1) = midstage + .5
                        End If
                    Else
                        soundticker% = 0: sbfx 9
                    End If
                End If


                If pticker%(pc1) > 9 Then
                    fighterfreeze (pc1)

                    nee2h(pc1) = -1
                    nee2v(pc1) = 1
                    foot2h(pc1) = -2
                    foot2v(pc1) = 1

                    position%(pc1) = 1
                End If


                '------------------------------------------------------------------------ Nee
            Case Is = 7
                If pticker%(pc1) = 1 Then sbfx 3
                fighterfreeze (pc1)
                buttx(pc1) = buttx(pc1) + d%(pc1)
                buttv(pc1) = buttv(pc1) - 2
                nee1x(pc1) = 0
                nee1y(pc1) = 6
                foot1x(pc1) = -1
                foot1y(pc1) = 5
                nee2x(pc1) = 5
                nee2y(pc1) = -4
                elbow1x(pc1) = -2
                elbow1y(pc1) = 3
                elbow2x(pc1) = -2
                elbow2y(pc1) = 3

                'Momontary Pause / Detect hit
                If pticker%(pc1) = 2 Then
                    fighterfreeze (pc1)

                    If nee2x(pc2) > l1x And nee2x(pc2) < l2x And nee2y(pc2) > h1y And nee2y(pc2) < l2y Then
                        soundticker% = 0: sbfx 10
                        health%(po1) = health%(po1) - lhpow%(pc1) * 2
                        ko(po1) = ko(po1) - lkpow%(pc1)
                        combol%(pc1) = 30
                        neckx(po1) = 2
                        heady(po1) = 2
                        position%(po1) = 1
                        If buttx(pc1) > buttx(po1) Then butth(po1) = butth(po1) - .3: particle (nee2x(pc2)), (nee2y(pc2)), (fighterz(pc1)), 3, 3 Else butth(po1) = butth(po1) + .3: particle (nee2x(pc2)), (nee2y(pc2)), (fighterz(pc1)), 4, 3
                    End If
                End If

                'Return Position
                If pticker%(pc1) > 3 Then
                    nee2v(pc1) = 1
                    position%(pc1) = 1
                End If



                '--------------------------------------------------------------- Fall Forward
            Case Is = 8
                If pticker%(pc1) = 1 Then buttv(pc1) = buttv(pc1) - 3

                If neckx(pc1) > 7 Then neckh(pc1) = neckh(pc1) - .05 Else neckh(pc1) = neckh(pc1) + .1
                If headx(pc1) > 3 Then headh(pc1) = headh(pc1) - .01 Else headh(pc1) = headh(pc1) + .1
                elbow1h(pc1) = 0
                elbow2h(pc1) = 0
                hand1h(pc1) = 0
                hand2h(pc1) = 0
                If nee1x(pc1) > -5 Then nee1h(pc1) = nee1h(pc1) - .2 Else nee1h(pc1) = nee1h(pc1) + .1
                If nee2x(pc1) > -2 Then nee2h(pc1) = nee2h(pc1) - .2 Else nee2h(pc1) = nee2h(pc1) + .1
                If foot1x(pc1) > -4 Then foot1h(pc1) = foot1h(pc1) - .1 Else foot1h(pc1) = foot1h(pc1) + .05
                If foot2x(pc1) > -3 Then foot2h(pc1) = foot2h(pc1) - .1 Else foot2h(pc1) = foot2h(pc1) + .05

                If necky(pc1) > -3 Then neckv(pc1) = neckv(pc1) - .05 Else neckv(pc1) = neckv(pc1) + .05
                If heady(pc1) > 2 Then headv(pc1) = headv(pc1) - .01 Else headv(pc1) = headv(pc1) + .05
                If elbow1y(pc2) > butty(pc1) Then elbow1v(pc1) = elbow1v(pc1) - .1 Else elbow1v(pc1) = elbow1v(pc1) + .05
                If elbow2y(pc2) > butty(pc1) Then elbow2v(pc1) = elbow2v(pc1) - .1 Else elbow2v(pc1) = elbow2v(pc1) + .05
                If hand1y(pc2) > butty(pc1) Then hand1v(pc1) = hand1v(pc1) - .05 Else hand1v(pc1) = hand1v(pc1) + .05
                If hand2y(pc2) > butty(pc1) Then hand2v(pc1) = hand2v(pc1) - .05 Else hand2v(pc1) = hand2v(pc1) + .05
                nee1y(pc1) = 0
                foot1y(pc1) = 0
                nee2y(pc1) = 0
                foot2y(pc1) = 0
                fightergoo (pc1), 1.3

                If Abs(butth(pc1)) < .05 And Abs(buttv(pc1)) < .1 And pticker%(pc1) > sdelay%(pc1) And necky(pc2) > butty(pc1) - 3 Then
                    fighterfreeze (pc1)
                    If ko(pc1) > 0 And health%(pc1) > 0 Then
                        position%(pc1) = 9
                        neckx(pc1) = 3
                        necky(pc1) = -5
                        elbow1x(pc1) = 3
                        elbow1y(pc1) = 4
                        hand1x(pc1) = 2
                        hand1y(pc1) = 3
                        elbow2x(pc1) = 3
                        elbow2y(pc1) = 4
                        hand2x(pc1) = 2
                        hand2y(pc1) = 3
                    End If
                End If


                '------------------------------------------------------------------- Get Up 1
            Case Is = 9

                If heady(pc1) > -1 - droop Then headv(pc1) = headv(pc1) - .1 Else headv(pc1) = headv(pc1) + .05
                nee1h(pc1) = 1.5
                neckh(pc1) = -.2
                neckv(pc1) = -.4

                fightergoo (pc1), 1.05

                If pticker%(pc1) > 5 Then

                    position%(pc1) = 1

                    headx(pc1) = 1
                    neckh(pc1) = 0
                    neckv(pc1) = 0
                    buttv(pc1) = -5
                    nee2x(pc1) = 2
                    foot1x(pc1) = 1
                    foot2x(pc1) = -2
                    nee1h(pc1) = 0
                    nee1y(pc1) = 0
                    nee2y(pc1) = 4
                    foot1y(pc1) = 4
                    foot2y(pc1) = 4
                End If



                '------------------------------------------------------------------ Fall Back
            Case Is = 10
                If neckx(pc1) > -7 Then neckh(pc1) = neckh(pc1) - .1 Else neckh(pc1) = neckh(pc1) + .05
                If headx(pc1) > -3 Then headh(pc1) = headh(pc1) - .1 Else headh(pc1) = headh(pc1) + .01
                elbow1h(pc1) = 0
                elbow2h(pc1) = 0
                hand1h(pc1) = 0
                hand2h(pc1) = 0
                If nee1x(pc1) > 5 Then nee1h(pc1) = nee1h(pc1) - .01 Else nee1h(pc1) = nee1h(pc1) + .1
                If nee2x(pc1) > 2 Then nee2h(pc1) = nee2h(pc1) - .01 Else nee2h(pc1) = nee2h(pc1) + .1
                If foot1x(pc1) > 4 Then foot1h(pc1) = foot1h(pc1) - .05 Else foot1h(pc1) = foot1h(pc1) + .1
                If foot2x(pc1) > 3 Then foot2h(pc1) = foot2h(pc1) - .05 Else foot2h(pc1) = foot2h(pc1) + .1

                If necky(pc1) > 0 Then neckv(pc1) = neckv(pc1) - .05 Else neckv(pc1) = neckv(pc1) + .1
                If heady(pc1) > -2 Then headv(pc1) = headv(pc1) - .01 Else headv(pc1) = headv(pc1) + .01
                If elbow1y(pc1 + 2) > butty(pc1) Then elbow1v(pc1) = elbow1v(pc1) - .1 Else elbow1v(pc1) = elbow1v(pc1) + .05
                If elbow2y(pc1 + 2) > butty(pc1) Then elbow2v(pc1) = elbow2v(pc1) - .1 Else elbow2v(pc1) = elbow2v(pc1) + .05
                If hand1y(pc1 + 2) > butty(pc1) Then hand1v(pc1) = hand1v(pc1) - .05 Else hand1v(pc1) = hand1v(pc1) + .05
                If hand2y(pc1 + 2) > butty(pc1) Then hand2v(pc1) = hand2v(pc1) - .05 Else hand2v(pc1) = hand2v(pc1) + .05
                If nee1y(pc1) > -1 Then nee1v(pc1) = nee1v(pc1) - .2 Else nee1v(pc1) = nee1v(pc1) + .05
                If foot1y(pc1) > 1 Then foot1v(pc1) = foot1v(pc1) - .1 Else foot1v(pc1) = foot1v(pc1) + .1
                If nee2y(pc1) > -3 Then nee2v(pc1) = nee2v(pc1) - .2 Else nee2v(pc1) = nee2v(pc1) + .05
                If foot2y(pc1) > 3 Then foot2v(pc1) = foot2v(pc1) - .1 Else foot2v(pc1) = foot2v(pc1) + .1
                fightergoo (pc1), 1.3

                If Abs(butth(pc1)) < .05 And Abs(buttv(pc1)) < .1 And pticker%(pc1) > sdelay%(pc1) And necky(pc2) >= butty(pc1) Then
                    fighterfreeze (pc1)
                    If ko(pc1) > 0 And health%(pc1) > 0 Then position%(pc1) = 11
                End If

                '------------------------------------------------------------------- Get Up 2
            Case Is = 11

                neckv(pc1) = neckv(pc1) + .005

                If nee1x(pc1) > -5 Then nee1h(pc1) = nee1h(pc1) - .1
                If nee2x(pc1) > -5 Then nee2h(pc1) = nee2h(pc1) - .1
                If foot1x(pc1) > 4 Then foot1h(pc1) = foot1h(pc1) - .1
                If foot2x(pc1) > 4 Then foot2h(pc1) = foot2h(pc1) - .1

                If nee1y(pc1) > -3 Then nee1v(pc1) = nee1v(pc1) - .01
                If nee2y(pc1) > -3 Then nee2v(pc1) = nee2v(pc1) - .01
                If foot1y(pc1) > -2 Then foot1v(pc1) = foot1v(pc1) - .1
                If foot2y(pc1) > -2 Then foot2v(pc1) = foot2v(pc1) - .1

                fightergoo (pc1), 1.3


                If pticker%(pc1) > 25 Then

                    position%(pc1) = 1
                    headx(pc1) = 1

                    neckh(pc1) = 2
                    neckv(pc1) = -2

                    buttv(pc1) = -5

                    nee1x(pc1) = 5
                    nee2x(pc1) = 2
                    foot1x(pc1) = 1
                    foot2x(pc1) = -2

                    nee1y(pc1) = 0
                    nee2y(pc1) = 4
                    foot1y(pc1) = 4
                    foot2y(pc1) = 4
                End If


                '--------------------------------------------------------------------- Crouch
            Case Is = 12
                If pticker%(pc1) = 1 Then fighterfreeze (pc1)
                nee1y(pc1) = 0
                nee2y(pc1) = 0

                If pticker%(pc1) > 15 Then
                    position%(pc1) = 1
                End If


                '------------------------------------------------------------------ Upper Cut
            Case Is = 13
                If pticker%(pc1) = 1 Then sbfx 4
                fighterfreeze (pc1)

                elbow2x(pc1) = 3
                elbow2y(pc1) = -5
                hand2x(pc1) = 0
                hand2y(pc1) = -4

                elbow1x(pc1) = -3
                elbow1y(pc1) = 5
                hand1x(pc1) = 0
                hand1y(pc1) = 4

                headx(pc1) = 0
                necky(pc1) = -10
                neckx(pc1) = 1

                If legs%(pc1) <> 666 Then
                    nee1x(pc1) = 5
                    nee2x(pc1) = -1
                    foot1x(pc1) = -1
                    foot2x(pc1) = -3
                End If

                nee1y(pc1) = 8
                nee2y(pc1) = 8
                foot1y(pc1) = 7
                foot2y(pc1) = 7

                'Detect Hit
                If pticker%(pc1) = 2 Then


                    If hand2x(pc2) > m1x - 5 And hand2x(pc2) < m2x + 5 And hand2y(pc2) > h1y - 10 And hand2y(pc2) < l2y Then
                        soundticker% = 0: sbfx 11
                        If razers%(pc1) > 0 Then n% = 10: bgcolor% = 12: soundticker% = 0: sbfx 17
                        health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 3)
                        If health%(po1) <= 0 Then decap (po1)

                        If position%(po1) <> 99 Then
                            butth(po1) = d%(pc1) / 2
                            ko(po1) = ko(po1) - akpow%(pc1) * 3
                            necky(po1) = necky(po1) + 1
                            buttv(po1) = -(ahpow%(pc1) * 3) - 5
                            position%(po1) = 10
                            For wee = 1 To 50 Step 5: particle (hand2x(pc2) + ((Rnd - .5) * 5)), (butty(pc1) - wee), (fighterz(pc1)), 2, 1: Next wee
                        Else
                            particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 3
                        End If
                    End If

                End If


                If pticker%(pc1) > 9 Then
                    position%(pc1) = 1
                    elbow2v(pc1) = 2
                End If


                '---------------------------------------------------------------- In-Air Kick
            Case Is = 14

                If pticker%(pc1) = 1 Then
                    sbfx 3
                    fighterfreeze (pc1)
                    neckx(pc1) = -5

                    nee1x(pc1) = -5
                    foot1x(pc1) = 5
                    nee1y(pc1) = 1
                    foot1y(pc1) = 1

                    elbow1x(pc1) = -4
                    elbow1y(pc1) = 2
                    hand1x(pc1) = 3
                    hand1y(pc1) = 1

                    elbow2x(pc1) = 4
                    elbow2y(pc1) = 2

                    nee2h(pc1) = 2
                    nee2v(pc1) = -2
                    foot2h(pc1) = -1
                    foot2v(pc1) = -2
                End If

                If pticker%(pc1) = 3 Then
                    fighterfreeze (pc1)

                    hand2y(pc1) = hand2y(pc1) + 2
                    elbow2y(pc1) = elbow2y(pc1) + 2
                    nee2x(pc1) = 5
                    nee2y(pc1) = 0
                    foot2x(pc1) = 5
                    foot2y(pc1) = 0
                End If


                If pticker%(pc1) > 3 And nee2x(pc2) > l1x - 5 And nee2x(pc2) < l2x + 5 And foot2y(pc2) > h1y And foot2y(pc2) < l2y Then
                    soundticker% = 0: sbfx 10
                    health%(po1) = health%(po1) - lhpow%(pc1) * 3
                    ko(po1) = ko(po1) - lkpow%(pc1) * 2
                    particle (nee2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 1, 5
                    combol%(pc1) = 30
                End If


                If pticker%(pc1) = 5 Then
                    fighterfreeze (pc1)

                    neckh(pc1) = 1

                    nee1h(pc1) = 1
                    nee1v(pc1) = 1
                    foot1h(pc1) = -2
                    foot1v(pc1) = 1

                    nee2v(pc1) = 1
                    foot2h(pc1) = -2
                    foot2v(pc1) = 1
                    position%(pc1) = 1
                End If

                '--------------------------------------------------------------- Delayed Fall
            Case Is = 15
                fighterfreeze (pc1)
                If pticker%(pc1) > sdelay%(pc1) * 2 Then position%(pc1) = 8: buttv(pc1) = buttv(pc1) + 3






                'SPECIALS ========================================================== SPECIALS`


                '-------------------------------------------------------------- One Fire Ball
            Case Is = 30
                fighterfreeze (pc1)
                If neckx(pc1) > 2 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If necky(pc1) > -7 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If hand1x(pc1) > -1 Then hand1h(pc1) = -.2 Else hand1h(pc1) = .2
                If hand2x(pc1) > 1 Then hand2h(pc1) = -.2 Else hand2h(pc1) = .2
                If hand1y(pc1) > 2 Then hand1v(pc1) = -.2 Else hand1v(pc1) = .2
                If hand2y(pc1) > 3 Then hand2v(pc1) = -.2 Else hand2v(pc1) = .2
                If elbow2x(pc1) > -5 Then elbow2h(pc1) = -.2 Else elbow2h(pc1) = .2

                If pticker%(pc1) > 3 Then
                    soundticker% = 0: sbfx 4
                    If ko(pc1) > 5 Then
                        ko(pc1) = ko(pc1) - 3
                        If pc1 = 2 Then n% = 3
                        projectile%(1 + n%) = 25
                        projectilex(1 + n%) = hand1x(pc2)
                        projectiley(1 + n%) = necky(pc2)
                        projectileh(1 + n%) = d%(pc1) * 10
                        projectilev(1 + n%) = 0
                        projectilet%(1 + n%) = 2

                        position%(pc1) = 1
                        neckx(pc1) = 5
                        necky(pc1) = -6

                        elbow1x(pc1) = 5
                        hand1x(pc1) = 4
                        elbow1y(pc1) = 0
                        hand1y(pc1) = 0

                        butth(pc1) = butth(pc1) - (d%(pc1) / 2)
                    Else
                        position%(pc1) = 1
                        particle (hand1x(pc2)), (hand1y(pc2)), fighterz(pc1), 15, 20
                    End If
                End If


                x = (hand1x(pc2) + hand2x(pc2)) / 2
                y = (hand1y(pc2) + hand2y(pc2)) / 2

                pscircle (x), (y), (fighterz(pc1)), 1, flash3%
                psline (x), (y), (fighterz(pc1)), (x + ((Rnd - .5) * 75)), (y + ((Rnd - .5) * 75)), (fighterz(pc1)), 12, 0


                '------------------------------------------------------------------ Power Jab
            Case Is = 31

                'Draw Back
                If pticker%(pc1) < 6 Then
                    elbow1h(pc1) = -1
                    elbow1v(pc1) = -.5
                    hand1x(pc1) = 1
                    hand1y(pc1) = -1
                End If

                'Jab
                If pticker%(pc1) = 6 Then
                    If ko(pc1) > 10 Then
                        ko(pc1) = ko(pc1) - 5
                        fighterfreeze (pc1)
                        elbow1x(pc1) = 3
                        elbow1y(pc1) = 4
                        hand1x(pc1) = 3
                        hand1y(pc1) = -2
                        neckx(pc1) = 4
                        necky(pc1) = -7
                        neckv(pc1) = -.2
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                'Detect hit
                If pticker%(pc1) = 7 Then
                    fighterfreeze (pc1)

                    If hand1x(pc2) > m1x - 4 And hand1x(pc2) < m2x + 4 And hand1y(pc2) > h1y And hand1y(pc2) < l2y Then
                        If razers%(pc1) > 0 Then
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 2, 10
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 10
                            n% = 10
                            bgcolor% = 15
                            soundticker% = 0: sbfx 17
                        Else
                            bgcolor% = 4
                            soundticker% = 0: sbfx 11
                        End If

                        If position%(po1) <> 99 Then
                            health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 2)
                            ko(po1) = ko(po1) - akpow%(pc1) * 3
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 9, 10
                            position%(po1) = 1
                        Else
                            ko(po1) = ko(po1) - akpow%(pc1)
                        End If
                        particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 1, 10

                        heady(po1) = heady(po1) + 1
                        butty(po1) = butty(po1) - 10
                    End If
                End If

                'Return Position
                If pticker%(pc1) = 8 Then
                    position%(pc1) = 1
                    elbow1h(pc1) = -1
                    hand1v(pc1) = 1
                End If


                'Effects
                If pticker%(pc1) > 6 Then
                    psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 5), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 3), (fighterz(pc1)), (15), 3
                End If




                '------------------------------------------------------------------- Neck Jab
            Case Is = 32

                'Draw Back
                If pticker%(pc1) < 6 Then
                    elbow1h(pc1) = -1
                    elbow1v(pc1) = -.5
                    hand1x(pc1) = 1
                    hand1y(pc1) = -1
                End If

                'Jab
                If pticker%(pc1) = 6 Then
                    If ko(pc1) > 10 And neckx(pc2) > m1x - 10 And neckx(pc2) < m2x + 10 And necky(pc2) > h1y - 7 Then
                        If buttx(pc1) > buttx(po1) Then d%(pc1) = -1 Else d%(pc1) = 1
                        ko(pc1) = ko(pc1) - 5
                        fighterfreeze (pc1)
                        hand1x(pc1) = (neckx(po2) - neckx(pc2)) / (2 * d%(pc1))
                        elbow1x(pc1) = (neckx(po2) - neckx(pc2)) / (2 * d%(pc1))
                        hand1y(pc1) = -1
                        elbow1y(pc1) = -1
                        neckx(pc1) = 4
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                'Detect hit
                If pticker%(pc1) = 7 And position%(po1) <> 99 Then
                    fighterfreeze (pc1)

                    If hand1x(pc2) > m1x - 2 And hand1x(pc2) < m2x + 2 And hand1y(pc2) > h1y - 1 And hand1y(pc2) < h2y + 1 Then
                        If razers%(pc1) > 0 Then
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 2, 10
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 10
                            n% = 10
                            bgcolor% = 15
                            health%(po1) = health%(po1) - 50
                            If health%(po1) < 50 Then decap (po1)
                            If razers%(pc1) > 15 Then razers%(pc1) = 15
                            soundticker% = 0: sbfx 17
                        Else
                            bgcolor% = 4
                            soundticker% = 0: sbfx 1
                        End If

                        ko(po1) = ko(po1) - 10

                        position%(po1) = 15
                        fighterfreeze (po1)
                        particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 9, 10

                    Else
                        position%(pc1) = 1
                    End If

                End If

                'Return Position
                If pticker%(pc1) >= sdelay%(po1) + 5 Then
                    position%(pc1) = 1
                    elbow1h(pc1) = -3
                    elbow1v(pc1) = 2
                End If





                '------------------------------------------------------------- Ball Lightning
            Case Is = 33
                fighterfreeze (pc1)


                If neckx(pc1) > 2 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If necky(pc1) > -7 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If hand1x(pc1) > -1 Then hand1h(pc1) = -.2 Else hand1h(pc1) = .2
                If hand2x(pc1) > 1 Then hand2h(pc1) = -.2 Else hand2h(pc1) = .2
                If hand1y(pc1) > 2 Then hand1v(pc1) = -.2 Else hand1v(pc1) = .2
                If hand2y(pc1) > 3 Then hand2v(pc1) = -.2 Else hand2v(pc1) = .2
                If elbow2x(pc1) > -6 Then elbow2h(pc1) = -.2 Else elbow2h(pc1) = .2

                If pticker%(pc1) > sdelay%(pc1) And projectile%(1 * pc1) = 0 Then
                    If pc1 = 2 Then n% = 3
                    If ko(pc1) > 5 Then
                        soundticker% = 0: sbfx 6
                        ko(pc1) = ko(pc1) - 5
                        projectile%(1 + n%) = 50
                        projectilex(1 + n%) = hand1x(pc2)
                        projectiley(1 + n%) = necky(pc2)
                        projectileh(1 + n%) = d%(pc1) * 10
                        projectilev(1 + n%) = 0
                        projectilet%(1 + n%) = 1

                        position%(pc1) = 1
                        neckx(pc1) = 5
                        necky(pc1) = -6

                        elbow1x(pc1) = 5
                        hand1x(pc1) = 4
                        elbow1y(pc1) = 0
                        hand1y(pc1) = 0

                        elbow2x(pc1) = 5
                        hand2x(pc1) = 4
                        elbow2y(pc1) = 0
                        hand2y(pc1) = 0

                        butth(pc1) = butth(pc1) - d%(pc1)
                        bgcolor% = 1
                    Else
                        position%(pc1) = 1
                        particle (hand1x(pc2)), (hand1y(pc2)), fighterz(pc1), 15, 20
                    End If
                End If


                x = (hand1x(pc2) + hand2x(pc2)) / 2
                y = (hand1y(pc2) + hand2y(pc2)) / 2

                'Effects
                sbfx 13
                psline (x), (y), (fighterz(pc1)), (x - (Rnd * 75)), (y + ((Rnd - .5) * 150)), (fighterz(pc1)), 15, 0
                psline (x), (y), (fighterz(pc1)), (x + (Rnd * 75)), (y + ((Rnd - .5) * 150)), (fighterz(pc1)), 15, 0
                pslightning (x), (y), (fighterz(pc1)), (x - (Rnd * 100)), (y + ((Rnd - .5) * 200)), (fighterz(pc1)), 50, (flash2%)
                pslightning (x), (y), (fighterz(pc1)), (x + (Rnd * 100)), (y + ((Rnd - .5) * 200)), (fighterz(pc1)), 30, (flash2%)
                pscircle (x), (y), (fighterz(pc1)), Rnd * 2, flash2%
                pscircle (x), (y), (fighterz(pc1)), 1, 15


                '------------------------------------------------------------ Triple Sheroken
            Case Is = 34

                If pc1 = 2 Then n% = 3
                For wee = 1 To 3
                    If pc1 = 2 Then n% = 3
                    projectile%(wee + n%) = 15
                    projectilex(wee + n%) = hand1x(pc2)
                    projectiley(wee + n%) = necky(pc2)
                    projectileh(wee + n%) = (d%(pc1) * (8 * (Rnd + 1)))
                    projectilev(wee + n%) = (Rnd - .5) * 20
                    projectilet%(wee + n%) = 4
                Next wee

                position%(pc1) = 1
                soundticker% = 0: sbfx 13
                elbow2x(pc1) = 3
                elbow2y(pc1) = 2



                '------------------------------------------------------------- Two Fire Balls
            Case Is = 35
                fighterfreeze (pc1)
                If neckx(pc1) > 2 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If necky(pc1) > -7 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If hand1x(pc1) > -1 Then hand1h(pc1) = -.2 Else hand1h(pc1) = .2
                If hand2x(pc1) > 1 Then hand2h(pc1) = -.2 Else hand2h(pc1) = .2
                If hand1y(pc1) > 2 Then hand1v(pc1) = -.2 Else hand1v(pc1) = .2
                If hand2y(pc1) > 3 Then hand2v(pc1) = -.2 Else hand2v(pc1) = .2
                If elbow2x(pc1) > -5 Then elbow2h(pc1) = -.2 Else elbow2h(pc1) = .2

                If pticker%(pc1) > 3 Then
                    soundticker% = 0: sbfx 4
                    If pc1 = 2 Then n% = 3
                    For wee = 2 To 3
                        projectile%(wee + n%) = 25
                        projectilex(wee + n%) = hand1x(pc2)
                        projectiley(wee + n%) = necky(pc2)
                        projectilev(wee + n%) = (Rnd - .5) * 10
                        projectileh(wee + n%) = (d%(pc1) * 10)
                        projectilet%(wee + n%) = 3
                    Next wee

                    position%(pc1) = 1
                    neckx(pc1) = 5
                    necky(pc1) = -6

                    elbow1x(pc1) = 5
                    hand1x(pc1) = 4
                    elbow1y(pc1) = 0
                    hand1y(pc1) = 0

                    elbow2x(pc1) = 5
                    hand2x(pc1) = 4
                    elbow2y(pc1) = 0
                    hand2y(pc1) = 0

                    butth(pc1) = butth(pc1) - (d%(pc1) / 2)
                End If


                x = (hand1x(pc2) + hand2x(pc2)) / 2
                y = (hand1y(pc2) + hand2y(pc2)) / 2

                pscircle (x), (y), (fighterz(pc1)), 1, flash3%
                psline (x), (y), (fighterz(pc1)), (x + ((Rnd - .5) * 75)), (y + ((Rnd - .5) * 75)), (fighterz(pc1)), 12, 0


                '--------------------------------------------------------------- Hammer Punch
            Case Is = 36

                'Draw Up
                If pticker%(pc1) < 8 Then
                    elbow2h(pc1) = 0
                    elbow2v(pc1) = -1.5
                    hand2x(pc1) = 3
                    hand2y(pc1) = -2
                    neckh(pc1) = -.3
                End If

                'Hammer
                If pticker%(pc1) = 8 Then
                    If ko(pc1) > 10 Then
                        If body%(pc1) = 666 Then rage(pc1) = 0
                        ko(pc1) = ko(pc1) - 5
                        fighterfreeze (pc1)
                        elbow2x(pc1) = 3
                        elbow2y(pc1) = 5
                        hand2x(pc1) = 4
                        hand2y(pc1) = 0
                        neckx(pc1) = 4
                        necky(pc1) = -7
                        neckv(pc1) = -.2
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                'Detect hit
                If pticker%(pc1) = 9 Then
                    fighterfreeze (pc1)

                    If hand2x(pc2) > m1x - 4 And hand2x(pc2) < m2x + 4 And hand2y(pc2) > h1y And hand2y(pc2) < l2y Then
                        If razers%(pc1) > 0 Then
                            n% = 10
                            bgcolor% = 15
                        Else
                            bgcolor% = 4
                        End If
                        If position%(po1) <> 99 Then health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 3)
                        ko(po1) = ko(po1) - akpow%(pc1) * 2

                        buttv(po1) = 2
                        neckh(po1) = -d%(pc1)
                        necky(po1) = necky(po1) + 3
                        heady(po1) = 4
                        position%(po1) = 8
                        If body%(pc1) = 666 Then particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 21, 5: health%(po1) = health%(po1) - 50
                        particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 5
                        particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 5
                        particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 9, 5
                    End If
                End If

                'Return Position
                If pticker%(pc1) = 10 Then
                    position%(pc1) = 1
                    elbow2h(pc1) = -1
                    hand2v(pc1) = 1
                End If


                'Effects
                If pticker%(pc1) > 8 Then
                    psline (neckx(pc2) + (7 * d%(pc1))), (necky(pc2) + 5), (fighterz(pc1)), (neckx(pc2) + (4 * d%(pc1))), (necky(pc2) - 7), (fighterz(pc1)), (15), 3
                    psline (neckx(pc2) + (5 * d%(pc1))), (necky(pc2) - 3), (fighterz(pc1)), (neckx(pc2) - (4 * d%(pc1))), (necky(pc2) - 10), (fighterz(pc1)), (15), 3
                End If

                '---------------------------------------------------------------- Thrust Slam
            Case Is = 37

                'Draw Back
                If pticker%(pc1) < 6 Then
                    elbow1h(pc1) = -1
                    elbow1v(pc1) = -.5
                    hand1x(pc1) = 1
                    hand1y(pc1) = -1
                End If

                'Jab
                If pticker%(pc1) = 6 Then
                    If ko(pc1) > 10 Then
                        ko(pc1) = ko(pc1) - 5
                        fighterfreeze (pc1)
                        elbow1x(pc1) = 3
                        elbow1y(pc1) = 6
                        hand1x(pc1) = 4
                        hand1y(pc1) = 0
                        neckx(pc1) = 4
                        necky(pc1) = -7
                        neckv(pc1) = -.2
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                elbow2x(pc1) = elbow1x(pc1)
                elbow2y(pc1) = elbow1y(pc1) - 4
                hand2x(pc1) = hand1x(pc1)
                hand2y(pc1) = hand1y(pc1)


                'Detect hit
                If pticker%(pc1) = 7 Then
                    fighterfreeze (pc1)

                    If hand1x(pc2) > m1x - 4 And hand1x(pc2) < m2x + 4 And hand1y(pc2) > h1y And hand1y(pc2) < l2y Then
                        If razers%(pc1) > 0 Then
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 23, 20
                            health%(po1) = health%(po1) - 25
                            bgcolor% = 15
                            soundticker% = 0: sbfx 17
                        Else
                            bgcolor% = 1
                            sbfx 11
                        End If

                        If position%(po1) <> 99 Then
                            ko(po1) = ko(po1) - akpow%(pc1) * 3
                            canjump%(po1) = 0
                            butth(po1) = d%(pc1) * (akpow%(pc1) * 2)
                            position%(po1) = 15
                        Else
                            canjump%(pc1) = 0
                            butth(pc1) = -d%(pc1) * (akpow%(pc1) * 1.5)
                            position%(pc1) = 1
                        End If

                        particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 22, 10
                    End If
                End If

                'Return Position
                If pticker%(pc1) >= 12 Then
                    position%(pc1) = 1
                    elbow1h(pc1) = -1
                    hand1v(pc1) = 1
                End If


                'Effects
                If pticker%(pc1) > 6 And pticker%(pc1) < 8 Then
                    psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 2), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 3), (fighterz(pc1)), (15), 3
                    psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 7), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 6), (fighterz(pc1)), (15), 3
                End If






                '-------------------------------------------------------------- Rising Dragon
            Case Is = 38
                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    neckx(pc1) = 5
                    necky(pc1) = -5
                    elbow2x(pc1) = 1

                    elbow1x(pc1) = -3
                    elbow1y(pc1) = 5
                    hand1x(pc1) = 0
                    hand1y(pc1) = 4

                    nee1x(pc1) = 4
                    foot1x(pc1) = -1
                    nee1y(pc1) = 1
                    foot1y(pc1) = 7
                    nee1v(pc1) = -.5
                End If


                If pticker%(pc1) > 1 And buttv(pc1) <= 0 Then

                    If neckx(pc1) > 0 Then neckh(pc1) = -2 Else neckx(pc1) = 0: neckh(pc1) = 0
                    nee2x(pc1) = 0
                    foot2x(pc1) = -1
                    nee2y(pc1) = 8
                    foot2y(pc1) = 7

                    headx(pc1) = 0
                    elbow2x(pc1) = 3
                    hand2x(pc1) = 0
                    hand2y(pc1) = -3
                    If elbow2y(pc1) > -5 Then elbow2v(pc1) = -2 Else elbow2v(pc1) = 0
                    butth(pc1) = butth(pc1) / 1.5
                End If

                If pticker%(pc1) = 4 Then
                    canjump%(pc1) = 1
                    jump (pc1), (1)
                    butth(pc1) = d%(pc1) * 5
                End If

                'Detect Hit(s)
                If pticker%(pc1) = 4 Or pticker%(pc1) = 7 Or pticker%(pc1) = 9 Or pticker%(pc1) = 12 Or pticker%(pc1) = 15 Then

                    If ko(pc1) < 5 Then
                        fall (pc1)
                        butth(pc1) = 0
                        buttv(pc1) = 0
                    Else
                        ko(pc1) = ko(pc1) - 1
                        If hand2x(pc2) > m1x - 7 And hand2x(pc2) < m2x + 7 And hand2y(pc2) > h1y - 10 And hand2y(pc2) < l2y + 10 Then

                            If position%(po1) = 99 Then
                                pticker%(po1) = 1
                            Else
                                soundticker% = 0: sbfx 11
                                If razers%(pc1) > 0 Then n% = 10: bgcolor% = 4: particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 21, 15: soundticker% = 0: sbfx 17
                                health%(po1) = health%(po1) - (ahpow%(pc1) + n%)
                                position%(po1) = 10
                                particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 2, 5
                                ko(po1) = ko(po1) - (akpow%(pc1) * 2)
                            End If


                            If health%(po1) <= 0 Then decap (po1)
                            butth(pc1) = d%(pc1) / 3
                            buttv(po1) = buttv(pc1) - 1
                            particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 5
                            If pticker%(pc1) = 15 Then If position%(po1) <> 99 Then fall (po1) Else butth(po1) = butth(po1) - d%(po1)
                        End If
                    End If
                End If

                'Effects
                particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 19, 1
                psline (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), (hand2x(pc2) - (butth(pc1) * 5)), (hand2y(pc2) - (buttv(pc1) * 5)), (fighterz(pc1)), flash1%, 0

                'Return Position
                If pticker%(pc1) >= 15 Then
                    position%(pc1) = 1
                    nee1v(pc1) = 2
                End If


                '--------------------------------------------------------------- Stun Knuckle
            Case Is = 39

                'Draw Back
                If pticker%(pc1) < 6 Then
                    elbow1h(pc1) = -1
                    elbow1v(pc1) = -.5
                    hand1x(pc1) = 1
                    hand1y(pc1) = -1
                End If

                'Stun Knuckle
                If pticker%(pc1) = 6 Then
                    If ko(pc1) > 6 Then
                        ko(pc1) = ko(pc1) - 4
                        fighterfreeze (pc1)
                        hand1x(pc1) = 4
                        elbow1x(pc1) = 4
                        hand1y(pc1) = 1
                        elbow1y(pc1) = -1
                        neckx(pc1) = 4
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                'Detect hit
                If pticker%(pc1) = 7 Then
                    fighterfreeze (pc1)

                    If hand1x(pc2) > m1x - 2 And hand1x(pc2) < m2x + 2 And hand1y(pc2) > h1y - 4 And hand1y(pc2) < l2y Then
                        If razers%(pc1) > 0 Then
                            n% = 10
                            bgcolor% = 12
                            health%(po1) = health%(po1) - (ahpow%(pc1) * 5)
                        Else
                            bgcolor% = 4
                        End If

                        If position%(po1) <> 99 Then
                            ko(po1) = ko(po1) - (akpow%(pc1) * 4)
                            position%(po1) = 15
                            fighterfreeze (po1)
                            particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 6, 10
                            sbfx 8
                        Else
                            bgcolor% = 0
                        End If
                    Else
                        position%(pc1) = 1
                    End If

                End If

                'Return Position
                If pticker%(pc1) >= 8 Then
                    position%(pc1) = 1
                    elbow1x(pc1) = 2
                End If

                'Effects
                If pticker%(pc1) > 4 Then
                    pscircle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .1), 2, flash1%
                    pscircle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .1), 1, flash2%
                End If


                '----------------------------------------------------------------- Plant Kick
            Case Is = 40

                If pticker%(pc1) = 1 Then
                    If canjump%(pc1) = 1 Then
                        fighterfreeze (pc1)
                        nee1y(pc1) = -2
                        nee2y(pc1) = 0
                        hand2h(pc1) = -1
                        hand2v(pc1) = 1
                    Else
                        position%(pc1) = 1
                    End If
                End If


                If pticker%(pc1) = 4 Then
                    If ko(pc1) > 10 Then
                        ko(pc1) = ko(pc1) - 10
                        sbfx 4
                    Else
                        fighterfreeze (pc1)
                        position%(pc1) = 1
                    End If
                End If

                If pticker%(pc1) > 3 Then
                    psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((Rnd - .5) * 5)), (butty(pc1) + Rnd * 5), (fighterz(pc1)), (flash1%), 0
                    psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((Rnd - .5) * 5)), (butty(pc1) + Rnd * 5), (fighterz(pc1)), (flash2%), 0
                End If


                If pticker%(pc1) = 5 Then

                    If buttx(pc1) > buttx(po1) Then d%(pc1) = -1 Else d%(pc1) = 1
                    fighterfreeze (pc1)

                    headx(pc1) = headx(pc1) - 2

                    If foot1y(pc1) > foot2y(pc1) Then elbow2y(pc1) = foot1y(pc1) / 2 Else elbow2y(pc1) = foot2y(pc1) / 2
                    hand2y(pc1) = elbow2y(pc1) + 1

                    elbow1x(pc1) = 1
                    elbow1y(pc1) = -6
                    hand1x(pc1) = 5
                    hand1y(pc1) = -2

                    elbow2x(pc1) = -3
                    hand2x(pc1) = -2

                    buttx(pc1) = buttx(pc1) + 7 * d%(pc1)
                    butty(pc1) = butty(pc1) - (elbow2y(pc1) * 2)
                    neckx(pc1) = -7
                    necky(pc1) = 7

                    nee1x(pc1) = 5
                    nee1y(pc1) = -7
                    foot1x(pc1) = 5
                    foot1y(pc1) = -6

                    nee2x(pc1) = 0
                    nee2y(pc1) = 5
                    foot2x(pc1) = 5
                    foot2y(pc1) = -6
                End If

                'Detect Hit
                If pticker%(pc1) = 6 And buttx(pc1) > neckx(po2) - 13 And buttx(pc1) < neckx(po2) + 13 And heady(po2) - 4 < foot2y(pc2) And foot2y(pc2) < l2y Then
                    If position%(po1) <> 99 Then
                        soundticker% = 0: sbfx 11
                        health%(po1) = health%(po1) - lhpow%(pc1) * 2
                        ko(po1) = ko(po1) - lkpow%(pc1) * 7
                        particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 1, 5
                        fall (po1)
                    End If
                    buttv(po1) = -10
                    butth(po1) = (1 + lhpow%(pc1) * d%(pc1))
                    particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 5, 8
                End If


                'return position
                If pticker%(pc1) >= 12 Then
                    position%(pc1) = 1
                    nee2y(pc1) = hand2y(pc1)
                    foot2y(pc1) = hand2y(pc1)
                    foot2h(pc1) = -2
                    neckh(pc1) = 2
                    neckv(pc1) = -3
                    elbow1h(pc1) = -1
                    elbow1v(pc1) = 1
                    nee1v(pc1) = 1
                    foot1h(pc1) = -2
                    foot1v(pc1) = 2
                    hand2h(pc1) = .5
                End If


                'Zero G
                If pticker%(pc1) > 4 Then buttv(pc1) = -gravity





                '------------------------------------------------------------------- Axe Kick
            Case Is = 41

                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    If ko(pc1) > 10 And canjump%(pc1) = 1 Then
                        ko(pc1) = ko(pc1) - 5
                        butth(pc1) = d%(pc1)
                        sbfx 2
                        neckh(pc1) = -1
                    Else
                        position%(pc1) = 1
                    End If
                End If


                Select Case pticker%(pc1)

                    Case 2
                        sbfx 2
                        nee2x(pc1) = 1
                        foot2x(pc1) = -1
                        neckx(pc1) = -1
                        foot1v(pc1) = 3

                        nee1x(pc1) = 3
                        nee1y(pc1) = -6
                        foot1x(pc1) = 3
                        foot1y(pc1) = -6

                    Case 4
                        neckh(pc1) = 0
                        nee1x(pc1) = 6
                        nee1y(pc1) = -1
                        foot1x(pc1) = 6
                        foot1y(pc1) = -1

                    Case 6
                        foot1v(pc1) = 0
                        nee1x(pc1) = 5
                        nee1y(pc1) = 5
                        foot1x(pc1) = 5
                        foot1y(pc1) = 5
                End Select


                'Detect Hit
                If pticker%(pc1) > 2 And pticker%(pc1) < 7 Then
                    If foot1x(pc2) > l1x And foot1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                        soundticker% = 0: sbfx 11
                        health%(po1) = health%(po1) - lhpow%(pc1)
                        ko(po1) = ko(po1) - lkpow%(pc1)
                        particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 1, 5
                        butth(po1) = butth(pc1)
                        position%(po1) = 1
                    End If
                End If



                'Return Position
                If pticker%(pc1) = 7 Then
                    foot1x(pc1) = -1
                    position%(pc1) = 1
                End If

                'Effects
                particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 19, 1


                '---------------------------------------------------------- Stunning Gut Stab
            Case Is = 42

                If pticker%(pc1) = 1 Then
                    d%(pc1) = -d%(pc1)
                    sbfx 3
                    If ko(pc1) > 10 Then
                        ko(pc1) = ko(pc1) - 5
                    Else
                        position%(pc1) = 1
                    End If
                End If

                If pticker%(pc1) > 1 And pticker%(pc1) < 8 Then
                    nee1x(pc1) = -6
                    nee1y(pc1) = -1
                    foot1x(pc1) = -6
                    foot1y(pc1) = -1
                    nee2x(pc1) = 0
                    foot2x(pc1) = 0
                End If

                If foot1x(pc2) > l1x And foot1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                    sbfx 11
                    health%(po1) = health%(po1) - 1
                    ko(po1) = ko(po1) - 1
                    If buttx(pc1) < buttx(po1) Then particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 4, 3 Else particle (foot1x(pc2) - 5), (foot1y(pc2)), (fighterz(pc1)), 3, 3
                    position%(po1) = 15
                End If


                If pticker%(pc1) = 8 Then
                    nee1h(pc1) = 1
                    nee1v(pc1) = .5
                    neckx(pc1) = .5

                End If


                'Return Position
                If pticker%(pc1) = 15 Then
                    d%(pc1) = -d%(pc1)
                    position%(pc1) = 1
                    sbfx 1
                End If

                '---------------------------------------------------------- Thrust Roundhouse
            Case Is = 43

                'Draw Back
                If pticker%(pc1) = 1 Then

                    fighterfreeze (pc1)
                    combo%(pc1) = 0

                    If ko(pc1) > 10 Then
                        butth(pc1) = butth(pc1) + (d%(pc1) * 3)
                        buttv(pc1) = buttv(pc1) - 1.5
                    End If

                    elbow1y(pc1) = elbow1y(pc1) - 4
                    elbow2y(pc1) = elbow2y(pc1) - 4

                    neckx(pc1) = 5
                    necky(pc1) = -5
                    buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

                    nee1x(pc1) = 5
                    nee1y(pc1) = 4
                    foot1x(pc1) = -4
                    foot1y(pc1) = 3

                End If


                'Begin Kick
                If pticker%(pc1) = 5 Then

                    If ko(pc1) > 10 Then
                        ko(pc1) = ko(pc1) - 6
                        nee2h(pc1) = 2
                        nee2v(pc1) = -2
                        foot2h(pc1) = -1
                        foot2v(pc1) = -1
                    Else
                        position%(pc1) = 1
                    End If
                End If

                If pticker%(pc1) = 8 Then
                    fighterfreeze (pc1)

                    elbow1x(pc1) = elbow1x(pc1) + 2

                    hand2y(pc1) = hand2y(pc1) + 2
                    elbow2y(pc1) = elbow2y(pc1) + 2

                    nee2x(pc1) = 6
                    nee2y(pc1) = 1

                    foot2x(pc1) = 5
                    foot2y(pc1) = 1
                End If

                'Detect Hit
                If pticker%(pc1) > 7 And combo%(pc1) = 0 And foot2x(pc2) > l1x And foot2x(pc2) < l2x And foot2y(pc2) > h1y And foot2y(pc2) < l2y Then
                    health%(po1) = health%(po1) - lhpow%(pc1) * 3
                    ko(po1) = ko(po1) - lkpow%(pc1) * 4
                    particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 3, 5
                    particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 4, 5
                    soundticker% = 0: sbfx 11
                    butth(po1) = butth(pc1) / 2
                    fall po1
                End If

                If pticker%(pc1) > 9 Then
                    fighterfreeze (pc1)

                    nee2h(pc1) = -1
                    nee2v(pc1) = 1
                    foot2h(pc1) = -2
                    foot2v(pc1) = 1

                    position%(pc1) = 1
                End If


                'Zero G
                buttv(pc1) = buttv(pc1) - gravity


                'Effects
                particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 19, 1


                '------------------------------------------------------------- Slasher Strike
            Case Is = 44

                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    neckx(pc1) = 0
                    neckh(pc1) = -.5
                    buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

                    nee1x(pc1) = 0
                    foot1x(pc1) = 0

                    If foot1y(pc1) < 1 Or nee1y(pc1) > 3 Then
                        nee1y(pc1) = 8
                        foot1y(pc1) = 7
                    End If

                    elbow1h(pc1) = -.5
                    elbow2h(pc1) = .5
                    elbow2v(pc1) = -.5
                End If


                If pticker%(pc1) = 5 Then
                    If ko(pc1) > 20 Then
                        ko(pc1) = ko(pc1) - 15
                        nee2h(pc1) = 2
                        nee2v(pc1) = -2
                        foot2h(pc1) = -1
                        foot2v(pc1) = -1
                    Else
                        position%(pc1) = 10
                    End If
                End If



                If pticker%(pc1) = 8 Then
                    sbfx 4
                    fighterfreeze (pc1)

                    elbow1x(pc1) = elbow1x(pc1) + 2
                    elbow1y(pc1) = elbow1y(pc1) - 2

                    hand2y(pc1) = hand2y(pc1) + 2
                    elbow2y(pc1) = elbow2y(pc1) + 2

                    nee2x(pc1) = 5
                    nee2y(pc1) = 0


                    foot2x(pc1) = 5
                    foot2y(pc1) = 0
                End If

                'Slash Effect
                If pticker%(pc1) > 8 Then
                    psline (foot2x(pc2) - 15), (foot2y(pc2)), (fighterz(pc1)), (foot2x(pc2) + 15), (foot2y(pc2)), (fighterz(pc1)), (flash2%), 0
                End If


                'Detect Hit
                If pticker%(pc1) = 9 And foot2x(pc2) > l1x - 10 And foot2x(pc2) < l2x + 10 And foot2y(pc2) > h1y And foot2y(pc2) < l2y Then
                    psline (buttx(po1) - 100), (foot2y(pc2)), (fighterz(pc1)), (buttx(po1) + 100), (foot2y(pc2)), (fighterz(pc1)), (15), 0
                    health%(po1) = health%(po1) - lhpow%(pc1) * 4
                    soundticker% = 0: sbfx 17
                    ko(po1) = ko(po1) - lkpow%(pc1) * 4
                    particle (buttx(po1)), (foot2y(pc2)), (fighterz(pc1)), 21, 10
                    position%(po1) = 15
                End If


                If pticker%(pc1) > 9 Then
                    fighterfreeze (pc1)

                    neckh(pc1) = .5
                    nee2h(pc1) = -1
                    nee2v(pc1) = 1
                    foot2h(pc1) = -2
                    foot2v(pc1) = 1

                    position%(pc1) = 1
                End If

                'Effects
                psline (foot2x(pc2) - 1), (foot2y(pc2)), (fighterz(pc1) - .1), (foot2x(pc2) + 1), (foot2y(pc2)), (fighterz(pc1) - .1), (flash2%), 0



                '------------------------------------------------------------------- Nee Bash
            Case Is = 45

                'Attempt head grab
                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    elbow1x(pc1) = 3
                    elbow1y(pc1) = -1
                    hand1x(pc1) = 3
                    hand1y(pc1) = -2
                End If

                'Detect head grab
                If pticker%(pc1) = 2 Then
                    If position%(po1) <> 99 And ko(pc1) > 15 And hand1x(pc2) > h1x And hand1x(pc2) < h2x And hand1y(pc2) > h1y And hand1y(pc2) < h2y Then
                        sbfx 13
                        ko(pc1) = ko(pc1) - 10
                        combol%(pc1) = sdelay%(po1) * 3
                        fighterfreeze (po1)
                    Else
                        position%(pc1) = 1
                    End If
                End If


                'Bashing
                If pticker%(pc1) > 2 Then
                    position%(po1) = 1
                    elbow1v(pc1) = -.6
                    hand1v(pc1) = -.8

                    'hit
                    If elbow1y(pc1) < -2 Then
                        elbow1y(pc1) = 4: hand1y(pc1) = 5
                        health%(po1) = health%(po1) - ahpow%(pc1)
                        ko(po1) = ko(po1) - akpow%(pc1)
                        health%(po1) = health%(po1) - lhpow%(pc1)
                        ko(po1) = ko(po1) - lkpow%(pc1)
                        soundticker% = 0: sbfx 9
                        If buttx(pc1) < buttx(po1) Then particle (hand1x(pc2)), (butty(pc1)), (fighterz(po1)), 3, 3 Else particle (hand1x(pc2)), (butty(pc1)), (fighterz(po1)), 4, 3
                    End If

                    elbow2y(pc1) = 3 - elbow1y(pc1) / 2
                    necky(pc1) = -10 + elbow1y(pc1) / 5
                    nee2x(pc1) = elbow1y(pc1) + 2
                    nee2y(pc1) = -elbow1y(pc1)
                    neckx(po1) = nee2x(pc1)
                    necky(po1) = -7 + elbow1y(pc1) + hand1y(pc1)


                    'Return position
                    If combol%(pc1) <= 0 Then
                        position%(pc1) = 1
                        butth(pc1) = -d%(pc1)
                        elbow1h(pc1) = -.5
                        elbow1y(pc1) = .5
                    End If
                End If



                '------------------------------------------------------- Lightning Kick Blast
            Case Is = 46

                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                End If

                If pticker%(pc1) < 10 Then
                    sbfx 16
                    neckx(pc1) = -3 - Rnd
                    necky(pc1) = -7 + Rnd

                    r1 = (Rnd * 3) + 2
                    r2 = (Rnd - .5) * 15
                    nee1x(pc1) = r1
                    nee1y(pc1) = r2
                    foot1x(pc1) = r1
                    foot1y(pc1) = r2

                    'Detect Hit(s)
                    If foot1x(pc2) > l1x And foot1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                        ko(po1) = ko(po1) - lkpow%(pc1)
                        position%(po1) = 1
                        particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 9, 5
                    End If
                End If



                If pticker%(pc1) = 10 Then
                    soundticker% = 0: sbfx 11
                    d%(pc1) = -d%(pc1)
                    neckx(pc1) = 5
                    necky(pc1) = -2
                    nee1x(pc1) = -6
                    nee1y(pc1) = 0
                    foot1x(pc1) = -6
                    foot1y(pc1) = 0
                End If

                'Detect Blast
                If pticker%(pc1) = 11 And foot1x(pc2) > l1x And foot1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                    health%(po1) = health%(po1) - lhpow%(pc1) * 5
                    ko(po1) = ko(po1) - lkpow%(pc1) * 2
                    particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 1, 5
                    butth(po1) = (lkpow%(pc1) * -d%(pc1))
                    neckx(po1) = 5
                    necky(po1) = -5
                    nee1x(po1) = 5
                    foot1x(po1) = 5
                    fall (po1)
                End If


                'Effects
                If pticker%(pc1) > 9 Then
                    psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((Rnd - .5) * 5)), (butty(pc1) + (Rnd - .5) * 8), (fighterz(pc1)), (flash1%), 0
                    psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((Rnd - .5) * 5)), (butty(pc1) + (Rnd - .5) * 5), (fighterz(pc1)), (flash2%), 0
                End If


                'Return position
                If pticker%(pc1) = 13 Then
                    position%(pc1) = 1
                End If

                '--------------------------------------------------------------------- 6-Slip
            Case Is = 47
                If ko(pc1) < 15 Then position%(pc1) = 1

                If pticker%(pc1) = 1 Then ds%(pc1) = d%(pc1): ds%(po1) = d%(po1)

                If pticker%(pc1) < 5 Then fighterz(pc1) = fighterz(pc1) - .1

                butth(pc1) = d%(pc1) * 2

                If buttx(pc1) > buttx(po1) - 10 And buttx(pc1) < buttx(po1) + 10 And canjump%(po1) = 1 Then
                    d%(po1) = ds%(po1)
                    pticker%(po1) = 0
                End If

                'return position
                If pticker%(pc1) = 8 Then position%(pc1) = 1: d%(pc1) = -ds%(pc1): ko(pc1) = ko(pc1) - 5


                '------------------------------------------------------------------ Skip Kick
            Case Is = 48

                If pticker%(pc1) = 1 Then
                    sbfx 3
                    If ko(pc1) > 10 And canjump%(pc1) = 1 Then
                        ko(pc1) = ko(pc1) - 5
                        buttv(pc1) = -5
                        butth(pc1) = d%(pc1) * 2
                    Else
                        position%(pc1) = 1
                    End If
                End If

                If pticker%(pc1) = 9 Then d%(pc1) = -d%(pc1)

                If pticker%(pc1) > 10 And pticker%(pc1) < 13 Then
                    nee1x(pc1) = -6
                    nee1y(pc1) = -1
                    foot1x(pc1) = -6
                    foot1y(pc1) = -1
                    nee2x(pc1) = 0
                    foot2x(pc1) = 0
                End If

                'Detect Hit
                If pticker%(pc1) > 9 And pticker%(pc1) < 13 Then
                    If foot1x(pc2) > l1x And foot1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                        sbfx 11
                        health%(po1) = health%(po1) - akpow%(pc1) * 3
                        ko(po1) = ko(po1) - lkpow%(pc1) * 3
                        If buttx(pc1) < buttx(po1) Then particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 4, 3 Else particle (foot1x(pc2) - 5), (foot1y(pc2)), (fighterz(pc1)), 3, 3
                        butth(po1) = butth(pc1)
                    End If
                End If

                If pticker%(pc1) = 13 Then
                    nee1h(pc1) = 1
                    nee1v(pc1) = .5
                    neckx(pc1) = .5
                End If


                'Return Position
                If pticker%(pc1) = 18 Then
                    d%(pc1) = -d%(pc1)
                    position%(pc1) = 1
                    sbfx 1
                End If






                '-------------------------------------------------------------- Upper Assault
            Case Is = 49
                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    neckx(pc1) = 5
                    necky(pc1) = -5
                    elbow2x(pc1) = 1

                    elbow1x(pc1) = -3
                    elbow1y(pc1) = 5
                    hand1x(pc1) = 0
                    hand1y(pc1) = 4

                    nee1x(pc1) = 4
                    foot1x(pc1) = -1
                    nee1y(pc1) = 1
                    foot1y(pc1) = 7
                    nee1v(pc1) = -.5

                    nee2x(pc1) = 4
                    nee2v(pc1) = -.5

                End If


                If pticker%(pc1) > 1 And buttv(pc1) <= 0 Then

                    If neckx(pc1) > 0 Then neckh(pc1) = -2 Else neckx(pc1) = 0: neckh(pc1) = 0
                    nee2x(pc1) = 0
                    foot2x(pc1) = -1
                    nee2y(pc1) = 8
                    foot2y(pc1) = 7

                    nee1x(pc1) = 2
                    nee1y(pc1) = -4
                    foot1x(pc1) = 2
                    foot1y(pc1) = -5


                    headx(pc1) = 0
                    elbow1x(pc1) = -1
                    elbow2x(pc1) = -1
                    elbow1y(pc1) = 3
                    elbow2y(pc1) = 3
                    hand1x(pc1) = 2
                    hand2x(pc1) = 2
                    hand1y(pc1) = 3
                    hand2y(pc1) = 3

                    butth(pc1) = butth(pc1) / 1.5
                End If

                If pticker%(pc1) = 4 Then
                    canjump%(pc1) = 1
                    jump (pc1), (1)
                    butth(pc1) = d%(pc1) * 5
                End If


                'Detect Hit(s)
                If pticker%(pc1) = 4 Or pticker%(pc1) = 7 Or pticker%(pc1) = 9 Or pticker%(pc1) = 12 Or pticker%(pc1) = 15 Then

                    If ko(pc1) < 5 Then
                        fall (pc1)
                        butth(pc1) = 0
                        buttv(pc1) = 0
                    Else
                        ko(pc1) = ko(pc1) - 1
                        If foot1x(pc2) > m1x - 7 And foot1x(pc2) < m2x + 7 And foot1y(pc2) > h1y - 10 And foot1y(pc2) < l2y + 10 Then

                            If position%(po1) = 99 Then
                                pticker%(po1) = 1
                            Else
                                soundticker% = 0: sbfx 11
                                position%(po1) = 10
                                particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 2, 5
                                ko(po1) = ko(po1) - (lkpow%(pc1) * 2)
                                health%(po1) = health%(po1) - (lhpow%(pc1) + n%)
                            End If


                            butth(pc1) = d%(pc1) / 3
                            buttv(po1) = buttv(pc1) - 1
                            particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 5
                            If pticker%(pc1) = 15 Then If position%(po1) <> 99 Then fall (po1) Else butth(po1) = butth(po1) - d%(po1)
                        End If
                    End If
                End If

                'Effects
                particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 19, 1
                psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (foot1x(pc2) - (butth(pc1) * 5)), (foot1y(pc2) - (buttv(pc1) * 5)), (fighterz(pc1)), flash1%, 0

                'Return Position
                If pticker%(pc1) = 15 Then
                    position%(pc1) = 1
                    nee1v(pc1) = 2
                End If





                'SUPERS ============================================================== SUPERS`

                '---------------------------------------------------------------- Vex of Evil
            Case Is = 81

                If pticker%(pc1) = 1 Then
                    If canjump%(pc1) = 1 Then
                        fighterfreeze (pc1)

                        hand1h(pc1) = (Rnd - .5) / 10
                        hand1v(pc1) = (Rnd - .5) / 10
                        hand2h(pc1) = (Rnd - .5) / 10
                        hand2v(pc1) = (Rnd - .5) / 10
                        elbow1h(pc1) = (Rnd - .5) / 10
                        elbow1v(pc1) = (Rnd - .5) / 10
                        elbow2h(pc1) = (Rnd - .5) / 10
                        elbow2v(pc1) = (Rnd - .5) / 10
                    Else
                        position%(pc1) = 1
                    End If
                End If

                rage(pc1) = rage(pc1) - 1.5
                If pticker%(pc1) < 40 Then
                    particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 19, 1
                    particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 19, 1
                End If

                If elbow1x(pc1) > 1 Then elbow1h(pc1) = elbow1h(pc1) - .2 Else elbow1h(pc1) = elbow1h(pc1) + .2
                If elbow1y(pc1) > 4 Then elbow1v(pc1) = elbow1v(pc1) - .2 Else elbow1v(pc1) = elbow1v(pc1) + .2
                If elbow2x(pc1) > 1 Then elbow2h(pc1) = elbow2h(pc1) - .2 Else elbow2h(pc1) = elbow2h(pc1) + .2
                If elbow2y(pc1) > 4 Then elbow2v(pc1) = elbow2v(pc1) - .2 Else elbow2v(pc1) = elbow2v(pc1) + .2

                If hand1x(pc1) > 1 Then hand1h(pc1) = hand1h(pc1) - .2 Else hand1h(pc1) = hand1h(pc1) + .2
                If hand1y(pc1) > -2 Then hand1v(pc1) = hand1v(pc1) - .2 Else hand2v(pc1) = hand1v(pc1) + .2
                If hand2x(pc1) > 1 Then hand2h(pc1) = hand2h(pc1) - .2 Else hand2h(pc1) = hand2h(pc1) + .2
                If hand2y(pc1) > -2 Then hand2v(pc1) = hand2v(pc1) - .2 Else hand2v(pc1) = hand2v(pc1) + .2


                'Vex and Return Position
                If pticker%(pc1) >= 75 Then
                    rage(po1) = rage(po1) * .75
                    vexed%(po1) = 1
                    position%(pc1) = 1
                    particle (neckx(po2)), (necky(po2)), fighterz(po1), 26, 25
                End If




                '--------------------------------------------------------------- Energy Blast
            Case Is = 82

                fighterfreeze (pc1)
                If head%(pc1) <> 1998 Then rage(pc1) = 0

                If neckx(pc1) > 2 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If necky(pc1) > -7 Then neckv(pc1) = -.2 Else neckv(pc1) = .2
                If hand1x(pc1) > -1 Then hand1h(pc1) = -.2 Else hand1h(pc1) = .2
                If hand2x(pc1) > 1 Then hand2h(pc1) = -.2 Else hand2h(pc1) = .2
                If hand1y(pc1) > 2 Then hand1v(pc1) = -.2 Else hand1v(pc1) = .2
                If hand2y(pc1) > 3 Then hand2v(pc1) = -.2 Else hand2v(pc1) = .2
                If elbow2x(pc1) > -6 Then elbow2h(pc1) = -.2 Else elbow2h(pc1) = .2

                If pticker%(pc1) > sdelay%(pc1) And projectile%(1 * pc1) = 0 Then
                    If buttx(pc1) > buttx(po1) Then d%(pc1) = -1 Else d%(pc1) = 1
                    If pc1 = 2 Then n% = 3
                    soundticker% = 0: sbfx 8
                    projectile%(1 + n%) = 50
                    projectilex(1 + n%) = hand1x(pc2)
                    projectiley(1 + n%) = necky(pc2)
                    projectileh(1 + n%) = d%(pc1) * 10
                    projectilev(1 + n%) = 0
                    projectilet%(1 + n%) = 5

                    position%(pc1) = 1
                    neckx(pc1) = 5
                    necky(pc1) = -6

                    elbow1x(pc1) = 5
                    hand1x(pc1) = 4
                    elbow1y(pc1) = 0
                    hand1y(pc1) = 0

                    elbow2x(pc1) = 5
                    hand2x(pc1) = 4
                    elbow2y(pc1) = 0
                    hand2y(pc1) = 0

                    butth(pc1) = butth(pc1) - d%(pc1)
                    bgcolor% = 19
                End If


                x = (hand1x(pc2) + hand2x(pc2)) / 2
                y = (hand1y(pc2) + hand2y(pc2)) / 2

                'Effects
                sbfx 7
                psline (x), (y), (fighterz(pc1)), (x - (Rnd * 75)), (y + ((Rnd - .5) * 250)), (fighterz(pc1)), 15, 0
                psline (x), (y), (fighterz(pc1)), (x + (Rnd * 75)), (y + ((Rnd - .5) * 250)), (fighterz(pc1)), 15, 0
                pslightning (x), (y), (fighterz(pc1)), (x - (Rnd * 100)), (y + ((Rnd - .5) * 200)), (fighterz(pc1)), 75, (flash2%)
                pslightning (x), (y), (fighterz(pc1)), (x + (Rnd * 100)), (y + ((Rnd - .5) * 200)), (fighterz(pc1)), 50, (flash2%)
                If pticker%(pc1) < 10 Then pscircle (x), (y), (fighterz(pc1)), 200 - (pticker%(pc1) * 20), flash1%
                pscircle (x), (y), (fighterz(pc1)), Rnd * 5, flash2%
                pscircle (x), (y), (fighterz(pc1)), 2, 15






                '----------------------------------------------------------------- Spear Kick
            Case Is = 83

                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    rage(pc1) = 0
                    blur 10
                    sbfx 2
                    neckx(pc1) = -3
                    nee1x(pc1) = 6
                    nee1y(pc1) = -1
                    foot1x(pc1) = 6
                    foot1y(pc1) = -1
                    butth(pc1) = d%(pc1) * 5
                End If

                If nee1x(pc2) > l1x And nee1x(pc2) < l2x And foot1y(pc2) > h1y And foot1y(pc2) < l2y Then
                    butth(pc1) = 0
                    health%(po1) = health%(po1) - 1
                    ko(po1) = ko(po1) - .5
                    particle (nee1x(pc2)), (nee1y(pc2)), (fighterz(po1)), 18, 1
                    buttx(po1) = nee1x(pc2)
                    neckx(po1) = ((Rnd - .5) * 2)
                    necky(po1) = -5 - (Rnd * 3)
                    elbow1x(po1) = -3 - (Rnd * 2)
                    elbow2x(po1) = -3 - (Rnd * 2)
                    elbow1y(po1) = 3 - (Rnd * 2)
                    elbow2y(po1) = 3 - (Rnd * 2)

                    hand1x(po1) = -3 + (Rnd * 2)
                    hand2x(po1) = -3 + (Rnd * 2)
                    hand1y(po1) = 3
                    hand2y(po1) = 3
                    If pticker%(pc1) < 50 Then position%(po1) = 15: pticker%(po1) = 1 Else butth(po1) = d%(pc1): fall (po1)


                Else
                    If pticker%(pc1) > 15 Then pticker%(pc1) = 50

                End If


                If pticker%(pc1) = 50 Then
                    position%(pc1) = 1
                    nee1x(pc1) = 2
                    foot1x(pc1) = -4
                End If


                '------------------------------------------------------------------ Health Up
            Case Is = 84
                rage(pc1) = 0
                health%(pc1) = health%(pc1) + ko(pc1)
                particle (headx(pc2)), (heady(pc2)), (fighterz(pc1)), 25, 25
                position%(pc1) = 1


                '----------------------------------------------------------------- Razer Arms
            Case Is = 85
                soundticker% = 0: sbfx 16
                particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .2), 6, 5
                particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .2), 5, 5

                particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1) - .2), 6, 5
                particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1) - .2), 5, 5
                razers%(pc1) = 200
                position%(pc1) = 1
                rage(pc1) = 0
                bgcolor% = 19

                '--------------------------------------------------------------- Neck Snapper
            Case Is = 86

                If pticker%(pc1) = 1 Then
                    If canjump%(pc1) = 1 Then
                        nee1x(pc1) = 2
                        nee2x(pc1) = 2
                        foot1x(pc1) = -2
                        foot2x(pc1) = -2
                        nee1y(pc1) = 5
                        nee2y(pc1) = 5

                        camode% = po1 + 1
                        rage(pc1) = 0
                        buttv(pc1) = -12
                        butth(pc1) = (buttx(po1) - buttx(pc1)) / 20
                    Else
                        position%(pc1) = 1
                    End If
                End If


                If foot1y(pc2) > butty(po1) And buttv(pc1) > -1 Then position%(pc1) = 1: camode% = 1

                'Snap
                If foot1y(pc2) > heady(po2) - 5 And foot1y(pc2) < necky(po2) + 5 And buttx(pc1) > neckx(po2) - 5 And buttx(pc1) < neckx(po2) + 5 Then
                    fighterfreeze (po1)
                    buttx(pc1) = neckx(po2)
                    butty(pc1) = necky(po2) - 15 + Abs(buttv(pc1))
                    elbow2x(pc1) = -5
                    elbow1y(pc1) = 0
                    elbow2y(pc1) = 0
                    hand1y(pc1) = 0
                    hand2y(pc1) = 0
                    nee1x(pc1) = 4
                    nee2x(pc1) = -4
                    foot2x(pc1) = -4
                    nee1y(pc1) = 8
                    nee2y(pc1) = 8
                    foot1y(pc1) = 7
                    foot2y(pc1) = 7
                    buttv(pc1) = -10
                    position%(pc1) = 1
                    camode% = 1

                    If position%(po1) <> 99 Then
                        health%(po1) = health%(po1) - 75
                        soundticker% = 0: sbfx 8
                        If health%(po1) <= 0 Then decap (po1) Else bgcolor% = 15
                        particle (neckx(po2)), (necky(po2)), fighterz(po1), 20, 15
                        particle (neckx(po2)), (necky(po2)), fighterz(po1), 21, 10
                        position%(po1) = 15
                        d%(pc1) = -d%(pc1)
                        butth(pc1) = butth(pc1) / 5
                        buttv(pc1) = -10
                    Else
                        particle (neckx(po2)), (necky(po2)), fighterz(po1), 8, 25
                        buttv(pc1) = -5
                    End If

                End If



                '-------------------------------------------------------------- Swizz Punches
            Case Is = 87
                If pticker%(pc1) = 1 Then
                    fighterfreeze (pc1)
                    rage(pc1) = 0
                    hand1x(pc1) = 5
                    hand2x(pc1) = 5
                    hand1y(pc1) = 0
                    hand2y(pc1) = 0
                    neckx(pc1) = 5
                End If

                psline (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), (hand1x(pc2) - (pticker%(pc1) * 1.5 * d%(pc1))), (hand1y(pc2)), (fighterz(pc1) + .5), (flash1%), 0
                psline (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), (hand2x(pc2) - (pticker%(pc1) * 1.5 * d%(pc1))), (hand2y(pc2)), (fighterz(pc1) - .5), (flash2%), 0


                'detect hit(s)
                If hand1x(pc2) > m1x And hand1x(pc2) < m2x And hand1y(pc2) > h1y And hand1y(pc2) < l2y Then
                    If position%(po1) = 99 Then butth(po1) = d%(pc1)
                    health%(po1) = health%(po1) - 2
                    ko(po1) = ko(po1) - 2
                    neckx(po1) = 0
                    If health%(po1) > 0 And ko(po1) > 0 And pticker%(pc1) < 20 Then fighterfreeze (po1): position%(po1) = 15 Else butth(po1) = d%(pc1)
                    If buttx(pc1) < buttx(po1) Then particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 4, 3 Else particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 3
                    soundticker% = 0: sbfx Int(Rnd * 3) + 9
                Else
                    sbfx 25
                End If

                If hand2x(pc2) > m1x And hand2x(pc2) < m2x And hand2y(pc2) > h1y And hand2y(pc2) < l2y Then
                    If position%(po1) = 99 Then butth(po1) = d%(pc1)
                    health%(po1) = health%(po1) - 3
                    ko(po1) = ko(po1) - 3
                    neckx(po1) = 0
                    If health%(po1) > 0 And ko(po1) > 0 And pticker%(pc1) < 20 Then fighterfreeze (po1): position%(po1) = 15 Else butth(po1) = d%(pc1)
                    If buttx(pc1) < buttx(po1) Then particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 3 Else particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 3
                    soundticker% = 0: sbfx Int(Rnd * 3) + 9
                Else
                    sbfx 25
                End If


                elbow1x(pc1) = (Rnd - .5) * 12
                elbow2x(pc1) = (Rnd - .5) * 12
                elbow1y(pc1) = (Rnd - .4) * 12
                elbow2y(pc1) = (Rnd - .4) * 12


                If pticker%(pc1) = 10 Then blur 15

                If pticker%(pc1) = 25 Then position%(pc1) = 1

                '----------------------------------------------------------------- Upper Bust
            Case Is = 88

                If pticker%(pc1) = 1 Then soundticker% = 0: sbfx 25

                fighterfreeze (pc1)
                rage(pc1) = 0

                elbow2x(pc1) = 3
                elbow2y(pc1) = -5
                hand2x(pc1) = 0
                hand2y(pc1) = -4

                elbow1x(pc1) = -3
                elbow1y(pc1) = 5
                hand1x(pc1) = 0
                hand1y(pc1) = 4

                headx(pc1) = 0
                necky(pc1) = -10
                neckx(pc1) = 1

                nee1x(pc1) = 5
                nee2x(pc1) = -1
                foot1x(pc1) = -1
                foot2x(pc1) = -3

                nee1y(pc1) = 8
                nee2y(pc1) = 8
                foot1y(pc1) = 7
                foot2y(pc1) = 7


                'Detect Hit
                If pticker%(pc1) = 2 Then
                    particle (hand2x(pc2)), (necky(pc2)), fighterz(pc1), 22, 10
 
                    If hand2x(pc2) > m1x - 8 And hand2x(pc2) < m2x + 8 And hand2y(pc2) > h1y - 15 And hand2y(pc2) < l2y Then
                        camode% = 0
                        bgcolor% = 15
                        blur 5
                        panh = d%(pc1)
                        panv = 0
                        health%(po1) = health%(po1) - (ahpow%(pc1) * 5)
                        ko(po1) = ko(po1) - 50
                        If health%(po1) <= 0 Then decap (po1)
                        buttv(po1) = -31
                        butth(po1) = d%(pc1)
                        position%(po1) = 10
                        Color , 15: Color , 0
                        particle (hand2x(pc2)), (necky(pc2)), fighterz(pc1), 23, 10
                        For wee = 1 To 80 Step 5: particle (hand2x(pc2) + ((Rnd - .5) * 5)), (butty(pc1) - wee), (fighterz(pc1)), 2, 1: Next wee
                        soundticker% = 0: sbfx 11
                    End If

                End If


                If pticker%(pc1) > 9 And butty(po1) > butty(pc1) - 25 Then
                    camode% = 1
                    position%(pc1) = 1
                    elbow2v(pc1) = 2
                End If


                '---------------------------------------------------------------------- Block
            Case Is = 99

                fighterfreeze (pc1)

                elbow1x(pc1) = 4
                elbow1y(pc1) = 2
                hand1x(pc1) = 0
                elbow2x(pc1) = 0
                nee1y(pc1) = nee2y(pc1) - 8
                foot1x(pc1) = 0
                neckx(pc1) = 1


                If pticker%(pc1) > 10 Then position%(pc1) = 1


                '----------------------------------------------------------------------------
        End Select

        If healths% > 0 And position%(pc1) < 30 Then health%(po1) = healths%: ko(po1) = kos

    Next pc1
End Sub

Sub file

    20
    Select Case mode%

        '----------------------------------------------------------------------- Load
        Case Is = 1
            fault$ = "load"
            Open path$ + "\slash.dat" For Input As #1
            If setback% = 1 Then mode% = 3: GoTo 20
            Input #1, cmethod%, cfreq%, frameskip%, particles%, nstars%, rez%, delay%, stage%, sbsound%, soundwait%, i16m%, smears%, stagedetail%, fighterdetail%, hudetail%, solidc%, name$(1), flimits%
            If setback% = 1 Then mode% = 3: GoTo 20
            Input #1, head%(1), body%(1), arms%(1), hands%(1), legs%(1), feet%(1), hairl%(1), hairc%(1), hairt%(1)
            Input #1, headc%(1), bodyc%(1), armsc%(1), handsc%(1), legsc%(1), feetc%(1)
            Close #1
            If stage% > stages% Then stage% = 1: setfightercpu

            Locate 12, 27: Print "Loaded"
            Locate 13, 27: Print "     "
            Locate 14, 27: Print "         "

            '----------------------------------------------------------------------- Save
            38
        Case Is = 2
            fault$ = "save1"
            Open path$ + "\slash.dat" For Output As #1
            If setback% = 1 Then setback% = 0: GoTo 38
            If setback% = 2 Then setback% = 0: GoTo 20
            Write #1, cmethod%, cfreq%, frameskip%, particles%, nstars%, rez%, delay%, stage%, sbsound%, soundwait%, i16m%, smears%, stagedetail%, fighterdetail%, hudetail%, solidc%, name$(1), flimits%
            If setback% = 2 Then setback% = 0: GoTo 20
            Write #1, head%(1), body%(1), arms%(1), hands%(1), legs%(1), feet%(1), hairl%(1), hairc%(1), hairt%(1)
            Write #1, headc%(1), bodyc%(1), armsc%(1), handsc%(1), legsc%(1), feetc%(1)
            Close #1

            Locate 12, 27: Print "      "
            Locate 13, 27: Print "Saved"
            Locate 14, 27: Print "         "
            Color 7
            If rez% <> 7 Then Locate 15, 27: Print "<" + UCase$(path$) + "\SLASH.DAT>"
            Locate 16, 27: Print "<C:\SFB2.PTH>"


            '------------------------------------------------------------- Reset Defaults
        Case Is = 3
            cmethod% = 1
            cfreq% = -1
            frameskip% = 3
            particles% = 30
            nstars% = 4
            rez% = 9
            delay% = 0
            stage% = 1
            soundwait% = 5
            sbsound% = 0
            i16m% = 0
            stagedetail% = 1
            fighterdetail% = 1
            hudetail% = 1
            smears% = 1
            flimits% = 1
            solidc% = 0

            head%(1) = 1
            body%(1) = 2
            arms%(1) = 2
            hands%(1) = 4
            legs%(1) = 2
            feet%(1) = 1

            headc%(1) = 7
            bodyc%(1) = 6
            armsc%(1) = 1
            handsc%(1) = 7
            legsc%(1) = 1
            feetc%(1) = 4
            hairl%(1) = 1
            hairc%(1) = 4
            hairt%(1) = 1

            name$(1) = "Mortal"

            Locate 12, 27: Print "      "
            Locate 13, 27: Print "     "
            Locate 14, 27: Print "Defaulted"

    End Select

    fault$ = ""
    mode% = 0
End Sub

Sub floors
    '---------------------------------------------------------- Floors / RingOuts
    For wee = 1 To 2
        wee2 = wee + 2

        'Default Settings
        floor3 = floor1
        canjump%(wee) = 0

        Select Case stage%

            '----------------------------------------------------------------------------
            Case Is = 1
                If Abs(buttx(wee)) > ring% Or butty(wee) > floor1 Then floor3 = floor2
                If butty(wee) > 70 Then ringout (wee)


                '----------------------------------------------------------------------------
            Case Is = 2
                If Abs(buttx(wee)) > ring% Then buttv(wee) = buttv(wee) - gravity - .05: ringout (wee)

                '----------------------------------------------------------------------------
            Case Is = 3, 8, 15
                If Abs(buttx(wee)) > ring% Then
                    floor3 = floor2
                    If foot1y(wee2) >= floor2 - 1 Or foot2y(wee2) >= floor2 - 1 Then ringout (wee): Exit Sub
                End If

                '----------------------------------------------------------------------------
            Case Is = 4
                If Abs(buttx(wee)) > ring% Or butty(wee) > floor1 + 25 Then floor3 = floor2 Else floor3 = (buttx(wee) * bob) / 200
                If heady(wee2) > 30 Then ringout (wee)

                '----------------------------------------------------------------------------
            Case Is = 9
                If Abs(buttx(wee)) > ring% Then floor3 = floor2: ringout (wee) Else floor3 = (buttx(wee) * trigger1) / 300

                '----------------------------------------------------------------------------
            Case Is = 12
                If Abs(buttx(wee)) > ring% Or butty(wee) > floor1 Then floor3 = floor2: camode% = wee + 1

                '----------------------------------------------------------------------------
            Case Is = 14
                If Abs(buttx(wee)) > 100 Then floor3 = floor2
                If ticker% < 60 And wee = 1 Then floor3 = -100

        End Select

        '-------------------------------------------------------------------- CanJump
        If position%(wee) = 1 Then
            If foot1y(wee2) >= (floor3 - buttv(wee)) - 2 Or foot2y(wee2) >= (floor3 - buttv(wee)) - 2 Then canjump%(wee) = 1
        End If


        '---------------------------------------------- Gravity, Traction and Landing

        buttv(wee) = buttv(wee) + gravity

        If foot1y(wee2) >= (floor3 - buttv(wee)) Or foot2y(wee2) >= (floor3 - buttv(wee)) Or butty(wee) >= (floor3 - buttv(wee)) Then
            butth(wee) = butth(wee) / 1.1

            'bounce
            If position%(wee) >= 8 And position%(wee) <= 11 And Abs(buttv(wee)) > 3 And Abs(buttv(wee)) < 25 Then buttv(wee) = -buttv(wee) / 3: butty(wee) = floor3

            If buttv(wee) > 0 Then buttv(wee) = 0
            If foot1y(wee2) > (floor3) Then
                butty(wee) = butty(wee) - (foot1y(wee2) - (floor3))
            Else
                If foot2y(wee2) > floor3 Then butty(wee) = butty(wee) - (foot2y(wee2) - (floor3))
            End If
 
        End If


        '-------------------------------------------------------------- Landing Heads
        If hy(wee) + hv(wee) >= floor3 - 2 Then
            hv(wee) = 0
            hy(wee) = floor3 - 2
            hh(wee) = hh(wee) / 2
        Else
            hv(wee) = hv(wee) + gravity
        End If


        '----------------------------------------------------------------------- Hair
        If wee = 1 Then
            For n% = 1 To 5
                If hairy(n%) > floor3 Then hairy(n%) = floor3
            Next n%
        Else
            For n% = 6 To 10
                If hairy(n%) > floor3 Then hairy(n%) = floor3
            Next n%
        End If

        '-------------------------------------------------------------------


        'Slamming on Ground Sound
        If butty(wee) >= floor3 - 5 And buttv(wee) > .5 Then sbfx 20

        'Skidding on Ground Sound
        If butty(wee) >= floor3 - 1 And buttv(wee) > -1 And Abs(butth(wee)) > .3 Then sbfx 5

        'Smoke
        If Abs(butth(wee)) > 4 And foot1y(wee2) > floor3 - 1 Then particle foot1x(wee2), foot1y(wee2), fighterz(wee), 16, 1
        If Abs(butth(wee)) > 3 And foot1y(wee2) > floor3 - 1 Then particle foot1x(wee2), foot1y(wee2), fighterz(wee), 15, 1


    Next wee


End Sub

Sub getpath
    fault$ = "file"
    Open "c:\sfb2.pth" For Input As #1
    If setback% = 1 Then window3d: setpath: GoTo 28
    Input #1, path$
    Close #1
    28
    fault$ = ""
End Sub

Sub i16 (x, y, x2, y2, F$)
    fault$ = "file"
    Open path$ + "\" + F$ + ".i16" For Input As #1

    If setback% = 1 Then
        setback% = 0
        Line (x, y)-(x + 18.5, y + 18), 0, BF
        Line (x, y)-(x + 18, y + 17.5), 4
        Line (x + 18, y)-(x, y + 17.5), 4
        GoTo 13
    End If

    x1 = x
    y1 = y

    Do While Not EOF(1)
        Input #1, c%
        If c% = 16 Then
            x1 = x
            y1 = y1 + y2
        Else
            Line (x1, y1)-(x1 + x2, y1 + y2), c%, BF
            x1 = x1 + x2
        End If
    Loop
    13
    fault$ = ""
    Close #1
End Sub

Sub jump (n%, T%)

    If canjump%(n%) = 1 Then
        Select Case legs%(n%)
            Case 1: buttv(n%) = -7
            Case 2, 2000: buttv(n%) = -10
            Case 3, 666: buttv(n%) = -8
            Case 4: buttv(n%) = -14
            Case 5, 1998: buttv(n%) = -9
        End Select


        If T% = 1 Then
            Select Case legs%(n%)
                Case 1, 666: butth(n%) = butth(n%) - 1.6
                Case 2: butth(n%) = butth(n%) - 1.4
                Case 3: butth(n%) = butth(n%) - 1.2
                Case 4: butth(n%) = butth(n%) - 1
                Case 5, 2000: butth(n%) = butth(n%) - 2.5
                Case 1998: butth(n%) = butth(n%) - 3
            End Select
        End If

        If T% = 3 Then
            Select Case legs%(n%)
                Case 1, 666: butth(n%) = butth(n%) + 1.6
                Case 2: butth(n%) = butth(n%) + 1.4
                Case 3: butth(n%) = butth(n%) + 1.2
                Case 4: butth(n%) = butth(n%) + 1
                Case 5, 2000: butth(n%) = butth(n%) + 2.5
                Case 1998: butth(n%) = butth(n%) + 3
            End Select
        End If

    End If
End Sub

Sub keycheck

    fault$ = "nokey"
    Open path$ + "\sfb2.key" For Input As #1
    Input #1, wee$
    Close #1

End Sub

Sub loadsave
    39 rezs% = rez%
    setback% = 0
    smallwindow

    Color 15
    Locate 10, 2: Print "File Options"
    Locate 12, 2: Print "1 Load"
    Locate 13, 2: Print "2 Save"
    Locate 14, 2: Print "3 Defaults"
    Locate 15, 2: Print "4 Delete Settings File"
    Locate 16, 2: Print "5 Reset Path File"

    Color 7
    If rez% <> 7 Then Locate 15, 27: Print "<" + UCase$(path$) + "\SLASH.DAT>"
    Locate 16, 27: Print "<C:\SFB2.PTH>"


    22 wee$ = InKey$
    If setback% = 1 Then 39
    If wee$ = "" Then 22

    If wee$ = "1" Then
        mode% = 1: file
        newmatch
    End If

    If wee$ = "2" Then
        mode% = 2: file
    End If

    If wee$ = "3" Then
        mode% = 3: file
        newmatch
    End If

    If wee$ = "4" Then
        Locate 15, 27
        If rez% = 7 Then Print "Deleted      ": Locate 15, 26 Else Print "Deleted                                              ": Locate 15, 27
        Shell "DEL " + path$ + "\SLASH.DAT"
        Locate 12, 27: Print "      "
        Locate 13, 27: Print "     "
        Locate 14, 27: Print "         "
    End If

    If wee$ = "5" Then
        setpath
        restart% = 1
        GoTo 23
    End If

    If rez% <> rezs% Then Screen rez%: window3d: GoTo 39
    If wee$ <> Chr$(27) Then 22

    23
    csmallwindow
    If wee$ = "3" Then Screen rez%
    wee$ = ""
End Sub

Sub movecam

    '-------------------------------------------------------------Camera Movement
    zoom = zoom + zoomd
    panx = panx + panh
    pany = pany + panv
    zoomd = zoomd / 1.1
    panh = panh / 1.01
    panv = panv / 1.01
End Sub

Sub mud

    Screen 9
    Color , 0

    fault$ = "mud"
    If setback% = 1 Then setback% = 0: GoTo 21
    '------------------------------------------------------------------- Show Mud
    Cls

    camdefaults
    zoom = .5
    panx = -500

    s$ = "  SFB2: Vector Warriors, Powered by Slash - Created by Kevin Reems 1997-1998"

    window3d


    For miniloop = 0 To 75
        If InKey$ <> "" Then 21

        panh = 25

        movecam
        'page flipping
        pflip

        flicker = Timer: Do Until Timer - flicker > .000001: Loop

        'Clear Screen
        Cls

        '-------------------------------------------------------------------
        If miniloop = 1 Then c% = 15
        If miniloop = 3 Then c% = 9
        If miniloop = 5 Then c% = 1
        If miniloop = 74 Then c% = 0

        For wee = n To n + 20
            psline -1500, -150, (wee + .5), 1500, -150, (wee + .5), c%, 3
            psline -1500, 150, (wee + .5), 1500, 150, (wee + .5), c%, 3
            psline -500, -150, (wee), 500, -150, (wee), c%, 0
            psline -500, 150, (wee), 500, 150, (wee), c%, 0
        Next wee

        If n > 0 Then n = n - .2 Else n = 1

        If miniloop > 60 Then
            window2d
            Line (0, (miniloop * 10) - 750)-(100, (miniloop * 10) - 650), 0, BF
            window3d
        End If

        '-------------------------------------------------------------------

        psdpset -200, -100, 0, 10, 8
        psdpset -100, -75, 0, 5, 8
        psdpset 0, 10, 0, 7, 8
        psdpset 100, -25, 0, 3, 8
        psdpset 400, 75, 0, 6, 8
        psdpset 500, -100, 0, 5, 8
        psdpset 200, 25, 0, 6, 8
        psdpset 300, -75, 0, 5, 8
        psdpset 600, 100, 0, 5, 8

        '---------S
        psdline 150, -50, 1, 100, 0, 4, 15, 7, 8, 0
        psdline 100, 0, 1, 150, 0, 4, 15, 7, 8, 0
        psdline 150, 0, 1, 100, 50, 4, 15, 7, 8, 0

        '---------L
        psdline 160, 50, 1, 200, 50, 4, 15, 7, 8, 0
        psdline 160, 50, 1, 180, -50, 4, 15, 7, 8, 0

        '---------A
        psdline 210, 50, 1, 250, -50, 4, 15, 7, 8, 0
        psdline 250, -50, 1, 250, 50, 4, 15, 7, 8, 0
        psdline 240, 0, 1, 250, 0, 4, 15, 7, 8, 0

        '---------S
        psdline 310, -50, 1, 260, 0, 4, 15, 7, 8, 0
        psdline 260, 0, 1, 310, 0, 4, 15, 7, 8, 0
        psdline 310, 0, 1, 260, 50, 4, 15, 7, 8, 0

        '---------H
        psdline 320, 50, 1, 340, -50, 4, 15, 7, 8, 0
        psdline 330, 0, 1, 370, 0, 4, 15, 7, 8, 0
        psdline 360, 50, 1, 380, -50, 4, 15, 7, 8, 0

        '-------------------------------------------------------------------

        If miniloop < 5 Then Locate 23, 1: Color 8: Print s$
        If miniloop > 4 And miniloop < 10 Then Locate 23, 1: Color 7: Print s$
        If miniloop > 9 Then Locate 23, 1: Color 15: Print s$
    Next miniloop

    If i16m% = 2 Then 21
    window2d
    Screen , , 0, 0
    i16 0, 0, .88, .85, "slash"
    Screen , , 1, 0
    i16 0, 0, .54, .73, "sfb2"
    Screen , , 0, 1
    Cls
    Sleep 3

    21
    fault$ = ""
End Sub

Sub newmatch
    'Start a New Match
   
    '-----------------------
    If stage% > stages% Then
        stage% = 1
        keycheck

        If wee$ <> "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit" Then
            fault$ = "writekey"
            wee$ = "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit"
            Open path$ + "\sfb2.key" For Output As #1
            Write #1, wee$
            Close #1
   
            '----------------------------------------------------------------------------
            smallwindow
            Color 15
            Locate 10, 2: Print "STAGE SELECT ENABLED"
            Color 12

            If rez% > 7 Then
                Locate 12, 2: Print "Congratulations, You've Earned The Stage Select Option."
            Else
                Locate 12, 2: Print "Congratulations!"
                Locate 13, 2: Print "You've Earned The Stage Select Option."
            End If


            '----------------------------------------------------------------------------
        End If
    End If

    stageinit
End Sub

Sub nokey
    smallwindow
    Color 15
    Locate 10, 2: Print "DISABLED"
    Color 12

    If rez% > 7 Then
        Locate 12, 2: Print "You Must Complete Every Stage To Enable This Option."
        Locate 13, 2: Print "Don't Forget To Save Your Progress."

    Else

        Locate 12, 2: Print "You Must Complete Every Stage"
        Locate 13, 2: Print "To Enable This Option."
        Locate 14, 2: Print "Don't Forget To Save Your Progress."

    End If


    Color 4
    Locate 16, 2: Print "Press Esc"

    40 If InKey$ <> Chr$(27) Then 40
    csmallwindow
End Sub

Sub ocasional

    If flimits% = 1 Then fighterlimits

    For wee = 1 To 2

        'recharge KO & Rage
        If Special%(wee) = 0 And ko(wee) > 0 And ko(wee) < 100 And health%(wee) > 0 Then ko(wee) = ko(wee) + kocharge(wee)
        If rage(wee) < 100 And health%(wee) > 0 Then rage(wee) = rage(wee) + ragecharge(wee)

        If vexed%(wee) > 0 Then health%(wee) = health%(wee) - 1

        '---------------------------+

        'Headless Stuff
        If headless%(wee) = 1 Then
            health%(wee) = health%(wee) - 20
            particle (hx(wee)), (hy(wee)), fighterz(wee), 0, 1
        End If

        '---------------------------+

        'Damage Bar Stuff
        If health%(wee) > maxhp%(wee) Then health%(wee) = maxhp%(wee)

        If health%(wee) < hpslide%(wee) Then
            hpslide%(wee) = hpslide%(wee) - 4
        Else
            hpslide%(wee) = health%(wee)
        End If

        If ko(wee) < koslide%(wee) Then
            koslide%(wee) = koslide%(wee) - 2
        Else
            koslide%(wee) = ko(wee)
        End If


        If health%(wee) >= maxhp%(wee) Then hc%(wee) = 10 Else hc%(wee) = 14
        If vexed%(wee) > 0 Then hc%(wee) = 9
        If ko(wee) >= 100 Then kc%(wee) = 10 Else kc%(wee) = 14

        '---------------------------+

        If rage(wee) < 0 Then rage(wee) = 0
        If rage(wee) = 100 Then vexed%(wee) = 0

        If fighterz(wee) > midstage Then fighterz(wee) = fighterz(wee) - .1
        If fighterz(wee) < midstage Then fighterz(wee) = fighterz(wee) + .1
        If fighterz(wee) > midstage + .5 Then fighterz(wee) = fighterz(wee) - .5
        If fighterz(wee) < midstage - .5 Then fighterz(wee) = fighterz(wee) + .5

    Next wee

    '----------------------------------------------------------------------------
End Sub

Sub options

    If AIactive%(1) = 1 Then AIactive%(1) = 0: stage% = 1: stageinit

    1 redraw% = 0
    fault$ = ""
    bigwindow
    Color 15, 0
    If rez% = 7 Then
        Locate 4, 17: Print "OPTIONS"
    Else
        Locate 4, 37: Print "OPTIONS"
    End If

    Locate 6, 6: Print "Select Stage"
    Locate 8, 6: Print "Build Fighter"
    Locate 10, 6: Print "Visit Dojo"
    Locate 12, 6: Print "Settings"
    Locate 14, 6: Print "Load/Save Options"
    Locate 16, 6: Print "Demo Mode"
    Locate 18, 6: Print "Restart"
    Locate 20, 6: Print "Quit"

    If ptoptions% = 0 Then ptoptions% = 6

    Do
        wee$ = UCase$(InKey$)
        '----------------------------------------------------------------- Move Arrow
        Select Case wee$
            Case Is = "8", Chr$(0) + "H"
                Locate ptoptions%, 2: Print " "
                If ptoptions% > 6 Then ptoptions% = ptoptions% - 2 Else ptoptions% = 20

            Case Is = "5", "2", Chr$(0) + "P"
                Locate ptoptions%, 2: Print " "
                If ptoptions% < 20 Then ptoptions% = ptoptions% + 2 Else ptoptions% = 6
        End Select
        Locate ptoptions%, 2: Print Chr$(16)

        '--------------------------------------------------------------------- Select
        If wee$ = " " Or wee$ = Chr$(13) Then
            redraw% = 1
            wee$ = ""

            Select Case ptoptions%

                Case Is = 6
                    wee$ = ""
                    keycheck
                    If wee$ = "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit" Then setstage Else nokey
                    wee$ = ""

                Case Is = 8
                    setfighter

                Case Is = 10
                    smallwindow
                    Locate 10, 31: Print "Master Bean's Dojo"
                    Locate 12, 2: Print "Leave Current Stage to Visit Dojo ?"
                    window2d
                    i16 76, 41, .363, .355, "dojo"
                    Line (75, 40)-(95, 60), 7, B
                    window3d
                    Locate 13, 2: Print "<Y/N>"
                    Do: wee$ = InKey$: Loop Until wee$ <> ""
                    If UCase$(wee$) = "Y" Then
                        stage% = 1000
                        stageinit
                        setfightercpu
                    End If

                Case Is = 12
                    settings

                Case Is = 14
                    loadsave

                Case Is = 16
                    AIactive%(1) = 1
                    AIactive%(2) = 1
                    dif% = 7
                    stage% = (Rnd * 3) + 1
                    newmatch
                    Exit Sub

                Case Is = 18
                    restart% = 1

                Case Is = 20
                    quit

            End Select
        End If

        If restart% = 1 Then wee$ = Chr$(27)
        If redraw% = 1 Then 1
    Loop Until wee$ = Chr$(27)
    cbigwindow
End Sub

Sub page2
    Screen , 0, 0
    Locate 1, 1: Color 4: Print "Loading..."
    Screen , 2, 0
    window2d

    Select Case stage%

        Case Is = 1
            wee = 1
            Do While wee < 50
                Line (0, 100 - wee)-(100, 100 - wee), 4
                wee = wee * 2
            Loop

        Case Is = 2
            stars2d 8, 15, 15

        Case Is = 3
            i16 0, 0, .88, .85, "slash"

        Case Is = 4
            i16 0, 0, .88, .85, "slash"


    End Select
    window3d
End Sub

Sub pagetest
    32 fault$ = "pagetest"
    wee$ = UCase$(InKey$)
    If wee$ = "0" Then Screen , 0, 0
    If wee$ = "1" Then Screen , 1, 1
    If wee$ = "2" Then Screen , 2, 2
    If wee$ = "3" Then Screen , 3, 3
    If wee$ = "4" Then Screen , 4, 4
    If wee$ = "5" Then Screen , 5, 5
    If wee$ <> "Q" Then 32
    wee$ = "": fault$ = ""

End Sub

Sub particle (x, y, Z, T%, Q%)
    fault$ = "particles"

    For wee = 1 To particles%

        If p%(wee) = 0 And Q% > 0 Then
            Q% = Q% - 1
            px(wee) = x
            py(wee) = y
            pz(wee) = Z

            Select Case T%

                Case Is = 0: 'Blood Down
                    p%(wee) = 20
                    ph(wee) = (Rnd - .5)
                    pv(wee) = Rnd
                    pg%(wee) = 1
                    pc1%(wee) = 12
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 0
                    pk%(wee) = 1

                Case Is = 1: 'Normal Blood
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 3
                    pv(wee) = -Rnd * 5
                    pg%(wee) = 2
                    pc1%(wee) = 12
                    pc2%(wee) = 4
                    pc3%(wee) = 4
                    pf%(wee) = 1
                    pk%(wee) = 1

                Case Is = 2: 'Blood Spurting Up
                    p%(wee) = 60
                    ph(wee) = (Rnd - .5)
                    pv(wee) = -8 + (Rnd * 2)
                    pg%(wee) = 2
                    pc1%(wee) = 12
                    pc2%(wee) = 4
                    pc3%(wee) = 4
                    pf%(wee) = 1
                    pk%(wee) = 1

                Case Is = 3: 'Blood Left
                    p%(wee) = 30
                    ph(wee) = -Rnd * 3
                    pv(wee) = -Rnd * 3
                    pg%(wee) = 2
                    pc1%(wee) = 12
                    pc2%(wee) = 4
                    pc3%(wee) = 4
                    pf%(wee) = 1
                    pk%(wee) = 1

                Case Is = 4: 'Blood Right
                    p%(wee) = 30
                    ph(wee) = Rnd * 3
                    pv(wee) = -Rnd * 3
                    pg%(wee) = 2
                    pc1%(wee) = 12
                    pc2%(wee) = 4
                    pc3%(wee) = 4
                    pf%(wee) = 1
                    pk%(wee) = 1
                    pk%(wee) = 1

                Case Is = 5: 'Large Omni Spark (Blue)
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 15
                    pv(wee) = (Rnd - .5) * 15
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 0
                    pk%(wee) = 1

                Case Is = 6: 'Small Omni Spark (Blue)
                    p%(wee) = 4
                    ph(wee) = (Rnd - .5) * 30
                    pv(wee) = (Rnd - .5) * 30
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 15
                    pc3%(wee) = 15
                    pf%(wee) = 0
                    pk%(wee) = 0

                Case Is = 8: 'Blue Spark Shower
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 4
                    pv(wee) = (-Rnd) * 3
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 1

                Case Is = 9: 'Red Spark Shower
                    p%(wee) = 40
                    ph(wee) = (Rnd - .5)
                    pv(wee) = Rnd
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 0
                    pk%(wee) = 1

                Case Is = 11: 'Normal Water
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 3
                    pv(wee) = -Rnd * 5
                    pg%(wee) = 2
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 2

                Case Is = 12: 'Water Spurting Up
                    p%(wee) = 40
                    ph(wee) = (Rnd - .5)
                    pv(wee) = -7 / (1 + Rnd)
                    pg%(wee) = 2
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 2

                Case Is = 13: 'Water Left
                    p%(wee) = 30
                    ph(wee) = -Rnd * 3
                    pv(wee) = -Rnd * 3
                    pg%(wee) = 2
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 2

                Case Is = 14: 'Water Right
                    p%(wee) = 30
                    ph(wee) = Rnd * 3
                    pv(wee) = -Rnd * 3
                    pg%(wee) = 2
                    pc1%(wee) = 15
                    pc2%(wee) = 9
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 2

                Case Is = 15: 'Smoke
                    p%(wee) = 60
                    ph(wee) = (Rnd - .5) * 2
                    pv(wee) = -Rnd * 1.5
                    pg%(wee) = 2
                    pc1%(wee) = 7
                    pc2%(wee) = 8
                    pc3%(wee) = 8
                    pf%(wee) = 3
                    pk%(wee) = 0

                Case Is = 16: 'Fire
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 2
                    pv(wee) = -Rnd
                    pg%(wee) = 1
                    pc1%(wee) = 14
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 3
                    pk%(wee) = 0

                Case Is = 17: 'Flame
                    p%(wee) = 40
                    ph(wee) = (Rnd - .5) * 2
                    pv(wee) = -Rnd * 4
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 14
                    pc3%(wee) = 12
                    pf%(wee) = 3
                    pk%(wee) = 0

                Case Is = 18: 'Bloody Mess!
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 8
                    pv(wee) = -Rnd * 8
                    pg%(wee) = 2
                    pc1%(wee) = 12
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 1
                    pk%(wee) = 2

                Case Is = 19: 'Grayscale Dot
                    p%(wee) = 18
                    ph(wee) = 0
                    pv(wee) = 0
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 7
                    pc3%(wee) = 8
                    pf%(wee) = 0
                    pk%(wee) = 2


                Case Is = 20: 'Horizontal Snap Spark White
                    p%(wee) = 15
                    ph(wee) = (Rnd - .5) * 50
                    pv(wee) = (Rnd - .5) * 5
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 15
                    pc3%(wee) = 7
                    pf%(wee) = 0
                    pk%(wee) = 0


                Case Is = 21: 'Horizontal Snap Spark Red
                    p%(wee) = 15
                    ph(wee) = (Rnd - .5) * 50
                    pv(wee) = (Rnd - .5) * 5
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 0
                    pk%(wee) = 0


                Case Is = 22: 'Vertical Snap Spark White
                    p%(wee) = 15
                    ph(wee) = (Rnd - .5) * 5
                    pv(wee) = (Rnd - .5) * 50
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 15
                    pc3%(wee) = 7
                    pf%(wee) = 0
                    pk%(wee) = 0


                Case Is = 23: 'Vertical Snap Spark Red
                    p%(wee) = 15
                    ph(wee) = (Rnd - .5) * 5
                    pv(wee) = (Rnd - .5) * 50
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 0
                    pk%(wee) = 0


                Case Is = 24: 'Volcanic Chunks (Brown)
                    p%(wee) = 60
                    ph(wee) = (Rnd - .5) * 2
                    pv(wee) = Rnd * -10
                    pg%(wee) = 3
                    pc1%(wee) = 6
                    pc2%(wee) = 6
                    pc3%(wee) = 6
                    pf%(wee) = 1
                    pk%(wee) = 1


                Case Is = 25: 'Large Omni Spark (Green)
                    p%(wee) = 18
                    ph(wee) = (Rnd - .5) * 50
                    pv(wee) = (Rnd - .5) * 50
                    pg%(wee) = 1
                    pc1%(wee) = 15
                    pc2%(wee) = 10
                    pc3%(wee) = 2
                    pf%(wee) = 0
                    pk%(wee) = 1


                Case Is = 26: 'Volcanic Chunks (Blue)
                    p%(wee) = 30
                    ph(wee) = (Rnd - .5) * 2
                    pv(wee) = Rnd * -10
                    pg%(wee) = 3
                    pc1%(wee) = 9
                    pc2%(wee) = 1
                    pc3%(wee) = 1
                    pf%(wee) = 1
                    pk%(wee) = 1

                Case Is = 27: 'Candle-Like Flame
                    p%(wee) = 15
                    ph(wee) = (Rnd - .5) / 3
                    pv(wee) = -Rnd
                    pg%(wee) = 1
                    pc1%(wee) = 14
                    pc2%(wee) = 12
                    pc3%(wee) = 4
                    pf%(wee) = 3
                    pk%(wee) = 0


            End Select
        End If

        '----------------------------------------------------------------------------
    Next wee
End Sub

Sub particleclear
    For wee = 1 To particles%
        p%(wee) = 0
        py(wee) = -5000
    Next wee

    For wee = 1 To 10
        smearl%(wee) = 0
    Next wee

End Sub

Sub particlemove

    For wee = 1 To particles%
        px(wee) = px(wee) + ph(wee)
        py(wee) = py(wee) + pv(wee)
        Select Case pf%(wee)
            Case Is = 1: pv(wee) = pv(wee) + gravity
            Case Is = 2: pv(wee) = pv(wee) - gravity
            Case Is = 3: ph(wee) = ph(wee) / 1.3
        End Select
    Next wee
End Sub

Sub particlerender

    fault$ = "particles"

    18
    For wee = 1 To particles%

        If setback% = 1 Then setback% = 0: particles% = 0: GoTo 18
        '----------------------------------------------------------------------------
        If p%(wee) > 0 Then

            If pg%(wee) < 3 Then psline (px(wee)), (py(wee)), (pz(wee)), (px(wee) - ph(wee)), (py(wee) - pv(wee)), (pz(wee) - pd(wee)), (pc1%(wee)), 0
            If pg%(wee) > 1 Then pscircle (px(wee)), (py(wee)), (pz(wee)), (.3), (pc1%(wee))

        End If

        '----------------------------------------------------------------------------
    Next wee
    fault$ = ""
End Sub

Sub pause

    Screen , , 0, 0

    Color 4
    Locate 22, 38
    Print "Pause"

    Color 15
    Locate 21, 1: Print name$(1) + " VS. " + name$(2)
    Locate 22, 1: Print stagename$

    Do While InKey$ = ""
    Loop

End Sub

Sub pflip
    fault$ = "pflip"
    If rez% <> 1 And rez% <> 12 Then
        Swap pflip1%, pflip2%
        Screen , , pflip1%, pflip2%
    End If
    fault$ = ""

End Sub

Sub projectilerender
    For n% = 1 To 6
        If projectile%(n%) > 0 Then
            If projectile%(n%) < 4 Then Z = fighterz(1) Else Z = fighterz(2)

            '----------------
            Select Case projectilet%(n%)


                '------------------------------------------------------------- Ball Lightning
                Case 1
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (Rnd * 4), (flash1%)
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (4), (flash2%)
                    pslightning (projectilex(n%)), (projectiley(n%)), (Z), (projectilex(n%) - projectileh(n%)), (projectiley(n%) + ((Rnd - .5) * 25)), (Z), (20), (flash2%)
                    particle (projectilex(n%)), (projectiley(n%)), (Z), 5, 1


                    '------------------------------------------------------------ Large Fire Ball
                Case 2
                    s = projectile%(n%)
                    If s > 6 Then s = 6
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (s), (flash3%)

                    For wee = 1 To 3
                        y = projectiley(n%) + ((Rnd - .5) * 10)
                        psline (projectilex(n%)), (y), (Z), (projectilex(n%) - (projectileh(n%) + ((Rnd - .5) * s * 5))), (y), (Z), flash3%, 0
                        particle (projectilex(n%) - ((Rnd * projectileh(n%)) * 5)), (projectiley(n%) + ((Rnd - .5) * 10)), (Z), 16, 1
                    Next wee

                    '------------------------------------------------------------ Small Fire Ball
                Case 3
                    s = projectile%(n%)
                    If s > 3 Then s = 3
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (s), (flash3%)
                    For wee = 1 To 3
                        y = projectiley(n%) + ((Rnd - .5) * 5)
                        psline (projectilex(n%)), (y), (Z), (projectilex(n%) - (projectileh(n%) + ((Rnd - .5) * s))), (y), (Z), 4, 0
                        particle (projectilex(n%) - ((Rnd * projectileh(n%)) * 5)), (projectiley(n%) + ((Rnd - .5) * 5)), (Z), 16, 1
                    Next wee


                    '------------------------------------------------------------------- Nin-Star
                Case 4
                    particle (projectilex(n%)), (projectiley(n%)), (Z), 19, 1
                    psline (projectilex(n%) - Rnd), (projectiley(n%) - Rnd), (Z), (projectilex(n%) + Rnd), (projectiley(n%) + Rnd), (Z), 15, 0
                    psline (projectilex(n%) + Rnd), (projectiley(n%) - Rnd), (Z), (projectilex(n%) - Rnd), (projectiley(n%) + Rnd), (Z), 15, 0


                    '--------------------------------------------------------------- Energy Blast
                Case 5
                    pscline (projectilex(n%) - projectileh(n%)), (projectiley(n%)), (Z), (projectilex(n%) - (projectileh(n%) * 3)), (projectiley(n%)), (Z), (4), (flash1%)
                    pscircle (projectilex(n%) - projectileh(n%)), (projectiley(n%)), (Z), (15), (flash1%)
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (Rnd * 5), (flash1%)
                    pscircle (projectilex(n%)), (projectiley(n%)), (Z), (5), (flash2%)
                    pslightning (projectilex(n%)), (projectiley(n%)), (Z), (projectilex(n%) - (projectileh(n%) * 5)), (projectiley(n%) + ((Rnd - .5) * 25)), (Z), (20), (flash2%)
                    For wee = 1 To 3: particle (projectilex(n%) + ((Rnd - .5) * 20)), (projectiley(n%) + ((Rnd - .5) * 15)), (Z), 19, 1: Next wee



            End Select
        End If
    Next n%

End Sub

Sub projectiles

    'Ball-1/4 Collision Detection
    If projectile%(1) > 0 And projectile%(4) > 0 And projectilex(1) > projectilex(1) - 5 And projectilex(1) < projectilex(1) + 5 And projectiley(1) > projectiley(1) - 5 And projectiley(1) < projectiley(1) + 5 Then
        If projectilet%(1) = 1 Or projectilet%(4) = 1 Then particle ((projectilex(1) + projectilex(2)) / 2), (projectiley(1)), (fighterz(1)), 5, 15
        If projectilet%(1) = 2 Or projectilet%(4) = 2 Then particle ((projectilex(1) + projectilex(2)) / 2), (projectiley(1)), (fighterz(1)), 17, 15
        projectile%(1) = 0
        projectile%(4) = 0
    End If

    For n% = 1 To 6
        If projectile%(n%) > 0 Then
            projectile%(n%) = projectile%(n%) - 1
            projectilex(n%) = projectilex(n%) + projectileh(n%)
            projectiley(n%) = projectiley(n%) + projectilev(n%)

            If n% < 4 Then pc1% = 1: po1% = 2 Else pc1% = 2: po1% = 1
            pc2% = pc1% + 2
            po2% = po1% + 2
            If foot1y(po2%) > foot2y(po2%) Then footy = foot1y(po2%) Else footy = foot2y(po2%)


            '---------------- Detect Hit
            If projectilex(n%) > buttx(po1%) - 5 And projectilex(n%) < buttx(po1%) + 5 And projectiley(n%) > heady(po2%) And projectiley(n%) < footy Then

                Select Case projectilet%(n%)
                    '------------------------------------------------------------- Ball Lightning
                    Case 1
                        butth(po1%) = butth(po1%) + (projectileh(n%) / 5)
                        pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (10), (1)
                        If position%(po1%) = 99 Then
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 6, 25
                        Else
                            soundticker% = 0: sbfx 19
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 10
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 5, 25
                            health%(po1%) = health%(po1%) - (ahpow%(pc1%) * 5)
                            ko(po1%) = ko(po1%) - (akpow%(pc1%) * 5)
                            If ko(po1%) < 25 Or projectiley(n%) > butty(po1%) Then fall (po1%)
                        End If

                        '-------------------------------------------------------------------- L. Fire
                    Case 2
                        butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
                        pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (10), (4)
                        If position%(po1%) = 99 Then
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 9, 25
                        Else
                            soundticker% = 0: sbfx 25
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 17, 20
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 10
                            health%(po1%) = health%(po1%) - (ahpow%(pc1%) * 2)
                            ko(po1%) = ko(po1%) - (akpow%(pc1%) * 2)
                            If ko(po1%) < 15 Then fall (po1%)
                        End If

                        '-------------------------------------------------------------------- S. Fire
                    Case 3
                        butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
                        pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (8), (4)
                        If position%(po1%) = 99 Then
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 9, 15
                        Else
                            soundticker% = 0: sbfx 25
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 17, 10
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 5
                            ko(po1%) = ko(po1%) - akpow%(pc1%)
                            butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
                        End If

                        '------------------------------------------------------------------- Nin-Star
                    Case 4
                        If position%(po1%) = 99 Then
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 6, 15
                        Else
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 0, 10
                            health%(po1%) = health%(po1%) - ahpow%(pc1%)
                            ko(po1%) = ko(po1%) - akpow%(pc1%)
                        End If


                        '------------------------------------------------------------------- E. Blast
                    Case 5
                        pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (20), (15)
                        particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 5, 25
                        health%(po1%) = health%(po1%) - 10
                        ko(po1%) = ko(po1%) - 10
                        butth(po1%) = butth(po1%) + (projectileh(n%) / 2)

                        If position%(po1%) = 99 Then
                            bgcolor% = 1
                        Else
                            soundticker% = 0: sbfx 21
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 20, 10
                            particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 22, 10
                            bgcolor% = 9
                            health%(po1%) = health%(po1%) / 2
                            ko(po1%) = ko(po1%) / 2
                            fall (po1%)
                        End If


                        '---------------------------------------------------------------------------+
                End Select
                projectile%(n%) = 0
            End If
        End If
    Next n%
End Sub

Sub pscircle (x, y, Z, r1, c%)

    '-------------------------------------------------------------------PS-Circle
    Z = Z + 1
    If Z = 0 Then Z = .000001

    x = (midx% + ((x - panx) / (Z * zoom)))
    y = (midy% + ((y - pany) / (Z * zoom)))

    r2 = r1 / (Z * zoom)

    fault$ = "ps"
    Circle (x, y), r2, c%
    fault$ = ""
End Sub

Sub pscline (x1, y1, z1, x5, y5, z5, r, c%)

    x3 = ((x1 + x5) / 2)
    x2 = ((x1 + x3) / 2)
    x4 = ((x3 + x5) / 2)

    y3 = ((y1 + y5) / 2)
    y2 = ((y1 + y3) / 2)
    y4 = ((y3 + y5) / 2)

    z3 = ((z1 + z5) / 2)
    z2 = ((z1 + z3) / 2)
    z4 = ((z3 + z5) / 2)

    pscircle (x1), (y1), (z1), (r), (c%)
    pscircle (x2), (y2), (z2), (r), (c%)
    pscircle (x3), (y3), (z3), (r), (c%)
    pscircle (x4), (y4), (z4), (r), (c%)
    pscircle (x5), (y5), (z5), (r), (c%)
End Sub

Sub pscube (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)


    '---------------------------------------------------------------------PS-Cube

    '---------far face
    psline (x1), (y1), (z2), (x2), (y2), (z2), (c3%), 1

    '---------connect faces
    'top/left
    psdpset (x1), (y1), (z1), (z2), (c2%)

    'top/right
    psdpset (x2), (y1), (z1), (z2), (c2%)

    'bottom/left
    psdpset (x1), (y2), (z1), (z2), (c2%)

    'bottom/right
    psdpset (x2), (y2), (z1), (z2), (c2%)

    '---------near face
    psline (x1), (y1), (z1), (x2), (y2), (z1), (c1%), 1

End Sub

Sub psdline (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, B%)


    '----------------------------------------------------------------PS Deep-Line
    '---------far line
    psline (x1), (y1), (z2), (x2), (y2), (z2), (c3%), 0

    '---------connect lines
    If B% = 1 Then psdpset (x1), (y1), (z1), (z2), (c2%): psdpset (x2), (y2), (z1), (z2), (c2%)

    '---------near line
    psline (x1), (y1), (z1), (x2), (y2), (z1), (c1%), 0

End Sub

Sub psdpset (x, y, z1, z2, c%)


    '---------------------------------------------------------------PS-Deep Point
    z1 = z1 + 1
    7 z2 = z2 + 1
    If z1 = 0 Then z1 = .000001
    If z2 = 0 Then z2 = .000001

    x3 = (midx% + ((x - panx) / (z1 * zoom)))
    y3 = (midy% + ((y - pany) / (z1 * zoom)))

    x4 = (midx% + ((x - panx) / (z2 * zoom)))
    y4 = (midy% + ((y - pany) / (z2 * zoom)))

    fault$ = "ps"
    Line (x3, y3)-(x4, y4), c%
    fault$ = ""
End Sub

Sub pslightning (x1, y1, z1, x5, y5, z5, r, c%)

    x3 = ((x1 + x5) / 2) + ((Rnd - .5) * r)
    x2 = ((x1 + x3) / 2) + ((Rnd - .5) * r)
    x4 = ((x3 + x5) / 2) + ((Rnd - .5) * r)

    y3 = ((y1 + y5) / 2) + ((Rnd - .5) * r)
    y2 = ((y1 + y3) / 2) + ((Rnd - .5) * r)
    y4 = ((y3 + y5) / 2) + ((Rnd - .5) * r)

    z3 = ((z1 + z5) / 2)
    z2 = ((z1 + z3) / 2)
    z4 = ((z3 + z5) / 2)

    psline (x1), (y1), (z1), (x2), (y2), (z2), (c%), 0
    psline (x2), (y2), (z2), (x3), (y3), (z3), (c%), 0
    psline (x3), (y3), (z3), (x4), (y4), (z4), (c%), 0
    psline (x4), (y4), (z4), (x5), (y5), (z5), (c%), 0
End Sub

Sub psline (x1, y1, z1, x2, y2, z2, c%, B%)

    '---------------------------------------------------------------------PS-Line
    z1 = z1 + 1
    z2 = z2 + 1
    If z1 = 0 Then z1 = .000001
    If z2 = 0 Then z2 = .000001

    x3 = (midx% + ((x1 - panx) / (z1 * zoom)))
    y3 = (midy% + ((y1 - pany) / (z1 * zoom)))

    x4 = (midx% + ((x2 - panx) / (z2 * zoom)))
    y4 = (midy% + ((y2 - pany) / (z2 * zoom)))

    fault$ = "ps"
    Select Case B%
        Case 0: Line (x3, y3)-(x4, y4), c%
        Case 1: Line (x3, y3)-(x4, y4), c%, B
        Case 2: Line (x3, y3)-(x4, y4), c%, BF
        Case 3: Line (x3, y3)-(x4, y4), c%, , &H1111
        Case 4: Line (x3, y3)-(x4, y4), c%, B , &H1111
    End Select

    fault$ = ""
End Sub

Sub psmark1 (x, y, Z, c1%, c2%, c3%)


    pspset (x), (y), (Z), (c3%)
    pspset (x), (y), (Z - .5), (c2%)
    pspset (x), (y), (Z - 1), (c1%)

End Sub

Sub psmark2 (x, y, c1%, c2%, c3%)


    pspset (x), (y), (1), (c3%)
    pspset (x), (y), (.5), (c2%)
    pspset (x), (y), (0), (c1%)

End Sub

Sub pspoint (x, y, Z)

    '------------------------------------------------------------------- PS-Point
    Z = Z + 1

    If Z = 0 Then Z = .000001

    x1 = (midx% + ((x - panx) / (Z * zoom)))
    y1 = (midy% + ((y - pany) / (Z * zoom)))

    fault$ = "ps"
    pointc% = Point(x1, y1)
    fault$ = ""

End Sub

Sub pspset (x, y, Z, c%)


    '------------------------------------------------------------------- PS-Pset
    Z = Z + 1

    If Z = 0 Then Z = .000001

    x1 = (midx% + ((x - panx) / (Z * zoom)))
    y1 = (midy% + ((y - pany) / (Z * zoom)))

    fault$ = "ps"
    PSet (x1, y1), c%
    fault$ = ""
End Sub

Sub quit

    smallwindow
    Locate 10, 2: Print "Quit SFB2: Vector Warriors ?"
    Locate 11, 2: Print "<Y/N>"
    5 wee$ = UCase$(InKey$)
    If wee$ = "" Then 5

    If wee$ = "Y" Then
        If sbsound% = 1 Then sbinit
        System
    End If

    csmallwindow
    wee$ = ""
End Sub

Sub rain2d (c1%, c2%, c3%, l)
    Rem-----------------------------------------------Draw Rain

    Window Screen(0, 0)-(1, 1)

    For wee = 1 To nstars%
        Line (stars1x(wee), stars1y(wee))-(stars1x(wee), stars1y(wee) - l), c1%
        Line (stars2x(wee), stars2y(wee))-(stars2x(wee), stars2y(wee) - l), c2%
        Line (stars3x(wee), stars3y(wee))-(stars3x(wee), stars3y(wee) - l), c3%
    Next wee

    Call window3d

End Sub

Sub rain3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, l)
    Rem-----------------------------------------------Draw Rain

    x2 = x2 - x1
    y2 = y2 - y1
    z2 = z2 - z1

    For wee = 1 To nstars%
        x3 = x1 + (stars1x(wee) * x2)
        y3 = y1 + (stars1y(wee) * y2)
        z3 = z1 + (stars1z(wee) * z2)
        psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c1%, 0
        'IF y3 > floor1 THEN psline (x3 - 1), (y3), (z3), (x3 + 1), (y3), (z3), 1, 0

        x3 = x1 + (stars2x(wee) * x2)
        y3 = y1 + (stars2y(wee) * y2)
        z3 = z1 + (stars2z(wee) * z2)
        psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c2%, 0
        'IF y3 > floor1 THEN psline (x3 - 1), (y3), (z3), (x3 + 1), (y3), (z3), 9, 0

        x3 = x1 + (stars3x(wee) * x2)
        y3 = y1 + (stars3y(wee) * y2)
        z3 = z1 + (stars3z(wee) * z2)
        psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c3%, 0
        'IF y3 > floor1 THEN psline (x3 - 2), (y3), (z3), (x3 + 2), (y3), (z3), 15, 0

    Next wee


End Sub

Sub ringout (n)

    ringoutt% = 50
    If ringoutp% = 1 And n = 2 Then ringoutp% = 3 Else ringoutp% = n


    Select Case stage%
        '----------------------------------------------------------------------------
        Case Is = 1, 2, 4
            health%(n) = health%(n) - 5

            '----------------------------------------------------------------------------
        Case Is = 3, 8, 15
            If buttx(n) > 0 Then buttx(n) = ring% - 10 Else buttx(n) = -ring% + 10
            butth(n) = 0
            For wee = 1 To particles%
                particle ((Rnd - .5) * 10), (floor1 - Rnd * 25), (midstage), 15, 1
            Next wee

            If n = 2 Then
                win%(1) = win%(1) + 1
                buttx(1) = 0
                butty(1) = floor1 - 20
                fighterfreeze 1
            Else
                win%(2) = win%(2) + 1
                buttx(2) = 0
                butty(2) = floor1 - 20
                fighterfreeze 2
            End If

            '------------
            Screen , , 0, 0
            If win%(1) > 1 Then Print name$(1) + " Wins the Match By Ringout": stage% = stage% + 1: setfightercpu
            If win%(2) > 1 Then Print name$(2) + " Wins the Match By Ringout"

            If win%(1) > 1 Or win%(2) > 1 Then
                wee = Timer
                35 If Timer - wee < 3 Then 35
                newmatch
            End If

            '----------------------------------------------------------------------------
        Case Is = 9
            If butty(n) > 80 Then
                health%(n) = health%(n) - 10
                butth(n) = butth(n) / 2
                pslightning buttx(n) + ((Rnd - .5) * 25), floor2, fighterz(n), neckx(n + 2), heady(n + 2) + (Rnd * 15), fighterz(n), 25, flash2%
                If Abs(buttx(n)) < ring% + 25 Then butth(n) = 0: health%(n) = 0
            End If

            '----------------------------------------------------------------------------
    End Select
End Sub

Sub ringoutext (n)
    If ticker% > 50 Then
        If ringoutt% < 3 Then Color 4 Else Color 12
        If ringoutt% > 47 Then Color 15
        If n = 3 Then
            If rez% > 7 Then Locate 5, 30 Else Locate 5, 20
            Print "Both Fighters Ringout"
        Else
            If rez% > 7 Then
                Locate 5, 30: Print name$(n)
                Locate 5, 45: Print "Ringout"
            Else
                Locate 5, 30: Print name$(n)
                Locate 6, 30: Print "Ringout"
            End If
        End If

    End If
End Sub

DefInt A-Z
Sub sbfx (fxx%)

    If soundticker% < 1 And sbsound = 1 Then
        soundticker% = soundwait%

        'Freq%, Wave%, FEEDBACK%, Modl%, CLEN%

        Select Case fxx%

            'Jab
            Case Is = 1
                For wee = 1 To 40
                    SBplay 100, 1, 1, 0, 1
                Next wee
                Call SBWrite(&HB0, &H0)

                'Strong
            Case Is = 2
                For wee = 1 To 60
                    SBplay 50, 1, 1, 0, 1
                Next wee
                Call SBWrite(&HB0, &H0)

                'Short
            Case Is = 3
                For wee = 1 To 45
                    SBplay 25, 1, 1, 0, 1
                Next wee
                Call SBWrite(&HB0, &H0)

                'Round House
            Case Is = 4
                For wee = 1 To 40
                    SBplay 1, 1, 1, 0, 1
                Next wee
                Call SBWrite(&HB0, &H0)

                'Skidding on Ground
            Case Is = 5
                For wee = 1 To 45
                    SBplay 150, 0, 14, 500, 150
                Next wee
                Call SBWrite(&HB0, &H0)

                'Throw Fire/Dragon
            Case Is = 6
                For wee = 1 To 45
                    SBplay 25, 0, 1000, 10, 261
                Next wee
                Call SBWrite(&HB0, &H0)

                'Charge
            Case Is = 7
                For wee = 1 To 45
                    SBplay 255, 0, 14, 16, 9
                Next wee
                Call SBWrite(&HB0, &H0)

                'Burning
            Case Is = 8
                For wee = 1 To 45
                    SBplay 25, 0, 1000, 10, 259
                Next wee
                Call SBWrite(&HB0, &H0)

                'Hit 1
            Case Is = 9
                For wee = 1 To 45
                    SBplay 50, 0, 12, 100, 262
                Next wee
                Call SBWrite(&HB0, &H0)

                'Hit 2
            Case Is = 10
                For wee = 1 To 45
                    SBplay 150, 0, 12, 100, 262
                Next wee
                Call SBWrite(&HB0, &H0)

                'Hit 3
            Case Is = 11
                For wee = 1 To 45
                    SBplay 250, 0, 12, 100, 262
                Next wee
                Call SBWrite(&HB0, &H0)


                'Gong 1
            Case Is = 12
                For wee = 1 To 45
                    SBplay 50, 2, 0, 13, 258
                Next wee
                Call SBWrite(&HB0, &H0)

                'Tick
            Case Is = 13
                For wee = 1 To 45
                    SBplay 0, 1, 10, 1, 15
                Next wee
                Call SBWrite(&HB0, &H0)

                'Gong 2
            Case Is = 14
                For wee = 1 To 45
                    SBplay 100, 2, 16, 135, 258
                Next wee
                Call SBWrite(&HB0, &H0)

                'Gong 3
            Case Is = 15
                For wee = 1 To 45
                    SBplay 50, 2, 0, 13, 259
                Next wee
                Call SBWrite(&HB0, &H0)

                'Fan
            Case Is = 16
                For wee = 1 To 45
                    SBplay 14, 1, 14, 15, 260
                Next wee
                Call SBWrite(&HB0, &H0)

                'Chopping
            Case Is = 17
                For wee = 1 To 45
                    SBplay 69, 1, 14, 5, 4
                Next wee
                Call SBWrite(&HB0, &H0)

                'Laser 1
            Case Is = 18
                For wee = 1 To 45
                    SBplay 35, -1, 62, 0, 260
                Next wee
                Call SBWrite(&HB0, &H0)

                'Shock 1
            Case Is = 19
                For wee = 1 To 45
                    SBplay 60, 3, 14, 15, 19
                Next wee
                Call SBWrite(&HB0, &H0)

                'Slamming on Ground
            Case Is = 20
                For wee = 1 To 45
                    SBplay 150, 0, 14, 500, 200
                Next wee
                Call SBWrite(&HB0, &H0)


                'Shock 2
            Case Is = 21
                For wee = 1 To 45
                    SBplay 30, 3, 14, 15, 19
                Next wee
                Call SBWrite(&HB0, &H0)


                'Button 1
            Case Is = 22
                For wee = 1 To 45
                    SBplay 200, 0, 1, 100, 262
                Next wee
                Call SBWrite(&HB0, &H0)


                'Button 2
            Case Is = 23
                For wee = 1 To 45
                    SBplay 50, 1, 0, 50, 259
                Next wee
                Call SBWrite(&HB0, &H0)


                'Button 3
            Case Is = 24
                For wee = 1 To 45
                    SBplay 100, 0, 10, 25, 262
                Next wee
                Call SBWrite(&HB0, &H0)


                'Swizz Punches
            Case Is = 25
                For wee = 1 To 45
                    SBplay 14, 0, 14, 15, 260
                Next wee
                Call SBWrite(&HB0, &H0)


                'Conclusion
            Case Is = 26
                For wee = 1 To 45
                    SBplay 200, 0, 0, 131, 2
                Next wee
                Call SBWrite(&HB0, &H0)



        End Select
    End If

End Sub

Sub sbinit
    fault$ = "sb"
    Locate 1, 1
    Color 15

    Print "Initializing Sound Card"
    For Q = 1 To &HF5
        Call SBWrite(Q, 0)
    Next Q

    Locate 1, 1
    Print "                       "

    fault$ = ""
End Sub

Sub SBplay (Freq%, Wave%, Feedback%, Modl%, Clen%)
    'Channel 1
    'Operator 1
    Call SBWrite(&H20, Modl%) '&H51
    Call SBWrite(&H40, 10) '49
    Call SBWrite(&H60, &H40) '&HF0
    Call SBWrite(&H80, &H240) '&H77
    Call SBWrite(&HA0, Freq%) 'Freq%
    'Operator 2
    Call SBWrite(&H23, 1) '
    Call SBWrite(&H43, 0) '49
    Call SBWrite(&H63, &HF0) '
    Call SBWrite(&H83, Clen%) 'CLEN%
    Call SBWrite(&HB0, &H31) '&H31
                                                   
    Call SBWrite(&HE0, Wave%) '0 or 1
    Call SBWrite(&HC0, Feedback%) '

End Sub

Sub SBWrite (Reg%, Value%)
    fault$ = "sb"
    Out &H220, Reg%
    For x = 0 To SBWrite.delay1
        a = Inp(&H220)
    Next x
    Out &H223, Value%
    For x = 0 To SBWrite.delay2
        a = Inp(&H220)
    Next x
    fault$ = ""
End Sub

DefSng A-Z
Sub setbody (n%)

    Select Case body%(n%)
        Case 1: maxhp%(n%) = 150: sdelay%(n%) = 5
        Case 2: maxhp%(n%) = 160: sdelay%(n%) = 8
        Case 3: maxhp%(n%) = 170: sdelay%(n%) = 9
        Case 4: maxhp%(n%) = 180: sdelay%(n%) = 15
        Case 5: maxhp%(n%) = 190: sdelay%(n%) = 18
        Case 6: maxhp%(n%) = 175: sdelay%(n%) = 10
        Case 7: maxhp%(n%) = 175: sdelay%(n%) = 11
        Case 8: maxhp%(n%) = 200: sdelay%(n%) = 20
        Case 666: maxhp%(n%) = 200: sdelay%(n%) = 5
        Case 2000: maxhp%(n%) = 200: sdelay%(n%) = 10
    End Select

    health%(n%) = maxhp%(n%)
End Sub

Sub setcmethod

    Call smallwindow
    Locate 10, 2: Print "Clear Method - Type"

    If cmethod% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 12, 2: Print "1 No Clearing"

    If cmethod% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 13, 2: Print "2 LINE BF"

    If cmethod% = 2 Then mark = 15 Else mark = 7
    Color mark: Locate 14, 2: Print "3 CLS"

    If cmethod% = 3 Then mark = 15 Else mark = 7
    Color mark: Locate 15, 2: Print "4 Horizontal Fade"

    If cmethod% = 4 Then mark = 15 Else mark = 7
    Color mark: Locate 16, 2: Print "5 Block Fade"

    16 wee$ = InKey$
    Select Case wee$
        Case Is = "": GoTo 16
        Case Is = "1": cmethod% = 0
        Case Is = "2": cmethod% = 1
        Case Is = "3": cmethod% = 2
        Case Is = "4": cmethod% = 3
        Case Is = "5": cmethod% = 4
    End Select

    '---------------------------------------------------------
    If cmethod% > 0 And wee$ <> Chr$(27) Then
        Call csmallwindow
        Call smallwindow

        Locate 10, 2: Print "Clear Method - Frequency"

        If cfreq% = -1 Then mark = 15 Else mark = 7
        Color mark: Locate 12, 2: Print "1 Always"

        If cfreq% = 1 Then mark = 15 Else mark = 7
        Color mark: Locate 13, 2: Print "2 Often"

        If cfreq% = 5 Then mark = 15 Else mark = 7
        Color mark: Locate 14, 2: Print "3 Rarely"

        17 wee$ = InKey$: If wee$ = "" Then 17
        If wee$ = "1" Then cfreq% = -1
        If wee$ = "2" Then cfreq% = 1
        If wee$ = "3" Then cfreq% = 5
    End If
    Call csmallwindow
    wee$ = ""
End Sub

Sub setdelay
    Screen , 0, 0
    Call smallwindow
    Color 15
    Locate 10, 2: Print "Game Speed"

    If rez% = 7 Then
        Locate 12, 2: Print " LOW 00 10 20 30 40 50 60 70 80 90 HI"
    Else
        Locate 12, 2: Print "Slow 00 10 20 30 40 50 60 70 80 90 Fast"
    End If

    Color 4
    Locate 16, 2: Print "Press Spacebar To Save."
    d = delay%
    15
    wee$ = InKey$

    If d = delay% Then
        Color 15
        Locate 13, 35 - Int(d / 2000): Print "^"

    Else
        Color 7
        Locate 13, 35 - Int(d / 2000): Print "^"
        Color 9
        Locate 13, 35 - Int(delay% / 2000): Print "^"
    End If

    If wee$ = "6" Or wee$ = Chr$(0) + "M" Or wee$ = "+" Or wee$ = "=" Then Locate 13, 35 - Int(d / 2000): Print " ": d = d - 2000
    If wee$ = "4" Or wee$ = Chr$(0) + "K" Or wee$ = "-" Then Locate 13, 35 - Int(d / 2000): Print " ": d = d + 2000
    If d < 0 Then d = 0
    If d > 56000 Then d = 56000
    If wee$ = " " Or wee$ = Chr$(13) Then Locate 13, 35 - Int(delay% / 2000): Print " ": delay% = d
    If wee$ <> Chr$(27) Then 15

    Call csmallwindow
    wee$ = ""
End Sub

Sub setdetails
    smallwindow

    Color 15
    Locate 10, 2: Print "Graphic Details"

    If rez% > 7 Then
        Locate 12, 2: Print "Stages"
        Locate 12, 12: Print "Fighters"
        Locate 12, 22: Print "HUD"
        Locate 12, 32: Print "Smears"
        Locate 12, 42: Print "Fighter Limits"
        n% = 10
    Else
        Locate 12, 2: Print "Stgs"
        Locate 12, 10: Print "Ftrs"
        Locate 12, 18: Print "HUD"
        Locate 12, 26: Print "Smrs"
        Locate 12, 34: Print "FLim"
        n% = 8
    End If


    33

    '---

    wee = 2

    If stagedetail% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 14, wee: Print "1 Low"

    If stagedetail% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 15, wee: Print "2 High"

    wee = wee + n%

    '---
    If fighterdetail% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 14, wee: Print "3 Low"

    If fighterdetail% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 15, wee: Print "4 High"

    wee = wee + n%

    '---
    If hudetail% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 14, wee: Print "5 Low"

    If hudetail% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 15, wee: Print "6 High"

    wee = wee + n%

    '---
    If smears% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 14, wee: Print "7 Off"

    If smears% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 15, wee: Print "8 On"

    wee = wee + n%

    '---
    If flimits% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 14, wee: Print "9 Off"

    If flimits% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 15, wee: Print "0 On"


    wee$ = InKey$
    Select Case wee$
        Case Is = "1": stagedetail% = 0
        Case Is = "2": stagedetail% = 1
        Case Is = "3": fighterdetail% = 0
        Case Is = "4": fighterdetail% = 1
        Case Is = "5": hudetail% = 0
        Case Is = "6": hudetail% = 1
        Case Is = "7": smears% = 0
        Case Is = "8": smears% = 1
        Case Is = "9": flimits% = 0
        Case Is = "0": flimits% = 1
    End Select

    If wee$ <> Chr$(27) Then 33


    '----------------------------------------------------------------------------
    smallwindow
    wee$ = ""
End Sub

Sub setfighter
    bigwindow

    changed% = 0
    zoomsave = zoom
    panxsave = panx
    panysave = pany

    zoom = fighterz(1) / 150
    pany = butty(1)
    wee = 0
    If rez% = 7 Then x% = -15

    37 redraw% = 0

    '----------------------------------------------------------------------------
    If head%(1) >= 100 Then
        body%(1) = head%(1)
        arms%(1) = head%(1)
        hands%(1) = head%(1)
        legs%(1) = head%(1)
        feet%(1) = head%(1)
    End If

    '-------------------------------------------------------------- Fighter Info.
    window2d
    Line (5, 15.5)-(99, 89), 0, BF
    window3d

    If rez% > 7 Then

        'Red Text (Titles)
        Color 4

        'Left Panel

        Locate 6, 30: Print "Specials:"
        Locate 7, 30: Print "Q"
        Locate 8, 30: Print "W"
        Locate 10, 30: Print "A"
        Locate 11, 30: Print "S"

        Locate 13, 30: Print "Super:"
        Locate 14, 30: Print "D"

        Locate 16, 30: Print "Recharges:"
        Locate 17, 30: Print "RG:"
        Locate 18, 30: Print "AW:"

        'Right Panel

        Locate 6, 55: Print "Arm Power Ratings:"
        Locate 7, 55: Print "HP:"
        Locate 8, 55: Print "AW:"

        Locate 9, 55: Print "Leg Power Ratings:"
        Locate 10, 55: Print "HP:"
        Locate 11, 55: Print "AW:"

        Locate 13, 55: Print "Jumping:"
        Locate 14, 55: Print "Alt       Dis"


        Locate 16, 55: Print "Starting Conditions"
        Locate 17, 55: Print "HP:"
        Locate 18, 55: Print "AW:"

        Locate 20, 55: Print "Stun Duration"

        Locate 20, 30: Print "Name"



        'Gray Text (Stats)
        Color 8

        Locate 18, 59
        Select Case head%(1)
            Case 1
                Print "50%"
                Locate 17, 34: Print "4"
                Locate 18, 34: Print "2"

            Case 2
                Print "40%"
                Locate 17, 34: Print "3"
                Locate 18, 34: Print "3"

            Case 3
                Print "30%"
                Locate 17, 34: Print "2"
                Locate 18, 34: Print "4"

            Case 4
                Print "60%"
                Locate 17, 34: Print "5"
                Locate 18, 34: Print "1"

            Case 5
                Print "20%"
                Locate 17, 34: Print "1"
                Locate 18, 34: Print "5"
        End Select


        'Hands
        Locate 7, 32
        Select Case hands%(1)
            Case 1
                Print "Fire Ball"
                Locate 8, 32
                Print "Twin Mini Balls"

            Case 2
                Print "Power Jab"
                Locate 8, 32
                Print "Hammer Punch"

            Case 3
                Print "Neck Jab"
                Locate 8, 32
                Print "Thrust Slam"

            Case 4
                Print "Ball Lightning"
                Locate 8, 32
                Print "Rising Dragon"

            Case 5
                Print "Triple Shrokken"
                Locate 8, 32
                Print "Stun Knuckle"
        End Select


        'Feet
        Locate 10, 32
        Select Case feet%(1)
            Case 1
                Print "Plant Kick"
                Locate 11, 32
                Print "Nee Bash"

            Case 2
                Print "Axe Kick"
                Locate 11, 32
                Print "Lightning Kick Blast"

            Case 3
                Print "Stunning Gut Stab"
                Locate 11, 32
                Print "6-Slip"

            Case 4
                Print "Thrust Kick"
                Locate 11, 32
                Print "Skip Kick"

            Case 5
                Print "Slasher Strike"
                Locate 11, 32
                Print "Upper Assault"
        End Select


        Locate 7, 59
        Select Case arms%(1)
            Case 1
                Print "0"
                Locate 8, 59: Print "5"

            Case 2
                Print "2"
                Locate 8, 59: Print "3"

            Case 3
                Print "3"
                Locate 8, 59: Print "2"

            Case 4
                Print "1"
                Locate 8, 59: Print "4"

            Case 5
                Print "4"
                Locate 8, 59: Print "1"

        End Select




        Locate 14, 59
        Select Case legs%(1)
            Case 1
                Print "7"
                Locate 10, 59: Print "0"
                Locate 11, 59: Print "5"
                Locate 14, 69: Print "16"

            Case 2
                Print "10"
                Locate 10, 59: Print "2"
                Locate 11, 59: Print "3"
                Locate 14, 69: Print "14"

            Case 3
                Print "8"
                Locate 10, 59: Print "3"
                Locate 11, 59: Print "2"
                Locate 14, 69: Print "12"

            Case 4
                Print "14"
                Locate 10, 59: Print "3"
                Locate 11, 59: Print "1"
                Locate 14, 69: Print "10"

            Case 5
                Print "9"
                Locate 10, 59: Print "2"
                Locate 11, 59: Print "2"
                Locate 14, 69: Print "25"
        End Select


        Locate 17, 59
        Select Case body%(1)
            Case 1
                Print "150"
                Locate 14, 32: Print "Vex of Evil"
                Locate 21, 55: Print "5"

            Case 2
                Print "160"
                Locate 14, 32: Print "Energy Blast"
                Locate 21, 55: Print "8"

            Case 3
                Print "170"
                Locate 14, 32: Print "Spear Kick"
                Locate 21, 55: Print "9"

            Case 4
                Print "180"
                Locate 14, 32: Print "Health Up"
                Locate 21, 55: Print "15"

            Case 5
                Print "190"
                Locate 14, 32: Print "Razer Arms"
                Locate 21, 55: Print "18"

            Case 6
                Print "175"
                Locate 14, 32: Print "Neck Snapper"
                Locate 21, 55: Print "10"

            Case 7
                Print "175"
                Locate 14, 32: Print "Swizz Punches"
                Locate 21, 55: Print "11"

            Case 8
                Print "200"
                Locate 14, 32: Print "Upper Bust"
                Locate 21, 55: Print "20"

        End Select

        Locate 21, 30: Print name$(1)


    End If
    '--------------------------------------------------------------- End of Stats

    '----------------------------------------------------------------- 3D Display
    panx = buttx(1) + x%
    smearender
    fighterender
    particlerender

    '--------------------------------------------------------------- Info Display
    Color 15
    If rez% > 7 Then Locate 4, 34 Else Locate 4, 2
    Print "BUILD FIGHTER"
    Locate 22, 6: Color 15: Print "MORE"

    '------------------------------------- Mode 0 (Info Display)
    If sfmode% = 0 Then

        Color 12
        Locate 6, 6: Print "PART       TYPE"
        Color 15
        Locate 7, 6: Print "Head      "; head%(1); "    "
        Locate 8, 6: Print "Body      "; body%(1); "    "
        Locate 9, 6: Print "Arms      "; arms%(1); "    "
        Locate 10, 6: Print "Hands     "; hands%(1); "    "
        Locate 11, 6: Print "Legs      "; legs%(1); "    "
        Locate 12, 6: Print "Feet      "; feet%(1); "    "

        Color 12
        Locate 14, 6: Print "PART       COLOR"
        Color 15
        Locate 15, 6: Print "Head"
        Locate 16, 6: Print "Body"
        Locate 17, 6: Print "Arms"
        Locate 18, 6: Print "Hands"
        Locate 19, 6: Print "Legs"
        Locate 20, 6: Print "Feet"

        Locate 15, 17: Color headc%(1): Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)
        Locate 16, 17: Color bodyc%(1): Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)
        Locate 17, 17: Color armsc%(1) + 8: Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)
        Locate 18, 17: Color handsc%(1) + 8: Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)
        Locate 19, 17: Color legsc%(1) + 8: Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)
        Locate 20, 17: Color feetc%(1) + 8: Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)

        Color 15

        '------------------------------------- Mode 1 (Info Display)
    Else

        Color 12
        Locate 6, 6: Print "NAME"
        Color 15
        Locate 7, 6: Print "Enter     "
        Locate 8, 6: Print "Generate  "

        Color 12
        Locate 10, 6: Print "HAIR"
        Color 15
        Select Case hairt%(1)
            Case 1: hairt$ = "Strait"
            Case 2: hairt$ = "Braid "
        End Select
        Locate 11, 6: Print "Style      "; hairt$
        Select Case hairl%(1)
            Case 0: hairl$ = "Bald  "
            Case 1: hairl$ = "Short "
            Case 2: hairl$ = "Medium"
            Case 3: hairl$ = "Long  "
        End Select
        Locate 12, 6: Print "Length     "; hairl$
        Locate 13, 6: Print "Color     ": Locate 13, 17: Color hairc%(1): Print Chr$(219); Chr$(178); Chr$(177); Chr$(176)

        Color 12
        Locate 15, 6: Print "MISC."
        Color 15

        If solidc% = 1 Then wee$ = "Solid" Else wee$ = "Multi"
        Locate 16, 6: Print "Opponent Colors - "; wee$


    End If


    '----------------------------------------------------------------------------

    If ptfighter% < 7 Then ptfighter% = 7


    Do
        wee$ = UCase$(InKey$)

        'Shift 3D Display
        If wee$ = "4" Or wee$ = Chr$(0) + "K" Then x% = 0: redraw% = 1
        If wee$ = "6" Or wee$ = Chr$(0) + "M" Then x% = -15: redraw% = 1

        If head%(1) < 100 Then
            Select Case wee$

                Case "š"
                    changed% = 1
                    head%(1) = 666
                    nee1x(3) = buttx(1) - 3 * d%(1)
                    nee2x(3) = buttx(1) - 3 * d%(1)
                    foot1x(3) = nee1x(3) + 5 * d%(1)
                    foot2x(3) = nee2x(3) + 5 * d%(1)
                    name$(1) = "Demize"
                    GoTo 37

                Case "Î": head%(1) = 1998: changed% = 1: GoTo 37
                Case "Ð": head%(1) = 2000: changed% = 1: GoTo 37
            End Select
        End If


        '----------------------------------------------------------------- Move Arrow

        Select Case wee$

            Case Is = "8", Chr$(0) + "H"
                Locate ptfighter%, 2: Print " ": ptfighter% = ptfighter% - 1
                If ptfighter% = 6 Then ptfighter% = 7
                If sfmode% = 0 Then
                    If ptfighter% = 14 Then ptfighter% = 12
                    If ptfighter% = 21 Then ptfighter% = 20
                Else
                    If ptfighter% = 10 Then ptfighter% = 8
                    If ptfighter% = 15 Then ptfighter% = 13
                    If ptfighter% = 21 Then ptfighter% = 16
                End If


                '--------------+

            Case Is = "5", "2", Chr$(0) + "P"
                Locate ptfighter%, 2: Print " ": ptfighter% = ptfighter% + 1
                If ptfighter% = 23 Then ptfighter% = 22
                If sfmode% = 0 Then
                    If ptfighter% = 13 Then ptfighter% = 15
                    If ptfighter% = 21 Then ptfighter% = 22
                Else
                    If ptfighter% = 9 Then ptfighter% = 11
                    If ptfighter% = 14 Then ptfighter% = 16
                    If ptfighter% = 17 Then ptfighter% = 22
                End If



        End Select

        Locate ptfighter%, 2: Print Chr$(16)



        '--------------------------------------------------------------------- Select
        If wee$ = " " Or wee$ = Chr$(13) Then

            redraw% = 1
            wee$ = ""

            '------------------------------------- Mode 0 (Selection)
            If sfmode% = 0 Then

                If ptfighter% <= 12 Then changed% = 1

                Select Case ptfighter%

                    Case Is = 7
                        If head%(1) >= 100 Then
                            head%(1) = 1
                            body%(1) = 1
                            arms%(1) = 1
                            hands%(1) = 1
                            legs%(1) = 1
                            feet%(1) = 1
                            nee1x(3) = buttx(1) + 5
                            nee2x(3) = buttx(1) - 1
                            foot1x(3) = nee1x(3) - 1
                            foot2x(3) = nee2x(3) - 3
                        Else
                            If head%(1) < 5 Then head%(1) = head%(1) + 1 Else head%(1) = 1
                        End If

                    Case Is = 9
                        If arms%(1) < 5 Then arms%(1) = arms%(1) + 1 Else arms%(1) = 1

                    Case Is = 10
                        If hands%(1) < 5 Then hands%(1) = hands%(1) + 1 Else hands%(1) = 1

                    Case Is = 8
                        If body%(1) < 8 Then body%(1) = body%(1) + 1 Else body%(1) = 1

                    Case Is = 11
                        If legs%(1) < 5 Then legs%(1) = legs%(1) + 1 Else legs%(1) = 1

                    Case Is = 12
                        If feet%(1) < 5 Then feet%(1) = feet%(1) + 1 Else feet%(1) = 1

                        '--------------------

                    Case Is = 15
                        If headc%(1) < 15 Then headc%(1) = headc%(1) + 1 Else headc%(1) = 1

                    Case Is = 16
                        If bodyc%(1) < 15 Then bodyc%(1) = bodyc%(1) + 1 Else bodyc%(1) = 1

                    Case Is = 17
                        If armsc%(1) < 7 Then armsc%(1) = armsc%(1) + 1 Else armsc%(1) = 1

                    Case Is = 18
                        If handsc%(1) < 7 Then handsc%(1) = handsc%(1) + 1 Else handsc%(1) = 1

                    Case Is = 19
                        If legsc%(1) < 7 Then legsc%(1) = legsc%(1) + 1 Else legsc%(1) = 1

                    Case Is = 20
                        If feetc%(1) < 7 Then feetc%(1) = feetc%(1) + 1 Else feetc%(1) = 1

                        '--------------------

                    Case Is = 22
                        sfmode% = 1: redraw% = 1
                        Locate ptfighter%, 2: Print " "
                        ptfighter% = 7

                End Select


                '------------------------------------- Mode 1 (Selection)
            Else

                Select Case ptfighter%

                    Case Is = 7
                        Locate 21, 30: Print "                         "
                        Locate 21, 30
                        Color 15
                        Input ; "", name$(1)

                    Case Is = 8
                        fightername (1)

                    Case Is = 11
                        If hairt%(1) = 1 Then hairt%(1) = 2 Else hairt%(1) = 1

                    Case Is = 12
                        If hairl%(1) < 3 Then hairl%(1) = hairl%(1) + 1 Else hairl%(1) = 0

                    Case Is = 13
                        If hairc%(1) < 15 Then hairc%(1) = hairc%(1) + 1 Else hairc%(1) = 1

                    Case Is = 16
                        If solidc% = 1 Then solidc% = 0 Else solidc% = 1

                    Case Is = 22
                        sfmode% = 0: redraw% = 1
                        Locate ptfighter%, 2: Print " "
                        ptfighter% = 7

                End Select
            End If
        End If

        '----------------------------------------------------------------------------
        If redraw% = 1 Then 37
    Loop Until wee$ = Chr$(27)

    cbigwindow
    wee$ = ""

    zoom = zoomsave
    panx = panxsave
    pany = panysave

    If changed% = 1 Then stageinit

    '----------------------------------------------------------------------------
End Sub

Sub setfightercpu

    If stage% < 1000 Then
        'Normal
        hairt%(2) = Int(Rnd * 2) + 1
        hairl%(2) = Int(Rnd * 4)
        hairc%(2) = Int(Rnd * 15) + 1
        head%(2) = Int(Rnd * 5) + 1
        arms%(2) = Int(Rnd * 5) + 1
        hands%(2) = Int(Rnd * 4) + 1
        body%(2) = Int(Rnd * 8) + 1
        legs%(2) = Int(Rnd * 5) + 1
        feet%(2) = Int(Rnd * 5) + 1
    Else
        'Master Bean
        hairl%(2) = 3
        hairt%(2) = 1
        head%(2) = 2000
        arms%(2) = 2000
        hands%(2) = 2000
        body%(2) = 2000
        legs%(2) = 2000
        feet%(2) = 2000
    End If

    If stage% < 1000 Then
        If solidc% = 1 Then
            'Solid Colors
            c% = Int(Rnd * 7) + 1
            headc%(2) = c% + 8
            bodyc%(2) = c% + 8
            armsc%(2) = c%
            handsc%(2) = c%
            legsc%(2) = c%
            feetc%(2) = c%

        Else
            'Normal Colors
            headc%(2) = Int(Rnd * 15) + 1
            bodyc%(2) = Int(Rnd * 15) + 1
            armsc%(2) = Int(Rnd * 7) + 1
            handsc%(2) = Int(Rnd * 7) + 1
            legsc%(2) = Int(Rnd * 7) + 1
            feetc%(2) = Int(Rnd * 7) + 1
        End If

    Else
        'Master Bean's Colors
        hairc%(2) = 4
        headc%(2) = 9
        bodyc%(2) = 1
        armsc%(2) = 4
        handsc%(2) = 1
        legsc%(2) = 4
        feetc%(2) = 1
    End If



    If stage% = 15 Then
        hairl%(2) = 0
        head%(2) = 666
        arms%(2) = 666
        hands%(2) = 666
        body%(2) = 666
        legs%(2) = 666
        feet%(2) = 666
        headc%(2) = 4
        bodyc%(2) = 4
        armsc%(2) = 4
        handsc%(2) = 4
        legsc%(2) = 4
        feetc%(2) = 8
    End If



End Sub

Sub setframeskip


    Call smallwindow
    Locate 10, 2: Print "Change Frame Skip Value"

    If frameskip% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 12, 2: Print "1 Render Everything"

    If frameskip% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 13, 2: Print "2 Skip Some Frames"

    If frameskip% = 3 Then mark = 15 Else mark = 7
    Color mark: Locate 14, 2: Print "3 Skip Many Frames"

    If frameskip% = 5 Then mark = 15 Else mark = 7
    Color mark: Locate 15, 2: Print "4 Skip Most Frames"

    10 wee$ = InKey$: If wee$ = "" Then 10
    If wee$ = "1" Then frameskip% = 0
    If wee$ = "2" Then frameskip% = 1
    If wee$ = "3" Then frameskip% = 3
    If wee$ = "4" Then frameskip% = 5

    Call csmallwindow
    wee$ = ""
End Sub

Sub seti16
    smallwindow
    Locate 10, 2: Print "i16 Options"

    If i16m% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 12, 2: Print "1 Show All i16"

    If i16m% = 1 Then mark = 15 Else mark = 7
    Color mark: Locate 13, 2: Print "2 No i16 in Stage Select"

    If i16m% = 2 Then mark = 15 Else mark = 7
    Color mark: Locate 14, 2: Print "3 Don't Show any i16"

    12 wee$ = InKey$: If wee$ = "" Then 12
    Select Case wee$
        Case Is = "1": i16m% = 0
        Case Is = "2": i16m% = 1
        Case Is = "3": i16m% = 2
    End Select

    csmallwindow
End Sub

Sub setko (n)

    Select Case head%(n)
        Case 1: ko(n) = 50
        Case 2: ko(n) = 40
        Case 3: ko(n) = 30
        Case 4: ko(n) = 60
        Case 5: ko(n) = 20
        Case 666: ko(n) = 100
    End Select
End Sub

Sub setparticles

    particleclear

    zoomsave = zoom
    panxsave = panx
    panysave = pany
    ringsave% = ring%

    zoom = .35
    panx = 0
    pany = 0
    ring% = 0


    Call smallwindow
    Locate 10, 2: Print "Max Number of Particles to Display"

    If rez% = 7 Then
        Locate 12, 2: Print " LOW 00 10 20 30 40 50 60 70 80 90 HI"
    Else
        Locate 12, 2: Print "None 00 10 20 30 40 50 60 70 80 90 Many"
    End If
    Color 4
    Locate 16, 2: Print "Press Spacebar To Save."


    p% = particles%

    PCopy 0, 1

    25
    wee$ = InKey$

    '------------------------
    If rez% > 7 Then
        pflip

        'Delay
        flicker = Timer: Do Until Timer - flicker > .000005: Loop

        window2d
        Line (60, 37)-(70, 63), 0, BF
        Line (5, 48)-(45, 49), 0, BF
        window3d

        particle 50, 45, 1, 16, 2
        particle 50, 45, 1, 15, 1
        decay
        particlemove
        particlerender
    End If
    '------------------------

    If p% = particles% Then
        Color 15
        Locate 13, 7 + Int(p% / 3.3): Print "^"

    Else
        Color 7
        Locate 13, 7 + Int(p% / 3.3): Print "^"
        Color 9
        Locate 13, 7 + Int(particles% / 3.3): Print "^"
    End If

    If wee$ = "6" Or wee$ = Chr$(0) + "M" Or wee$ = "+" Or wee$ = "=" Then Locate 13, 7 + Int(p% / 3.3): Print " ": p% = p% + 10
    If wee$ = "4" Or wee$ = Chr$(0) + "K" Or wee$ = "-" Then Locate 13, 7 + Int(p% / 3.3): Print " ": p% = p% - 10
    If p% < 0 Then p% = 0
    If p% > 90 Then p% = 90
    If wee$ = " " Or wee$ = Chr$(13) Then Locate 13, 7 + Int(particles% / 3.3): Print " ": particles% = p%

    If wee$ <> Chr$(27) Then 25

    particleclear
    Call csmallwindow
    wee$ = ""
    zoom = zoomsave
    panx = panxsave
    pany = panysave
    ring% = ringsave%
    Screen , , 0, 0
End Sub

Sub setpath
    Screen 9
    If rez% > 0 Then
        smallwindow
    End If

    Locate 10, 2: Print "SET PATH"
    Locate 11, 2: Print "Please give the working directory of this program."
    Locate 12, 2: Print "Ex.  C:\SFB2"
    Locate 13, 2: Input "", path$
    path$ = UCase$(path$)

    Locate 14, 2: Print "Would you like save this info as C:\SFB2.PTH [Y/N]?"

    30 wee$ = UCase$(InKey$): If wee$ = "" Then 30
    If wee$ = "Y" Then
        Open "c:\sfb2.pth" For Output As #1
        Write #1, path$
        Close #1
    End If
    If rez% > 0 Then csmallwindow
    Cls
End Sub

Sub setrez

    Call smallwindow
    Locate 10, 2: Print "Change Screen Resolution"

    If rez% = 7 Then mark = 15 Else mark = 7
    Color mark: Locate 13, 2: Print "1 (320x200)"

    If rez% = 8 Then mark = 15 Else mark = 7
    Color mark: Locate 14, 2: Print "2 (640x200)"

    If rez% = 9 Then mark = 15 Else mark = 7
    Color mark: Locate 15, 2: Print "3 (640x350)"


    6 wee$ = InKey$: If wee$ = "" Then 6
    If wee$ = "1" Then rez% = 7
    If wee$ = "2" Then rez% = 8
    If wee$ = "3" Then rez% = 9

    If wee$ = Chr$(27) Then 11

    If wee$ <> "1" And wee$ <> "2" And wee$ <> "3" And wee$ <> "4" And wee$ <> "5" Then 6


    11
    Call csmallwindow
    Screen rez%
    Call window3d

    'IF rez% = 8 THEN CALL page2
    wee$ = ""
End Sub

Sub setsound

    smallwindow
    Locate 10, 2: Print "Sound Quality Options"

    If sbsound% = 1 And soundwait% = 3 Then mark = 15 Else mark = 7
    Color mark: Locate 12, 2: Print "1 Best"

    If sbsound% = 1 And soundwait% = 4 Then mark = 15 Else mark = 7
    Color mark: Locate 13, 2: Print "2 Good"

    If sbsound% = 1 And soundwait% = 6 Then mark = 15 Else mark = 7
    Color mark: Locate 14, 2: Print "3 Ok"

    If sbsound% = 1 And soundwait% = 10 Then mark = 15 Else mark = 7
    Color mark: Locate 15, 2: Print "4 Chunky"

    If sbsound% = 0 Then mark = 15 Else mark = 7
    Color mark: Locate 16, 2: Print "5 No Sound"


    29 wee$ = InKey$: If wee$ = "" Then 29
    If wee$ = "1" Then sbsound% = 1: soundwait% = 3
    If wee$ = "2" Then sbsound% = 1: soundwait% = 4
    If wee$ = "3" Then sbsound% = 1: soundwait% = 6
    If wee$ = "4" Then sbsound% = 1: soundwait% = 10
    If wee$ = "5" Then sbsound% = 0

    If sbsound% = 1 Then sbinit

    csmallwindow
    wee$ = ""
End Sub

Sub setstage
    Call bigwindow
    Color 15: Locate 4, 2: Print "Select Stage"
    Color 7: Locate 21, 2: Print "Press Spacebar To Select"
    Color 4
    window2d
    stagewindow 0
    x% = 20: y% = 35

    27
    If x% > 0 And x% < 100 Then Line (x% - 9.5, y% - 9.5)-(x% + 9.5, y% + 9.5), 12, B
    If x% = 20 And y% = 35 Then Slot% = 1
    If x% = 50 And y% = 35 Then Slot% = 2
    If x% = 80 And y% = 35 Then Slot% = 3
    If x% = 20 And y% = 65 Then Slot% = 4
    If x% = 50 And y% = 65 Then Slot% = 5
    If x% = 80 And y% = 65 Then Slot% = 6

    Select Case stageset%
        Case Is = 0: stagepage% = 1
        Case Is = 6: stagepage% = 2
        Case Is = 12: stagepage% = 3
        Case Is = 18: stagepage% = 4

    End Select
    If rez% > 7 Then
        Locate 4, 64: Print "Page"; stagepage%; "Stage"; stageset% + Slot%
    Else
        Locate 4, 32: Print stagepage%; "/"; stageset% + Slot%
    End If

    'Display Stage Name
    setstagename (Slot% + stageset%)
    Locate 22, 2: Print stagename$


    wee$ = InKey$
    If wee$ <> "" Then Line (x% - 9.5, y% - 9.5)-(x% + 9.5, y% + 9.5), 0, B

    If stageset% > 0 Then arrow1% = 1: c% = 12 Else arrow1% = 0: c% = 0
    Line (5, 50)-(8, 40), c%
    Line (5, 50)-(8, 60), c%
    Line (8, 40)-(8, 60), c%

    If stageset% < 12 Then arrow2% = 1: c% = 12 Else arrow2% = 0: c% = 0
    Line (95, 50)-(92, 40), c%
    Line (95, 50)-(92, 60), c%
    Line (92, 40)-(92, 60), c%


    If wee$ = Chr$(0) + "K" Or wee$ = "4" Then
        If x% = 20 Then
            If arrow1% = 1 Then stageset% = stageset% - 6: x% = 80: stagewindow 1
        Else
            x% = x% - 30
        End If
    End If

    If wee$ = Chr$(0) + "M" Or wee$ = "6" Then
        If x% = 80 Then
            If arrow2% = 1 Then stageset% = stageset% + 6: x% = 20: stagewindow 2
        Else
            x% = x% + 30
        End If
    End If

    If wee$ = Chr$(0) + "P" Or wee$ = "5" Or wee$ = "2" Then If y% = 35 Then y% = 65
    If wee$ = Chr$(0) + "H" Or wee$ = "8" Then If y% = 65 Then y% = 35


    If y% < 35 Then y% = 35
    If y% > 65 Then y% = 65

    If wee$ = " " Or wee$ = Chr$(13) Then
        stage% = stageset% + Slot%
        stageinit
        setfightercpu
    End If

    If wee$ <> Chr$(27) And wee$ <> " " And wee$ <> Chr$(13) Then 27

    window3d
    cbigwindow
    setstagename (stage%)
End Sub

Sub setstagename (n%)
    Select Case n%
        Case 1: stagename$ = "Demon's Alter           "
        Case 2: stagename$ = "V-Wing Class B-01       "
        Case 3: stagename$ = "Elky's Arena            "
        Case 4: stagename$ = "Jungle Raft Ride        "
        Case 5: stagename$ = "Defence Complex 10      "
        Case 6: stagename$ = "Picketed Claustrophobia "
        Case 7: stagename$ = "Crushing Casket         "
        Case 8: stagename$ = "Silence                 "
        Case 9: stagename$ = "Extended Altitude 1     "
        Case 10: stagename$ = "Pain By The Inch        "
        Case 11: stagename$ = "79th Street             "
        Case 12: stagename$ = "Extended Altitude 2     "
        Case 13: stagename$ = "Rest In Pieces          "
        Case 14: stagename$ = "Endangered              "
        Case 15: stagename$ = "Lair Of Demize          "
        Case 16: stagename$ = "Empty Slot (Stage 16)   "
        Case 17: stagename$ = "Empty Slot (Stage 17)   "
        Case 18: stagename$ = "Empty Slot (Stage 18)   "
        Case 1000: stagename$ = "Master Bean's Dojo      "
        Case 1001: stagename$ = "Dojo (Tutorial)         "
        Case 1002: stagename$ = "Dojo (Training)         "
    End Select
End Sub

Sub setstars

    zoomsave = zoom
    panxsave = panx
    panysave = pany

    zoom = 1
    panx = 0
    pany = 0


    Call smallwindow
    Locate 10, 2: Print "Number of Stars to Display"

    Locate 12, 2: Print "Min | | | |  Med  | | | | Max"

    Color 4
    Locate 16, 2: Print "Press Spacebar To Save."
    s% = nstars%

    26
    wee$ = InKey$
    If rez% <> 7 Then
        stars3d 50, -50, 0, 230, 50, .5, 15, 15, 15
        stars3d 50, -50, 0, 230, 50, .5, 0, 0, 0
        starsoffset -.001, .001
        pscube 50, -50, 0, 230, 50, .5, 12, 4, 4
    End If

    If s% = nstars% Then
        Color 15
        Locate 13, 6 + s%: Print "^"

    Else
        Color 7
        Locate 13, 6 + s%: Print "^"
        Color 9
        Locate 13, 6 + nstars%: Print "^"
    End If

    If wee$ = "6" Or wee$ = Chr$(0) + "M" Or wee$ = "+" Or wee$ = "=" Then Locate 13, 6 + s%: Print " ": s% = s% + 2
    If wee$ = "4" Or wee$ = Chr$(0) + "K" Or wee$ = "-" Then Locate 13, 6 + s%: Print " ": s% = s% - 2
    If s% < 0 Then s% = 0
    If s% > 20 Then s% = 20
    If wee$ = " " Or wee$ = Chr$(13) Then Locate 13, 6 + nstars%: Print " ": nstars% = s%
    If wee$ <> Chr$(27) Then 26


    Call csmallwindow
    wee$ = ""
    zoom = zoomsave
    panx = panxsave
    pany = panysave

End Sub

Sub settings

    2 redraw% = 0
    bigwindow
    Color 15, 0
    If rez% = 7 Then
        Locate 4, 17: Print "SETTINGS"
    Else
        Locate 4, 37: Print "SETTINGS"
    End If

    Locate 6, 6: Print "Screen Resolution"
    Locate 8, 6: Print "Frame Skipping"
    Locate 10, 6: Print "Game Speed"
    Locate 12, 6: Print "Clear Method"
    Locate 14, 6: Print "Stars"
    Locate 16, 6: Print "Particles"
    Locate 18, 6: Print "i16 Images"
    Locate 20, 6: Print "Graphic Details"
    Locate 22, 6: Print "Sound"

    If ptsettings% = 0 Then ptsettings% = 6

    Do
        wee$ = UCase$(InKey$)
        '----------------------------------------------------------------- Move Arrow
        Select Case wee$
            Case Is = "8", Chr$(0) + "H"
                Locate ptsettings%, 2: Print " "
                If ptsettings% > 6 Then ptsettings% = ptsettings% - 2 Else ptsettings% = 22

            Case Is = "5", "2", Chr$(0) + "P"
                Locate ptsettings%, 2: Print " "
                If ptsettings% < 22 Then ptsettings% = ptsettings% + 2 Else ptsettings% = 6
        End Select
        Locate ptsettings%, 2: Print Chr$(16)

        '--------------------------------------------------------------------- Select
        If wee$ = " " Or wee$ = Chr$(13) Then
            redraw% = 1
            wee$ = ""

            Select Case ptsettings%

                Case Is = 6
                    setrez

                Case Is = 8
                    setframeskip

                Case Is = 10
                    setdelay

                Case Is = 12
                    setcmethod

                Case Is = 14
                    setstars

                Case Is = 16
                    setparticles

                Case Is = 18
                    seti16

                Case Is = 20
                    setdetails

                Case Is = 22
                    setsound

            End Select
        End If

        If redraw% = 1 Then 2
    Loop Until wee$ = Chr$(27)
    cbigwindow
    wee$ = ""
End Sub

Sub smallwindow

    Screen , 0, 0
    Color , 0
    For wee = 0 To 248 Step 1
        Line (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), Int((Rnd * 2) + 7)
    Next wee

    Line (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), 0, BF
    Line (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), 15, B
End Sub

Sub smear (x%, y%, Z, c%)

    If stage% = 4 Then Exit Sub

    Do Until exitloop% = 1 Or wee = 10
        wee = wee + 1
        If smearl%(wee) = 0 Or smearl%(wee) > 300 Then
            exitloop% = 1
            smearl%(wee) = 1
            smearc%(wee) = c%
            smearx%(wee) = x%
            smeary%(wee) = y%
            smearz(wee) = Z
        End If
    Loop
End Sub

Sub smearender
    For wee = 1 To 10

        If smearl%(wee) > 0 Then
            l = smearl%(wee) / 10
            If l > 5 Then l = 5
            psline (smearx%(wee) - l), (smeary%(wee)), (smearz(wee)), (smearx%(wee) + l), (smeary%(wee)), (smearz(wee)), smearc%(wee), 0
        End If

    Next wee
End Sub

Sub splash (n)
    particle (buttx(n)), (butty(n) + (Rnd * 20)), (fighterz(n)), 11, 1
    particle (buttx(n)), (butty(n) + 20), (fighterz(n)), 12, 1
End Sub

Sub stagebackground

    Select Case stage%
        '----------------------------------------------------------------------------
        Case Is = 1


            'lava
            psdline -500, 100, 2, 500, 100, 13, 4, 12, 4, 1
            If stagedetail% = 1 Then
                psdline -375, 100 + bob, 3, 375, 100 - bob, 12, 4, 12, 4, 1
                psdline -250, 100 - bob, 4, 250, 100 + bob, 11, 12, 4, 12, 1
                psdline -125, 100 + bob, 5, 125, 100 - bob, 10, 4, 12, 4, 1
            End If

            'pillar
            pscube -15, 15, 7, 15, 100, 8, 7, 8, 8

            'steam
            stars3d -500, 50, 2, 500, 100, 13, 5, (flash3%), 12
            starsoffset 0, -.01

            'ring
            pscube -200, 0, 5, 200, 15, 10, 7, 7, 7

            For wee = -100 To 100 Step 100
                psdpset (wee), 0, 5.1, 9.9, 8
            Next wee
            For wee = 6.25 To 9.75 Step 1.25
                psline -199, 0, (wee), 199, 0, (wee), 8, 0
            Next wee

            'alter
            pscube -15, -50, 7, 15, 0, 8, 6, 4, 4
            If stagedetail% = 1 Then
                psline -9, -20, 7, 9, -20, 7, 6, 0
                psline -6, -35, 7, 0, -12, 7, 6, 0
                psline 6, -35, 7, 0, -12, 7, 6, 0
                psline -6, -35, 7, 9, -20, 7, 6, 0
                psline 6, -35, 7, -9, -20, 7, 6, 0
            End If
            pscircle 0, -25, 7, 10, 4

            '----------------------------------------------------------------------------
        Case Is = 2

            stars2d 7, 7, 15
            starsoffset -.01, 0

            'far wing
            psline -500, -75, 4.5, 100, -75, 6.5, 8, 0
            psline -250, -75, 4.5, 100, -75, 6.5, 7, 0

            'nose
            psline 200, 0, 4, 400, 40, 3.5, 8, 0
            psline 200, 0, 3, 400, 40, 3.5, 15, 0

            'exhaust
            stars3d -900, -25, 2.5, -625, 75, 4, 9, (flash1%), 15

            'hull
            psdline -600, 75, 2.5, -300, 75, 4.5, 15, 7, 8, 1
            psline -300, 75, 4.5, -200, 40, 3.5, 8, 0
            psline -300, 75, 2.5, -200, 40, 3.5, 15, 0
            psline -200, 40, 3.5, 400, 40, 3.5, 7, 0
            For wee = -150 To 150 Step 50
                psdpset (wee), 0, 3, 4, 7
            Next wee
            psdline -200, 0, 3, 200, 0, 4, 15, 7, 8, 1

            'cargo area
            If stagedetail% = 1 Then
                psline -800, -150, 3.5, -650, -75, 4.5, 8, 0
                psline -800, -150, 3.5, -650, -75, 2.5, 15, 0
                psline -800, -150, 3.5, -350, -150, 3.5, 7, 0
                psline -350, -150, 3.5, -250, -75, 4.5, 8, 0
                psline -350, -150, 3.5, -250, -75, 2.5, 15, 0
            End If
            psdline -650, -75, 2.5, -250, -75, 4.5, 15, 7, 8, 1
            psdline -650, -75, 2.5, -600, 75, 4.5, 15, 7, 8, 1
            psline -250, -75, 4.5, -200, 0, 4, 8, 0
            psline -250, -75, 2.5, -200, 0, 3, 15, 0


            '----------------------------------------------------------------------------
        Case Is = 3

            'horizon
            window2d
            Line (0, 50)-(100, 50), 8
            window3d


            'Ground
            psdline -500, 115, 1, 500, 115, 20, 0, 7, 8, 1

            'Ceiling
            pscube -150, -45, 3, 150, -50, 8, 15, 7, 8

            'Floor
            pscube -150, 110, 3, 150, 115, 8, 15, 7, 8

            'Back Struts
            If stagedetail% = 1 Then
                pscube -145, -45, 7, -125, 110, 7.5, 15, 7, 8
                pscube 145, -45, 7, 125, 110, 7.5, 15, 7, 8
            End If

            'Ring
            pscube -100, 100, 4, 100, 110, 7, 15, 7, 8


            For wee = -60 To 60 Step 40
                psdpset (wee), 100, 4, 7, 7
            Next wee

            For wee = 4.5 To 6.5 Step 1
                psline -100, 100, (wee), 100, 100, (wee), 7, 0
            Next wee

            '----------------------------------------------------------------------------
        Case Is = 4

            starsoffset -.002, 0

            'Trees
            If stagedetail% = 1 Then

                For wee = -2000 To 1000 Step 1500
                    psdline wee + wx, -500, 5, wee + wx, 10, 15, 6, 0, 4, 0
                Next wee

                For wee = -4000 To -2000 Step 1000
                    psdline wee + 250 + wx, -400, 10, wee + 250 + wx, 0, 20, 6, 0, 4, 0
                Next wee

                For wee = -3000 To 1000 - ticker% Step 500
                    psline wee + wx, -400, 25, wee + wx, -700, 1, 2, 0
                Next wee

                For wee = -5000 To 1000 - ticker% Step 1000
                    psline wee + wx, -400, 15, wee + wx, -1000, 1, 2, 0
                Next wee
            End If
            'end trees


            If ticker% < 1000 Then
                stars3d -1000 + wx, wy, 2, -500 + wx, 1 + wy, 6, 9, (flash1%), 15
                psline -1000 + wx, wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
                psline -1000 + wx, wy, 6, 500 + wx, wy, 6, 1, 0
                psline 500 + wx, wy, 6, 1000 + wx, wy, 4, 1, 0
                psline -2000 + wx, 100 + wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
                psline -3000 + wx, 200 + wy, 6, -2000 + wx, 100 + wy, 6, 1, 0
            Else
                psline -2000 + wx, 100 + wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
                psline -3000 + wx, 200 + wy, 6, -2000 + wx, 100 + wy, 6, 1, 0
                psline -5000 + wx, 200 + wy, 6, -3000 + wx, 200 + wy, 6, 1, 0
                psline -6500 + wx, 950 + wy, 4, -6000 + wx, 950 + wy, 6, 1, 0
                psline -6000 + wx, 950 + wy, 6, -5000 + wx, 950 + wy, 6, 1, 0
                psline -5000 + wx, 200 + wy, 6, -5000 + wx, 950 + wy, 6, 1, 0
                stars3d -5000 + wx, 200 + wy, 2, -4500 + wx, 201 + wy, 6, 9, (flash1%), 15
                stars3d -5700 + wx, 950 + wy, 2, -5000 + wx, 951 + wy, 6, 15, (flash1%), 15
            End If

            'raft
            psdline -200 - (bob / 5), 30 - bob, 3, 200 - (bob / 5), 30 + bob, 5, 4, 4, 4, 1
            psdline -200 + (bob / 5), -bob, 3, -200 - (bob / 5), 30 - bob, 5, 4, 4, 4, 0
            psdline 200 - (bob / 5), 30 + bob, 3, 200 + (bob / 5), bob, 5, 4, 4, 4, 0
            psdline -200 + (bob / 5), -bob, 3, 200 + (bob / 5), bob, 5, 6, 6, 6, 1
            psdline -200 + (bob / 5), -bob, 3.5, 200 + (bob / 5), bob, 4.5, 6, 6, 6, 0
            psline -200 + (bob / 5), -bob, 4, 200 + (bob / 5), bob, 4, 6, 0

            If ticker% < 1000 Then
                psline -3000 + wx, 200 + wy, 2, -2000 + wx, 100 + wy, 2, 9, 0
                psline -2000 + wx, 100 + wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
                psline -1000 + wx, wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
                psline -1000 + wx, wy, 2, 500 + wx, wy, 2, 9, 0
                psline 500 + wx, wy, 2, 1000 + wx, wy, 4, 9, 0
            Else
                psline -3000 + wx, 200 + wy, 2, -2000 + wx, 100 + wy, 2, 9, 0
                psline -2000 + wx, 100 + wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
                psline -6500 + wx, 950 + wy, 4, -6000 + wx, 950 + wy, 2, 9, 0
                psline -6000 + wx, 950 + wy, 2, -5000 + wx, 950 + wy, 2, 9, 0
                psline -5000 + wx, 200 + wy, 2, -5000 + wx, 950 + wy, 2, 9, 0
                psline -5000 + wx, 200 + wy, 2, -3000 + wx, 200 + wy, 2, 9, 0
            End If


            '----------------------------------------------------------------------------
        Case Is = 5

            'horizon
            window2d
            Line (0, 50)-(100, 50), 8
            window3d

            'pads
            psdline -200, 0, 5, 200, 0, 15, 15, 7, 8, 1
            psdline 400, 0, 5, 800, 0, 15, 15, 7, 8, 1

            '-----Ship
            If ticker% < 2100 Then
                'landing gear
                psline -60, -25 + wy, 13, -70, wy + trigger1, 13.5, 8, 0
                psline 60, -25 + wy, 13, 70, wy + trigger1, 13.5, 8, 0
                psline 0, -25 + wy, 10, 0, wy + trigger1, 9 + trigger2, 7, 0

                'exhaust
                stars3d -90, -85 + wy, 12, -80, -30 + wy, 13, flash1%, 9, flash1%
                stars3d 80, -85 + wy, 12, 90, -30 + wy, 13, flash1%, 9, flash1%
                starsoffset 0, .005

                'left wing
                psline -75, -100 + wy, 14, -175, -50 + wy, 14, 8, 0
                psline -75, -100 + wy, 10, -175, -50 + wy, 13, 7, 0
                psdline -75, -75 + wy, 12, -90, -92.5 + wy, 14, 7, 8, 8, 1
                psdpset -175, -50 + wy, 11, 15, 7

                'right wing
                psline 75, -100 + wy, 14, 175, -50 + wy, 14, 8, 0
                psline 75, -100 + wy, 10, 175, -50 + wy, 13, 7, 0
                psdline 75, -75 + wy, 12, 90, -92.5 + wy, 14, 7, 8, 8, 1
                psdpset 175, -50 + wy, 11, 15, 7

                'hull
                pscube -75, -100 + wy, 10, 75, -25 + wy, 14, 7, 7, 8

                'nose
                psline -75, -25 + wy, 10, -25, -40 + wy, 6, 8, 0
                psline 75, -25 + wy, 10, 25, -40 + wy, 6, 8, 0
                psline -75, -100 + wy, 10, -25, -40 + wy, 6, 7, 0
                psline 75, -100 + wy, 10, 25, -40 + wy, 6, 7, 0
                psline -25, -40 + wy, 6, 25, -40 + wy, 6, 7, 0
            End If

            'building
            pscube -800, -300, 2, -400, 0, 15, 15, 7, 8



            '----------------------------------------------------------------------------
        Case Is = 6

            'Back Wall "X"
            If stagedetail% = 1 Then
                psline -200, -300, 10, 200, 0, 10, 8, 0
                psline 200, -300, 10, -200, 0, 10, 8, 0

                'Ceiling
                pscube -200, -315, 5, 200, -300, 10, 7, 7, 8

                'floor
                pscube -200, 0, 5, 200, 15, 10, 7, 7, 8

            Else
                'Low detail
                'Ceiling
                psdline -200, -300, 5, 200, -300, 10, 7, 7, 8, 1
                'Floor
                psdline -200, 0, 5, 200, 0, 10, 7, 7, 8, 1
            End If

            For wee = -150 To 150 Step 50
                psdpset wee, 0, 5, 10, 7
            Next wee


            'Walls and Spikes
            If panx < 0 Or zoom > .07 Then
                pscube -196, -300, 5.5, -185, -.5, 9.5, 6, 4, 4
                For wee = -155 To -10 Step 30
                    psline -185, (wee) + 15, 8.5, -175, (wee) + 10, 8.5, 8, 0
                    psline -185, (wee + 30), 8, -175, (wee) + 25, 8, 7, 0
                Next wee
            End If

            If panx >= 0 Or zoom > .07 Then
                pscube 196, -300, 5.5, 185, -.5, 9.5, 6, 4, 4
                For wee = -155 To -10 Step 30
                    psline 185, (wee) + 15, 8.5, 175, (wee) + 10, 8.5, 8, 0
                    psline 185, (wee + 30), 8, 175, (wee) + 25, 8, 7, 0
                Next wee
            End If


            '----------------------------------------------------------------------------
        Case Is = 7

            'Back Wall
            If stagedetail% = 1 Then
                For wee = -400 To 400 Step 200
                    psline wee, -300, 10, wee, 0, 10, 8, 0
                Next wee
            End If

            'Ceiling
            psdline -400, -300, 5, 400, -300, 10, 15, 7, 8, 0
            For wee = -400 To 400 Step 200
                psdpset wee, -300, 5, 10, 7
            Next wee

            'floor
            psdline -400, 0, 5, 400, 0, 10, 15, 7, 8, 0
            For wee = -400 To 400 Step 200
                psdpset wee, 0, 5, 10, 7
            Next wee

            'Crush Walls
            pscube -10 - wx, -300, 5.5, -wx, -.5, 9.5, 6, 4, 4
            pscube wx, -300, 5.5, 10 + wx, -.5, 9.5, 6, 4, 4
            If stagedetail% = 1 Then
                psline -wx, -300, 5.5, -wx, -.5, 9.5, 4, 0
                psline -wx, -300, 9.5, -wx, -.5, 5.5, 4, 0
                psline wx, -300, 5.5, wx, -.5, 9.5, 4, 0
                psline wx, -300, 9.5, wx, -.5, 5.5, 4, 0
            End If

            '----------------------------------------------------------------------------
        Case Is = 8

            'Sky
            window2d
            Line (0, 30)-(100, 30), 4
            Line (0, 40)-(100, 40), 4
            Line (0, 46)-(100, 46), 12
            Line (0, 50)-(100, 50), 14
            window3d


            'Ring
            pscube -400, 0, 1, 400, 25, 21, 15, 7, 8

            If stagedetail% = 1 Then
                psdline -320, 0, 3, 320, 0, 19, 8, 7, 8, 1
                psdline -240, 0, 5, 240, 0, 17, 8, 7, 8, 1
                psdline -160, 0, 7, 160, 0, 15, 8, 7, 8, 1
                psdline -80, 0, 9, 80, 0, 13, 8, 7, 8, 1
            End If

            '----------------------------------------------------------------------------
        Case Is = 9

            'Shocker
            psdline -500, 100, 4, 500, 100, 12, flash1%, flash1%, flash1%, 1


            'Rear Support
            pscube -20, -25, 10, 20, 100, 11, 7, 7, 8

            If stagedetail% = 1 Then
                pscircle 0, 0, 10, 10, 8
                psline -300, -trigger1, 6, 300, trigger1, 10, 7, 0
                psline -300, -trigger1, 10, 300, trigger1, 6, 7, 0
            End If

            'Tilting Ring
            psdline -300, -trigger1, 6, 300, trigger1, 10, 15, 7, 8, 1


            '----------------------------------------------------------------------------
        Case Is = 10

            'Walls
            pscube -225, -300, 6, -200, 15, 8, 15, 7, 8
            pscube 200, -300, 6, 225, 15, 8, 15, 7, 8

            'Top Bar
            psdline -200, -300, 6.8, 200, -300, 7.2, 15, 0, 8, 0

            'Rear Pendulum
            psline wx, -300, 7, wx, -20 - (trigger1 * 10), 7 + trigger1, 7, 0
            psline wx, -15 - (trigger1 * 10), 7 + trigger1, wx, -20 - (trigger1 * 10), 6.5 + trigger1, (trigger3), 0
            psline wx, -15 - (trigger1 * 10), 7 + trigger1, wx, -20 - (trigger1 * 12), 7.5 + trigger1, (trigger3), 0

            'ring
            pscube -200, 0, 6, 200, 15, 8, 9, 9, 1
            psline -200, 0, 6, 200, 0, 8, 1, 0
            psline -200, 0, 8, 200, 0, 6, 1, 0


            '----------------------------------------------------------------------------
        Case Is = 11, 12

            'rear building
            psline -1500, -700, 23, 1500, 0, 23, 8, 1
            If stagedetail% = 1 Then
                For wee = -1000 To 1000 Step 500
                    psline wee, -700, 23, wee, 0, 23, 8, 0
                Next wee
            End If

            'Left building
            If stagedetail% = 1 And panx <= 0 Then
                For wee = -15 To -800 Step -150
                    psdline -1000, wee, 9, -400, wee, 17, 9, 1, 1, 1
                Next wee
            End If
            pscube -1000, -800, 9, -400, 0, 17, 15, 7, 8

            'Right building
            If panx > -200 Then pscube 400, -1000, 9, 1500, 0, 17, 9, 1, 1

            'center building
            pscube -200, -500, 9, 200, 0, 17, 7, 7, 8
            'windows
            If stagedetail% = 1 Then
                For wee = -15 To -450 Step -100
                    psline -190, wee - 60, 9, 190, wee, 9, 9, 1
                    psline -200, wee, 10, -200, wee, 16, 1, 0
                    psline 200, wee, 10, 200, wee, 16, 1, 0
                Next wee
            End If

            psline -200, -500, 9, 200, -500, 17, 7, 0
            psline 200, -500, 9, -200, -500, 17, 7, 0



            '----------------------------------------------------------------------------
        Case Is = 13, 14

            If trigger1 = 0 Or trigger1 = 15 Then

                'Rear fence
                For wee = -175 To 175 Step 25
                    psline (wee), (0), (15), (wee), (-35), (15), 7, 0
                Next wee

                'Side fences
                For wee = 2.5 To 15 Step 1
                    psline (-200), (0), (wee), (-200), (-35), (wee), 7, 0
                    psline (200), (0), (wee), (200), (-35), (wee), 7, 0
                Next wee


                'High Detail Stuff
                If stagedetail% = 1 Then
                    psline (-200), (-20), (15), (200), (-20), (15), 8, 0

                    psline (-200), (-20), (2.5), (-200), (-20), (3.5), 8, 0
                    psline (200), (-20), (2.5), (200), (-20), (3.5), 8, 0

                    psline (-200), (-20), (4.5), (-200), (-20), (15), 8, 0
                    psline (200), (-20), (4.5), (200), (-20), (15), 8, 0
                End If


                'Graves
                For wee = -165 To 35 Step 200
                    pscube wee, -15, 5, wee + 10, 0, 5.1, 7, 7, 8

                    'Far Cross
                    psline wee + 72, -27, 9, wee + 76, 0, 9, 4, 0
                    psline wee + 80, -20, 9, wee + 66, -19, 9, 4, 0

                    'Near Cross
                    psline wee - 22, -27, 7, wee - 26, 0, 7, 4, 0
                    psline wee - 30, -20, 7, wee - 16, -19, 7, 4, 0

                    pscube wee + 100, -15, 8, wee + 110, 0, 8.1, 7, 8, 8
                    psline wee + 50, -15, 10, wee + 60, 0, 10, 7, 1
                    psline wee + 150, -15, 12, wee + 160, 0, 12, 8, 1
                Next wee



                '---------- Dead Tree
                'trunk
                psline 120, 0, 4.8, 125, -23, 5, 4, 0
                psline 130, 0, 4.2, 120, -60, 5, (trigger2), 0
                psline 145, 0, 4.5, 125, -50, 4.9, 4, 0
                psline 150, 0, 5, 125, -75, 5, 4, 0
                psline 50, (-150 + trigger1), 5, 125, -75, 5, 4, 0
                psline 60, (-135 + trigger1), 5, 120, -60, 5, (trigger2), 0
                psline 90, (-100 + trigger1), 4.8, 120, -70, 4.5, 4, 0

                'Incomming branch
                psline 140, (-80 + trigger1), 4, 120, -70, 4.5, 4, 0
                psline 150, (-85 + trigger1), 3, 120, -63, 4.9, 4, 0
                psline 150, (-85 + trigger1), 3, 128, -65, 5, (trigger2), 0


            End If

            '--------------------+


            If stage% = 14 Then

                If stagedetail% = 1 Then
                    '--- Crucifix
                    'Body
                    psline -10, 325, 7, 8, 390, 7, 8, 0
                    psline 10, 325, 7, -8, 390, 7, 8, 0
                    'Legs
                    psline -5, 470, 7, 8, 390, 7, 8, 0
                    psline 5, 470, 7, -8, 390, 7, 8, 0
                    'Feet
                    psline 0, 470, 7, 0, 495, 7, 8, 0
                    'arms
                    psline -9, 355, 7, -55, 370, 7, 8, 0
                    psline -100, 345, 7, -30, 370, 7, 8, 0
                    psline 9, 355, 7, 55, 370, 7, 8, 0
                    psline 100, 345, 7, 30, 370, 7, 8, 0
                End If

                'Room/Ring
                psdline -175, 300, 3, -100, 250, 7, 4, 0, 4, 0
                psdline 175, 300, 3, 100, 250, 7, 4, 0, 4, 0
                pscube -175, 300, 1.5, 175, 500, 7, 12, 4, 4
                pscube -100, 495, 3, 100, 500, 5, 15, 7, 8


                'Steam
                particle (-175 + (Rnd * 350)), (500), (1.5 + (Rnd * 1.5)), 15, 1
                particle (-175 + (Rnd * 350)), (500), (5 + (Rnd * 2)), 15, 1
                stars3d -175, 450, 1.5, 175, 500, 7, 7, 8, 7
                starsoffset 0, -.005
            End If



            '----------------------------------------------------------------------------
        Case Is = 15

            If ticker% < 175 Then
                pscube -250, -300, 1.5, 300, 0, 7, 7, 8, 8
                psline -100.5, -100, 7, -99.5, -80, 7, 8, 1
                psline -101.5, -100, 7, -98.5, -100, 7, 8, 1
                particle -100, -102, 7, 16, 1
            Else


                'Back Room
                If stagedetail% = 1 Then

                    For wee = -100 To 100 Step 50
                        psline (wee), -40, 30, (wee), 0, 30, 4, 0
                    Next wee
                    psline 0, -140, 30, 0, -50, 30, 4, 0
                    psline -25, -70, 30, 25, -70, 30, 4, 0

                    'Hall and Mats
                    psline -100, -100, 15, -50, 0, 15, 0, 2
                    psline 50, -100, 15, 100, 0, 15, 0, 2
                    psline -50, -100, 15, 50, 0, 15, 4, 1
                    pscube -50, -100, 10, 50, 0, 15, 4, 4, 8
                    If ticker% < 300 Then psline -400, -100, 10, -175, 0, 10, 0, 2
                    psline -175, -100, 10, -50, 0, 10, 0, 2
                    psline 50, -100, 10, 175, 0, 10, 0, 2
                    psline -50, -100, 10, 50, 0, 10, 4, 1
                End If


                'Hallway
                If ticker% < 350 Then For wee = -700 To -300 Step 75: psdpset (wee), 0, 3, 6, 8: Next wee
                pscube -800, -100, 3, -200, 0, 6, 4, 4, 4

                'Gate
                psdline -202, trigger3, 3.4, -202, trigger3 - 100, 3.8, 8, 8, 8, 0
                psdline -202, trigger3, 4.2, -202, trigger3 - 100, 4.6, 8, 8, 8, 0
                psdline -203, trigger3, 5, -203, trigger3 - 100, 5.4, 8, 8, 8, 0
                psdpset -201.5, trigger3 - 25, 3, 6, 7
                psdpset -201.5, trigger3 - 75, 3, 6, 7


                'Rear Wall
                psline -100, 0, 10, 100, 0, 10, 4, 0
                psline -200, -200, 10, 200, -200, 10, 4, 0
                psline -100, 0, 10, -200, -200, 10, 4, 0
                psline 100, 0, 10, 200, -200, 10, 4, 0


                'Rear Corners
                psline -100, 0, 10, -200, 0, 6, 4, 0
                psline 100, 0, 10, 200, 0, 6, 4, 0
                psline -200, -200, 10, -200, 0, 6, 4, 0
                psline 200, -200, 10, 200, 0, 6, 4, 0


                'Sides
                psline -200, -200, 2, -200, -200, 10, 4, 0
                psline 200, -200, 2, 200, -200, 10, 4, 0
                psline 200, 0, 3, 200, 0, 6, 4, 0


                If stagedetail% = 1 Then
                    '--- Circle Symbol
                    'Outer Circle
                    psdline -25, 0, 3.5, 25, 0, 6.5, 4, 0, 4, 0
                    psline -25, 0, 3.5, -50, 0, 4, 4, 0
                    psline -60, 0, 4.5, -50, 0, 4, 4, 0
                    psline -60, 0, 4.5, -60, 0, 5.5, 4, 0
                    psline -25, 0, 6.5, -50, 0, 6, 4, 0
                    psline -60, 0, 5.5, -50, 0, 6, 4, 0
                    psline 25, 0, 3.5, 50, 0, 4, 4, 0
                    psline 60, 0, 4.5, 50, 0, 4, 4, 0
                    psline 60, 0, 4.5, 60, 0, 5.5, 4, 0
                    psline 25, 0, 6.5, 50, 0, 6, 4, 0
                    psline 60, 0, 5.5, 50, 0, 6, 4, 0
                    'Inner Design
                    'NS Points
                    psline 0, 0, 6.5, -20, 0, 5, 4, 0
                    psline 0, 0, 3.5, -20, 0, 5, 4, 0
                    psline 0, 0, 6.5, 20, 0, 5, 4, 0
                    psline 0, 0, 3.5, 20, 0, 5, 4, 0
                    'EW Points
                    psline -60, 0, 5, 0, 0, 5.5, 4, 0
                    psline -60, 0, 5, 0, 0, 4.5, 4, 0
                    psline 60, 0, 5, 0, 0, 5.5, 4, 0
                    psline 60, 0, 5, 0, 0, 4.5, 4, 0
                End If

                'Ring of Fire
                If Rnd < .3 Then
                    particle -63, -2, 5, 27, 1
                    particle 63, -2, 5, 27, 1

                    particle -45, -2, 6.2, 27, 1
                    particle 45, -2, 6.2, 27, 1
                    particle -45, -2, 3.7, 27, 1
                    particle 45, -2, 3.7, 27, 1

                    particle 0, -2, 7, 27, 1
                    particle 0, -2, 3, 27, 1

                    particle -20, -2, 6.8, 27, 1
                    particle 20, -2, 6.8, 27, 1
                    particle -20, -2, 3.2, 27, 1
                    particle 20, -2, 3.2, 27, 1

                End If

            End If

            '----------------------------------------------------------------------- Dojo
        Case Is = 1000, 1001, 1002

            'Walls
            pscube -200, -300, 3, 200, 0, 10, 12, 4, 4

            'Weapon Racks
            For wee = 0 To 50 Step 10
                psline (-75 - wee), -55, 10, (-75 - wee), -10, 10, 8, 0
                psline (75 + wee), -55, 10, (75 + wee), -10, 10, 8, 0
            Next wee
            psline -125, -45, 9.8, -75, -45, 9.8, 7, 0
            psline -125, -15, 9.8, -75, -15, 9.8, 7, 0
            psline 125, -45, 9.8, 75, -45, 9.8, 7, 0
            psline 125, -15, 9.8, 75, -15, 9.8, 7, 0


            'Torch Posts
            pscube -150, -35, 7, -154, 0, 7.2, 15, 7, 8
            pscube 150, -35, 7, 154, 0, 7.2, 15, 7, 8


            'fire Pit
            starsoffset 0, -.01
            psdline -25, 0, 8, 25, 0, 9, 7, 8, 8, 1
            stars3d -25, -50, 8, 25, 0, 9, 8, 7, 8

            'Fire
            particle ((Rnd - .5) * 25), -5, 8 + Rnd, 17, 1
            particle -152, -40, 7.1, 16, 1
            particle 152, -40, 7.1, 16, 1



            '----------------------------------------------------------------------------
    End Select
End Sub

Sub stageforground
    Select Case stage%

        '----------------------------------------------------------------------------
        Case Is = 2

            'far wing
            psline -500, -75, 2.5, 100, -75, .5, 7, 0
            psline -250, -75, 2.5, 100, -75, .5, 15, 0


            '----------------------------------------------------------------------------
        Case Is = 3

            'Near Struts
            If stagedetail% = 1 Then
                pscube -145, -45, 3.5, -125, 110, 4, 15, 7, 8
                pscube 145, -45, 3.5, 125, 110, 4, 15, 7, 8
            End If

            '----------------------------------------------------------------------------
        Case Is = 5

            'Missle Launcher
            If stagedetail% = 1 Then
                pscircle 1015 + wx, -7, 3.1, 5, 8
                pscircle 1050 + wx, -7, 3, 5, 8
                pscircle 1135 + wx, -7, 3, 5, 8
                pscube 1125 + wx, -15, 2.3, 1145 + wx, -5, 2.7, 15, 7, 8
                pscube 1026 + wx, -15, 2, 1060 + wx, -5, 3, 15, 7, 8
                pscube 1035 + wx, -30, 2, 1150 + wx, -16, 3, 15, 7, 8
                psline 1015 + wx, -42, 2.5, 1135 + wx, -42, 2.5, 8, 0
                psline 1015 + wx, -42, 2.5, 980 + wx, -47.5, 2.5, 8, 0
                pscube 1000 + wx, -40, 2, 1025 + wx, -5, 3, 15, 7, 8
                pscube 1135 + wx, -55, 2.1, 1145 + wx, -30, 2.9, 15, 7, 8
                pscircle 1015 + wx, -7, 1.9, 5, 15
                pscircle 1050 + wx, -7, 2, 5, 15
                pscircle 1135 + wx, -7, 2, 5, 15

                psline 1015 + wx, -47.5, 2.6, 1135 + wx, -47.5, 2.6, 7, 0
                psline 1015 + wx, -47.5, 2.6, 980 + wx, -47.5, 2.5, 7, 0
                psline 1015 + wx, -54, 2.5, 1135 + wx, -54, 2.5, 15, 0
                psline 1015 + wx, -54, 2.5, 980 + wx, -47.5, 2.5, 15, 0
                psline 1015 + wx, -47.5, 2.4, 1135 + wx, -47.5, 2.4, 15, 0
                psline 1015 + wx, -47.5, 2.4, 980 + wx, -47.5, 2.5, 15, 0
            End If

            '----------------------------------------------------------------------------
        Case Is = 6

            'Spikes
            If panx < 0 Or zoom > .07 Then
                For wee = -155 To -10 Step 30
                    psline -185, (wee) + 15, 7.5, -175, (wee) + 10, 7.5, 7, 0
                    psline -185, (wee + 30), 7, -175, (wee) + 25, 7, 7, 0
                    psline -185, (wee) + 15, 6.5, -175, (wee) + 10, 6.5, 15, 0
                Next wee
            End If

            If panx >= 0 Or zoom > .07 Then
                For wee = -155 To -10 Step 30
                    psline 185, (wee) + 15, 7.5, 175, (wee) + 10, 7.5, 7, 0
                    psline 185, (wee + 30), 7, 175, (wee) + 25, 7, 7, 0
                    psline 185, (wee) + 15, 6.5, 175, (wee) + 10, 6.5, 15, 0
                Next wee
            End If



            '----------------------------------------------------------------------------
        Case Is = 9

            'Near Support
            If stagedetail% = 1 Then pscircle 0, 0, 6, 10, 8
            pscube -20, -25, 5, 20, 100, 6, 15, 7, 8

            '----------------------------------------------------------------------------
        Case Is = 10

            'Near Pendulum
            psline -wx, -300, 7, -wx, -20 - (trigger1 * 10), 7 - trigger1, 7, 0
            psline -wx, -15 - (trigger1 * 10), 7 - trigger1, -wx, -20 - (trigger1 * 12), 6.5 - trigger1, (trigger3), 0
            psline -wx, -15 - (trigger1 * 10), 7 - trigger1, -wx, -20 - (trigger1 * 10), 7.5 - trigger1, (trigger3), 0


            '----------------------------------------------------------------------------
        Case Is = 11

            If zoom > .12 And stagedetail% = 1 Then
                'Left building
                pscube -1500, -800, .1, -400, 0, 3, 15, 7, 8

                'center "building"
                pscube -200, -500, .1, 200, 0, 3, 15, 7, 8

                'Right building
                pscube 400, -1000, .1, 800, 0, 3, 15, 7, 8
            End If



            '----------------------------------------------------------------------------
        Case Is = 13, 14

            If trigger1 = 0 Or trigger1 = 15 Then

                If ticker% < 25 And stage% = 13 Then psline -100, 0, 4, 100, 55, 4, 0, 2

                If stagedetail% = 1 Then psline (-200), (-20), (2.5), (200), (-20), (2.5), 8, 0

                'rain
                rain3d -200, -150, .1, 200, 5, 15, 7, 9, 15, 5
                If ticker% > 400 And stage% = 13 Then rain2d 1, 9, 1, .02

                'Near fence
                For wee = -175 To 175 Step 25
                    psline (wee), (0), (2.5), (wee), (-35), (2.5), 15, 0
                Next wee

            End If



            '----------------------------------------------------------------------------
        Case Is = 15

            If ticker% >= 175 Then
                psline -100, 0, 2, 100, 0, 2, 4, 0
                psline -200, -200, 2, 200, -200, 2, 4, 0
                psline -100, 0, 2, -200, -200, 2, 4, 0
                psline 100, 0, 2, 200, -200, 2, 4, 0


                'Near Corners
                psline -100, 0, 2, -200, 0, 3, 4, 0
                psline 100, 0, 2, 200, 0, 3, 4, 0
                psline -200, -200, 2, -200, 0, 3, 4, 0
                psline 200, -200, 2, 200, 0, 3, 4, 0

            End If

            '----------------------------------------------------------------------------
    End Select
End Sub

Sub stageinit
    If stage% <> 1000 Then If stage% < 1 Or stage% > stages% Then stage% = 1
    If stage% < 50 Then dif% = stage%: AIactive%(2) = 1 Else dif% = 7: AIactive%(2) = 0
    If AIactive%(1) = 1 And AIactive%(2) = 1 Then dif% = 5: stage% = Int(Rnd * 3) + 1: setfightercpu
    If stage% = 15 Then dif% = 7

    ticker% = 0
    soundticker% = 20
    control% = 0
    victory% = 0
    camode% = 0
    bobm = 0
    rebirth% = 0
    particleclear

    For wee = 1 To 10
        smearl%(wee) = 0
    Next wee

    For wee = 1 To 6
        projectile%(wee) = 0
    Next wee

    For wee = 1 To 2
        setbody (wee)
        setko (wee)
        win%(wee) = 0
        rage(wee) = 0
    Next wee


    Select Case stage%

        '---------------------------------------------------------------- Init Stages
        Case Is = 1
            startfight% = 100
            ring% = 200
            midstage = 6

            zoom = 1
            panx = 0
            pany = 75
            panh = 0
            panv = -1.4
            zoomd = -.084
            zoomt = .02: 'Smaller = Zoom More

            floor1 = 0
            floor2 = 120
            bob = 15
            gravity = 1

            wx = 0
            wy = 25
            wz = 0

            trigger1 = 100
            trigger2 = 0
            trigger3 = 0

            fightercompress (1)
            fightercompress (2)

            setfightercpu

            '----------------------------------------------------------------------------
        Case Is = 2
            startfight% = 200
            ring% = 200
            midstage = 3.5

            zoom = .3
            panx = -1000
            pany = 10
            panh = 9.9
            panv = 0
            zoomd = 0
            zoomt = .1

            floor1 = 0
            floor2 = 100
            bob = 5

            gravity = .5

            wx = 0
            wy = 25
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 3
            startfight% = 100
            ring% = 100
            midstage = 5.5

            zoom = .3
            panx = 0
            pany = -500
            panh = 0
            panv = 15
            zoomd = 0
            zoomt = .04

            floor1 = 100
            floor2 = 110
            bob = 5

            gravity = 1

            wx = 0
            wy = 25
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 4
            startfight% = 125
            ring% = 200
            midstage = 4

            zoom = .6
            panx = -2000
            pany = 0
            panh = 25
            panv = 0
            zoomd = 0
            zoomt = .1

            floor1 = 0
            floor2 = 500
            bob = 3

            gravity = 1

            wx = 0
            wy = 25
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 5
            startfight% = 100
            ring% = 400
            midstage = 3.5

            zoom = .1
            panx = 900
            pany = -50
            panh = 0
            panv = 0
            zoomd = .005
            zoomt = .045

            floor1 = 0
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 6
            startfight% = 100
            ring% = 180
            midstage = 7.5

            zoom = .01
            panx = -175
            pany = -100
            panh = 0
            panv = 2
            zoomd = 0
            zoomt = .015

            floor1 = 0
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 7
            startfight% = 125
            ring% = 100
            midstage = 7.5

            zoom = .01
            panx = 380
            pany = -10
            panh = 0
            panv = 0
            zoomd = .001
            zoomt = .02

            floor1 = 0
            floor2 = 0
            bob = 0
            gravity = 1

            wx = 390
            wy = -.1
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 8
            startfight% = 10
            ring% = 400
            midstage = 10

            zoom = .1
            panx = 0
            pany = -300
            panh = 0
            panv = 0
            zoomd = 0
            zoomt = .01

            floor1 = 0
            floor2 = 25
            bob = 0
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 9
            startfight% = 50
            ring% = 300
            midstage = 8

            zoom = .08
            panx = -400
            pany = 50
            panh = 20
            panv = 0
            zoomd = 0
            zoomt = .015

            floor1 = 100
            floor2 = 100
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0


            '----------------------------------------------------------------------------
        Case Is = 10
            startfight% = 100
            ring% = 200
            midstage = 7

            zoom = .07
            panx = 100
            pany = -250
            panh = 0
            panv = 0
            zoomd = 0
            zoomt = .015

            floor1 = 0
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 5
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 15



            '----------------------------------------------------------------------------
        Case Is = 11
            startfight% = 75
            ring% = 200
            midstage = 7

            zoom = .8
            panx = 0
            pany = -1000
            panh = 0
            panv = 10
            zoomd = -.06
            zoomt = .02

            floor1 = 0
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0




            '----------------------------------------------------------------------------
        Case Is = 12
            startfight% = 25
            ring% = 200
            midstage = 13

            'zoom = .8
            'panx = 0
            'pany = -1000
            'panh = 0
            'panv = 10
            'zoomd = -.06
            zoomt = .015

            floor1 = -500
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0



            '----------------------------------------------------------------------------
        Case Is = 13
            startfight% = 25
            ring% = 100
            midstage = 4

            zoom = .1
            panx = 0
            pany = 0
            panh = 0
            panv = -2
            zoomd = 0
            zoomt = .045

            floor1 = 50
            floor2 = 50
            bob = 10
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 12
            trigger3 = .001



            '----------------------------------------------------------------------------
        Case Is = 14
            startfight% = 100
            ring% = 100
            midstage = 4

            'zoom = .1
            'panx = 0
            'pany = 0
            panh = 0
            panv = 5
            zoomd = .005
            zoomt = .045

            floor1 = 495
            floor2 = 500
            bob = 10
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 15
            trigger2 = 0
            trigger3 = 0



            '----------------------------------------------------------------------------
        Case Is = 15

            startfight% = 500
            ring% = 650
            midstage = 4

            zoom = .01
            panx = -200
            pany = -50
            panh = 0
            panv = 0
            zoomd = .01
            zoomt = .003

            floor1 = -400
            floor2 = -400
            bob = 10
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = -100







            '----------------------------------------------------------------------------

            'Dojo
        Case Is = 1000
            startfight% = 1
            ring% = 200
            midstage = 6

            zoom = .1
            panx = 0
            pany = -100
            panh = 0
            panv = .5
            zoomd = 0
            zoomt = .03

            floor1 = 0
            floor2 = 0
            bob = 15
            gravity = 1

            wx = 0
            wy = 0
            wz = 0

            trigger1 = 0
            trigger2 = 0
            trigger3 = 0



            '----------------------------------------------------------------------------
    End Select

    fighterinit


End Sub

Sub stageshifting
    If ticker% < 32767 Then ticker% = ticker% + 1
    If ticker% = 1 Or ticker% = 10 Then setstagename (stage%): fightername (2)
    Select Case stage%


        '----------------------------------------------------------------------------
        Case Is = 1

            If trigger1 > 0 Then trigger1 = trigger1 - 1

            If ticker% = 150 Then camode% = 1
            If headless%(1) = 0 And headless%(2) = 0 Then
                If health%(2) = 0 Then camode% = 2
                If health%(1) = 0 Then camode% = 3
            End If

            For wee = 1 To 2
                If butty(wee) > 75 Then particle (buttx(wee) + ((Rnd - .5) * 10)), (foot1y(wee + 2)), (fighterz(wee)), 17, 1: particle (buttx(wee)), (butty(wee) - (Rnd * 10)), (fighterz(wee)), 18, 1
            Next wee

            'lightning
            If Rnd < .01 Then trigger1 = 5
            If trigger1 > 0 Then
                If Rnd > .5 Then pslightning 0, -25, 7, ((Rnd - .5) * 200), -500, 0, 75, flash1% Else pslightning 0, -25, 7, ((Rnd - .5) * 200), -500, 0, 75, flash2%
            End If

            'Pop Fighters
            If ticker% = 100 Then fighterpop 1: fighterpop 2
            If ticker% < 100 Then
                psline -9 + (Rnd - .5), -20 + (Rnd - .5), 7, 9, -20, 7, flash2%, 0
                psline -6 + (Rnd - .5), -35 + (Rnd - .5), 7, 0, -12, 7, flash2%, 0
                psline 6 + (Rnd - .5), -35 + (Rnd - .5), 7, 0, -12, 7, flash2%, 0
                psline -6 + (Rnd - .5), -35 + (Rnd - .5), 7, 9, -20, 7, flash2%, 0
                psline 6 + (Rnd - .5), -35 + (Rnd - .5), 7, -9, -20, 7, flash2%, 0
                pscircle 0 + (Rnd - .5), -25 + (Rnd - .5), 7, 10, flash2%
            End If

            If ticker% > 70 And ticker% < 100 Then
                For wee = 1 To 2
                    particle headx(wee + 2), heady(wee + 2), fighterz(wee), 15, 3
                    pslightning 0, -25, 7, headx(wee + 2), heady(wee + 2), fighterz(wee), 25, flash2%
                Next wee
            End If

            '----------------------------------------------------------------------------
        Case Is = 2
            If ticker% = 200 Then camode% = 1


            '----------------------------------------------------------------------------
        Case Is = 3

            If ticker% = 45 Then camode% = 1
            For wee = 1 To 2
                If heady(wee + 2) < -45 Then heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
            Next wee

            '----------------------------------------------------------------------------
        Case Is = 4

            'Camera stuff
            If ticker% = 50 Then
                camode% = 1
            Else
                If butty(2) > 50 Then camode% = 2
                If butty(1) > 50 Then camode% = 3
            End If

            'Raft moves with current
            If ticker% < 2637 Then wx = wx + 2 Else wx = wx + .2: wy = wy - .4

            'Water splashes
            For wee = 1 To 2
                If ticker% < 2300 And butty(wee) > 25 And butty(wee) < 35 Then splash (wee)
                If foot1y(wee + 2) > 950 + wy And foot1y(wee + 2) < 975 + wy Then splash wee
            Next wee

            'Raft Splashes when hits water
            If ticker% = 576 Or ticker% = 2626 Then
                gravity = 1
                For wee = -200 To 200 Step 25
                    particle wee, 0, 5, 11, 1
                    particle wee, 10, 3, 11, 2
                Next wee
            End If


            '----------------+
            If ticker% < 1500 Then
                '----1st Half

                'First drop
                If ticker% > 550 And ticker% < 575 Then
                    wy = wy - 4
                    If odds% = 1 Then particle 100 + (Rnd * 100), 20, 3, 13, 1: particle 100 + (Rnd * 100), 20, 5, 13, 2
                End If


                'Slope
                If ticker% > 1000 Then
                    wy = wy - .2
                    If Rnd < .05 Then particle (Rnd * 200), 20, 3, 11, 1: particle (Rnd * 200), 20, 5, 11, 2
                End If

                '----------------+
            Else
                '----2nd Half

                'Tilt raft at waterfall
                If ticker% > 2450 And ticker% < 2625 Then bobm = 0: bob = bob - .14

                'Low G and effects of waterfall
                If ticker% > 2550 And ticker% < 2625 Then
                    gravity = .5
                    wy = wy - 10
                    If Rnd < .2 Then particle 200, 0, 3, 12, 1: particle 200, 0, 5, 12, 1
                End If

                'Drown PLayers at end
                If foot1y(3) > 1000 + wy And foot1y(3) > 1000 + wy Then health%(1) = health%(1) - 1: health%(2) = health%(2) - 1: gravity = .5


                '----------------+
            End If
            '----------------------------------------------------------------------------
        Case Is = 5

            If ticker% < 75 Then wx = wx - 10: panh = -8.05 Else If ticker% > 75 And ticker% < 100 Then wx = wx - 3
            If ticker% > 100 And ticker% < 125 Then panh = panh / 1.06
            If ticker% = 175 Then camode% = 1

            If ticker% > 1600 Then wy = wy - .1
            If ticker% > 1625 And ticker% < 1675 Then trigger2 = trigger2 + .04
            If ticker% > 1650 And ticker% < 1700 Then trigger1 = trigger1 - .5
            If stagedetail% = 1 Then
                If ticker% > 1800 And ticker% < 2080 Then wy = wy - 2: If Rnd < .4 Then particle -85, -85 + wy, 12.5, 8, 1: particle 85, -85 + wy, 12.5, 8, 1
                If ticker% = 2100 Then particle 0, -85 + wy, 13, 5, 50
            End If

            'Wall Stopping
            For wee = 1 To 2
                If (buttx(wee)) < -400 Then buttx(wee) = -400: neckx(wee) = 0: butth(wee) = 0
            Next wee


            '----------------------------------------------------------------------------
        Case Is = 6

            If ticker% = 50 Then camode% = 1
            If headless%(1) = 0 And headless%(2) = 0 Then
                If health%(2) = 0 Then camode% = 2
                If health%(1) = 0 Then camode% = 3
            End If


            For wee = 1 To 2
                If (buttx(wee)) < -ring% Then buttx(wee) = -ring%: butth(wee) = 0

                If (buttx(wee)) < -ring% + 10 And butty(wee) > -165 Then
                    health%(wee) = health%(wee) - 1
                    fighterfreeze (wee)
                    buttv(wee) = -gravity
                    butth(wee) = butth(wee) + .01
                    particle (buttx(wee)), (butty(wee) + (Rnd * necky(wee))), (fighterz(wee)), 4, 1
                End If

                If (buttx(wee)) > ring% Then buttx(wee) = ring%: butth(wee) = 0

                If (buttx(wee)) > ring% - 10 And butty(wee) > -165 Then
                    health%(wee) = health%(wee) - 1
                    fighterfreeze (wee)
                    buttv(wee) = -gravity
                    butth(wee) = butth(wee) - .01
                    particle (buttx(wee)), (butty(wee) + (Rnd * necky(wee))), (fighterz(wee)), 3, 1
                End If

                If heady(wee + 2) < -300 Then heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
            Next wee


            '----------------------------------------------------------------------------
        Case Is = 7

            If ticker% = 100 Then camode% = 1
            If wx <= 0 Then trigger1 = .5
            If wx > ring% Then trigger1 = -.1
            wx = wx + trigger1

            For wee = 1 To 2
                If Abs(buttx(wee)) > Abs(wx) And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

                If (buttx(wee)) < -wx Then buttx(wee) = -wx: butth(wee) = 0: neckx(wee) = 0
                If (buttx(wee)) > wx Then buttx(wee) = wx: butth(wee) = 0: neckx(wee) = 0

                'Crush
                If wx < 3 Then
                    health%(wee) = health%(wee) - 2
                    position%(wee) = 1
                    buttv(wee) = -gravity
                    If Rnd < .5 Then butty(wee) = butty(wee) + ((Rnd - .5) * 10)
                    particle (headx(wee + 2)), (butty(wee)), (fighterz(wee)), 2, 3
                    particle (headx(wee + 2)), (heady(wee + 2) + (Rnd * 20)), (fighterz(wee)), 1, 1
                End If

                If heady(wee + 2) < -300 Then heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
            Next wee

            '----------------------------------------------------------------------------
        Case Is = 8
            If ticker% = 1 Then camode% = 1
            If ticker% = 40 Then panv = 0

            '----------------------------------------------------------------------------
        Case Is = 9

            If ticker% = 45 Then: panh = -35: panv = -5
            If ticker% = 55 Then panh = 0: camode% = 1
            If headless%(1) = 0 And headless%(2) = 0 Then
                If health%(2) = 0 Then camode% = 2
                If health%(1) = 0 Then camode% = 3
            End If

            'Shock Jumping
            If butty(1) > 80 Or butty(2) > 80 Then
                If buttx(1) - buttx(2) < 100 And buttx(2) - buttx(1) < 100 Then
                    health%(1) = health%(1) - 2
                    health%(2) = health%(2) - 2
                    pslightning neckx(3), heady(3) + (Rnd * 25), fighterz(1), neckx(4), heady(4) + (Rnd * 25), fighterz(2), 50, flash2%
                End If
            End If


            For wee = 1 To 2
                If position%(wee) < 8 Or position%(wee) > 11 Then
                    If Abs(buttx(wee)) < Abs(ring%) And foot1y(wee + 2) > ((buttx(wee) * trigger1) / 300) - 2 Then trigger2 = trigger2 + buttx(wee) / 5000: butth(wee) = butth(wee) + (trigger1 / 2500)
                End If
            Next wee

            trigger2 = trigger2 / 1.05

            If Abs(trigger1) > 75 Then trigger2 = 0: If trigger1 > 0 Then trigger1 = 75 Else trigger1 = -75

            trigger1 = trigger1 + trigger2


            '----------------------------------------------------------------------------
        Case Is = 10

            If ticker% < 75 Then panv = 1
            If ticker% = 75 Then camode% = 1
            If headless%(1) = 0 And headless%(2) = 0 Then
                If health%(2) = 0 Then camode% = 2
                If health%(1) = 0 Then camode% = 3
            End If

            trigger2 = trigger2 - .01
            trigger1 = trigger1 + trigger2
            If trigger1 < 0 Then trigger2 = .25: wx = -wx

            'Color Change
            If Rnd < .05 Then
                Select Case trigger3
                    Case Is = 4: trigger3 = 12
                    Case Is = 12: trigger3 = 15
                End Select
            End If

            'Hack
            If trigger1 < .5 Then
                For wee = 1 To 2
                    If butty(wee) > -35 And Abs(buttx(wee)) < 10 And position%(wee) <> 8 And position%(wee) <> 10 Then
                        soundticker% = 0: sbfx 17
                        health%(wee) = health%(wee) - 15
                        ko(wee) = ko(wee) - 3
                        particle (headx(wee + 2)), -20, 7, 1, 10
                        particle (headx(wee + 2)), -20, 7, 18, 10
                        trigger3 = 4
                        buttv(wee) = buttv(wee) - (Rnd * 3)
                        neckx(wee) = neckx(wee) + ((Rnd - .5) * 5)
                    End If
                Next wee
            End If

            'Wall Stopping
            For wee = 1 To 2
                If Abs(buttx(wee)) > Abs(ring%) And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

                If (buttx(wee)) < -ring% Then buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
                If (buttx(wee)) > ring% Then buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
            Next wee


            '----------------------------------------------------------------------------
        Case Is = 11
            If ticker% = 1 Then ring% = 1500
            If ticker% = 50 Then camode% = 1
            For wee = 1 To 2
                If buttx(wee) < -1500 Then buttx(wee) = -1500
                If buttx(wee) > 1500 Then buttx(wee) = 1500
            Next wee

            '----------------------------------------------------------------------------
        Case Is = 12
            If ticker% = 1 Then camode% = 1

            For wee = 1 To 2
                If buttx(wee) < -1500 Then buttx(wee) = -1500
                If buttx(wee) > 1500 Then buttx(wee) = 1500
            Next wee


            'Fall Off Building
            If floor1 < 0 Then
                For wee = 1 To 2
                    If Abs(buttx(wee)) > 400 Then butth(wee) = -butth(wee)
                    If butty(wee) > floor1 And Abs(buttx(wee)) < ring% Then butth(wee) = -butth(wee)

                    If butty(wee) > -450 And butty(wee) < -400 Then fall (wee)
                    If butty(wee) > -50 Then
                        health%(wee) = 0
                        butty(wee) = 0
                        buttv(wee) = 0
                        decap (wee)
                        For n% = 1 To 10
                            particle buttx(wee) + ((Rnd - .5) * 20), -5, fighterz(wee), 2, 1
                            smear buttx(wee) + ((Rnd - .5) * 30), 0, fighterz(wee) + (Rnd - .5), 12
                        Next n%
                    End If
                Next wee

                If butty(1) = 0 And butty(2) = 0 Then camode% = 1: floor1 = 0: ring% = 1500
            End If

            If floor1 = 0 And health%(1) = 100 And health%(2) = 100 Then midstage = 7


            '----------------------------------------------------------------------------
        Case Is = 13

            If ticker% = 10 Then
                buttv(1) = -15
                buttv(2) = -15
                For wee = -10 To 10 Step 2
                    particle (buttx(1) + wee), 0, 4, 24, 1
                    particle (buttx(2) + wee), 0, 4, 24, 1
                Next wee
            End If

            If ticker% = 25 Then
                floor1 = 0
                floor2 = 0
                camode% = 1
            End If

            'Lightning strikes tree
            If ticker% > 399 And ticker% < 415 Then
                If ticker% = 400 Then bgcolor% = 19: trigger1 = 15: trigger2 = 8: blur 5: soundticker% = 0: sbfx 17
                pslightning 100 + (Rnd * 15), -90, 5, 135 + (Rnd * 15), Rnd * 5, 5, 50, flash1%
                pslightning -300, -200, 5, 140, 0, 5, 50, flash2%
                particle 105 + (Rnd * 35), -(Rnd * 70), 4.5, 9, 1
                particle 115 + (Rnd * 30), -(Rnd * 30), 4.5, 15, 1
                particle 115 + (Rnd * 30), -(Rnd * 50), 4.5, 16, 1
            End If

            'Normal Lightning
            If Rnd < .1 Then
                If Rnd < .3 Then
                    bgcolor% = 1
                    n% = ((Rnd - .5) * 500)
                    pslightning (n%), (-300), (5 + (Rnd * 20)), (n%), (0), (5 + (Rnd * 20)), (100), (flash2%)
                Else
                    pslightning ((Rnd - .5) * 800), (-200), (10 + (Rnd * 10)), ((Rnd - .5) * 800), (-200), (10 + (Rnd * 10)), (75), (flash2%)
                End If
            End If


            'Rain
            If trigger3 < .02 Then trigger3 = trigger3 + .00001
            starsoffset (trigger3 / 8), (trigger3)


            '----------------------------------------------------------------------------
        Case Is = 14

            If ticker% < 60 Then
                camode% = 0
                panh = -panx / 1000
                If pany > 475 Then panv = 0
            End If

            If ticker% = 75 Then camode% = 1
            If ticker% = 75 Then trigger1 = 1


            For wee = 1 To 2
                'Burning Feet
                If Abs(buttx(wee)) > 110 And foot1y(wee + 2) > 495 Then
                    If Rnd < .1 Then health%(wee) = health%(wee) - 1
                    If Rnd < .5 Then particle (buttx(wee) + ((Rnd - .5) * 5)), (500), (fighterz(wee)), 16, 1
                End If

                'Wall Stopping
                If Abs(buttx(wee)) > 175 And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5
                If (buttx(wee)) < -175 Then buttx(wee) = -175: butth(wee) = 0: neckx(wee) = 0
                If (buttx(wee)) > 175 Then buttx(wee) = 175: butth(wee) = 0: neckx(wee) = 0

            Next wee





            '----------------------------------------------------------------------------
        Case Is = 15

            If ticker% <= 450 Then

                If ticker% = 1 Then floor1 = 0: floor2 = 0
                If ticker% > 50 And ticker% < 100 Then Locate 10: Color 15: Print "This place is rank!"
                If ticker% > 125 And ticker% < 150 Then butth(1) = 8
                If ticker% > 175 And ticker% < 225 Then Locate 10, 65: Color 4: Print "I smell blood!"
                If ticker% = 175 Then
                    midstage = 4.5
                    panx = -500
                    panh = 5
                    buttx(1) = -375
                    butth(1) = 30
                    fighterz(1) = 5.5
                    buttx(2) = 75
                End If
                If ticker% = 400 Then camode% = 3: zoomd = -.008
                If ticker% > 200 And ticker% <= 300 Then trigger3 = trigger3 + 1
                If ticker% > 250 And ticker% < 350 Then Locate 10, 50: Color 4: Print "I don't know who you are..."
                If ticker% > 350 And ticker% < 400 Then Locate 10, 60: Color 4: Print "But your dead!"
                If ticker% = 450 Then camode% = 1: zoomt = .02



            Else

                For wee = 1 To 2
                    'Hit Head On Roof
                    If heady(wee + 2) < -200 Then heady(wee) = 0: buttv(wee) = 2: health%(wee) = health%(wee) - 8: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 18, 20

                    'Wall Stopping
                    If Abs(buttx(wee)) > 200 And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5
                    If (buttx(wee)) < -200 Then buttx(wee) = -200: butth(wee) = 0: neckx(wee) = 0
                    If (buttx(wee)) > 200 Then buttx(wee) = 200: butth(wee) = 0: neckx(wee) = 0

                Next wee

            End If

            '----------------------------------------------------------------------- Dojo
        Case Is = 1000

            If ticker% = 1 Then health%(2) = maxhp%(2): ko(2) = 75

            If ticker% >= 0 And ticker% < 100 Then
                Color 15: Locate 4
                Print "Welcome to Master Bean's Dojo."
            End If

            If ticker% = 100 Then control% = 1

            If ticker% >= 100 And ticker% < 300 Then
                Color 15: Locate 4
                Print "If you would like to learn to fight"
                Print "come over here and hit me!"
                Print "Otherwise I'm giving you a tutorial."
            End If

            If ticker% = 300 Then
                ticker% = 2
                If health%(2) < maxhp%(2) Then
                    stage% = 1002
                Else
                    stage% = 1001
                End If
            End If



            '------------------------------------------------------------------- Tutorial
        Case Is = 1001

            If ticker% = 3 Then hands%(1) = 4: feet%(1) = 1: body%(1) = 2: head%(1) = 4

            If ticker% < 200 Then
                Color 15: Locate 4
                Print "Tutorial it is. You're wise to seek"
                Print "guidance before getting your head removed."
            End If

            If ticker% = 200 Then panh = 1: zoomd = -.005

            If ticker% >= 200 And ticker% < 300 Then
                Color 15: Locate 4
                Print "My name is Master Bean. I intend to"
                Print "to teach some basics or kill you trying."
            End If

            If ticker% = 300 Then panh = 0

            If ticker% >= 300 And ticker% < 400 Then
                Color 15: Locate 4
                Print "Let us begin."
            End If

            If ticker% = 400 Then panh = -2: control% = 1
            If ticker% = 450 Then camode% = 2

            If ticker% >= 400 And ticker% < 500 Then
                Color 15: Locate 4
                Print "Try moving around using the Number Pad."
            End If

            If ticker% >= 500 And ticker% < 700 Then
                Color 15: Locate 4
                Print "Try pressing Q or W."
            End If

            If ticker% >= 700 And ticker% < 900 Then
                Color 15: Locate 4
                Print "These are your Punches."
            End If

            If ticker% >= 900 And ticker% < 1100 Then
                Color 15: Locate 4
                Print "A and S are Kicks."
            End If

            If ticker% >= 1100 And ticker% < 1300 Then
                Color 15: Locate 4
                Print "Note that keys 5 and 2 both Crouch."
            End If

            If ticker% >= 1300 And ticker% < 1500 Then
                Color 15: Locate 4
                Print "Try pressing 5 then immediately"
                Print "press S. This will do a Sweep."
            End If

            If ticker% = 1500 Then camode% = 1

            If ticker% >= 1500 And ticker% < 1700 Then
                Color 15: Locate 4
                Print "Go ahead and try to sweep me."
                Print "I won't kill you just yet."
            End If

            If ticker% = 1700 Then trigger1 = health%(2)

            If ticker% >= 1700 And ticker% < 1900 Then
                Color 15: Locate 4
                Print "Okay, Now I want you to try an Uppercut."
                Print "Get close and Press 5 then W."
            End If

            If ticker% >= 1900 And ticker% < 2000 Then
                Color 15: Locate 4
                If health%(2) = trigger1 Then
                    Print "Come on, hit me!"
                Else
                    Print "Very Nice!"
                End If
            End If


            If ticker% >= 2000 And ticker% < 2200 Then
                Color 15: Locate 4
                Print "Now I want you to press E."
                Print "This will put you in Special Mode."
            End If

            If ticker% >= 2200 And ticker% < 2400 Then
                Color 15: Locate 4
                Print "Notice the indicator in the corner"
                Print "of the screen when you press E."
            End If

            If ticker% >= 2400 And ticker% < 2600 Then
                Color 15: Locate 4
                Print "Now try pressing Q while in"
                Print "Special Mode to throw Ball Lightning."
            End If

            If ticker% >= 2600 And ticker% < 3000 Then
                Color 15: Locate 4
                Print "Remember that when you do a"
                Print "Special move you exit Special Mode."
                Print "Try your other Special Moves by"
                Print "using other attack keys."
            End If

            If ticker% >= 3000 And ticker% < 3200 Then
                Color 15: Locate 4
                Print "Try doing a Nee Bash."
                Print "Get close to me and press E then S."
            End If

            If ticker% = 3150 Then control% = 0: fighterfreeze (1)

            If ticker% = 3200 Then position%(2) = 86

            If ticker% >= 3250 And ticker% < 3400 Then
                Color 15: Locate 4
                Print "That's for kicking my ass so bad!"
                control% = 1
            End If

            If ticker% >= 3400 And ticker% < 3500 Then
                Color 15: Locate 4
                Print "Stand back and watch."
            End If

            If ticker% = 3480 Then position%(2) = 82: trigger1 = health%(1)

            If ticker% >= 3500 And ticker% < 3600 Then
                Color 15: Locate 4
                If trigger1 > health%(1) Then
                    Print "I told you to sand back!"
                Else
                    Print "I'm glad you didn't eat that."
                End If
            End If

            If ticker% = 3600 Then rage(1) = 100

            If ticker% >= 3600 And ticker% < 3800 Then
                Color 15: Locate 4
                Print "That was an Energy Blast."
                Print "I want you to try now. Press D"
            End If

            If ticker% = 3900 Then control% = 0: camode% = 2

            If ticker% >= 3800 And ticker% < 4000 Then
                Color 15: Locate 4
                Print "The Energy Blast is a type of Super"
                Print "move. See the bar at the bottom left?"
            End If

            If ticker% >= 4000 And ticker% < 4200 Then
                Color 15: Locate 4
                Print "That is your level of Rage."
                Print "Your Rage builds at a constant rate."
            End If

            If ticker% >= 4200 And ticker% < 4400 Then
                Color 15: Locate 4
                Print "When your Rage is at it's full you"
                Print "may release it as a Super like the"
                Print "Energy Blast."
            End If

            If ticker% >= 4400 And ticker% < 4600 Then
                Color 15: Locate 4
                Print "At the top of the screen are your"
                Print "Health and Awareness bars."
            End If

            If ticker% >= 4600 And ticker% < 4800 Then
                Color 15: Locate 4
                Print "When your out of Health your Dead."
                Print "If the Awareness is gone your KO."
            End If

            If ticker% >= 4800 And ticker% < 5000 Then
                Color 15: Locate 4
                Print "...and remember dead people don't"
                Print "have a chance at Round Two."
            End If

            If ticker% >= 5000 And ticker% < 5200 Then
                Color 15: Locate 4
                Print "At the very top of the screen is"
                Print "the current cycles per second."
            End If

            If ticker% >= 5200 And ticker% < 5400 Then
                Color 15: Locate 4
                Print "If the indicator is Red, the game"
                Print "is going too slow or too fast."
            End If

            If ticker% >= 5400 And ticker% < 5600 Then
                Color 15: Locate 4
                Print "You can adjust this by changing"
                Print "settings in the options menus."
            End If

            If ticker% >= 5600 And ticker% < 5800 Then
                Color 15: Locate 4
                Print "A true warrior knows when to be offensive"
                Print "and when to be defensive."
            End If

            If ticker% = 5800 Then control% = 1

            If ticker% >= 5800 And ticker% < 6200 Then
                Color 15: Locate 4
                Print "When you are in Special Mode your"
                Print "awareness level does not recharge."
                Print "Futher more, when you preform most"
                Print "special moves your awareness drops."
            End If

            If ticker% >= 6200 And ticker% < 6400 Then
                Color 15: Locate 4
                Print "A failed attack may actually benefit"
                Print "your opponent! Be wise choosing your"
                Print "attacks."
            End If

            If ticker% >= 6400 And ticker% < 6600 Then
                Color 15: Locate 4
                Print "This is the end of the lesson."
                Print "Prepare for a real fight!"
            End If

            If ticker% = 6600 Then setfighter: camode% = 1

            If ticker% > 6600 Then
                If ticker% < 6650 Then Color 15: Locate 4: Print "End of Lesson!"
                elbow1x(2) = 0
                elbow1y(2) = -5
                hand1x(2) = 0
                hand1y(2) = -4
                pslightning (hand1x(4)), (hand1y(4)), (midstage), (headx(3)), (heady(3)), (midstage), 50, flash2%
                health%(1) = health%(1) - 5
            End If




            'Death's and KO's
            If health%(1) <= 0 And ticker% < 6600 Then Locate 10: Print "Shit! Your no better then the rest!": Print "Get out of here!"
            If health%(2) <= 0 Then Locate 10: Print "Damn the dishonor! I've been beat by my own student!"

            If ko(1) <= 0 Then
                Locate 10
                If win%(2) < 2 Then
                    Print "Get up you wuss! Your better then that!"
                Else
                    Print "Your no fighter! Get out of my dojo!"
                End If
            End If


            'Avoid Projectile
            If projectile%(1) > 0 And position%(2) = 1 And projectilex(1) > buttx(2) - 75 And projectilex(1) < buttx(2) + 75 Then jump 2, 2


            'P2 Health/KO
            If health%(2) < 25 And position%(1) = 1 Then position%(2) = 84
            If ko(2) < 25 Then ko(2) = 25

            'Wall Stopping
            If ticker% < 6400 Then
                For wee = 1 To 2
                    If Abs(buttx(wee)) > Abs(ring%) And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

                    If (buttx(wee)) < -ring% Then buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
                    If (buttx(wee)) > ring% Then buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
                Next wee
            End If

            '------------------------------------------------------------------- Training
        Case Is = 1002

            If ticker% < 100 Then
                Color 15: Locate 4
                If position%(1) > 1 Then
                    If position%(2) = 1 And pticker%(2) > 75 Then position%(2) = 37
                    Print "Calm Yourself!"
                Else
                    Print "Training Begins."
                End If
            End If

            If ticker% = 200 Then camode% = 1: zoomd = -.006: AIactive%(2) = 1

            If ticker% >= 200 And ticker% < 400 Then
                Color 15: Locate 4
                Print "Press Esc when you've had enough."
            End If

            'Inc. difficulty
            trigger1 = trigger1 + 1
            If trigger1 = 1000 Then
                Screen , , 0, 0
                trigger1 = 0: Locate 4
                If dif% < 10 Then
                    dif% = dif% + 1
                    Select Case Int(Rnd * 5) + 1
                        Case 1: Print "I see you didn't come to play games."
                        Case 2: Print "Alright, let's see what you got!"
                        Case 3: Print "Your advancing well."
                        Case 4: Print "Don't back down now."
                        Case 5: Print "Let me teach you about pain!"
                    End Select
                    Print "(Difficulty Increase)"
                Else
                    Print "You've had enough training."
                End If
                For wee = 0 To 10: wee$ = InKey$: Next wee: wee$ = ""
                Sleep
            End If

            'Health/KO
            If health%(1) < 50 And position%(1) = 1 Then position%(1) = 84
            If health%(2) < 50 And position%(2) = 1 Then position%(2) = 84
            If ko(2) < 25 Then ko(2) = 25

            'Wall Stopping
            For wee = 1 To 2
                If Abs(buttx(wee)) > Abs(ring%) And Abs(butth(wee)) > 1 Then health%(wee) = health%(wee) - Abs(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

                If (buttx(wee)) < -ring% Then buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
                If (buttx(wee)) > ring% Then buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
            Next wee

            'Death's and KO's
            If health%(1) <= 5 Then Locate 10: Print "Your good for nothing when your dead!"
            If health%(2) <= 5 Then Locate 10: Print "The gods must be with you..."

            If ko(1) <= 0 Then
                Locate 10
                Print "C'Mon grandma throw some punches!"
            End If


            '----------------------------------------------------------------------------
    End Select
End Sub

Sub stagewindow (mode%)

    If mode% = 1 Then
        For wee = 10 To 90 Step 2
            Line (wee, 25)-(wee + 2, 45), 7, BF
            Line (wee, 65)-(wee + 2, 75), 7, BF
            Line (wee, 25)-(wee - 2, 75), 0, BF
        Next wee
        Line (wee, 25)-(wee - 2, 75), 0, BF
    End If


    If mode% = 2 Then
        For wee = 90 To 10 Step -2
            Line (wee, 25)-(wee - 2, 45), 7, BF
            Line (wee, 65)-(wee - 2, 75), 7, BF
            Line (wee, 25)-(wee + 2, 75), 0, BF
        Next wee
        Line (wee, 25)-(wee + 2, 75), 0, BF
    End If


    wee = 0
    For y = 20 To 50 Step 30
        For x = 5 To 65 Step 30
            wee = wee + 1
            Line (x + 5, y + 5)-(x + 25, y + 25), 7, B
            If i16m% = 0 Then i16 x + 6, y + 6, .363, .355, "stage" + Str$((wee + stageset%) * -1)
        Next x
    Next y
End Sub

Sub stars2d (c1%, c2%, c3%)
    Rem-----------------------------------------------Draw stars

    Window Screen(0, 0)-(1, 1)

    For wee = 1 To nstars%
        PSet (stars1x(wee), stars1y(wee)), c1%
        PSet (stars2x(wee), stars2y(wee)), c2%
        PSet (stars3x(wee), stars3y(wee)), c3%
    Next wee

    Call window3d
End Sub

Sub stars3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)
    Rem-----------------------------------------------Draw stars

    x2 = x2 - x1
    y2 = y2 - y1
    z2 = z2 - z1

    For wee = 1 To nstars%
        x3 = x1 + (stars1x(wee) * x2)
        y3 = y1 + (stars1y(wee) * y2)
        z3 = z1 + (stars1z(wee) * z2)
        pspset (x3), (y3), (z3), c1%

        x3 = x1 + (stars2x(wee) * x2)
        y3 = y1 + (stars2y(wee) * y2)
        z3 = z1 + (stars2z(wee) * z2)
        pspset (x3), (y3), (z3), c2%

        x3 = x1 + (stars3x(wee) * x2)
        y3 = y1 + (stars3y(wee) * y2)
        z3 = z1 + (stars3z(wee) * z2)
        pspset (x3), (y3), (z3), c3%
    Next wee

End Sub

Sub starsoffset (x, y)
    For wee = 1 To nstars%
        stars1x(wee) = stars1x(wee) + x
        stars2x(wee) = stars2x(wee) + (x + x + x)
        stars3x(wee) = stars3x(wee) + (x + x + x + x + x)
        stars1y(wee) = stars1y(wee) + y
        stars2y(wee) = stars2y(wee) + (y + y + y)
        stars3y(wee) = stars3y(wee) + (y + y + y + y + y)

        If x < 0 Then
            If stars1x(wee) < 0 Then stars1x(wee) = 1
            If stars2x(wee) < 0 Then stars2x(wee) = 1
            If stars3x(wee) < 0 Then stars3x(wee) = 1
        Else
            If stars1x(wee) > 1 Then stars1x(wee) = 0
            If stars2x(wee) > 1 Then stars2x(wee) = 0
            If stars3x(wee) > 1 Then stars3x(wee) = 0
        End If

        If y < 0 Then
            If stars1y(wee) < 0 Then stars1y(wee) = 1
            If stars2y(wee) < 0 Then stars2y(wee) = 1
            If stars3y(wee) < 0 Then stars3y(wee) = 1
        Else
            If stars1y(wee) > 1 Then stars1y(wee) = 0
            If stars2y(wee) > 1 Then stars2y(wee) = 0
            If stars3y(wee) > 1 Then stars3y(wee) = 0
        End If
    Next wee

End Sub

Sub starsrnd
    '-------------------------- Randomize Stars
    For wee = 1 To 20
        stars1x(wee) = Rnd
        stars1y(wee) = Rnd
        stars1z(wee) = Rnd
        stars2x(wee) = Rnd
        stars2y(wee) = Rnd
        stars2z(wee) = Rnd
        stars3x(wee) = Rnd
        stars3y(wee) = Rnd
        stars3z(wee) = Rnd
    Next wee

End Sub

Sub window2d
    Window Screen(0, 0)-(100, 100)
End Sub

Sub window3d
    Window Screen(xx1, yy1)-(xx2, yy2)
End Sub

Sub winxwiny

    xx1 = midx% - winx
    yy1 = midy% - winy
    xx2 = midx% + winx
    yy2 = midy% + winy
End Sub

