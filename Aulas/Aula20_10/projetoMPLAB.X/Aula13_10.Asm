

; Replace with your application code
.EQU constante=22
start:
    ldi r16, 2
    add r16, r17	;r16 = r16+r17
    ldi r17, constante
    add r16, r17	;r16 = r16+r17
    mov r18, r16	;r18 = r16+r17     
    
    rjmp start
