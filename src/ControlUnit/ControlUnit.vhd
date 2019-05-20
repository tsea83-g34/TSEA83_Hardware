library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;


entity ControlUnit is
  port (
        clk : in std_logic;
        rst : in std_logic;

        -- IR in
        IR1 : in unsigned(31 downto 0);
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);

        -- Flags input
        Z_flag : in std_logic;
        N_flag : in std_logic;
        O_flag : in std_logic;
        C_flag : in std_logic;
      
        -- Debugging outputs
        IR1_op : out op_enum   :=  NOP;
        IR2_op : out op_enum   :=  NOP;
        IR3_op : out op_enum   :=  NOP;
        IR4_op : out op_enum   :=  NOP;   

        -- Pipeline
        pipe_control_signal : out pipe_op :=  PIPE_NORMAL;        

        -- Program Memory
        pm_jmp_stall : out pm_jmp_stall_enum  :=  PM_NORMAL;
        pm_write_enable : out pm_write_enum   :=  PM_NO_WRITE;
    
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal : out rf_read_d_or_b_enum   :=  RF_READ_B;
        rf_write_d_control_signal : out rf_write_d_enum           :=  RF_NO_WRITE_D;
        
        -- DataForwarding        
        df_a_select : out df_select                     := DF_FROM_RF;
        df_b_select : out df_select                     := DF_FROM_RF;
        df_alu_imm_or_b : out df_alu_imm_or_b_enum      := DF_ALU_B;
        df_ar_a_or_b : out df_ar_a_or_b_enum            :=   DF_AR_B;

        -- ALU control signals  
        alu_update_flags_control_signal : out alu_update_flags_enum     :=  ALU_NO_FLAGS;
        alu_data_size_control_signal : out byte_mode                    :=  NAN;
        alu_op_control_signal : out alu_op                              :=  ALU_NOP;


        kb_read_control_signal : out std_logic := '0';
        uart_read_control_signal : out std_logic := '0';

        
        -- DataMemory
        dm_write_or_read_control_signal : out dm_write_or_read_enum     :=  DM_READ;
        dm_size_mode_control_signal : out byte_mode                     :=  NAN;

        -- VideoMemory
        vm_write_enable_control_signal : out vm_write_enable_enum       :=  VM_NO_WRITE;

        -- WriteBackLogic

        wb3_in_or_alu3 : out wb3_in_or_alu3_enum              :=  WB3_ALU3;
        wb4_dm_or_alu4 : out  wb4_dm_or_alu4_enum             :=  WB4_ALU4;
        in_port : out unsigned(3 downto 0) := X"0";
        -- LED
        led_write_control_signal : out std_logic  :=  '0'

        
  );
end ControlUnit;

