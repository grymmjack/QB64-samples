  '------------------- Portal.BAS -------------------------
  '           PC-to-PC File Transfer Utility
  '                      by
  '                 John Wolfskill
  '
  ' Copyright (C) 1993 DOS Resource Guide
  ' Published in Special Utilities Issue, April 1993
  '
  ' Requires: RS-232C Serial communications port(s)
  '         : Serial null modem cable, or cable adapter
  '         : Microsoft Quickbasic 4.x (or later) compiler
  '--------------------------------------------------------
  '
  DEFINT A-Z
  '$INCLUDE: 'qb.bi'
  DIM regs AS RegTypeX
  ON ERROR GOTO OPENERROR
  ' -- Default protocol values --
  CMD$ = UCASE$(COMMAND$): MODE = 1: MODE$ = "SEND"
  BAUD$ = "19200": PORT$ = "COM1:": BLOCKSIZE& = 1024
  ' --- Initialize variables --
  DIM filename$(500), TAG(500)      ' maximum of 500 files per directory
  ' -- Parse command line tail  --
  GOSUB GETTAIL
  ' -- Initialize strings and video screen --
  SPEC$ = STRING$(64, 32)
  BLANK$ = STRING$(67, 32)
  BLANKFILE$ = STRING$(12, 32)
  SOH$ = CHR$(4)                           ' start of file marker
  EOT$ = CHR$(3)                           ' end of transmission
  XON$ = CHR$(15)                          ' resume sending data
  NACK$ = CHR$(5)                          ' CRC error signal
  TB$ = "TB" + STR$(BLOCKSIZE& * 3) + ","  ' transmit buffer size
  RB$ = "RB" + STR$(BLOCKSIZE& * 3) + ","  ' receive buffer size
  COLOR 15, 1: CLS
  ' -- Verify serial port connections --
  LOCATE 7, 20: PRINT "ษออออออออออออออออออออออออออออออออออออออออป"
  LOCATE 8, 20: PRINT "บ                 PORTAL                 บ"
  LOCATE 9, 20: PRINT "บ    PC-to-PC File Transfer Utility      บ"
  LOCATE 10, 20: PRINT "บ Copyright (c) 1992, DOS Resource Guide บ"
  LOCATE 11, 20: PRINT "ศออออออออออออออออออออออออออออออออออออออออผ"
  LOCATE 14, 22: PRINT "         Scanning port - " + PORT$;
  LOCATE 16, 22: PRINT "  Please start PORTAL.EXE on second PC"
  LOCATE 18, 22: PRINT "        Press <ESC> key to exit";

OPENCOMM:
  CH$ = PORT$ + BAUD$ + ",N,8,1," + TB$ + RB$ + "OP20000"
  OPEN CH$ FOR RANDOM AS #1 LEN = BLOCKSIZE&
  ON ERROR GOTO ERRTRAP: CLS
  SELECT$ = "<CR> Select  <ESC> Exit "
' --
 SCREEN 0: CLS
