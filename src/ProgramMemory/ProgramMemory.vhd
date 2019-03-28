library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_memory_comp is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_control_signal : in unsigned(1 downto 0);

        pm_write : in std_logic;
        pm_write_data : in unsigned(31 downto 0);
        pm_write_address : in unsigned(#PROGRAM_MEMORY_SIZE downto 0); -- TODO: update when program memory size is decided

        pm_counter : buffer unsigned(#PROGRAM_MEMORY_SIZE downto 0); -- TODO: update when program memory size is decided
        pm_out : out unsigned(31 downto 0)
  );
end program_memory_comp;

