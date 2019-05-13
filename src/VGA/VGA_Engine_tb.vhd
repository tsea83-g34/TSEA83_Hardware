library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Engine_tb is 
end VGA_Engine_tb;

architecture behavior of VGA_Engine_tb is 

  component VGA_Engine
    port(
      clk : in std_logic;
      rst : in std_logic;
      char : in unsigned(7 downto 0);
      fg_color : in unsigned(7 downto 0);
      bg_color : in unsigned(7 downto 0);
      addr : out unsigned(15 downto 0);
      vga_r : out std_logic_vector(2 downto 0);
      vga_g : out std_logic_vector(2 downto 0);
      vga_b : out std_logic_vector(2 downto 1);
      h_sync : out std_logic;
      v_sync : out std_logic
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal char : unsigned(7 downto 0);
  signal fg_color : unsigned(7 downto 0);
  signal bg_color : unsigned(7 downto 0);
  signal addr : unsigned(15 downto 0);
  signal vga_r : std_logic_vector(2 downto 0);
  signal vga_g : std_logic_vector(2 downto 0);
  signal vga_b : std_logic_vector(2 downto 1);
  signal h_sync : std_logic;
  signal v_sync : std_logic;

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: VGA_Engine port map(
    clk => clk,
    rst => rst,
    char => char,
    fg_color => fg_color,
    bg_color => bg_color,
    addr => addr,
    vga_r => vga_r,
    vga_g => vga_g,
    vga_b => vga_b,
    h_sync => h_sync,
    v_sync => v_sync
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
    char <= x"00";
    fg_color <= x"00";
    bg_color <= x"00";
    
    -- ============ Addressing ============    
        report "Case 1";

    wait until rising_edge(clk);        -- Offset
    
    assert (
        addr = x"00_00"
    )
    report "Failed 'Addressing (1)'. Expected '0000', got '" & integer'image(to_integer(addr)) & "'."
    severity error;
    
    wait for 40 * 16 ns;
    
    assert (
        addr = x"00_01"
    )
    report "Failed 'Addressing (2)'. Expected '0001', got '" & integer'image(to_integer(addr)) & "'."
    severity error;
    
    wait for 40 * 16 ns;
    
    assert (
        addr = x"00_02"
    )
    report "Failed 'Addressing (3)'. Expected '0002', got '" & integer'image(to_integer(addr)) & "'."
    severity error;
    
    wait for 10000 ns;    -- Maunual check
    
    -- ============ Basic output ============
        report "Case 2";
        
    char <= x"00";
    fg_color <= b"100_010_01";
    bg_color <= b"110_101_11";
    
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
        vga_r = "110" and vga_g = "101" and vga_b = "11"
    )
    report "Failed 'Basic output'. Expected '110', '101', '11', got '" & integer'image(to_integer(unsigned(vga_r))) & "', '" & integer'image(to_integer(unsigned(vga_g))) & "', '" & integer'image(to_integer(unsigned(vga_b))) & "'."
    severity error;

    wait for 1 us;
    
    --tb_running <= false;           
    wait;
  end process;
      
end;
