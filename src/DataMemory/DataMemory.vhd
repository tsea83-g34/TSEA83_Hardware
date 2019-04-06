library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU.ALL;

entity data_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        read_address : in unsigned(15 downto 0);
        write_address : in unsigned(15 downto 0);

        write_enable : in std_logic; -- Should write if true
        
        read_mode : in byte_mode;
        write_mode : in byte_mode;

        read_data : out unsigned(31 downto 0);
        write_data : in unsigned(31 downto 0);
      );
end data_memory;

architecture Behavioral of data_memory is
  
  type data_chunk_array is array (0 to (2^DATA_MEM_BIT_SIZE - 1)) of unsigned (7 downto 0);

  signal mem_chunk0 : data_chunk_array; -- Address % 4 = 0       Low byte
  signal mem_chunk1 : data_chunk_array; -- Address % 4 = 1
  signal mem_chunk2 : data_chunk_array; -- Address % 4 = 2
  signal mem_chunk3 : data_chunk_array; -- Address % 4 = 3       High byte
  
  alias read_phys_address : unsigned ((DATA_MEM_BIT_SIZE - 2) downto 0) is read_address ((DATA_MEM_BIT_SIZE - 1) downto 2);
  alias read_chunk_select : unsigned (1 downto 0) is read_address (1 downto 0);
  
  alias write_phys_address : unsigned ((DATA_MEM_BIT_SIZE - 2) downto 0) is write_address ((DATA_MEM_BIT_SIZE - 1) downto 2);
  alias write_chunk_select : unsigned (1 downto 0) is write_address (1 downto 0);

begin

  -- Writing
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        
        mem_chunk0 <= (others <= (others <= '0'));
        mem_chunk1 <= (others <= (others <= '0'));
        mem_chunk2 <= (others <= (others <= '0'));
        mem_chunk3 <= (others <= (others <= '0'));

      elsif write_enable = '1' then

        case write_mode is
          when WORD =>
            mem_chunk0(write_phys_address) <= write_data(7 downto 0);
            mem_chunk1(write_phys_address) <= write_data(15 downto 8);
            mem_chunk2(write_phys_address) <= write_data(23 downto 16);
            mem_chunk3(write_phys_address) <= write_data(31 downto 24);
          
          when HALF =>
            if (chunk_select < 2) then
              mem_chunk0(write_phys_address) <= write_data(7 downto 0);
              mem_chunk1(write_phys_address) <= write_data(15 downto 8);
            else
              mem_chunk2(write_phys_address) <= write_data(7 downto 0);
              mem_chunk3(write_phys_address) <= write_data(15 downto 8);
            end if;
          
          when BYTE =>
            case chunk_select is
              when 0 =>
                mem_chunk0(write_phys_address) <= write_data(7 downto 0);
              when 1 =>
                mem_chunk1(write_phys_address) <= write_data(7 downto 0);
              when 2 =>
                mem_chunk2(write_phys_address) <= write_data(7 downto 0);
              when 3 =>
                mem_chunk3(write_phys_address) <= write_data(7 downto 0);
            
          end case;
        end case;
      end if;
    end if;
  end process;

  -- Reading
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then

        read_data <= (others <= '0')

      else
        case read_mode is
          when WORD =>
            read_data <= mem_chunk3(read_phys_address) & mem_chunk2(read_phys_address) & mem_chunk1(read_phys_address) & mem_chunk0(read_phys_address);
          
          when HALF =>
            read_data <= "0000_0000" & mem_chunk1(read_phys_address) & mem_chunk0(read_phys_address);
          
          when BYTE =>
            read_data <= "0000_0000_0000" & mem_chunk0(read_phys_address);
      
      end if;
    end if;
  end process;
end architecture;