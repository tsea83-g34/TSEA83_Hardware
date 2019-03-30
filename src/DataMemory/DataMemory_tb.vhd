
-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory_tb is 
end DataMemory_tb;

architecture behavior of DataMemory_tb is 

  component data_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      dm_ control_signal : in std_logic;
      write_enable : in std_logic;
      address : in unsigned(15 downto 0);
      write_data : in unsigned(31 downto 0);
      read_data : out unsigned(31 downto 0)
    );
  end component;

  signal clk : in std_logic;
  signal rst : in std_logic;
  signal dm_ control_signal : in std_logic;
  signal write_enable : in std_logic;
  signal address : in unsigned(15 downto 0);
  signal write_data : in unsigned(31 downto 0);
  signal read_data : out unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: data_memory port map(
    clk => clk,
    rst => rst,
    dm_ control_signal => dm_ control_signal,
    write_enable => write_enable,
    address => address,
    write_data => write_data,
    read_data => read_data
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
  
    -- Insert test here, and add more if you want 
    wait until rising_edge(clk);
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
