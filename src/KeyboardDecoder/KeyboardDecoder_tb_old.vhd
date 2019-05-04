-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KeyboardDecoder_tb is 
end KeyboardDecoder_tb;

architecture behavior of KeyboardDecoder_tb is 

  component keyboard_decoder
    port(
      clk : in std_logic;
      rst : in std_logic;
      PS2KeyboardCLK : in std_logic;
      PS2KeyboardData : in std_logic;
      we : out std_logic;
      out_register : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal PS2KeyboardCLK : std_logic;
  signal PS2KeyboardData : std_logic;
  signal we : std_logic;
  signal out_register : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  constant A_KEY: unsigned(7 downto 0) := x"1C";
  constant OUT_PADDING : unsigned(19 downto 0) := "00000000000000000000";
  
begin

  -- Component Instantiation
  uut: keyboard_decoder port map(
    clk => clk,
    rst => rst,
    PS2KeyboardCLK => PS2KeyboardCLK,
    PS2KeyboardData => PS2KeyboardData,
    we => we,
    out_register => out_register
  );

  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 1 ns;
    end loop;
    wait;
  end process;

  

  process
  begin


    ------ Format of a test case -------
    wait until rising_edge(clk);

    -- Start bit 
    PS2KeyboardData <= '0';
    PS2KeyboardCLK <= '1';
    wait for 5 ns;
    PS2KeyboardCLK <= '0';
    wait for 5 ns;

    -- Type the A key
    for i in 0 to 7 loop
      PS2KeyboardData <= A_KEY(i);
      PS2KeyboardCLK <= '1';
      wait for 5 ns;
      PS2KeyboardCLK <= '0';
      wait for 5 ns;
    end loop;  -- i
    -- Parity bit
    PS2KeyboardData <= '0';
    PS2KeyboardCLK <= '1';
    wait for 5 ns;
    PS2KeyboardCLK <= '0';
    wait for 5 ns;
    -- Stop bit
    PS2KeyboardData <= '1';
    PS2KeyboardCLK <= '1';
    wait for 5 ns;
    PS2KeyboardCLK <= '0';
    wait for 5 ns;

    assert (
      out_register <= OUT_PADDING & "1100" & "00000001" -- A key has key_value='1'
    )
    report "Failed (Type A key) "
    severity error;
    -------  END ---------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
