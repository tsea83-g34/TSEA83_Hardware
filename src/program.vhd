library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"8fff0001", -- subi r15 r15 1
X"f7dd0005", -- movlo r13 r13 5
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000149", -- rjmp 329
X"8fff0002", -- subi r15 r15 2
X"33000006", -- rjmp 6 [__halt]
X"cfdf0000", -- move r13 r15 [get_uart]
X"8fff0002", -- subi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"0f010000", -- in r0 1
X"cfc00000", -- move r12 r0
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0010", -- subi r13 r13 16
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [store_pm]
X"820d0002", -- load r0 r13 2 [2]
X"831d0004", -- load r1 r13 4 [4]
X"d7010164", -- store_pm r0 r1 356
X"d2d00002", -- store r13 r0 2 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd001a", -- subi r13 r13 26
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [store_dm]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"d1010000", -- store r0 r1 0 [1]
X"d2d00004", -- store r13 r0 4 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0024", -- subi r13 r13 36
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [is_uart_new]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"f7dd0030", -- movlo r13 r13 48
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000007", -- rjmp 7
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"821e0000", -- load r1 r14 0 [2]
X"bf110000", -- and r1 r1 r0
X"cfc10000", -- move r12 r1
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd003b", -- subi r13 r13 59
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [get_uart_byte]
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0045", -- movlo r13 r13 69
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000007", -- rjmp 7
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"d2d0fffe", -- store r13 r0 -2 [2]
X"821e0000", -- load r1 r14 0 [2]
X"8f110001", -- subi r1 r1 1
X"bf001000", -- and r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0053", -- subi r13 r13 83
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [get_num_lines]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0001", -- addi r1 r14 1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"820dfffc", -- load r0 r13 -4 [2] [L0]
X"e3000000", -- cmpi r0 0
X"1b00009c", -- breq 156
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0066", -- movlo r13 r13 102
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000007", -- rjmp 7
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"d2d0fffa", -- store r13 r0 -6 [2]
X"821e0000", -- load r1 r14 0 [2]
X"bf001000", -- and r0 r0 r1
X"8fff0002", -- subi r15 r15 2
X"822dfffa", -- load r2 r13 -6 [2]
X"8f110001", -- subi r1 r1 1
X"bf221000", -- and r2 r2 r1
X"d2d0fff8", -- store r13 r0 -8 [2]
X"e3000000", -- cmpi r0 0
X"1f000077", -- brne 119
X"8b0e0000", -- addi r0 r14 0
X"33000078", -- rjmp 120
X"8b0e0001", -- addi r0 r14 1 [L2]
X"d2d2fff6", -- store r13 r2 -10 [2] [L3]
X"e302000a", -- cmpi r2 10
X"2300007d", -- brlt 125
X"8b2e0000", -- addi r2 r14 0
X"3300007e", -- rjmp 126
X"8b2e0001", -- addi r2 r14 1 [L4]
X"bf002000", -- and r0 r0 r2 [L5]
X"e3000000", -- cmpi r0 0
X"1b000088", -- breq 136
X"820dfffe", -- load r0 r13 -2 [2]
X"8b1e000a", -- addi r1 r14 10
X"a7001000", -- mul r0 r0 r1
X"821dfff6", -- load r1 r13 -10 [2]
X"93001000", -- add r0 r0 r1
X"d2d0fffe", -- store r13 r0 -2 [2]
X"33000088", -- rjmp 136
X"820dfff8", -- load r0 r13 -8 [2] [L7] [L6]
X"e3000000", -- cmpi r0 0
X"1f00008d", -- brne 141
X"8b0e0000", -- addi r0 r14 0
X"3300008e", -- rjmp 142
X"8b0e0001", -- addi r0 r14 1 [L8]
X"821dfff6", -- load r1 r13 -10 [2] [L9]
X"e3010009", -- cmpi r1 9
X"27000093", -- brgt 147
X"8b1e0000", -- addi r1 r14 0
X"33000094", -- rjmp 148
X"8b1e0001", -- addi r1 r14 1 [L10]
X"bf001000", -- and r0 r0 r1 [L11]
X"e3000000", -- cmpi r0 0
X"1b00009a", -- breq 154
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffc", -- store r13 r0 -4 [2]
X"3300009a", -- rjmp 154
X"8bff0006", -- addi r15 r15 6 [L13] [L12]
X"3300005b", -- rjmp 91
X"820dfffe", -- load r0 r13 -2 [2] [L1]
X"cfc00000", -- move r12 r0
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00a2", -- subi r13 r13 162
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [load_uart]
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd00ac", -- movlo r13 r13 172
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000054", -- rjmp 84
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0006", -- subi r15 r15 6
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d3d1fff8", -- store r13 r1 -8 [4]
X"d2d2fff6", -- store r13 r2 -10 [2]
X"d2d3fff4", -- store r13 r3 -12 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L14]
X"e3000000", -- cmpi r0 0
X"1b000102", -- breq 258
X"820dfff6", -- load r0 r13 -10 [2] [L16]
X"e3000004", -- cmpi r0 4
X"230000c2", -- brlt 194
X"8b0e0000", -- addi r0 r14 0
X"330000c3", -- rjmp 195
X"8b0e0001", -- addi r0 r14 1 [L18]
X"e3000000", -- cmpi r0 0 [L19]
X"1b0000e7", -- breq 231
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd00cb", -- movlo r13 r13 203
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000025", -- rjmp 37
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b0000e6", -- breq 230
X"830dfff8", -- load r0 r13 -8 [4]
X"8b1e0100", -- addi r1 r14 256
X"a7001000", -- mul r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd00db", -- movlo r13 r13 219
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300003c", -- rjmp 60
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820f0000", -- load r0 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"9300c000", -- add r0 r0 r12
X"821dfff6", -- load r1 r13 -10 [2]
X"8b110001", -- addi r1 r1 1
X"d3d0fff8", -- store r13 r0 -8 [4]
X"d2d1fff6", -- store r13 r1 -10 [2]
X"330000e6", -- rjmp 230
X"330000bd", -- rjmp 189 [L20] [L21]
X"8b0e0000", -- addi r0 r14 0 [L17]
X"821dfffe", -- load r1 r13 -2 [2]
X"8f110001", -- subi r1 r1 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"832dfff8", -- load r2 r13 -8 [4]
X"8bfffffc", -- addi r15 r15 -4
X"d3f20000", -- store r15 r2 0 [4]
X"823dfff4", -- load r3 r13 -12 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0fff6", -- store r13 r0 -10 [2]
X"d2d1fffe", -- store r13 r1 -2 [2]
X"f7dd00f9", -- movlo r13 r13 249
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000011", -- rjmp 17
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"821dfff4", -- load r1 r13 -12 [2]
X"8b110001", -- addi r1 r1 1
X"d3d0fff8", -- store r13 r0 -8 [4]
X"d2d1fff4", -- store r13 r1 -12 [2]
X"330000ba", -- rjmp 186
X"8b0e0000", -- addi r0 r14 0 [L15]
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"d2d0fff4", -- store r13 r0 -12 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd010c", -- movlo r13 r13 268
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000054", -- rjmp 84
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"d2d0fff2", -- store r13 r0 -14 [2]
X"d2d1fff0", -- store r13 r1 -16 [2]
X"820dfff2", -- load r0 r13 -14 [2] [L22]
X"e3000000", -- cmpi r0 0
X"1b000143", -- breq 323
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd011d", -- movlo r13 r13 285
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000025", -- rjmp 37
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b000142", -- breq 322
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd0127", -- movlo r13 r13 295
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300003c", -- rjmp 60
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"821dfff2", -- load r1 r13 -14 [2]
X"8f110001", -- subi r1 r1 1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"822dfff4", -- load r2 r13 -12 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d2d0fff0", -- store r13 r0 -16 [2]
X"d2d1fff2", -- store r13 r1 -14 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd013b", -- movlo r13 r13 315
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300001b", -- rjmp 27
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820dfff4", -- load r0 r13 -12 [2]
X"8b000001", -- addi r0 r0 1
X"d2d0fff4", -- store r13 r0 -12 [2]
X"33000142", -- rjmp 322
X"33000114", -- rjmp 276 [L25] [L24]
X"8bff0010", -- addi r15 r15 16 [L23]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0148", -- subi r13 r13 328
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [main]
X"8bfffffe", -- addi r15 r15 -2 [L26]
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd0150", -- movlo r13 r13 336
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000025", -- rjmp 37
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b00015e", -- breq 350
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd015a", -- movlo r13 r13 346
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"330000a3", -- rjmp 163
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000164", -- rjmp 356
X"3300015e", -- rjmp 350
X"3300014a", -- rjmp 330 [L28] [L29]
X"cfce0000", -- move r12 r14 [L27]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0163", -- subi r13 r13 355
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
