-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PipeCPU_tb is 
end PipeCPU_tb;

architecture behavior of PipeCPU_tb is 

  component PipeCPU
    port(
      clk : in std_logic;
      rst : in std_logic;
      PS2KeyboardCLK : in std_logic;
      PS2KeyboardData : in std_logic;
      vga_r : out std_logic_vector(2 downto 0);
      vga_g : out std_logic_vector(2 downto 0);
      vga_b : out std_logic_vector(2 downto 1);
      h_sync : out std_logic;
      v_sync : out std_logic
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal PS2KeyboardCLK : std_logic;
  signal PS2KeyboardData : std_logic;
  signal vga_r : std_logic_vector(2 downto 0);
  signal vga_g : std_logic_vector(2 downto 0);
  signal vga_b : std_logic_vector(2 downto 1);
  signal h_sync : std_logic;
  signal v_sync : std_logic;

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: PipeCPU port map(
    clk => clk,
    rst => rst,
    PS2KeyboardCLK => PS2KeyboardCLK,
    PS2KeyboardData => PS2KeyboardData,
    vga_r => vga_r,
    vga_g => vga_g,
    vga_b => vga_b,
    h_sync => h_sync,
    v_sync => v_sync
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

    -- Assign your inputs: A2 <= X"0000_0001";


    -- Have to wait TWO clock cycles, because this process
    -- AND the components process has to tick before the output
    -- of the component is registered
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      2 = 1 + 1 -- Check that: {actual output} = {expected output}, for example: (a_out = '1') and (b_out = '0') 
    )
    report "Failed (Addition test). Expected output: 2"
    severity error;
    -------  END ---------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
