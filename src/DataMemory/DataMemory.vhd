library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        dm_ control_signal : in std_logic; -- Should write if true

        write_enable : in std_logic;
        address : in unsigned(15 downto 0);
        write_data : in unsigned(31 downto 0);
        read_data : out unsigned(31 downto 0);

        -- TODO: Own component for VGA Buffer / Palette?

  );
end data_memory;