-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VideoMemory_tb is 
end VideoMemory_tb;

architecture behavior of VideoMemory_tb is 

  component video_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      write_address : in unsigned(15 downto 0);
      write_data : in unsigned(15 downto 0);
      write_enable : in std_logic;
      read_address : in unsigned(15 downto 0);
      read_data : out unsigned(15 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal write_address : unsigned(15 downto 0);
  signal write_data : unsigned(15 downto 0);
  signal write_enable : std_logic;
  signal read_address : unsigned(15 downto 0);
  signal read_data : unsigned(15 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: video_memory port map(
    clk => clk,
    rst => rst,
    write_address => write_address,
    write_data => write_data,
    write_enable => write_enable,
    read_address => read_address,
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

    
    
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
