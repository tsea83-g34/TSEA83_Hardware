addi r1, r1, 1 
    addi r2, r2, 2
    addi r3, r3, 3 
    store[4] r3, r3, 0 ; Mem(3) = 3 
    load[4] r5, r3, 0  ; r5 := 3
ADD_r5:
    addi r5, r5, 1 ; Stall + Dataforwarding 
    cmpi r5, 5 ; Flags
    brne ADD_r5 ; NOP second time 
    addi r10, r10, 0xfedc
    store[1] r0, r10, 10 ; Test offset and datasize  
    load[1] r10, r0, 10 ; Size masking: r10 = 0xdc 
    call SUBROUTINE ; PC > 25 
    nop
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
SUBROUTINE:
    ret ; PC = 14 ish
