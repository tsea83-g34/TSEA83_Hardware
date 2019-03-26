library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
  port (clk : in std_logic;
       rst : in std_logic;

       addr_a : in unsigned(3 downto 0);
       addr_b : in unsigned(3 downto 0);

       write_d : in std_logic; -- Should write
       addr_d : in unsigned(3 downto 0);
       data_d : in unsigned(31 downto 0);

       out_a : out unsigned(31 downto 0);
       out_b : out unsigned(31 downto 0)
      );
end register_file;
