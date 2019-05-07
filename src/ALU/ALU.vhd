library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity alu is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        update_flags_control_signal : in unsigned(0 downto 0);
        data_size : in byte_mode;
        alu_op : in unsigned(5 downto 0);

        alu_a : in unsigned(31 downto 0); -- rA
        alu_b : in unsigned(31 downto 0); -- rB or IMM

        alu_res : out unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : buffer std_logic
  );
end alu;

architecture Behavioral of alu is
  constant ZERO_32 : unsigned(31 downto 0) := X"0000_0000"; -- Nop constant variable
  constant ZERO : unsigned(32 downto 0) := "0" & X"0000_0000"; -- Zero constant variable
  constant ONE : unsigned(32 downto 0) := "0" & X"0000_0001"; -- one constant variable
  
  signal alu_a_33 : unsigned(32 downto 0);
  signal alu_b_33 : unsigned(32 downto 0);
  signal alu_res_32 : unsigned(32 downto 0);
  signal alu_shift_res_33 : unsigned(32 downto 0);
  signal alu_res_66 : unsigned(65 downto 0) := X"0000_0000_0000_0000" & "00";

  signal alu_res_n : unsigned(31 downto 0);
  signal Z_next, N_next, O_next, C_next : std_logic;

begin
  -- 1. Change data to right size. 
  alu_a_33 <= '0' & alu_a;
  alu_b_33 <= '0' & alu_b;
       
 
  -- 2. Perform ALU operation and calculate result
  
  -- 2.A Perform 66 bit operation (multiply)
  with alu_op select 
   alu_res_66 <= 
       unsigned(signed(alu_a_33) * signed(alu_b_33)) when MUL,
       X"0000_0000_0000_0000" & "00" when others;
  

  -- 2.B Perform shifting ALU operation, which depends on size
  process(alu_op, data_size, alu_a) 
  begin
    if alu_op = LSL then
      case data_size is
        when WORD =>
          alu_shift_res_33 <= "0" & alu_a(30 downto 0) & "0";
        when HALF =>
          if alu_a(14 downto 14) = "1" then -- new MSB = 1
            alu_shift_res_33 <= "0" & X"FFFF" & alu_a(14 downto 0) & "0"; -- Sign extend with "FFFF"
          else                              -- new MSB = 0
            alu_shift_res_33 <= "0" & X"0000" & alu_a(14 downto 0) & "0"; -- Sign extend with "0000"
          end if;
        when BYTE =>
          if alu_a(6 downto 6) = "1" then -- new MSB = 1
            alu_shift_res_33 <= "0" & X"FFFF_FF" & alu_a(6 downto 0) & "0"; -- Sign extend with "FFFF_FF"
          else                            -- new MSB = 0
            alu_shift_res_33 <= "0" & X"0000_00" & alu_a(6 downto 0) & "0"; -- Sign extend with "0000_00"
          end if;
        when others => 
          alu_shift_res_33 <= ZERO; -- Undefined  
      end case;      
    else if alu_op = LSR then
      case data_size is
        when WORD =>
          alu_shift_res_33 <= "0" & "0" & alu_a(31 downto 1); 
        when HALF =>
          alu_shift_res_33 <= "0" & X"0000" & alu_a(15 downto 1); -- Always sign extend with zeroes       
        when BYTE =>
          alu_shift_res_33 <= "0" & X"0000_00" & alu_a(7 downto 1); -- Always sign extend with zeroes 
        when others =>
          alu_shift_res_33 <= ZERO; -- Undefined
      end case; 
    else
      alu_shift_res_33 <= ZERO;
  end process;


  -- 2.C Perform regular ALU operation
  with alu_op select
    alu_res_33 <= 
                  alu_a_33 when ALU_PASS, -- Just pass:
                                          -- MOVE,  STORE, STORE_PM, STORE_VGA, OUT                 
                                  
                  alu_a_33 + alu_b_33 when ADD, -- ADD, ADDI
                  alu_a_33 - alu_b_33 when SUBB, -- SUB, SUBI, CMP, CMPI
                  ZERO - alu_a_33 when NEG, -- NEG - negate
                  alu_a_33 + ONE when INC, -- INC - increment,
                  alu_a_33 - ONE when DEC, -- DEC - decrement 

                  alu_res_66(32 downto 0) when MUL, -- MUL - multiplication for signed integers 

                  alu_shift_res_33 when LSL, -- LSL
                  alu_shift_res_33 when LSR, -- LSR

                  alu_a_33 and alu_b_33 when ANDD, -- AND 
                  alu_a_33 or alu_b_33 when ORR, -- OR 
                  alu_a_33 xor alu_b_33 when XORR, -- XOR 
                  not alu_a_33 when NOTT, -- NOT 
                  
                  "0" & alu_a_33(31 downto 16) & alu_b_33(15 downto 0) when MOVLO, -- MOVLO: rA(31 downto 16) & IMM
                  "0" & alu_b_33(15 downto 0) & alu_a_33(15 downto 0) when MOVHI, -- MOVHI:  IMM & rA(15 downto 0)

                  ZERO when others; -- Do nothing: 
                                    -- NOP, LOAD, BREQ, BRNE, BRLT, BRGT, BRLE, BRGE, RJMP, RJMPREG
                                    -- IN


  


  -- 3. Calculate flags
  -- Zero flag
  Z_next <= '1' when alu_res_33(31 downto 0) = X"0000_0000" else '0';

  -- Negative flag
  N_next <= alu_res_33(31); -- Most significant bit of the result 

  -- Overflow flag
  -- Logic depends on operation
  with alu_op select
      O_next <= (alu_res_33(31) and not alu_a_33(31) and not alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and alu_b_33(31)) 
              when ADD, -- ADD
                (alu_res_33(31) and not alu_a_33(31)) or
                (not alu_res_33(31) and alu_a_33(31))
              when INC, -- INC
                (alu_res_33(31) and not alu_a_33(31) and alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and not alu_b_33(31))
              when SUBB, -- SUB
                (alu_res_33(31) and not alu_a_33(31)) or 
                (not alu_res_33(31) and alu_a_33(31))
              when DEC, -- DEC
                '0'
              when others;

  -- Carry flag
  C_next <= alu_res_33(32); -- Carry bit of of the result


  -- 4. Change result data back to correct size
  alu_res_n <= alu_res_33(31 downto 0);

  -- 5. Assign next result and flags to registers
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        alu_res <= ZERO_32;

        Z_flag <= '0';
        N_flag <= '0';
        O_flag <= '0';
        C_flag <= '0';
      else
        alu_res <= alu_res_n;
        
        if update_flags_control_signal = "1" then
          Z_flag <= Z_next;
          N_flag <= N_next;
          O_flag <= O_next;
          C_flag <= C_next; 
        else 
          Z_flag <= Z_flag;
          N_flag <= N_flag;
          O_flag <= O_flag;
          C_flag <= C_flag;
        end if;
      end if;
    end if;
  end process;

end architecture;
