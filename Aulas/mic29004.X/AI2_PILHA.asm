.INCLUDE <m328Pdef.inc>

.DSEG
.ORG SRAM_START
    A1: .BYTE 10 ; declara vetor com 10 posições
    count: .BYTE 1
.CSEG

.def AUX = R16  ; apelido para r16
.equ DP = PC5 ; apelido para o botão
 
setup:
     ;Inicializa o vetor A1
    LDI XH,HIGH(A1)
    LDI XL,LOW(A1)
    rcall startA1
    rcall ssd_init
    ldi r16,0
    sts count, r16
    clr r16

loopLED1: 
    lds r16, count
    inc r16
    sts count, r16
    
    ldi r19,16
    rcall delay	
    
    rcall ssd_write_x
    adiw X,1
    
    ldi r19,16
    rcall delay	
    
    cpi r16,11
    brlo loopLED1
    
    rcall loopResetado
    ldi r16,0
    sts count,r16
    rjmp loopLED1
   
    
    
;--------------------------------------;
startA1: 
    push r17
    ldi r17, 9
loop10:
    st X+,r17	; adiciona no vetor o valor de r17 e incrementa ponteiro
    dec r17	; decrementa r17
    cpi r17,0	; verifica se o valor de r17 não é igual a 0
    BRGE loop10 ; salta para startA1 se o valor de r17 ainda for maior que 0
    rcall loopResetado
    pop r17
    ret

loopResetado:
    ;Inicializa os vetores A1
    LDI XH,HIGH(A1)
    LDI XL,LOW(A1)
    ret
;--------------------------------------;  
ssd_init:
    LDI AUX,0b11111111 
    OUT DDRB,AUX	; seleciona como saida os leds == 1
    OUT DDRC,AUX	; seleciona como saida os leds == 1
    OUT PORTB,AUX	; deixa todos os leds apagados por padrão == 1
    OUT PORTC,AUX	; deixa todos os leds apagados por padrão == 1
    RET

;--------------------------------------;
ssd_write_x:
    ld r16, X
    rcall ssd_decode
    ret

;--------------------------------------;
ssd_dp_on:
    cbi PORTC,DP
    ret
    
;--------------------------------------;
ssd_dp_off:    
    sbi PORTC,DP
    ret
    

;---------------------------------------------------------------------------
; SUB-ROTINA: Decodifica um valor de 0 a 15 passado como parâmetro no R16 e 
;             escreve em um display anodo comum com a seguinte ligação:
; Seguimento:  DP G F  ...  A
; Pino:       PC5 PC4 PB5 ... PB0
;---------------------------------------------------------------------------
ssd_decode:
  push ZH            ; Guarda contexto
  push ZL        
  push r0        
  in r0,SREG   
  push r0      

  ldi  ZH,HIGH(Tabela<<1) 
  ldi  ZL,LOW(Tabela<<1)  
  add  ZL,R16             
  brcc le_tab             
  inc  ZH    

le_tab:     
  lpm  R0,Z      ; Lê tabela de decoficação

  sbi PORTC, PC4 ; Escreve G
  sbrs R0, 6
  cbi PORTC, PC4

  out PORTB, R0  ; Escreve A .. F      

  pop r0         ; Recupera contexto
  out SREG, r0
  pop r0
  pop ZL
  pop ZH    

  ret

;---------------------------------------------------------------------------
;   Tabela p/ decodificar o display: como cada endereço da memória flash é 
; de 16 bits, acessa-se a parte baixa e alta na decodificação
;---------------------------------------------------------------------------
Tabela: .dw 0x7940, 0x3024, 0x1219, 0x7802, 0x1800, 0x0308, 0x2146, 0x0E06
;             1 0     3 2     5 4     7 6     9 8     B A     D C     F E  
;===========================================================================



;---------------------------------------------------------------
;SUB-ROTINA DE ATRASO Programável
; Descrição: Depende do valor de R19 carregado antes da chamada.
; Exemplos:  - R19 = 16 --> 200ms 
;            - R19 = 80 --> 1s 
;---------------------------------------------------------------
delay:           
  push r17       ; Salva os valores de r17,
  push r18       ; ... r18,
  in r17,SREG    ; ...
  push r17       ; ... e SREG na pilha.

  ; Executa sub-rotina :
  clr r17
  clr r18
loop:            
  dec  R17       ;decrementa R17, começa com 0x00
  brne loop      ;enquanto R17 > 0 fica decrementando R17
  dec  R18       ;decrementa R18, começa com 0x00
  brne loop      ;enquanto R18 > 0 volta decrementar R18
  dec  R19       ;decrementa R19
  brne loop      ;enquanto R19 > 0 vai para volta

  pop r17         
  out SREG, r17  ; Restaura os valores de SREG,
  pop r18        ; ... r18
  pop r17        ; ... r17 da pilha

  ret
