library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU.ALL;

entity alu is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        alu_control_signal : in unsigned(6 downto 0);

        alu_a : in unsigned(31 downto 0);
        alu_b : in unsigned(31 downto 0);

        alu_res : out unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : buffer std_logic
  );
end alu;

architecture Behavioral of alu is
  constant NOP : unsigned(31 downto 0) := X"0000_0000"; -- Nop constant variable
  constant ZERO : unsigned(32 downto 0) := "0" & X"0000_0000"; -- Zero constant variable
  constant ONE : unsigned(32 downto 0) := "0" & X"0000_0001"; -- one constant variable

  alias update_flag_control_signal is alu_control_signal(6 downto 6);
  alias data_size_control_signal is alu_control_signal(5 downto 4);
  alias alu_operation_control_signal is alu_control_signal(3 downto 0);
  
  signal alu_a_33 : unsigned(32 downto 0);
  signal alu_b_33 : unsigned(32 downto 0);
  signal alu_res_33 : unsigned(32 downto 0);
  signal alu_res_66 : unsigned(65 downto 0) := X"0000_0000_0000_0000" & "00";

  signal alu_res_n : unsigned(31 downto 0);
  signal Z_next, N_next, O_next, C_next : std_logic;

begin
  -- 1. Change data to right size.
  -- Combinatorical process for access to better syntax tools
  process(alu_a, alu_b, data_size_control_signal)
  begin
    case data_size_control_signal is 
      when "11" => -- 32 bit data size 
        alu_a_33 <= '0' & alu_a;
        alu_b_33 <= '0' & alu_b;
      when "10" => -- 16 bit data size
        alu_a_33 <= '0' & alu_a(15 downto 0) & X"0000";
        alu_b_33 <= '0' & alu_b(15 downto 0) & X"0000";
      when "01" => -- 8 bit data size
        alu_a_33 <= '0' & alu_a(7 downto 0) & X"00_0000";
        alu_b_33 <= '0' & alu_b(7 downto 0) & X"00_0000";
      when others => -- Non arithmetic operation
        alu_a_33 <= '0' & alu_a;
        alu_b_33 <= '0' & alu_b;
    end case;
  end process;


  

        
 
  -- 2. Perform ALU operation and calculate result
  
  -- 2.a Perform 66 bit operation (multiply)
  with alu_operation_control_signal select 
   alu_res_66 <= 
       (alu_a_33 * alu_b_33) when "0110",
       unsigned(signed(alu_a_33) * signed(alu_b_33)) when "0111",
       X"0000_0000_0000_0000" & "00" when others;


  with alu_operation_control_signal select
    alu_res_33 <= ZERO when "0000", -- Non arithmetic operation
                  alu_a_33 + alu_b_33 when "0001", -- Add without carry, Add immediate
                  alu_a_33 - alu_b_33 when "0010", -- Sub without borrow, Sub immediate, Compare, Compare immediate
                  ZERO - alu_a_33 when "0011", -- NEG - negate
                  alu_a_33 + ONE when "0100", -- INC - increment,
                  alu_a_33 - ONE when "0101", -- DEC - decrement 
                  alu_res_66(32 downto 0) when "0110", -- UMUL - multiplication for unsigned integers 
                  alu_res_66(32 downto 0) when "0111", -- MUL - multiplication for signed integers 
                  alu_a_33(31 downto 0) & '0' when "1000", -- Logical shift left 
                  '0' & alu_a_33(32 downto 1) when "1001", -- Logical shift right
                  alu_a_33(31 downto 0) & C_flag when "1010", -- Arithmetical shit left 
                  C_flag & alu_a_33(32 downto 1) when "1011", -- Arithmetical shift right 
                  alu_a_33 and alu_b_33 when "1100", -- AND 
                  alu_a_33 or alu_b_33 when "1101", -- OR 
                  alu_a_33 xor alu_b_33 when "1110", -- XOR 
                  not alu_a_33 when "1111", -- NOT 
                  ZERO when others;



  -- 3. Calculate flags
  -- Zero flag
  Z_next <= '1' when alu_res_33(31 downto 0) = X"0000_0000" else '0';
  -- Negative flag
  N_next <= '0' when alu_operation_control_signal = "0000" else -- PASS
            alu_res_33(31); -- Most significant bit of the result 
  -- Overflow flag
  -- Logic depends on operation
  with alu_operation_control_signal select
      O_next <= (alu_res_33(31) and not alu_a_33(31) and not alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and alu_b_33(31)) 
              when "0001", -- ADD
                (alu_res_33(31) and not alu_a_33(31)) or
                (not alu_res_33(31) and alu_a_33(31))
              when "0100", -- INC
                (alu_res_33(31) and not alu_a_33(31) and alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and not alu_b_33(31))
              when "0010", -- SUB
                (alu_res_33(31) and not alu_a_33(31)) or 
                (not alu_res_33(31) and alu_a_33(31))
              when "0101", -- DEC
                '0'
              when others;
  -- Carry flag
  C_next <= '0' when alu_control_signal = "0000" else -- PASS
            alu_a_33(0) when alu_control_signal = "1001" or alu_control_signal = "1011" -- When shift right
            alu_res_33(32); -- Carry bit of of the result

  -- 4. Change result data back to correct size
  -- Combinatorical process for access to better syntax tools
  process(alu_res_33, alu_a, alu_b, data_size_control_signal)
  begin
    case data_size_control_signal is 
      when "11" => -- 32 bit data size 
        alu_res_n <= alu_res_33(31 downto 0);
      when "10" => -- 16 bit data size
        alu_res_n <= X"0000" & alu_res_33(31 downto 16);
        if alu_operation_control_signal = "1010" then -- if arithmetical shift left
          alu_res_n(0) <= C_flag; -- Add lost C flag
        end if;
      when "01" => -- 8 bit data size
        alu_res_n <= X"0000_00" & alu_res_33(31 downto 24);
        if alu_operation_control_signal = "1010" then -- if arithmetical shift left
          alu_res_n(0) <= C_flag; -- Add lost C flag
        end if;      
      when others => -- Non arithmetic operation
          alu_res_n <= alu_res_33(31 downto 0);
    end case;
  end process;

  --with data_size_control_signal select 
    --alu_res_n <=  
    

  -- 5. Assign next result and flags to registers
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        alu_res <= NOP;

        Z_flag <= '0';
        N_flag <= '0';
        O_flag <= '0';
        C_flag <= '0';
      else
        alu_res <= alu_res_n;
        
        if update_flag_control_signal = "1" then
          Z_flag <= Z_next;
          N_flag <= N_next;
          O_flag <= O_next;
          C_flag <= C_next; 
        end if;
      end if;
    end if;
  end process;

end architecture;
