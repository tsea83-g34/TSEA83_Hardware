library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipeline is
  port (clk : in std_logic;
        rst : in std_logic;

        IR1 : buffer unsigned(31 downto 0);
        IR2 : buffer unsigned(31 downto 0);
        IR3 : buffer unsigned(31 downto 0);
        IR4 : buffer unsigned(31 downto 0)
  );
end pipeline;
