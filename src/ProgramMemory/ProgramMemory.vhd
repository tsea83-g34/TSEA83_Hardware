library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity ProgramMemory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_jmp_stall : in pm_jmp_stall_enum;
        pm_write_enable : in pm_write_enum;

        pm_jmp_offs_imm : in unsigned(15 downto 0);
        pm_jmp_offs_reg : in unsigned(15 downto 0);

        pm_write_data : in unsigned(31 downto 0);
        pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);

        pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        pm_out : out unsigned(31 downto 0)
  );
end ProgramMemory;

architecture Behaviour of ProgramMemory is 
  type program_memory_array is array(0 to PROGRAM_MEMORY_SIZE-1) of unsigned(31 downto 0);

  signal memory: program_memory_array := (
    --$PROGRAM
    X"8bff00fe", -- addi r15 r15 0xfe
    X"8b110001", -- addi r1 r1 1
    X"8b220002", -- addi r2 r2 2
    X"8b330003", -- addi r3 r3 3
    X"d3330000", -- store r3 r3 0 [4]
    X"83530000", -- load r5 r3 0 [4]
    X"8b550001", -- addi r5 r5 1
    X"e3050005", -- cmpi r5 5
    X"1f00fffe", -- brne ADD_r5
    X"8baafedc", -- addi r10 r10 0xfedc
    X"d00a000a", -- store r0 r10 10 [1]
    X"80a0000a", -- load r10 r0 10 [1]
    X"f7d0000f", -- movlo r13 16
    X"8bffffff", -- addi r15 r15 -1
    X"d3fd0000", -- store r15 r13 0
    X"3300000d", -- rjmp SUBROUTINE
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"03000000", -- nop
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd001e", -- subi r13 r13 31
    X"efd00000", -- rjmprg r13,
    --$PROGRAM_END
    others => X"00000000"
  );

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

