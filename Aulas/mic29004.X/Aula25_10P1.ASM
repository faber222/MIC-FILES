.equ LED = PB5
    
setup:
    LDI R16,0xFF
    OUT DDRB,R16
    
loop:
    CBI PORTB,LED
    SBI PORTB,LED
    RJMP loop2


    