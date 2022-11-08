;DEFINI�C~OES
.equ LED = PB5 ;LED �e o substituto de PB5

start:
    ldi R16,0xFF ;carrega R16 com o valor 0xFF
    out DDRB,R16 ;PORTB inteira como sa�?da

main:
    sbi PORTB, LED ;coloca o pino PB5 em 5V
    rcall delay ;chama a sub-rotina de atraso
    cbi PORTB, LED ;coloca o pino PB5 em 0V
    rcall delay ;chama a sub-rotina de atraso
    rjmp main ;volta para main

delay: ;atraso de aprox. 200ms
    push r17 ; Salva os valores de r17,
    push r18 ; ... r18,
    push r19 ; ... r19,
    in r17,SREG ;
    push r17 ; ... e SREG na pilha.

; Executa sub-rotina :
    clr r17
    clr r18
    ldi R19,16

loop:
    dec R17 ;decrementa R17, come�ca com 0x00
    brne loop ;enquanto R17 > 0 fica decrementando R17
    dec R18 ;decrementa R18, come�ca com 0x00
    brne loop ;enquanto R18 > 0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;enquanto R19 > 0 vai para volta

    pop r17
    out SREG, r17 ; Restaura os valores de SREG,
    pop r19 ; ... r19
    pop r18 ; ... r18
    pop r17 ; ... r17 da pilha

ret