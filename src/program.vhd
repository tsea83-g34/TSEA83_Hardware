library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"820e03fc", -- load r0 r14 1020 [2]
X"821e03fe", -- load r1 r14 1022 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00400", -- store r14 r0 1024 [2]
X"820e0400", -- load r0 r14 1024 [2]
X"d2e00402", -- store r14 r0 1026 [2]
X"820e0400", -- load r0 r14 1024 [2]
X"822e0404", -- load r2 r14 1028 [2]
X"93002000", -- add r0 r0 r2
X"d2e00406", -- store r14 r0 1030 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde000f", -- addi r13 r14 15
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300146a", -- rjmp main
X"8fff0002", -- subi r15 r15 2
X"33000000", -- rjmp __halt [__halt]
X"cfdf0000", -- move r13 r15 [in]
X"820d0002", -- load r0 r13 2 [2]
X"8fff0004", -- subi r15 r15 4
X"831dfffc", -- load r1 r13 -4 [4]
X"0f100000", -- in r1 0
X"cfc10000", -- move r12 r1
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd001b", -- subi r13 r13 27
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [out]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"e7000000", -- out 0 r0
X"d3d00004", -- store r13 r0 4 [4]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0025", -- subi r13 r13 37
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [vga_write]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"eb100000", -- vgaw r1 r0 0
X"d2d10006", -- store r13 r1 6 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd002f", -- subi r13 r13 47
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [outside_bound]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L0
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L1
X"8b0e0001", -- addi r0 r14 1 [L0]
X"823d0002", -- load r3 r13 2 [2] [L1]
X"df031000", -- cmp r3 r1
X"23000003", -- brlt L2
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L3
X"8b3e0001", -- addi r3 r14 1 [L2]
X"c3003000", -- or r0 r0 r3 [L3]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0044", -- subi r13 r13 68
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_l]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"820d000a", -- load r0 r13 10 [2] [L4]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L6
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L7
X"8b0e0001", -- addi r0 r14 1 [L6]
X"e3000000", -- cmpi r0 0 [L7]
X"1b000008", -- breq L5
X"831d0004", -- load r1 r13 4 [4]
X"af110000", -- lsl r1 r1 [4]
X"822d000a", -- load r2 r13 10 [2]
X"8f220001", -- subi r2 r2 1
X"d3d10004", -- store r13 r1 4 [4]
X"d2d2000a", -- store r13 r2 10 [2]
X"3300fff2", -- rjmp L4
X"830d0004", -- load r0 r13 4 [4] [L5]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd005c", -- subi r13 r13 92
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_l]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"820d000a", -- load r0 r13 10 [2] [L8]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L10
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L11
X"8b0e0001", -- addi r0 r14 1 [L10]
X"e3000000", -- cmpi r0 0 [L11]
X"1b000008", -- breq L9
X"831d0004", -- load r1 r13 4 [4]
X"b3110000", -- lsr r1 r1 [4]
X"822d000a", -- load r2 r13 10 [2]
X"8f220001", -- subi r2 r2 1
X"d3d10004", -- store r13 r1 4 [4]
X"d2d2000a", -- store r13 r2 10 [2]
X"3300fff2", -- rjmp L8
X"830d0004", -- load r0 r13 4 [4] [L9]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0074", -- subi r13 r13 116
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_i]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L12]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L14
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L15
X"8b0e0001", -- addi r0 r14 1 [L14]
X"e3000000", -- cmpi r0 0 [L15]
X"1b000008", -- breq L13
X"821d0004", -- load r1 r13 4 [2]
X"ae110000", -- lsl r1 r1 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d2d10004", -- store r13 r1 4 [2]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L12
X"820d0004", -- load r0 r13 4 [2] [L13]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd008c", -- subi r13 r13 140
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_i]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L16]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L18
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L19
X"8b0e0001", -- addi r0 r14 1 [L18]
X"e3000000", -- cmpi r0 0 [L19]
X"1b000008", -- breq L17
X"821d0004", -- load r1 r13 4 [2]
X"b2110000", -- lsr r1 r1 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d2d10004", -- store r13 r1 4 [2]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L16
X"820d0004", -- load r0 r13 4 [2] [L17]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00a4", -- subi r13 r13 164
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_c]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L20]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L22
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L23
X"8b0e0001", -- addi r0 r14 1 [L22]
X"e3000000", -- cmpi r0 0 [L23]
X"1b000008", -- breq L21
X"811d0005", -- load r1 r13 5 [1]
X"ad110000", -- lsl r1 r1 [1]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d1d10005", -- store r13 r1 5 [1]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L20
X"810d0005", -- load r0 r13 5 [1] [L21]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00bc", -- subi r13 r13 188
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_c]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L24]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L26
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L27
X"8b0e0001", -- addi r0 r14 1 [L26]
X"e3000000", -- cmpi r0 0 [L27]
X"1b000008", -- breq L25
X"811d0005", -- load r1 r13 5 [1]
X"b1110000", -- lsr r1 r1 [1]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d1d10005", -- store r13 r1 5 [1]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L24
X"810d0005", -- load r0 r13 5 [1] [L25]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00d4", -- subi r13 r13 212
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [sleep_ms]
X"830d0004", -- load r0 r13 4 [4]
X"8fff0004", -- subi r15 r15 4
X"831e03f8", -- load r1 r14 1016 [4]
X"a7001000", -- mul r0 r0 r1
X"8fff0004", -- subi r15 r15 4
X"8b2e0000", -- addi r2 r14 0
X"d3d0fffc", -- store r13 r0 -4 [4]
X"d3d2fff8", -- store r13 r2 -8 [4]
X"e3020000", -- cmpi r2 0
X"1b000004", -- breq L28
X"8b0e0000", -- addi r0 r14 0
X"d3d0fff8", -- store r13 r0 -8 [4]
X"33000001", -- rjmp L29
X"830dfff8", -- load r0 r13 -8 [4] [L28] [L29] [L30]
X"831dfffc", -- load r1 r13 -4 [4]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L32
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L33
X"8b0e0001", -- addi r0 r14 1 [L32]
X"e3000000", -- cmpi r0 0 [L33]
X"1b000005", -- breq L31
X"832dfff8", -- load r2 r13 -8 [4]
X"8b220001", -- addi r2 r2 1
X"d3d2fff8", -- store r13 r2 -8 [4]
X"3300fff4", -- rjmp L30
X"8bff0008", -- addi r15 r15 8 [L31]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00f5", -- subi r13 r13 245
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [divide]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d2fffc", -- store r13 r2 -4 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L34]
X"821d0006", -- load r1 r13 6 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L36
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L37
X"8b0e0001", -- addi r0 r14 1 [L36]
X"e3000000", -- cmpi r0 0 [L37]
X"1b000008", -- breq L35
X"822dfffe", -- load r2 r13 -2 [2]
X"97221000", -- sub r2 r2 r1
X"823dfffc", -- load r3 r13 -4 [2]
X"8b330001", -- addi r3 r3 1
X"d2d2fffe", -- store r13 r2 -2 [2]
X"d2d3fffc", -- store r13 r3 -4 [2]
X"3300fff1", -- rjmp L34
X"8fff0004", -- subi r15 r15 4 [L35]
X"820dfffc", -- load r0 r13 -4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d3d0fff8", -- store r13 r0 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde011f", -- addi r13 r14 287
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff27", -- rjmp left_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d3d0fff8", -- store r13 r0 -8 [4]
X"821dfffe", -- load r1 r13 -2 [2]
X"93001000", -- add r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd012b", -- subi r13 r13 299
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_compare]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0004", -- load r0 r13 4 [2] [L38]
X"81000000", -- load r0 r0 0 [1]
X"821d0006", -- load r1 r13 6 [2]
X"81110000", -- load r1 r1 0 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L40
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L41
X"8b0e0001", -- addi r0 r14 1 [L40]
X"e3000000", -- cmpi r0 0 [L41]
X"1b000017", -- breq L39
X"822d0004", -- load r2 r13 4 [2]
X"81220000", -- load r2 r2 0 [1]
X"e3020000", -- cmpi r2 0
X"1b000003", -- breq L42
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L43
X"8b2e0001", -- addi r2 r14 1 [L42]
X"e3020000", -- cmpi r2 0 [L43]
X"1b000007", -- breq L44
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0147", -- subi r13 r13 327
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L45
X"820d0004", -- load r0 r13 4 [2] [L44] [L45]
X"8b000001", -- addi r0 r0 1
X"821d0006", -- load r1 r13 6 [2]
X"8b110001", -- addi r1 r1 1
X"d2d00004", -- store r13 r0 4 [2]
X"d2d10006", -- store r13 r1 6 [2]
X"3300ffe0", -- rjmp L38
X"820d0004", -- load r0 r13 4 [2] [L39]
X"81000000", -- load r0 r0 0 [1]
X"821d0006", -- load r1 r13 6 [2]
X"81110000", -- load r1 r1 0 [1]
X"97001000", -- sub r0 r0 r1
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0159", -- subi r13 r13 345
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_length]
X"820d0002", -- load r0 r13 2 [2]
X"8fff0002", -- subi r15 r15 2
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820d0002", -- load r0 r13 2 [2] [L46]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L48
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L49
X"8b0e0001", -- addi r0 r14 1 [L48]
X"e3000000", -- cmpi r0 0 [L49]
X"1b000005", -- breq L47
X"821d0002", -- load r1 r13 2 [2]
X"8b110001", -- addi r1 r1 1
X"d2d10002", -- store r13 r1 2 [2]
X"3300fff4", -- rjmp L46
X"820d0002", -- load r0 r13 2 [2] [L47]
X"821dfffe", -- load r1 r13 -2 [2]
X"97001000", -- sub r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0173", -- subi r13 r13 371
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_copy]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0004", -- load r0 r13 4 [2] [L50]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L52
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L53
X"8b0e0001", -- addi r0 r14 1 [L52]
X"e3000000", -- cmpi r0 0 [L53]
X"1b00000b", -- breq L51
X"821d0006", -- load r1 r13 6 [2]
X"822d0004", -- load r2 r13 4 [2]
X"81220000", -- load r2 r2 0 [1]
X"d1120000", -- store r1 r2 0 [1]
X"823d0004", -- load r3 r13 4 [2]
X"8b330001", -- addi r3 r3 1
X"8b110001", -- addi r1 r1 1
X"d2d10006", -- store r13 r1 6 [2]
X"d2d30004", -- store r13 r3 4 [2]
X"3300ffee", -- rjmp L50
X"cfce0000", -- move r12 r14 [L51]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd018e", -- subi r13 r13 398
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [memset]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"812d0007", -- load r2 r13 7 [1]
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"d2d3fffe", -- store r13 r3 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L54]
X"821d0004", -- load r1 r13 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L56
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L57
X"8b0e0001", -- addi r0 r14 1 [L56]
X"e3000000", -- cmpi r0 0 [L57]
X"1b00000b", -- breq L55
X"822d0002", -- load r2 r13 2 [2]
X"823dfffe", -- load r3 r13 -2 [2]
X"8b4e0001", -- addi r4 r14 1
X"a7434000", -- mul r4 r3 r4
X"93224000", -- add r2 r2 r4
X"814d0007", -- load r4 r13 7 [1]
X"d1240000", -- store r2 r4 0 [1]
X"8b330001", -- addi r3 r3 1
X"d2d3fffe", -- store r13 r3 -2 [2]
X"3300ffee", -- rjmp L54
X"8bff0002", -- addi r15 r15 2 [L55]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01ae", -- subi r13 r13 430
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_index_write]
X"820d0004", -- load r0 r13 4 [2]
X"823d0006", -- load r3 r13 6 [2]
X"824e0400", -- load r4 r14 1024 [2]
X"df034000", -- cmp r3 r4
X"2f000003", -- brge L58
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L59
X"8b3e0001", -- addi r3 r14 1 [L58]
X"e3030000", -- cmpi r3 0 [L59]
X"1b000007", -- breq L60
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01be", -- subi r13 r13 446
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L61
X"8bfffffe", -- addi r15 r15 -2 [L60] [L61]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820d0006", -- load r0 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821d0004", -- load r1 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde01ce", -- addi r13 r14 462
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe59", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01d5", -- subi r13 r13 469
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_coord_write]
X"830d0004", -- load r0 r13 4 [4]
X"821d0008", -- load r1 r13 8 [2]
X"822d000a", -- load r2 r13 10 [2]
X"823e0408", -- load r3 r14 1032 [2]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L62
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L63
X"8b1e0001", -- addi r1 r14 1 [L62]
X"824e040a", -- load r4 r14 1034 [2] [L63]
X"df024000", -- cmp r2 r4
X"2f000003", -- brge L64
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L65
X"8b2e0001", -- addi r2 r14 1 [L64]
X"c3112000", -- or r1 r1 r2 [L65]
X"e3010000", -- cmpi r1 0
X"1b000007", -- breq L66
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01ed", -- subi r13 r13 493
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L67
X"8fff0002", -- subi r15 r15 2 [L66] [L67]
X"820d0008", -- load r0 r13 8 [2]
X"821e0408", -- load r1 r14 1032 [2]
X"822d000a", -- load r2 r13 10 [2]
X"a7112000", -- mul r1 r1 r2
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"833d0004", -- load r3 r13 4 [4]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde0202", -- addi r13 r14 514
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe25", -- rjmp vga_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd020a", -- subi r13 r13 522
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [palette_index_write]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"823e0404", -- load r3 r14 1028 [2]
X"df003000", -- cmp r0 r3
X"2f000003", -- brge L68
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L69
X"8b0e0001", -- addi r0 r14 1 [L68]
X"e3000000", -- cmpi r0 0 [L69]
X"1b000007", -- breq L70
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd021b", -- subi r13 r13 539
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L71
X"8fff0002", -- subi r15 r15 2 [L70] [L71]
X"8b0e04b0", -- addi r0 r14 1200
X"821d0002", -- load r1 r13 2 [2]
X"93001000", -- add r0 r0 r1
X"8fff0002", -- subi r15 r15 2
X"822d0004", -- load r2 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0008", -- addi r3 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"823d0004", -- load r3 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d2fffc", -- store r13 r2 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde0233", -- addi r13 r14 563
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe43", -- rjmp left_shift_i
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0fffc", -- store r13 r0 -4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dfffe", -- load r2 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffc", -- store r13 r0 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde0248", -- addi r13 r14 584
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fddf", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0250", -- subi r13 r13 592
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [set_cursor]
X"810d0002", -- load r0 r13 2 [1]
X"811d0003", -- load r1 r13 3 [1]
X"822e03fc", -- load r2 r14 1020 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L72
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L73
X"8b0e0001", -- addi r0 r14 1 [L72]
X"823e03fe", -- load r3 r14 1022 [2] [L73]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L74
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L75
X"8b1e0001", -- addi r1 r14 1 [L74]
X"c3001000", -- or r0 r0 r1 [L75]
X"e3000000", -- cmpi r0 0
X"1b000007", -- breq L76
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0267", -- subi r13 r13 615
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L77
X"810d0002", -- load r0 r13 2 [1] [L76] [L77]
X"cf100000", -- move r1 r0
X"812d0003", -- load r2 r13 3 [1]
X"cf320000", -- move r3 r2
X"824e03fc", -- load r4 r14 1020 [2]
X"a7224000", -- mul r2 r2 r4
X"93002000", -- add r0 r0 r2
X"d2e00410", -- store r14 r0 1040 [2]
X"d2e10412", -- store r14 r1 1042 [2]
X"d2e30414", -- store r14 r3 1044 [2]
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0277", -- subi r13 r13 631
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_cursor]
X"820e0410", -- load r0 r14 1040 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00410", -- store r14 r0 1040 [2]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L78
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L79
X"8b0e0001", -- addi r0 r14 1 [L78]
X"e3000000", -- cmpi r0 0 [L79]
X"1b000013", -- breq L80
X"820e0412", -- load r0 r14 1042 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00412", -- store r14 r0 1042 [2]
X"821e03fc", -- load r1 r14 1020 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L82
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L83
X"8b0e0001", -- addi r0 r14 1 [L82]
X"e3000000", -- cmpi r0 0 [L83]
X"1b000007", -- breq L84
X"8b0e0000", -- addi r0 r14 0
X"821e0414", -- load r1 r14 1044 [2]
X"8b110001", -- addi r1 r1 1
X"d2e00412", -- store r14 r0 1042 [2]
X"d2e10414", -- store r14 r1 1044 [2]
X"33000001", -- rjmp L85
X"33000007", -- rjmp L81 [L84] [L85]
X"8b0e0000", -- addi r0 r14 0 [L80]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"d2e00410", -- store r14 r0 1040 [2]
X"d2e10412", -- store r14 r1 1042 [2]
X"d2e20414", -- store r14 r2 1044 [2]
X"cfce0000", -- move r12 r14 [L81]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02a0", -- subi r13 r13 672
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_cursor]
X"820e0410", -- load r0 r14 1040 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L86
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L87
X"8b0e0001", -- addi r0 r14 1 [L86]
X"e3000000", -- cmpi r0 0 [L87]
X"1b000007", -- breq L88
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02ae", -- subi r13 r13 686
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L89
X"820e0410", -- load r0 r14 1040 [2] [L88] [L89]
X"8f000001", -- subi r0 r0 1
X"d2e00410", -- store r14 r0 1040 [2]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L90
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L91
X"8b0e0001", -- addi r0 r14 1 [L90]
X"e3000000", -- cmpi r0 0 [L91]
X"1b000012", -- breq L92
X"820e0412", -- load r0 r14 1042 [2]
X"8f000001", -- subi r0 r0 1
X"d2e00412", -- store r14 r0 1042 [2]
X"e3000000", -- cmpi r0 0
X"23000003", -- brlt L94
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L95
X"8b0e0001", -- addi r0 r14 1 [L94]
X"e3000000", -- cmpi r0 0 [L95]
X"1b000007", -- breq L96
X"8b0e0000", -- addi r0 r14 0
X"821e0414", -- load r1 r14 1044 [2]
X"8f110001", -- subi r1 r1 1
X"d2e00412", -- store r14 r0 1042 [2]
X"d2e10414", -- store r14 r1 1044 [2]
X"33000001", -- rjmp L97
X"3300000a", -- rjmp L93 [L96] [L97]
X"820e0400", -- load r0 r14 1024 [2] [L92]
X"8f000001", -- subi r0 r0 1
X"821e03fc", -- load r1 r14 1020 [2]
X"cf210000", -- move r2 r1
X"823e03fe", -- load r3 r14 1022 [2]
X"cf430000", -- move r4 r3
X"d2e00410", -- store r14 r0 1040 [2]
X"d2e20412", -- store r14 r2 1042 [2]
X"d2e40414", -- store r14 r4 1044 [2]
X"cfce0000", -- move r12 r14 [L93]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02d9", -- subi r13 r13 729
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_steps]
X"820d0002", -- load r0 r13 2 [2]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L98
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L99
X"8b0e0001", -- addi r0 r14 1 [L98]
X"e3000000", -- cmpi r0 0 [L99]
X"1b000007", -- breq L100
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02e8", -- subi r13 r13 744
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L101
X"820e0410", -- load r0 r14 1040 [2] [L100] [L101]
X"821d0002", -- load r1 r13 2 [2]
X"93001000", -- add r0 r0 r1
X"d2e00410", -- store r14 r0 1040 [2]
X"822e0400", -- load r2 r14 1024 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L102
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L103
X"8b0e0001", -- addi r0 r14 1 [L102]
X"e3000000", -- cmpi r0 0 [L103]
X"1b000006", -- breq L104
X"820e0410", -- load r0 r14 1040 [2]
X"821e0400", -- load r1 r14 1024 [2]
X"97001000", -- sub r0 r0 r1
X"d2e00410", -- store r14 r0 1040 [2]
X"33000001", -- rjmp L105
X"8fff0004", -- subi r15 r15 4 [L104] [L105]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03fc", -- load r0 r14 1020 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e0410", -- load r1 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde030a", -- addi r13 r14 778
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fded", -- rjmp divide
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e03fe", -- load r1 r14 1022 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"822e0410", -- load r2 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d3d0fffc", -- store r13 r0 -4 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde031e", -- addi r13 r14 798
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdd9", -- rjmp divide
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"831dfffc", -- load r1 r13 -4 [4]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d3d0fff8", -- store r13 r0 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0332", -- addi r13 r14 818
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd2c", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"831dfff8", -- load r1 r13 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d2e00412", -- store r14 r0 1042 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde0346", -- addi r13 r14 838
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd18", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2e00414", -- store r14 r0 1044 [2]
X"8bce0001", -- addi r12 r14 1
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0350", -- subi r13 r13 848
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_line]
X"820e0414", -- load r0 r14 1044 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00414", -- store r14 r0 1044 [2]
X"821e03fe", -- load r1 r14 1022 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L106
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L107
X"8b0e0001", -- addi r0 r14 1 [L106]
X"e3000000", -- cmpi r0 0 [L107]
X"1b000008", -- breq L108
X"820e03fc", -- load r0 r14 1020 [2]
X"821e0414", -- load r1 r14 1044 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0412", -- load r2 r14 1042 [2]
X"93002000", -- add r0 r0 r2
X"d2e00410", -- store r14 r0 1040 [2]
X"33000006", -- rjmp L109
X"820e0412", -- load r0 r14 1042 [2] [L108]
X"cf100000", -- move r1 r0
X"8b2e0000", -- addi r2 r14 0
X"d2e10410", -- store r14 r1 1040 [2]
X"d2e20414", -- store r14 r2 1044 [2]
X"cfce0000", -- move r12 r14 [L109]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd036d", -- subi r13 r13 877
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_line]
X"820e0414", -- load r0 r14 1044 [2]
X"8f000001", -- subi r0 r0 1
X"d2e00414", -- store r14 r0 1044 [2]
X"e3000000", -- cmpi r0 0
X"2f000003", -- brge L110
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L111
X"8b0e0001", -- addi r0 r14 1 [L110]
X"e3000000", -- cmpi r0 0 [L111]
X"1b000008", -- breq L112
X"820e03fc", -- load r0 r14 1020 [2]
X"821e0414", -- load r1 r14 1044 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0412", -- load r2 r14 1042 [2]
X"93002000", -- add r0 r0 r2
X"d2e00410", -- store r14 r0 1040 [2]
X"33000007", -- rjmp L113
X"820e0412", -- load r0 r14 1042 [2] [L112]
X"cf100000", -- move r1 r0
X"822e03fe", -- load r2 r14 1022 [2]
X"8f220001", -- subi r2 r2 1
X"d2e10410", -- store r14 r1 1040 [2]
X"d2e20414", -- store r14 r2 1044 [2]
X"cfce0000", -- move r12 r14 [L113]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd038a", -- subi r13 r13 906
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [new_line]
X"820e0414", -- load r0 r14 1044 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00414", -- store r14 r0 1044 [2]
X"821e03fe", -- load r1 r14 1022 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L114
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L115
X"8b0e0001", -- addi r0 r14 1 [L114]
X"e3000000", -- cmpi r0 0 [L115]
X"1b000006", -- breq L116
X"820e03fc", -- load r0 r14 1020 [2]
X"821e0414", -- load r1 r14 1044 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00410", -- store r14 r0 1040 [2]
X"33000005", -- rjmp L117
X"8b0e0000", -- addi r0 r14 0 [L116]
X"8b1e0000", -- addi r1 r14 0
X"d2e00410", -- store r14 r0 1040 [2]
X"d2e10414", -- store r14 r1 1044 [2]
X"8b0e0000", -- addi r0 r14 0 [L117]
X"d2e00412", -- store r14 r0 1042 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03a6", -- subi r13 r13 934
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"822e040c", -- load r2 r14 1036 [2]
X"823e0404", -- load r3 r14 1028 [2]
X"df023000", -- cmp r2 r3
X"2f000003", -- brge L118
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L119
X"8b2e0001", -- addi r2 r14 1 [L118]
X"824e040e", -- load r4 r14 1038 [2] [L119]
X"df043000", -- cmp r4 r3
X"2f000003", -- brge L120
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L121
X"8b4e0001", -- addi r4 r14 1 [L120]
X"c3224000", -- or r2 r2 r4 [L121]
X"e3020000", -- cmpi r2 0
X"1b000007", -- breq L122
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03be", -- subi r13 r13 958
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L123
X"8fff0002", -- subi r15 r15 2 [L122] [L123]
X"820e040c", -- load r0 r14 1036 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde03cf", -- addi r13 r14 975
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fca7", -- rjmp left_shift_i
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0fffe", -- store r13 r0 -2 [2]
X"821e040e", -- load r1 r14 1038 [2]
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b2e0008", -- addi r2 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde03e3", -- addi r13 r14 995
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc93", -- rjmp left_shift_i
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"811d0005", -- load r1 r13 5 [1]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"93110000", -- add r1 r1 r0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822d0006", -- load r2 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde03fa", -- addi r13 r14 1018
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdb6", -- rjmp tile_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0401", -- subi r13 r13 1025
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at_pos]
X"810d0003", -- load r0 r13 3 [1]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"823e03fc", -- load r3 r14 1020 [2]
X"a7332000", -- mul r3 r3 r2
X"93113000", -- add r1 r1 r3
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde0415", -- addi r13 r14 1045
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff93", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd041b", -- subi r13 r13 1051
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c]
X"810d0003", -- load r0 r13 3 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0410", -- load r1 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde042b", -- addi r13 r14 1067
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff7d", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b00000f", -- breq L124
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde0436", -- addi r13 r14 1078
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe43", -- rjmp advance_cursor
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd043c", -- subi r13 r13 1084
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L125
X"8bce0000", -- addi r12 r14 0 [L124] [L125]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0442", -- subi r13 r13 1090
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print]
X"820d0002", -- load r0 r13 2 [2]
X"820d0002", -- load r0 r13 2 [2] [L126]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1b000014", -- breq L127
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821d0002", -- load r1 r13 2 [2]
X"81110000", -- load r1 r1 0 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0001", -- subi r15 r15 1
X"8bde0455", -- addi r13 r14 1109
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffc8", -- rjmp print_c
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820d0002", -- load r0 r13 2 [2]
X"8b000001", -- addi r0 r0 1
X"d2d00002", -- store r13 r0 2 [2]
X"3300ffea", -- rjmp L126
X"cfce0000", -- move r12 r14 [L127]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0460", -- subi r13 r13 1120
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_at]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820d0004", -- load r0 r13 4 [2] [L128]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1b00001a", -- breq L129
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"821d0006", -- load r1 r13 6 [2]
X"822d0004", -- load r2 r13 4 [2]
X"823dfffe", -- load r3 r13 -2 [2]
X"97223000", -- sub r2 r2 r3
X"93112000", -- add r1 r1 r2
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"824d0004", -- load r4 r13 4 [2]
X"81440000", -- load r4 r4 0 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde047c", -- addi r13 r14 1148
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff2c", -- rjmp print_c_at
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820d0004", -- load r0 r13 4 [2]
X"8b000001", -- addi r0 r0 1
X"d2d00004", -- store r13 r0 4 [2]
X"3300ffe4", -- rjmp L128
X"8bff0002", -- addi r15 r15 2 [L129]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0488", -- subi r13 r13 1160
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_sprite]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820d0002", -- load r0 r13 2 [2] [L130]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1b00002d", -- breq L131
X"821d0002", -- load r1 r13 2 [2]
X"81110000", -- load r1 r1 0 [1]
X"e301000a", -- cmpi r1 10
X"1b000003", -- breq L132
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L133
X"8b1e0001", -- addi r1 r14 1 [L132]
X"e3010000", -- cmpi r1 0 [L133]
X"1b000008", -- breq L134
X"820d0002", -- load r0 r13 2 [2]
X"8b000001", -- addi r0 r0 1
X"821d0006", -- load r1 r13 6 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d10006", -- store r13 r1 6 [2]
X"33000019", -- rjmp L135
X"8bfffffe", -- addi r15 r15 -2 [L134]
X"d2fd0000", -- store r15 r13 0 [2]
X"820d0006", -- load r0 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0002", -- load r2 r13 2 [2]
X"823dfffe", -- load r3 r13 -2 [2]
X"97223000", -- sub r2 r2 r3
X"93112000", -- add r1 r1 r2
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"824d0002", -- load r4 r13 2 [2]
X"81440000", -- load r4 r4 0 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8fff0001", -- subi r15 r15 1
X"8bde04b8", -- addi r13 r14 1208
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff4b", -- rjmp print_c_at_pos
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820d0002", -- load r0 r13 2 [2] [L135]
X"8b000001", -- addi r0 r0 1
X"d2d00002", -- store r13 r0 2 [2]
X"3300ffd1", -- rjmp L130
X"8bff0002", -- addi r15 r15 2 [L131]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04c4", -- subi r13 r13 1220
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [clear]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde04d6", -- addi r13 r14 1238
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb47", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2] [L136]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L138
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L139
X"8b0e0001", -- addi r0 r14 1 [L138]
X"e3000000", -- cmpi r0 0 [L139]
X"1b000015", -- breq L137
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"822dfffe", -- load r2 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b3e0000", -- addi r3 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde04ef", -- addi r13 r14 1263
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcc1", -- rjmp tile_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8b000001", -- addi r0 r0 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"3300ffe4", -- rjmp L136
X"8b0e0000", -- addi r0 r14 0 [L137]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"8bff0002", -- addi r15 r15 2
X"d2e00410", -- store r14 r0 1040 [2]
X"d2e10412", -- store r14 r1 1042 [2]
X"d2e20414", -- store r14 r2 1044 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0501", -- subi r13 r13 1281
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [load_basic_palette]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03b8", -- load r0 r14 952 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03be", -- load r1 r14 958 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0513", -- addi r13 r14 1299
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcf9", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03ba", -- load r0 r14 954 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03bc", -- load r1 r14 956 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0001", -- addi r2 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0526", -- addi r13 r14 1318
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fce6", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03bc", -- load r0 r14 956 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03ba", -- load r1 r14 954 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0002", -- addi r2 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0539", -- addi r13 r14 1337
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcd3", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03be", -- load r0 r14 958 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03b8", -- load r1 r14 952 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0003", -- addi r2 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde054c", -- addi r13 r14 1356
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcc0", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c0", -- load r0 r14 960 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde055e", -- addi r13 r14 1374
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcae", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c2", -- load r0 r14 962 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0005", -- addi r1 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0570", -- addi r13 r14 1392
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc9c", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c4", -- load r0 r14 964 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0006", -- addi r1 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0582", -- addi r13 r14 1410
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc8a", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c6", -- load r0 r14 966 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0007", -- addi r1 r14 7
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0594", -- addi r13 r14 1428
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc78", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c8", -- load r0 r14 968 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0008", -- addi r1 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde05a6", -- addi r13 r14 1446
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc66", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03ca", -- load r0 r14 970 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0009", -- addi r1 r14 9
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde05b8", -- addi r13 r14 1464
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc54", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03cc", -- load r0 r14 972 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000a", -- addi r1 r14 10
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde05ca", -- addi r13 r14 1482
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc42", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03ce", -- load r0 r14 974 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000b", -- addi r1 r14 11
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde05dc", -- addi r13 r14 1500
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc30", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d0", -- load r0 r14 976 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000c", -- addi r1 r14 12
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde05ee", -- addi r13 r14 1518
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc1e", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d2", -- load r0 r14 978 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000d", -- addi r1 r14 13
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0600", -- addi r13 r14 1536
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc0c", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d4", -- load r0 r14 980 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000e", -- addi r1 r14 14
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0612", -- addi r13 r14 1554
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbfa", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b0e000f", -- addi r0 r14 15
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0625", -- addi r13 r14 1573
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbe7", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd062c", -- subi r13 r13 1580
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [read_keyboard]
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0639", -- addi r13 r14 1593
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9d9", -- rjmp in
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0004", -- subi r15 r15 4
X"8b1e1000", -- addi r1 r14 4096
X"bf110000", -- and r1 r1 r0
X"8fff0004", -- subi r15 r15 4
X"8b2e0800", -- addi r2 r14 2048
X"bf220000", -- and r2 r2 r0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0001", -- addi r3 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d3d0fffc", -- store r13 r0 -4 [4]
X"d3d1fff8", -- store r13 r1 -8 [4]
X"d3d2fff4", -- store r13 r2 -12 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0654", -- addi r13 r14 1620
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa0a", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"831dfff4", -- load r1 r13 -12 [4]
X"bf001000", -- and r0 r0 r1
X"e3000000", -- cmpi r0 0
X"1b000009", -- breq L140
X"830dfffc", -- load r0 r13 -4 [4]
X"cfc00000", -- move r12 r0
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0662", -- subi r13 r13 1634
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L141
X"8bff000c", -- addi r15 r15 12 [L140] [L141]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0669", -- subi r13 r13 1641
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [read_char]
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0676", -- addi r13 r14 1654
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f99c", -- rjmp in
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0004", -- subi r15 r15 4
X"8b1e1000", -- addi r1 r14 4096
X"bf110000", -- and r1 r1 r0
X"8fff0004", -- subi r15 r15 4
X"8b2e0800", -- addi r2 r14 2048
X"bf220000", -- and r2 r2 r0
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0001", -- addi r3 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d3d0fffc", -- store r13 r0 -4 [4]
X"d3d1fff8", -- store r13 r1 -8 [4]
X"d3d2fff4", -- store r13 r2 -12 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0692", -- addi r13 r14 1682
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9cc", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"d3d0fff0", -- store r13 r0 -16 [4]
X"832dfff4", -- load r2 r13 -12 [4]
X"bf002000", -- and r0 r0 r2
X"d2d1ffee", -- store r13 r1 -18 [2]
X"e3000000", -- cmpi r0 0
X"1b00000b", -- breq L142
X"8b0e00ff", -- addi r0 r14 255
X"831dfffc", -- load r1 r13 -4 [4]
X"bf001000", -- and r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0012", -- addi r15 r15 18
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd06a6", -- subi r13 r13 1702
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L143
X"8bff0012", -- addi r15 r15 18 [L142] [L143]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd06ad", -- subi r13 r13 1709
X"ef0d0000", -- rjmprg r13
X"8bde06b2", -- addi r13 r14 1714
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"cfdf0000", -- move r13 r15 [rjmp_user_program]
X"820d0002", -- load r0 r13 2 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L144
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L145
X"8b0e0001", -- addi r0 r14 1 [L144]
X"e3000000", -- cmpi r0 0 [L145]
X"1b00000a", -- breq L146
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde06c0", -- addi r13 r14 1728
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300006f", -- rjmp disco
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000067", -- rjmp L147
X"820d0002", -- load r0 r13 2 [2] [L146]
X"e3000001", -- cmpi r0 1
X"1b000003", -- breq L148
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L149
X"8b0e0001", -- addi r0 r14 1 [L148]
X"e3000000", -- cmpi r0 0 [L149]
X"1b00000a", -- breq L150
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde06d1", -- addi r13 r14 1745
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"330001c8", -- rjmp ls
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000056", -- rjmp L151
X"820d0002", -- load r0 r13 2 [2] [L150]
X"e3000002", -- cmpi r0 2
X"1b000003", -- breq L152
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L153
X"8b0e0001", -- addi r0 r14 1 [L152]
X"e3000000", -- cmpi r0 0 [L153]
X"1b00000a", -- breq L154
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde06e2", -- addi r13 r14 1762
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000282", -- rjmp matrix
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000045", -- rjmp L155
X"820d0002", -- load r0 r13 2 [2] [L154]
X"e3000003", -- cmpi r0 3
X"1b000003", -- breq L156
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L157
X"8b0e0001", -- addi r0 r14 1 [L156]
X"e3000000", -- cmpi r0 0 [L157]
X"1b00000a", -- breq L158
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde06f3", -- addi r13 r14 1779
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000349", -- rjmp pong
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000034", -- rjmp L159
X"820d0002", -- load r0 r13 2 [2] [L158]
X"e3000004", -- cmpi r0 4
X"1b000003", -- breq L160
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L161
X"8b0e0001", -- addi r0 r14 1 [L160]
X"e3000000", -- cmpi r0 0 [L161]
X"1b00000a", -- breq L162
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde0704", -- addi r13 r14 1796
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000a2b", -- rjmp rainbow
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000023", -- rjmp L163
X"820d0002", -- load r0 r13 2 [2] [L162]
X"e3000005", -- cmpi r0 5
X"1b000003", -- breq L164
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L165
X"8b0e0001", -- addi r0 r14 1 [L164]
X"e3000000", -- cmpi r0 0 [L165]
X"1b00000a", -- breq L166
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde0715", -- addi r13 r14 1813
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000ab4", -- rjmp screensaver
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000012", -- rjmp L167
X"820d0002", -- load r0 r13 2 [2] [L166]
X"e3000006", -- cmpi r0 6
X"1b000003", -- breq L168
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L169
X"8b0e0001", -- addi r0 r14 1 [L168]
X"e3000000", -- cmpi r0 0 [L169]
X"1b00000a", -- breq L170
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde0726", -- addi r13 r14 1830
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000b46", -- rjmp snake_paint
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L171
X"cfce0000", -- move r12 r14 [L170] [L171] [L167] [L163] [L159] [L155] [L151] [L147]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd072d", -- subi r13 r13 1837
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [disco]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8fff0010", -- subi r15 r15 16
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"8b4e0000", -- addi r4 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0045", -- addi r4 r14 69
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0059", -- addi r4 r14 89
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0042", -- addi r4 r14 66
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0044", -- addi r4 r14 68
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e004f", -- addi r4 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e004f", -- addi r4 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0047", -- addi r4 r14 71
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"8b4e0000", -- addi r4 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b5e0000", -- addi r5 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b6e0000", -- addi r6 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f60000", -- store r15 r6 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f50000", -- store r15 r5 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"d1d2ffea", -- store r13 r2 -22 [1]
X"d1d3ffe8", -- store r13 r3 -24 [1]
X"d2e4040e", -- store r14 r4 1038 [2]
X"d1d5ffde", -- store r13 r5 -34 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde0766", -- addi r13 r14 1894
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f8b7", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffde", -- load r0 r13 -34 [1] [L172]
X"e3000010", -- cmpi r0 16
X"23000003", -- brlt L174
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L175
X"8b0e0001", -- addi r0 r14 1 [L174]
X"e3000000", -- cmpi r0 0 [L175]
X"1b000026", -- breq L173
X"8b1dffec", -- addi r1 r13 -20
X"812dffde", -- load r2 r13 -34 [1]
X"8b3e0001", -- addi r3 r14 1
X"a7323000", -- mul r3 r2 r3
X"93113000", -- add r1 r1 r3
X"8b3e0010", -- addi r3 r14 16
X"a7223000", -- mul r2 r2 r3
X"8b220086", -- addi r2 r2 134
X"d1120000", -- store r1 r2 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1dffec", -- addi r1 r13 -20
X"813dffde", -- load r3 r13 -34 [1]
X"93313000", -- add r3 r1 r3
X"81330000", -- load r3 r3 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8b1dffec", -- addi r1 r13 -20
X"814dffde", -- load r4 r13 -34 [1]
X"93414000", -- add r4 r1 r4
X"81440000", -- load r4 r4 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"815dffde", -- load r5 r13 -34 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f50000", -- store r15 r5 0 [2]
X"8bde078f", -- addi r13 r14 1935
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa7d", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffde", -- load r0 r13 -34 [1]
X"8b000001", -- addi r0 r0 1
X"d1d0ffde", -- store r13 r0 -34 [1]
X"3300ffd4", -- rjmp L172
X"8b0e0000", -- addi r0 r14 0 [L173] [L176]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde07a5", -- addi r13 r14 1957
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f878", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2] [L178]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L180
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L181
X"8b0e0001", -- addi r0 r14 1 [L180]
X"e3000000", -- cmpi r0 0 [L181]
X"1b0000d7", -- breq L179
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde07b8", -- addi r13 r14 1976
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300feb3", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d1d0ffe8", -- store r13 r0 -24 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde07ca", -- addi r13 r14 1994
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f853", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffe8", -- load r0 r13 -24 [1]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L182
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L183
X"8b0e0001", -- addi r0 r14 1 [L182]
X"e3000000", -- cmpi r0 0 [L183]
X"1b000021", -- breq L184
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0dffe0", -- addi r0 r13 -32
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde07de", -- addi r13 r14 2014
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc66", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde07eb", -- addi r13 r14 2027
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f8eb", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff0022", -- addi r15 r15 34
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd07f3", -- subi r13 r13 2035
X"ef0d0000", -- rjmprg r13
X"33000010", -- rjmp L185
X"810dffe8", -- load r0 r13 -24 [1] [L184]
X"e3000061", -- cmpi r0 97
X"1b000003", -- breq L186
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L187
X"8b0e0001", -- addi r0 r14 1 [L186]
X"e3000000", -- cmpi r0 0 [L187]
X"1b000005", -- breq L188
X"820dfffe", -- load r0 r13 -2 [2]
X"8b00001f", -- addi r0 r0 31
X"d2d0fffe", -- store r13 r0 -2 [2]
X"33000004", -- rjmp L189
X"820dfffe", -- load r0 r13 -2 [2] [L188]
X"8b000001", -- addi r0 r0 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2 [L189] [L185]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d1d0ffdc", -- store r13 r0 -36 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde0815", -- addi r13 r14 2069
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f808", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffdc", -- load r0 r13 -36 [1] [L190]
X"e3000010", -- cmpi r0 16
X"23000003", -- brlt L192
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L193
X"8b0e0001", -- addi r0 r14 1 [L192]
X"e3000000", -- cmpi r0 0 [L193]
X"1b000028", -- breq L191
X"8b1dffec", -- addi r1 r13 -20
X"812dffdc", -- load r2 r13 -36 [1]
X"8b3e0001", -- addi r3 r14 1
X"a7323000", -- mul r3 r2 r3
X"93113000", -- add r1 r1 r3
X"8b3dffec", -- addi r3 r13 -20
X"93232000", -- add r2 r3 r2
X"81220000", -- load r2 r2 0 [1]
X"8b220001", -- addi r2 r2 1
X"d1120000", -- store r1 r2 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3dffec", -- addi r3 r13 -20
X"811dffdc", -- load r1 r13 -36 [1]
X"93131000", -- add r1 r3 r1
X"81110000", -- load r1 r1 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b3dffec", -- addi r3 r13 -20
X"814dffdc", -- load r4 r13 -36 [1]
X"93434000", -- add r4 r3 r4
X"81440000", -- load r4 r4 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"815dffdc", -- load r5 r13 -36 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2f50000", -- store r15 r5 0 [2]
X"8bde0840", -- addi r13 r14 2112
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9cc", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffdc", -- load r0 r13 -36 [1]
X"8b000001", -- addi r0 r0 1
X"d1d0ffdc", -- store r13 r0 -36 [1]
X"3300ffd2", -- rjmp L190
X"810dffea", -- load r0 r13 -22 [1] [L191]
X"8b000001", -- addi r0 r0 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d1d0ffea", -- store r13 r0 -22 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde0858", -- addi r13 r14 2136
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f7c5", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dffea", -- load r0 r13 -22 [1]
X"e3000010", -- cmpi r0 16
X"2f000003", -- brge L194
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L195
X"8b0e0001", -- addi r0 r14 1 [L194]
X"e3000000", -- cmpi r0 0 [L195]
X"1b000004", -- breq L196
X"8b0e0000", -- addi r0 r14 0
X"d1d0ffea", -- store r13 r0 -22 [1]
X"33000001", -- rjmp L197
X"810dffea", -- load r0 r13 -22 [1] [L196] [L197]
X"cf100000", -- move r1 r0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde0874", -- addi r13 r14 2164
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fba9", -- rjmp print_c
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0004", -- addi r0 r14 4
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0882", -- addi r13 r14 2178
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f854", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0002", -- addi r15 r15 2
X"3300ff22", -- rjmp L178
X"8bfffffe", -- addi r15 r15 -2 [L179]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde088e", -- addi r13 r14 2190
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc38", -- rjmp clear
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300ff05", -- rjmp L176
X"8bce0000", -- addi r12 r14 0 [L177]
X"8bff0022", -- addi r15 r15 34
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0897", -- subi r13 r13 2199
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [ls]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0416", -- addi r1 r14 1046
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"822e044e", -- load r2 r14 1102 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde08ae", -- addi r13 r14 2222
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f76f", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2] [L198]
X"821e044e", -- load r1 r14 1102 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L200
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L201
X"8b0e0001", -- addi r0 r14 1 [L200]
X"e3000000", -- cmpi r0 0 [L201]
X"1b00003d", -- breq L199
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"822dfffc", -- load r2 r13 -4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde08c4", -- addi r13 r14 2244
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f897", -- rjmp string_length
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e002a", -- addi r1 r14 42
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"d2d0fffa", -- store r13 r0 -6 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde08d3", -- addi r13 r14 2259
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb4a", -- rjmp print_c
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820dfffc", -- load r0 r13 -4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde08df", -- addi r13 r14 2271
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb65", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde08e9", -- addi r13 r14 2281
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300faa3", -- rjmp new_line
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffc", -- load r0 r13 -4 [2]
X"821dfffa", -- load r1 r13 -6 [2]
X"93001000", -- add r0 r0 r1
X"8b000001", -- addi r0 r0 1
X"822dfffe", -- load r2 r13 -2 [2]
X"8b220001", -- addi r2 r2 1
X"8bff0002", -- addi r15 r15 2
X"d2d0fffc", -- store r13 r0 -4 [2]
X"d2d2fffe", -- store r13 r2 -2 [2]
X"3300ffbc", -- rjmp L198
X"8bfffffe", -- addi r15 r15 -2 [L199]
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde08fc", -- addi r13 r14 2300
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa90", -- rjmp new_line
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e002e", -- addi r0 r14 46
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0074", -- addi r0 r14 116
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0069", -- addi r0 r14 105
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0075", -- addi r0 r14 117
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0071", -- addi r0 r14 113
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0020", -- addi r0 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e006f", -- addi r0 r14 111
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0074", -- addi r0 r14 116
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0020", -- addi r0 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0043", -- addi r0 r14 67
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0053", -- addi r0 r14 83
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0045", -- addi r0 r14 69
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0020", -- addi r0 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0073", -- addi r0 r14 115
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0073", -- addi r0 r14 115
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0065", -- addi r0 r14 101
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0072", -- addi r0 r14 114
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0050", -- addi r0 r14 80
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0001", -- subi r15 r15 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0dffe9", -- addi r0 r13 -23
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0942", -- addi r13 r14 2370
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb02", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d1d0ffe6", -- store r13 r0 -26 [1]
X"810dffe6", -- load r0 r13 -26 [1] [L202]
X"e300001b", -- cmpi r0 27
X"1f000003", -- brne L204
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L205
X"8b0e0001", -- addi r0 r14 1 [L204]
X"e3000000", -- cmpi r0 0 [L205]
X"1b00000e", -- breq L203
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde0957", -- addi r13 r14 2391
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd14", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d1d0ffe6", -- store r13 r0 -26 [1]
X"3300ffec", -- rjmp L202
X"8bff001a", -- addi r15 r15 26 [L203]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0962", -- subi r13 r13 2402
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [matrix]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e0045", -- addi r2 r14 69
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e0059", -- addi r2 r14 89
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e0042", -- addi r2 r14 66
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e0044", -- addi r2 r14 68
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e004f", -- addi r2 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e004f", -- addi r2 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8b2e0047", -- addi r2 r14 71
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"8fff0004", -- subi r15 r15 4
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"823e03b8", -- load r3 r14 952 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"824e03c8", -- load r4 r14 968 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"8b5e0000", -- addi r5 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f50000", -- store r15 r5 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d1d1fffc", -- store r13 r1 -4 [1]
X"d3d2fff0", -- store r13 r2 -16 [4]
X"8bde0995", -- addi r13 r14 2453
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f877", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8b1e0000", -- addi r1 r14 0
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8b0e0000", -- addi r0 r14 0 [L206]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde09ac", -- addi r13 r14 2476
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f671", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2] [L208]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L210
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L211
X"8b0e0001", -- addi r0 r14 1 [L210]
X"e3000000", -- cmpi r0 0 [L211]
X"1b00007d", -- breq L209
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde09be", -- addi r13 r14 2494
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcad", -- rjmp read_char
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d1d0fffc", -- store r13 r0 -4 [1]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L212
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L213
X"8b0e0001", -- addi r0 r14 1 [L212]
X"e3000000", -- cmpi r0 0 [L213]
X"1b000033", -- breq L214
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e000e", -- addi r0 r14 14
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0010", -- addi r0 r14 16
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8bde09d6", -- addi r13 r14 2518
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f87c", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0dfff4", -- addi r0 r13 -12
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde09e3", -- addi r13 r14 2531
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa61", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde09f1", -- addi r13 r14 2545
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f6e5", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff0010", -- addi r15 r15 16
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd09f9", -- subi r13 r13 2553
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L215
X"8bfffffe", -- addi r15 r15 -2 [L214] [L215]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"811dfffc", -- load r1 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde0a09", -- addi r13 r14 2569
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f99f", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8b000001", -- addi r0 r0 1
X"8fff0004", -- subi r15 r15 4
X"8b1e0708", -- addi r1 r14 1800
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d3d1ffec", -- store r13 r1 -20 [4]
X"d3d2fff0", -- store r13 r2 -16 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0a22", -- addi r13 r14 2594
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f5fb", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"830dfff0", -- load r0 r13 -16 [4] [L216]
X"831dffec", -- load r1 r13 -20 [4]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L218
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L219
X"8b0e0001", -- addi r0 r14 1 [L218]
X"e3000000", -- cmpi r0 0 [L219]
X"1b000005", -- breq L217
X"832dfff0", -- load r2 r13 -16 [4]
X"8b220001", -- addi r2 r2 1
X"d3d2fff0", -- store r13 r2 -16 [4]
X"3300fff4", -- rjmp L216
X"8bff0004", -- addi r15 r15 4 [L217]
X"3300ff7c", -- rjmp L208
X"3300ff68", -- rjmp L206 [L209]
X"8bce0000", -- addi r12 r14 0 [L207]
X"8bff0010", -- addi r15 r15 16
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0a3a", -- subi r13 r13 2618
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [pong]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0008", -- addi r1 r14 8
X"8fff0002", -- subi r15 r15 2
X"8b2e0013", -- addi r2 r14 19
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"823e03f2", -- load r3 r14 1010 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8b4e0000", -- addi r4 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"d1d0fffe", -- store r13 r0 -2 [1]
X"d1d1fffc", -- store r13 r1 -4 [1]
X"d1d2fffa", -- store r13 r2 -6 [1]
X"8bde0a53", -- addi r13 r14 2643
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f7b9", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03f4", -- load r0 r14 1012 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0001", -- addi r1 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0a64", -- addi r13 r14 2660
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f7a8", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03f2", -- load r0 r14 1010 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03e2", -- load r1 r14 994 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0002", -- addi r2 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0a76", -- addi r13 r14 2678
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f796", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03f4", -- load r0 r14 1012 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03e2", -- load r1 r14 994 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0003", -- addi r2 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0a88", -- addi r13 r14 2696
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f784", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03f2", -- load r0 r14 1010 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0a99", -- addi r13 r14 2713
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f773", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03e2", -- load r0 r14 994 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0005", -- addi r1 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde0aaa", -- addi r13 r14 2730
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f762", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03f4", -- load r0 r14 1012 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03e2", -- load r1 r14 994 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0006", -- addi r2 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde0abc", -- addi r13 r14 2748
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f750", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fff0002", -- subi r15 r15 2 [L220]
X"8b0e0001", -- addi r0 r14 1
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b4e0013", -- addi r4 r14 19
X"8fff0002", -- subi r15 r15 2
X"8b5e000e", -- addi r5 r14 14
X"8fff0002", -- subi r15 r15 2
X"8b6e0000", -- addi r6 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b7e0000", -- addi r7 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b8e0001", -- addi r8 r14 1
X"8fff0002", -- subi r15 r15 2
X"8b9e0001", -- addi r9 r14 1
X"8fff0002", -- subi r15 r15 2
X"8bae0002", -- addi r10 r14 2
X"8fff0002", -- subi r15 r15 2
X"8bbe000c", -- addi r11 r14 12
X"8fff0002", -- subi r15 r15 2
X"8bce0025", -- addi r12 r14 37
X"8fff0002", -- subi r15 r15 2
X"d2d0fff8", -- store r13 r0 -8 [2]
X"8b0e000c", -- addi r0 r14 12
X"8fff04b0", -- subi r15 r15 1200
X"8fff0002", -- subi r15 r15 2
X"d2d1fff6", -- store r13 r1 -10 [2]
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"d2d2fff4", -- store r13 r2 -12 [2]
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"d1d3fff2", -- store r13 r3 -14 [1]
X"8b3e0000", -- addi r3 r14 0
X"8b1e0000", -- addi r1 r14 0
X"d2d0ffde", -- store r13 r0 -34 [2]
X"d2d1fb2c", -- store r13 r1 -1236 [2]
X"d2d2fb2a", -- store r13 r2 -1238 [2]
X"d2d3fb28", -- store r13 r3 -1240 [2]
X"d2d4fff0", -- store r13 r4 -16 [2]
X"d2d5ffee", -- store r13 r5 -18 [2]
X"d2d6ffec", -- store r13 r6 -20 [2]
X"d2d7ffea", -- store r13 r7 -22 [2]
X"d2d8ffe8", -- store r13 r8 -24 [2]
X"d2d9ffe6", -- store r13 r9 -26 [2]
X"d2daffe4", -- store r13 r10 -28 [2]
X"d2dbffe2", -- store r13 r11 -30 [2]
X"d2dcffe0", -- store r13 r12 -32 [2]
X"820dfb2c", -- load r0 r13 -1236 [2] [L222]
X"e30004b0", -- cmpi r0 1200
X"23000003", -- brlt L224
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L225
X"8b0e0001", -- addi r0 r14 1 [L224]
X"e3000000", -- cmpi r0 0 [L225]
X"1b00000b", -- breq L223
X"8b1dfb2e", -- addi r1 r13 -1234
X"822dfb2c", -- load r2 r13 -1236 [2]
X"8b3e0001", -- addi r3 r14 1
X"a7323000", -- mul r3 r2 r3
X"93113000", -- add r1 r1 r3
X"813e0462", -- load r3 r14 1122 [1]
X"d1130000", -- store r1 r3 0 [1]
X"8b220001", -- addi r2 r2 1
X"d2d2fb2c", -- store r13 r2 -1236 [2]
X"3300ffef", -- rjmp L222
X"8bfffffe", -- addi r15 r15 -2 [L223]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b0e1111", -- addi r0 r14 4369
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0b15", -- addi r13 r14 2837
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f508", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0002", -- addi r0 r14 2
X"d2d0fb2c", -- store r13 r0 -1236 [2]
X"821e0452", -- load r1 r14 1106 [2]
X"822e045e", -- load r2 r14 1118 [2]
X"97112000", -- sub r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L226
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L227
X"8b0e0001", -- addi r0 r14 1 [L226]
X"e3000000", -- cmpi r0 0 [L227]
X"1b000014", -- breq L228
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dfb2c", -- load r0 r13 -1236 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0b33", -- addi r13 r14 2867
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4ea", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L229
X"820dfb2c", -- load r0 r13 -1236 [2] [L228] [L229] [L230]
X"821e0452", -- load r1 r14 1106 [2]
X"822e045e", -- load r2 r14 1118 [2]
X"97112000", -- sub r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L232
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L233
X"8b0e0001", -- addi r0 r14 1 [L232]
X"e3000000", -- cmpi r0 0 [L233]
X"1b00002a", -- breq L231
X"8b3dfb2e", -- addi r3 r13 -1234
X"824dfb2c", -- load r4 r13 -1236 [2]
X"825e0450", -- load r5 r14 1104 [2]
X"a7445000", -- mul r4 r4 r5
X"8b6e0001", -- addi r6 r14 1
X"a7646000", -- mul r6 r4 r6
X"93336000", -- add r3 r3 r6
X"816e0469", -- load r6 r14 1129 [1]
X"d1360000", -- store r3 r6 0 [1]
X"8b3dfb2e", -- addi r3 r13 -1234
X"827dfb2c", -- load r7 r13 -1236 [2]
X"a7775000", -- mul r7 r7 r5
X"8b770001", -- addi r7 r7 1
X"8b8e0001", -- addi r8 r14 1
X"a7878000", -- mul r8 r7 r8
X"93338000", -- add r3 r3 r8
X"d1360000", -- store r3 r6 0 [1]
X"8b3dfb2e", -- addi r3 r13 -1234
X"828dfb2c", -- load r8 r13 -1236 [2]
X"a7885000", -- mul r8 r8 r5
X"8f550002", -- subi r5 r5 2
X"93885000", -- add r8 r8 r5
X"8b9e0001", -- addi r9 r14 1
X"a7989000", -- mul r9 r8 r9
X"93339000", -- add r3 r3 r9
X"819e046a", -- load r9 r14 1130 [1]
X"d1390000", -- store r3 r9 0 [1]
X"8b3dfb2e", -- addi r3 r13 -1234
X"82adfb2c", -- load r10 r13 -1236 [2]
X"82be0450", -- load r11 r14 1104 [2]
X"a7aab000", -- mul r10 r10 r11
X"8fbb0001", -- subi r11 r11 1
X"93aab000", -- add r10 r10 r11
X"8bce0001", -- addi r12 r14 1
X"a7cac000", -- mul r12 r10 r12
X"9333c000", -- add r3 r3 r12
X"d1390000", -- store r3 r9 0 [1]
X"823dfb2c", -- load r3 r13 -1236 [2]
X"8b330001", -- addi r3 r3 1
X"d2d3fb2c", -- store r13 r3 -1236 [2]
X"3300ffcd", -- rjmp L230
X"8b0e0000", -- addi r0 r14 0 [L231]
X"d2d0fb2c", -- store r13 r0 -1236 [2]
X"820dfb2c", -- load r0 r13 -1236 [2] [L234]
X"821e0450", -- load r1 r14 1104 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L236
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L237
X"8b0e0001", -- addi r0 r14 1 [L236]
X"e3000000", -- cmpi r0 0 [L237]
X"1b000024", -- breq L235
X"8b2dfb2e", -- addi r2 r13 -1234
X"823dfb2c", -- load r3 r13 -1236 [2]
X"8b4e0001", -- addi r4 r14 1
X"a7434000", -- mul r4 r3 r4
X"93224000", -- add r2 r2 r4
X"814e0463", -- load r4 r14 1123 [1]
X"d1240000", -- store r2 r4 0 [1]
X"8b2dfb2e", -- addi r2 r13 -1234
X"93113000", -- add r1 r1 r3
X"8b5e0001", -- addi r5 r14 1
X"a7515000", -- mul r5 r1 r5
X"93225000", -- add r2 r2 r5
X"d1240000", -- store r2 r4 0 [1]
X"8b2dfb2e", -- addi r2 r13 -1234
X"825e0452", -- load r5 r14 1106 [2]
X"8f550002", -- subi r5 r5 2
X"826e0450", -- load r6 r14 1104 [2]
X"a7556000", -- mul r5 r5 r6
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93227000", -- add r2 r2 r7
X"d1240000", -- store r2 r4 0 [1]
X"8b2dfb2e", -- addi r2 r13 -1234
X"827e0452", -- load r7 r14 1106 [2]
X"8f770001", -- subi r7 r7 1
X"a7776000", -- mul r7 r7 r6
X"93773000", -- add r7 r7 r3
X"8b8e0001", -- addi r8 r14 1
X"a7878000", -- mul r8 r7 r8
X"93228000", -- add r2 r2 r8
X"d1240000", -- store r2 r4 0 [1]
X"8b330001", -- addi r3 r3 1
X"d2d3fb2c", -- store r13 r3 -1236 [2]
X"3300ffd5", -- rjmp L234
X"8b0dfb2e", -- addi r0 r13 -1234 [L235]
X"821e0458", -- load r1 r14 1112 [2]
X"822e0450", -- load r2 r14 1104 [2]
X"a7112000", -- mul r1 r1 r2
X"823e0456", -- load r3 r14 1110 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e0467", -- load r4 r14 1127 [1]
X"d1040000", -- store r0 r4 0 [1]
X"8b0dfb2e", -- addi r0 r13 -1234
X"825e045c", -- load r5 r14 1116 [2]
X"a7552000", -- mul r5 r5 r2
X"826e045a", -- load r6 r14 1114 [2]
X"93556000", -- add r5 r5 r6
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93007000", -- add r0 r0 r7
X"817e0468", -- load r7 r14 1128 [1]
X"d1070000", -- store r0 r7 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f3000000", -- movhi r0 r0 0
X"f700fefe", -- movlo r0 r0 65278
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0bbe", -- addi r13 r14 3006
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f45f", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fb2c", -- store r13 r0 -1236 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L238
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L239
X"8b0e0001", -- addi r0 r14 1 [L238]
X"e3000000", -- cmpi r0 0 [L239]
X"1b000014", -- breq L240
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dfb2c", -- load r0 r13 -1236 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0bd9", -- addi r13 r14 3033
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f444", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L241
X"820dfb2c", -- load r0 r13 -1236 [2] [L240] [L241] [L242]
X"821e0454", -- load r1 r14 1108 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L244
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L245
X"8b0e0001", -- addi r0 r14 1 [L244]
X"e3000000", -- cmpi r0 0 [L245]
X"1b00002f", -- breq L243
X"8b2dfb2e", -- addi r2 r13 -1234
X"823dffe2", -- load r3 r13 -30 [2]
X"824dfb2c", -- load r4 r13 -1236 [2]
X"93334000", -- add r3 r3 r4
X"825e0450", -- load r5 r14 1104 [2]
X"a7335000", -- mul r3 r3 r5
X"826dffe4", -- load r6 r13 -28 [2]
X"93336000", -- add r3 r3 r6
X"8b7e0001", -- addi r7 r14 1
X"a7737000", -- mul r7 r3 r7
X"93227000", -- add r2 r2 r7
X"817e0464", -- load r7 r14 1124 [1]
X"d1270000", -- store r2 r7 0 [1]
X"8b2dfb2e", -- addi r2 r13 -1234
X"828dffde", -- load r8 r13 -34 [2]
X"93884000", -- add r8 r8 r4
X"a7885000", -- mul r8 r8 r5
X"829dffe0", -- load r9 r13 -32 [2]
X"93889000", -- add r8 r8 r9
X"8bae0001", -- addi r10 r14 1
X"a7a8a000", -- mul r10 r8 r10
X"9322a000", -- add r2 r2 r10
X"81ae0465", -- load r10 r14 1125 [1]
X"d12a0000", -- store r2 r10 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b2e1010", -- addi r2 r14 4112
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0c0d", -- addi r13 r14 3085
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f410", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfb2c", -- load r0 r13 -1236 [2]
X"8b000001", -- addi r0 r0 1
X"d2d0fb2c", -- store r13 r0 -1236 [2]
X"3300ffca", -- rjmp L242
X"8b0dfb2e", -- addi r0 r13 -1234 [L243]
X"821dffee", -- load r1 r13 -18 [2]
X"822e0450", -- load r2 r14 1104 [2]
X"a7112000", -- mul r1 r1 r2
X"823dfff0", -- load r3 r13 -16 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e0466", -- load r4 r14 1126 [1]
X"d1040000", -- store r0 r4 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b0e000f", -- addi r0 r14 15
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0c2e", -- addi r13 r14 3118
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f3ef", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"810dfffc", -- load r0 r13 -4 [1]
X"8f000002", -- subi r0 r0 2
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"811dfffa", -- load r1 r13 -6 [1]
X"8f110005", -- subi r1 r1 5
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8bde0c40", -- addi r13 r14 3136
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f612", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0006", -- addi r0 r14 6
X"8b1e0006", -- addi r1 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e046c", -- addi r2 r14 1132
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d2e0040e", -- store r14 r0 1038 [2]
X"d2e1040c", -- store r14 r1 1036 [2]
X"8bde0c51", -- addi r13 r14 3153
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f7f3", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0c5f", -- addi r13 r14 3167
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f477", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfff8", -- load r0 r13 -8 [2] [L246]
X"e3000001", -- cmpi r0 1
X"1b000003", -- breq L248
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L249
X"8b0e0001", -- addi r0 r14 1 [L248]
X"e3000000", -- cmpi r0 0 [L249]
X"1b000388", -- breq L247
X"8fff0004", -- subi r15 r15 4
X"f3110000", -- movhi r1 r1 0
X"f7119600", -- movlo r1 r1 38400
X"8fff0004", -- subi r15 r15 4
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"d3d1fb24", -- store r13 r1 -1244 [4]
X"d3d2fb20", -- store r13 r2 -1248 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0c7f", -- addi r13 r14 3199
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f39e", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8b1e0000", -- addi r1 r14 0
X"d2d0fb2a", -- store r13 r0 -1238 [2]
X"d2d1fb28", -- store r13 r1 -1240 [2]
X"830dfb20", -- load r0 r13 -1248 [4] [L250]
X"831dfb24", -- load r1 r13 -1244 [4]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L252
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L253
X"8b0e0001", -- addi r0 r14 1 [L252]
X"e3000000", -- cmpi r0 0 [L253]
X"1b00008c", -- breq L251
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde0c95", -- addi r13 r14 3221
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9d6", -- rjmp read_char
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d1d0fffe", -- store r13 r0 -2 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde0ca7", -- addi r13 r14 3239
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f376", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dfffe", -- load r0 r13 -2 [1]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L254
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L255
X"8b0e0001", -- addi r0 r14 1 [L254]
X"e3000000", -- cmpi r0 0 [L255]
X"1b000039", -- breq L256
X"8b0e0006", -- addi r0 r14 6
X"8b1e0006", -- addi r1 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"812dfffc", -- load r2 r13 -4 [1]
X"8f220002", -- subi r2 r2 2
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"813dfffa", -- load r3 r13 -6 [1]
X"8f330003", -- subi r3 r3 3
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"d2e1040c", -- store r14 r1 1036 [2]
X"8bde0cc5", -- addi r13 r14 3269
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f58d", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e04bd", -- addi r0 r14 1213
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0cd2", -- addi r13 r14 3282
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f772", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0ce0", -- addi r13 r14 3296
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f3f6", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff04e0", -- addi r15 r15 1248
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0ce8", -- subi r13 r13 3304
X"ef0d0000", -- rjmprg r13
X"3300002d", -- rjmp L257
X"810dfffe", -- load r0 r13 -2 [1] [L256]
X"e3000073", -- cmpi r0 115
X"1b000003", -- breq L258
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L259
X"8b0e0001", -- addi r0 r14 1 [L258]
X"e3000000", -- cmpi r0 0 [L259]
X"1b000004", -- breq L260
X"8b0effff", -- addi r0 r14 -1
X"d2d0fb2a", -- store r13 r0 -1238 [2]
X"33000022", -- rjmp L261
X"810dfffe", -- load r0 r13 -2 [1] [L260]
X"e3000077", -- cmpi r0 119
X"1b000003", -- breq L262
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L263
X"8b0e0001", -- addi r0 r14 1 [L262]
X"e3000000", -- cmpi r0 0 [L263]
X"1b000004", -- breq L264
X"8b0e0001", -- addi r0 r14 1
X"d2d0fb2a", -- store r13 r0 -1238 [2]
X"33000017", -- rjmp L265
X"810dfffe", -- load r0 r13 -2 [1] [L264]
X"e300006c", -- cmpi r0 108
X"1b000003", -- breq L266
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L267
X"8b0e0001", -- addi r0 r14 1 [L266]
X"e3000000", -- cmpi r0 0 [L267]
X"1b000004", -- breq L268
X"8b0effff", -- addi r0 r14 -1
X"d2d0fb28", -- store r13 r0 -1240 [2]
X"3300000c", -- rjmp L269
X"810dfffe", -- load r0 r13 -2 [1] [L268]
X"e300006f", -- cmpi r0 111
X"1b000003", -- breq L270
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L271
X"8b0e0001", -- addi r0 r14 1 [L270]
X"e3000000", -- cmpi r0 0 [L271]
X"1b000004", -- breq L272
X"8b0e0001", -- addi r0 r14 1
X"d2d0fb28", -- store r13 r0 -1240 [2]
X"33000001", -- rjmp L273
X"830dfb20", -- load r0 r13 -1248 [4] [L272] [L273] [L269] [L265] [L261] [L257]
X"8b000001", -- addi r0 r0 1
X"d3d0fb20", -- store r13 r0 -1248 [4]
X"3300ff6d", -- rjmp L250
X"820dfb2a", -- load r0 r13 -1238 [2] [L251]
X"e300ffff", -- cmpi r0 -1
X"1b000003", -- breq L274
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L275
X"8b0e0001", -- addi r0 r14 1 [L274]
X"e3000000", -- cmpi r0 0 [L275]
X"1b00002a", -- breq L276
X"820dffe2", -- load r0 r13 -30 [2]
X"821e0452", -- load r1 r14 1106 [2]
X"822e0454", -- load r2 r14 1108 [2]
X"97112000", -- sub r1 r1 r2
X"823e045e", -- load r3 r14 1118 [2]
X"97113000", -- sub r1 r1 r3
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L278
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L279
X"8b0e0001", -- addi r0 r14 1 [L278]
X"e3000000", -- cmpi r0 0 [L279]
X"1b00001c", -- breq L280
X"820dffe2", -- load r0 r13 -30 [2]
X"8b000001", -- addi r0 r0 1
X"8b1dfb2e", -- addi r1 r13 -1234
X"d2d0ffe2", -- store r13 r0 -30 [2]
X"8f000001", -- subi r0 r0 1
X"822e0450", -- load r2 r14 1104 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe4", -- load r3 r13 -28 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0462", -- load r4 r14 1122 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1dfb2e", -- addi r1 r13 -1234
X"825dffe2", -- load r5 r13 -30 [2]
X"826e0454", -- load r6 r14 1108 [2]
X"8f660001", -- subi r6 r6 1
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0464", -- load r7 r14 1124 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L281
X"3300002c", -- rjmp L277 [L280] [L281]
X"820dfb2a", -- load r0 r13 -1238 [2] [L276]
X"e3000001", -- cmpi r0 1
X"1b000003", -- breq L282
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L283
X"8b0e0001", -- addi r0 r14 1 [L282]
X"e3000000", -- cmpi r0 0 [L283]
X"1b000024", -- breq L284
X"820dffe2", -- load r0 r13 -30 [2]
X"821e045e", -- load r1 r14 1118 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L286
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L287
X"8b0e0001", -- addi r0 r14 1 [L286]
X"e3000000", -- cmpi r0 0 [L287]
X"1b00001a", -- breq L288
X"820dffe2", -- load r0 r13 -30 [2]
X"8f000001", -- subi r0 r0 1
X"8b1dfb2e", -- addi r1 r13 -1234
X"d2d0ffe2", -- store r13 r0 -30 [2]
X"822e0450", -- load r2 r14 1104 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe4", -- load r3 r13 -28 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0464", -- load r4 r14 1124 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1dfb2e", -- addi r1 r13 -1234
X"825dffe2", -- load r5 r13 -30 [2]
X"826e0454", -- load r6 r14 1108 [2]
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0462", -- load r7 r14 1122 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L289
X"33000001", -- rjmp L285 [L288] [L289]
X"820dfb28", -- load r0 r13 -1240 [2] [L284] [L285] [L277]
X"e300ffff", -- cmpi r0 -1
X"1b000003", -- breq L290
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L291
X"8b0e0001", -- addi r0 r14 1 [L290]
X"e3000000", -- cmpi r0 0 [L291]
X"1b00002a", -- breq L292
X"820dffde", -- load r0 r13 -34 [2]
X"821e0452", -- load r1 r14 1106 [2]
X"822e0454", -- load r2 r14 1108 [2]
X"97112000", -- sub r1 r1 r2
X"823e045e", -- load r3 r14 1118 [2]
X"97113000", -- sub r1 r1 r3
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L294
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L295
X"8b0e0001", -- addi r0 r14 1 [L294]
X"e3000000", -- cmpi r0 0 [L295]
X"1b00001c", -- breq L296
X"820dffde", -- load r0 r13 -34 [2]
X"8b000001", -- addi r0 r0 1
X"8b1dfb2e", -- addi r1 r13 -1234
X"d2d0ffde", -- store r13 r0 -34 [2]
X"8f000001", -- subi r0 r0 1
X"822e0450", -- load r2 r14 1104 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe0", -- load r3 r13 -32 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0462", -- load r4 r14 1122 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1dfb2e", -- addi r1 r13 -1234
X"825dffde", -- load r5 r13 -34 [2]
X"826e0454", -- load r6 r14 1108 [2]
X"8f660001", -- subi r6 r6 1
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0465", -- load r7 r14 1125 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L297
X"3300002c", -- rjmp L293 [L296] [L297]
X"820dfb28", -- load r0 r13 -1240 [2] [L292]
X"e3000001", -- cmpi r0 1
X"1b000003", -- breq L298
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L299
X"8b0e0001", -- addi r0 r14 1 [L298]
X"e3000000", -- cmpi r0 0 [L299]
X"1b000024", -- breq L300
X"820dffde", -- load r0 r13 -34 [2]
X"821e045e", -- load r1 r14 1118 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L302
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L303
X"8b0e0001", -- addi r0 r14 1 [L302]
X"e3000000", -- cmpi r0 0 [L303]
X"1b00001a", -- breq L304
X"820dffde", -- load r0 r13 -34 [2]
X"8f000001", -- subi r0 r0 1
X"8b1dfb2e", -- addi r1 r13 -1234
X"d2d0ffde", -- store r13 r0 -34 [2]
X"822e0450", -- load r2 r14 1104 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe0", -- load r3 r13 -32 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0465", -- load r4 r14 1125 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1dfb2e", -- addi r1 r13 -1234
X"825dffde", -- load r5 r13 -34 [2]
X"826e0454", -- load r6 r14 1108 [2]
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0462", -- load r7 r14 1122 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L305
X"33000001", -- rjmp L301 [L304] [L305]
X"820dfff0", -- load r0 r13 -16 [2] [L300] [L301] [L293]
X"821dffe8", -- load r1 r13 -24 [2]
X"93001000", -- add r0 r0 r1
X"822dffee", -- load r2 r13 -18 [2]
X"823dffe6", -- load r3 r13 -26 [2]
X"93223000", -- add r2 r2 r3
X"8fff0002", -- subi r15 r15 2
X"8b4dfb2e", -- addi r4 r13 -1234
X"d2d2ffea", -- store r13 r2 -22 [2]
X"825e0450", -- load r5 r14 1104 [2]
X"a7225000", -- mul r2 r2 r5
X"93220000", -- add r2 r2 r0
X"93242000", -- add r2 r4 r2
X"81220000", -- load r2 r2 0 [1]
X"d1d2fb1e", -- store r13 r2 -1250 [1]
X"816e0463", -- load r6 r14 1123 [1]
X"df026000", -- cmp r2 r6
X"1b000003", -- breq L306
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L307
X"8b2e0001", -- addi r2 r14 1 [L306]
X"d2d0ffec", -- store r13 r0 -20 [2] [L307]
X"e3020000", -- cmpi r2 0
X"1b00000c", -- breq L308
X"820dffe6", -- load r0 r13 -26 [2]
X"9b000000", -- neg r0 r0
X"821dfff0", -- load r1 r13 -16 [2]
X"822dffe8", -- load r2 r13 -24 [2]
X"93112000", -- add r1 r1 r2
X"823dffee", -- load r3 r13 -18 [2]
X"93330000", -- add r3 r3 r0
X"d2d0ffe6", -- store r13 r0 -26 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d3ffea", -- store r13 r3 -22 [2]
X"330000a3", -- rjmp L309
X"810dfb1e", -- load r0 r13 -1250 [1] [L308]
X"811e0464", -- load r1 r14 1124 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L310
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L311
X"8b0e0001", -- addi r0 r14 1 [L310]
X"812dfb1e", -- load r2 r13 -1250 [1] [L311]
X"813e0465", -- load r3 r14 1125 [1]
X"df023000", -- cmp r2 r3
X"1b000003", -- breq L312
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L313
X"8b2e0001", -- addi r2 r14 1 [L312]
X"c3002000", -- or r0 r0 r2 [L313]
X"e3000000", -- cmpi r0 0
X"1b00000c", -- breq L314
X"820dffe8", -- load r0 r13 -24 [2]
X"9b000000", -- neg r0 r0
X"821dfff0", -- load r1 r13 -16 [2]
X"93110000", -- add r1 r1 r0
X"822dffee", -- load r2 r13 -18 [2]
X"823dffe6", -- load r3 r13 -26 [2]
X"93223000", -- add r2 r2 r3
X"d2d0ffe8", -- store r13 r0 -24 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d2ffea", -- store r13 r2 -22 [2]
X"33000087", -- rjmp L315
X"810dfb1e", -- load r0 r13 -1250 [1] [L314]
X"811e0469", -- load r1 r14 1129 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L316
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L317
X"8b0e0001", -- addi r0 r14 1 [L316]
X"e3000000", -- cmpi r0 0 [L317]
X"1b00003b", -- breq L318
X"820dfff4", -- load r0 r13 -12 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e0013", -- addi r1 r14 19
X"8b2e000e", -- addi r2 r14 14
X"8b3e0001", -- addi r3 r14 1
X"8b4e0001", -- addi r4 r14 1
X"8b5e0006", -- addi r5 r14 6
X"8b6e0006", -- addi r6 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"817dfffc", -- load r7 r13 -4 [1]
X"8f770003", -- subi r7 r7 3
X"8bffffff", -- addi r15 r15 -1
X"d1f70000", -- store r15 r7 0 [1]
X"818dfffa", -- load r8 r13 -6 [1]
X"8b880002", -- addi r8 r8 2
X"8bffffff", -- addi r15 r15 -1
X"d1f80000", -- store r15 r8 0 [1]
X"d2d0fff4", -- store r13 r0 -12 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d2ffea", -- store r13 r2 -22 [2]
X"d2d3ffe8", -- store r13 r3 -24 [2]
X"d2d4ffe6", -- store r13 r4 -26 [2]
X"d2e5040e", -- store r14 r5 1038 [2]
X"d2e6040c", -- store r14 r6 1036 [2]
X"8bde0e37", -- addi r13 r14 3639
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f41b", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e04a2", -- addi r0 r14 1186
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0e43", -- addi r13 r14 3651
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f601", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0e50", -- addi r13 r14 3664
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f286", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000044", -- rjmp L319
X"810dfb1e", -- load r0 r13 -1250 [1] [L318]
X"811e046a", -- load r1 r14 1130 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L320
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L321
X"8b0e0001", -- addi r0 r14 1 [L320]
X"e3000000", -- cmpi r0 0 [L321]
X"1b00003b", -- breq L322
X"820dfff6", -- load r0 r13 -10 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e0013", -- addi r1 r14 19
X"8b2e000e", -- addi r2 r14 14
X"8b3effff", -- addi r3 r14 -1
X"8b4effff", -- addi r4 r14 -1
X"8b5e0006", -- addi r5 r14 6
X"8b6e0006", -- addi r6 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"817dfffc", -- load r7 r13 -4 [1]
X"8f770003", -- subi r7 r7 3
X"8bffffff", -- addi r15 r15 -1
X"d1f70000", -- store r15 r7 0 [1]
X"818dfffa", -- load r8 r13 -6 [1]
X"8f88000a", -- subi r8 r8 10
X"8bffffff", -- addi r15 r15 -1
X"d1f80000", -- store r15 r8 0 [1]
X"d2d0fff6", -- store r13 r0 -10 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d2ffea", -- store r13 r2 -22 [2]
X"d2d3ffe8", -- store r13 r3 -24 [2]
X"d2d4ffe6", -- store r13 r4 -26 [2]
X"d2e5040e", -- store r14 r5 1038 [2]
X"d2e6040c", -- store r14 r6 1036 [2]
X"8bde0e7a", -- addi r13 r14 3706
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f3d8", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e04a2", -- addi r0 r14 1186
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde0e86", -- addi r13 r14 3718
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f5be", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0e93", -- addi r13 r14 3731
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f243", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L323
X"8b0dfb2e", -- addi r0 r13 -1234 [L322] [L323] [L319] [L315] [L309]
X"821dffee", -- load r1 r13 -18 [2]
X"822e0450", -- load r2 r14 1104 [2]
X"a7112000", -- mul r1 r1 r2
X"823dfff0", -- load r3 r13 -16 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e0462", -- load r4 r14 1122 [1]
X"d1040000", -- store r0 r4 0 [1]
X"8b0dfb2e", -- addi r0 r13 -1234
X"825dffea", -- load r5 r13 -22 [2]
X"a7552000", -- mul r5 r5 r2
X"826dffec", -- load r6 r13 -20 [2]
X"93556000", -- add r5 r5 r6
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93007000", -- add r0 r0 r7
X"817e0466", -- load r7 r14 1126 [1]
X"d1070000", -- store r0 r7 0 [1]
X"cf360000", -- move r3 r6
X"820dffea", -- load r0 r13 -22 [2]
X"cf800000", -- move r8 r0
X"8b9e0000", -- addi r9 r14 0
X"8fff0002", -- subi r15 r15 2
X"8bae0000", -- addi r10 r14 0
X"d2d3fff0", -- store r13 r3 -16 [2]
X"d2d8ffee", -- store r13 r8 -18 [2]
X"d2d9fb2c", -- store r13 r9 -1236 [2]
X"d1dafb1c", -- store r13 r10 -1252 [1]
X"820dfb2c", -- load r0 r13 -1236 [2] [L324]
X"821e0450", -- load r1 r14 1104 [2]
X"822e0452", -- load r2 r14 1106 [2]
X"a7112000", -- mul r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L326
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L327
X"8b0e0001", -- addi r0 r14 1 [L326]
X"e3000000", -- cmpi r0 0 [L327]
X"1b000101", -- breq L325
X"8b3dfb2e", -- addi r3 r13 -1234
X"824dfb2c", -- load r4 r13 -1236 [2]
X"93434000", -- add r4 r3 r4
X"81440000", -- load r4 r4 0 [1]
X"d1d4fb1c", -- store r13 r4 -1252 [1]
X"815e0462", -- load r5 r14 1122 [1]
X"df045000", -- cmp r4 r5
X"1b000003", -- breq L328
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L329
X"8b4e0001", -- addi r4 r14 1 [L328]
X"e3040000", -- cmpi r4 0 [L329]
X"1b000015", -- breq L330
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dfb2c", -- load r1 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0ede", -- addi r13 r14 3806
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4ca", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000dc", -- rjmp L331
X"810dfb1c", -- load r0 r13 -1252 [1] [L330]
X"811e0469", -- load r1 r14 1129 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L332
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L333
X"8b0e0001", -- addi r0 r14 1 [L332]
X"e3000000", -- cmpi r0 0 [L333]
X"1b000015", -- breq L334
X"8b0e0004", -- addi r0 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dfb2c", -- load r1 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0efb", -- addi r13 r14 3835
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4ad", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000bf", -- rjmp L335
X"810dfb1c", -- load r0 r13 -1252 [1] [L334]
X"811e046a", -- load r1 r14 1130 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L336
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L337
X"8b0e0001", -- addi r0 r14 1 [L336]
X"e3000000", -- cmpi r0 0 [L337]
X"1b000015", -- breq L338
X"8b0e0004", -- addi r0 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dfb2c", -- load r1 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0f18", -- addi r13 r14 3864
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f490", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000a2", -- rjmp L339
X"810dfb1c", -- load r0 r13 -1252 [1] [L338]
X"811e0463", -- load r1 r14 1123 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L340
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L341
X"8b0e0001", -- addi r0 r14 1 [L340]
X"e3000000", -- cmpi r0 0 [L341]
X"1b000015", -- breq L342
X"8b0e0001", -- addi r0 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dfb2c", -- load r1 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0f35", -- addi r13 r14 3893
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f473", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000085", -- rjmp L343
X"810dfb1c", -- load r0 r13 -1252 [1] [L342]
X"811e0464", -- load r1 r14 1124 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L344
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L345
X"8b0e0001", -- addi r0 r14 1 [L344]
X"812dfb1c", -- load r2 r13 -1252 [1] [L345]
X"813e0465", -- load r3 r14 1125 [1]
X"df023000", -- cmp r2 r3
X"1b000003", -- breq L346
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L347
X"8b2e0001", -- addi r2 r14 1 [L346]
X"c3002000", -- or r0 r0 r2 [L347]
X"e3000000", -- cmpi r0 0
X"1b000015", -- breq L348
X"8b0e0005", -- addi r0 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dfb2c", -- load r1 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0f5a", -- addi r13 r14 3930
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f44e", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000060", -- rjmp L349
X"810dfb1c", -- load r0 r13 -1252 [1] [L348]
X"811e0466", -- load r1 r14 1126 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L350
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L351
X"8b0e0001", -- addi r0 r14 1 [L350]
X"e3000000", -- cmpi r0 0 [L351]
X"1b000017", -- breq L352
X"8b0e0002", -- addi r0 r14 2
X"8b1e0002", -- addi r1 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dfb2c", -- load r2 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b3e006f", -- addi r3 r14 111
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0f79", -- addi r13 r14 3961
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f42f", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000041", -- rjmp L353
X"810dfb1c", -- load r0 r13 -1252 [1] [L352]
X"811e0467", -- load r1 r14 1127 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L354
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L355
X"8b0e0001", -- addi r0 r14 1 [L354]
X"e3000000", -- cmpi r0 0 [L355]
X"1b000018", -- breq L356
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dfb2c", -- load r2 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"823dfff6", -- load r3 r13 -10 [2]
X"8b330030", -- addi r3 r3 48
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0f99", -- addi r13 r14 3993
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f40f", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000021", -- rjmp L357
X"810dfb1c", -- load r0 r13 -1252 [1] [L356]
X"811e0468", -- load r1 r14 1128 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L358
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L359
X"8b0e0001", -- addi r0 r14 1 [L358]
X"e3000000", -- cmpi r0 0 [L359]
X"1b000018", -- breq L360
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dfb2c", -- load r2 r13 -1236 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"823dfff4", -- load r3 r13 -12 [2]
X"8b330030", -- addi r3 r3 48
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde0fb9", -- addi r13 r14 4025
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f3ef", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L361
X"820dfb2c", -- load r0 r13 -1236 [2] [L360] [L361] [L357] [L353] [L349] [L343] [L339] [L335] [L331]
X"8b000001", -- addi r0 r0 1
X"d2d0fb2c", -- store r13 r0 -1236 [2]
X"3300fef6", -- rjmp L324
X"8bfffffe", -- addi r15 r15 -2 [L325]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b0e00ff", -- addi r0 r14 255
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde0fd0", -- addi r13 r14 4048
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f04d", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfff6", -- load r0 r13 -10 [2]
X"821e0460", -- load r1 r14 1120 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L362
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L363
X"8b0e0001", -- addi r0 r14 1 [L362]
X"e3000000", -- cmpi r0 0 [L363]
X"1b000006", -- breq L364
X"8b0e0001", -- addi r0 r14 1
X"8b1e0000", -- addi r1 r14 0
X"d1d0fff2", -- store r13 r0 -14 [1]
X"d2d1fff8", -- store r13 r1 -8 [2]
X"3300000f", -- rjmp L365
X"820dfff4", -- load r0 r13 -12 [2] [L364]
X"821e0460", -- load r1 r14 1120 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L366
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L367
X"8b0e0001", -- addi r0 r14 1 [L366]
X"e3000000", -- cmpi r0 0 [L367]
X"1b000006", -- breq L368
X"8b0e0002", -- addi r0 r14 2
X"8b1e0000", -- addi r1 r14 0
X"d1d0fff2", -- store r13 r0 -14 [1]
X"d2d1fff8", -- store r13 r1 -8 [2]
X"33000001", -- rjmp L369
X"8bff000c", -- addi r15 r15 12 [L368] [L369] [L365]
X"3300fc72", -- rjmp L246
X"8bfffffe", -- addi r15 r15 -2 [L247]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"810dfff2", -- load r0 r13 -14 [1]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde1000", -- addi r13 r14 4096
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f01d", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0479", -- addi r0 r14 1145
X"8b000007", -- addi r0 r0 7
X"811dfff2", -- load r1 r13 -14 [1]
X"8b110030", -- addi r1 r1 48
X"d1010000", -- store r0 r1 0 [1]
X"8b0e0006", -- addi r0 r14 6
X"8b2e0006", -- addi r2 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"813dfffc", -- load r3 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"814dfffa", -- load r4 r13 -6 [1]
X"8f440007", -- subi r4 r4 7
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"d2e2040c", -- store r14 r2 1036 [2]
X"8bde101a", -- addi r13 r14 4122
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f238", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0479", -- addi r0 r14 1145
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde1027", -- addi r13 r14 4135
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f41d", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"810dfffc", -- load r0 r13 -4 [1]
X"8b000003", -- addi r0 r0 3
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"811dfffa", -- load r1 r13 -6 [1]
X"8f11000c", -- subi r1 r1 12
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8bde1039", -- addi r13 r14 4153
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f219", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0487", -- addi r0 r14 1159
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde1046", -- addi r13 r14 4166
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f3fe", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fb26", -- store r13 r0 -1242 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L370
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L371
X"8b0e0001", -- addi r0 r14 1 [L370]
X"e3000000", -- cmpi r0 0 [L371]
X"1b000013", -- breq L372
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dfb26", -- load r0 r13 -1242 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde1061", -- addi r13 r14 4193
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efbc", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L373
X"820dfb26", -- load r0 r13 -1242 [2] [L372] [L373] [L374]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L376
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L377
X"8b0e0001", -- addi r0 r14 1 [L376]
X"e3000000", -- cmpi r0 0 [L377]
X"1b00007a", -- breq L375
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde1074", -- addi r13 r14 4212
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f5f7", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b1dfb2e", -- addi r1 r13 -1234
X"81210000", -- load r2 r1 0 [1]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"d1d0fffe", -- store r13 r0 -2 [1]
X"8fff0002", -- subi r15 r15 2
X"8bde1088", -- addi r13 r14 4232
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef95", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dfffe", -- load r0 r13 -2 [1]
X"e300000a", -- cmpi r0 10
X"1b000003", -- breq L378
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L379
X"8b0e0001", -- addi r0 r14 1 [L378]
X"e3000000", -- cmpi r0 0 [L379]
X"1b000004", -- breq L380
X"8b0e0001", -- addi r0 r14 1
X"d2d0fb26", -- store r13 r0 -1242 [2]
X"33000050", -- rjmp L381
X"810dfffe", -- load r0 r13 -2 [1] [L380]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L382
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L383
X"8b0e0001", -- addi r0 r14 1 [L382]
X"e3000000", -- cmpi r0 0 [L383]
X"1b000048", -- breq L384
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"812dfffc", -- load r2 r13 -4 [1]
X"8f220002", -- subi r2 r2 2
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"813dfffa", -- load r3 r13 -6 [1]
X"8f330003", -- subi r3 r3 3
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"d2e1040c", -- store r14 r1 1036 [2]
X"8bde10b0", -- addi r13 r14 4272
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f1a2", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e04bd", -- addi r0 r14 1213
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde10bc", -- addi r13 r14 4284
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f388", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde10c9", -- addi r13 r14 4297
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f00d", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f3000000", -- movhi r0 r0 0
X"f700eeee", -- movlo r0 r0 61166
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde10db", -- addi r13 r14 4315
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef42", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff04da", -- addi r15 r15 1242
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd10e3", -- subi r13 r13 4323
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L385
X"3300ff80", -- rjmp L374 [L384] [L385] [L381]
X"8bfffffe", -- addi r15 r15 -2 [L375]
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f3000000", -- movhi r0 r0 0
X"f700ffff", -- movlo r0 r0 65535
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde10f5", -- addi r13 r14 4341
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef28", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0006", -- addi r0 r14 6
X"8b1e0006", -- addi r1 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"812dfffc", -- load r2 r13 -4 [1]
X"8f220002", -- subi r2 r2 2
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"813dfffa", -- load r3 r13 -6 [1]
X"8f330004", -- subi r3 r3 4
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"d2e1040c", -- store r14 r1 1036 [2]
X"8bde110a", -- addi r13 r14 4362
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f148", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e04b0", -- addi r0 r14 1200
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde1116", -- addi r13 r14 4374
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f32e", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde1123", -- addi r13 r14 4387
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efb3", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff04d4", -- addi r15 r15 1236
X"3300f998", -- rjmp L220
X"8bce0000", -- addi r12 r14 0 [L221]
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd112d", -- subi r13 r13 4397
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [rainbow]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8b3e0000", -- addi r3 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0045", -- addi r3 r14 69
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0059", -- addi r3 r14 89
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0042", -- addi r3 r14 66
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0044", -- addi r3 r14 68
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e004f", -- addi r3 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e004f", -- addi r3 r14 79
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0047", -- addi r3 r14 71
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"d1d2fffa", -- store r13 r2 -6 [1]
X"8b0e0000", -- addi r0 r14 0 [L386]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde115f", -- addi r13 r14 4447
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eebe", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2] [L388]
X"821e0400", -- load r1 r14 1024 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L390
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L391
X"8b0e0001", -- addi r0 r14 1 [L390]
X"e3000000", -- cmpi r0 0 [L391]
X"1b000057", -- breq L389
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde1172", -- addi r13 r14 4466
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4f9", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d1d0fffa", -- store r13 r0 -6 [1]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L392
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L393
X"8b0e0001", -- addi r0 r14 1 [L392]
X"e3000000", -- cmpi r0 0 [L393]
X"1b000021", -- breq L394
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0dfff2", -- addi r0 r13 -14
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde1187", -- addi r13 r14 4487
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f2bd", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde1194", -- addi r13 r14 4500
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef42", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff000e", -- addi r15 r15 14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd119c", -- subi r13 r13 4508
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L395
X"820dfffc", -- load r0 r13 -4 [2] [L394] [L395]
X"e300000b", -- cmpi r0 11
X"2f000003", -- brge L396
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L397
X"8b0e0001", -- addi r0 r14 1 [L396]
X"e3000000", -- cmpi r0 0 [L397]
X"1b000004", -- breq L398
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffc", -- store r13 r0 -4 [2]
X"33000001", -- rjmp L399
X"8b0e0004", -- addi r0 r14 4 [L398] [L399]
X"821dfffc", -- load r1 r13 -4 [2]
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b2e0000", -- addi r2 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde11b7", -- addi r13 r14 4535
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f266", -- rjmp print_c
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8b000001", -- addi r0 r0 1
X"821dfffc", -- load r1 r13 -4 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"3300ffa2", -- rjmp L388
X"3300ff8f", -- rjmp L386 [L389]
X"8bce0000", -- addi r12 r14 0 [L387]
X"8bff000e", -- addi r15 r15 14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd11c7", -- subi r13 r13 4551
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [screensaver]
X"8fff0002", -- subi r15 r15 2
X"8b0e0001", -- addi r0 r14 1
X"8fff0002", -- subi r15 r15 2
X"8b1e0001", -- addi r1 r14 1
X"8fff0002", -- subi r15 r15 2
X"8b2e000e", -- addi r2 r14 14
X"8fff0002", -- subi r15 r15 2
X"8b3e0013", -- addi r3 r14 19
X"8fff0002", -- subi r15 r15 2
X"8b4e0004", -- addi r4 r14 4
X"8fff0002", -- subi r15 r15 2
X"8b5e0000", -- addi r5 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"d2d2fffa", -- store r13 r2 -6 [2]
X"d2d3fff8", -- store r13 r3 -8 [2]
X"d2d4fff6", -- store r13 r4 -10 [2]
X"d1d5fff4", -- store r13 r5 -12 [1]
X"810dfff4", -- load r0 r13 -12 [1] [L400]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L402
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L403
X"8b0e0001", -- addi r0 r14 1 [L402]
X"e3000000", -- cmpi r0 0 [L403]
X"1b000083", -- breq L401
X"821dfffa", -- load r1 r13 -6 [2]
X"e301001d", -- cmpi r1 29
X"2f000003", -- brge L404
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L405
X"8b1e0001", -- addi r1 r14 1 [L404]
X"e3010000", -- cmpi r1 0 [L405]
X"1b000007", -- breq L406
X"8b0effff", -- addi r0 r14 -1
X"821dfff6", -- load r1 r13 -10 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fff6", -- store r13 r1 -10 [2]
X"33000001", -- rjmp L407
X"820dfffa", -- load r0 r13 -6 [2] [L406] [L407]
X"e3000000", -- cmpi r0 0
X"2b000003", -- brle L408
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L409
X"8b0e0001", -- addi r0 r14 1 [L408]
X"e3000000", -- cmpi r0 0 [L409]
X"1b000007", -- breq L410
X"8b0e0001", -- addi r0 r14 1
X"821dfff6", -- load r1 r13 -10 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fff6", -- store r13 r1 -10 [2]
X"33000001", -- rjmp L411
X"820dfff8", -- load r0 r13 -8 [2] [L410] [L411]
X"e3000000", -- cmpi r0 0
X"2b000003", -- brle L412
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L413
X"8b0e0001", -- addi r0 r14 1 [L412]
X"e3000000", -- cmpi r0 0 [L413]
X"1b000007", -- breq L414
X"8b0e0001", -- addi r0 r14 1
X"821dfff6", -- load r1 r13 -10 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffc", -- store r13 r0 -4 [2]
X"d2d1fff6", -- store r13 r1 -10 [2]
X"33000001", -- rjmp L415
X"820dfff8", -- load r0 r13 -8 [2] [L414] [L415]
X"e3000018", -- cmpi r0 24
X"2f000003", -- brge L416
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L417
X"8b0e0001", -- addi r0 r14 1 [L416]
X"e3000000", -- cmpi r0 0 [L417]
X"1b000007", -- breq L418
X"8b0effff", -- addi r0 r14 -1
X"821dfff6", -- load r1 r13 -10 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffc", -- store r13 r0 -4 [2]
X"d2d1fff6", -- store r13 r1 -10 [2]
X"33000001", -- rjmp L419
X"8b0e0004", -- addi r0 r14 4 [L418] [L419]
X"821dfff6", -- load r1 r13 -10 [2]
X"93001000", -- add r0 r0 r1
X"e301000b", -- cmpi r1 11
X"2f000003", -- brge L420
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L421
X"8b1e0001", -- addi r1 r14 1 [L420]
X"d2e0040c", -- store r14 r0 1036 [2] [L421]
X"e3010000", -- cmpi r1 0
X"1b000004", -- breq L422
X"8b0e0000", -- addi r0 r14 0
X"d2d0fff6", -- store r13 r0 -10 [2]
X"33000001", -- rjmp L423
X"820dfffa", -- load r0 r13 -6 [2] [L422] [L423]
X"821dfffe", -- load r1 r13 -2 [2]
X"93001000", -- add r0 r0 r1
X"822dfff8", -- load r2 r13 -8 [2]
X"823dfffc", -- load r3 r13 -4 [2]
X"93223000", -- add r2 r2 r3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"d2d0fffa", -- store r13 r0 -6 [2]
X"d2d2fff8", -- store r13 r2 -8 [2]
X"8bde1237", -- addi r13 r14 4663
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f28f", -- rjmp clear
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820dfff8", -- load r0 r13 -8 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821dfffa", -- load r1 r13 -6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde1249", -- addi r13 r14 4681
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f241", -- rjmp print_sprite
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e00fa", -- addi r0 r14 250
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"8bde1257", -- addi r13 r14 4695
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ee7f", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde1260", -- addi r13 r14 4704
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f40b", -- rjmp read_char
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d1d0fff4", -- store r13 r0 -12 [1]
X"3300ff77", -- rjmp L400
X"8bff000c", -- addi r15 r15 12 [L401]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd126a", -- subi r13 r13 4714
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [snake_paint]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c0", -- load r0 r14 960 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0001", -- addi r1 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde127b", -- addi r13 r14 4731
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef91", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c2", -- load r0 r14 962 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0002", -- addi r1 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde128d", -- addi r13 r14 4749
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef7f", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c4", -- load r0 r14 964 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde129f", -- addi r13 r14 4767
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef6d", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c6", -- load r0 r14 966 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde12b1", -- addi r13 r14 4785
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef5b", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03c8", -- load r0 r14 968 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0005", -- addi r1 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde12c3", -- addi r13 r14 4803
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef49", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03cc", -- load r0 r14 972 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0006", -- addi r1 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde12d5", -- addi r13 r14 4821
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef37", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03ce", -- load r0 r14 974 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0007", -- addi r1 r14 7
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde12e7", -- addi r13 r14 4839
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef25", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d0", -- load r0 r14 976 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0008", -- addi r1 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde12f9", -- addi r13 r14 4857
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef13", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d2", -- load r0 r14 978 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0009", -- addi r1 r14 9
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde130b", -- addi r13 r14 4875
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef01", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03d4", -- load r0 r14 980 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000a", -- addi r1 r14 10
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde131d", -- addi r13 r14 4893
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eeef", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03be", -- load r0 r14 958 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde132f", -- addi r13 r14 4911
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eedd", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e03b8", -- load r0 r14 952 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e000b", -- addi r1 r14 11
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bde1341", -- addi r13 r14 4929
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eecb", -- rjmp palette_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e000b", -- addi r0 r14 11
X"8fff0004", -- subi r15 r15 4
X"8b1e0000", -- addi r1 r14 0
X"d2e0040c", -- store r14 r0 1036 [2]
X"d3d1fffc", -- store r13 r1 -4 [4]
X"8bfffffe", -- addi r15 r15 -2 [L424]
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde134f", -- addi r13 r14 4943
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f31c", -- rjmp read_char
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d3d0fffc", -- store r13 r0 -4 [4]
X"e3000000", -- cmpi r0 0
X"1b00011d", -- breq L426
X"830dfffc", -- load r0 r13 -4 [4]
X"e3000077", -- cmpi r0 119
X"1b000003", -- breq L428
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L429
X"8b0e0001", -- addi r0 r14 1 [L428]
X"e3000000", -- cmpi r0 0 [L429]
X"1b00002c", -- breq L430
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0020", -- addi r1 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde136b", -- addi r13 r14 4971
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f03d", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde1374", -- addi r13 r14 4980
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300effb", -- rjmp back_line
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e002b", -- addi r1 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde1384", -- addi r13 r14 4996
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f024", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000e9", -- rjmp L431
X"830dfffc", -- load r0 r13 -4 [4] [L430]
X"e3000061", -- cmpi r0 97
X"1b000003", -- breq L432
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L433
X"8b0e0001", -- addi r0 r14 1 [L432]
X"e3000000", -- cmpi r0 0 [L433]
X"1b00002c", -- breq L434
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0020", -- addi r1 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde139e", -- addi r13 r14 5022
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f00a", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde13a7", -- addi r13 r14 5031
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eefb", -- rjmp back_cursor
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e002b", -- addi r1 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde13b7", -- addi r13 r14 5047
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eff1", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000b6", -- rjmp L435
X"830dfffc", -- load r0 r13 -4 [4] [L434]
X"e3000073", -- cmpi r0 115
X"1b000003", -- breq L436
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L437
X"8b0e0001", -- addi r0 r14 1 [L436]
X"e3000000", -- cmpi r0 0 [L437]
X"1b00002c", -- breq L438
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0020", -- addi r1 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde13d1", -- addi r13 r14 5073
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efd7", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde13da", -- addi r13 r14 5082
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef78", -- rjmp advance_line
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e002b", -- addi r1 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde13ea", -- addi r13 r14 5098
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efbe", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000083", -- rjmp L439
X"830dfffc", -- load r0 r13 -4 [4] [L438]
X"e3000064", -- cmpi r0 100
X"1b000003", -- breq L440
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L441
X"8b0e0001", -- addi r0 r14 1 [L440]
X"e3000000", -- cmpi r0 0 [L441]
X"1b00002c", -- breq L442
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0020", -- addi r1 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde1404", -- addi r13 r14 5124
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efa4", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bde140d", -- addi r13 r14 5133
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ee6c", -- rjmp advance_cursor
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e002b", -- addi r1 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde141d", -- addi r13 r14 5149
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef8b", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000050", -- rjmp L443
X"830dfffc", -- load r0 r13 -4 [4] [L442]
X"e3000030", -- cmpi r0 48
X"2f000003", -- brge L444
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L445
X"8b0e0001", -- addi r0 r14 1 [L444]
X"831dfffc", -- load r1 r13 -4 [4] [L445]
X"e3010039", -- cmpi r1 57
X"2b000003", -- brle L446
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L447
X"8b1e0001", -- addi r1 r14 1 [L446]
X"bf001000", -- and r0 r0 r1 [L447]
X"e3000000", -- cmpi r0 0
X"1b000016", -- breq L448
X"830dfffc", -- load r0 r13 -4 [4]
X"8f00002f", -- subi r0 r0 47
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0410", -- load r1 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e002b", -- addi r2 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde1441", -- addi r13 r14 5185
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef67", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300002c", -- rjmp L449
X"830dfffc", -- load r0 r13 -4 [4] [L448]
X"e300000a", -- cmpi r0 10
X"1b000003", -- breq L450
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L451
X"8b0e0001", -- addi r0 r14 1 [L450]
X"e3000000", -- cmpi r0 0 [L451]
X"1b000015", -- breq L452
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0410", -- load r1 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e002b", -- addi r2 r14 43
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0003", -- subi r15 r15 3
X"8bde145d", -- addi r13 r14 5213
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef4b", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000010", -- rjmp L453
X"830dfffc", -- load r0 r13 -4 [4] [L452]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L454
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L455
X"8b0e0001", -- addi r0 r14 1 [L454]
X"e3000000", -- cmpi r0 0 [L455]
X"1b000008", -- breq L456
X"8bce0000", -- addi r12 r14 0
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd146e", -- subi r13 r13 5230
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L457
X"33000001", -- rjmp L427 [L456] [L457] [L453] [L449] [L443] [L439] [L435] [L431]
X"3300fed8", -- rjmp L424 [L426] [L427]
X"8bff0004", -- addi r15 r15 4 [L425]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd1477", -- subi r13 r13 5239
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [main]
X"8fff0028", -- subi r15 r15 40
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0 [L458]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0001", -- addi r2 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b3e0000", -- addi r3 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"8b3e0028", -- addi r3 r14 40
X"8fff0001", -- subi r15 r15 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8b3dffd8", -- addi r3 r13 -40
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0ffd6", -- store r13 r0 -42 [2]
X"d2d1ffd4", -- store r13 r1 -44 [2]
X"d2d2ffd2", -- store r13 r2 -46 [2]
X"8bde1497", -- addi r13 r14 5271
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ecf9", -- rjmp memset
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e03ee", -- load r0 r14 1006 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e03c2", -- load r1 r14 962 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0003", -- addi r2 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bde14a9", -- addi r13 r14 5289
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ed63", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e000a", -- addi r0 r14 10
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b2e0001", -- addi r2 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b2e0001", -- addi r2 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b2e0033", -- addi r2 r14 51
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8bde14bf", -- addi r13 r14 5311
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efcb", -- rjmp print_sprite
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e0019", -- addi r0 r14 25
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8b0e0000", -- addi r0 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8bde14ce", -- addi r13 r14 5326
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ed84", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e003e", -- addi r1 r14 62
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"d2e0040e", -- store r14 r0 1038 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde14dd", -- addi r13 r14 5341
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef40", -- rjmp print_c
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2e0040c", -- store r14 r0 1036 [2]
X"820dffd2", -- load r0 r13 -46 [2] [L460]
X"e3000000", -- cmpi r0 0
X"1b00006d", -- breq L461
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde14ec", -- addi r13 r14 5356
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f17f", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0ffd4", -- store r13 r0 -44 [2]
X"e3000000", -- cmpi r0 0
X"1b00005e", -- breq L462
X"820dffd4", -- load r0 r13 -44 [2]
X"e300000a", -- cmpi r0 10
X"1b000003", -- breq L464
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L465
X"8b0e0001", -- addi r0 r14 1 [L464]
X"e3000000", -- cmpi r0 0 [L465]
X"1b00000b", -- breq L466
X"8b0dffd8", -- addi r0 r13 -40
X"821dffd6", -- load r1 r13 -42 [2]
X"8b2e0001", -- addi r2 r14 1
X"a7212000", -- mul r2 r1 r2
X"93002000", -- add r0 r0 r2
X"8b2e0000", -- addi r2 r14 0
X"d1020000", -- store r0 r2 0 [1]
X"8b0e0000", -- addi r0 r14 0
X"d2d0ffd2", -- store r13 r0 -46 [2]
X"3300004b", -- rjmp L467
X"820dffd4", -- load r0 r13 -44 [2] [L466]
X"e3000008", -- cmpi r0 8
X"1b000003", -- breq L468
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L469
X"8b0e0001", -- addi r0 r14 1 [L468]
X"e3000000", -- cmpi r0 0 [L469]
X"1b00002e", -- breq L470
X"820dffd6", -- load r0 r13 -42 [2]
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L472
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L473
X"8b0e0001", -- addi r0 r14 1 [L472]
X"e3000000", -- cmpi r0 0 [L473]
X"1b000025", -- breq L474
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde151c", -- addi r13 r14 5404
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ed86", -- rjmp back_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0410", -- load r0 r14 1040 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0003", -- subi r15 r15 3
X"8bde152c", -- addi r13 r14 5420
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ee7c", -- rjmp print_c_at
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dffd6", -- load r0 r13 -42 [2]
X"8f000001", -- subi r0 r0 1
X"8b1dffd8", -- addi r1 r13 -40
X"8b2e0001", -- addi r2 r14 1
X"a7202000", -- mul r2 r0 r2
X"93112000", -- add r1 r1 r2
X"8b2e0000", -- addi r2 r14 0
X"d1120000", -- store r1 r2 0 [1]
X"d2d0ffd6", -- store r13 r0 -42 [2]
X"33000001", -- rjmp L475
X"33000016", -- rjmp L471 [L474] [L475]
X"8b0dffd8", -- addi r0 r13 -40 [L470]
X"821dffd6", -- load r1 r13 -42 [2]
X"8b2e0001", -- addi r2 r14 1
X"a7212000", -- mul r2 r1 r2
X"93002000", -- add r0 r0 r2
X"822dffd4", -- load r2 r13 -44 [2]
X"d1020000", -- store r0 r2 0 [1]
X"8b110001", -- addi r1 r1 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2d1ffd6", -- store r13 r1 -42 [2]
X"8fff0001", -- subi r15 r15 1
X"8bde154c", -- addi r13 r14 5452
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eed1", -- rjmp print_c
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L463 [L471] [L467]
X"3300ff92", -- rjmp L460 [L462] [L463]
X"8bfffffe", -- addi r15 r15 -2 [L461]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde1558", -- addi r13 r14 5464
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef6e", -- rjmp clear
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde1562", -- addi r13 r14 5474
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300efa1", -- rjmp load_basic_palette
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0dffd8", -- addi r0 r13 -40
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde156e", -- addi r13 r14 5486
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ebed", -- rjmp string_length
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L476
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L477
X"8b0e0001", -- addi r0 r14 1 [L476]
X"e3000000", -- cmpi r0 0 [L477]
X"1b000073", -- breq L478
X"8b0e0416", -- addi r0 r14 1046
X"cf100000", -- move r1 r0
X"8b2e0000", -- addi r2 r14 0
X"8b3e0001", -- addi r3 r14 1
X"d2d1ffd0", -- store r13 r1 -48 [2]
X"d2d2ffce", -- store r13 r2 -50 [2]
X"d2d3ffcc", -- store r13 r3 -52 [2]
X"820dffce", -- load r0 r13 -50 [2] [L480]
X"821e044e", -- load r1 r14 1102 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L482
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L483
X"8b0e0001", -- addi r0 r14 1 [L482]
X"822dffcc", -- load r2 r13 -52 [2] [L483]
X"bf002000", -- and r0 r0 r2
X"e3000000", -- cmpi r0 0
X"1b000032", -- breq L481
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"823dffd0", -- load r3 r13 -48 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8b4dffd8", -- addi r4 r13 -40
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde1598", -- addi r13 r14 5528
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eb95", -- rjmp string_compare
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L484
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L485
X"8b0e0001", -- addi r0 r14 1 [L484]
X"e3000000", -- cmpi r0 0 [L485]
X"1b000004", -- breq L486
X"8b0e0000", -- addi r0 r14 0
X"d2d0ffcc", -- store r13 r0 -52 [2]
X"33000016", -- rjmp L487
X"8bfffffe", -- addi r15 r15 -2 [L486]
X"d2fd0000", -- store r15 r13 0 [2]
X"820dffd0", -- load r0 r13 -48 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde15af", -- addi r13 r14 5551
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ebac", -- rjmp string_length
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"821dffd0", -- load r1 r13 -48 [2]
X"93110000", -- add r1 r1 r0
X"8b110001", -- addi r1 r1 1
X"822dffce", -- load r2 r13 -50 [2]
X"8b220001", -- addi r2 r2 1
X"d2d0ffca", -- store r13 r0 -54 [2]
X"d2d1ffd0", -- store r13 r1 -48 [2]
X"d2d2ffce", -- store r13 r2 -50 [2]
X"3300ffc5", -- rjmp L480 [L487]
X"820dffce", -- load r0 r13 -50 [2] [L481]
X"821e044e", -- load r1 r14 1102 [2]
X"df001000", -- cmp r0 r1
X"1f000003", -- brne L488
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L489
X"8b0e0001", -- addi r0 r14 1 [L488]
X"e3000000", -- cmpi r0 0 [L489]
X"1b00000e", -- breq L490
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820dffce", -- load r0 r13 -50 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bde15ce", -- addi r13 r14 5582
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f0e4", -- rjmp rjmp_user_program
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L491
X"8bfffffe", -- addi r15 r15 -2 [L490] [L491]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde15d9", -- addi r13 r14 5593
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ef2a", -- rjmp load_basic_palette
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"d2e0040c", -- store r14 r0 1036 [2]
X"d2e1040e", -- store r14 r1 1038 [2]
X"8fff0002", -- subi r15 r15 2
X"8bde15e7", -- addi r13 r14 5607
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300eedf", -- rjmp clear
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L479
X"3300fe96", -- rjmp L458 [L478] [L479]
X"8bff0036", -- addi r15 r15 54 [L459]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd15f1", -- subi r13 r13 5617
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
