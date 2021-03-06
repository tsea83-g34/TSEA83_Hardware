library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.PIPECPU_STD.ALL;

entity ALU is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        update_flags_control_signal : in alu_update_flags_enum;
        data_size_control_signal : in byte_mode;
        alu_op_control_signal : in alu_op;

        alu_a : in unsigned(31 downto 0); -- rA
        alu_b : in unsigned(31 downto 0); -- rB or IMM

        alu_res : out unsigned(31 downto 0) := X"0000_0000";

        Z_flag, N_flag, O_flag, C_flag : out std_logic := '0'
  );
end ALU;

architecture Behavioral of ALU is
  constant ZERO_32 : unsigned(31 downto 0) := X"0000_0000"; -- Nop constant variable
  constant ZERO : unsigned(32 downto 0) := "0" & X"0000_0000"; -- Zero constant variable
  constant ONE : unsigned(32 downto 0) := "0" & X"0000_0001"; -- one constant variable
  
  signal alu_a_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
  signal alu_b_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
  signal alu_res_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
  signal alu_shift_res_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
  signal alu_res_mul : unsigned(31 downto 0) := X"0000_0000";

  signal N_next, O_next, C_next : std_logic := '0';

begin
  -- 1. Change data to right size. 
  alu_a_33 <= '0' & alu_a;
  alu_b_33 <= '0' & alu_b;
       
 
  -- 2. Perform ALU operation and calculate result
  
  -- 2.A Perform 66 bit operation (multiply)
  alu_res_mul <= unsigned(signed(alu_a_33(15 downto 0)) * signed(alu_b_33(15 downto 0)));
  

  -- 2.B Perform shifting ALU operation, which depends on size
  process(alu_op_control_signal, data_size_control_signal, alu_a) 
  begin
    if alu_op_control_signal = ALU_LSL then

      case data_size_control_signal is
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

    elsif alu_op_control_signal = ALU_LSR then

      case data_size_control_signal is
        when WORD =>
          alu_shift_res_33 <= "0" & "0" & alu_a(31 downto 1); 
        when HALF =>
          alu_shift_res_33 <= "0" & X"0000" & "0" & alu_a(15 downto 1); -- Always sign extend with zeroes       
        when BYTE =>
          alu_shift_res_33 <= "0" & X"0000_00" & "0" & alu_a(7 downto 1); -- Always sign extend with zeroes 
        when others =>
          alu_shift_res_33 <= ZERO; -- Undefined
      end case; 

    else
      alu_shift_res_33 <= ZERO; -- Irrelevant signal
    end if;
  end process;


  -- 2.C Perform regular ALU operation
  with alu_op_control_signal select
    alu_res_33 <= 
                  alu_a_33 when ALU_PASS, -- Just pass:
                                          -- MOVE,  STORE, STORE_PM, STORE_VGA, OUT                 
                                  
                  alu_a_33 + alu_b_33 when ALU_ADD, -- ADD, ADDI
                  alu_a_33 - alu_b_33 when ALU_SUB, -- SUB, SUBI, CMP, CMPI
                  ZERO - alu_a_33 when ALU_NEG, -- NEG - negate
                  alu_a_33 + ONE when ALU_INC, -- INC - increment,
                  alu_a_33 - ONE when ALU_DEC, -- DEC - decrement

                  alu_shift_res_33 when ALU_LSL, -- LSL
                  alu_shift_res_33 when ALU_LSR, -- LSR

                  alu_a_33 and alu_b_33 when ALU_AND, -- AND 
                  alu_a_33 or alu_b_33 when ALU_OR, -- OR 
                  alu_a_33 xor alu_b_33 when ALU_XOR, -- XOR 
                  not alu_a_33 when ALU_NOT, -- NOT 
                  
                  "0" & alu_a_33(31 downto 16) & alu_b_33(15 downto 0) when ALU_MOVLO, -- MOVLO: rA(31 downto 16) & IMM
                  "0" & alu_b_33(15 downto 0) & alu_a_33(15 downto 0) when ALU_MOVHI, -- MOVHI:  IMM & rA(15 downto 0)

                  ZERO when others; -- Do nothing: 
                                    -- NOP, LOAD, BREQ, BRNE, BRLT, BRGT, BRLE, BRGE, RJMP, RJMPREG
                                    -- IN


  


  -- 3. Calculate flags

  -- Negative flag
  N_next <= alu_res_33(31); -- Most significant bit of the result 
  
  -- Overflow flag
  -- Logic depends on operation
  with alu_op_control_signal select
      O_next <= (alu_res_33(31) and not alu_a_33(31) and not alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and alu_b_33(31)) 
              when ALU_ADD, -- ADD
                (alu_res_33(31) and not alu_a_33(31)) or
                (not alu_res_33(31) and alu_a_33(31))
              when ALU_INC, -- INC
                (alu_res_33(31) and not alu_a_33(31) and alu_b_33(31)) or
                (not alu_res_33(31) and alu_a_33(31) and not alu_b_33(31))
              when ALU_SUB, -- SUB
                (alu_res_33(31) and not alu_a_33(31)) or 
                (not alu_res_33(31) and alu_a_33(31))
              when ALU_DEC, -- DEC
                '0'
              when others;

  -- Carry flag
  C_next <= alu_res_33(32); -- Carry bit of of the result

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
      
        -- 4. Change result data back to correct size
        case alu_op_control_signal is
          when ALU_MUL => alu_res <= alu_res_mul;  -- MUL - multiplication for signed integers
          when others  => alu_res <= alu_res_33(31 downto 0);
        end case;
        
        if update_flags_control_signal = ALU_FLAGS then
          -- Zero flag
          if alu_res_33(31 downto 0) = X"0000_0000" then
            Z_flag <= '1';
          else
            Z_flag <= '0';
          end if;
          
          N_flag <= N_next;
          O_flag <= O_next;
          C_flag <= C_next;
          
        -- Else, keep old value
          
        end if;
      end if;
    end if;
  end process;

end architecture;
