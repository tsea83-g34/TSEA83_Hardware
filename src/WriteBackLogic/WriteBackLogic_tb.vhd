
-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WriteBackLogic_tb is 
end WriteBackLogic_tb;

architecture behavior of WriteBackLogic_tb is 

  component write_back_logic
    port(
      clk : in std_logic;
      rst : in std_logic;
      alu_res : in unsigned(31 downto 0);
      dm_out : in unsigned(31 downto 0);
      keyboard_out : in unsigned(31 downto 0);
      write_back_control_signal : in unsigned(1 downto 0);

      alu_res_3 : out unsigned(31 downto 0);
      write_back_out_4 : out unsigned(31 downto 0)
    );
  end component;

  signal clk : in std_logic;
  signal rst : in std_logic;
  signal alu_res : in unsigned(31 downto 0);
  signal dm_out : in unsigned(31 downto 0);
  signal keyboard_out : in unsigned(31 downto 0);
  signal write_back_control_signal : in unsigned(1 downto 0);
  signal alu_res_3 : out unsigned(31 downto 0);
  signal write_back_out_4 : out unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: write_back_logic port map(
    clk => clk,
    rst => rst,
    alu_res => alu_res,
    dm_out => dm_out,
    keyboard_out => keyboard_out,
    write_back_control_signal => write_back_control_signal,
    alu_res_3 => alu_res_3,
    write_back_out_4 => write_back_out_4
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

    -- Test tetst bench
    alu_res <= X"0000_1000";
    dm_out <= X"0000_0010";
    keyboard_out <= X"0000_0001";

    write_back_control_signal <= "00";
    
    tb_running <= false;           
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    wait;

  end process;
      
end;
