;DEFINIÇÕES
.equ LED7 = PD7 ;LED 7 o substituto de PD2 na programação
.equ LED6 = PD6 ;LED 6 o substituto de PD2 na programação
.equ LED5 = PD5 ;LED 5 o substituto de PD2 na programação
.equ LED4 = PD4 ;LED 4 o substituto de PD2 na programação
.equ LED3 = PD3 ;LED 3 o substituto de PD2 na programação
.equ LED2 = PD2 ;LED 2 o substituto de PD2 na programação
.equ LED1 = PD1 ;LED 1 o substituto de PD2 na programação
.equ LED0 = PD0 ;LED 0 o substituto de PD2 na programação
.equ BOTAOSELECAO = PB1 ;BOTAO � o substituto de PD7 na programação
.equ BOTAOAJUSTE = PB0 ;BOTAO � o substituto de PD7 na programação
.def AUX = R16 ;R16 tem agora o nome de AUX

setup:
LDI AUX,0b11111111 
OUT DDRD,AUX 
OUT PORTD,AUX 
OUT PORTB,AUX

;----------------------
;LAÇO PRINCIPAL
;----------------------
naoPress: ;loop botao nao pressionado (pull-up)
sbis PINB,BOTAOSELECAO ;verifica se o botao nao foi pressionado, senao
rjmp pressSelecao

rjmp desligaLedSelecao ;volta e fica preso no la�co naoPress

;--------------------------------------;
pressSelecao: ;loop botao pressionado
sbis PINB,BOTAOSELECAO ;verifica se o botao nao foi solto, senao
rjmp ligaLedSelecao ;senao, aguarda.

rjmp desligaLedSelecao

;--------------------------------------;
pressAjuste: ;loop botao pressionado
sbis PINB,BOTAOAJUSTE ;verifica se o botao nao foi solto, senao
rjmp ligaLedAjuste

rjmp desligaLedAjuste

;---------------------------------------;
desligaLedAjuste:
cbi PORTD,LED3 ;desliga LED3
cbi PORTD,LED2 ;desliga LED2
cbi PORTD,LED1 ;desliga LED1
cbi PORTD,LED0 ;desliga LED0
rjmp pressSelecao
    
desligaLedSelecao:
cbi PORTD,LED7 ;desliga LED7
cbi PORTD,LED6 ;desliga LED6
cbi PORTD,LED5 ;desliga LED5
cbi PORTD,LED4 ;desliga LED4
rjmp pressAjuste
    
ligaLedAjuste:
sbi PORTD,LED3 ;liga LED3
sbi PORTD,LED2 ;liga LED2
sbi PORTD,LED1 ;liga LED1
sbi PORTD,LED0 ;liga LED0

rjmp pressSelecao
    
ligaLedSelecao:
sbi PORTD,LED7 ;liga LED7
sbi PORTD,LED6 ;liga LED6
sbi PORTD,LED5 ;liga LED5
sbi PORTD,LED4 ;liga LED4
    
rjmp pressAjuste
