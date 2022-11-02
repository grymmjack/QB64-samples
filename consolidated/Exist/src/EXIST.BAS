'  EXIST.BAS  
'     by Phil Weber
'  Copyright (c) 1993 DOS Resource Guide Magazine
'  Published in Issue #13, January 1994, page 58.
    
    
     DEFINT A-Z
     REDIM Exist(1 TO 17)                   'Create a code buffer.
     DEF SEG = VARSEG(Exist(1))             'Point to buffer segment
     Address = VARPTR(Exist(1))             '  and offset.
     FOR I = 0 TO 33                        'Read Exist code into
         READ A                             '  buffer.
         POKE Address + I, A
     NEXT
     LINE INPUT "Enter a file spec: "; FileSpec$
     IF LEN(FileSpec$) THEN                 'If the user entered something...
        Temp$ = FileSpec$ + CHR$(0)         'Tack on a null byte for DOS,
        CALL Absolute(Exist, Temp$, Address)     'and call our routine.
        PRINT FileSpec$;
        IF Exist THEN                       'Exist% = -1 if the file
           PRINT " exists!"                 '  spec is found.
        ELSE                                'Otherwise, Exist% = 0.
           PRINT " not found."
        END IF
     END IF
     END

     DATA 139,220                         : 'Mov  BX,SP
     DATA 139,127,6                       : 'Mov  DI,Word Ptr [BX+6]
     DATA 139,119,4                       : 'Mov  SI,Word Ptr [BX+4]
     DATA 70                              : 'Inc  SI
     DATA 70                              : 'Inc  SI
     DATA 139,20                          : 'Mov  DX,Word Ptr [SI]
     DATA 184,0,78                        : 'Mov  AX,4E00h
     DATA 51,201                          : 'Xor  CX,CX
     DATA 205,33                          : 'Int  33
     DATA 199,5,255,255                   : 'Mov  Word Ptr [DI],-1
     DATA 60,0                            : 'Cmp  AL,0
     DATA 116,4                           : 'Jz   Exit
     DATA 199,5,0,0                       : 'Mov  Word Ptr [DI],0
     DATA 202,4,0                         : 'Exit:
                                          : 'Retf 4

