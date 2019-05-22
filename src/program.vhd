library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"820e0002", -- load r0 r14 2 [2]
X"821e0004", -- load r1 r14 4 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00006", -- store r14 r0 6 [2]
X"820e0006", -- load r0 r14 6 [2]
X"d2e00008", -- store r14 r0 8 [2]
X"820e0006", -- load r0 r14 6 [2]
X"822e000a", -- load r2 r14 10 [2]
X"93002000", -- add r0 r0 r2
X"d2e0000c", -- store r14 r0 12 [2]
X"8fff0001", -- subi r15 r15 1
X"f7dd000f", -- movlo r13 r13 15
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000501", -- rjmp main
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
X"cfdf0000", -- move r13 r15 [divide]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d2fffc", -- store r13 r2 -4 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L28]
X"821d0006", -- load r1 r13 6 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L30
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L31
X"8b0e0001", -- addi r0 r14 1 [L30]
X"e3000000", -- cmpi r0 0 [L31]
X"1b000008", -- breq L29
X"822dfffe", -- load r2 r13 -2 [2]
X"97221000", -- sub r2 r2 r1
X"823dfffc", -- load r3 r13 -4 [2]
X"8b330001", -- addi r3 r3 1
X"d2d2fffe", -- store r13 r2 -2 [2]
X"d2d3fffc", -- store r13 r3 -4 [2]
X"3300fff1", -- rjmp L28
X"8fff0004", -- subi r15 r15 4 [L29]
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
X"f7dd00fe", -- movlo r13 r13 254
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff48", -- rjmp left_shift_l
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
X"8fdd010a", -- subi r13 r13 266
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_index_write]
X"820d0004", -- load r0 r13 4 [2]
X"823d0006", -- load r3 r13 6 [2]
X"824e0006", -- load r4 r14 6 [2]
X"df034000", -- cmp r3 r4
X"2f000003", -- brge L32
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L33
X"8b3e0001", -- addi r3 r14 1 [L32]
X"e3030000", -- cmpi r3 0 [L33]
X"1b000007", -- breq L34
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd011a", -- subi r13 r13 282
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L35
X"8bfffffe", -- addi r15 r15 -2 [L34] [L35]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820d0006", -- load r0 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821d0004", -- load r1 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd012a", -- movlo r13 r13 298
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fefd", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0131", -- subi r13 r13 305
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_coord_write]
X"830d0004", -- load r0 r13 4 [4]
X"821d0008", -- load r1 r13 8 [2]
X"822d000a", -- load r2 r13 10 [2]
X"823e000e", -- load r3 r14 14 [2]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L36
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L37
X"8b1e0001", -- addi r1 r14 1 [L36]
X"824e0010", -- load r4 r14 16 [2] [L37]
X"df024000", -- cmp r2 r4
X"2f000003", -- brge L38
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L39
X"8b2e0001", -- addi r2 r14 1 [L38]
X"c3112000", -- or r1 r1 r2 [L39]
X"e3010000", -- cmpi r1 0
X"1b000007", -- breq L40
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0149", -- subi r13 r13 329
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L41
X"8fff0002", -- subi r15 r15 2 [L40] [L41]
X"820d0008", -- load r0 r13 8 [2]
X"821e000e", -- load r1 r14 14 [2]
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
X"f7dd015e", -- movlo r13 r13 350
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fec9", -- rjmp vga_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0166", -- subi r13 r13 358
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [palette_index_write]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"823e000a", -- load r3 r14 10 [2]
X"df003000", -- cmp r0 r3
X"2f000003", -- brge L42
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L43
X"8b0e0001", -- addi r0 r14 1 [L42]
X"e3000000", -- cmpi r0 0 [L43]
X"1b000007", -- breq L44
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0177", -- subi r13 r13 375
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L45
X"8fff0002", -- subi r15 r15 2 [L44] [L45]
X"820e0008", -- load r0 r14 8 [2]
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
X"f7dd018f", -- movlo r13 r13 399
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fee7", -- rjmp left_shift_i
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
X"f7dd01a4", -- movlo r13 r13 420
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe83", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01ac", -- subi r13 r13 428
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_compare]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0004", -- load r0 r13 4 [2] [L46]
X"81000000", -- load r0 r0 0 [1]
X"821d0006", -- load r1 r13 6 [2]
X"81110000", -- load r1 r1 0 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L48
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L49
X"8b0e0001", -- addi r0 r14 1 [L48]
X"e3000000", -- cmpi r0 0 [L49]
X"1b000017", -- breq L47
X"822d0004", -- load r2 r13 4 [2]
X"81220000", -- load r2 r2 0 [1]
X"e3020000", -- cmpi r2 0
X"1b000003", -- breq L50
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L51
X"8b2e0001", -- addi r2 r14 1 [L50]
X"e3020000", -- cmpi r2 0 [L51]
X"1b000007", -- breq L52
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01c8", -- subi r13 r13 456
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L53
X"820d0004", -- load r0 r13 4 [2] [L52] [L53]
X"8b000001", -- addi r0 r0 1
X"821d0006", -- load r1 r13 6 [2]
X"8b110001", -- addi r1 r1 1
X"d2d00004", -- store r13 r0 4 [2]
X"d2d10006", -- store r13 r1 6 [2]
X"3300ffe0", -- rjmp L46
X"820d0004", -- load r0 r13 4 [2] [L47]
X"81000000", -- load r0 r0 0 [1]
X"821d0006", -- load r1 r13 6 [2]
X"81110000", -- load r1 r1 0 [1]
X"97001000", -- sub r0 r0 r1
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01da", -- subi r13 r13 474
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_length]
X"820d0002", -- load r0 r13 2 [2]
X"8fff0002", -- subi r15 r15 2
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820d0002", -- load r0 r13 2 [2] [L54]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L56
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L57
X"8b0e0001", -- addi r0 r14 1 [L56]
X"e3000000", -- cmpi r0 0 [L57]
X"1b000005", -- breq L55
X"821d0002", -- load r1 r13 2 [2]
X"8b110001", -- addi r1 r1 1
X"d2d10002", -- store r13 r1 2 [2]
X"3300fff4", -- rjmp L54
X"820d0002", -- load r0 r13 2 [2] [L55]
X"821dfffe", -- load r1 r13 -2 [2]
X"97001000", -- sub r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01f4", -- subi r13 r13 500
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [string_copy]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0004", -- load r0 r13 4 [2] [L58]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1f000003", -- brne L60
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L61
X"8b0e0001", -- addi r0 r14 1 [L60]
X"e3000000", -- cmpi r0 0 [L61]
X"1b00000b", -- breq L59
X"821d0006", -- load r1 r13 6 [2]
X"822d0004", -- load r2 r13 4 [2]
X"81220000", -- load r2 r2 0 [1]
X"d1120000", -- store r1 r2 0 [1]
X"823d0004", -- load r3 r13 4 [2]
X"8b330001", -- addi r3 r3 1
X"8b110001", -- addi r1 r1 1
X"d2d10006", -- store r13 r1 6 [2]
X"d2d30004", -- store r13 r3 4 [2]
X"3300ffee", -- rjmp L58
X"cfce0000", -- move r12 r14 [L59]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd020f", -- subi r13 r13 527
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [memset]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"812d0007", -- load r2 r13 7 [1]
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"d2d3fffe", -- store r13 r3 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L62]
X"821d0004", -- load r1 r13 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L64
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L65
X"8b0e0001", -- addi r0 r14 1 [L64]
X"e3000000", -- cmpi r0 0 [L65]
X"1b00000b", -- breq L63
X"822d0002", -- load r2 r13 2 [2]
X"823dfffe", -- load r3 r13 -2 [2]
X"8b4e0001", -- addi r4 r14 1
X"a7434000", -- mul r4 r3 r4
X"93224000", -- add r2 r2 r4
X"814d0007", -- load r4 r13 7 [1]
X"d1240000", -- store r2 r4 0 [1]
X"8b330001", -- addi r3 r3 1
X"d2d3fffe", -- store r13 r3 -2 [2]
X"3300ffee", -- rjmp L62
X"8bff0002", -- addi r15 r15 2 [L63]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd022f", -- subi r13 r13 559
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [set_cursor]
X"810d0002", -- load r0 r13 2 [1]
X"811d0003", -- load r1 r13 3 [1]
X"822e0002", -- load r2 r14 2 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L66
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L67
X"8b0e0001", -- addi r0 r14 1 [L66]
X"823e0004", -- load r3 r14 4 [2] [L67]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L68
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L69
X"8b1e0001", -- addi r1 r14 1 [L68]
X"c3001000", -- or r0 r0 r1 [L69]
X"e3000000", -- cmpi r0 0
X"1b000007", -- breq L70
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0246", -- subi r13 r13 582
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L71
X"810d0002", -- load r0 r13 2 [1] [L70] [L71]
X"cf100000", -- move r1 r0
X"812d0003", -- load r2 r13 3 [1]
X"cf320000", -- move r3 r2
X"824e0002", -- load r4 r14 2 [2]
X"a7224000", -- mul r2 r2 r4
X"93002000", -- add r0 r0 r2
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e3001a", -- store r14 r3 26 [2]
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0256", -- subi r13 r13 598
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_cursor]
X"820e0016", -- load r0 r14 22 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00016", -- store r14 r0 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L72
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L73
X"8b0e0001", -- addi r0 r14 1 [L72]
X"e3000000", -- cmpi r0 0 [L73]
X"1b000013", -- breq L74
X"820e0018", -- load r0 r14 24 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00018", -- store r14 r0 24 [2]
X"821e0002", -- load r1 r14 2 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L76
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L77
X"8b0e0001", -- addi r0 r14 1 [L76]
X"e3000000", -- cmpi r0 0 [L77]
X"1b000007", -- breq L78
X"8b0e0000", -- addi r0 r14 0
X"821e001a", -- load r1 r14 26 [2]
X"8b110001", -- addi r1 r1 1
X"d2e00018", -- store r14 r0 24 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"33000001", -- rjmp L79
X"33000007", -- rjmp L75 [L78] [L79]
X"8b0e0000", -- addi r0 r14 0 [L74]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L75]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd027f", -- subi r13 r13 639
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_cursor]
X"820e0016", -- load r0 r14 22 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L80
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L81
X"8b0e0001", -- addi r0 r14 1 [L80]
X"e3000000", -- cmpi r0 0 [L81]
X"1b000007", -- breq L82
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd028d", -- subi r13 r13 653
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L83
X"820e0016", -- load r0 r14 22 [2] [L82] [L83]
X"8f000001", -- subi r0 r0 1
X"d2e00016", -- store r14 r0 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L84
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L85
X"8b0e0001", -- addi r0 r14 1 [L84]
X"e3000000", -- cmpi r0 0 [L85]
X"1b000012", -- breq L86
X"820e0018", -- load r0 r14 24 [2]
X"8f000001", -- subi r0 r0 1
X"d2e00018", -- store r14 r0 24 [2]
X"e3000000", -- cmpi r0 0
X"23000003", -- brlt L88
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L89
X"8b0e0001", -- addi r0 r14 1 [L88]
X"e3000000", -- cmpi r0 0 [L89]
X"1b000007", -- breq L90
X"8b0e0000", -- addi r0 r14 0
X"821e001a", -- load r1 r14 26 [2]
X"8f110001", -- subi r1 r1 1
X"d2e00018", -- store r14 r0 24 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"33000001", -- rjmp L91
X"3300000a", -- rjmp L87 [L90] [L91]
X"820e0006", -- load r0 r14 6 [2] [L86]
X"8f000001", -- subi r0 r0 1
X"821e0002", -- load r1 r14 2 [2]
X"cf210000", -- move r2 r1
X"823e0004", -- load r3 r14 4 [2]
X"cf430000", -- move r4 r3
X"d2e00016", -- store r14 r0 22 [2]
X"d2e20018", -- store r14 r2 24 [2]
X"d2e4001a", -- store r14 r4 26 [2]
X"cfce0000", -- move r12 r14 [L87]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02b8", -- subi r13 r13 696
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_steps]
X"820d0002", -- load r0 r13 2 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L92
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L93
X"8b0e0001", -- addi r0 r14 1 [L92]
X"e3000000", -- cmpi r0 0 [L93]
X"1b000007", -- breq L94
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02c7", -- subi r13 r13 711
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L95
X"820e0016", -- load r0 r14 22 [2] [L94] [L95]
X"821d0002", -- load r1 r13 2 [2]
X"93001000", -- add r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"822e0006", -- load r2 r14 6 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L96
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L97
X"8b0e0001", -- addi r0 r14 1 [L96]
X"e3000000", -- cmpi r0 0 [L97]
X"1b000006", -- breq L98
X"820e0016", -- load r0 r14 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"97001000", -- sub r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"33000001", -- rjmp L99
X"8fff0004", -- subi r15 r15 4 [L98] [L99]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0002", -- load r0 r14 2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e0016", -- load r1 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd02e9", -- movlo r13 r13 745
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
X"821e0004", -- load r1 r14 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"822e0016", -- load r2 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d3d0fffc", -- store r13 r0 -4 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd02fd", -- movlo r13 r13 765
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
X"f7dd0311", -- movlo r13 r13 785
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd4d", -- rjmp right_shift_l
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
X"d2e00018", -- store r14 r0 24 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0325", -- movlo r13 r13 805
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd39", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2e0001a", -- store r14 r0 26 [2]
X"8bce0001", -- addi r12 r14 1
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd032f", -- subi r13 r13 815
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_line]
X"820e001a", -- load r0 r14 26 [2]
X"8b000001", -- addi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"821e0004", -- load r1 r14 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L100
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L101
X"8b0e0001", -- addi r0 r14 1 [L100]
X"e3000000", -- cmpi r0 0 [L101]
X"1b000008", -- breq L102
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0018", -- load r2 r14 24 [2]
X"93002000", -- add r0 r0 r2
X"d2e00016", -- store r14 r0 22 [2]
X"33000006", -- rjmp L103
X"820e0018", -- load r0 r14 24 [2] [L102]
X"cf100000", -- move r1 r0
X"8b2e0000", -- addi r2 r14 0
X"d2e10016", -- store r14 r1 22 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L103]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd034c", -- subi r13 r13 844
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_line]
X"820e001a", -- load r0 r14 26 [2]
X"8f000001", -- subi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"e3000000", -- cmpi r0 0
X"2f000003", -- brge L104
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L105
X"8b0e0001", -- addi r0 r14 1 [L104]
X"e3000000", -- cmpi r0 0 [L105]
X"1b000008", -- breq L106
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0018", -- load r2 r14 24 [2]
X"93002000", -- add r0 r0 r2
X"d2e00016", -- store r14 r0 22 [2]
X"33000007", -- rjmp L107
X"820e0018", -- load r0 r14 24 [2] [L106]
X"cf100000", -- move r1 r0
X"822e0004", -- load r2 r14 4 [2]
X"8f220001", -- subi r2 r2 1
X"d2e10016", -- store r14 r1 22 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L107]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0369", -- subi r13 r13 873
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [new_line]
X"820e001a", -- load r0 r14 26 [2]
X"8b000001", -- addi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"821e0004", -- load r1 r14 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L108
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L109
X"8b0e0001", -- addi r0 r14 1 [L108]
X"e3000000", -- cmpi r0 0 [L109]
X"1b000006", -- breq L110
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"33000005", -- rjmp L111
X"8b0e0000", -- addi r0 r14 0 [L110]
X"8b1e0000", -- addi r1 r14 0
X"d2e00016", -- store r14 r0 22 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"8b0e0000", -- addi r0 r14 0 [L111]
X"d2e00018", -- store r14 r0 24 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0385", -- subi r13 r13 901
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"822e0012", -- load r2 r14 18 [2]
X"823e000a", -- load r3 r14 10 [2]
X"df023000", -- cmp r2 r3
X"2f000003", -- brge L112
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L113
X"8b2e0001", -- addi r2 r14 1 [L112]
X"824e0014", -- load r4 r14 20 [2] [L113]
X"df043000", -- cmp r4 r3
X"2f000003", -- brge L114
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L115
X"8b4e0001", -- addi r4 r14 1 [L114]
X"c3224000", -- or r2 r2 r4 [L115]
X"e3020000", -- cmpi r2 0
X"1b000007", -- breq L116
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd039d", -- subi r13 r13 925
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L117
X"8fff0002", -- subi r15 r15 2 [L116] [L117]
X"820e0012", -- load r0 r14 18 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd03ae", -- movlo r13 r13 942
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcc8", -- rjmp left_shift_i
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0fffe", -- store r13 r0 -2 [2]
X"821e0014", -- load r1 r14 20 [2]
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
X"f7dd03c2", -- movlo r13 r13 962
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcb4", -- rjmp left_shift_i
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
X"f7dd03d9", -- movlo r13 r13 985
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd33", -- rjmp tile_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03e0", -- subi r13 r13 992
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at_pos]
X"810d0003", -- load r0 r13 3 [1]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"823e0002", -- load r3 r14 2 [2]
X"a7332000", -- mul r3 r3 r2
X"93113000", -- add r1 r1 r3
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"f7dd03f4", -- movlo r13 r13 1012
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff93", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03fa", -- subi r13 r13 1018
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c]
X"810d0003", -- load r0 r13 3 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0016", -- load r1 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"f7dd040a", -- movlo r13 r13 1034
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff7d", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b00000f", -- breq L118
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd0415", -- movlo r13 r13 1045
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe43", -- rjmp advance_cursor
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd041b", -- subi r13 r13 1051
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L119
X"8bce0000", -- addi r12 r14 0 [L118] [L119]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0421", -- subi r13 r13 1057
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print]
X"820d0002", -- load r0 r13 2 [2]
X"820d0002", -- load r0 r13 2 [2] [L120]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1b000014", -- breq L121
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821d0002", -- load r1 r13 2 [2]
X"81110000", -- load r1 r1 0 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0001", -- subi r15 r15 1
X"f7dd0434", -- movlo r13 r13 1076
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffc8", -- rjmp print_c
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820d0002", -- load r0 r13 2 [2]
X"8b000001", -- addi r0 r0 1
X"d2d00002", -- store r13 r0 2 [2]
X"3300ffea", -- rjmp L120
X"cfce0000", -- move r12 r14 [L121]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd043f", -- subi r13 r13 1087
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [clear]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L122]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L124
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L125
X"8b0e0001", -- addi r0 r14 1 [L124]
X"e3000000", -- cmpi r0 0 [L125]
X"1b000015", -- breq L123
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"822dfffe", -- load r2 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b3e0000", -- addi r3 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd045a", -- movlo r13 r13 1114
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcb2", -- rjmp tile_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8b000001", -- addi r0 r0 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"3300ffe4", -- rjmp L122
X"8b0e0000", -- addi r0 r14 0 [L123]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"8bff0002", -- addi r15 r15 2
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd046c", -- subi r13 r13 1132
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [read_keyboard]
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0479", -- movlo r13 r13 1145
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb99", -- rjmp in
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
X"f7dd0494", -- movlo r13 r13 1172
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbca", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"831dfff4", -- load r1 r13 -12 [4]
X"bf001000", -- and r0 r0 r1
X"e3000000", -- cmpi r0 0
X"1b000009", -- breq L126
X"830dfffc", -- load r0 r13 -4 [4]
X"cfc00000", -- move r12 r0
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04a2", -- subi r13 r13 1186
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L127
X"8bff000c", -- addi r15 r15 12 [L126] [L127]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04a9", -- subi r13 r13 1193
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [read_char]
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd04b6", -- movlo r13 r13 1206
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb5c", -- rjmp in
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
X"f7dd04d2", -- movlo r13 r13 1234
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb8c", -- rjmp right_shift_l
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
X"1b00000b", -- breq L128
X"8b0e00ff", -- addi r0 r14 255
X"831dfffc", -- load r1 r13 -4 [4]
X"bf001000", -- and r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0012", -- addi r15 r15 18
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04e6", -- subi r13 r13 1254
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L129
X"8bff0012", -- addi r15 r15 18 [L128] [L129]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04ed", -- subi r13 r13 1261
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [sleep_ms]
X"830d0004", -- load r0 r13 4 [4]
X"8fff0004", -- subi r15 r15 4
X"831e001c", -- load r1 r14 28 [4]
X"a7001000", -- mul r0 r0 r1
X"8fff0004", -- subi r15 r15 4
X"8b2e0000", -- addi r2 r14 0
X"d3d0fffc", -- store r13 r0 -4 [4]
X"d3d2fff8", -- store r13 r2 -8 [4]
X"e3020000", -- cmpi r2 0
X"1b000004", -- breq L130
X"8b0e0000", -- addi r0 r14 0
X"d3d0fff8", -- store r13 r0 -8 [4]
X"33000001", -- rjmp L131
X"830dfff8", -- load r0 r13 -8 [4] [L130] [L131] [L132]
X"831dfffc", -- load r1 r13 -4 [4]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L134
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L135
X"8b0e0001", -- addi r0 r14 1 [L134]
X"e3000000", -- cmpi r0 0 [L135]
X"1b000005", -- breq L133
X"832dfff8", -- load r2 r13 -8 [4]
X"8b220001", -- addi r2 r2 1
X"d3d2fff8", -- store r13 r2 -8 [4]
X"3300fff4", -- rjmp L132
X"8bff0008", -- addi r15 r15 8 [L133]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd050e", -- subi r13 r13 1294
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [main]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0008", -- addi r1 r14 8
X"8fff0002", -- subi r15 r15 2
X"8b2e0013", -- addi r2 r14 19
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"823e0020", -- load r3 r14 32 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"824e003e", -- load r4 r14 62 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f40000", -- store r15 r4 0 [2]
X"8b5e0000", -- addi r5 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f50000", -- store r15 r5 0 [2]
X"d1d0fffe", -- store r13 r0 -2 [1]
X"d1d1fffc", -- store r13 r1 -4 [1]
X"d1d2fffa", -- store r13 r2 -6 [1]
X"f7dd0528", -- movlo r13 r13 1320
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc40", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e003e", -- load r0 r14 62 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e003c", -- load r1 r14 60 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0001", -- addi r2 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"f7dd053a", -- movlo r13 r13 1338
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc2e", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0020", -- load r0 r14 32 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e003c", -- load r1 r14 60 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0002", -- addi r2 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"f7dd054c", -- movlo r13 r13 1356
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc1c", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0020", -- load r0 r14 32 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e0040", -- load r1 r14 64 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0003", -- addi r2 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"f7dd055e", -- movlo r13 r13 1374
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc0a", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0042", -- load r0 r14 66 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"f7dd056f", -- movlo r13 r13 1391
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbf9", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0032", -- load r0 r14 50 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0005", -- addi r1 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"f7dd0580", -- movlo r13 r13 1408
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbe8", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820e0020", -- load r0 r14 32 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e0042", -- load r1 r14 66 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0006", -- addi r2 r14 6
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"f7dd0592", -- movlo r13 r13 1426
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbd6", -- rjmp palette_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fff0002", -- subi r15 r15 2 [L136]
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
X"8fff0002", -- subi r15 r15 2
X"d2d1fff6", -- store r13 r1 -10 [2]
X"8b1e0000", -- addi r1 r14 0
X"8b1e0000", -- addi r1 r14 0
X"d2d0ffde", -- store r13 r0 -34 [2]
X"d2d1ffdc", -- store r13 r1 -36 [2]
X"d2d2fff4", -- store r13 r2 -12 [2]
X"d1d3fff2", -- store r13 r3 -14 [1]
X"d2d4fff0", -- store r13 r4 -16 [2]
X"d2d5ffee", -- store r13 r5 -18 [2]
X"d2d6ffec", -- store r13 r6 -20 [2]
X"d2d7ffea", -- store r13 r7 -22 [2]
X"d2d8ffe8", -- store r13 r8 -24 [2]
X"d2d9ffe6", -- store r13 r9 -26 [2]
X"d2daffe4", -- store r13 r10 -28 [2]
X"d2dbffe2", -- store r13 r11 -30 [2]
X"d2dcffe0", -- store r13 r12 -32 [2]
X"820dffdc", -- load r0 r13 -36 [2] [L138]
X"e30004b0", -- cmpi r0 1200
X"23000003", -- brlt L140
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L141
X"8b0e0001", -- addi r0 r14 1 [L140]
X"e3000000", -- cmpi r0 0 [L141]
X"1b00000b", -- breq L139
X"8b1e00bd", -- addi r1 r14 189
X"822dffdc", -- load r2 r13 -36 [2]
X"8b3e0001", -- addi r3 r14 1
X"a7323000", -- mul r3 r2 r3
X"93113000", -- add r1 r1 r3
X"813e0068", -- load r3 r14 104 [1]
X"d1130000", -- store r1 r3 0 [1]
X"8b220001", -- addi r2 r2 1
X"d2d2ffdc", -- store r13 r2 -36 [2]
X"3300ffef", -- rjmp L138
X"8bfffffe", -- addi r15 r15 -2 [L139]
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
X"f7dd05e4", -- movlo r13 r13 1508
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa39", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0002", -- addi r0 r14 2
X"d2d0ffdc", -- store r13 r0 -36 [2]
X"821e0058", -- load r1 r14 88 [2]
X"822e0064", -- load r2 r14 100 [2]
X"97112000", -- sub r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L142
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L143
X"8b0e0001", -- addi r0 r14 1 [L142]
X"e3000000", -- cmpi r0 0 [L143]
X"1b000014", -- breq L144
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dffdc", -- load r0 r13 -36 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0602", -- movlo r13 r13 1538
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa1b", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L145
X"820dffdc", -- load r0 r13 -36 [2] [L144] [L145] [L146]
X"821e0058", -- load r1 r14 88 [2]
X"822e0064", -- load r2 r14 100 [2]
X"97112000", -- sub r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L148
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L149
X"8b0e0001", -- addi r0 r14 1 [L148]
X"e3000000", -- cmpi r0 0 [L149]
X"1b00002a", -- breq L147
X"8b3e00bd", -- addi r3 r14 189
X"824dffdc", -- load r4 r13 -36 [2]
X"825e0056", -- load r5 r14 86 [2]
X"a7445000", -- mul r4 r4 r5
X"8b6e0001", -- addi r6 r14 1
X"a7646000", -- mul r6 r4 r6
X"93336000", -- add r3 r3 r6
X"816e006f", -- load r6 r14 111 [1]
X"d1360000", -- store r3 r6 0 [1]
X"8b3e00bd", -- addi r3 r14 189
X"827dffdc", -- load r7 r13 -36 [2]
X"a7775000", -- mul r7 r7 r5
X"8b770001", -- addi r7 r7 1
X"8b8e0001", -- addi r8 r14 1
X"a7878000", -- mul r8 r7 r8
X"93338000", -- add r3 r3 r8
X"d1360000", -- store r3 r6 0 [1]
X"8b3e00bd", -- addi r3 r14 189
X"828dffdc", -- load r8 r13 -36 [2]
X"a7885000", -- mul r8 r8 r5
X"8f550002", -- subi r5 r5 2
X"93885000", -- add r8 r8 r5
X"8b9e0001", -- addi r9 r14 1
X"a7989000", -- mul r9 r8 r9
X"93339000", -- add r3 r3 r9
X"819e0070", -- load r9 r14 112 [1]
X"d1390000", -- store r3 r9 0 [1]
X"8b3e00bd", -- addi r3 r14 189
X"82adffdc", -- load r10 r13 -36 [2]
X"82be0056", -- load r11 r14 86 [2]
X"a7aab000", -- mul r10 r10 r11
X"8fbb0001", -- subi r11 r11 1
X"93aab000", -- add r10 r10 r11
X"8bce0001", -- addi r12 r14 1
X"a7cac000", -- mul r12 r10 r12
X"9333c000", -- add r3 r3 r12
X"d1390000", -- store r3 r9 0 [1]
X"823dffdc", -- load r3 r13 -36 [2]
X"8b330001", -- addi r3 r3 1
X"d2d3ffdc", -- store r13 r3 -36 [2]
X"3300ffcd", -- rjmp L146
X"8b0e0000", -- addi r0 r14 0 [L147]
X"d2d0ffdc", -- store r13 r0 -36 [2]
X"820dffdc", -- load r0 r13 -36 [2] [L150]
X"821e0056", -- load r1 r14 86 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L152
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L153
X"8b0e0001", -- addi r0 r14 1 [L152]
X"e3000000", -- cmpi r0 0 [L153]
X"1b000024", -- breq L151
X"8b2e00bd", -- addi r2 r14 189
X"823dffdc", -- load r3 r13 -36 [2]
X"8b4e0001", -- addi r4 r14 1
X"a7434000", -- mul r4 r3 r4
X"93224000", -- add r2 r2 r4
X"814e0069", -- load r4 r14 105 [1]
X"d1240000", -- store r2 r4 0 [1]
X"8b2e00bd", -- addi r2 r14 189
X"93113000", -- add r1 r1 r3
X"8b5e0001", -- addi r5 r14 1
X"a7515000", -- mul r5 r1 r5
X"93225000", -- add r2 r2 r5
X"d1240000", -- store r2 r4 0 [1]
X"8b2e00bd", -- addi r2 r14 189
X"825e0058", -- load r5 r14 88 [2]
X"8f550002", -- subi r5 r5 2
X"826e0056", -- load r6 r14 86 [2]
X"a7556000", -- mul r5 r5 r6
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93227000", -- add r2 r2 r7
X"d1240000", -- store r2 r4 0 [1]
X"8b2e00bd", -- addi r2 r14 189
X"827e0058", -- load r7 r14 88 [2]
X"8f770001", -- subi r7 r7 1
X"a7776000", -- mul r7 r7 r6
X"93773000", -- add r7 r7 r3
X"8b8e0001", -- addi r8 r14 1
X"a7878000", -- mul r8 r7 r8
X"93228000", -- add r2 r2 r8
X"d1240000", -- store r2 r4 0 [1]
X"8b330001", -- addi r3 r3 1
X"d2d3ffdc", -- store r13 r3 -36 [2]
X"3300ffd5", -- rjmp L150
X"8b0e00bd", -- addi r0 r14 189 [L151]
X"821e005e", -- load r1 r14 94 [2]
X"822e0056", -- load r2 r14 86 [2]
X"a7112000", -- mul r1 r1 r2
X"823e005c", -- load r3 r14 92 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e006d", -- load r4 r14 109 [1]
X"d1040000", -- store r0 r4 0 [1]
X"8b0e00bd", -- addi r0 r14 189
X"825e0062", -- load r5 r14 98 [2]
X"a7552000", -- mul r5 r5 r2
X"826e0060", -- load r6 r14 96 [2]
X"93556000", -- add r5 r5 r6
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93007000", -- add r0 r0 r7
X"817e006e", -- load r7 r14 110 [1]
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
X"f7dd068d", -- movlo r13 r13 1677
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f990", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0ffdc", -- store r13 r0 -36 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L154
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L155
X"8b0e0001", -- addi r0 r14 1 [L154]
X"e3000000", -- cmpi r0 0 [L155]
X"1b000014", -- breq L156
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dffdc", -- load r0 r13 -36 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd06a8", -- movlo r13 r13 1704
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f975", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L157
X"820dffdc", -- load r0 r13 -36 [2] [L156] [L157] [L158]
X"821e005a", -- load r1 r14 90 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L160
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L161
X"8b0e0001", -- addi r0 r14 1 [L160]
X"e3000000", -- cmpi r0 0 [L161]
X"1b00002f", -- breq L159
X"8b2e00bd", -- addi r2 r14 189
X"823dffe2", -- load r3 r13 -30 [2]
X"824dffdc", -- load r4 r13 -36 [2]
X"93334000", -- add r3 r3 r4
X"825e0056", -- load r5 r14 86 [2]
X"a7335000", -- mul r3 r3 r5
X"826dffe4", -- load r6 r13 -28 [2]
X"93336000", -- add r3 r3 r6
X"8b7e0001", -- addi r7 r14 1
X"a7737000", -- mul r7 r3 r7
X"93227000", -- add r2 r2 r7
X"817e006a", -- load r7 r14 106 [1]
X"d1270000", -- store r2 r7 0 [1]
X"8b2e00bd", -- addi r2 r14 189
X"828dffde", -- load r8 r13 -34 [2]
X"93884000", -- add r8 r8 r4
X"a7885000", -- mul r8 r8 r5
X"829dffe0", -- load r9 r13 -32 [2]
X"93889000", -- add r8 r8 r9
X"8bae0001", -- addi r10 r14 1
X"a7a8a000", -- mul r10 r8 r10
X"9322a000", -- add r2 r2 r10
X"81ae006b", -- load r10 r14 107 [1]
X"d12a0000", -- store r2 r10 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b2e0a55", -- addi r2 r14 2645
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd06dc", -- movlo r13 r13 1756
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f941", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dffdc", -- load r0 r13 -36 [2]
X"8b000001", -- addi r0 r0 1
X"d2d0ffdc", -- store r13 r0 -36 [2]
X"3300ffca", -- rjmp L158
X"8b0e00bd", -- addi r0 r14 189 [L159]
X"821dffee", -- load r1 r13 -18 [2]
X"822e0056", -- load r2 r14 86 [2]
X"a7112000", -- mul r1 r1 r2
X"823dfff0", -- load r3 r13 -16 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e006c", -- load r4 r14 108 [1]
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
X"f7dd06fd", -- movlo r13 r13 1789
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f920", -- rjmp out
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
X"f7dd070f", -- movlo r13 r13 1807
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb22", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0071", -- addi r2 r14 113
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d2e00014", -- store r14 r0 20 [2]
X"d2e10012", -- store r14 r1 18 [2]
X"f7dd0720", -- movlo r13 r13 1824
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd03", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e07d0", -- addi r0 r14 2000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd072e", -- movlo r13 r13 1838
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdc1", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfff8", -- load r0 r13 -8 [2] [L162]
X"e3000001", -- cmpi r0 1
X"1b000003", -- breq L164
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L165
X"8b0e0001", -- addi r0 r14 1 [L164]
X"e3000000", -- cmpi r0 0 [L165]
X"1b000317", -- breq L163
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd073f", -- movlo r13 r13 1855
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd6c", -- rjmp read_char
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d1d0fffe", -- store r13 r0 -2 [1]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L166
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L167
X"8b0e0001", -- addi r0 r14 1 [L166]
X"e3000000", -- cmpi r0 0 [L167]
X"1b000038", -- breq L168
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"812dfffc", -- load r2 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"813dfffa", -- load r3 r13 -6 [1]
X"8f330003", -- subi r3 r3 3
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"d2e10012", -- store r14 r1 18 [2]
X"f7dd075c", -- movlo r13 r13 1884
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fad5", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e00b5", -- addi r0 r14 181
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0769", -- movlo r13 r13 1897
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fcba", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e07d0", -- addi r0 r14 2000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0777", -- movlo r13 r13 1911
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd78", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff0024", -- addi r15 r15 36
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd077f", -- subi r13 r13 1919
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L169
X"810dfffe", -- load r0 r13 -2 [1] [L168] [L169]
X"e3000073", -- cmpi r0 115
X"1b000003", -- breq L170
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L171
X"8b0e0001", -- addi r0 r14 1 [L170]
X"e3000000", -- cmpi r0 0 [L171]
X"1b00002a", -- breq L172
X"820dffe2", -- load r0 r13 -30 [2]
X"821e0058", -- load r1 r14 88 [2]
X"822e005a", -- load r2 r14 90 [2]
X"97112000", -- sub r1 r1 r2
X"823e0064", -- load r3 r14 100 [2]
X"97113000", -- sub r1 r1 r3
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L174
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L175
X"8b0e0001", -- addi r0 r14 1 [L174]
X"e3000000", -- cmpi r0 0 [L175]
X"1b00001c", -- breq L176
X"820dffe2", -- load r0 r13 -30 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e00bd", -- addi r1 r14 189
X"d2d0ffe2", -- store r13 r0 -30 [2]
X"8f000001", -- subi r0 r0 1
X"822e0056", -- load r2 r14 86 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe4", -- load r3 r13 -28 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0068", -- load r4 r14 104 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1e00bd", -- addi r1 r14 189
X"825dffe2", -- load r5 r13 -30 [2]
X"826e005a", -- load r6 r14 90 [2]
X"8f660001", -- subi r6 r6 1
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e006a", -- load r7 r14 106 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L177
X"3300002c", -- rjmp L173 [L176] [L177]
X"810dfffe", -- load r0 r13 -2 [1] [L172]
X"e3000077", -- cmpi r0 119
X"1b000003", -- breq L178
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L179
X"8b0e0001", -- addi r0 r14 1 [L178]
X"e3000000", -- cmpi r0 0 [L179]
X"1b000024", -- breq L180
X"820dffe2", -- load r0 r13 -30 [2]
X"821e0064", -- load r1 r14 100 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L182
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L183
X"8b0e0001", -- addi r0 r14 1 [L182]
X"e3000000", -- cmpi r0 0 [L183]
X"1b00001a", -- breq L184
X"820dffe2", -- load r0 r13 -30 [2]
X"8f000001", -- subi r0 r0 1
X"8b1e00bd", -- addi r1 r14 189
X"d2d0ffe2", -- store r13 r0 -30 [2]
X"822e0056", -- load r2 r14 86 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe4", -- load r3 r13 -28 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e006a", -- load r4 r14 106 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1e00bd", -- addi r1 r14 189
X"825dffe2", -- load r5 r13 -30 [2]
X"826e005a", -- load r6 r14 90 [2]
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0068", -- load r7 r14 104 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L185
X"33000001", -- rjmp L181 [L184] [L185]
X"810dfffe", -- load r0 r13 -2 [1] [L180] [L181] [L173]
X"e300006c", -- cmpi r0 108
X"1b000003", -- breq L186
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L187
X"8b0e0001", -- addi r0 r14 1 [L186]
X"e3000000", -- cmpi r0 0 [L187]
X"1b00002a", -- breq L188
X"820dffde", -- load r0 r13 -34 [2]
X"821e0058", -- load r1 r14 88 [2]
X"822e005a", -- load r2 r14 90 [2]
X"97112000", -- sub r1 r1 r2
X"823e0064", -- load r3 r14 100 [2]
X"97113000", -- sub r1 r1 r3
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L190
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L191
X"8b0e0001", -- addi r0 r14 1 [L190]
X"e3000000", -- cmpi r0 0 [L191]
X"1b00001c", -- breq L192
X"820dffde", -- load r0 r13 -34 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e00bd", -- addi r1 r14 189
X"d2d0ffde", -- store r13 r0 -34 [2]
X"8f000001", -- subi r0 r0 1
X"822e0056", -- load r2 r14 86 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe0", -- load r3 r13 -32 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e0068", -- load r4 r14 104 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1e00bd", -- addi r1 r14 189
X"825dffde", -- load r5 r13 -34 [2]
X"826e005a", -- load r6 r14 90 [2]
X"8f660001", -- subi r6 r6 1
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e006b", -- load r7 r14 107 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L193
X"3300002c", -- rjmp L189 [L192] [L193]
X"810dfffe", -- load r0 r13 -2 [1] [L188]
X"e300006f", -- cmpi r0 111
X"1b000003", -- breq L194
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L195
X"8b0e0001", -- addi r0 r14 1 [L194]
X"e3000000", -- cmpi r0 0 [L195]
X"1b000024", -- breq L196
X"820dffde", -- load r0 r13 -34 [2]
X"821e0064", -- load r1 r14 100 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L198
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L199
X"8b0e0001", -- addi r0 r14 1 [L198]
X"e3000000", -- cmpi r0 0 [L199]
X"1b00001a", -- breq L200
X"820dffde", -- load r0 r13 -34 [2]
X"8f000001", -- subi r0 r0 1
X"8b1e00bd", -- addi r1 r14 189
X"d2d0ffde", -- store r13 r0 -34 [2]
X"822e0056", -- load r2 r14 86 [2]
X"a7002000", -- mul r0 r0 r2
X"823dffe0", -- load r3 r13 -32 [2]
X"93003000", -- add r0 r0 r3
X"8b4e0001", -- addi r4 r14 1
X"a7404000", -- mul r4 r0 r4
X"93114000", -- add r1 r1 r4
X"814e006b", -- load r4 r14 107 [1]
X"d1140000", -- store r1 r4 0 [1]
X"8b1e00bd", -- addi r1 r14 189
X"825dffde", -- load r5 r13 -34 [2]
X"826e005a", -- load r6 r14 90 [2]
X"93556000", -- add r5 r5 r6
X"a7552000", -- mul r5 r5 r2
X"93553000", -- add r5 r5 r3
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93117000", -- add r1 r1 r7
X"817e0068", -- load r7 r14 104 [1]
X"d1170000", -- store r1 r7 0 [1]
X"33000001", -- rjmp L201
X"33000001", -- rjmp L197 [L200] [L201]
X"820dfff0", -- load r0 r13 -16 [2] [L196] [L197] [L189]
X"821dffe8", -- load r1 r13 -24 [2]
X"93001000", -- add r0 r0 r1
X"822dffee", -- load r2 r13 -18 [2]
X"823dffe6", -- load r3 r13 -26 [2]
X"93223000", -- add r2 r2 r3
X"8fff0002", -- subi r15 r15 2
X"8b4e00bd", -- addi r4 r14 189
X"d2d2ffea", -- store r13 r2 -22 [2]
X"825e0056", -- load r5 r14 86 [2]
X"a7225000", -- mul r2 r2 r5
X"93220000", -- add r2 r2 r0
X"93242000", -- add r2 r4 r2
X"81220000", -- load r2 r2 0 [1]
X"d1d2ffda", -- store r13 r2 -38 [1]
X"816e0069", -- load r6 r14 105 [1]
X"df026000", -- cmp r2 r6
X"1b000003", -- breq L202
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L203
X"8b2e0001", -- addi r2 r14 1 [L202]
X"d2d0ffec", -- store r13 r0 -20 [2] [L203]
X"e3020000", -- cmpi r2 0
X"1b00000c", -- breq L204
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
X"330000a1", -- rjmp L205
X"810dffda", -- load r0 r13 -38 [1] [L204]
X"811e006a", -- load r1 r14 106 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L206
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L207
X"8b0e0001", -- addi r0 r14 1 [L206]
X"812dffda", -- load r2 r13 -38 [1] [L207]
X"813e006b", -- load r3 r14 107 [1]
X"df023000", -- cmp r2 r3
X"1b000003", -- breq L208
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L209
X"8b2e0001", -- addi r2 r14 1 [L208]
X"c3002000", -- or r0 r0 r2 [L209]
X"e3000000", -- cmpi r0 0
X"1b00000c", -- breq L210
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
X"33000085", -- rjmp L211
X"810dffda", -- load r0 r13 -38 [1] [L210]
X"811e006f", -- load r1 r14 111 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L212
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L213
X"8b0e0001", -- addi r0 r14 1 [L212]
X"e3000000", -- cmpi r0 0 [L213]
X"1b00003a", -- breq L214
X"820dfff4", -- load r0 r13 -12 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e0013", -- addi r1 r14 19
X"8b2e000e", -- addi r2 r14 14
X"8b3e0001", -- addi r3 r14 1
X"8b4e0001", -- addi r4 r14 1
X"8b5e0003", -- addi r5 r14 3
X"8b6e0003", -- addi r6 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"817dfffc", -- load r7 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f70000", -- store r15 r7 0 [1]
X"818dfffa", -- load r8 r13 -6 [1]
X"8b880001", -- addi r8 r8 1
X"8bffffff", -- addi r15 r15 -1
X"d1f80000", -- store r15 r8 0 [1]
X"d2d0fff4", -- store r13 r0 -12 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d2ffea", -- store r13 r2 -22 [2]
X"d2d3ffe8", -- store r13 r3 -24 [2]
X"d2d4ffe6", -- store r13 r4 -26 [2]
X"d2e50014", -- store r14 r5 20 [2]
X"d2e60012", -- store r14 r6 18 [2]
X"f7dd089d", -- movlo r13 r13 2205
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f994", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e00a4", -- addi r0 r14 164
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd08a9", -- movlo r13 r13 2217
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb7a", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd08b6", -- movlo r13 r13 2230
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fc39", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000043", -- rjmp L215
X"810dffda", -- load r0 r13 -38 [1] [L214]
X"811e0070", -- load r1 r14 112 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L216
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L217
X"8b0e0001", -- addi r0 r14 1 [L216]
X"e3000000", -- cmpi r0 0 [L217]
X"1b00003a", -- breq L218
X"820dfff6", -- load r0 r13 -10 [2]
X"8b000001", -- addi r0 r0 1
X"8b1e0013", -- addi r1 r14 19
X"8b2e000e", -- addi r2 r14 14
X"8b3effff", -- addi r3 r14 -1
X"8b4effff", -- addi r4 r14 -1
X"8b5e0003", -- addi r5 r14 3
X"8b6e0003", -- addi r6 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"817dfffc", -- load r7 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f70000", -- store r15 r7 0 [1]
X"818dfffa", -- load r8 r13 -6 [1]
X"8f880005", -- subi r8 r8 5
X"8bffffff", -- addi r15 r15 -1
X"d1f80000", -- store r15 r8 0 [1]
X"d2d0fff6", -- store r13 r0 -10 [2]
X"d2d1ffec", -- store r13 r1 -20 [2]
X"d2d2ffea", -- store r13 r2 -22 [2]
X"d2d3ffe8", -- store r13 r3 -24 [2]
X"d2d4ffe6", -- store r13 r4 -26 [2]
X"d2e50014", -- store r14 r5 20 [2]
X"d2e60012", -- store r14 r6 18 [2]
X"f7dd08df", -- movlo r13 r13 2271
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f952", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e00a4", -- addi r0 r14 164
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd08eb", -- movlo r13 r13 2283
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb38", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e03e8", -- addi r0 r14 1000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd08f8", -- movlo r13 r13 2296
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fbf7", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L219
X"8b0e00bd", -- addi r0 r14 189 [L218] [L219] [L215] [L211] [L205]
X"821dffee", -- load r1 r13 -18 [2]
X"822e0056", -- load r2 r14 86 [2]
X"a7112000", -- mul r1 r1 r2
X"823dfff0", -- load r3 r13 -16 [2]
X"93113000", -- add r1 r1 r3
X"8b4e0001", -- addi r4 r14 1
X"a7414000", -- mul r4 r1 r4
X"93004000", -- add r0 r0 r4
X"814e0068", -- load r4 r14 104 [1]
X"d1040000", -- store r0 r4 0 [1]
X"8b0e00bd", -- addi r0 r14 189
X"825dffea", -- load r5 r13 -22 [2]
X"a7552000", -- mul r5 r5 r2
X"826dffec", -- load r6 r13 -20 [2]
X"93556000", -- add r5 r5 r6
X"8b7e0001", -- addi r7 r14 1
X"a7757000", -- mul r7 r5 r7
X"93007000", -- add r0 r0 r7
X"817e006c", -- load r7 r14 108 [1]
X"d1070000", -- store r0 r7 0 [1]
X"cf360000", -- move r3 r6
X"820dffea", -- load r0 r13 -22 [2]
X"cf800000", -- move r8 r0
X"8b9e0000", -- addi r9 r14 0
X"8fff0002", -- subi r15 r15 2
X"8bae0000", -- addi r10 r14 0
X"d2d3fff0", -- store r13 r3 -16 [2]
X"d2d8ffee", -- store r13 r8 -18 [2]
X"d2d9ffdc", -- store r13 r9 -36 [2]
X"d1daffd8", -- store r13 r10 -40 [1]
X"820dffdc", -- load r0 r13 -36 [2] [L220]
X"821e0056", -- load r1 r14 86 [2]
X"822e0058", -- load r2 r14 88 [2]
X"a7112000", -- mul r1 r1 r2
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L222
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L223
X"8b0e0001", -- addi r0 r14 1 [L222]
X"e3000000", -- cmpi r0 0 [L223]
X"1b0000ec", -- breq L221
X"8b3e00bd", -- addi r3 r14 189
X"824dffdc", -- load r4 r13 -36 [2]
X"93434000", -- add r4 r3 r4
X"81440000", -- load r4 r4 0 [1]
X"d1d4ffd8", -- store r13 r4 -40 [1]
X"815e0068", -- load r5 r14 104 [1]
X"df045000", -- cmp r4 r5
X"1b000003", -- breq L224
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L225
X"8b4e0001", -- addi r4 r14 1 [L224]
X"e3040000", -- cmpi r4 0 [L225]
X"1b000015", -- breq L226
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dffdc", -- load r1 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd0943", -- movlo r13 r13 2371
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa44", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000c7", -- rjmp L227
X"810dffd8", -- load r0 r13 -40 [1] [L226]
X"811e006f", -- load r1 r14 111 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L228
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L229
X"8b0e0001", -- addi r0 r14 1 [L228]
X"e3000000", -- cmpi r0 0 [L229]
X"1b000015", -- breq L230
X"8b0e0004", -- addi r0 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dffdc", -- load r1 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd0960", -- movlo r13 r13 2400
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa27", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"330000aa", -- rjmp L231
X"810dffd8", -- load r0 r13 -40 [1] [L230]
X"811e0070", -- load r1 r14 112 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L232
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L233
X"8b0e0001", -- addi r0 r14 1 [L232]
X"e3000000", -- cmpi r0 0 [L233]
X"1b000015", -- breq L234
X"8b0e0005", -- addi r0 r14 5
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dffdc", -- load r1 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd097d", -- movlo r13 r13 2429
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fa0a", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300008d", -- rjmp L235
X"810dffd8", -- load r0 r13 -40 [1] [L234]
X"811e0069", -- load r1 r14 105 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L236
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L237
X"8b0e0001", -- addi r0 r14 1 [L236]
X"812dffd8", -- load r2 r13 -40 [1] [L237]
X"813e006a", -- load r3 r14 106 [1]
X"df023000", -- cmp r2 r3
X"1b000003", -- breq L238
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L239
X"8b2e0001", -- addi r2 r14 1 [L238]
X"c3002000", -- or r0 r0 r2 [L239]
X"814dffd8", -- load r4 r13 -40 [1]
X"815e006b", -- load r5 r14 107 [1]
X"df045000", -- cmp r4 r5
X"1b000003", -- breq L240
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L241
X"8b4e0001", -- addi r4 r14 1 [L240]
X"c3004000", -- or r0 r0 r4 [L241]
X"e3000000", -- cmpi r0 0
X"1b000015", -- breq L242
X"8b0e0001", -- addi r0 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821dffdc", -- load r1 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8b2e0020", -- addi r2 r14 32
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd09aa", -- movlo r13 r13 2474
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9dd", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000060", -- rjmp L243
X"810dffd8", -- load r0 r13 -40 [1] [L242]
X"811e006c", -- load r1 r14 108 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L244
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L245
X"8b0e0001", -- addi r0 r14 1 [L244]
X"e3000000", -- cmpi r0 0 [L245]
X"1b000017", -- breq L246
X"8b0e0002", -- addi r0 r14 2
X"8b1e0002", -- addi r1 r14 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dffdc", -- load r2 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b3e0004", -- addi r3 r14 4
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e00012", -- store r14 r0 18 [2]
X"d2e10014", -- store r14 r1 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd09c9", -- movlo r13 r13 2505
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9be", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000041", -- rjmp L247
X"810dffd8", -- load r0 r13 -40 [1] [L246]
X"811e006d", -- load r1 r14 109 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L248
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L249
X"8b0e0001", -- addi r0 r14 1 [L248]
X"e3000000", -- cmpi r0 0 [L249]
X"1b000018", -- breq L250
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dffdc", -- load r2 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"823dfff6", -- load r3 r13 -10 [2]
X"8b330030", -- addi r3 r3 48
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e00012", -- store r14 r0 18 [2]
X"d2e10014", -- store r14 r1 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd09e9", -- movlo r13 r13 2537
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f99e", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000021", -- rjmp L251
X"810dffd8", -- load r0 r13 -40 [1] [L250]
X"811e006e", -- load r1 r14 110 [1]
X"df001000", -- cmp r0 r1
X"1b000003", -- breq L252
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L253
X"8b0e0001", -- addi r0 r14 1 [L252]
X"e3000000", -- cmpi r0 0 [L253]
X"1b000018", -- breq L254
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dffdc", -- load r2 r13 -36 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"823dfff4", -- load r3 r13 -12 [2]
X"8b330030", -- addi r3 r3 48
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e00012", -- store r14 r0 18 [2]
X"d2e10014", -- store r14 r1 20 [2]
X"8fff0003", -- subi r15 r15 3
X"f7dd0a09", -- movlo r13 r13 2569
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f97e", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L255
X"820dffdc", -- load r0 r13 -36 [2] [L254] [L255] [L251] [L247] [L243] [L235] [L231] [L227]
X"8b000001", -- addi r0 r0 1
X"d2d0ffdc", -- store r13 r0 -36 [2]
X"3300ff0b", -- rjmp L220
X"8bfffffe", -- addi r15 r15 -2 [L221]
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
X"f7dd0a20", -- movlo r13 r13 2592
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f5fd", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfff6", -- load r0 r13 -10 [2]
X"821e0066", -- load r1 r14 102 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L256
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L257
X"8b0e0001", -- addi r0 r14 1 [L256]
X"e3000000", -- cmpi r0 0 [L257]
X"1b000006", -- breq L258
X"8b0e0001", -- addi r0 r14 1
X"8b1e0000", -- addi r1 r14 0
X"d1d0fff2", -- store r13 r0 -14 [1]
X"d2d1fff8", -- store r13 r1 -8 [2]
X"3300000f", -- rjmp L259
X"820dfff4", -- load r0 r13 -12 [2] [L258]
X"821e0066", -- load r1 r14 102 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L260
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L261
X"8b0e0001", -- addi r0 r14 1 [L260]
X"e3000000", -- cmpi r0 0 [L261]
X"1b000006", -- breq L262
X"8b0e0002", -- addi r0 r14 2
X"8b1e0000", -- addi r1 r14 0
X"d1d0fff2", -- store r13 r0 -14 [1]
X"d2d1fff8", -- store r13 r1 -8 [2]
X"33000001", -- rjmp L263
X"8bfffffe", -- addi r15 r15 -2 [L262] [L263] [L259]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0078", -- addi r0 r14 120
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0a4a", -- movlo r13 r13 2634
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300faa5", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0004", -- addi r15 r15 4
X"3300fce3", -- rjmp L162
X"8bfffffe", -- addi r15 r15 -2 [L163]
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
X"f7dd0a5e", -- movlo r13 r13 2654
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f5bf", -- rjmp out
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e007d", -- addi r0 r14 125
X"8b000007", -- addi r0 r0 7
X"811dfff2", -- load r1 r13 -14 [1]
X"8b110030", -- addi r1 r1 48
X"d1010000", -- store r0 r1 0 [1]
X"8b0e0003", -- addi r0 r14 3
X"8b2e0003", -- addi r2 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"813dfffc", -- load r3 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"814dfffa", -- load r4 r13 -6 [1]
X"8f440008", -- subi r4 r4 8
X"8bffffff", -- addi r15 r15 -1
X"d1f40000", -- store r15 r4 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"d2e20012", -- store r14 r2 18 [2]
X"f7dd0a78", -- movlo r13 r13 2680
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f7b9", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e007d", -- addi r0 r14 125
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0a85", -- movlo r13 r13 2693
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f99e", -- rjmp print
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
X"8f11000a", -- subi r1 r1 10
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"f7dd0a97", -- movlo r13 r13 2711
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f79a", -- rjmp set_cursor
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e008a", -- addi r0 r14 138
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0aa4", -- movlo r13 r13 2724
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f97f", -- rjmp print
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0ffda", -- store r13 r0 -38 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L264
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L265
X"8b0e0001", -- addi r0 r14 1 [L264]
X"e3000000", -- cmpi r0 0 [L265]
X"1b000013", -- breq L266
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"820dffda", -- load r0 r13 -38 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0abf", -- movlo r13 r13 2751
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f55e", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L267
X"820dffda", -- load r0 r13 -38 [2] [L266] [L267] [L268]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L270
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L271
X"8b0e0001", -- addi r0 r14 1 [L270]
X"e3000000", -- cmpi r0 0 [L271]
X"1b000079", -- breq L269
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0ad2", -- movlo r13 r13 2770
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9d9", -- rjmp read_char
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0000", -- addi r1 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"f3110000", -- movhi r1 r1 0
X"f711eaea", -- movlo r1 r1 60138
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d1d0fffe", -- store r13 r0 -2 [1]
X"8fff0002", -- subi r15 r15 2
X"f7dd0ae6", -- movlo r13 r13 2790
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f537", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"810dfffe", -- load r0 r13 -2 [1]
X"e300000a", -- cmpi r0 10
X"1b000003", -- breq L272
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L273
X"8b0e0001", -- addi r0 r14 1 [L272]
X"e3000000", -- cmpi r0 0 [L273]
X"1b000004", -- breq L274
X"8b0e0001", -- addi r0 r14 1
X"d2d0ffda", -- store r13 r0 -38 [2]
X"3300004f", -- rjmp L275
X"810dfffe", -- load r0 r13 -2 [1] [L274]
X"e300001b", -- cmpi r0 27
X"1b000003", -- breq L276
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L277
X"8b0e0001", -- addi r0 r14 1 [L276]
X"e3000000", -- cmpi r0 0 [L277]
X"1b000047", -- breq L278
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"812dfffc", -- load r2 r13 -4 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f20000", -- store r15 r2 0 [1]
X"813dfffa", -- load r3 r13 -6 [1]
X"8f330003", -- subi r3 r3 3
X"8bffffff", -- addi r15 r15 -1
X"d1f30000", -- store r15 r3 0 [1]
X"d2e00014", -- store r14 r0 20 [2]
X"d2e10012", -- store r14 r1 18 [2]
X"f7dd0b0d", -- movlo r13 r13 2829
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f724", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e00b5", -- addi r0 r14 181
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0b19", -- movlo r13 r13 2841
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f90a", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e07d0", -- addi r0 r14 2000
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0b26", -- movlo r13 r13 2854
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9c9", -- rjmp sleep_ms
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
X"f7dd0b38", -- movlo r13 r13 2872
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4e5", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0000", -- addi r12 r14 0
X"8bff0026", -- addi r15 r15 38
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0b40", -- subi r13 r13 2880
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L279
X"3300ff81", -- rjmp L268 [L278] [L279] [L275]
X"8bfffffe", -- addi r15 r15 -2 [L269]
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0b4d", -- movlo r13 r13 2893
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f9a2", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
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
X"f7dd0b5f", -- movlo r13 r13 2911
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f4be", -- rjmp out
X"8bff000a", -- addi r15 r15 10
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0003", -- addi r0 r14 3
X"8b1e0003", -- addi r1 r14 3
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
X"d2e00014", -- store r14 r0 20 [2]
X"d2e10012", -- store r14 r1 18 [2]
X"f7dd0b74", -- movlo r13 r13 2932
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f6bd", -- rjmp set_cursor
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e00a9", -- addi r0 r14 169
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd0b80", -- movlo r13 r13 2944
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f8a3", -- rjmp print
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd0b8d", -- movlo r13 r13 2957
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300f962", -- rjmp sleep_ms
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0020", -- addi r15 r15 32
X"3300fa04", -- rjmp L136
X"8bce0000", -- addi r12 r14 0 [L137]
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0b97", -- subi r13 r13 2967
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;