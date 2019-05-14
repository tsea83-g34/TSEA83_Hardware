library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
  X"8b110001", -- addi r1 r1 1
  X"8b220002", -- addi r2 r2 2
  X"8b330003", -- addi r3 r3 3
  X"d3330000", -- store r3 r3 0 [4]
  X"83530000", -- load r5 r3 0 [4]
  X"8b550001", -- addi r5 r5 1 [ADD_r5]
  X"e3050005", -- cmpi r5 5
  X"1f00fffe", -- brne ADD_r5
  X"8baafedc", -- addi r10 r10 0xfedc
  X"d00a000a", -- store r0 r10 10 [1]
  X"80a0000a", -- load r10 r0 10 [1]
  X"f7dd000f", -- movlo r13 r13 15
  X"8bffffff", -- addi r15 r15 -1
  X"d3fd0000", -- store r15 r13 0
  X"3300000d", -- rjmp SUBROUTINE
  X"8b110001", -- addi r1 r1 1
  X"8b220002", -- addi r2 r2 2
  X"8b330003", -- addi r3 r3 3
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"03000000", -- nop
  X"83df0000", -- load r13 r15 0 [SUBROUTINE]
  X"8bff0001", -- addi r15 r15 1
  X"8fdd001e", -- subi r13 r13 30
  X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
