-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile_tb is 
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is 

  component register_file
    port(
      clk : in std_logic;
      rst : in std_logic;
      addr_a : in unsigned(3 downto 0);
      addr_b : in unsigned(3 downto 0);
      write_d : in std_logic;
      addr_d : in unsigned(3 downto 0);
      data_d : in unsigned(31 downto 0);
      out_a : out unsigned(31 downto 0);
      out_b : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal addr_a : unsigned(3 downto 0);
  signal addr_b : unsigned(3 downto 0);
  signal write_d : std_logic;
  signal addr_d : unsigned(3 downto 0);
  signal data_d : unsigned(31 downto 0);
  signal out_a : unsigned(31 downto 0);
  signal out_b : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: register_file port map(
    clk => clk,
    rst => rst,
    addr_a => addr_a,
    addr_b => addr_b,
    write_d => write_d,
    addr_d => addr_d,
    data_d => data_d,
    out_a => out_a,
    out_b => out_b
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

    write_d <= '1';
    data_d <= X"0000_0001";
    addr_d <= "0001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    addr_a <= "0001";

    -- Have to wait TWO clock cycles, because this process
    -- AND the components process has to tick before the output
    -- of the component is registered
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      out_a = X"0000_0001"
    )
    report "Failed (Simple Write). Expected output: 1"
    severity error;
    -------  END ---------

    data_d <= X"0000_0002";
    addr_d <= "0001";
    addr_a <= "0001";

    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      out_a = X"0000_0002"
    )
    report "SHOULD FAIL (Write and Fetch Same Cycle)"
    severity error;

    data_d <= X"0000_0003";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    data_d <= X"0000_0004";
    addr_d <= "0010";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    addr_a <= "0001";
    addr_b <= "0010";

    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      (out_a = X"0000_0003") and (out_b = X"0000_0004")
    )
    report "Failed (Fetch A and B same Cycle). Expected output: a = 3, b = 4"
    severity error;



    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
