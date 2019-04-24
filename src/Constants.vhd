library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package PIPECPU_STD is
  
  type byte_mode is (WORD, HALF, BYTE);

  constant PROGRAM_MEMORY_SIZE: INTEGER := 4096;
  constant PROGRAM_MEMORY_ADDRESS_BITS: INTEGER := 16;
  constant PROGRAM_MEMORY_BIT_SIZE: INTEGER := 32;

  constant DATA_MEM_BIT_SIZE: INTEGER := 8;
  
  constant PALETTE_SIZE  : INTEGER := 32 / 2;                  -- 32 byte in 2 byte chunks
  
  constant VIDEO_MEM_SIZE: INTEGER := 2400 / 2 + PALETTE_SIZE; -- 2400 bytes in 2 byte chunks
  
  constant PALETTE_START : INTEGER := VIDEO_MEM_SIZE - PALETTE_SIZE;

end PIPECPU_STD;
