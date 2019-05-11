library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity program_memory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_jmp_stall : in pm_jmp_stall_enum;
        pm_write_enable : in pm_write_enum;

        pm_jump_offset : in unsigned(15 downto 0);
        pm_write_data : in unsigned(31 downto 0);
        pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);

        pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        pm_out : out unsigned(31 downto 0)
  );
end program_memory;

architecture Behaviour of program_memory is 
  type program_memory_array is array(0 to PROGRAM_MEMORY_SIZE-1) of unsigned(31 downto 0);

  signal memory: program_memory_array := (
    --$PROGRAM
    X"8b10000a", -- addi r1 r0 10
    X"93111000", -- add r1 r1 r1
    X"d3010002", -- store r0 r1 2 [4]
    X"83200002", -- load r2 r0 2 [4]
    X"f7300003", -- movlo r3 3
    X"a7323000", -- mul r3 r2 r3,
    --$PROGRAM_END
    others => X"00000000"
  );
  signal PC : unsigned(15 downto 0) := X"0000";
  signal PC1 : unsigned(15 downto 0) := X"0000";
  signal PC2 : unsigned(15 downto 0) := X"0000";
  
begin
  
  -- Update PC registers and output current line
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        PC <= X"0000";
        PC1 <= X"0000";
        PC2 <= X"0000";
      else
        PC1 <= PC;
        PC2 <= PC1 + pm_jump_offset;
        if pm_jmp_stall = PM_JMP then
          PC <= PC2;                    -- jump
        elsif pm_jmp_stall = PM_STALL then
          PC <= PC;                     -- stall
        elsif pm_jmp_stall = PM_NORMAL then
          PC <= PC + 1;                 -- tick
        end if;
      end if;
    end if;    
  end process;
  
 -- Check if should write to PM
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        -- Pass
      else
        if pm_write_enable = PM_WRITE then
          memory(to_integer(pm_write_address)) <= pm_write_data;
        end if; 
      end if;
    end if;    
  end process;

  -- Output signals logic
  pm_out <= memory(to_integer(PC));
  pm_counter <= PC; -- Maybe not needed

end architecture;

