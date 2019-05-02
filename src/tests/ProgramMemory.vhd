library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity program_memory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_control_signal : in unsigned(1 downto 0); -- write, jmp
        pm_offset : in unsigned(15 downto 0);
        pm_write_data : in unsigned(31 downto 0);
        pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);

        pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        pm_out : out unsigned(31 downto 0)
  );
end program_memory;

architecture Behaviour of program_memory is 
  type program_memory_array is array(0 to PROGRAM_MEMORY_SIZE-1) of unsigned(31 downto 0);

  signal memory: program_memory_array := (
    X"0000_0000",
    X"0000_0001",
    X"0000_0002",
    X"0000_0003",
    others => X"0000_0000"
  );
  signal PC: unsigned(16 downto 1) := X"0000";

  alias pm_jmp is pm_control_signal(0 downto 0);
  alias pm_write is pm_control_signal(1 downto 1);



begin 

  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        PC <= X"0000";
      else
        PC <= PC + 1;
        if pm_jmp = "1" then
          PC <= PC + pm_offset;
        end if; 

      end if;
    end if;    
  end process;

  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        -- Pass
      else
        if pm_write = "1" then
          memory(to_integer(pm_write_address)) <= pm_write_data;
        end if; 

      end if;
    end if;    
  end process;


  pm_out <= memory(to_integer(PC));
  pm_counter <= PC; -- Maybe not needed

end architecture;

