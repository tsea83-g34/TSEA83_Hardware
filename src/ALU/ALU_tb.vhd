-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is 
end ALU_tb;

architecture behavior of ALU_tb is 

  component alu
    port(
      clk : in std_logic;
      rst : in std_logic;
      alu_control_signal : in unsigned(6 downto 0);
      alu_a : in unsigned(31 downto 0);
      alu_b : in unsigned(31 downto 0);
      alu_res : out unsigned(31 downto 0);
      Z_flag, N_flag, O_flag, C_flag : buffer std_logic
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal alu_control_signal : unsigned(6 downto 0);
  signal alu_a : unsigned(31 downto 0);
  signal alu_b : unsigned(31 downto 0);
  signal alu_res : unsigned(31 downto 0);
  signal Z_flag, N_flag, O_flag, C_flag : std_logic;

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: alu port map(
    clk => clk,
    rst => rst,
    alu_control_signal => alu_control_signal,
    alu_a => alu_a,
    alu_b => alu_b,
    alu_res => alu_res,
    Z_flag => Z_flag,
    N_flag => N_flag,
    O_flag => O_flag,
    C_flag => C_flag
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

    
    alu_control_signal <= "0000001";
    alu_a <= X"0000_0006";
    alu_b <= X"FFFF_FFFC";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0002"
    )
    report "Failed (Add without carry (0001)). Expected output: 6+(-4) = 2"
    severity error;


    -- control signal is 8 bits in alu.vhd
    alu_control_signal <= "0001000"; -- Left shift
    alu_a <= X"0000_0002";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0004"
    )
    report "Failed (Left shift). Expected output: 4"
    severity error;


    alu_control_signal <= "0000110"; -- Multiply signed
    alu_a <= X"0000_0003";
    alu_b <= X"0000_0004";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_000C"
    )
    report "Failed (Multiply signed (0110)). Expected output: 3*4 = 12"
    severity error;



    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
