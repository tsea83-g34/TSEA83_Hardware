-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataForwarding_tb is 
end DataForwarding_tb;

architecture behavior of DataForwarding_tb is 

  component DataForwarding
    port(
      clk : in std_logic;
			rst : in std_logic;
      A2 : in unsigned(31 downto 0);
      B2 : in unsigned(31 downto 0);
      D3 : in unsigned(31 downto 0);
      D4 : in unsigned(31 downto 0);
      IMM2 : in unsigned(31 downto 0);
      control_signal : in unsigned(5 downto 0);
      ALU_a_out : out unsigned(31 downto 0);
      ALU_b_out : out unsigned(31 downto 0);
      AR3_out : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
	signal rst : std_logic;
  signal A2 : unsigned(31 downto 0);
  signal B2 : unsigned(31 downto 0);
  signal D3 : unsigned(31 downto 0);
  signal D4 : unsigned(31 downto 0);
  signal IMM2 : unsigned(31 downto 0);
  signal control_signal : unsigned(5 downto 0);
  signal ALU_a_out : unsigned(31 downto 0);
  signal ALU_b_out : unsigned(31 downto 0);
  signal AR3_out : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: DataForwarding port map(
    clk => clk,
		rst => rst,
    A2 => A2,
    B2 => B2,
    D3 => D3,
    D4 => D4,
    IMM2 => IMM2,
    control_signal => control_signal,
    ALU_a_out => ALU_a_out,
    ALU_b_out => ALU_b_out,
    AR3_out => AR3_out
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

    A2 <= X"1000_0000";
    B2 <= X"2000_0000";
		IMM2 <= X"0000_0000";
    control_signal <= "000000";

    wait until rising_edge(clk);
    assert (
      (ALU_a_out = X"1000_0000") and (ALU_b_out = X"2000_0000")
    )
    report "Failed (Basic A, B test) . Expected output: A: 1..., B: 2...."
    severity error;

		wait until rising_edge(clk);
    
    D3 <= X"0000_0003";
		IMM2 <= X"0000_0001";
    control_signal <= "100001";

    wait until rising_edge(clk);
		wait until rising_edge(clk);
    
		assert (
      AR3_out = X"0000_0004"
    )
    report "Failed (D3 -> AR3) . Expected output: 4"
    severity error;
		
		wait until rising_edge(clk);

    D4 <= X"0000_0004";
    IMM2 <= X"0000_0005";
    control_signal <= "110011";

    wait until rising_edge(clk);

    assert (
      (ALU_a_out = X"0000_0004") and (ALU_b_out = X"0000_0005") 
    )
    report "Failed (D4 -> ALU_a, IMM2 -> ALU_b) . Expected output: 4, 5"
    severity error;

    wait until rising_edge(clk);

    assert (3 = 1 + 1) report "Assertion test: Should fail" severity error;
    


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