' -- Display the program screen --
 T$ = STRING$(74, 205)
 TL$ = CHR$(201): TR$ = CHR$(187)
 BL$ = CHR$(200): BR$ = CHR$(188)
 VDBL$ = CHR$(186): BLK2$ = STRING$(74, 32)
 LOCATE 3, 3: PRINT TL$; T$; TR$;
 COL = 3

 FOR ROW = 4 TO 20
  LOCATE ROW, COL: PRINT VDBL$; BLK2$; VDBL$;
 NEXT

 LOCATE 21, 3: PRINT BL$; T$; BR$;
 LOCATE 4, 5: PRINT TL$; MID$(T$, 1, 70); TR$;
 LOCATE 5, 5: PRINT VDBL$; MID$(BLK2$, 1, 70); VDBL$;
 LOCATE 6, 5: PRINT BL$; MID$(T$, 1, 70); BR$;
 LOCATE 5, 7: PRINT "DIRECTORY PATH:";
 '--
 LOCATE 18, 5: PRINT TL$; MID$(T$, 1, 70); TR$;
 LOCATE 19, 5: PRINT VDBL$; MID$(BLK2$, 1, 70); VDBL$;
 LOCATE 20, 5: PRINT BL$; MID$(T$, 1, 70); BR$;

 LOCATE 7, 5: PRINT TL$; MID$(T$, 1, 14); TR$;
 COL = 5

 FOR ROW = 8 TO 16
  LOCATE ROW, COL: PRINT VDBL$; MID$(BLK2$, 1, 14); VDBL$;
 NEXT

 LOCATE 17, 5: PRINT BL$; MID$(T$, 1, 14); BR$;
 '--
 LOCATE 7, 21: PRINT TL$; CHR$(205); TR$;
 COL = 21

 FOR ROW = 8 TO 16
  LOCATE ROW, COL: PRINT VDBL$; " "; VDBL$;
 NEXT

 LOCATE 17, 21: PRINT BL$; CHR$(205); BR$;
 '--
 LOCATE 7, 27: PRINT TL$; MID$(T$, 1, 21); TR$;
 COL = 27

 FOR ROW = 8 TO 10
  LOCATE ROW, COL: PRINT VDBL$; MID$(BLK2$, 1, 21); VDBL$;
 NEXT

 LOCATE 11, 27: PRINT BL$; MID$(T$, 1, 21); BR$;
 '--
 LOCATE 8, 30: PRINT "MODE";
 LOCATE 9, 30: PRINT "BAUD RATE";
 LOCATE 10, 30: PRINT "PORT";
 '--
 LOCATE 8, 52: PRINT TL$; MID$(T$, 1, 23); TR$;
 COL = 52

 FOR ROW = 9 TO 14
  LOCATE ROW, COL: PRINT VDBL$; MID$(BLK2$, 1, 23); VDBL$;
 NEXT

 LOCATE 15, 52: PRINT BL$; MID$(T$, 1, 23); BR$;
 '--
 COLOR 0, 7
 LOCATE 9, 54: PRINT "F1 - Rescan Directory";
 LOCATE 10, 54: PRINT "F2 - Create Directory";
 LOCATE 11, 54: PRINT "F3 - Change Drive    ";
 LOCATE 12, 54: PRINT "F4 - Send/Receive    ";
 LOCATE 13, 54: PRINT "F5 - Tag/Untag Files ";
 LOCATE 14, 54: PRINT "F6 - Quit            ";
 COLOR 15, 1
' --
 LOCATE 12, 27: PRINT TL$; MID$(T$, 1, 21); TR$;
 LOCATE 13, 27: PRINT VDBL$; MID$(BLK2$, 1, 21); VDBL$;
 LOCATE 14, 27: PRINT CHR$(204); MID$(T$, 1, 21); CHR$(185);
 LOCATE 15, 27: PRINT VDBL$; MID$(BLK2$, 1, 21); VDBL$;
 LOCATE 16, 27: PRINT VDBL$; MID$(BLK2$, 1, 21); VDBL$;
 LOCATE 17, 27: PRINT BL$; MID$(T$, 1, 21); BR$;
 '--
 LOCATE 13, 28: PRINT "File   :";
 LOCATE 15, 28: PRINT "Block:       of";
 LOCATE 16, 28: PRINT "Bytes:";
 '--
 COLOR 14, 1
 LOCATE 8, 41: PRINT MODE$;
 LOCATE 9, 41: PRINT BAUD$;
 LOCATE 10, 41: PRINT PORT$;
 COLOR 15, 1
' -- Start of program code --
RESTART:
  GOSUB INITDIRS                    ' gather file info from directories
  LOCATE 8, 7: PRINT filename$(1);
RESTART2:
  GOSUB PRNTMESS
  LOCATE 19, 18: PRINT " -- Select a program function (F1-F6) --";
' -- Main processing loop --
INITLOOP:
 DO
  x$ = INKEY$
	 IF x$ = "" THEN GOTO INITLOOP
	  K = ASC(RIGHT$(x$, 1))
	  IF K = 59 THEN GOSUB INITDIRS: GOTO RESTART     ' rescan directory
	  IF K = 60 THEN GOSUB CREATEDIR: GOTO RESTART    ' create new directory

	  IF K = 61 THEN                                  ' change drive
		GOSUB NEWDRIVE: GOSUB INITDIRS
		GOSUB PRNTMESS: GOTO RESTART                   ' rescan directory
	 END IF

	  IF K = 62 THEN GOSUB CHECKTAGS: GOTO RESTART2   ' transmit/receive
	  IF K = 63 THEN GOSUB SELECTFILES: GOTO RESTART  ' tag/untag files
	  IF K = 64 THEN COLOR 7, 0: CLS : END            ' quit
 LOOP
' -- Find number of tagged files/transfer files --
CHECKTAGS:
  TF = 0                         ' zero files tagged counter

  FOR J = 1 TO NFILES            ' find number of files to transfer
	IF TAG(J) THEN TF = TF + 1
  NEXT

  IF MODE = 1 THEN               ' we are in transmit mode
	IF TF THEN                    ' if there are files tagged
	 GOSUB TRANSMIT               ' transmit them
	ELSE
	 GOSUB PRNTMESS: PRINT "No files tagged.."; : BEEP
	END IF
  END IF

  IF MODE = 2 THEN GOSUB RECEIVE  ' we are in receive mode
  RETURN
