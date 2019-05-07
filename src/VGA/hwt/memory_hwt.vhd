-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type

library work;
use work.PIPECPU_STD.ALL;
use work.CHARS.ALL;

-- entity
entity memory_hwt is
  port (
        clk		 : in std_logic;
        rst    : in std_logic;
        
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic
       );
end memory_hwt;

architecture behavioural of memory_hwt is

  component vga_engine is
  port (
        clk		 : in std_logic;
        rst    : in std_logic;
        
        char	   : in  unsigned(7 downto 0);
        fg_color : in  unsigned(7 downto 0);
        bg_color : in  unsigned(7 downto 0);
        addr	   : out unsigned(15 downto 0);
        
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic
       );
  end component;
  
  component video_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        -- User port
        write_address : in unsigned(15 downto 0);
        write_data    : in unsigned(15 downto 0);
        write_enable  : in std_logic; -- Should write if true

        -- VGA engine port
        read_address : in  unsigned(15 downto 0);
        char         : out unsigned(7 downto 0);
        fg_color     : out unsigned(7 downto 0);
        bg_color     : out unsigned(7 downto 0)
       );
  end component;
  
  -- Intermediate signals
  signal address_s  : unsigned(15 downto 0);
  signal char_s     : unsigned(7  downto 0);
  signal fg_color_s : unsigned(7  downto 0);
  signal bg_color_s : unsigned(7  downto 0);
  
  -- Loose signals
  signal write_address_s : unsigned(15 downto 0);
  signal write_data_s    : unsigned(15 downto 0);
  signal write_enable_s  : std_logic;
  
  -- Local signals
  signal counter : integer;
  signal running : std_logic := '1';
  
begin
  
  -- VGA engine component connection
  U0 : vga_engine port map(clk => clk, rst => rst, char => char_s, fg_color => fg_color_s, bg_color => bg_color_s, addr => address_s, vga_r => vga_r, vga_g => vga_g, vga_b => vga_b, h_sync => h_sync, v_sync => v_sync);
  
  -- VGA engine component connection
  U1 : video_memory port map(clk => clk, rst => rst, write_address => write_address_s, write_data => write_data_s, write_enable => write_enable_s, read_address => address_s, char => char_s, fg_color => fg_color_s, bg_color => bg_color_s);
  
  -- Update write address
  process(clk) begin
    if rising_edge(clk) then
    
      if running = '1' then
        
        write_address_s <= to_unsigned(counter, 16);
        
      end if;
    end if;
  end process;
  
  -- Fill memory
  process(clk) begin
    if rising_edge(clk) then
    
      if running = '1' then
        
        -- Write all characters in sequence to the memory
        if counter < NUMBER_OF_CHARS then
          
          write_data_s   <= to_unsigned(counter, 8) & x"FF";
          write_enable_s <= '1';
        
        -- Set first palette colors to white and black
        elsif counter = PALETTE_START then
        
          write_data_s   <= x"FF" & x"00";
          write_enable_s <= '1';
        
        else
          
          write_data_s   <= x"0000";
          write_enable_s <= '1';
        
        end if;
      else
         
        write_data_s   <= x"0000";
        write_enable_s <= '0';
         
      end if;
    end if;
  end process;
  
  -- Update counter
  process(clk) begin
    if rising_edge(clk) then
    
      if running = '1' then
        
        if counter >= VIDEO_MEM_SIZE then
          running <= '0';
        end if;
      
        counter <= counter + 1;
        
      end if;
    end if;
  end process;
  
end architecture;


