architecture Behavioral of ControlUnit is
  -- INPUT ALIASES
  -- IR1 signals
  alias IR1_op_code is IR1(31 downto 26);
  alias IR1_a is IR1(19 downto 16);
  alias IR1_b is IR1(15 downto 12);
  alias IR1_d is IR1(23 downto 20);
  alias IR1_rf_read is IR1(31 downto 31);

  -- IR2 signals
  alias IR2_op_code is IR2(31 downto 26);
  alias IR2_s is IR2(25 downto 24);
  alias IR2_a is IR2(19 downto 16);
  alias IR2_b is IR2(15 downto 12);
  alias IR2_d is IR2(23 downto 20);

	alias IR2_rf_read is IR2(31 downto 31);

  -- IR3 signals
  alias IR3_op_code is IR3(31 downto 26);
  alias IR3_s is IR3(25 downto 24);
  alias IR3_d is IR3(23 downto 20);
  alias IR3_a is IR3(19 downto 16);
  alias IR3_b is IR3(15 downto 12);

  signal IR3_rf_write : std_logic   :=  '0';

  -- IR4 signals
  alias IR4_op_code is IR4(31 downto 26);
  alias IR4_d is IR4(23 downto 20);

  signal IR4_rf_write : std_logic   :=  '0';
    
  -- General logic signals
  signal should_jump : std_logic    :=  '0';
  signal should_stall : std_logic   :=  '0';

  signal IR1_read_d : std_logic     :=  '0';
  signal IR2_read_d : std_logic     :=  '0';   
  
  signal IR1_read_b : std_logic     :=  '0';
  signal IR2_read_b : std_logic     :=  '0';
  
 begin

  ----------------------- Decode op codes to enum  --------------------------

  with IR1_op_code select 
  IR1_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when OP_NOP, NOT_FOUND when others;

  with IR2_op_code select 
  IR2_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when OP_NOP, NOT_FOUND when others; 

  with IR3_op_code select 
  IR3_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when OP_NOP, NOT_FOUND when others; 

  with IR4_op_code select 
  IR4_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when OP_NOP, NOT_FOUND when others; 



  -- ---------------------- General logic signals ----------------------
  
    -- JUMP / STALL signals
  should_stall <= '1' when (
                         (IR1_read_b = '1' and IR2_op_code = OP_LOAD and (IR2_d = IR1_a or IR2_d = IR1_b)) or
                         (IR1_read_d = '1' and IR2_op_code = OP_LOAD and (IR2_d = IR1_a or IR2_d = IR1_d))
                      ) else 
                  '0';
  
  
  should_jump <= '1' when (
                        (IR2_op_code = OP_BREQ and Z_flag = '1') or                                     -- EQUALS
                        (IR2_op_code = OP_BRNE and Z_flag = '0') or                                     -- NOT EQUALS
                        (IR2_op_code = OP_BRLT and (N_flag xor O_flag) = '1') or                          -- LESS THAN
                        (IR2_op_code = OP_BRGT and Z_flag = '0' and (N_flag xnor O_flag ) = '1') or     -- GREATER THAN 
                        (IR2_op_code = OP_BRLE and (Z_flag = '1' or (N_flag = '1' xor O_flag = '1'))) or  -- LESS THAN OR EQUALS
                        (IR2_op_code = OP_BRGE and (N_flag = '1' xnor O_flag = '1')) or                 -- GREATER THAN OR EQUALS
                        (IR2_op_code = OP_RJMP) or                                                      -- REL JUMP
                        (IR2_op_code = OP_RJMPRG)                                                       -- REGISTER REL JUMP
                     ) else 
                 '0';
                 
                 
                                  
  -- WRITE signals 
  IR3_rf_write <= '1' when  (IR3_op_code = OP_ADD or IR3_op_code = OP_ADDI or IR3_op_code = OP_SUBI or IR3_op_code = OP_SUBB or
                             IR3_op_code = OP_INC or IR3_op_code = OP_DEC or IR3_op_code = OP_MUL or IR3_op_code = OP_NEG or
                             IR3_op_code = OP_LSL or IR3_op_code = OP_LSR or 
                             IR3_op_code = OP_ANDD or IR3_op_code = OP_ORR or IR3_op_code = OP_XORR or IR3_op_code = OP_NOTT or
                             IR3_op_code = OP_LOAD or IR3_op_code = OP_MOVE or IR3_op_code = OP_MOVHI or IR3_op_code = OP_MOVLO or 
                             IR3_op_code = OP_IN) else
                  '0';

  IR4_rf_write <= '1' when (IR4_op_code = OP_ADD or IR4_op_code = OP_ADDI or IR4_op_code = OP_SUBI or IR4_op_code = OP_SUBB or
                            IR4_op_code = OP_INC or IR4_op_code = OP_DEC or IR4_op_code = OP_MUL or IR4_op_code = OP_NEG or
                            IR4_op_code = OP_LSL or IR4_op_code = OP_LSR or
                            IR4_op_code = OP_ANDD or IR4_op_code = OP_ORR or IR4_op_code = OP_XORR or IR4_op_code = OP_NOTT or
                            IR4_op_code = OP_LOAD or IR4_op_code = OP_MOVE or IR4_op_code = OP_MOVHI or IR4_op_code = OP_MOVLO or
                            IR4_op_code = OP_IN) else
                  '0';


  -- Read d logic
  IR1_read_d <= '1' when (IR1_op_code = OP_STORE or IR1_op_code = OP_STORE_PM or IR1_op_code = OP_STORE_VGA) else
                '0';


  IR2_read_d <= '1' when (IR2_op_code = OP_STORE or IR2_op_code = OP_STORE_PM or IR2_op_code = OP_STORE_VGA) else
                '0';
  
  -- Read b logic
  IR1_read_b <= '1' when IR1_rf_read = "1" and IR1_read_d = '0' else
  '0';
  
  
  IR2_read_b <= '1' when IR2_rf_read = "1" and IR2_read_d = '0' else
                '0';


  -- ---------------------------- PIPECPU --------------------------------

  pipe_control_signal <= PIPE_JMP when should_jump = '1' else 
                         PIPE_STALL when should_stall = '1' else 
                         PIPE_NORMAL;

                      
  -- ------------------------- REGISTER FILE -----------------------------
  -- Register File read control signal
  rf_read_d_or_b_control_signal <= RF_READ_D when (IR1_read_d = '1') else -- STORE, STORE_PM, STORE_VGA
                                   RF_READ_B;

  -- Register File write control signal
  rf_write_d_control_signal <= RF_WRITE_D when IR4_rf_write = '1' else
                               RF_NO_WRITE_D;


  -- ------------------------- DATA FORWARDING ----------------------------  

  df_a_select <= DF_FROM_D3 when (IR2_rf_read = "1" and IR3_rf_write = '1' and IR2_a = IR3_d) else
                 DF_FROM_D4 when (IR2_rf_read = "1" and IR4_rf_write = '1' and IR2_a = IR4_d) else
                 DF_FROM_RF;


  df_b_select <= DF_FROM_D3 when (IR2_read_b = '1' and IR3_rf_write = '1' and IR2_b = IR3_d) else -- read B register
                 DF_FROM_D4 when (IR2_read_b = '1' and IR4_rf_write = '1' and IR2_b = IR4_d) else -- read B register
                 DF_FROM_D3 when (IR2_read_d = '1' and IR3_rf_write = '1' and IR2_d = IR3_d) else -- read D register
                 DF_FROM_D4 when (IR2_read_d = '1' and IR4_rf_write = '1' and IR2_d = IR4_D) else -- read D register
                 DF_FROM_RF;
  

  df_alu_imm_or_b <= DF_ALU_IMM when (IR2_op_code = OP_ADDI or IR2_op_code = OP_SUBI or IR2_op_code = OP_CMPI or -- IMM
                                      IR2_op_code = OP_MOVHI or IR2_op_code = OP_MOVLO) else  					 -- IMM
                     DF_ALU_B; 		-- rB
  
  df_ar_a_or_b <= DF_AR_A when IR2_op_code = OP_LOAD else  -- offs + rA
                  DF_AR_B; 	-- STORE, STORE_PM, STORE_VGA , (offs + rD), or not important

  
  -- -------------------------------- ALU ----------------------------------
  -- ALU operation control signal
  with IR2_op_code select
  alu_op_control_signal <= 
                          ALU_PASS when OP_MOVE,
                          ALU_PASS when OP_STORE,
                          ALU_PASS when OP_STORE_PM,
                          ALU_PASS when OP_STORE_VGA,
                          ALU_PASS when OP_OUT,
                          
                          ALU_ADD when OP_ADD,
                          ALU_ADD when OP_ADDI,
                          ALU_SUB when OP_SUBB,
                          ALU_SUB when OP_SUBI,
                          ALU_SUB when OP_CMP,
                          ALU_SUB when OP_CMPI,
                          ALU_NEG when OP_NEG,
                          ALU_INC when OP_INC,
                          ALU_DEC when OP_DEC,

                          ALU_MUL when OP_MUL,

                          ALU_LSL when OP_LSL,
                          ALU_LSR when OP_LSR,

                          ALU_AND when OP_ANDD,
                          ALU_OR  when OP_ORR,
                          ALU_XOR when OP_XORR,
                          ALU_NOT when OP_NOTT,

                          ALU_MOVLO when OP_MOVLO,
                          ALU_MOVHI when OP_MOVHI,

                          ALU_NOP when others;

  -- Data size control signal
  with IR2_s select
  alu_data_size_control_signal <= WORD when "11",
                                  HALF when "10",
                                  BYTE when "01",
                                  NAN when others;

  

  -- Update flags control signal
  alu_update_flags_control_signal <= ALU_FLAGS when (IR2_op_code = OP_ADDI or IR2_op_code = OP_SUBI or IR2_op_code = OP_ADD or 
                                                    IR2_op_code = OP_SUBB or IR2_op_code = OP_NEG or IR2_op_code = OP_INC or
                                                    IR2_op_code = OP_DEC or IR2_op_code = OP_MUL or IR2_op_code = OP_ANDD or
                                                    IR2_op_code = OP_ORR or IR2_op_code = OP_XORR or IR2_op_code = OP_NOTT or
                                                    IR2_op_code = OP_CMP or IR2_op_code = OP_CMPI) else
                                     ALU_NO_FLAGS;
  
  -- ----------------------------- DATA MEMORY -----------------------------
  with IR3_op_code select
  dm_write_or_read_control_signal <= DM_WRITE when OP_STORE,  -- write
                                     DM_READ when others; -- read
  
  with IR3_s select
  dm_size_mode_control_signal <= WORD when "11",
                                 HALF when "10",
                                 BYTE when "01",
                                 NAN when others;


  -- ------------------------- PROGRAM MEMORY ----------------------------
  pm_jmp_stall <= PM_STALL when should_stall = '1' and should_jump = '0' else
                  PM_JMP_REG when should_stall = '0' and should_jump = '1' and IR2_op_code = OP_RJMPRG else
                  PM_JMP_IMM when should_stall = '0' and should_jump = '1' else
                  PM_NORMAL when should_stall = '0' and should_jump = '0' else
                  PM_NAN;


  pm_write_enable <= PM_WRITE when IR3_op_code = OP_STORE_PM else
                     PM_NO_WRITE;


  -- ----------------------------- VIDEO MEMORY -----------------------------
  with IR3_op_code select 
  vm_write_enable_control_signal <= VM_WRITE when OP_STORE_VGA,
                                    VM_NO_WRITE when others;


  -- --------------------------- WRITE BACK LOGIC ----------------------------
  with IR3_op_code select
  wb3_in_or_alu3 <= WB3_IN when OP_IN, 
                    WB3_ALU3 when others;
  
  with IR4_op_code select
  wb4_dm_or_alu4 <= WB4_DM when OP_LOAD,
                    WB4_ALU4 when others;
  

  -- -------------------------- INPUT PORT READING -----------------------------
  kb_read_control_signal <= '1' when (IR3_op_code = OP_IN and IR3_a = x"0") else -- Keyboard is port 0
                            '0';

  uart_read_control_signal <= '1' when (IR3_op_code = OP_IN and IR3_a = x"1") else -- UART is port 1
                            '0';

  in_port <= IR3_a;
   
  ------------------------------- LED DRIVER  ------------------------------

  led_write_control_signal <= '1' when (IR4_op_code = OP_OUT and IR4_d = x"0") else 
                              '0';



  -- ------------------------------- END -------------------------------------
end Behavioral;
