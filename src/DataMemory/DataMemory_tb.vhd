-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity DataMemory_tb is 
end DataMemory_tb;

architecture behavior of DataMemory_tb is 

  component data_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      address : in unsigned(15 downto 0);
      write_or_read : in std_logic;
      address_mode : in byte_mode;
      read_data : out unsigned(31 downto 0);
      write_data : in unsigned(31 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal address : unsigned(15 downto 0);
  signal write_or_read : std_logic;
  signal address_mode : byte_mode;
  signal read_data : unsigned(31 downto 0);
  signal write_data : unsigned(31 downto 0);

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: data_memory port map(
    clk => clk,
    rst => rst,
    address => address,
    write_or_read => write_or_read,
    address_mode => address_mode,
    read_data => read_data,
    write_data => write_data
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
  
    address <= x"00_00";
    write_or_read  <= '0';
    address_mode <= WORD;
    write_data  <= x"00_00_00_00";
    
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
        -- Word
        report "Case 1";
        
    address <= x"00_00";
    write_or_read  <= '1';
    address_mode <= WORD;
    write_data  <= x"01010101";
    
    wait until rising_edge(clk);
    write_or_read <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"01_01_01_01"
    )
    report "Failed 'Read write (WORD)'. Expected '01010101', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
        -- Half
        report "Case 2";
        
    address <= x"00_04";
    write_or_read  <= '1';
    address_mode <= HALF;
    write_data  <= x"02_02_02_02";
    
    wait until rising_edge(clk);
    write_or_read <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00_02_02"
    )
    report "Failed (Read write (HALF)). Expected '00_00_00_02', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
        -- Byte
        report "Case 3";
        
    address <= x"00_06";
    write_or_read  <= '1';
    address_mode <= BYTE;
    write_data  <= x"03_03_03_03";
    
    wait until rising_edge(clk);
    write_or_read <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00_00_03"
    )
    report "Failed (Read write (BYTE)). Expected '00_00_00_03', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    -- ============ Read write (write not enabled) ============
        -- Word
        report "Case 4";
        
    address <= x"00_08";
    write_or_read  <= '0';
    address_mode <= WORD;
    write_data  <= x"04_04_04_04";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00000000"
    )
    report "Failed 'Read write (WORD)'. Expected '0', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
        -- Half
        report "Case 5";
        
    address <= x"00_0C";
    write_or_read  <= '0';
    address_mode <= HALF;
    write_data  <= x"05_05_05_05";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00_00_00"
    )
    report "Failed (Read write (HALF)). Expected '0', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
        -- Byte
        report "Case 6";
        
    address <= x"00_0E";
    write_or_read  <= '0';
    address_mode <= BYTE;
    write_data  <= x"06_06_06_06";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00_00_00"
    )
    report "Failed (Read write (BYTE)). Expected '0', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;

        
    -- ============ Write non aligned ============
        -- Word
        report "Case 10 (after removed simultaneous read/write cases)";
        
    address <= x"01_01"; -- WRITE
    write_or_read  <= '1';
    address_mode <= WORD;
    write_data  <= x"10_10_10_10";
    
    wait until rising_edge(clk);
    write_or_read <= '0';    
    address <= x"01_00"; -- READ
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"10_10_10_10"
    )
    report "Failed (Write non aligned (WORD)). Expected '10_10_10_10', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
        -- Half            
        report "Case 11 (after removed simultaneous read/write cases)";
        
    address <= x"01_07"; -- WRITE
    write_or_read  <= '1';
    address_mode <= HALF;
    address_mode <= HALF;
    write_data  <= x"11_11_11_11";
    
    wait until rising_edge(clk);
    write_or_read <= '0'; 
    address <= x"01_06"; -- READ
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        read_data = x"00_00_11_11"
    )
    report "Failed (Write non aligned (HALF)). Expected '00_00_11_11', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
        
    -- ============ Mixed write ============
        report "Case 12 (after removed simultaneous read/write cases)";
        
    address <= x"02_00";
    write_or_read  <= '1'; -- WRITE
    address_mode <= HALF;
    write_data  <= x"00_00_01_20";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    write_data  <= x"00_00_12_00";
    address <= x"02_02";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    address_mode <= BYTE;
    write_data  <= x"00_00_00_42";
    address <= x"02_01";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
  
    addres_mode <= WORD;
    write_or_read <= '0'; -- READ
     
    wait until rising_edge(clk);
    wait until rising_edge(clk);  
    
    assert (
        read_data = x"12_00_42_20"
    )
    report "Failed (Mixed write). Expected '12_00_42_20', got '" & integer'image(to_integer(read_data)) & "'."
    severity error;
    
    -- ============ Reset ============
    
    report "All tests run";

    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