' -- Create new subdirectory --
CREATEDIR:
	GOSUB PRNTMESS
	INPUT "Directory name (8 or less letters): "; NEWDIR$
	ON ERROR GOTO DIRECTORYERROR     ' DOS directory error handler
	OPATH$ = PATH$                   ' save the old DOS pathname

	IF INSTR(filename$(1), "*") THEN
	 PATH$ = PATH$ + "\" + NEWDIR$
	ELSE
	 PATH$ = PATH$ + NEWDIR$
	END IF

	MKDIR PATH$             ' create the new directory
	CHDIR PATH$             ' then log it
	GOSUB CLEANDIRECT       ' zero directory flags and strings
	GOSUB INITDIRS          ' rescan the directory
	GOSUB PRNTMESS
	ON ERROR GOTO ERRTRAP   ' switch to main error handler
	RETURN
 ' -- Directory change error handler --
DIRECTORYERROR:
	 DERROR$ = "": GOSUB PRNTMESS

	 IF ERR = 75 THEN
	  DERROR$ = "Invalid directory .."
	  PATH$ = OPATH$
	 END IF

	 DERROR$ = "Disk I/O error .."
	 PRINT DERROR$; " <any key> to continue";
	 x$ = ""

	 DO WHILE x$ = ""
	  x$ = INKEY$
	 LOOP

	 GOSUB PRNTMESS
	 ON ERROR GOTO ERRTRAP
	 RESUME RESTART2
' -- Select a new drive --
NEWDRIVE:
	GOSUB PRNTMESS
	INPUT "New drive letter "; NEWDRIVE$
	IF INSTR(NEWDRIVE$, ":") THEN NEWDRIVE$ = LEFT$(NEWDRIVE$, 1)
	DRIVELETTER = ASC(UCASE$(LEFT$(NEWDRIVE$, 1))) - 65
	IF DRIVELETTER < 0 OR DRIVELETTER > 26 THEN BEEP: GOTO NEWDRIVE
	regs.ax = &HE00            ' DOS INT21 function call &0EH: Setdrive
	regs.dx = DRIVELETTER
	CALL INTERRUPTX(&H21, regs, regs)

9998   OPEN NEWDRIVE$ + ":\TEMP@@@" FOR OUTPUT AS #3
		 CLOSE 3                ' test to confirm drive exists in system
9999  KILL NEWDRIVE$ + ":\TEMP@@@"
		 RETURN
' -- Redisplay directory listing --
INITDIRS:
	GOSUB GETDRIVE
	GOSUB GETDFILES
	ENTRY = 0: FIRST = 1
	IF NFILES < 9 THEN LAST = NFILES ELSE LAST = 9
	GOSUB HIGHLIGHT
	RETURN
' -- Select files --
SELECTFILES:
  GOSUB INITDIRS
  LOCATE 19, 10: PRINT STRING$(57, 32); : LOCATE 19, 7
  PRINT "<Spacebar> Tag/Untag  <+> Tag All  <-> Untag All  <Esc> Exit";

	FOR HH = 1 TO 500
	 TAG(HH) = 0
	NEXT   ' clear all tagged files

