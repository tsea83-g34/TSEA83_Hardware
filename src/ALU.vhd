library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (clk : in std_logic;
          rst : in std_logic;
          alu_control_signal : in unsigned(3 downto 0);
          alu_a : in unsigned(31 downto 0);
          alu_b : in unsigned(31 downto 0);

          alu_d : out unsigned(31 downto 0);

          alu_flags : buffer unsigned(3 downto 0)
    );
end ALU;
