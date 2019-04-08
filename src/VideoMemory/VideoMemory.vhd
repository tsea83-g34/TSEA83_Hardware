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

entity video_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        -- User port
        write_address : in unsigned(15 downto 0);
        write_data    : in unsigned(15 downto 0);
        write_enable  : in std_logic; -- Should write if true

        -- VGA engine port
        read_address : in unsigned(15 downto 0);
        read_data    : out unsigned(15 downto 0)
       );
end video_memory;

architecture Behavioral of video_memory is
  
  type data_chunk_array is array (0 to (VIDEO_MEM_SIZE) - 1) of unsigned (15 downto 0);

  signal v_mem : data_chunk_array;
  
begin

  -- Writing
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        
        v_mem <= (others => (others => '0'));

      elsif write_enable = '1' then
        if write_address < VIDEO_MEM_SIZE then
      
          v_mem(to_integer(write_address)) <= write_data;

        end if;
      end if;
    end if;
  end process;

  -- Reading
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then

        read_data <= (others => '0');

      else
        if read_address < VIDEO_MEM_SIZE then
      
          read_data <= v_mem(to_integer(read_address));
        
        else
        
          read_data <= (others => '0'); -- Return zeros when reading from an illegal address
        
        end if;
      end if;
    end if;
  end process;
end architecture;
