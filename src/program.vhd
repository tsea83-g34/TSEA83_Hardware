library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
    --$PROGRAM
    X"8b11000a", -- addi r1 r1 10
    X"33000001", -- rjmp L1
    X"93111000", -- add r1 r1 r1
    X"cf210000", -- move r2 r1
    X"97111000", -- sub r1 r1 r1
    X"a3110000", -- dec r1 r1
    X"ef010000", -- rjmprg r1
    X"83010000", -- load r0 r1 0 [4]
    X"83010001", -- load r0 r1 1 [4]
    X"83010002", -- load r0 r1 2 [4]
    X"83010003", -- load r0 r1 3 [4]
    --$PROGRAM_END
    others => X"00000000"
);

end program_file;
