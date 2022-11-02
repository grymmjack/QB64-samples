CLS
    AX = 1
    BX = 0
    CX = 0
    DX = 0
INTnum = 51

DIM Code%(22)
LoadCount% = 0
Segment = VARSEG(Code%(0))
 Offset = VARPTR(Code%(0))

DEF SEG = Segment

FOR LoadCount% = 0 TO 14
   GOSUB ReadData
   POKE (Offset + LoadCount%), Menomic%
NEXT LoadCount%

POKE (Offset + 1), AX         'load AX register
POKE (Offset + 4), BX         'load BX register
POKE (Offset + 7), CX        'load CX register
POKE (Offset + 10), DX        'load DX register
POKE (Offset + 13), INTnum    'load Interrupt number

CALL ABSOLUTE(Offset)         'execute code
POKE (Offset + 1), 3          'load AX register

DO
CALL ABSOLUTE(Offset)         'execute code
LOCATE 1, 1
FOR LoadCount% = 1 TO 13
   PRINT PEEK(Offset + LoadCount%),
NEXT LoadCount%
LOOP

END
ReadData:
READ Menomic%
'DATA 80              : 'PUSH AX        save the registers
'DATA 83              : 'PUSH BX
'DATA 81              : 'PUSH CX
'DATA 82              : 'PUSH DX
DATA 184,00,00       : 'MOV AX,0000h   load registers with our own values
DATA 187,00,00       : 'MOV BX,0000h
DATA 185,00,00       : 'MOV CX,0000h
DATA 186,00,00       : 'MOV DX,0000h
DATA 205,00          : 'INT 00h        execute interrupt
'DATA 90              : 'POP DX         recall old register values
'DATA 89              : 'POP CX
'DATA 91              : 'POP BX
'DATA 88              : 'POP AX
DATA 203             : 'RETF           give control back to QB
RETURN



