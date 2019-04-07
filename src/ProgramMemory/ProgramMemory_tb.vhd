-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.PIPECPU_STD.ALL;

entity ProgramMemory_tb is 
end ProgramMemory_tb;

architecture behavior of ProgramMemory_tb is 

  component program_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      pm_control_signal : in unsigned(1 downto 0);
      pm_write : in std_logic;
      pm_write_data : in unsigned(31 downto 0);
      pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 0);
      pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 0);
      pm_out : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal pm_control_signal : unsigned(1 downto 0);
  signal pm_write : std_logic;
  signal pm_write_data : unsigned(31 downto 0);
  signal pm_write_address : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 0);
  signal pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 0);
  signal pm_out : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: program_memory port map(
    clk => clk,
    rst => rst,
    pm_control_signal => pm_control_signal,
    pm_write => pm_write,
    pm_write_data => pm_write_data,
    pm_write_address => pm_write_address,
    pm_counter => pm_counter,
    pm_out => pm_out
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
