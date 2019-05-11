library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity WriteBackLogic_tb is 
end WriteBackLogic_tb;

architecture behavior of WriteBackLogic_tb is 

  component WriteBackLogic
    port(
      clk : in std_logic;
      rst : in std_logic;
      alu_res : in unsigned(31 downto 0);
      dm_out : in unsigned(31 downto 0);
      keyboard_out : in unsigned(31 downto 0);
      wb3_in_or_alu3 : in wb3_in_or_alu3_enum;
      wb4_dm_or_alu4 : in wb4_dm_or_alu4_enum;
      write_back_out_3 : buffer unsigned(31 downto 0);
      write_back_out_4 : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal alu_res : unsigned(31 downto 0);
  signal dm_out : unsigned(31 downto 0);
  signal keyboard_out : unsigned(31 downto 0);
  signal wb3_in_or_alu3 : wb3_in_or_alu3_enum;
  signal wb4_dm_or_alu4 : wb4_dm_or_alu4_enum;
  signal write_back_out_3 : unsigned(31 downto 0);
  signal write_back_out_4 : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: WriteBackLogic port map(
    clk => clk,
    rst => rst,
    alu_res => alu_res,
    dm_out => dm_out,
    keyboard_out => keyboard_out,
    wb3_in_or_alu3 => wb3_in_or_alu3, 
    wb4_dm_or_alu4 => wb4_dm_or_alu4,
    write_back_out_3 => write_back_out_3,
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
    wait until rising_edge(clk);

    -- Test 1 out <= alu_res
    alu_res <= X"0000_1000";
    dm_out <= X"0000_0010";
    keyboard_out <= X"0000_0001";
    
    wb3_in_or_alu3 <= WB3_ALU3;
    wb4_dm_or_alu4 <= WB4_ALU4;
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    assert (
      (write_back_out_4 = X"0000_1000")
    )
    report "Failed test1: Expected '0000_0010 got '" & integer'image(to_integer(write_back_out_4)) & "'."
    severity error;
    
    wait until rising_edge(clk);

    
    -- Test 2 out <= keyboard_decoder
    
    wb3_in_or_alu3 <= WB3_IN;
    wb4_dm_or_alu4 <= WB4_ALU4;

    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    assert (
      (write_back_out_4 = X"0000_0001")
    )
    report "Failed test2: Expected '0000_0001 got '" & integer'image(to_integer(write_back_out_4)) & "'."
    severity error;
    
    wait until rising_edge(clk);
    
    --  Test 3 out <= dm_out

    wb3_in_or_alu3 <= WB3_ALU3;
    wb4_dm_or_alu4 <= WB4_DM;  
  
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      (write_back_out_4 = X"0000_0010")
    )
    report "Failed test3: Expected '0000_0010 got '" & integer'image(to_integer(write_back_out_4)) & "'."
    severity error;

    wait until rising_edge(clk);

    --  Test 4 out <= dm_out

    wb3_in_or_alu3 <= WB3_IN;
    wb4_dm_or_alu4 <= WB4_DM;

    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    assert (
      (write_back_out_4 = X"0000_0010")
    )
    report "Failed test4: Expected '0000_0010 got '" & integer'image(to_integer(write_back_out_4)) & "'."
    severity error;

    report "ALL TESTS PASS";
      
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
