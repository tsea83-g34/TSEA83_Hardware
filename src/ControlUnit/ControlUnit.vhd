library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;



entity control_unit is
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
        IR1_op : buffer op_enum;
        IR2_op : buffer op_enum;
        IR3_op : buffer op_enum;
        IR4_op : buffer op_enum;          

        -- Pipeline
        pipe_control_signal : out pipe_op;        

        -- PM 
        pm_control_signal : out unsigned(2 downto 0);
    
        -- RegisterFile control SIGNALS
        rf_read_d_or_b_control_signal : out std_logic;
        rf_write_d_control_signal : out std_logic;
        
        -- DataForwarding        
        df_a_select : out df_select;
        df_b_select : out df_select;    
        df_imm_or_b : out std_logic; -- 1 for IMM, 0 for b
        df_ar_a_or_b : out std_logic; -- 1 for a, 0 for b

        -- ALU control signals  
        alu_update_flags_control_signal : out std_logic; -- 1 for true 0 for false
        alu_data_size_control_signal : out byte_mode;
        alu_op_control_signal : out alu_op;

        -- KEYBOARD
        kb_read_control_signal : out kb_read_enum;
        
        -- DataMemory
        dm_write_or_read_control_signal : out std_logic;
        dm_size_mode_control_signal : out byte_mode;

        -- VideoMemory
        vm_write_enable_control_signal : out std_logic;

        -- WriteBackLogic
        wb3_in_or_alu3 : out wb3_in_or_alu3_enum;
        wb4_dm_or_alu4 : out  wb4_dm_or_alu4_enum
        
  );
end control_unit;

