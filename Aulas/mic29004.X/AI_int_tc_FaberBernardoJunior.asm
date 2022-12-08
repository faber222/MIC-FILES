.INCLUDE <m328Pdef.inc>

;DEFINICOES
.equ BOTAO = PD2
.def AUX = R16

.DSEG
.ORG SRAM_START
    countTime: .BYTE 1	; variavel para armazenar contagem de tempo	
    countNum: .BYTE 1	; variavel para armazenar contagem de numeros

.CSEG    

.ORG 0x0000 ; Reset vector
    RJMP setup

.ORG 0x0002 ; Vetor (endereco na Flash) da INT0
    RJMP isr_int0

.ORG 0x0020
    RJMP isr_tc0b
    
.ORG 0x0034 ; primeira end. livre depois dos vetores

setup:    
    ; Configura a PD2 como entrada com o pull-up ativo
    cbi DDRD, BOTAO
    sbi PORTD, BOTAO

    ; Inicializa o SSD
    sbi DDRC, PC4	    ; Configura PC5 (segmento G) como saída ...
    sbi PORTC, PC4	    ; ... e apaga 
    sbi DDRC, PC5	    ; Configura PC6 (DP) como saída ...
    sbi PORTc, PC5	    ; ... e apaga 
    
    ldi R17,0xFF	  
    out DDRB, R17	    ; configura PBx como saída ...
    out PORTB, R17	    ; ... e apaga os segmentos do display
    
    LDI AUX, 0b00000010 
    STS EICRA, AUX	    ; config. INT0 sensivel a borda de descida
    SBI EIMSK, INT0	    ; habilita a INT0
    
    LDI AUX, 0b00000101	    ;TC0 com prescaler de 1024, a 16 MHz gera
    OUT TCCR0B, AUX	    ; uma interrupcaoo a cada 16,384 ms
    LDI AUX, 1
    STS TIMSK0, AUX	    ; habilita int. do TC0B (TIMSK0(0) =TOIE0 <- 1)
    
    clr AUX
    clr r17
    sts countTime,r17	    ; seta zero na variavel
    sts countNum,r17	    ; seta zero na variavel
    
    SEI			    ; habilita a interrupcao global ...
			    ; ... (bit I do SREG

main: 
   rjmp main
    
isr_tc0b:
    push r17	    ; Salva o contexto de r17
    in r17, SREG    ; Salva o contexto da SREG
    push r17
    lds r17, countTime  ; carrega valor de count para r17
    inc r17	    ; incrementa o contador
    cpi r17,122	    ; verifica se é 122 = 2s
    brne fim	    ; se não for igual, salta para o fim
    clr r17	    ; limpa r17
    rcall ssd_decode; chama desenho numero 
    lds AUX, countNum ; carrega o valor da variavel dentro de AUX
    inc AUX	    ; incrementa AUX
    cpi AUX, 10	    ; verifica se é 10
    brne fim	    ; se não for igual a zero, salta para o fim
    clr AUX	    ; limpa AUX
fim:
    sts  countTime, r17 ; armazena o valor no contador de tempo
    sts  countNum, AUX	; armazena o valor no contador numerico
    pop r17		; Restaura o contexto (SREG)
    out SREG,r17	; Restaura o contexto (SREG)
    pop r17		; Restaura o contexto de r17
    reti
 
isr_int0:
    clr AUX		; limpa AUX
    rcall ssd_decode	; chama o codificador para desenhar o numero
    reti		; retorna da interrupcao
	
;---------------------------------------------------------------------------
; SUB-ROTINA: Decodifica um valor de 0 a 15 passado como parâmetro no R16 e 
;             escreve em um display anodo comum com a seguinte ligação:
; Seguimento:  G   F  ...  A
; Pino:       PB2 PC5 ... PC0
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
 
 