DO
SELECTFILES1:
 x$ = INKEY$
	 IF x$ = "" THEN GOTO SELECTFILES1
	  K = ASC(RIGHT$(x$, 1))
		IF K = 13 THEN
		 IF INSTR(filename$(FIRST + ENTRY), "[D]") THEN  ' select file
		 GOSUB CHANGEDIRECT: GOTO SELECTFILES
		END IF
	  END IF

	IF K = 27 THEN
	 LOCATE 19, 7: PRINT STRING$(60, 32);    ' exit routine
	 COLOR 15, 1
	 LOCATE 8 + ENTRY, 7
	 PRINT filename$(FIRST + ENTRY);
	 RETURN
	END IF
	
	IF K = 80 THEN
	 IF ENTRY < 8 THEN
		ENTRY = ENTRY + 1
		GOSUB HIGHLIGHT                        ' next dir entry
	  ELSE
		ENTRY = 8: GOSUB HIGHLIGHT
	  IF FIRST + 8 < NFILES - 1 THEN
		 FIRST = FIRST + 1: LAST = LAST + 1
		 GOSUB HIGHLIGHT
	  END IF
	 END IF
	END IF

	IF K = 72 THEN                             ' prev dir entry
	 IF ENTRY > 0 THEN
		ENTRY = ENTRY - 1
		GOSUB HIGHLIGHT
	  ELSE
		ENTRY = 0
		GOSUB HIGHLIGHT
	  IF FIRST > 1 THEN
		FIRST = FIRST - 1: LAST = LAST - 1
		GOSUB HIGHLIGHT
	  END IF
	 END IF
	END IF

	IF K = 71 THEN GOTO SELECTFILES         ' first dir entry

	IF K = 79 THEN                          ' last dir entry
		FIRST = NFILES - 9
		LAST = NFILES
		ENTRY = 8
		GOSUB HIGHLIGHT
	END IF

	IF K = 81 THEN                         ' PgDn
		IF LAST + 8 < NFILES THEN
		 FIRST = FIRST + 9
		 LAST = LAST + 9
		 GOSUB HIGHLIGHT
		END IF
	END IF

	IF K = 73 THEN                         ' PgUp
		IF FIRST - 8 > 0 THEN
		 FIRST = FIRST - 9
		 LAST = LAST - 9
		 GOSUB HIGHLIGHT
		END IF
	END IF
	
	IF K = 43 OR K = 61 THEN GOSUB TAGALL    ' tag all files
	IF K = 45 OR K = 95 THEN GOSUB UNTAGALL  ' untag all files
	IF K = 32 THEN GOSUB TAGONE              ' tag one file
 LOOP
' -- Display directory entries --
HIGHLIGHT:
 ROW = 8

	 FOR J = FIRST TO LAST
	  LOCATE ROW, 7: PRINT filename$(J); : LOCATE ROW, 22
		 IF TAG(J) THEN
	 COLOR 0, 15: PRINT CHR$(251);
		 ELSE
	 PRINT " ";
		 END IF
		 COLOR 15, 1
		 ROW = ROW + 1
	NEXT

	LOCATE 8 + ENTRY, 7: COLOR 0, 15
	PRINT filename$(FIRST + ENTRY);
	COLOR 15, 1
	RETURN
' -- Tag all files in directory --
TAGALL:
  NTAGGED = 0

  FOR J = 1 TO NFILES
	IF filename$(J) <> "" THEN
	 IF INSTR(filename$(J), "[") = 0 THEN TAG(J) = 1
	END IF
  NEXT

  GOSUB HIGHLIGHT
  RETURN
' -- Tag a single file --
TAGONE:
  IF INSTR(filename$(FIRST + ENTRY), "[") = 0 THEN
	  IF TAG(FIRST + ENTRY) THEN
		 TAG(FIRST + ENTRY) = 0
	  ELSE
		 TAG(FIRST + ENTRY) = 1
	  END IF
	 ELSE
		SOUND 90, 1
  END IF

  GOSUB HIGHLIGHT
  RETURN
' -- Untag all files in directory --
UNTAGALL:

  FOR J = 1 TO NFILES
	IF filename$(J) <> "" THEN
	 IF INSTR(filename$(J), "[") = 0 THEN TAG(J) = 0
	END IF
  NEXT

  GOSUB HIGHLIGHT
  RETURN
 ' -- Change to new subdirectory --
CHANGEDIRECT:
	IF INSTR(filename$(FIRST + ENTRY), "[") = 0 THEN RETURN
	 CHANGE$ = LEFT$(filename$(FIRST + ENTRY), 8)
	 CH$ = RTRIM$(CHANGE$)
	  IF CH$ = "*" THEN RETURN
	  IF CH$ = "**" THEN CH$ = ".."
	  CHDIR CH$
	  GOSUB CLEANDIRECT
	  GOSUB GETDRIVE
	  RETURN
' -- Erase Directory names and tags --
CLEANDIRECT:
	  ERASE filename$, TAG
	  COLOR 15, 1

	  FOR ROW = 8 TO 16
		LOCATE ROW, 7: PRINT BLANKFILE$ + " ";
	  NEXT

	  RETURN
