.INCLUDE <m328Pdef.inc>

.DSEG
.ORG SRAM_START
    A1: .BYTE 6 ; declara vetor com 6 posições
.CSEG

.def AUX = R16  ; apelido para r16
.equ BOTAOAJUSTE = PD2 ; apelido para o botão
 
setup:
ldi AUX,0b11111111 
OUT DDRB,AUX	; seleciona como saida os leds == 1
ldi AUX,0b00000000 
OUT PORTB,AUX	; deixa todos os leds acesos por padrão == 0
    
cbi DDRD,BOTAOAJUSTE	; seleciona como entrada == 0
sbi PORTD,BOTAOAJUSTE	; seleciona como pull-up em 1 == não pressionado

start:
    ;Inicializa os vetores A1
    LDI YH,HIGH(A1)
    LDI YL,LOW(A1)
    LDI R17,1 ; carrega r17 com 1 para fazer o incremento

startA23: ;INDIRETO COM POS INCREMENTO
    st Y+,r17 ; adiciona no vetor o valor de r17 e incrementa ponteiro
    add r17,r17 ; soma o valor de r17 com ele mesmo, fazendo 1+1=2/ 2+2 = 4 e etc.
    cpi r17,64 ; verifica se o valor de r17 não é igual a 64
    brlo startA23 ; salta para startA23 se o valor de r17 ainda for menor que 64

loopResetado:
    ;Inicializa os vetores A1
    LDI YH,HIGH(A1)
    LDI YL,LOW(A1)
    LDI r18,1 ; carrega r18 com 1 para fazer o incremento
;--------------------------------------;
pressAjuste: 
    sbic PIND,BOTAOAJUSTE   ; if(BOTAOAJUSTE != 0)
    rjmp pressAjuste	    ; {rjmp pressAjuste}
    
    ld r17,Y+	    ; carrega o valor do ponteiro do vetor dentro de r17
    out PORTB,r17   ; joga na saida dos leds o valor de r17 
    
    inc r18		    ; incrementa o iterador r18
    cpi r18,7		    ; compara se é igual a 7
    
loopBotao:
    sbis PIND,BOTAOAJUSTE
    rjmp loopBotao
    
    breq loopResetado	    ; salta se for igual a 7 para o loopResetado
    rjmp pressAjuste	    ; se não, salta para a rotina pressAjuste
    
