library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
  port (
        clk : in std_logic;
        rst : in std_logic;

        IR1 : in unsigned(31 downto 0);
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);

        pm_control_signal : out unsigned(1 downto 0);
        pipe_control_signal : out unsigned(1 downto 0);
        alu_control_signal : out unsigned(3 downto 0);
        dataforwarding_control_signal : out unsigned(1 downto 0);
  );
end control_unit;