' -- File Transmission loop --
TRANSMIT:
  J = 1: FC = 0                    ' reset file and byte counters

  DO WHILE J < NFILES
	 IF TAG(J) THEN                 ' if the file has been tagged
		GOSUB PARSE                  ' strip blanks from dir entry
		OPEN File$ FOR BINARY AS #2  ' open the file
		TBYTES& = LOF(2)             ' total bytes to transfer

		TBLOCKS& = INT(TBYTES& / BLOCKSIZE&)   ' # of blocks to transfer
		TBLOCK$ = STR$(TBLOCKS&)               ' make it a string
		TBLOCK$ = RIGHT$(TBLOCK$, LEN(TBLOCK$) - 1)

		FRAGMENT& = TBYTES& - (TBLOCKS& * BLOCKSIZE&)     ' number of bytes in
		FRAGMENT$ = STR$(FRAGMENT&)                       ' last partial block.
		FRAGMENT$ = RIGHT$(FRAGMENT$, LEN(FRAGMENT$) - 1) ' (if any)
		LOCATE 13, 37: PRINT BLANKFILE$;                  ' clear the screen
		LOCATE 13, 37: PRINT File$;                       ' print the filename
		GOSUB PRINTTOTAL                                  ' print total bytes

		TF$ = STR$(TF)                                    ' tranmission header
		TF$ = RIGHT$(TF$, LEN(TF$) - 1)                   ' total files to transfer
		IF LEN(TF$) < 3 THEN TF$ = TF$ + STRING$(3 - LEN(TF$), 32)

		 IF LEN(File$) < 12 THEN                          ' filename
	File$ = File$ + STRING$(12 - LEN(File$), 32)
		 END IF

		 IF LEN(TBLOCK$) < 6 THEN                         ' total blocks to transfer
	TBLOCK$ = TBLOCK$ + STRING$(6 - LEN(TBLOCK$), 32)
		 END IF

		IF LEN(FRAGMENT$) < 4 THEN                         ' length of fragment
		 FRAGMENT$ = FRAGMENT$ + STRING$(4 - LEN(FRAGMENT$), 32)
		END IF

		GOSUB PRNTMESS
		PRINT "Sending start signal.. ";

 '-- Handshaking loop ---
	 DO
		 PRINT #1, SOH$                ' send start signal
		 LINE INPUT #1, START$         ' wait for handshake
		 IF START$ = XON$ THEN EXIT DO ' go when it is received
	LOOP

' -- File Transmission loop --
		 GOSUB PRNTMESS
		 FC = FC + 1
		 PRINT "Transmitting file"; FC; " of "; TF;
		 HEADER$ = TF$ + File$ + TBLOCK$ + FRAGMENT$   ' send the header
		 PRINT #1, HEADER$       ' total files tagged
		 BYTES& = 1                                    ' zero the byte counter

	 IF TBLOCKS& THEN     ' send the blocks one at a time
	FOR BLOCKS& = 1 TO TBLOCKS&
