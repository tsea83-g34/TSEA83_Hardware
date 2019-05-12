library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;


-- ====== Data in/out ======
-- Data out:
-- 
-- [           16           ]
--
-- Chars:
-- 
--  char         fg     bg
-- [     8     ][  4  ][  4  ]
-- 
-- Palette:
-- 
--  fg           bg
-- [     8     ][     8     ]
--


-- ======   Memory    ======
--   ___________________  0
--  |                   |
--  |                   |
--  |       chars       |
--  |                   |
--  |___________________|
--  |                   |
--  |  fg & bg palette  |
--  |___________________| VIDEO_MEM_SIZE

entity VideoMemory is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        -- User port
        write_address : in unsigned(15 downto 0);
        write_data    : in unsigned(15 downto 0);

        write_enable  : in vm_write_enable_enum;

        -- VGA engine port
        read_address : in  unsigned(15 downto 0);
        char         : out unsigned(7 downto 0);
        fg_color     : out unsigned(7 downto 0);
        bg_color     : out unsigned(7 downto 0)
       );
end VideoMemory;

architecture Behavioral of VideoMemory is
  
  type video_chunk_array   is array (0 to (VIDEO_MEM_SIZE) - 1) of unsigned (15 downto 0);
  type palette_chunk_array is array (0 to 15)                   of unsigned (7 downto 0);

  signal v_mem    : video_chunk_array   := (others => (others => '0'));
  signal fg_p_mem : palette_chunk_array := (x"FF", x"AA", others => (others => '0'));
  signal bg_p_mem : palette_chunk_array := (x"55", x"00", others => (others => '0'));
  
begin

  -- Writing
  process(clk) begin
    if rising_edge(clk) then
      if write_enable = VM_WRITE then
        if write_address < PALETTE_START then
      
          v_mem(to_integer(write_address)) <= write_data;
        
        elsif write_address < VIDEO_MEM_SIZE then
          
          fg_p_mem(to_integer(write_address) - PALETTE_START) <= write_data(15 downto 8);
          bg_p_mem(to_integer(write_address) - PALETTE_START) <= write_data(7 downto 0);
          
        end if;
      end if;
    end if;
  end process;

  -- Reading
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' or read_address >= PALETTE_START then
        
        char     <= (others => '0');
        fg_color <= (others => '0');
        bg_color <= (others => '0');

      else

        char     <= v_mem(to_integer(read_address))(15 downto 8);
        fg_color <= fg_p_mem(to_integer(v_mem(to_integer(read_address))(7 downto 4)));
        bg_color <= bg_p_mem(to_integer(v_mem(to_integer(read_address))(3 downto 0)));

      end if;
    end if;
  end process;

end architecture;
