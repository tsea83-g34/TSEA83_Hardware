-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity VideoMemory_tb is 
end VideoMemory_tb;

architecture behavior of VideoMemory_tb is 

  component video_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      write_address : in unsigned(15 downto 0);
      write_data : in unsigned(15 downto 0);
      write_enable  : in vm_write_enable_enum;
      read_address : in unsigned(15 downto 0);
      char : out unsigned(7 downto 0);
      fg_color : out unsigned(7 downto 0);
      bg_color : out unsigned(7 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal write_address : unsigned(15 downto 0);
  signal write_data : unsigned(15 downto 0);
  signal write_enable : vm_write_enable_enum;
  signal read_address : unsigned(15 downto 0);
  signal char : unsigned(7 downto 0);
  signal fg_color : unsigned(7 downto 0);
  signal bg_color : unsigned(7 downto 0);

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
    char => char,
    fg_color => fg_color,
    bg_color => bg_color
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
    
    -- ============== Test setup ==============
    rst <= '1';
    wait until rising_edge(clk);
    rst <= '0';
    
    read_address <= x"00_00";
    write_enable  <= VM_WRITE;
    
    -- Chars
    write_address <= x"00_11";
    write_data  <= x"01_11";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    write_address <= x"00_12";
    write_data  <= x"10_21";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    write_address <= x"00_13";
    write_data  <= x"07_20";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    -- Palette
    write_address <= to_unsigned(PALETTE_START, 16);
    write_data  <= x"10_20";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    write_address <= to_unsigned(PALETTE_START + 1, 16);
    write_data  <= x"DE_AD";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    write_address <= to_unsigned(PALETTE_START + 2, 16);
    write_data  <= x"BE_EF";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    
    
    -- ============ Read write ============
        report "Case 1";
        
    read_address <= x"00_01";
    write_address <= x"00_01";
    write_enable <= VM_WRITE;
    write_data  <= x"0100";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        char     = x"01" and
        fg_color = x"10" and
        bg_color = x"20"
    )
    report "Failed 'Read write'. Expected '01', '10', '20', got '" & integer'image(to_integer(char)) & "', '" & integer'image(to_integer(fg_color)) & "', '" & integer'image(to_integer(bg_color)) & "'."
    severity error;
    
    wait until rising_edge(clk);
    
    -- ======= Read write (not enabled) =======
        report "Case 2";
        
    read_address <= x"00_02";
    write_address <= x"00_02";
    write_enable <= VM_NO_WRITE;
    write_data  <= x"02_02";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        char     = x"00" and
        fg_color = x"10" and
        bg_color = x"20"
    )
    report "Failed 'Read write (not enabled)'. Expected '00', '10', '20', got '" & integer'image(to_integer(char)) & "', '" & integer'image(to_integer(fg_color)) & "', '" & integer'image(to_integer(bg_color)) & "'."
    severity error;
    
    wait until rising_edge(clk);
    
    -- ========= Async Read write =========
        report "Case 3";
    
    wait for 3 ns;
    
    write_address <= x"00_03";
    write_enable  <= VM_WRITE;
    write_data  <= x"03_02";
    
    read_address <= x"00_01";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait for 1 ns;

    assert (
        char     = x"01" and
        fg_color = x"10" and
        bg_color = x"20"
    )
    report "Failed 'Async Read write (1)'. Expected '00', '10', '20', got '" & integer'image(to_integer(char)) & "', '" & integer'image(to_integer(fg_color)) & "', '" & integer'image(to_integer(bg_color)) & "'."
    severity error;
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait for 2 ns;
    
    read_address <= x"00_03";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait for 3 ns;
    
    assert (
        char     = x"03" and
        fg_color = x"10" and
        bg_color = x"EF"
    )
    report "Failed 'Async Read write (2)'. Expected '03', '10', 'EF', got '" & integer'image(to_integer(char)) & "', '" & integer'image(to_integer(fg_color)) & "', '" & integer'image(to_integer(bg_color)) & "'."
    severity error;
    
    -- ========= Done =========

    tb_running <= false;           
    wait;
  end process;
      
end;
