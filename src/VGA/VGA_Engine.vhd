-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type

library work;
use work.PIPECPU_STD.ALL;
use work.CHARS.ALL;

-- entity
entity VGA_Engine is
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
end VGA_Engine;

architecture Behavioral of VGA_Engine is

  signal x_pixel	  : unsigned(9 downto 0) := "0000000000"; -- Horizontal pixel counter
  signal y_pixel	  : unsigned(9 downto 0) := "0000000000"; -- Vertical pixel counter
  signal clk_div	  : unsigned(1 downto 0);		              -- Clock divisor, to generate 25 MHz signal
  signal clk_25     : std_logic;			                      -- One pulse width 25 MHz signal

  signal blank      : std_logic;                            -- blanking signal
  
  signal tile        : integer := 0;                           -- Current tile
  signal tile_x_offs : unsigned(CHAR_BIT_SIZE - 1 downto 0);   -- x offset in current tile
  signal tile_y_offs : unsigned(CHAR_BIT_SIZE - 1 downto 0);   -- y offset in current tile
  signal tile_index  : integer := 0;                           -- Index of pixel to be read in current tile
  
  signal color       : unsigned(7 downto 0);        -- Color of current pixel
  
  -- Constants
  -- Add one pixel to account for memory access time
  constant x_res       : integer := 640 + 1;            -- Max resolution for monitor, x-width
  constant x_sync_low  : integer := 656 + 1;            -- x-pos when h-sync starts (inclusive)
  constant x_sync_high : integer := 751 + 1;            -- x-pos when h-sync stops  (inclusive)
  constant x_max       : integer := 799 + 1;            -- Maximum count (position) for x

  constant y_res       : integer := 480;            -- Max resolution for monitor, y-height
  constant y_sync_low  : integer := 490;            -- y-pos when v-sync starts (inclusive)
  constant y_sync_high : integer := 491;            -- y-pos when v-sync stops  (inclusive)
  constant y_max       : integer := 510;            -- Maximum count (position) for y
		  
begin

  -- Clock divisor
  -- Divide system clock (100 MHz) by 4
  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
	      clk_div <= (others => '0');
      else
	      clk_div <= clk_div + 1;
      end if;
    end if;
  end process;
	
  -- 25 MHz clock (one system clock pulse width)
  clk_25 <= '1' when (clk_div = 3) else '0';
	
	
  -- Horizontal pixel counter

    process(clk) begin
        if rising_edge(clk) then
            if rst = '1' then
                x_pixel <= (others => '0');
            elsif clk_25 = '1' then
                x_pixel <= x_pixel + 1;
                if x_pixel = x_max then
                    x_pixel <= (others => '0');
                end if;
            end if;
        end if;
    end process;        
    
  
  -- Horizontal sync
  
  h_sync <= '0' when x_pixel >= x_sync_low and x_pixel <= x_sync_high -- Sets h_sync to 0 when inside the defined sync-bounds
                else '1';
  
  -- Vertical pixel counter

	process(clk) begin
        if rising_edge(clk) then
            if rst = '1' then
                y_pixel <= (others => '0');
            elsif clk_25 = '1' then
                if x_pixel = x_max then
                    y_pixel <= y_pixel + 1;
                    if y_pixel = y_max then
                        y_pixel <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;

  -- Vertical sync

  v_sync <= '0' when y_pixel >= y_sync_low and y_pixel <= y_sync_high -- Sets v_sync to 0 when inside the defined sync-bounds
                else '1';

  
  -- Video blanking signal
  
  blank <= '1' when x_pixel >= x_res or y_pixel >= y_res -- Sets blank to 1 if either x-pos or y-pos are outside visible (monitor) area
               else '0';

  -- Tile
  
  tile <= to_integer(y_pixel(9 downto CHAR_BIT_SIZE)) * VIDEO_TILE_WIDTH + to_integer(x_pixel(9 downto CHAR_BIT_SIZE));

  -- Tile offset
  
  tile_x_offs <= x_pixel(CHAR_BIT_SIZE - 1 downto 0);
  tile_y_offs <= y_pixel(CHAR_BIT_SIZE - 1 downto 0);

  -- Tile index
  
  tile_index <= to_integer(tile_y_offs) * CHAR_SIZE + to_integer(tile_x_offs);
  
  -- Address
  addr <= to_unsigned(tile, 16);
  
  -- Color
  color <= x"00"    when blank = '1' else
           fg_color when CHARS(to_integer(char))(tile_index) = '1' else
           bg_color;

  -- VGA generation
  vga_r(2) <= color(7);
  vga_r(1) <= color(6);
  vga_r(0) <= color(5);
  vga_g(2) <= color(4);
  vga_g(1) <= color(3);
  vga_g(0) <= color(2);
  vga_b(2) <= color(1);
  vga_b(1) <= color(0);
  
end Behavioral;

