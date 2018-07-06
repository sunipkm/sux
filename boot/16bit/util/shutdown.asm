shutdown:
;Connect to APM API
MOV     AX,0x5301
XOR     BX,BX
INT     0x15

;Try to set APM version (to 1.2)
MOV     AX,0x530E
XOR     BX,BX
MOV     CX,0x0102
INT     0x15

;Turn off the system
MOV     AX,0x5307
MOV     BX,0x0001
MOV     CX,0x0003
INT     0x15

;Exit (for good measure and in case of failure)
RET