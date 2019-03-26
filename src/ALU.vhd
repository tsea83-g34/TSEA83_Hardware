library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port (clk : in std_logic;
          rst : in std_logic;
          alu_control_signal : in unsigned(3 downto 0);
          alu_a : in unsigned(31 downto 0);
          alu_b : in unsigned(31 downto 0);

          alu_d : out unsigned(31 downto 0);

          alu_flags : buffer unsigned(3 downto 0)
    );
end alu;

architecture Behavioral of alu is
  alias z_flag : unsigned is alu_flags(3);
  alias n_flag : unsigned is alu_flags(2);
  alias o_flag : unsigned is alu_flags(1);
  alias c_flag : unsigned is alu_flags(0);
begin
  -- ALU computation
  if alu_control_signal == "0000" then --ADD
    alu_d <= alu_a + alu_b;
  elsif alu_control_signal == "0001" then --ADD with carry
    alu_d <= alu_a + alu_b + unsigned(c_flag"000"); -- Probably doesn't work
  end if;
  
end architecture;
