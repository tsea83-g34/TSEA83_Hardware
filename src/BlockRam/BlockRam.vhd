library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity block_ram is
  port ( -- TODO: Solve generic size of vectors
         -- TODO: Perhaps need specific declaration of blockram for PM and DM since DM has unique writing due to unspecified data size
        clk : in std_logic;
        rst : in std_logic; -- Maybe not?

        -- port 1
        addr_1 : in unsigned(#PROGRAM_MEMORY_SIZE downto 0);
        write_enable_1 : in std_logic; 
        data_in_1 : in unsigned(31 downto 0);
        data_out_1 : out unsigned(31 downto 0);

        -- port 2
        addr_2 : in unsigned(#PROGRAM_MEMORY_SIZE downto 0);
        write_enable_2 : in std_logic; 
        data_in_2 : in unsigned(31 downto 0);
        data_out_2 : out unsigned(31 downto 0);
  );
end block_ram;