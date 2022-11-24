.INCLUDE <m328Pdef.inc>

;DEFINICOES
.equ BOTAO = PD3
.equ BOTAO2 = PD2
.equ L0 = PB0
.equ L1 = PB1
.def AUX = R16

.ORG 0x0000 ; Reset vector
    RJMP setup

.ORG 0x0002 ; Vetor (endereco na Flash) da INT1
    RJMP isr_int0

.ORG 0x0004 ; Vetor (endereco na Flash) da INT1
    RJMP isr_int1    
    
.ORG 0x0034 ; primeira end. livre depois dos vetores
setup:
    ldi AUX,0x03 ; 0b00000011
    out DDRB,AUX ; configura PB3/2 como saida
    out PORTB,AUX ; desliga os LEDs
    cbi DDRD, BOTAO ; configura o PD3 como entrada
    sbi PORTD, BOTAO ; liga o pull-up do PD
    cbi DDRD, BOTAO2 ; configura o PD2 como entrada
    sbi PORTD, BOTAO2 ; liga o pull-up do PD2

    LDI AUX, 0b00000010 ;
    STS EICRA, AUX ; config. INT0 sensivel a borda
    SBI EIMSK, INT0 ; habilita a INT0
    
    LDI AUX, 0b00001000 ;
    STS EICRA, AUX ; config. INT1 sensivel a borda
    SBI EIMSK, INT1 ; habilita a INT1

    SEI ; habilita a interrupcao global ...
; ... (bit I do SREG)
    
main:
    sbi PORTB,L0 ; desliga L0
    ldi r19, 160
    rcall delay ; delay 1s
    cbi PORTB,L0 ; liga L0
    ldi r19, 160
    rcall delay ; delay 1s
    rjmp main

;-------------------------------------------------
; Rotina de Interrupcao (ISR) da INT0
;-------------------------------------------------
isr_int1:
    push R16 ; Salva o contexto (SREG)
    in R16, SREG
    push R16
    sbi PORTB,L1 ; desliga L1
    pop R16 ; Restaura o contexto (SREG)
    out SREG,R16
    pop R16
    reti ; retorna da interrupcao


isr_int0:
    push R16 ; Salva o contexto (SREG)
    in R16, SREG
    push R16
    cbi PORTB,L1 ; liga L1
    pop R16 ; Restaura o contexto (SREG)
    out SREG,R16
    pop R16
    reti ; retorna da interrupcao

delay:
    push r17 ; Salva os valores de r17,
    push r18 ; ... r18,
    in r17,SREG ; ...
    push r17 ; ... e SREG na pilha.

; Executa sub-rotina :
    clr r17
    clr r18
loop:
    dec R17 ;decrementa R17, come¸ca com 0x00
    brne loop ;enquanto R17 > 0 fica decrementando R17
    dec R18 ;decrementa R18, come¸ca com 0x00
    brne loop ;enquanto R18 > 0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;enquanto R19 > 0 vai para volta

    pop r17
    out SREG, r17 ; Restaura os valores de SREG,
    pop r18 ; ... r18
    pop r17 ; ... r17 da pilha

    ret