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

    rst <= '1';
    wait until rising_edge(clk);
    rst <= '0';
  
    read_address <= x"00_00";
    write_address <= x"00_00";
    write_enable  <= '0';
    write_data  <= x"00_00";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        2 = 1 + 1
    )
    report "Failed (TEST). Expected '2', got '" -- & integer'image(to_integer(write_data)) & "'."
    severity error;
    -------  END ---------
    
    
    -- ============ Read write ============
        report "Case 1";
        
    read_address <= x"00_00";
    write_address <= x"00_00";
    write_enable  <= '1';
    write_data  <= x"0101";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"01_01"
    )
    report "Failed 'Read write'. Expected '0101', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    -- ======= Read write (not enabled) =======
        report "Case 2";
        
    read_address <= x"00_01";
    write_address <= x"00_01";
    write_enable  <= '0';
    write_data  <= x"0101";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00"
    )
    report "Failed 'Read write (not enabled)'. Expected '0000', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    -- ========= Async Read write =========
        report "Case 3";
        
    write_address <= x"00_03";
    write_enable  <= '1';
    write_data  <= x"03_03";
    
    wait for 3 ns;
    
    read_address <= x"00_00";
    
    wait until rising_edge(clk);
    wait for 3 ns;
    
    read_address <= x"00_03";
    
    wait for 6 ns;

    assert (
        read_data = x"01_01"
    )
    report "Failed 'Read write Async (1)'. Expected '0101', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    assert (
        read_data = x"03_03"
    )
    report "Failed 'Read write Async (2)'. Expected '0303', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
