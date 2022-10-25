.equ LED = PB5
    
setup:
    LDI R16,0xFF
    OUT DDRB,R16

loop:
    SBI PORTB,LED
    
    RJMP loop
    