RESEND:
		 BLOCK$ = INPUT$(BLOCKSIZE&, #2)   ' get a block from the file
		 GOSUB GETCRC                      ' create a CRC checksum
		 PRINT #1, BLOCK$                  ' send the block
		 PRINT #1, CRC$                    ' and the checksum
		 GOSUB SWAIT                       ' wait for handshake

		 IF BADPACKET THEN                 ' transmission error
			BADPACKET = 0                   ' reset packet bad flag
			SEEK #2, BYTES&                 ' reset file pointer
			GOTO RESEND                     ' resend the block
		 END IF
	
		 LOCATE 15, 35: PRINT USING "####"; BLOCKS&;   ' update display
		 BYTES& = BYTES& + BLOCKSIZE&
		 LOCATE 16, 38: PRINT USING "#######"; BYTES& - 1;
	NEXT
	END IF

RESEND1:
		BLOCK$ = INPUT$(FRAGMENT&, #2)   ' get the parital block (if any)
		GOSUB GETCRC                     ' create a CRC checksum
		PRINT #1, BLOCK$                 ' send the partial block
		PRINT #1, CRC$                   ' and the checksum
		LOCATE 15, 35: PRINT USING "####"; BLOCKS&;  ' update display
		GOSUB SWAIT                      ' wait for handshake

		IF BADPACKET THEN   ' a transmission error has occured
	BADPACKET = 0     ' reset packet bad flag
	SEEK #2, BYTES&   ' reset the file pointer
	GOTO RESEND1      ' resend the fragment block
		END IF

		CLOSE 2             ' close the file
		BYTES& = BYTES& + FRAGMENT&
		LOCATE 16, 38: PRINT USING "#######"; BYTES& - 1;
	END IF

  J = J + 1               ' increment file counter
 LOOP

	GOSUB PRNTMESS
	PRINT "Transmission complete .."; TF; " files transferred";
	SOUND 2000, 2
	T! = TIMER + 3: WHILE TIMER < T!: WEND    ' time delay loop
	RETURN
' -- Wait for handshake signal --
SWAIT:
  HS$ = ""
  DO
		IF LOC(1) > 0 THEN LINE INPUT #1, HS$  ' wait for byte in buffer
		IF HS$ = XON$ THEN RETURN              ' is it the handshake byte?

		IF HS$ = NACK$ THEN                    ' is it the bad packet byte?
		 GOSUB PRNTMESS
		 PRINT "CRC Error..";
		 BEEP
		 BADPACKET = 1     ' set the bad packet flag
		 RETURN
		END IF

  LOOP
' -- File Receive Loop --
RECEIVE:
  J = 1             ' reset file counter
  DO
		 GOSUB PRNTMESS
		 PRINT "Waiting for start signal ..";
		 COLOR 15, 1

		 IF THATSALL THEN    ' has last file been received ?
	THATSALL = 0       ' reset last file flag
	GOSUB PRNTMESS
	PRINT "Transmission complete .."; TF; " files transferred";
	SOUND 4000, 2
	T! = TIMER + 3: WHILE TIMER < T!: WEND ' time delay loop
	RETURN
		 END IF
	 ' -- Handshaking loop --
		 START$ = ""
		 DO
	x$ = INKEY$
	  IF LOC(1) THEN LINE INPUT #1, START$   ' wait for start signal
	  IF x$ = CHR$(27) THEN RETURN        ' does the user want to abort
	  IF START$ = SOH$ THEN EXIT DO       ' do we have a start signal
		 LOOP

	PRINT #1, XON$                ' yes, send the XON byte
	GOSUB PRNTMESS
	PRINT "Checksum .. ";
	LOCATE 19, 41: PRINT "=";
	LINE INPUT #1, HEADER$       ' read the file header

	TF = VAL(RTRIM$(MID$(HEADER$, 1, 3)))         ' number of files
	File$ = RTRIM$(MID$(HEADER$, 4, 12))          ' filename
	TBLOCKS& = VAL(RTRIM$(MID$(HEADER$, 16, 6)))  ' # blocks to receive
	FRAGMENT& = VAL(RTRIM$(MID$(HEADER$, 22, 4))) ' size of fragment (if any)

	LOCATE 13, 37: PRINT BLANKFILE$;    ' clear the display
	LOCATE 13, 37: PRINT File$;         ' display the filename
	GOSUB PRINTTOTAL
	
	OPEN File$ FOR BINARY AS #2         ' Create the file
	BYTES& = 1: BLOCKS& = 0             ' reset byte and block counters

	 IF TBLOCKS& THEN
		 FOR BLOCKS& = 1 TO TBLOCKS&        ' receive the blocks
RESEND3:
			 BLOCK$ = INPUT$(BLOCKSIZE&, 1)  ' get the blocksize
			 DUMP$ = INPUT$(1, 1)            ' skip this byte
			 Check$ = INPUT$(1, 1)           ' get the CRC checksum
			 DUMP$ = INPUT$(1, 1)            ' skip this byte
			 GOSUB GETCRC                    ' compare CRC checksums

		 IF CRC$ <> Check$ THEN             ' checksums don't match.. BAD
			 PRINT #1, NACK$                 ' send bad packet byte
			 SEEK #2, BYTES&                 ' reset file pointer
			 GOSUB PRNTMESS: SOUND 90, 1
			 PRINT "CRC Error ..";
			 GOTO RESEND3                    ' wait for re-transmission
		  ELSE
			GOSUB PRINTCHECK                 ' print the OK checksum
		 END IF

			PUT #2, , BLOCK$                 ' store the block
			LOCATE 15, 35: PRINT USING "####"; BLOCKS&;
			BYTES& = BYTES& + BLOCKSIZE&
			LOCATE 16, 38: PRINT USING "#######"; BYTES& - 1;
			PRINT #1, XON$                   ' send the handshake byte
		NEXT
	END IF

RESEND4:
			BLOCK$ = INPUT$(FRAGMENT&, 1)  ' receive partial block (if any)
			DUMP$ = INPUT$(1, 1)           ' skip this byte
			Check$ = INPUT$(1, 1)          ' get the checksum
			DUMP$ = INPUT$(1, 1)           ' skip this byte
			GOSUB GETCRC                   ' compare the checksum

		 IF CRC$ <> Check$ THEN           ' checksums don't match ..BAD
			 PRINT #1, NACK$               ' send bad packet byte
			 SEEK #2, BYTES&               ' reset file pointer
			 GOSUB PRNTMESS: SOUND 90, 1
			 PRINT "CRC Error ..";
			 GOTO RESEND4                  ' wait for re-transmission
		 ELSE
			 GOSUB PRINTCHECK              ' print the checksum
		 END IF

		LOCATE 15, 35: PRINT USING "####"; BLOCKS&;
		PUT #2, , BLOCK$                ' store the fragment block (if any)
		CLOSE 2                         ' close the file
		BYTES& = BYTES& + FRAGMENT&     ' increment byte count
		LOCATE 16, 38: PRINT USING "#######"; BYTES& - 1;
		PRINT #1, XON$                  ' send the handshake byte
		J = J + 1                       ' increment the file counter

	IF J > TF THEN THATSALL = 1        ' set flag if last file
	 LOOP

' -- Print checksum values --
PRINTCHECK:
	LOCATE 19, 38
	PRINT USING "###"; ASC(Check$);
	LOCATE 19, 42
	PRINT USING "###"; ASC(CRC$);
	RETURN
' -- Print total number of blocks --
PRINTTOTAL:
 LOCATE 15, 44

  IF TBLOCKS& THEN
	 PRINT USING "#####"; TBLOCKS& + 1;
  ELSE
	 PRINT "    1";
  END IF

 RETURN
' -- Calculate CRC checksum --
GETCRC:
 REMAINDER = 0

 FOR CS = 1 TO LEN(BLOCK$)
  REMAINDER = (ASC(MID$(BLOCK$, CS, 1)) + REMAINDER) MOD 255
  NEXT

 CRC$ = CHR$(REMAINDER)
 RETURN
' -- Remove blanks from directory entry --
PARSE:
	 File$ = "": EXT$ = "": POSITION = 1

	  DO WHILE POSITION <= LEN(filename$(J))
		TA$ = MID$(filename$(J), POSITION, 1)
		 IF TA$ = " " THEN GOSUB GETEXTENSION: EXIT DO
		 File$ = File$ + TA$
		 POSITION = POSITION + 1
		LOOP

	 File$ = File$ + EXT$
	 RETURN
' -- Add filename extension to directory entry --
GETEXTENSION:
	 DO WHILE POSITION <= LEN(filename$(J))
		XTA$ = MID$(filename$(J), POSITION, 1)
		IF XTA$ <> " " THEN EXT$ = EXT$ + XTA$
		POSITION = POSITION + 1
	 LOOP

	 IF EXT$ > "" THEN EXT$ = "." + EXT$
	 RETURN
' -- Get Directory entries from DOS --
GETDFILES:
	 PATH1$ = "*.*" + CHR$(0): NFILES = 1
	 GOSUB FINDFIRST
	  IF LASTFILE = 18 THEN GOSUB RESETDTA: RETURN
	 GOSUB FORMATENTRY
	  NFILES = NFILES + 1

  DO
	 GOSUB FINDNEXT
	 IF LASTFILE = 18 THEN EXIT DO
	 GOSUB FORMATENTRY
	 NFILES = NFILES + 1
  LOOP

  GOSUB RESETDTA
  RETURN
'-- Get Current drive & path --
GETDRIVE:
	SPEC$ = STRING$(64, 32)
	regs.ax = &H1900
	CALL INTERRUPTX(&H21, regs, regs)
	DRIVE$ = CHR$((regs.ax AND 255) + 65) + ":\"
	regs.ax = &H4700
	regs.ds = -1
	regs.si = SADD(SPEC$)
	regs.dx = 0
	CALL INTERRUPTX(&H21, regs, regs)
	PATH$ = DRIVE$ + RTRIM$(SPEC$)
	PATH$ = LEFT$(PATH$, LEN(PATH$) - 1)
	LOCATE 5, 24: PRINT STRING$(51, 32);
	LOCATE 5, 24: PRINT PATH$;
	RETURN
 '-- Find first matching filename --
FINDFIRST:
	GOSUB GETDTA
	GOSUB SETDTA
	regs.ax = &H4E00  ' Find first matching file
	regs.cx = &H10    ' Normal/Dir files only
	regs.ds = VARSEG(PATH1$)
	regs.dx = SADD(PATH1$)
	CALL INTERRUPTX(&H21, regs, regs)
	LASTFILE = regs.ax
	RETURN
' -- Find next matching filename --
FINDNEXT:
	regs.ax = &H4F00 ' Find next matching file
	regs.cx = &H10   ' Normal/Dir files only
	regs.ds = VARSEG(PATH1$)
	regs.dx = SADD(PATH1$)
	CALL INTERRUPTX(&H21, regs, regs)
	LASTFILE = regs.ax
	RETURN
' -- Save Disk Transfer buffer address --
GETDTA:
	regs.ax = &H2F00  ' Get DTA address
	CALL INTERRUPTX(&H21, regs, regs)
	OLDSEGMENT = regs.es
	OLDOFFSET = regs.bx
	RETURN
' -- Set New DTA --
SETDTA:
	DTA$ = SPACE$(43)   ' Set DTA address
	regs.ax = &H1A00
	regs.ds = VARSEG(DTA$)
	regs.dx = SADD(DTA$)
	CALL INTERRUPTX(&H21, regs, regs)
	RETURN
'-- Reset Old DTA --
RESETDTA:
	regs.ax = &H1A00
	regs.ds = OLDSEGMENT
	regs.dx = OLDOFFSET
	CALL INTERRUPTX(&H21, regs, regs)
	RETURN
' -- Format directory entries --
FORMATENTRY:
	 B = ASC(MID$(DTA$, 22, 1))
	 FTEMP$ = RIGHT$(DTA$, 13)
	 A = INSTR(FTEMP$, CHR$(0))
	 IF A THEN FTEMP$ = LEFT$(FTEMP$, A - 1)

	 IF (B AND 16) THEN
		IF INSTR(FTEMP$, "..") THEN FTEMP$ = "**      "
		IF INSTR(FTEMP$, ".") THEN FTEMP$ = "*"
		FTEMP$ = FTEMP$ + ".[D]"
	END IF

	C = INSTR(FTEMP$, ".")

	IF C THEN
	  FM$ = LEFT$(FTEMP$, C - 1)
	  E$ = RIGHT$(FTEMP$, LEN(FTEMP$) - C)
	  FTEMP$ = FM$ + STRING$(11 - C, " ") + E$
	 END IF

	filename$(NFILES) = FTEMP$
	RETURN
' -- Open Channel errortrap --
OPENERROR:
  x$ = INKEY$   ' It may require up to 30 seconds to activate this routine
  IF x$ = CHR$(27) THEN CLS : END
  RESUME OPENCOMM
'-- Main Error Handler --
ERRTRAP:
  GOSUB PRNTMESS

  IF ERL = 9998 OR ERL = 9999 THEN
	PRINT "Drive or path is invalid.."; : GOTO EKEY0
  END IF

  IF ERR > 51 THEN
	PRINT "Disk I/O error.."; ERR;
  ELSE
	PRINT "Proceeding after error "; ERR;
  END IF

EKEY0:
  BEEP: PRINT " Press <ANY KEY> ..";

EKEY:
	DO
	 x$ = INKEY$
	  IF x$ > "" THEN EXIT DO
	LOOP
  CLOSE 2

	RESUME RESTART2
 ' -- Blank message area --
PRNTMESS:
	 LOCATE 19, 7: PRINT BLANK$;
	 LOCATE 19, 23
	 RETURN
' -- Parse the DOS command tail --
GETTAIL:

  IF INSTR(CMD$, "?") THEN         ' print the help screen
	PRINT "USAGE: PORTAL M=[mode] B=[baud rate] P=[port] S=[blocksize] ";
	PRINT "The default values are:  M=S B=19200 P=1 S=1024"
	PRINT "Where: Communications mode      (M=) is SEND"
	PRINT "       Baud rate                (B=) is 19200 bps"
	PRINT "       Communications port      (P=) is COM1"
	PRINT "       Communications blocksize (S=) is 1K (1024 bytes)"
	PRINT
	PRINT "Optional values are:"
	PRINT "  M=R     start program in receive mode"
	PRINT "  B=4800  use 4800 bps transmit/receive rate"
	PRINT "  B=9600  use 9600 bps transmit/receive rate"
	PRINT "  P=2     use COM2"
	PRINT "  S=2048  use 2K transmission blocksize"
	PRINT "  S=4096  use 4K transmission blocksize"
	END
  END IF

	P = INSTR(CMD$, "M=")     ' selected communications mode

	IF P THEN
	  IF INSTR(P + 2, CMD$, "R") THEN MODE = 2: MODE$ = "RECEIVE"
	END IF

  P = INSTR(CMD$, "B=")        ' selected baud rate

	IF P THEN
	 IF INSTR(P + 2, CMD$, "9600") THEN BAUD$ = "9600"
	 IF INSTR(P + 2, CMD$, "4800") THEN BAUD$ = "4800"
	END IF

  P = INSTR(CMD$, "P=")        ' selected COM port
	IF P THEN
	 IF INSTR(P + 2, CMD$, "2") THEN PORT$ = "COM2:"
	END IF

  P = INSTR(CMD$, "S=")

	IF P THEN                   ' selected block size
	 IF INSTR(P + 2, CMD$, "2") THEN BLOCKSIZE& = 2048
	 IF INSTR(P + 2, CMD$, "4") THEN BLOCKSIZE& = 4096
	END IF

  RETURN

