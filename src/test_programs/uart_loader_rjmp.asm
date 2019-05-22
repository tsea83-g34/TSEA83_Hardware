const SP r15
const NULL r14
const BP r13
const RR r12

.data NEW_UART_MASK
	.dh 256

	subi SP, SP, 1
	call main
	subi SP, SP, 2
__halt:
	rjmp __halt

get_uart:
	move BP, SP
	subi SP, SP, 2
	load[2] r0, BP, -2
	in r0, 1
	move RR, r0
	addi SP, SP, 2
	ret

store_pm:
	move BP, SP
	load[2] r0, BP, 2
	load[4] r1, BP, 4
	store_pm r0, r1, _program_end_
	store[2] BP, r0, 2
	move RR, NULL
	ret

store_dm:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
	store[1] r0, r1, 0
	store[2] BP, r0, 4
	move RR, NULL
	ret

is_uart_new:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	subi SP, SP, 2
	push[2] BP
	store[2] BP, r0, -2
	call get_uart
	pop[2] BP
	move r0, RR
	subi SP, SP, 2
	load[2] r1, NULL, NEW_UART_MASK
	and r1, r1, r0
	move RR, r1
	addi SP, SP, 6
	ret

get_uart_byte:
	move BP, SP
	subi SP, SP, 2
	push[2] BP
	subi SP, SP, 2
	call get_uart
	addi SP, SP, 2
	pop[2] BP
	move r0, RR
	subi SP, SP, 2
	store[2] BP, r0, -2
	load[2] r1, NULL, NEW_UART_MASK
	subi r1, r1, 1
	and r0, r0, r1
	move RR, r0
	addi SP, SP, 4
	ret

get_num_lines:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	subi SP, SP, 2
	addi r1, NULL, 1
	store[2] BP, r0, -2
	store[2] BP, r1, -4
L0:
	load[2] r0, BP, -4
	cmpi r0, 0
	breq L1
	subi SP, SP, 2
	push[2] BP
	subi SP, SP, 2
	call get_uart
	addi SP, SP, 2
	pop[2] BP
	move r0, RR
	subi SP, SP, 2
	store[2] BP, r0, -6
	load[2] r1, NULL, NEW_UART_MASK
	and r0, r0, r1
	subi SP, SP, 2
	load[2] r2, BP, -6
	subi r1, r1, 1
	and r2, r2, r1
	store[2] BP, r0, -8
	cmpi r0, 0
	brne L2
	addi r0, NULL, 0
	rjmp L3
L2:
	addi r0, NULL, 1
L3:
	store[2] BP, r2, -10
	cmpi r2, 10
	brlt L4
	addi r2, NULL, 0
	rjmp L5
L4:
	addi r2, NULL, 1
L5:
	and r0, r0, r2
	cmpi r0, 0
	breq L6
	load[2] r0, BP, -2
	addi r1, NULL, 10
	mul r0, r0, r1
	load[2] r1, BP, -10
	add r0, r0, r1
	store[2] BP, r0, -2
	rjmp L7
L6:
L7:
	load[2] r0, BP, -8
	cmpi r0, 0
	brne L8
	addi r0, NULL, 0
	rjmp L9
L8:
	addi r0, NULL, 1
L9:
	load[2] r1, BP, -10
	cmpi r1, 9
	brgt L10
	addi r1, NULL, 0
	rjmp L11
L10:
	addi r1, NULL, 1
L11:
	and r0, r0, r1
	cmpi r0, 0
	breq L12
	addi r0, NULL, 0
	store[2] BP, r0, -4
	rjmp L13
L12:
L13:
	addi SP, SP, 6
	rjmp L0
L1:
	load[2] r0, BP, -2
	move RR, r0
	addi SP, SP, 4
	ret

load_uart:
	move BP, SP
	subi SP, SP, 2
	push[2] BP
	subi SP, SP, 2
	call get_num_lines
	addi SP, SP, 2
	pop[2] BP
	move r0, RR
	subi SP, SP, 6
	addi r1, NULL, 0
	subi SP, SP, 2
	addi r2, NULL, 0
	subi SP, SP, 2
	addi r3, NULL, 0
	store[2] BP, r0, -2
	store[4] BP, r1, -8
	store[2] BP, r2, -10
	store[2] BP, r3, -12
L14:
	load[2] r0, BP, -2
	cmpi r0, 0
	breq L15
L16:
	load[2] r0, BP, -10
	cmpi r0, 4
	brlt L18
	addi r0, NULL, 0
	rjmp L19
L18:
	addi r0, NULL, 1
L19:
	cmpi r0, 0
	breq L17
	push[2] BP
	call is_uart_new
	pop[2] BP
	cmpi RR, 0
	breq L20
	load[4] r0, BP, -8
	addi r1, NULL, 256
	mul r0, r0, r1
	push[2] r0
	push[2] BP
	subi SP, SP, 2
	call get_uart_byte
	addi SP, SP, 2
	pop[2] BP
	pop[2] r0
	add r0, r0, RR
	load[2] r1, BP, -10
	addi r1, r1, 1
	store[4] BP, r0, -8
	store[2] BP, r1, -10
	rjmp L21
L20:
L21:
	rjmp L16
L17:
	addi r0, NULL, 0
	load[2] r1, BP, -2
	subi r1, r1, 1
	push[2] BP
	subi SP, SP, 2
	load[4] r2, BP, -8
	push[4] r2
	load[2] r3, BP, -12
	push[2] r3
	store[2] BP, r0, -10
	store[2] BP, r1, -2
	call store_pm
	addi SP, SP, 8
	pop[2] BP
	addi r0, NULL, 0
	load[2] r1, BP, -12
	addi r1, r1, 1
	store[4] BP, r0, -8
	store[2] BP, r1, -12
	rjmp L14
L15:
	addi r0, NULL, 0
	subi SP, SP, 2
	push[2] BP
	store[2] BP, r0, -12
	subi SP, SP, 2
	call get_num_lines
	addi SP, SP, 2
	pop[2] BP
	move r0, RR
	subi SP, SP, 2
	addi r1, NULL, 0
	store[2] BP, r0, -14
	store[2] BP, r1, -16
L22:
	load[2] r0, BP, -14
	cmpi r0, 0
	breq L23
	push[2] BP
	call is_uart_new
	pop[2] BP
	cmpi RR, 0
	breq L24
	push[2] BP
	call get_uart_byte
	pop[2] BP
	move r0, RR
	load[2] r1, BP, -14
	subi r1, r1, 1
	push[2] BP
	subi SP, SP, 2
	push[2] r0
	load[2] r2, BP, -12
	push[2] r2
	store[2] BP, r0, -16
	store[2] BP, r1, -14
	subi SP, SP, 2
	call store_dm
	addi SP, SP, 8
	pop[2] BP
	load[2] r0, BP, -12
	addi r0, r0, 1
	store[2] BP, r0, -12
	rjmp L25
L24:
L25:
	rjmp L22
L23:
	addi SP, SP, 16
	move RR, NULL
	ret

main:
	move BP, SP
L26:
	push[2] BP
	call is_uart_new
	pop[2] BP
	cmpi RR, 0
	breq L28
	push[2] BP
	call load_uart
	pop[2] BP
	rjmp _program_end_
	rjmp L29
L28:
L29:
	rjmp L26
L27:
	move RR, NULL
	ret

