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
        -- The Control Unit should only have IR1 (cur_PM(idx)) as input.
        -- The rest can just be preservered within *this component*, right?
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);

        -- Flags input
        Z_flag : in std_logic;
        N_flag : in std_logic;
        O_flag : in std_logic;
        C_flag : in std_logic; 
        
        -- PM 
        pm_control_signal : out unsigned(1 downto 0);
        pm_offset : out unsigned(15 downto 0);
        pm_write_data : out unsigned(31 downto 0);
        pm_write_address : out unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
        --

        pipe_control_signal : out unsigned(1 downto 0);

        -- RegisterFile control SIGNALS
        rf_write_d_control_signal : out std_logic;
        rf_a_address : out unsigned(3 downto 0);
        rf_b_address : out unsigned(3 downto 0);
        rf_d_address : out unsigned(3 downto 0);
        -- ALU control signals
        alu_update_flags_control_signal : out std_logic; -- 1 for true 0 for false
        data_size_control_signal : out byte_mode;
        alu_op_control_signal : out op_code;

        -- KEYBOARD
        keyboard_read_signal : out std_logic;

        df_control_signal : out unsigned(6 downto 0);
        dm_control_signal : out std_logic
  );
end control_unit;

architecture Behavioral of control_unit is
  -- INPUT ALIASES
  -- IR1 signals
  alias IR1_op is IR1(31 downto 26);
  alias IR1_a is IR1(19 downto 16);
  alias IR1_b is IR1(15 downto 12);

  -- IR2 signals
  alias IR2_op is IR2(31 downto 26);
  alias IR2_s is IR2(25 downto 24);
  alias IR2_a is IR2(19 downto 16);
  alias IR2_b is IR2(15 downto 12);

	alias IR2_read is IR2(31 downto 31);

  -- IR3 signals
  alias IR3_op is IR3(31 downto 26);
  alias IR3_s is IR3(25 downto 24);
  alias IR3_d is IR3(23 downto 20);
  alias IR3_a is IR2(19 downto 16);
  alias IR3_b is IR2(15 downto 12);

  signal IR3_write : std_logic;

  -- IR4 signals
  alias IR4_op is IR4(31 downto 26);
  alias IR4_d is IR3(23 downto 20);

  signal IR4_write : std_logic;
  
  -- Program Memory 
  signal should_jump: std_logic := '0';

  -- OUTPUT ALIASES
  alias df_control_signal_a : unsigned(1 downto 0) is df_control_signal(1 downto 0);
  alias df_control_signal_b : unsigned(1 downto 0) is df_control_signal(3 downto 2);
  alias df_control_signal_ar_write : unsigned(0 downto 0) is df_control_signal(4 downto 4);
	alias df_control_signal_imm_b : unsigned(0 downto 0) is df_control_signal(5 downto 5);
  alias df_control_signal_ar_sel : unsigned(0 downto 0) is df_control_signal(6 downto 6); -- 1 for a, 0 for b

 begin
  -- CONTROL SIGNALS DEPENDING ON IR1
  -- Program Memory control signals


  -- Data Stalling control signals


  -- Register File read control signals
  -- Is this necessary, perhaps it's better with the RF just reading addresses straight from the pipecpu.
  rf_a_address <= IR1_a;
  rf_b_address <= IR1_b;

  -- CONTROL SIGNALS DEPENDING ON IR2
  -- Data Forwarding control signals

  IR3_write <= '1' when  (IR3_op = ADD or IR3_op = ADDI or IR3_op = SUBI or IR3_op = NEG or
                         IR3_op = INC or IR3_op = DEC or IR3_op = MUL or IR3_op = UMUL or
                         IR3_op = LSL or IR3_op = LSR or IR3_op = ASL or IR3_op = ASR or
                         IR3_op = ANDD or IR3_op = ORR or IR3_op = XORR or IR3_op = NOTT or
                         IR3_op = LOAD or IR3_op = LOAD_PM or IR3_op = MOVE or
                         IR3_op = MOVHI or IR3_op = MOVLO or IR3_op = POP or IR3_op = INN) else
               '0';

   IR4_write <= '1' when (IR4_op = ADD or IR4_op = ADDI or IR4_op = SUBI or IR4_op = NEG or
                          IR4_op = INC or IR4_op = DEC or IR4_op = MUL or IR4_op = UMUL or
                          IR4_op = LSL or IR4_op = LSR or IR4_op = ASL or IR4_op = ASR or
                          IR4_op = ANDD or IR4_op = ORR or IR4_op = XORR or IR4_op = NOTT or
                          IR4_op = LOAD or IR4_op = LOAD_PM or IR4_op = MOVE or
                          IR4_op = MOVHI or IR4_op = MOVLO or IR4_op = POP or IR4_op = INN) else
                '0';

  process(IR2, IR3, IR4) -- Process statement for easier syntax
  begin
    df_control_signal <= "00000"; -- Standard control signal, overwritten in statements below if necessary
    if IR2_read = "1" then -- Read register bit is set
      if IR3_write = '1' then
        if IR3_d = IR2_a then
          df_control_signal_a <= "01"; -- IR2_a <= D3
        elsif IR3_d = IR3_b then
          df_control_signal_b <= "01"; -- IR2_b <= D3
        end if;
			end if;      
			if IR4_write = '1' then
        if IR4_d = IR2_a and IR3_d /= IR2_a then
          df_control_signal_a <= "10"; -- IR2_a <= D4
        elsif IR4_d = IR2_b and IR3_d /= IR2_b then
          df_control_signal_b <= "10"; -- IR2_b <= D4
        end if;
      end if;
    end if;
  end process;
	
	df_control_signal_ar_write <= '1' when (IR2_op = STORE or IR2_op = VGAWRT) else
																'0';

	df_control_signal_imm_b <= '1' when (IR2_op = ADDI or IR2_op = SUBI or IR2_op = CMPI or -- IMM
																			IR2_op = MOVHI or IR2_op = MOVLO) 									-- IMM

														 '0';
  
	df_control_signal_ar_sel <= '1' when (IR2_op = LOAD or IR2_op = LOAD_PM) else  -- offs + rA
													    '0'; 		-- STORE, STORE_PM, STORE_VGA , offs + rD

  df_control_signal_ 
  -- ALU control signals
  -- ALU operation control signal
  with IR2_op select
  alu_op_control_signal <= ADD when ADD,
                          ADD when ADDI,
                          SUBB when SUBB,
                          SUBB when SUBI,
                          NEG when NEG,
                          INC when INC,
                          DEC when DEC,
                          MUL when MUL,
                          UMUL when UMUL,
                          SUBB when CMP,
                          SUBB when CMPI,
                          PASS when PASS,
                          LSL when LSL,
                          LSR when LSR,
                          ASL when ASL,
                          ASR when ASR,
                          ANDD when ANDD,
                          ORR when ORR,
                          XORR when XORR,
                          NOTT when NOTT,
                          NOP when others;

  -- Data size control signal
  with IR2_s select
  data_size_control_signal <= WORD when "11",
                              HALF when "10",
                              BYTE when "01",
                              NAN when others;

  -- CONTROL SIGNALS DEPENDING ON IR3
  -- Data Memory control signals


  -- Write Back Ĺogic control signals

