library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"8b111111", -- addi r1 r1 4369
X"8beeeeee", -- addi r14 r14 61166
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"e7010000", -- out 0 r1 [L0]
X"03000000", -- nop
X"03000000", -- nop
X"f722f080", -- movlo r2 r2 61568
X"f32202fa", -- movhi r2 r2 762
X"a3220000", -- dec r2 r2 [L1]
X"df002000", -- cmp r0 r2
X"1f00fffe", -- brne L1
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"e70e0000", -- out 0 r14
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"03000000", -- nop
X"33000000", -- rjmp L2 [L2]
X"03000000", -- nop
X"03000000", -- nop
--$PROGRAM_END
others => X"00000000"
);

end program_file;
