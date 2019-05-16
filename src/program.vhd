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
X"33000015", -- rjmp main
X"8fff0002", -- subi r15 r15 2
X"33000000", -- rjmp __halt [__halt]
X"cfdf0000", -- move r13 r15 [f]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"d2d2fffe", -- store r13 r2 -2 [2]
X"e3020000", -- cmpi r2 0
X"1b000005", -- breq L0
X"8fff0002", -- subi r15 r15 2
X"8b0e0001", -- addi r0 r14 1
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L1
X"8bff0002", -- addi r15 r15 2 [L1] [L0]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0018", -- subi r13 r13 24
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [main]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"8b2e0002", -- addi r2 r14 2
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d2fffe", -- store r13 r2 -2 [2]
X"f7dd002d", -- movlo r13 r13 45
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffdb", -- rjmp f
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"821d0004", -- load r1 r13 4 [2]
X"93001000", -- add r0 r0 r1
X"8bff0004", -- addi r15 r15 4
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0038", -- subi r13 r13 56
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
