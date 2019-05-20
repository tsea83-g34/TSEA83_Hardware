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

begin
  

  process(clk)
  
    variable alu_a_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
    variable alu_b_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
    variable alu_res_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
    variable alu_shift_res_33 : unsigned(32 downto 0) := "0" & X"0000_0000";
    variable alu_res_66 : unsigned(65 downto 0) := X"0000_0000_0000_0000" & "00";
 
 begin
    
    if rising_edge(clk) then 
  
    -- Change data to right size. 
      alu_a_33 := '0' & alu_a;
      alu_b_33 := '0' & alu_b;
    
    -- Perform ALU operation and calculate result
    
      -- A Perform 66 bit operation (multiply)
      --alu_res_66 := unsigned(signed(alu_a_33) * signed(alu_b_33));
    
      -- B Perform shifting ALU operation, which depends on size
      if alu_op_control_signal = ALU_LSL then

        case data_size_control_signal is
          when WORD =>
            alu_shift_res_33 := "0" & alu_a(30 downto 0) & "0";
          when HALF =>
            if alu_a(14) = '1' then -- new MSB = 1
              alu_shift_res_33 := "0" & X"FFFF" & alu_a(14 downto 0) & "0"; -- Sign extend with "FFFF"
            else                              -- new MSB = 0
              alu_shift_res_33 := "0" & X"0000" & alu_a(14 downto 0) & "0"; -- Sign extend with "0000"
            end if;
          when BYTE =>
            if alu_a(6) = '1' then -- new MSB = 1
              alu_shift_res_33 := "0" & X"FFFF_FF" & alu_a(6 downto 0) & "0"; -- Sign extend with "FFFF_FF"
            else                            -- new MSB = 0
              alu_shift_res_33 := "0" & X"0000_00" & alu_a(6 downto 0) & "0"; -- Sign extend with "0000_00"
            end if;
          when others => 
            alu_shift_res_33 := ZERO; -- Undefined  
        end case;      

      elsif alu_op_control_signal = ALU_LSR then

        case data_size_control_signal is
          when WORD =>
            alu_shift_res_33 := "0" & "0" & alu_a(31 downto 1); 
          when HALF =>
            alu_shift_res_33 := "0" & X"0000" & "0" & alu_a(15 downto 1); -- Always sign extend with zeroes       
          when BYTE =>
            alu_shift_res_33 := "0" & X"0000_00" & "0" & alu_a(7 downto 1); -- Always sign extend with zeroes 
          when others =>
            alu_shift_res_33 := ZERO; -- Undefined
        end case; 

      else
        alu_shift_res_33 := ZERO; -- Irrelevant signal
      end if;
    
      -- C Perform regular ALU operation
      case alu_op_control_signal is
        when ALU_PASS => alu_res_33 := alu_a_33; -- Just pass:
                                                 -- MOVE,  STORE, STORE_PM, STORE_VGA, OUT                 
                        
        when ALU_ADD => alu_res_33 := alu_a_33 + alu_b_33; -- ADD, ADDI
        when ALU_SUB => alu_res_33 := alu_a_33 - alu_b_33; -- SUB, SUBI, CMP, CMPI
        when ALU_NEG => alu_res_33 := ZERO - alu_a_33;     -- NEG - negate
        when ALU_INC => alu_res_33 := alu_a_33 + ONE;      -- INC - increment,
        when ALU_DEC => alu_res_33 := alu_a_33 - ONE;      -- DEC - decrement 

        --when ALU_MUL => alu_res_33 := alu_res_66(32 downto 0); -- MUL - multiplication for signed integers 

        when ALU_LSL => alu_res_33 := alu_shift_res_33; -- LSL
        when ALU_LSR => alu_res_33 := alu_shift_res_33; -- LSR

        when ALU_AND => alu_res_33 := alu_a_33 and alu_b_33; -- AND 
        when ALU_OR  => alu_res_33 := alu_a_33 or alu_b_33;  -- OR 
        when ALU_XOR => alu_res_33 := alu_a_33 xor alu_b_33; -- XOR 
        when ALU_NOT => alu_res_33 := not alu_a_33;          -- NOT 
        
        when ALU_MOVLO => alu_res_33 := "0" & alu_a_33(31 downto 16) & alu_b_33(15 downto 0); -- MOVLO: rA(31 downto 16) & IMM
        when ALU_MOVHI => alu_res_33 := "0" & alu_b_33(15 downto 0) & alu_a_33(15 downto 0);  -- MOVHI:  IMM & rA(15 downto 0)

        when others => alu_res_33 := ZERO; -- Do nothing: 
      end case;                            -- NOP, LOAD, BREQ, BRNE, BRLT, BRGT, BRLE, BRGE, RJMP, RJMPREG, IN
      
      -- Change result data back to correct size and output
      alu_res <= alu_res_33(31 downto 0);
      
      -- Update flags
      if update_flags_control_signal = ALU_FLAGS then
      
        -- Calculate flags
        
        -- Zero flag
        case alu_res_33(31 downto 0) = x"0000_0000" is
          when True    => Z_flag <= '1';
          when others  => Z_flag <= '0';
        end case;
        
        -- Negative flag
        N_flag <= alu_res_33(31); -- Most significant bit of the result
        
        -- Overflow flag
        -- Logic depends on operation
        case alu_op_control_signal is
                  when ALU_ADD => O_flag <= (alu_res_33(31) and not alu_a_33(31) and not alu_b_33(31)) or
                                            (not alu_res_33(31) and alu_a_33(31) and alu_b_33(31));        -- ADD

                  when ALU_INC => O_flag <= (alu_res_33(31) and not alu_a_33(31)) or
                                            (not alu_res_33(31) and alu_a_33(31));                         -- INC
                  
                  when ALU_SUB => O_flag <= (alu_res_33(31) and not alu_a_33(31) and alu_b_33(31)) or
                                            (not alu_res_33(31) and alu_a_33(31) and not alu_b_33(31));    -- SUB

                  when ALU_DEC => O_flag <= (alu_res_33(31) and not alu_a_33(31)) or 
                                            (not alu_res_33(31) and alu_a_33(31));                         -- DEC

                  when others  => O_flag <= '0';
        end case;
         
        -- Carry flag
        C_flag <= alu_res_33(32); -- Carry bit of of the result
        
      -- Else, keep old flags
      
      end if;
    end if;
  end process;
end architecture;
