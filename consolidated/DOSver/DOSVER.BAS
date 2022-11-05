'  DOSVER.BAS
'     by Phil Weber
'  Copyright (c) 1993 DOS Resource Guide Magazine
'  Published in Issue #13, January 1994, page 57.
   
     DEFINT A-Z
     REDIM DosVer(1 TO 13)                  'Create a code buffer.
     DEF SEG = VARSEG(DosVer(1))            'Point to buffer segment
     Address = VARPTR(DosVer(1))            '  and offset.
     FOR I = 0 TO 24                        'Read DosVer code into
         READ A                             '  buffer.
         POKE Address + I, A
     NEXT: CLS                              'Call DosVer and print
     CALL Absolute(Version, Address)        '  the result.
     PRINT USING "DOS Version = #.##"; Version / 100
     END

     DATA 139,220                         : 'Mov  BX,SP
     DATA 139,119,4                       : 'Mov  SI,[BX+4]
     DATA 180,48                          : 'Mov  AH,48
     DATA 205,33                          : 'Int  33
     DATA 50,255                          : 'Xor  BH,BH
     DATA 138,220                         : 'Mov  BL,AH
     DATA 152                             : 'Cbw
     DATA 177,100                         : 'Mov  CL,100
     DATA 246,225                         : 'Mul  CL
     DATA 3,195                           : 'Add  AX,BX
     DATA 137,4                           : 'Mov  [SI],AX
     DATA 202,2,0                         : 'Retf 2

