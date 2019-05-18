const SP r15 
const NULL r14
const temp r13

const fib_n r1 
const x r2 
const y r3

const IS_NEW 1<<12
const KEY_DOWN 1<<11

addi SP, SP, 0x200



MAIN:
    in r1, 0
    addi r2, r2, IS_NEW
    and r2, r1, r2
    cmpi r2, 0
    breq MAIN; Not new value
    addi r2, NULL, KEY_DOWN 
    and r2, r1, r2 ;
    cmpi r2, 0
    brne MAIN ; Key was not released, but pressed down (is_make)
    addi r2, NULL, (1<<8)-1
    and  r2, r2, r1 ; r2 is now the key 
    cmpi r2, '\n'
    breq PRINT_FIB 
    subi r3, r2, '0' ; r3 has numeric value 
    add r4, r4, r3
    rjmp MAIN
PRINT_FIB:
    push[2] r4
    call FIB 
    rjmp MAIN






FIB:
    addi r2, NULL, 0xffff
    pop[2] fib_n
    move x, NULL 
    move y, NULL
    addi x, x, 1 
FIB2:
    subi fib_n, fib_n, 1
    move temp, x 
    add x, x, y 
    move y, temp 
    cmpi fib_n, 0
    brgt FIB 
    out 0, x
    move fib_n, NULL ; Set r4 to zero
    move x, NULL 
    move y, NULL
    move temp, NULL
    ret




halt
