library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"0f110000", -- in r1 1 [MAIN]
X"e7010000", -- out 0 r1
X"3300fffe", -- rjmp MAIN
--$PROGRAM_END
others => X"00000000"
);

end program_file;
