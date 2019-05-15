library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"8b111111", -- addi r1 r1 4369
X"8b222222", -- addi r2 r2 8738
X"8b333333", -- addi r3 r3 13107
X"8b444444", -- addi r4 r4 17476
X"8b555555", -- addi r5 r5 21845
X"8b666666", -- addi r6 r6 26214
X"8b777777", -- addi r7 r7 30583
X"8b888888", -- addi r8 r8 34952
X"8b999999", -- addi r9 r9 39321
X"8baaaaaa", -- addi r10 r10 43690
X"8bbbbbbb", -- addi r11 r11 48059
X"8bcccccc", -- addi r12 r12 52428
X"8bdddddd", -- addi r13 r13 56797
X"8beeeeee", -- addi r14 r14 61166
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"e7010000", -- out 0 r1
X"e7020000", -- out 0 r2
X"e7030000", -- out 0 r3
X"e7040000", -- out 0 r4
X"e7050000", -- out 0 r5
X"e7060000", -- out 0 r6
X"e7070000", -- out 0 r7
X"e7080000", -- out 0 r8
X"e7090000", -- out 0 r9
X"e70a0000", -- out 0 r10
X"e70b0000", -- out 0 r11
X"e70c0000", -- out 0 r12
X"e70d0000", -- out 0 r13
X"e70e0000", -- out 0 r14
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"33000000", -- rjmp 0
--$PROGRAM_END
others => X"00000000"
);

end program_file;
