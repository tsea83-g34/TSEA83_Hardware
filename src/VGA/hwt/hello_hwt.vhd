-- library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;            -- basic IEEE library
use IEEE.NUMERIC_STD.ALL;               -- IEEE library for the unsigned type

library work;
use work.PIPECPU_STD.ALL;
use work.CHARS.ALL;

-- entity
entity hello_hwt is
  port (
        clk		 : in std_logic;
        rst    : in std_logic;
        
        vga_r  : out std_logic_vector(2 downto 0);
        vga_g  : out std_logic_vector(2 downto 0);
        vga_b  : out std_logic_vector(2 downto 1);
        h_sync : out std_logic;
        v_sync : out std_logic
       );
end hello_hwt;

architecture behavioural of hello_hwt is

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
  
  signal char_s	    : unsigned(7 downto 0);
  signal fg_color_s : unsigned(7 downto 0);
  signal bg_color_S : unsigned(7 downto 0);
  signal addr_s     : unsigned(15 downto 0);
  
begin
  
  -- VGA engine component connection
  U0 : vga_engine port map(clk => clk, rst => rst, char => char_s, fg_color => fg_color_s, bg_color => bg_color_s, addr => addr_s, vga_r => vga_r, vga_g => vga_g, vga_b => vga_b, h_sync => h_sync, v_sync => v_sync);
  
  -- Char
  process(clk) begin
    if rising_edge(clk) then
      if addr_s = 0 then
        char_s <= to_unsigned(H, 8);                -- H
      elsif addr_s = 1 then
        char_s <= to_unsigned(e_low, 8);            -- e
      elsif addr_s = 2 then
        char_s <= to_unsigned(l_low, 8);            -- l
      elsif addr_s = 3 then
        char_s <= to_unsigned(l_low, 8);            -- l
      elsif addr_s = 4 then
        char_s <= to_unsigned(o_low, 8);            -- o
      elsif addr_s = 5 then
        char_s <= to_unsigned(SPACE, 8);            --
      elsif addr_s = 6 then
        char_s <= to_unsigned(W, 8);                -- W
      elsif addr_s = 7 then
        char_s <= to_unsigned(o_low, 8);            -- o
      elsif addr_s = 8 then
        char_s <= to_unsigned(r_low, 8);            -- r
      elsif addr_s = 9 then
        char_s <= to_unsigned(l_low, 8);            -- l
      elsif addr_s = 10 then
        char_s <= to_unsigned(d_low, 8);            -- d
      elsif addr_s = 11 then
        char_s <= to_unsigned(EXCLAMATION_MARK, 8); -- !
      else
        char_s <= x"00";
      end if;
    end if;
  end process;
  
  -- Color
  process(clk) begin
    if rising_edge(clk) then
      -- Black and white
      if addr_s < 40 then
      
        fg_color_s <= x"FF";
        bg_color_s <= x"00";
      
      -- Red
      elsif addr_s = 41 then
      
        fg_color_s <= b"111_000_00";
        bg_color_s <= b"111_000_00";
      
      -- Green
      elsif addr_s = 82 then
        
        fg_color_s <= b"000_111_00";
        bg_color_s <= b"000_111_00";
      
      -- Blue
      elsif addr_s = 123 then
        
        fg_color_s <= b"000_000_11";
        bg_color_s <= b"000_000_11";
      
      else

        fg_color_s <= x"00";
        bg_color_s <= x"00";
            
      end if;
    end if;
  end process;
end architecture;


























