.INCLUDE <m328Pdef.inc>
    
; Fiz baseado na AA anterior, que era sobre interrupção
; Onde devemos fazer com que o led0 pisque a cada 2s 
; E quando pressionado o botão PD3, deveria ligar o led1
; E quando pressionado o botão PD2, deveria desligar o led1

;DEFINICOES
.equ BOTAO = PD3
.equ BOTAO2 = PD2
.equ L0 = PB0
.equ L1 = PB1
.def AUX = R16

.DSEG
.ORG SRAM_START
    count: .BYTE 1

.CSEG    

.ORG 0x0000 ; Reset vector
    RJMP setup

.ORG 0x0002 ; Vetor (endereco na Flash) da INT1
    RJMP isr_int0

.ORG 0x0004 ; Vetor (endereco na Flash) da INT1
    RJMP isr_int1    

.ORG 0x0020
    RJMP isr_tc0b
    
.ORG 0x0034 ; primeira end. livre depois dos vetores
setup:
    ldi AUX,0x03 ; 0b00000011
    out DDRB,AUX ; configura PB3/2 como saida
    out PORTB,AUX ; desliga os LEDs
    cbi DDRD, BOTAO ; configura o PD3 como entrada
    sbi PORTD, BOTAO ; liga o pull-up do PD
    cbi DDRD, BOTAO2 ; configura o PD2 como entrada
    sbi PORTD, BOTAO2 ; liga o pull-up do PD2

    LDI AUX, 0b00001010 ;
    STS EICRA, AUX ; config. INT0 sensivel a borda
    SBI EIMSK, INT0 ; habilita a INT0
    SBI EIMSK, INT1 ; habilita a INT1
    
    LDI AUX, 0b00000101   ;TC0 com prescaler de 1024, a 16 MHz gera
    OUT TCCR0B, AUX	    ; uma interrupcaoo a cada 16,384 ms
    LDI AUX, 1
    STS TIMSK0, AUX	    ; habilita int. do TC0B (TIMSK0(0) =TOIE0 <- 1)

    SEI ; habilita a interrupcao global ...
; ... (bit I do SREG)
    
main:
    rcall teste
    rjmp main

;-------------------------------------------------
; Rotina de Interrupcao (ISR) da INT0
;-------------------------------------------------
isr_int1:
    push AUX ; Salva o contexto (SREG)
    in AUX, SREG
    push AUX
    sbi PORTB,L1 ; desliga L1
    pop AUX ; Restaura o contexto (SREG)
    out SREG,AUX
    pop AUX
    reti ; retorna da interrupcao


isr_int0:
    push AUX ; Salva o contexto (SREG)
    in AUX, SREG
    push AUX
    cbi PORTB,L1 ; liga L1
    pop AUX ; Restaura o contexto (SREG)
    out SREG,AUX
    pop AUX
    reti ; retorna da interrupcao

isr_tc0b:
    push AUX ; Salva o contexto (SREG)
    in AUX, SREG
    push AUX
    
    lds AUX, count
    inc AUX	    ; incrementa o contador
    cpi AUX, 128	    ; verifica se é 62
    brne fim	    ; se não for igual, salta para o fim
    
    sbi PINB, L0    ; inverte o estado do LED depois de entrar 62 vezes
		    ; na interrupcao: 62 * 16,384 ms = 1.015,81ms
    ldi AUX,0

fim:
    sts  count, AUX
    pop AUX ; Restaura o contexto (SREG)
    out SREG,AUX
    pop AUX
    reti
    
teste:
  CLR ZH
  CLR ZL
  LDI R29, 29
  CLR R28
cont:
  ST Z+,R28
  DEC R29
  CPI R29, 0
  BRNE cont
  
  CLR ZH
  CLR ZL
;  OUT SREG, R28 Foi comentado devido a matar o uso das interrupcoes
  
  ret