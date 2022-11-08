

; Replace with your application code
start:
    ldi r16,0x01 ; carrega r16 com 0x01
    ldi r17,0x02 ; carrega r17 com 0x02

    push r16 ; salva r16 na pilha
    push r17 ; salva r17 na pilha

    pop r16 ; restaura r16 da pilha
    pop r17 ; restaura r17 da pilha
