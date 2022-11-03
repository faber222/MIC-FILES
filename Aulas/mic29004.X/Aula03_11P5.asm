.DSEG
    
.ORG SRAM_START
    A1: .BYTE 12
    A2: .BYTE 12
    A3: .BYTE 12
    A4: .BYTE 4
 
.CSEG

startA23: ;INDIRETO COM POS INCREMENTO
    LDI XH,HIGH(A2)
    LDI XL,LOW(A2)
    LDI YH,HIGH(A3)
    LDI YL,LOW(A3)
    
    inc r16
    st X+,r16
    st Y+,r16
    
    cpi r16,12
    brlo startA23
