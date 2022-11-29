.ORG 0x0000		    ; Vetor reset
    RJMP setup 
.ORG 0x0020   ; Vetor (endereco na Flash) do estouro doT/C0
    RJMP isr_tc0b 
setup: 
    sbi DDRB, PB5 
    cbi PORTB, PB5 ; desliga led
    
    ldi R16, 0b00000101	    ;TC0 com prescaler de 1024, a 16 MHz gera
    out TCCR0B, R16	    ; uma interrupcaoo a cada 16,384 ms
    LDI R16, 1
    sts TIMSK0, R16	    ; habilita int. do TC0B (TIMSK0(0) =TOIE0 <- 1)

    sei			    ; habilita as interrup¸c~oes globais
main:
    rjmp main

isr_tc0b:
    inc r16
    cpi r16, 62
    brne fim
    sbi PINB, PB5   ; inverte o estado do LED depois de entrar 62 vezes
		    ; na interrup¸c~ao: 62 * 16,384 ms = 1.015,81ms
    ldi r16,0
fim:
    reti