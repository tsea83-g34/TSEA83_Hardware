library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package data_file is
  
  constant data0 : data_chunk_array := (
--$DATA1
--$DATA1_END
others => X"00"
);
  constant data1 : data_chunk_array := (
--$DATA2
--$DATA2_END
others => X"00"
);

  constant data2 : data_chunk_array := (
--$DATA3
--$DATA3_END
others => X"00"
);

  constant data3 : data_chunk_array := (
--$DATA4
--$DATA4_END
others => X"00"
);
  
end data_file;
