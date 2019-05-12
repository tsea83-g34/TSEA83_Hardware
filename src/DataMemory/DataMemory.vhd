library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;
use work.data_file.ALL;

entity DataMemory is
  port (
        clk : in std_logic;
        rst : in std_logic;

        address : in unsigned(15 downto 0);

        write_or_read : in dm_write_or_read_enum; 

        size_mode  : in byte_mode;
        
        write_data : in unsigned(31 downto 0);
        read_data  : out unsigned(31 downto 0)
       );
end DataMemory;

architecture Behavioral of DataMemory is

  signal mem_chunk0 : data_chunk_array := data0; -- Address % 4 = 0       Low byte
  signal mem_chunk1 : data_chunk_array := data1; -- Address % 4 = 1
  signal mem_chunk2 : data_chunk_array := data2; -- Address % 4 = 2
  signal mem_chunk3 : data_chunk_array := data3; -- Address % 4 = 3       High byte
  
  alias phys_address : unsigned ((DATA_MEM_BIT_SIZE - 3) downto 0) is address((DATA_MEM_BIT_SIZE - 1) downto 2);
  alias chunk_select : unsigned (1 downto 0) is address (1 downto 0);

begin
  
  -- Read and Write.
  process(clk) begin
    if rising_edge(clk) then
      if rst = '1' then
       
        read_data <= (others => '0');

      elsif write_or_read = DM_WRITE then
         -- Read NOP if writing
        read_data <= (others => '0');
        
        -- Write
        case size_mode is
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
            end case; 

           when others =>
              
        end case;

       elsif write_or_read = DM_READ then
        case size_mode is
          when WORD =>
          
            read_data <= mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address)) & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
          
          when HALF =>
            if (chunk_select < 2) then
              if mem_chunk1(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                read_data <= X"FF_FF" & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
              else 
                read_data <= X"00_00" & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
              end if;
            else
              if mem_chunk3(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                read_data <= X"FF_FF" & mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address));
              else
                read_data <= X"00_00" & mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address));
              end if;
            end if;
          
          when BYTE =>
            case chunk_select is
              when "00" => 
                if mem_chunk0(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                  read_data <= X"FF_FF_FF" & mem_chunk0(to_integer(phys_address));
                else 
                  read_data <= x"00_00_00" & mem_chunk0(to_integer(phys_address));
                end if;
              when "01" =>
                if mem_chunk1(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                  read_data <= X"FF_FF_FF" & mem_chunk1(to_integer(phys_address));
                else 
                  read_data <= x"00_00_00" & mem_chunk1(to_integer(phys_address));
                end if;
              when "10" =>
                if mem_chunk2(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                  read_data <= X"FF_FF_FF" & mem_chunk2(to_integer(phys_address));
                else 
                  read_data <= x"00_00_00" & mem_chunk2(to_integer(phys_address));
                end if;
              when others =>
                if mem_chunk3(to_integer(phys_address))(7) = '1' then -- MSB = 1 so extend sign
                  read_data <= X"FF_FF_FF" & mem_chunk3(to_integer(phys_address));
                else 
                  read_data <= x"00_00_00" & mem_chunk3(to_integer(phys_address));
                end if;
            end case;   

          when others =>
            read_data <= (others => '0');

      	end case;
      end if;
    end if;
  end process;
end architecture;
