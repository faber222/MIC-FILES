

; Replace with your application code
start:
    inc R0
    out GPIOR0, R0
    in R1, GPIOR0
    
    sbi DDRB, 5 ; Seta o bit 5 do registrador DDRB (0x04)
    cbi DDRB, 5 ; Reseta o bit 5 do registrador DDRB (0x04)
    
waitUM:
    sbis PIND,7 ; Salta a pr´oxima instru¸c~ao se o bit 7 do registrado PIND (0x09) ´e UM.
    rjmp waitUM ; Bit 7 do PIND n~ao setado. Salta para wait.
waitZERO:
    sbic PIND,7 ; Salta a pr´oxima instru¸c~ao se o mesmo bit ´e ZERO.
    rjmp waitZERO ; Sen~ao, aguarda.
    nop ; Continua o programa (instru¸c~ao "n~ao faz nada")
    rjmp start
