.def AUX = R16 
.equ BOTAOSELECAO = PB1 ; apelido para o PB1 == 0b000000X0
.equ BOTAOAJUSTE = PB0	; apelido para o PB0 == 0b0000000X

setup:
ldi AUX,0b11111111 
out DDRD,AUX	; seleciona como saida os leds == 1	
out PORTD,AUX	; deixa todos os leds apagados por padrão == 1

cbi DDRB,BOTAOAJUSTE	; seleciona como entrada == 0
cbi DDRB,BOTAOSELECAO	; seleciona como entrada == 0
sbi PORTB,BOTAOAJUSTE	; seleciona como pull-up em 1 == não pressionado
sbi PORTB,BOTAOSELECAO	; seleciona como pull-up em 1 == não pressionado

;----------------------
pressSelecao: 
    sbic PINB,BOTAOSELECAO  ; if(BOTAOSELECAO != 0)
    rjmp pressAjuste	    ; {rjmp pressAjuste}
    
    rcall loopR		    ; else {rcall loopR}
    ldi r19,16 ; carrega r19 com 16 == 200ms    
    
    rcall delay
    rjmp  pressAjuste

;--------------------------------------;
pressAjuste: 
    sbic PINB,BOTAOAJUSTE   ; if(BOTAOAJUSTE != 0)
    rjmp pressSelecao	    ; {rjmp pressSelecao}

    rcall loopL		    ; else {rcall loppL}
    ldi r19,80 ; carrega r19 com 80 == 1s
    
    rcall delay
    rjmp pressSelecao
    

loopL:	; executa rotacao da esquerda para a direita
    rol r16
    out PORTD,r16   ; salva o valor de r16 rotacionado em PORTD
		    ; para fazer os leds acenderem
    ret		    ; volta para a linha 32
 
loopR:; executa rotacao da direita para a esqueda
    ror r16
    out PORTD,r16   ; salva o valor de r16 rotacionado em PORTD
		    ; para fazer os leds acenderem
    ret		    ; volta para a linha 21


;--------------------------------------------------------------
;SUB-ROTINA DE ATRASO Programavel
; Depende do valor de R19 carregado antes da chamada.
; Ex.: - R19 = 16 --> 200ms
; Ex : - R19 = 80 --> 1s
;--------------------------------------------------------------
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