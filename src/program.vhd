library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"f30e0004", -- movhi r0 r14 4
X"f70000b0", -- movlo r0 r0 176
X"f72e0010", -- movlo r2 r14 16
X"f3220029", -- movhi r2 r2 41
X"eb120000", -- vgaw r1 r2 0
X"f322002a", -- movhi r2 r2 42
X"eb120001", -- vgaw r1 r2 1
X"f322ffff", -- movhi r2 r2 -1
X"f722ffff", -- movlo r2 r2 -1
X"eb020000", -- vgaw r0 r2 0
X"f32e0000", -- movhi r2 r14 0
X"eb020001", -- vgaw r0 r2 1
--$PROGRAM_END
others => X"00000000"
);

end program_file;
