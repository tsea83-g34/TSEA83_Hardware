library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity KeyboardDecoder_tb is 
end KeyboardDecoder_tb;

architecture behavior of KeyboardDecoder_tb is 

  component KeyboardDecoder
    port(
      clk : in std_logic;
      rst : in std_logic;
      PS2KeyboardCLK : in std_logic;
      PS2KeyboardData : in std_logic;
      read_signal : in std_logic;
      out_register : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal PS2KeyboardCLK : std_logic;
  signal PS2KeyboardData : std_logic;
  signal read_signal : std_logic;
  signal out_register : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  constant A_KEY: unsigned(7 downto 0) := x"1C";
  constant OUT_PADDING : unsigned(10 downto 0) := "00000000000";
  
begin

  -- Component Instantiation
  uut: KeyboardDecoder port map(
    clk => clk,
    rst => rst,
    PS2KeyboardCLK => PS2KeyboardCLK,
    PS2KeyboardData => PS2KeyboardData,
    read_signal => read_signal,
    out_register => out_register
  );

  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
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
      out_register <= OUT_PADDING & A_KEY & "11000" & X"41" -- A key has key_value='1'
    )
    report "Failed (Type A key) "
    severity error;
    -------  END ---------

    read_control_signal <= KB_READ; -- Polls an old value
    wait until rising_edge(clk);
    wait until rising_edge(clk);
      
    assert (
      out_register <= OUT_PADDING & A_KEY & "01000" & X"41" -- A key has key_value='1'
    )
    report "Failed 'is_new' test "
    severity error;

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
