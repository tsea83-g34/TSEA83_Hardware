library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        dm_ control_signal : in std_logic; -- Should write if true


  )