library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;
use work.program_file.all;

entity ProgramMemory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_jmp_stall : in pm_jmp_stall_enum;
        pm_write_enable : in pm_write_enum;

        pm_jmp_offs_imm : in unsigned(15 downto 0);
        pm_jmp_offs_reg : in unsigned(15 downto 0);

        pm_write_data : in unsigned(31 downto 0);
        pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS - 1 downto 0);

        pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS - 1 downto 0);
        pm_out : out unsigned(31 downto 0) := X"0000_0000"
  );
end ProgramMemory;

architecture Behaviour of ProgramMemory is

  signal memory: program_memory_array := program;

  signal PC : unsigned(15 downto 0) := X"0000";
  signal PC1 : unsigned(15 downto 0) := X"0000";
  signal PC2 : unsigned(15 downto 0) := X"0000";
  signal JPC2 : unsigned(15 downto 0) := X"0000";
  
begin
  
  -- Update PC registers and output current line
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        PC <= X"0000";
        PC1 <= X"0000";
        PC2 <= X"0000";
        JPC2 <= X"0000";

        pm_out <= NOP_REG;

      else
        -- Update PC registers
        PC1 <= PC;
        PC2 <= PC1;
        JPC2 <= PC1 + pm_jmp_offs_imm;
        if pm_jmp_stall = PM_JMP_IMM then
          PC <= JPC2;                    -- jump
        elsif pm_jmp_stall = PM_JMP_REG then
          PC <= PC2 + pm_jmp_offs_reg;   -- jumpreg
        elsif pm_jmp_stall = PM_STALL then
          PC <= PC;                     -- stall
        elsif pm_jmp_stall = PM_NORMAL then
          PC <= PC + 1;                 -- tick
        end if;

        -- Output current line
        pm_out <= memory(to_integer(PC));
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


  -- Output program counter
  pm_counter <= PC; -- Maybe not needed, currently not used.

end architecture;

