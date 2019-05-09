library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity program_memory is 
  port (
        clk : in std_logic;
        rst : in std_logic;

        pm_control_signal : in unsigned(2 downto 0); -- stall, write, jmp
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
    X"cfdf0000", -- move r13 r15
    X"810d0002", -- load r0 r13 2 [2]
    X"e3000001", -- cmpi r0 1
    X"1b000003", -- breq L0
    X"8b0e0000", -- addi r0 r14 0
    X"33000002", -- rjmp L1
    X"8b0e0001", -- addi r0 r14 1
    X"e3000001", -- cmpi r0 1
    X"1f000006", -- brne L2
    X"8bce0001", -- addi r12 r14 1
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd000d", -- subi r13 r13 13
    X"efd00000", -- rjmprg r13
    X"811d0002", -- load r1 r13 2 [2]
    X"e3020002", -- cmpi r1 2
    X"1b000003", -- breq L3
    X"8b1e0000", -- addi r1 r14 0
    X"33000002", -- rjmp L4
    X"8b1e0001", -- addi r1 r14 1
    X"e3020001", -- cmpi r1 1
    X"1f000006", -- brne L5
    X"8bce0001", -- addi r12 r14 1
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd001a", -- subi r13 r13 26
    X"efd00000", -- rjmprg r13
    X"8fff0002", -- subi r15 r15 2
    X"8b2e0001", -- addi r2 r14 1
    X"8fff0002", -- subi r15 r15 2
    X"8b3e0001", -- addi r3 r14 1
    X"8fff0002", -- subi r15 r15 2
    X"8b4e0000", -- addi r4 r14 0
    X"8fff0002", -- subi r15 r15 2
    X"8b5e0002", -- addi r5 r14 2
    X"d1d2fffe", -- store r13 r2 -2 [2]
    X"d1d3fffc", -- store r13 r3 -4 [2]
    X"d1d4fffa", -- store r13 r4 -6 [2]
    X"d1d5fff8", -- store r13 r5 -8 [2]
    X"810dfff8", -- load r0 r13 -8 [2]
    X"811d0002", -- load r1 r13 2 [2]
    X"df002000", -- cmp r0 r1
    X"1f000003", -- brne L8
    X"8b0e0000", -- addi r0 r14 0
    X"33000002", -- rjmp L9
    X"8b0e0001", -- addi r0 r14 1
    X"e3000001", -- cmpi r0 1
    X"1f00001f", -- brne L7
    X"812dfffa", -- load r2 r13 -6 [2]
    X"e3040000", -- cmpi r2 0
    X"1b000003", -- breq L10
    X"8b2e0000", -- addi r2 r14 0
    X"33000002", -- rjmp L11
    X"8b2e0001", -- addi r2 r14 1
    X"e3040001", -- cmpi r2 1
    X"1f000006", -- brne L12
    X"813dfffe", -- load r3 r13 -2 [2]
    X"814dfffc", -- load r4 r13 -4 [2]
    X"93334000", -- add r3 r3 r4
    X"cf530000", -- move r5 r3
    X"8b6e0001", -- addi r6 r14 1
    X"e30c0001", -- cmpi r6 1
    X"1b000003", -- breq L13
    X"8b6e0000", -- addi r6 r14 0
    X"33000002", -- rjmp L14
    X"8b6e0001", -- addi r6 r14 1
    X"e30c0001", -- cmpi r6 1
    X"1f000004", -- brne L15
    X"93445000", -- add r4 r4 r5
    X"cf340000", -- move r3 r4
    X"8b6e0000", -- addi r6 r14 0
    X"8b110001", -- addi r1 r1 1
    X"cf410000", -- move r4 r1
    X"d1d3fffc", -- store r13 r3 -4 [2]
    X"d1d40002", -- store r13 r4 2 [2]
    X"d1d5fffe", -- store r13 r5 -2 [2]
    X"d1d6fffa", -- store r13 r6 -6 [2]
    X"3300ffda", -- rjmp L6
    X"810dfffa", -- load r0 r13 -6 [2]
    X"e3000000", -- cmpi r0 0
    X"1b000003", -- breq L16
    X"8b0e0000", -- addi r0 r14 0
    X"33000002", -- rjmp L17
    X"8b0e0001", -- addi r0 r14 1
    X"e3000001", -- cmpi r0 1
    X"1f000008", -- brne L18
    X"811dfffc", -- load r1 r13 -4 [2]
    X"cfc10000", -- move r12 r1
    X"8bff0008", -- addi r15 r15 8
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd005c", -- subi r13 r13 92
    X"efd00000", -- rjmprg r13
    X"812dfffa", -- load r2 r13 -6 [2]
    X"e3040001", -- cmpi r2 1
    X"1b000003", -- breq L19
    X"8b2e0000", -- addi r2 r14 0
    X"33000002", -- rjmp L20
    X"8b2e0001", -- addi r2 r14 1
    X"e3040001", -- cmpi r2 1
    X"1f000008", -- brne L21
    X"813dfffe", -- load r3 r13 -2 [2]
    X"cfc30000", -- move r12 r3
    X"8bff0008", -- addi r15 r15 8
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd006b", -- subi r13 r13 107
    X"efd00000", -- rjmprg r13
    X"8bff0008", -- addi r15 r15 8
    X"cfce0000", -- move r12 r14
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd0071", -- subi r13 r13 113
    X"efd00000", -- rjmprg r13
    X"cfdf0000", -- move r13 r15
    X"8fff0002", -- subi r15 r15 2
    X"8bfffffe", -- addi r15 r15 -2
    X"d1fd0000", -- store r15 r13 0 [2]
    X"8fff0002", -- subi r15 r15 2
    X"8b0e000a", -- addi r0 r14 10
    X"8bfffffe", -- addi r15 r15 -2
    X"d1f00000", -- store r15 r0 0 [2]
    X"f7d0007e", -- movlo r13 126
    X"8bffffff", -- addi r15 r15 -1
    X"d3fd0000", -- store r15 r13 0
    X"3300ff83", -- rjmp fibonacci
    X"8bff0004", -- addi r15 r15 4
    X"81df0000", -- load r13 r15 0 [2]
    X"8bff0002", -- addi r15 r15 2
    X"cf0c0000", -- move r0 r12
    X"8bce0000", -- addi r12 r14 0
    X"8bff0002", -- addi r15 r15 2
    X"83df0000", -- load r13 r15 0
    X"8bff0001", -- addi r15 r15 1
    X"8fdd0087", -- subi r13 r13 135
    X"efd00000", -- rjmprg r13,
    --$PROGRAM_END

    others => X"0000_0000"
  );
  signal PC : unsigned(15 downto 0) := X"0000";
  signal PC1 : unsigned(15 downto 0) := X"0000";
  signal PC2 : unsigned(15 downto 0) := X"0000";
  
  alias pm_jmp is pm_control_signal(0 downto 0);
  alias pm_stall is pm_control_signal(1 downto 1);
  alias pm_write_enable is pm_control_signal(2 downto 2);
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
        if pm_jmp = "1" and pm_stall = "0" then
          PC <= PC2;                    -- jump
        elsif pm_jmp = "0" and pm_stall = "1" then
          PC <= PC;                     -- stall
        else
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
        if pm_write_enable = "1" then
          memory(to_integer(pm_write_address)) <= pm_write_data;
        end if; 
      end if;
    end if;    
  end process;

  -- Output signals logic
  pm_out <= memory(to_integer(PC));
  pm_counter <= PC; -- Maybe not needed

end architecture;