alias IR2_op = unsigned(5 downto 0) is IR2(31 downto 26);
alias IR2_a = unsigned(4 downto 0) is IR2(20 downto 16); 
alias IR2_b = unsigned(4 downto 0) is IR2(15 downto 11); 
alias IR3_d = unsigned(4 downto 0) is IR3(25 downto 21);
alias IR4_d = unsigned(4 downto 0) is IR4(25 downto 21);
  -- CONTROL SIGNALS DEPENDING ON IR4
  -- Register Write Back control signals
  
  -- Register File write control signals
  rf_write_d_control_signal <= IR4_write;
  rf_d_address <= IR4_d;

  -- PROGRAM MEMORY control signals 

  should_jump <= '1' when (
                      (IR2_op = BREQ and Z_flag = '1') or
                      (IR2_op = BRNE and Z_flag = '0') or
                      (IR2_op = BRLT and (N_flag xor O_flag) = '1') or
                      (IR2_op = BRGT and (N_flag xnor O_flag ) = '1') or -- Either Positive and no underflow, or Negative and overflow 
                      (IR2_op = BRLE and ((N_flag = '1' xor O_flag = '1') or Z_flag = '1')) or
                      (IR2_op = BRGE and ((N_flag = '1' xnor O_flag = '1') or Z_flag = '1')) or
                      (IR2_op = RJMP)
  ) else '0';

  -- TODO: when to write to pm
  pm_control_signal <= "01" when should_jump = '1' else
                       "00";
  
  pm_offset <= IR1(15 downto 0); -- Addition happens one step before
  

  -- END 


  -- IN/OUT - Keyboard
  keyboard_read_signal <= '1' when (IR3_op = INN and IR3_a = 0) else -- Keyboard is port 0
                          '0';



end Behavioral;
