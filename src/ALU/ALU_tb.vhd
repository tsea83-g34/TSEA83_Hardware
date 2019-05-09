-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pipecpu_std.all;


entity ALU_tb is 
end ALU_tb;

architecture behavior of ALU_tb is 

  component alu
    port(
      clk : in std_logic;
      rst : in std_logic;
      update_flags_control_signal : in unsigned(0 downto 0);
      data_size_control_signal : in byte_mode;
      alu_op_control_signal : in unsigned(5 downto 0);
      alu_a : in unsigned(31 downto 0);
      alu_b : in unsigned(31 downto 0);
      alu_res : out unsigned(31 downto 0);
      Z_flag, N_flag, O_flag, C_flag : buffer std_logic
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal update_flags_control_signal : unsigned(0 downto 0);
  signal data_size_control_signal : byte_mode;
  signal alu_op_control_signal : unsigned(5 downto 0);
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
    update_flags_control_signal => update_flags_control_signal,
    data_size_control_signal => data_size_control_signal,
    alu_op_control_signal => alu_op_control_signal,
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
    
    update_flags_control_signal <= "1";
    
    alu_op_control_signal <= NOP; -- ZERO
    alu_a <= X"0000_0006";
    alu_b <= X"FFFF_FFFC";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0000"
    )
    report "Failed ZERO"
    severity error;
    
    alu_op_control_signal <= ADD;
    alu_a <= X"0000_0006";
    alu_b <= X"FFFF_FFFC";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0002"
    )
    report "Failed (Add without carry (0001)). Expected output: 6+(-4) = 2"
    severity error;



    alu_op_control_signal <= SUBB;
    alu_a <= X"0000_0006";
    alu_b <= X"0000_0004";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0002"
    )
    report "Failed SUB. Expected output: 6 - 4 = 2"
    severity error;


    alu_op_control_signal <= NEG;
    alu_a <= X"0000_0001";
    alu_b <= X"0000_0004";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"FFFF_FFFF"
    )
    report "Failed NEG"
    severity error;

    alu_op_control_signal <= INC;
    alu_a <= X"0000_0001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0002"
    )
    report "Failed INC test 1"
    severity error;
    
    alu_op_control_signal <= INC;
    alu_a <= X"FFFF_FFFF";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    assert (
      alu_res = X"0000_0000"
    )
    report "Failed INC test 2"
    severity error;
  
    alu_op_control_signal <= DEC;
    alu_a <= X"0000_0001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0000"
    )
    report "Failed DEC test 1"
    severity error;

    alu_op_control_signal <= DEC;
    alu_a <= X"0000_0000";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"FFFF_FFFF"
    )
    report "Failed DEC test 2"
    severity error;

    alu_op_control_signal <= MUL; -- Multiply signed
    alu_a <= X"0000_0003";
    alu_b <= X"0000_0004";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_000C"
    )
    report "Failed (Multiply signed (0110)). Expected output: 3*4 = 12"
    severity error;

    
    alu_op_control_signal <= MUL; -- Multiply signed
    alu_a <= X"0000_0003"; -- +3
    alu_b <= X"FFFF_FFFC"; -- -4
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"FFFF_FFF4" -- -12
    )
    report "Failed (Multiply signed). Expected output: 3*-4 = -12"
    severity error;


    -- control signal is 8 bits in alu.vhd
    alu_op_control_signal <= LSL; -- Left shift
    alu_a <= X"0000_0002";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0004"
    )
    report "Failed (Logical Left Shift). Expected output: 4"
    severity error;



    alu_op_control_signal <= LSR; -- Multiply signed
    alu_a <= X"0000_0002";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0001"
    )
    report "LSR"
    severity error;


    alu_op_control_signal <= ANDD; -- Multiply signed
    alu_a <= X"0000_0010";
    alu_b <= X"0000_0011";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0010"
    )
    report "ANDD"
    severity error;


    alu_op_control_signal <= ORR; -- Multiply signed
    alu_a <= X"0000_0010";
    alu_b <= X"0000_0011";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0011"
    )
    report "ORR"
    severity error;
  
  
    alu_op_control_signal <= XORR; -- Multiply signed
    alu_a <= X"0000_0110";
    alu_b <= X"0000_0011";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0101"
    )
    report "XORR"
    severity error;
  

    alu_op_control_signal <= NOTT; -- Multiply signed
    alu_a <= X"0000_0000";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"FFFF_FFFF"
    )
    report "NOTT"
    severity error;
  


    -- DONE !!!! -----
    alu_op_control_signal <= LSL; -- Left shift
    alu_a <= X"0000_0002";
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      alu_res = X"0000_0003"
    )
    report "Should fail: PASSED ALL TESTS!"
    severity error;

    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