architecture Behavioral of control_unit is
  -- INPUT ALIASES
  -- IR1 signals
  alias IR1_op_code is IR1(31 downto 26);
  alias IR1_a is IR1(19 downto 16);
  alias IR1_b is IR1(15 downto 12);
  alias IR1_read is IR1(31 downto 31);

  -- IR2 signals
  alias IR2_op_code is IR2(31 downto 26);
  alias IR2_s is IR2(25 downto 24);
  alias IR2_a is IR2(19 downto 16);
  alias IR2_b is IR2(15 downto 12);
  alias IR2_d is IR2(23 downto 20);

	alias IR2_read is IR2(31 downto 31);

  -- IR3 signals
  alias IR3_op_code is IR3(31 downto 26);
  alias IR3_s is IR3(25 downto 24);
  alias IR3_d is IR3(23 downto 20);
  alias IR3_a is IR2(19 downto 16);
  alias IR3_b is IR2(15 downto 12);

  signal IR3_write : std_logic;

  -- IR4 signals
  alias IR4_op_code is IR4(31 downto 26);
  alias IR4_d is IR4(23 downto 20);

  signal IR4_write : std_logic;
    
  -- General Data Stalling
  signal should_jump : std_logic := '0';
  signal should_stall : std_logic := '0';

  -- OUTPUT ALIASES
  -- Program Memory 
  alias pm_stall_or_jump : unsigned(1 downto 0) is pm_control_signal(1 downto 0); -- "10" = stall not jump, "01" = jump not stall, "00"/"11" nop
  alias pm_write_enable : unsigned(0 downto 0) is pm_control_signal(2 downto 2); -- 1 for enable

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
            NOP when others; 

  with IR2_op_code select 
  IR2_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when others; 

  with IR3_op_code select 
  IR3_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when others; 

  with IR4_op_code select 
  IR4_op <= LOAD when OP_LOAD, STORE when OP_STORE, STORE_PM when OP_STORE_PM, MOVHI when OP_MOVHI, MOVLO when OP_MOVLO,
            STORE_VGA when OP_STORE_VGA, MOVE when OP_MOVE, ADD when OP_ADD, ADDI when OP_ADDI, SUBB when OP_SUBB, 
            SUBI when OP_SUBI, NEG when OP_NEG, INC when OP_INC, DEC when OP_DEC, MUL when OP_MUL, 
            CMP when OP_CMP, CMPI when OP_CMPI, LSL when OP_LSL, LSR when OP_LSR, 
            ANDD when OP_ANDD, ORR when OP_ORR, XORR when OP_XORR, NOTT when OP_NOTT,
            BREQ when OP_BREQ, BRNE when OP_BRNE, BRLT when OP_BRLT, BRGT when OP_BRGT, BRLE when OP_BRLE, 
            BRGE when OP_BRGE, RJMP when OP_RJMP, RJMPRG when OP_RJMPRG, INN when OP_IN, OUTT when OP_OUT,
            NOP when others; 

  -- ---------------------- General logic signals ----------------------
  -- JUMP / STALL signals
  should_stall <= '1' when (
                        IR1_read = "1" and (
                          (IR2_op = LOAD or IR2_op = INN) and
                          (IR2_d = IR1_a or IR2_d = IR1_b)
                        )
                      ) else 
                  '0';
  
  should_jump <= '1' when (
                        (IR2_op = BREQ and Z_flag = '1') or
                        (IR2_op = BRNE and Z_flag = '0') or
                        (IR2_op = BRLT and (N_flag xor O_flag) = '1') or
                        (IR2_op = BRGT and (N_flag xnor O_flag ) = '1') or -- Either Positive and no underflow, or Negative and overflow 
                        (IR2_op = BRLE and ((N_flag = '1' xor O_flag = '1') or Z_flag = '1')) or
                        (IR2_op = BRGE and ((N_flag = '1' xnor O_flag = '1') or Z_flag = '1')) or
                        (IR2_op = RJMP)) else 
                 '0';  

  -- WRITE signals 
  IR3_write <= '1' when  (IR3_op = ADD or IR3_op = ADDI or IR3_op = SUBI or IR3_op = NEG or
                         IR3_op = INC or IR3_op = DEC or IR3_op = MUL or
                         IR3_op = LSL or IR3_op = LSR or 
                         IR3_op = ANDD or IR3_op = ORR or IR3_op = XORR or IR3_op = NOTT or
                         IR3_op = LOAD or IR3_op = MOVE or IR3_op = MOVHI or IR3_op = MOVLO or 
                         IR3_op = INN) else
               '0';

   IR4_write <= '1' when (IR4_op = ADD or IR4_op = ADDI or IR4_op = SUBI or IR4_op = NEG or
                         IR4_op = INC or IR4_op = DEC or IR4_op = MUL or
                         IR4_op = LSL or IR4_op = LSR or
                         IR4_op = ANDD or IR4_op = ORR or IR4_op = XORR or IR4_op = NOTT or
                         IR4_op = LOAD or IR4_op = MOVE or IR4_op = MOVHI or IR4_op = MOVLO or
                         IR4_op = INN) else
                '0';

  
  -- ---------------------------- PIPECPU --------------------------------

  pipe_control_signal <= PIPE_JMP when should_jump = '1' else 
                         PIPE_STALL when should_stall = '1' else 
                         PIPE_NORMAL;


  -- ------------------------- PROGRAM MEMORY ----------------------------
  -- Program Memory IR1 control signals
  pm_stall_or_jump <= "10" when should_stall = '1' and should_jump = '0' else
                      "01" when should_stall = '0' and should_jump = '1' else
                      "00";
  

  -- ------------------------- REGISTER FILE -----------------------------
  -- Register File read control signals
  rf_read_d_or_b_control_signal <= '1' when (IR1_op = STORE or IR1_op = STORE_PM or IR1_op = STORE_VGA) else -- Should read from rD.
                                   '0';

  -- Register File write control signals
  rf_write_d_control_signal <= IR4_write;


  -- ------------------------- DATA FORWARDING ----------------------------

  process(IR2, IR3, IR4) -- Process statement for easier syntax
  begin
    -- Standard control signal, overwritten in if statements below if necessary
    --df_a_select <= from_RF; 
    --df_b_select <= from_RF;  
    if IR2_read = "1" then -- Read register bit is set
      if IR3_write = '1' then
        if IR3_d = IR2_a then
          df_a_select <= from_D3; -- IR2_a <= D3
        elsif IR3_d = IR3_b then
          df_b_select <= from_D3; -- IR2_b <= D3
        end if;
			end if;      
			if IR4_write = '1' then
        if IR4_d = IR2_a and IR3_d /= IR2_a then -- Make sure that shouldn't be dataforwarded from D3
          df_a_select <= from_D4; -- IR2_a <= D4
        elsif IR4_d = IR2_b and IR3_d /= IR2_b then -- Make sure that shouldn't be dataforwarded from D3 
          df_b_select <= from_D4; -- IR2_b <= D4
        end if;
      end if;
    end if;
  end process;
	

  df_imm_or_b <= '1' when (IR2_op = ADDI or IR2_op = SUBI or IR2_op = CMPI or -- IMM
                        IR2_op = MOVHI or IR2_op = MOVLO) else  					 -- IMM
              '0'; 		-- rB
  
  df_ar_a_or_b <= '1' when IR2_op = LOAD else  -- offs + rA
               '0'; 	-- STORE, STORE_PM, STORE_VGA , (offs + rD), or not important

  
  -- -------------------------------- ALU ----------------------------------
  -- ALU operation control signal
  with IR2_op select
  alu_op_control_signal <= 
                          ALU_PASS when MOVE,
                          ALU_PASS when STORE,
                          ALU_PASS when STORE_PM,
                          ALU_PASS when STORE_VGA,
                          ALU_PASS when OUTT,
                          
                          ALU_ADD when ADD,
                          ALU_ADD when ADDI,
                          ALU_SUB when SUBB,
                          ALU_SUB when SUBI,
                          ALU_SUB when CMP,
                          ALU_SUB when CMPI,
                          ALU_NEG when NEG,
                          ALU_INC when INC,
                          ALU_DEC when DEC,

                          ALU_MUL when MUL,

                          ALU_LSL when LSL,
                          ALU_LSR when LSR,

                          ALU_AND when ANDD,
                          ALU_OR when ORR,
                          ALU_XOR when XORR,
                          ALU_NOT when NOTT,

                          ALU_MOVLO when MOVLO,
                          ALU_MOVHI when MOVHI,

                          ALU_NOP when others;

  -- Data size control signal
  with IR2_s select
  alu_data_size_control_signal <= WORD when "11",
                                  HALF when "10",
                                  BYTE when "01",
                                  NAN when others;

  

  -- Update flags control signal
  alu_update_flags_control_signal <= '1' when (IR2_op = ADDI or IR2_op = SUBI or IR2_op = ADD or 
                                              IR2_op = SUBB or IR2_op = NEG or IR2_op = INC or
                                              IR2_op = DEC or IR2_op = MUL or IR2_op = ANDD or
                                              IR2_op = ORR or IR2_op = XORR or IR2_op = NOTT or
                                              IR2_op = CMP or IR2_op = CMPI)
                                         else
                                     '0';
  
  -- ----------------------------- DATA MEMORY -----------------------------
  with IR3_op select
  dm_write_or_read_control_signal <= '1' when STORE,  -- write
                                     '0' when others; -- read
  
  with IR3_s select
  dm_size_mode_control_signal <= WORD when "11",
                                 HALF when "10",
                                 BYTE when "01",
                                 NAN when others;


  -- ----------------------------- VIDEO MEMORY -----------------------------
  with IR3_op select 
  vm_write_enable_control_signal <= '1' when STORE_VGA,
                                    '0' when others;


  -- --------------------------- WRITE BACK LOGIC ----------------------------
  with IR3_op select
  wb3_in_or_alu3 <= WB3_IN when INN, 
                    WB3_ALU3 when others;
  
  with IR4_op select
  wb4_dm_or_alu4 <= WB4_DM when LOAD,
                    WB4_ALU4 when others;
  
  -- -------------------------- KEYBOARD DECODER -----------------------------
  kb_read_control_signal <= KB_READ when (IR3_op = INN and IR3_a = 0) else -- Keyboard is port 0
                            KB_NO_READ;


  -- ------------------------------- END -------------------------------------
end Behavioral;
