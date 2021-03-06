library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity RegisterFile_tb is 
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is 

  component RegisterFile
    port(
      clk : in std_logic;
      rst : in std_logic;
      read_addr_a : in unsigned(3 downto 0);
      read_addr_b : in unsigned(3 downto 0);
			read_addr_d : in unsigned(3 downto 0);
			read_d_or_b_control_signal : in rf_read_d_or_b_enum; -- 1 => read addr_d, 0 => read addr_b
      write_d_control_signal : in rf_write_d_enum;
      write_addr_d : in unsigned(3 downto 0);
      write_data_d : in unsigned(31 downto 0);
      out_A2 : out unsigned(31 downto 0);
      out_B2 : out unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal read_addr_a : unsigned(3 downto 0);
  signal read_addr_b : unsigned(3 downto 0);
	signal read_addr_d : unsigned(3 downto 0);
	signal read_d_or_b_control_signal : rf_read_d_or_b_enum; -- 1 => read addr_d, 0 => read addr_b
  signal write_d_control_signal : rf_write_d_enum;
  signal write_addr_d : unsigned(3 downto 0);
  signal write_data_d : unsigned(31 downto 0);
  signal out_A2 : unsigned(31 downto 0);
  signal out_B2 : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: RegisterFile port map(
    clk => clk,
    rst => rst,
    read_addr_a => read_addr_a,
    read_addr_b => read_addr_b,
		read_addr_d => read_addr_d,
		read_d_or_b_control_signal => read_d_or_b_control_signal,
    write_d_control_signal => write_d_control_signal,
    write_addr_d => write_addr_d,
    write_data_d => write_data_d,
    out_A2 => out_A2,
    out_B2 => out_B2
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

    write_d_control_signal <= RF_WRITE_D;
		read_d_or_b_control_signal <= RF_READ_B; -- Read addr_b
    write_data_d <= X"0000_0001";
    write_addr_d <= "0001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    read_addr_a <= "0001";

    -- Have to wait TWO clock cycles, because this process
    -- AND the components process has to tick before the output
    -- of the component is registered
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      out_A2 = X"0000_0001"
    )
    report "Failed (Simple Write). Expected output: 1"
    severity error;
    -------  END ---------

    write_data_d <= X"0000_0002";
    write_addr_d <= "0010";
    read_addr_b <= "0010";


    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      out_A2 = X"0000_0001" and out_B2 = X"0000_0002"
    )
    report "Write and Fetch Same Cycle, expected 0000_0001 and 0000_0002"
    severity error;
    wait until rising_edge(clk);

    assert (
      out_A2 = X"0000_0001" and out_B2 = X"0000_0002"
    ) report "Failed to write when fetching and writing in previous cycle"
    severity error;

    write_data_d <= X"0000_0003";
		write_addr_d <= "0001";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    write_data_d <= X"0000_0004";
    write_addr_d <= "0010";
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    read_addr_a <= "0001";
    read_addr_b <= "0010";

    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      (out_A2 = X"0000_0003") and (out_B2 = X"0000_0004")
    )
    report "Failed (Fetch A and B same Cycle). Expected output: a = 3, b = 4"
    severity error;

    write_addr_d <= "1000";
    write_data_d <= X"1111_1111";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    read_addr_a <= "1000";
    read_addr_b <= "1000";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    assert (
      (out_A2 = X"1111_1111") and out_B2 = X"1111_1111")
    report "Failed read from same register in same cycle"
    severity error;
     
    write_data_d <= X"0000_0000";
    write_d_control_signal <= RF_NO_WRITE_D;

    wait until rising_edge(clk);
    wait until rising_edge(clk);
    assert (
      (out_A2 = X"1111_1111") and out_B2 = X"1111_1111")
    report "Error: Wrote to register when write_d is disabled"
    severity error;

		read_d_or_b_control_signal <= RF_READ_D; -- read addr_d
		read_addr_d <= "0010";
		read_addr_a <= "0001";
		
		wait until rising_edge(clk);
    wait until rising_edge(clk);
    assert (
      (out_A2 = X"0000_0003") and out_B2 = X"0000_0004")
    report "Failed to read from addr_d instead of addr_b"
		severity error;

		read_d_or_b_control_signal <= RF_READ_B; -- read addr_b

		wait until rising_edge(clk);
    wait until rising_edge(clk);
    assert (
      (out_A2 = X"0000_0003") and out_B2 = X"1111_1111")
    report "Failed to read from addr_b instead of addr_d"
    severity error;



    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
