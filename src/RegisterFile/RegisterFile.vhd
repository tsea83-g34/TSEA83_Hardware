library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

entity RegisterFile is
  port (
        clk : in std_logic;
        rst : in std_logic;

        read_addr_a : in unsigned(3 downto 0);
        read_addr_b : in unsigned(3 downto 0);
				read_addr_d : in unsigned(3 downto 0);
				
				read_d_or_b_control_signal : in rf_read_d_or_b_enum; -- 1 => read addr_d, 0 => read addr_b

        write_d_control_signal : in rf_write_d_enum; -- Should write

        write_addr_d : in unsigned(3 downto 0);
        write_data_d : in unsigned(31 downto 0);

        out_A2 : out unsigned(31 downto 0)  :=  X"0000_0000";
        out_B2 : out unsigned(31 downto 0)  :=  X"0000_0000"
  );
end RegisterFile;


architecture Behavioral of RegisterFile is

  type reg_array is array (0 to 15) of unsigned(31 downto 0);

  signal registers : reg_array := (

      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      X"00000000", 
      to_unsigned(DATA_MEM_SIZE - 1, 32)); -- Stack pointer
  
begin

  -- Register file logic
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        registers <= (

          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          X"00000000", 
          to_unsigned(DATA_MEM_SIZE - 1, 32)); -- Stack pointer

      else
        -- 1. Update out_A2 and out_B2 registers based on addr_a and addr_b/addr_d
        out_A2 <= registers(to_integer(read_addr_a));
				-- Select between addr_b or addr_d
				case read_d_or_b_control_signal is
					when RF_READ_D => 
						out_B2 <= registers(to_integer(read_addr_d));
					when RF_READ_B =>
						out_B2 <= registers(to_integer(read_addr_b));
				end case; 
        -- 2. Check if should write, and if write write_data_d to write_addr_d.
        if write_d_control_signal = RF_WRITE_D then
          registers(to_integer(write_addr_d)) <= write_data_d;
          
          -- Forward writing data if reading from same address in same cycle to A
          if write_addr_d = read_addr_a then
            out_A2 <= write_data_d;
          end if;
          
          -- Forward writing data if reading from same address in same cycle to B / D
          if write_addr_d = read_addr_b and read_d_or_b_control_signal = RF_READ_B then
            out_B2 <= write_data_d;
          elsif write_addr_d = read_addr_d and read_d_or_b_control_signal = RF_READ_D then
            out_B2 <= write_data_d;
          end if;
          
        end if;
      end if;
    end if;
  end process;

end architecture;

