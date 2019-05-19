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

        read_data  : out unsigned(31 downto 0)  :=  X"0000_0000"
       );
end DataMemory;

architecture Behavioral of DataMemory is

  signal mem_chunk0 : data_chunk_array := data0; -- Address % 4 = 0       Low byte
  signal mem_chunk1 : data_chunk_array := data1; -- Address % 4 = 1
  signal mem_chunk2 : data_chunk_array := data2; -- Address % 4 = 2
  signal mem_chunk3 : data_chunk_array := data3; -- Address % 4 = 3       High byte
  
  alias phys_address : unsigned ((DATA_MEM_CHUNK_BIT_SIZE - 1) downto 0) is address((DATA_MEM_BIT_SIZE - 1) downto 2);
  alias chunk_select : unsigned (1 downto 0) is address (1 downto 0);
  
  signal memory_out : unsigned(31 downto 0) := x"00000000";
  signal prev_size_mode : byte_mode         := NAN;

begin
  
  -- Read and Write.
  process(clk) begin
    if rising_edge(clk) then
      if write_or_read = DM_WRITE then
      
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
          
            memory_out <= mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address)) & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
          
          when HALF =>
            if (chunk_select < 2) then
            
              memory_out <= X"00_00" & mem_chunk1(to_integer(phys_address)) & mem_chunk0(to_integer(phys_address));
                
            else
            
              memory_out <= X"00_00" & mem_chunk3(to_integer(phys_address)) & mem_chunk2(to_integer(phys_address));
                
            end if;
          
          when BYTE =>
            case chunk_select is
              when "00" => 
              
                memory_out <= x"00_00_00" & mem_chunk0(to_integer(phys_address));
                  
              when "01" =>
              
                memory_out <= x"00_00_00" & mem_chunk1(to_integer(phys_address));
                  
              when "10" =>
              
                memory_out <= x"00_00_00" & mem_chunk2(to_integer(phys_address));
                  
              when others =>
              
                memory_out <= x"00_00_00" & mem_chunk3(to_integer(phys_address));
                  
            end case;   

          when others =>
          
            memory_out <= (others => '0');

      	end case;
      end if;
    end if;
  end process;
  
  -- Clock size mode (for sign extending on output)
  process(clk) begin
    if rising_edge(clk) then
      prev_size_mode <= size_mode;
    end if;
  end process;
  
  -- Sign extention
  read_data <= memory_out                            when write_or_read = DM_READ and prev_size_mode = WORD else
               x"FF_FF"    & memory_out(15 downto 0) when write_or_read = DM_READ and prev_size_mode = HALF and memory_out(15) = '1' else
               x"00_00"    & memory_out(15 downto 0) when write_or_read = DM_READ and prev_size_mode = HALF and memory_out(15) = '0' else
               x"FF_FF_FF" & memory_out(7  downto 0) when write_or_read = DM_READ and prev_size_mode = BYTE and memory_out( 7) = '1' else
               x"00_00_00" & memory_out(7  downto 0) when write_or_read = DM_READ and prev_size_mode = BYTE and memory_out( 7) = '0' else
               x"00_00_00_00";
  
end architecture;

