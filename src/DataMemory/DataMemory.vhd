library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;

use work.PIPECPU_STD.ALL;

entity data_memory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        address : in unsigned(15 downto 0);

        write_enable : in std_logic; -- Should write if true, else read

        address_mode  : in byte_mode;
        
        write_data : in unsigned(31 downto 0)
        read_data  : out unsigned(31 downto 0);
       );
end data_memory;

architecture Behavioral of data_memory is
  
  type data_chunk_array is array (0 to (2**DATA_MEM_BIT_SIZE) - 1) of unsigned (7 downto 0);

  signal mem_chunk0 : data_chunk_array; -- Address % 4 = 0       Low byte
  signal mem_chunk1 : data_chunk_array; -- Address % 4 = 1
  signal mem_chunk2 : data_chunk_array; -- Address % 4 = 2
  signal mem_chunk3 : data_chunk_array; -- Address % 4 = 3       High byte
  
  alias phys_address : unsigned ((DATA_MEM_BIT_SIZE - 3) downto 0) is address((DATA_MEM_BIT_SIZE - 1) downto 2);
  alias chunk_select : unsigned (1 downto 0) is address (1 downto 0);

begin
  
  -- Read and Write.
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        
        mem_chunk0 <= (others => (others => '0'));
        mem_chunk1 <= (others => (others => '0'));
        mem_chunk2 <= (others => (others => '0'));
        mem_chunk3 <= (others => (others => '0'));

        read_data <= (others => '0');

      elsif write_enable = '1' then
         -- Read NOP if writing
        read _data <= (others => '0');
        
        -- Write
        case address_mode is
          when WORD =>
            mem_chunk0(to_integer(phys_address)) <= write_data(7 downto 0);
            mem_chunk1(to_integer(phys_address)) <= write_data(15 downto 8);
            mem_chunk2(to_integer(phys_address)) <= write_data(23 downto 16);
            mem_chunk3(to_integer(phys_address)) <= write_data(31 downto 24);
          
          when HALF =>
            if (chunk_select < 2) then
              mem_chunk0(to_integer(phys_address)) <= write_data(7 downto 0);
              mem_chunk1(to_integer(phys_address)) <= write_data(15 downto 8);
            else
              mem_chunk2(to_integer(phys_address)) <= write_data(7 downto 0);
              mem_chunk3(to_integer(phys_address)) <= write_data(15 downto 8);
            end if;
          
          when BYTE =>
            case chunk_select is
              when "00" =>
                mem_chunk0(to_integer(phys_address)) <= write_data(7 downto 0);
              when "01" =>
                mem_chunk1(to_integer(phys_address)) <= write_data(7 downto 0);
              when "10" =>
                mem_chunk2(to_integer(phys_address)) <= write_data(7 downto 0);
              when others =>
                mem_chunk3(to_integer(phys_address)) <= write_data(7 downto 0);
            
       else -- Read if not writing
        case address_mode is
          when WORD =>
          
            read_data <= mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address)) & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
          
          when HALF =>
            if (chunk_select < 2) then
              read_data <= x"00_00" & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
            else
              read_data <= x"00_00" & mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address));
            end if;
          
          when BYTE =>
            case chunk_select is
              when "00" =>
                read_data <= x"00_00_00" & mem_chunk0(to_integer(phys_address));
              when "01" =>
                read_data <= x"00_00_00" & mem_chunk1(to_integer(phys_address));
              when "10" =>
                read_data <= x"00_00_00" & mem_chunk2(to_integer(phys_address));
              when others =>
                read_data <= x"00_00_00" & mem_chunk3(to_integer(phys_address));

      	end case;
      end if;
    end if;
  end process;

end architecture;
