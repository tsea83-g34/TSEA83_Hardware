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
      pm_offset : in unsigned(15 downto 0);
      pm_write_data : in unsigned(31 downto 0);
      pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_out : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal pm_control_signal : unsigned(1 downto 0);
  signal pm_offset : unsigned(15 downto 0);
  signal pm_write_data : unsigned(31 downto 0);
  signal pm_write_address : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pm_out : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: program_memory port map(
    clk => clk,
    rst => rst,
    pm_control_signal => pm_control_signal,
    pm_offset => pm_offset,
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

    pm_control_signal <= "10";
    pm_write_data <= X"0000_0002";
    pm_write_address <= X"001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      pm_counter = X"001"
    )
    report "Failed (Counter tracking). Expected output: 1"
    severity error;
    -------  END ---------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
