;DEFINI¸C~OES
.equ LED = PD2 ;LED ´e o substituto de PD2 na programa¸c~ao
.equ BOTAO = PD7 ;BOTAO ´e o substituto de PD7 na programa¸c~ao
.def AUX = R16 ;R16 tem agora o nome de AUX

setup:
LDI AUX,0b00000100 ;carrega AUX com o valor 0x04 (1 = sa´?da e 0 = entrada)
OUT DDRD,AUX ;configura PORTD, PD2 sa´?da e demais pinos entradas
LDI AUX,0b11111111 ;habilita o pull-up para o bot~ao e apaga o LED
OUT PORTD,AUX

;----------------------
;LA¸CO PRINCIPAL
;----------------------
naoPress: ;loop bot~ao n~ao pressionado (pull-up)
sbi PORTD,LED ;desliga LED
sbic PIND,BOTAO ;verifica se o bot~ao foi pressionado, sen~ao
rjmp naoPress ;volta e fica preso no la¸co naoPress

press: ;loop bot~ao pressionado
cbi PORTD,LED ;desliga LED
sbis PIND,BOTAO ;verifica se o bot~ao foi solto, sen~ao
rjmp press ;sen~ao, aguarda.

rjmp naoPress ;vai para o loop do "bot~ao pressionado"