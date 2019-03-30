
-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit_tb is 
end ControlUnit_tb;

architecture behavior of ControlUnit_tb is 

  component control_unit
    port(
      clk : in std_logic;
      rst : in std_logic;
      IR1 : in unsigned(31 downto 0);
      IR2 : in unsigned(31 downto 0);
      IR3 : in unsigned(31 downto 0);
      IR4 : in unsigned(31 downto 0);
      pm_control_signal : out unsigned(1 downto 0);
      pipe_control_signal : out unsigned(1 downto 0);
      alu_control_signal : out unsigned(3 downto 0);
      dataforwarding_control_signal : out unsigned(1 downto 0);
      dm_control_signal : out std_logic
    );
  end component;

  signal clk : in std_logic;
  signal rst : in std_logic;
  signal IR1 : in unsigned(31 downto 0);
  signal IR2 : in unsigned(31 downto 0);
  signal IR3 : in unsigned(31 downto 0);
  signal IR4 : in unsigned(31 downto 0);
  signal pm_control_signal : out unsigned(1 downto 0);
  signal pipe_control_signal : out unsigned(1 downto 0);
  signal alu_control_signal : out unsigned(3 downto 0);
  signal dataforwarding_control_signal : out unsigned(1 downto 0);
  signal dm_control_signal : out std_logic;

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: control_unit port map(
    clk => clk,
    rst => rst,
    IR1 => IR1,
    IR2 => IR2,
    IR3 => IR3,
    IR4 => IR4,
    pm_control_signal => pm_control_signal,
    pipe_control_signal => pipe_control_signal,
    alu_control_signal => alu_control_signal,
    dataforwarding_control_signal => dataforwarding_control_signal,
    dm_control_signal => dm_control_signal
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
