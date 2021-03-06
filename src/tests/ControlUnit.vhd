library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL; -- Include constants

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
        alu_op_control_signal : out alu_operation_control_signal_type;


        df_control_signal : out unsigned(4 downto 0);
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

  -- IR3 signals
  alias IR3_op is IR3(31 downto 26);
  alias IR3_s is IR3(25 downto 24);
  alias IR3_d is IR3(23 downto 20);

  signal IR3_write is std_logic;

  -- IR4 signals
  alias IR4_op is IR4(31 downto 26);
  alias IR4_d is IR3(23 downto 20);

  signal IR4_write is std_logic;

  -- Program Memory 
  signal should_jump: std_logic := '0';

  -- OUTPUT ALIASES
  alias df_control_signal_a : unsigned(1 downto 0) is df_control_signal(1 downto 0);
  alias df_control_signal_b : unsigned(1 downto 0) is df_control_signal(3 downto 2);
  alias df_control_signal_ar_write : unsigned(0 downto 0) is df_control_signal(4 downto 4);

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
  IR3_write <= '1' when (IR3_op == ADD or IR3_op == ADDI or IR3_op == SUBI or IR3_op == NEG or
                         IR3_op == INC or IR3_op == DEC or IR3_op == MUL or IR3_op == UMUL or
                         IR3_op == LSL or IR3_op == LSR or IR3_op == ASL or IR3_op == ASR or
                         IR3_op == AND_ or IR3_op == OR_ or IR3_op == XOR_ or IR3_op == NOT_ or
                         IR3_op == LOAD or IR3_op == LOAD_PM or IR3_op == MOVE or
                         IR3_op == LOAD_IMM or IR3_op == POP or IR3_op == IN_) else
               '0';

   IR4_write <= '1' when (IR4_op == ADD or IR4_op == ADDI or IR4_op == SUBI or IR4_op == NEG or
                          IR4_op == INC or IR4_op == DEC or IR4_op == MUL or IR4_op == UMUL or
                          IR4_op == LSL or IR4_op == LSR or IR4_op == ASL or IR4_op == ASR or
                          IR4_op == AND_ or IR4_op == OR_ or IR4_op == XOR_ or IR4_op == NOT_ or
                          IR4_op == LOAD or IR4_op == LOAD_PM or IR4_op == MOVE or
                          IR4_op == LOAD_IMM or IR4_op == POP or IR4_op == IN_) else
                '0';

  process(IR2, IR3, IR4) -- Process statement for easier syntax
  begin
    df_control_signal <= "000000"; -- Standard control signal, overwritten in statements below if necessary
    if IR2_op(6 downto 6) = "1" then-- Read register bit is set
      if IR3_write then
        if IR3_d == IR2_a then
          df_control_signal_a <= "01";
        elsif IR3_d == IR3_b then
          df_control_signal_b <= "01";
        end if;
      elsif IR4_write then
        if IR4_d == IR2_a then
          df_control_signal_a <= "10";
        elsif IR4_d == IR2_b then
          df_control_signal_b <= ""

  -- ALU control signals
  -- ALU operation control signal
  with IR2_op select
  alu_op_control_signal <= ADD when ADD,
                          ADD when ADDI,
                          SUB when SUB,
                          SUB when SUBI,
                          NEG when NEG,
                          INC when INC,
                          DEC when DEC,
                          MUL when MUL,
                          UMUL when UMUL,
                          SUB when CMP,
                          SUB when CMPI,
                          PASS when PASS,
                          LSL when LSL,
                          LSR when LSR,
                          ASL when ASL,
                          ASR when ASR,
                          AND_ when AND_,
                          OR_ when OR_
                          XOR_ when XOR_,
                          NOT_ when NOT_,
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


  -- CONTROL SIGNALS DEPENDING ON IR4
  -- Register Write Back control signals

  -- Register File write control signals
  rf_write_d_control_signal <= IR4_write;
  rf_d_address <= IR4_d;

  -- PROGRAM MEMORY control signals 

  should_jump <= '1' when (
                      (IR2_op = BREQ and Z_flag = '1') or
                      (IR2_op = BRNE and Z_flag = '0') or
                      (IR2_op = BRLT and (N_flag xor O_flag)) or
                      (IR2_op = BRGT and (N_flag xnor O_flag )) or -- Either Positive and no underflow, or Negative and overflow 
                      (IR2_op = BRLE and ((N_flag xor O_flag) or Z_flag)) or
                      (IR2_op = BRGE and ((N_flag xnor O_flag) or Z_flag)) or
                      (IR2_op = RJMP)
  ) else '0';

  -- TODO: when to write to pm
  pm_control_signal <= "01" when should_jump = '1' else
                       "00";
  
  pm_offset <= IR1(15 downto 0);
  

  -- END 

end Behavioral
