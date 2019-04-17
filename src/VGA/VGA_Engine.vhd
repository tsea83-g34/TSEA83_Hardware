-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type


-- entity
entity vga_engine is
  port (
        clk		 : in std_logic;
        data	 : in std_logic_vector(7 downto 0);
        addr	 : out unsigned(10 downto 0);
        rst    : in std_logic;
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic
       );
end vga_engine;

architecture Behavioral of vga_engine is

  signal x_pixel	  : unsigned(9 downto 0);         -- Horizontal pixel counter
  signal Y_pixel	  : unsigned(9 downto 0);		      -- Vertical pixel counter
  signal clk_div	  : unsigned(1 downto 0);		      -- Clock divisor, to generate 25 MHz signal
  signal clk_25     : std_logic;			              -- One pulse width 25 MHz signal
		
  signal tile_pixel : std_logic_vector(7 downto 0);	-- Tile pixel data
  signal tile_addr	: unsigned(10 downto 0);	      -- Tile address

  signal blank      : std_logic;                    -- blanking signal

-- constants
  constant x_res       : integer := 640;            -- Max resolution for monitor, x-width
  constant x_sync_low  : integer := 656;            -- x-pos when h-sync starts (inclusive)
  constant x_sync_high : integer := 751;            -- x-pos when h-sync stops  (inclusive)
  constant x_max       : integer := 799;            -- Maximum count (position) for x

  constant y_res       : integer := 480;            -- Max resolution for monitor, y-height
  constant y_sync_low  : integer := 490;            -- y-pos when v-sync starts (inclusive)
  constant y_sync_high : integer := 491;            -- y-pos when v-sync stops  (inclusive)
  constant y_max       : integer := 510;            -- Maximum count (position) for y
	

  -- Tile memory type
  type ram_t is array (0 to 2047) of std_logic_vector(7 downto 0);

-- Tile memory
  signal tile_mem : ram_t := 
		( x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",      -- space
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"00",x"00",x"00",x"FF",x"FF",x"FF",	-- A
		  x"FF",x"00",x"00",x"FF",x"00",x"00",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"00",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",      -- B
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",      -- C
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- D
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
                  
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- E
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- F
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- G
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- H
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- I
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- J
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- K
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- L
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- M
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- N
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- O
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- P
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- Q
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- R
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- S
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- T
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- U
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- V
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",  -- W
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"E0",x"E0",x"FF",x"FF",x"FF",x"E0",x"E0",x"FF",	-- X
		  x"FF",x"E0",x"E0",x"FF",x"E0",x"E0",x"FF",x"FF",
		  x"FF",x"FF",x"E0",x"E0",x"E0",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"E0",x"E0",x"E0",x"FF",x"FF",x"FF",
		  x"FF",x"E0",x"E0",x"FF",x"E0",x"E0",x"FF",x"FF",
		  x"E0",x"E0",x"FF",x"FF",x"FF",x"E0",x"E0",x"FF",
		  x"E0",x"FF",x"FF",x"FF",x"FF",x"FF",x"E0",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"1C",x"1C",x"FF",x"FF",x"1C",x"1C",x"FF",      -- Y
		  x"FF",x"1C",x"1C",x"FF",x"FF",x"1C",x"1C",x"FF",
		  x"FF",x"1C",x"1C",x"FF",x"FF",x"1C",x"1C",x"FF",
		  x"FF",x"FF",x"1C",x"1C",x"1C",x"1C",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"1C",x"1C",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"1C",x"1C",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"1C",x"1C",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"FF",      -- Z
		  x"FF",x"FF",x"FF",x"FF",x"03",x"03",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"03",x"03",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"03",x"03",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"03",x"03",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"03",x"03",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"03",x"03",x"03",x"03",x"03",x"03",x"03",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"00",x"FF",x"FF",x"FF",x"FF",      -- Å
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"00",x"FF",x"00",x"FF",x"FF",x"FF",      -- Ä
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"00",x"FF",x"00",x"FF",x"FF",x"FF",      -- Ö
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"00",x"00",x"FF",x"FF",x"FF",x"00",x"00",x"FF",
		  x"FF",x"00",x"00",x"00",x"00",x"00",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
		  x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",

		  x"FF",x"FF",x"27",x"27",x"27",x"27",x"FF",x"FF",      -- PACMAN CURSOR
		  x"FF",x"27",x"27",x"27",x"27",x"27",x"27",x"FF",
		  x"27",x"27",x"27",x"27",x"E0",x"27",x"FF",x"FF",
		  x"27",x"27",x"27",x"27",x"27",x"FF",x"FF",x"FF",
		  x"27",x"27",x"27",x"27",x"27",x"FF",x"FF",x"FF",
		  x"27",x"27",x"27",x"27",x"27",x"27",x"FF",x"FF",
		  x"FF",x"27",x"27",x"27",x"27",x"27",x"27",x"FF",
		  x"FF",x"FF",x"27",x"27",x"27",x"27",x"FF",x"FF"

                  );
		  
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

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  x_pixel                         *
  -- *                                 *
  -- ***********************************

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

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  h_sync                          *
  -- *                                 *
  -- ***********************************
  
    h_sync <= '0' when x_pixel >= x_sync_low and x_pixel <= x_sync_high -- Sets h_sync to 0 when inside the defined sync-bounds
                 else '1';
  
  -- Vertical pixel counter

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  y_pixel                         *
  -- *                                 *
  -- ***********************************

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

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  v_sync                          *
  -- *                                 *
  -- ***********************************

    v_sync <= '0' when y_pixel >= y_sync_low and y_pixel <= y_sync_high -- Sets v_sync to 0 when inside the defined sync-bounds
                 else '1';

  
  -- Video blanking signal

  -- ***********************************
  -- *                                 *
  -- *  VHDL for :                     *
  -- *  Blank                          *
  -- *                                 *
  -- ***********************************
  
    blank <= '1' when x_pixel >= x_res or y_pixel >= y_res -- Sets blank to 1 if either x-pos or y-pos are outside visible (monitor) area
                 else '0';

  
  -- Tile memory
  process(clk)
  begin
    if rising_edge(clk) then
      if (blank = '0') then
        tile_pixel <= tile_mem(to_integer(tile_addr));
      else
        tile_pixel <= (others => '0');
      end if;
    end if;
  end process;
	


  -- Tile memory address composite
  tile_addr <= unsigned(data(4 downto 0)) & y_pixel(4 downto 2) & x_pixel(4 downto 2);


  -- Picture memory address composite
  addr <= to_unsigned(20, 7) * y_pixel(8 downto 5) + x_pixel(9 downto 5);


  -- VGA generation
  vga_r(2) 	<= tile_pixel(7);
  vga_r(1) 	<= tile_pixel(6);
  vga_r(0) 	<= tile_pixel(5);
  vga_g(2)  <= tile_pixel(4);
  vga_g(1)  <= tile_pixel(3);
  vga_g(0)  <= tile_pixel(2);
  vga_b(2) 	<= tile_pixel(1);
  vga_b(1) 	<= tile_pixel(0);


end Behavioral;

