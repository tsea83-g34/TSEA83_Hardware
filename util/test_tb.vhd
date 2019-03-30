-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_tb is 
end test_tb;

architecture behavior of test_tb is 

  component test
    port(
      clk : in std_logic;
      A2 : in unsigned(31 downto 0);
      B2 : in unsigned(31 downto 0);
      D3 : in unsigned(31 downto 0);
      D4 : in unsigned(31 downto 0);
      IMM1 : in unsigned(31 downto 0);
      control_signal : in unsigned(5 downto 0);
      ALU_a_out : out unsigned(31 downto 0);
      ALU_b_out : out unsigned(31 downto 0);
      AR_out : out unsigned(31 downto 0)
    );
  end component;

  signal clk : in std_logic;
  signal A2 : in unsigned(31 downto 0);
  signal B2 : in unsigned(31 downto 0);
  signal D3 : in unsigned(31 downto 0);
  signal D4 : in unsigned(31 downto 0);
  signal IMM1 : in unsigned(31 downto 0);
  signal control_signal : in unsigned(5 downto 0);
  signal ALU_a_out : out unsigned(31 downto 0);
  signal ALU_b_out : out unsigned(31 downto 0);
  signal AR_out : out unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: test port map(
    clk => clk,
    A2 => A2,
    B2 => B2,
    D3 => D3,
    D4 => D4,
    IMM1 => IMM1,
    control_signal => control_signal,
    ALU_a_out => ALU_a_out,
    ALU_b_out => ALU_b_out,
    AR_out => AR_out
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
