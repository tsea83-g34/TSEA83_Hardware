--------------------------------------------------------------------------------
-- VGA lab
-- Anders Nilsson
-- 16-dec-2015
-- Version 1.0


-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type
                                        -- and various arithmetic operations

-- entity
entity VGA_lab is
  port ( clk	                : in std_logic;                         -- system clock
	 rst                    : in std_logic;                         -- reset
	 Hsync	                : out std_logic;                        -- horizontal sync
	 Vsync	                : out std_logic;                        -- vertical sync
	 vgaRed	                : out	std_logic_vector(2 downto 0);   -- VGA red
	 vgaGreen               : out std_logic_vector(2 downto 0);     -- VGA green
	 vgaBlue	        : out std_logic_vector(2 downto 1);     -- VGA blue
	 PS2KeyboardCLK	        : in std_logic;                         -- PS2 clock
	 PS2KeyboardData        : in std_logic);                        -- PS2 data
end VGA_lab;


-- architecture
architecture Behavioral of VGA_lab is

  -- PS2 keyboard encoder component
  component KBD_ENC
    port ( clk		        : in std_logic;				-- system clock
	   rst		        : in std_logic;				-- reset signal
	   PS2KeyboardCLK       : in std_logic;				-- PS2 clock
	   PS2KeyboardData      : in std_logic;				-- PS2 data
	   data		        : out std_logic_vector(7 downto 0);	-- tile data
	   addr			: out unsigned(10 downto 0);	        -- tile address
	   we			: out std_logic);	                -- write enable
  end component;

  -- picture memory component
  component PICT_MEM
    port ( clk			: in std_logic;                         -- system clock
	 -- port 1
           we1		        : in std_logic;                         -- write enable
           data_in1	        : in std_logic_vector(7 downto 0);      -- data in
           data_out1	        : out std_logic_vector(7 downto 0);     -- data out
           addr1	        : in unsigned(10 downto 0);             -- address
	 -- port 2
           we2			: in std_logic;                         -- write enable
           data_in2	        : in std_logic_vector(7 downto 0);      -- data in
           data_out2	        : out std_logic_vector(7 downto 0);     -- data out
           addr2		: in unsigned(10 downto 0));            -- address
  end component;
	
  -- VGA motor component
  component VGA_MOTOR
    port ( clk			: in std_logic;                         -- system clock
           rst			: in std_logic;                         -- reset
           data			: in std_logic_vector(7 downto 0);      -- data
           addr			: out unsigned(10 downto 0);            -- address
           vgaRed		: out std_logic_vector(2 downto 0);     -- VGA red
           vgaGreen	        : out std_logic_vector(2 downto 0);     -- VGA green
           vgaBlue		: out std_logic_vector(2 downto 1);     -- VGA blue
           Hsync		: out std_logic;                        -- horizontal sync
           Vsync		: out std_logic);                       -- vertical sync
  end component;
	
  -- intermediate signals between KBD_ENC and PICT_MEM
  signal        data_s	        : std_logic_vector(7 downto 0);         -- data
  signal	addr_s	        : unsigned(10 downto 0);                -- address
  signal	we_s		: std_logic;                            -- write enable
	
  -- intermediate signals between PICT_MEM and VGA_MOTOR
  signal	data_out2_s     : std_logic_vector(7 downto 0);         -- data
  signal	addr2_s		: unsigned(10 downto 0);                -- address
	
begin

  -- keyboard encoder component connection
  U0 : KBD_ENC port map(clk=>clk, rst=>rst, PS2KeyboardCLK=>PS2KeyboardCLK, PS2KeyboardData=>PS2KeyboardData, data=>data_s, addr=>addr_s, we=>we_s);

  -- picture memory component connection
  U1 : PICT_MEM port map(clk=>clk, we1=>we_s, data_in1=>data_s, addr1=>addr_s, we2=>'0', data_in2=>"00000000", data_out2=>data_out2_s, addr2=>addr2_s);
	
  -- VGA motor component connection
  U2 : VGA_MOTOR port map(clk=>clk, rst=>rst, data=>data_out2_s, addr=>addr2_s, vgaRed=>vgaRed, vgaGreen=>vgaGreen, vgaBlue=>vgaBlue, Hsync=>Hsync, Vsync=>Vsync);

end Behavioral;

