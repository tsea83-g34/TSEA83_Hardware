library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity KeyboardHW is
    Port ( 
          clk, rst: in  STD_LOGIC;    -- rst är tryckknappen i mitten under displayen
          PS2KeyboardCLK : in std_logic;
          PS2KeyboardData : in std_logic;
          seg: out  UNSIGNED(7 downto 0);
          an : out  UNSIGNED (3 downto 0)
          );
end KeyboardHW;

architecture Behavioral of KeyboardHW is

  component leddriver
    Port ( 
           clk,rst : in  STD_LOGIC;
           seg : out  UNSIGNED(7 downto 0);
           an : out  UNSIGNED (3 downto 0);
           value : in  UNSIGNED (15 downto 0)
          );
  end component;

  component keyboard_decoder
  port(
    clk : in std_logic;
    rst : in std_logic;
    PS2KeyboardCLK : in std_logic;
    PS2KeyboardData : in std_logic;
    read_signal : in std_logic;
    we : out std_logic;
    out_register : out unsigned(31 downto 0)
  );
  end component;

  signal number : UNSIGNED(15 downto 0) := X"0000";  

  signal read_signal : std_logic;
  -- out
  signal we : std_logic;
  signal out_register : unsigned(31 downto 0);

begin

  led: leddriver port map (clk, rst, seg, an, number);

  keyboard_instance: keyboard_decoder port map(
    clk => clk,
    rst => rst,
    PS2KeyboardCLK => PS2KeyboardCLK,
    PS2KeyboardData => PS2KeyboardData,
    read_signal => read_signal,
    we => we,
    out_register => out_register
  );

  number <= out_register(15 downto 0);
  --number <= X"ABCD";  

end Behavioral;

