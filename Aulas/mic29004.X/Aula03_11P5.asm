.DSEG
    
.ORG SRAM_START
    A1: .BYTE 12
    A2: .BYTE 12
    A3: .BYTE 12
    A4: .BYTE 4
 
.CSEG

start:
    ;Inicializa os vetores A2 e A3
    LDI YH,HIGH(A2)
    LDI YL,LOW(A2)
    LDI ZH,HIGH(A3)
    LDI ZL,LOW(A3)
    LDI R16,1
     
startA23: ;INDIRETO COM POS INCREMENTO
    st Y+,r16
    st Z+,r16
    inc r16
    cpi r16,13
    brlo startA23
    
;Some A2 com a ultima de A3 e armazenar em A1
    LDI YH,HIGH(A2)
    LDI YL,LOW(A2)
    LDI ZH,HIGH(A3+12)
    LDI ZL,LOW(A3+12)
    
    LDI XH,HIGH(A1)
    LDI XL,LOW(A1)
    
    LDI r16,1
    
sum_seq:
    ld r17,Y+
    ld r18,-Z
    add r17,r18
    st X+,r17
    
    inc r16
    cpi r16,13
    brlo sum_seq
    
; soma A2(3) e A3(4), A2(5) e A3(7), A2(8) e A3(6), A2(10) e A3(12)
; salvar em A4
    LDI YH,HIGH(A2)
    LDI YL,LOW(A2)
    LDI ZH,HIGH(A3)
    LDI ZL,LOW(A3)
    
    LDI XH,HIGH(A4)
    LDI XL,LOW(A4)
    
sum_ale:
    ldd r17,Y+2
    ldd r18,Z+3
    add r17,r18
    st X+,r17
    
    ldd r17,Y+4
    ldd r18,Z+6
    add r17,r18
    st X+,r17
   
    ldd r17,Y+7
    ldd r18,Z+5
    add r17,r18
    st X+,r17
    
    ldd r17,Y+9
    ldd r18,Z+11
    add r17,r18
    st X+,r17
    
    rjmp start
