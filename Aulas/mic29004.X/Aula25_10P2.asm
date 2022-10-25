.equ LED = PB5 ;LED ´e o substituto de PB5 na programa¸c~ao

start:
    LDI R16,0xFF ;carrega R16 com o valor 0xFF
    OUT DDRB,R16 ;configura todos os pinos do PORTB como sa´?da

main:
    SBI PORTB, LED ;coloca o pino PB5 em 5V
;atraso de aprox. 200ms
    LDI R19,80
loop:
    DEC R17 ;decrementa R17, come¸ca com 0x00
    BRNE loop ;enquanto R17 > 0 fica decrementando R17
    DEC R18 ;decrementa R18, come¸ca com 0x00
    BRNE loop ;enquanto R18 > 0 volta decrementar R18
    DEC R19 ;decrementa R19
    BRNE loop ;enquanto R19 > 0 vai para volta
    CBI PORTB, LED ;coloca o pino PB5 em 0V

;atraso de aprox. 200ms
    LDI R19,80
loop2:
    DEC R17 ;decrementa R17, come¸ca com 0x00
    BRNE loop2 ;enquanto R17 > 0 fica decrementando R17
    DEC R18 ;decrementa R18, come¸ca com 0x00
    BRNE loop2 ;enquanto R18 > 0 volta decrementar R18
    DEC R19 ;decrementa R19
    BRNE loop2 ;enquanto R19 > 0 vai para volta
    RJMP main ;volta para main