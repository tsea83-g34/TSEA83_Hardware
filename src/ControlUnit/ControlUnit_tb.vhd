library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity ControlUnit_tb is 
end ControlUnit_tb;

architecture behavior of ControlUnit_tb is 

  component ControlUnit
    port(
      clk : in std_logic;
      rst : in std_logic;
      IR1 : in unsigned(31 downto 0);
      IR2 : in unsigned(31 downto 0);
      IR3 : in unsigned(31 downto 0);
      IR4 : in unsigned(31 downto 0);
      Z_flag : in std_logic;
      N_flag : in std_logic;
      O_flag : in std_logic;
      C_flag : in std_logic;
      IR1_op : buffer op_enum;
      IR2_op : buffer op_enum;
      IR3_op : buffer op_enum;
      IR4_op : buffer op_enum;   
      pipe_control_signal : out pipe_op;
      pm_jmp_stall : out pm_jmp_stall_enum;  
      pm_write_enable : out pm_write_enum;
      rf_read_d_or_b_control_signal : out rf_read_d_or_b_enum;
      rf_write_d_control_signal : out rf_write_d_enum;
      df_a_select : out df_select;
      df_b_select : out df_select;    
      df_alu_imm_or_b : out df_alu_imm_or_b_enum; -- 1 for IMM, 0 for b
      df_ar_a_or_b : out df_ar_a_or_b_enum; -- 1 for a, 0 for b
      alu_update_flags_control_signal : out alu_update_flags_enum;
      alu_data_size_control_signal : out byte_mode;
      alu_op_control_signal : out alu_op;
      kb_read_control_signal : out std_logic;
      dm_write_or_read_control_signal : out dm_write_or_read_enum;
      dm_size_mode_control_signal : out byte_mode;
      vm_write_enable_control_signal : out vm_write_enable_enum;
      wb3_in_or_alu3 : out wb3_in_or_alu3_enum;
      wb4_dm_or_alu4 : out  wb4_dm_or_alu4_enum
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal IR1 : unsigned(31 downto 0);
  signal IR2 : unsigned(31 downto 0);
  signal IR3 : unsigned(31 downto 0);
  signal IR4 : unsigned(31 downto 0);
  signal IR1_op : op_enum;
  signal IR2_op : op_enum;
  signal IR3_op : op_enum;
  signal IR4_op : op_enum;   
  signal Z_flag : std_logic;
  signal N_flag : std_logic;
  signal O_flag : std_logic;
  signal C_flag : std_logic;
  signal pipe_control_signal : pipe_op;
  signal pm_jmp_stall : pm_jmp_stall_enum;  
  signal pm_write_enable : pm_write_enum;
  signal rf_read_d_or_b_control_signal : rf_read_d_or_b_enum;
  signal rf_write_d_control_signal : rf_write_d_enum;
  signal df_a_select : df_select;
  signal df_b_select : df_select;    
  signal df_alu_imm_or_b : df_alu_imm_or_b_enum; 
  signal df_ar_a_or_b : df_ar_a_or_b_enum; 
  signal alu_update_flags_control_signal : alu_update_flags_enum;
  signal alu_data_size_control_signal : byte_mode;
  signal alu_op_control_signal : alu_op;
  signal kb_read_control_signal : std_logic;
  signal dm_write_or_read_control_signal : dm_write_or_read_enum;
  signal dm_size_mode_control_signal : byte_mode;
  signal vm_write_enable_control_signal : vm_write_enable_enum;
  signal wb3_in_or_alu3 : wb3_in_or_alu3_enum;
  signal wb4_dm_or_alu4 :  wb4_dm_or_alu4_enum;

  signal tb_running: boolean := true;

  constant s00 : unsigned(1 downto 0) := "00";
  constant s01 : unsigned(1 downto 0) := "01";
  constant s10 : unsigned(1 downto 0) := "10";
  constant s11 : unsigned(1 downto 0) := "11";


  constant r0  : unsigned(3 downto 0) := X"0";
  constant r1  : unsigned(3 downto 0) := X"1";
  constant r2  : unsigned(3 downto 0) := X"2";
  constant r3  : unsigned(3 downto 0) := X"3";
  constant r4  : unsigned(3 downto 0) := X"4";
  constant r5  : unsigned(3 downto 0) := X"5";
  constant r6  : unsigned(3 downto 0) := X"6";
  constant r7  : unsigned(3 downto 0) := X"7";
  constant r8  : unsigned(3 downto 0) := X"8";
  constant r9  : unsigned(3 downto 0) := X"9";
  constant r10 : unsigned(3 downto 0) := X"A";
  constant r11 : unsigned(3 downto 0) := X"B";
  constant r12 : unsigned(3 downto 0) := X"C";
  constant r13 : unsigned(3 downto 0) := X"D";
  constant r14 : unsigned(3 downto 0) := X"E";
  constant r15 : unsigned(3 downto 0) := X"F";
  
  constant rNAN : unsigned(3 downto 0) := X"0";    

  constant p0 : unsigned(3 downto 0) := X"0";
  constant p1 : unsigned(3 downto 0) := X"0";

  constant NAN_12 : unsigned(11 downto 0) := X"000";
  constant NAN_16 : unsigned(15 downto 0) := X"0000";

  constant IMM_0 : unsigned(15 downto 0) := X"0000"; 
  
  constant OFFS_0 : unsigned(15 downto 0) := X"0000";
  
begin

  -- Component Instantiation
  uut: ControlUnit port map(
    clk => clk,
    rst => rst,
    IR1 => IR1,
    IR2 => IR2,
    IR3 => IR3,
    IR4 => IR4,
    Z_flag => Z_flag,
    N_flag => N_flag,
    O_flag => O_flag,
    C_flag => C_flag,
    IR1_op => IR1_op,
    IR2_op => IR2_op,
    IR3_op => IR3_op,
    IR4_op => IR4_op,   
    pipe_control_signal => pipe_control_signal,
    pm_jmp_stall => pm_jmp_stall,   
    pm_write_enable => pm_write_enable,
    rf_read_d_or_b_control_signal => rf_read_d_or_b_control_signal,
    rf_write_d_control_signal => rf_write_d_control_signal,
    df_a_select => df_a_select,
    df_b_select => df_b_select,    
    df_alu_imm_or_b => df_alu_imm_or_b, -- 1 for IMM, 0 for b
    df_ar_a_or_b => df_ar_a_or_b, -- 1 for a, 0 for b
    alu_update_flags_control_signal => alu_update_flags_control_signal,
    alu_data_size_control_signal => alu_data_size_control_signal,
    alu_op_control_signal => alu_op_control_signal,
    kb_read_control_signal => kb_read_control_signal,
    dm_write_or_read_control_signal => dm_write_or_read_control_signal,
    dm_size_mode_control_signal => dm_size_mode_control_signal,
    vm_write_enable_control_signal => vm_write_enable_control_signal,
    wb3_in_or_alu3 => wb3_in_or_alu3,
    wb4_dm_or_alu4 => wb4_dm_or_alu4
  );

  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  
  process
  begin


    ------ Format of a test case -------

    -- Assign your inputs: A2 <= X"0000_0001";


    -- Have to wait TWO clock cycles, because this process
    -- AND the components process has to tick before the output
    -- of the component is registered
    ---------------------------------------- BEGIN ----------------------------------------
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    ---------------------------------- JUMP AND STALL TESTS ----------------------------------
    IR3 <= NOP_REG;
    IR4 <= NOP_REG;    
  
    -- Case 1
    report "Jump stall 1";
    IR1 <= OP_ADD & "00" & X"3" & X"2" & X"1" & X"000"; -- Add r3, r2, r1
    IR2 <= OP_LOAD & "00" & X"2" & X"0" & X"0000"; -- Store r2, r0, 0
    -- IR3 <= LOAD 
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    assert (
      pipe_control_signal = PIPE_STALL and pm_jmp_stall = PM_STALL
    )
    report "Failed Stall 1 (10)"
    severity error;


    ---------------------------------- DATA FORWARDING TESTS ----------------------------------
    IR1 <= NOP_REG;    

    -- Case 1:
    report "Dataforwarding 1";
    IR2 <= OP_ADD & s00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR3 <= OP_ADD & s00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s00 & r1 & r5 & r5 & NAN_12; -- ADD r1, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D3 and df_b_select = DF_FROM_D3 
    report "Failed dataforwaring 1, expected: from_D3, from_D3"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 2
    report "Dataforwarding 2";
    IR2 <= OP_ADD & s00 & r1 & r1 & r2 & NAN_12; -- ADD r1, r1, r2
    IR3 <= OP_ADD & s00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s00 & r2 & r5 & r5 & NAN_12; -- ADD r2, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D3 and df_b_select = DF_FROM_D4 
    report "Failed dataforwaring 2, expected: from_D3, from_D4"
    severity error; 
    wait until rising_edge(clk);


    -- Case 3
    report "Dataforwarding 3";
    IR2 <= OP_ADD & s00 & r2 & r2 & r1 & NAN_12; -- ADD r2, r2, r1
    IR3 <= OP_ADD & s00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s00 & r2 & r5 & r5 & NAN_12; -- ADD r2, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D4 and df_b_select = DF_FROM_D3 
    report "Failed dataforwaring 3, expected: from_D4, from_D3"
    severity error; 
    wait until rising_edge(clk);

    -- Case 4
    report "Dataforwarding 4";
    IR2 <= OP_ADD & s00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR3 <= OP_ADD & s00 & r3 & r2 & r2 & NAN_12; -- ADD r3, r2, r2
    IR4 <= OP_ADD & s00 & r1 & r5 & r5 & NAN_12; -- ADD r1, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D4 and df_b_select = DF_FROM_D4 
    report "Failed dataforwaring 4, expected: from_D4, from_D4"
    severity error; 
    wait until rising_edge(clk);
   
    -- Case 5
    report "Dataforwarding 5";
    IR2 <= OP_ADD & s00 & r2 & r1 & r3 & NAN_12; -- ADD r2, r1, r3
    IR3 <= OP_ADD & s00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR4 <= OP_ADD & s00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_RF and df_b_select = DF_FROM_RF 
    report "Failed dataforwaring 5, expected: from_RF, from_RF"
    severity error; 
    wait until rising_edge(clk);

    -- Case 6
    report "Dataforwarding 6";
    IR2 <= OP_ADD & s00 & r2 & r1 & r3 & NAN_12; -- ADD r2, r1, r3
    IR3 <= OP_ADD & s00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR4 <= OP_ADD & s00 & r3 & r1 & r1 & NAN_12; -- ADD r3, r1, r1
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_RF and df_b_select = DF_FROM_D4 
    report "Failed dataforwaring 6, expected: from_RF, from_RF"
    severity error; 
    wait until rising_edge(clk);



    ---------------------------------- REGISTER FILE TESTS ----------------------------------
    IR2 <= NOP_REG;
    IR3 <= NOP_REG;

    -- Case 1
    report "Registerfile 1";
    IR1 <= OP_STORE & s11 & r1 & r2 & OFFS_0;    -- STORE, s11, r1, r2, "0000"
    IR4 <= OP_SUBB & s00 & r2 & r4 & r5 & NAN_12; -- SUB, r2, r4, r5 
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Failed register file 1, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);

    -- Case 2
    report "Registerfile 2";
    IR1 <= OP_STORE_PM & s00 & r1 & r2 & OFFS_0;    -- STORE_PM , r1, r2, "0000"
    IR4 <= OP_NEG & s00 & r2 & r4 & NAN_16;         -- NEG, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Failed register file 2, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 3
    report "Registerfile 3";
    IR1 <= OP_STORE_VGA & s00 & r1 & r2 & OFFS_0;    -- STORE_VGA, s11, r1, r2, "0000"
    IR4 <= OP_INC & s00 & r2 & r4 & NAN_16;         -- INC, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Failed register file 3, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);

    -- Case 4
    report "Registerfile 4";
    IR1 <= OP_MOVE & s00 & r1 & r2 & NAN_16;        -- MOVE, r1, r2
    IR4 <= OP_INC & s00 & r2 & r4 & NAN_16;         -- INC, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_B and rf_write_d_control_signal = RF_WRITE_D
    report "Failed register file 4, expected RF_NO_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 5
    report "Registerfile 5";
    IR1 <= OP_MUL & s00 & r1 & r2 & r3 & NAN_12;      -- MUL, r1, r2, r3
    IR4 <= OP_STORE & s11 & r2 & r4 & OFFS_0;         -- STORE, s11, r2, r4, "0000"
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_B and rf_write_d_control_signal = RF_NO_WRITE_D
    report "Failed register file 5, expected RF_NO_READ_D and RF_NO_WRITE_D"
    severity error;
    wait until rising_edge(clk);


    ---------------------------------- ALU TESTS ----------------------------------
    IR1 <= NOP_REG;
    IR3 <= NOP_REG;
    IR4 <= NOP_REG;
  
    ---- MOVE, STORE and OUT ----
    -- Case 1
    report "ALU 1 MOVE";
    IR2 <= OP_MOVE & s00 & r1 & r2 & NAN_16;       -- MOVE, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_PASS and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 1 MOVE, expected ALU_PASS, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 2
    report "ALU 2 STORE";
    IR2 <= OP_STORE & s11 & r1 & r2 & OFFS_0;       -- STORE, s11, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_PASS and alu_data_size_control_signal = WORD and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 2 STORE, expected ALU_PASS, WORD and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 3
    report "ALU 3 STORE_PM";
    IR2 <= OP_STORE_PM & s00 & r1 & r2 & OFFS_0;       -- STORE_PM, s00, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_PASS and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 3 STORE_PM, expected ALU_PASS, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 4
    report "ALU 4 STORE_VGA";
    IR2 <= OP_STORE & s00 & r1 & r2 & OFFS_0;       -- STORE_VGA, s00, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_PASS and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 4 STORE_VGA, expected ALU_PASS, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 5
    report "ALU 5 OUTT";
    IR2 <= OP_OUT & s00 & p1 & r2 & NAN_16;       -- OUTT, s00, p1, r2,
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_PASS and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 5 OUTT, expected ALU_PASS, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    ---- ARITHMETIC ----
    -- Case 6
    report "ALU 6 ADD";
    IR2 <= OP_ADD & s00 & r1 & r2 & r3 & NAN_12;       -- ADD, s00, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_ADD and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 6 ADD, expected ALU_ADD, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 7
    report "ALU 7 ADDI";
    IR2 <= OP_ADDI & s00 & r1 & r2 & IMM_0;       -- ADD, s00, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_ADD and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 7 ADDI, expected ALU_ADD, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 8
    report "ALU 8 SUBB";
    IR2 <= OP_SUBB & s00 & r1 & r2 & r3 & NAN_12;       -- SUBB, s00, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_SUB and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 8 SUBB, expected ALU_SUB, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);
  
    -- Case 9
    report "ALU 9 SUBI";
    IR2 <= OP_SUBI & s00 & r1 & r2 & IMM_0;       -- SUBI, s00, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_SUB and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 9 SUBI, expected ALU_SUB, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 10
    report "ALU 10 CMP";
    IR2 <= OP_CMP & s00 & rNAN & r1 & r2 & NAN_12;       -- CMP, s00, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_SUB and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 10 CMP, expected ALU_SUB, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk); 

    -- Case 11
    report "ALU 11 CMPI";
    IR2 <= OP_CMPI & s00 & rNAN & r1 & IMM_0;       -- CMP, s00, r1, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_SUB and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 10 CMP, expected ALU_SUB, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);   

    -- Case 12
    report "ALU 12 NEG";
    IR2 <= OP_NEG & s00 & r1 & r2 & NAN_16;       -- NEG, s00, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_NEG and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 12 NEG, expected ALU_NEG, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);   

    -- Case 13
    report "ALU 13 INC";
    IR2 <= OP_INC & s00 & r1 & r2 & NAN_16;       -- INC, s00, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_INC and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 13 INC, expected ALU_INC, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);  
    
    -- Case 14
    report "ALU 14 DEC";
    IR2 <= OP_DEC & s00 & r1 & r2 & NAN_16;       -- DEC, s00, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_DEC and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 14 DEC, expected ALU_DEC, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);  

    -- Case 15
    report "ALU 15 MUL";
    IR2 <= OP_MUL & s00 & r1 & r2 & r3 & NAN_12;       -- MUL, s00, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_MUL and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 15 MUL, expected ALU_MUL, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    ---- SHIFTING ---
    -- Case 16
    report "ALU 16 LSL word";
    --      6        2     4    4 
    IR2 <= OP_LSL & s11 & r1 & r2 & NAN_16;       -- LSL, s11, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_LSL and alu_data_size_control_signal = WORD and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 16 LSL, expected ALU_LSL, WORD and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 17
    report "ALU 17 LSL half";
    IR2 <= OP_LSL & s10 & r1 & r2 & NAN_16;       -- LSL, s10, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_LSL and alu_data_size_control_signal = HALF and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 17 LSL, expected ALU_LSL, HALF and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 18
    report "ALU 18 LSL byte";
    IR2 <= OP_LSL & s01 & r1 & r2 & NAN_16;       -- LSL, s01, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_LSL and alu_data_size_control_signal = BYTE and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 17 LSL, expected ALU_LSL, BYTE and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 19
    report "ALU 19 LSR word";
    IR2 <= OP_LSR & s11 & r1 & r2 & NAN_16;       -- LSR, s11, r1, r2
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_LSR and alu_data_size_control_signal = WORD and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 19 LSR, expected ALU_LSR, WORD and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);
    
    ---- LOGICAL ----
    -- Case 20
    report "ALU 20 AND";
    IR2 <= OP_ANDD & s00 & r1 & r2 & r3 & NAN_12;      -- AND, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_AND and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 20 AND, expected ALU_AND, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 21
    report "ALU 21 OR";
    IR2 <= OP_ORR & s00 & r1 & r2 & r3 & NAN_12;      -- OR, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_OR and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 21 OR, expected ALU_OR, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 22
    report "ALU 22 XOR";
    IR2 <= OP_XORR & s00 & r1 & r2 & r3 & NAN_12;      -- XOR, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_XOR and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 22 XOR, expected ALU_XOR, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 23
    report "ALU 23 NOT";
    IR2 <= OP_NOTT & s00 & r1 & r2 & r3 & NAN_12;      -- XOR, r1, r2, r3
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_NOT and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_FLAGS
    )
    report "Failed ALU 23 NOT, expected ALU_NOT, NAN and ALU_FLAGS"
    severity error;
    wait until rising_edge(clk);

    ---- MOVLO, MOVHI ----
    -- Case 24
    report "ALU 24 MOVLO";
    IR2 <= OP_MOVLO & s00 & r1 & r2 & IMM_0;      -- MOVLO, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_MOVLO and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 24 MOVLO, expected ALU_MOVLO, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    -- Case 25
    report "ALU 25 MOVHI";
    IR2 <= OP_MOVHI & s00 & r1 & r2 & IMM_0;      -- MOVHI, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_MOVHI and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 25 MOVHI, expected ALU_MOVHI, NAN and ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    ---- NOP ----
    -- Case 26
    report "ALU 26 NOP";
    IR2 <= OP_NOP & s00 & r0 & r0 & NAN_16;        -- NOP
    wait until rising_edge(clk);
    assert (
      alu_op_control_signal = ALU_NOP and alu_data_size_control_signal = NAN and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 26 NOP, expected ALU_NOP, NAN, ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 27
    report "ALU 27 LOAD (NON ALU OPERATION)";
    IR2 <= OP_LOAD & s11 & r1 & r2 & OFFS_0;        -- LOAD, s11, r1, r2, "0000"
    wait until rising_edge(clk); 
    assert (
      alu_op_control_signal = ALU_NOP and alu_data_size_control_signal = WORD and
      alu_update_flags_control_signal = ALU_NO_FLAGS
    )
    report "Failed ALU 26 NOP (NON ALU OPERATION), expected ALU_NOP, WORD, ALU_NO_FLAGS"
    severity error;
    wait until rising_edge(clk);

    ----------------------------------- DATA MEMORY TESTS ----------------------------------
    IR1 <= NOP_REG;
    IR2 <= NOP_REG;
    IR4 <= NOP_REG;
      
    -- Case 1
    report "DM 1 STORE WORD";
    IR3 <= OP_STORE & s11 & r1 & r2 & OFFS_0;      -- STORE, s11, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      dm_write_or_read_control_signal = DM_WRITE and dm_size_mode_control_signal = WORD
    )
    report "Failed DM 1 STORE WORD, expected DM_WRITE, WORD"
    severity error;
    wait until rising_edge(clk);

    -- Case 2
    report "DM 2 STORE HALF";
    IR3 <= OP_STORE & s10 & r1 & r2 & OFFS_0;      -- STORE, s10, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      dm_write_or_read_control_signal = DM_WRITE and dm_size_mode_control_signal = HALF
    )
    report "Failed DM 2 STORE HALF, expected DM_WRITE, HALF"
    severity error;
    wait until rising_edge(clk);

    -- Case 3
    report "DM 3 STORE BYTE";
    IR3 <= OP_STORE & s01 & r1 & r2 & OFFS_0;      -- STORE, s01, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      dm_write_or_read_control_signal = DM_WRITE and dm_size_mode_control_signal = BYTE
    )
    report "Failed DM 3 STORE BYTE, expected DM_WRITE, BYTE"
    severity error;
    wait until rising_edge(clk);

    -- Case 4
    report "DM 4 unrealistic STORE NAN";
    IR3 <= OP_STORE & s00 & r1 & r2 & OFFS_0;      -- STORE, s00, r1, r2, "0000"
    wait until rising_edge(clk);
    assert (
      dm_write_or_read_control_signal = DM_WRITE and dm_size_mode_control_signal = NAN
    )
    report "Failed DM 4 STORE NAN, expected DM_WRITE, NAN, NOTE that this test is unrealistic"
    severity error;
    wait until rising_edge(clk);

    -- Case 5
    report "DM 5 LOAD WORD";
    IR3 <= OP_LOAD & s11 & r1 & r2 & OFFS_0;      -- LOAD, s00, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      dm_write_or_read_control_signal = DM_READ and dm_size_mode_control_signal = WORD
    )
    report "Failed DM 6 non DM operation 1, expected DM_READ, WORD"
    severity error;
    wait until rising_edge(clk);

    -- Case 6
    report "DM 6 non DM operation 1";
    IR3 <= OP_STORE_VGA & s00 & r1 & r2 & OFFS_0;      -- STORE_VGA, s00, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      dm_write_or_read_control_signal = DM_READ and dm_size_mode_control_signal = NAN
    )
    report "Failed DM 6 non DM operation 1, expected DM_READ, NAN"
    severity error;
    wait until rising_edge(clk);

    -- Case 7
    report "DM 7 non DM operation 2";
    IR3 <= OP_STORE_PM & s00 & r1 & r2 & OFFS_0;      -- STORE_OM, s00, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      dm_write_or_read_control_signal = DM_READ and dm_size_mode_control_signal = NAN
    )
    report "Failed DM 7 non DM operation 2, expected DM_READ, NAN"
    severity error;
    wait until rising_edge(clk);

    ----------------------------------- VIDEO MEMORY TESTS ----------------------------------
    IR1 <= NOP_REG;
    IR2 <= NOP_REG;
    IR4 <= NOP_REG;
    
    -- Case 1
    report "VMEM 1 STORE_VGA";
    IR3 <= OP_STORE_VGA & s00 & r1 & r2 & OFFS_0;      -- STORE_VGA, s00, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      vm_write_enable_control_signal = VM_WRITE
    )
    report "Failed VMEM 1 STORE_VGA, expected VM_WRITE"
    severity error;
    wait until rising_edge(clk);

    -- Case 2
    report "VMEM 2 non vmem operation 1";
    IR3 <= OP_STORE_PM & s00 & r1 & r2 & OFFS_0;      -- STORE_PM, s00, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      vm_write_enable_control_signal = VM_NO_WRITE
    )
    report "Failed VMEM 2 non vmem operation 1, expected VM_NO_WRITE"
    severity error;
    wait until rising_edge(clk);

  -- Case 3
    report "VMEM 3 non vmem operation 2";
    IR3 <= OP_STORE & s11 & r1 & r2 & OFFS_0;      -- STORE_PM, s11, r1, r2, "0000"
    wait until rising_edge(clk);
     assert (
      vm_write_enable_control_signal = VM_NO_WRITE
    )
    report "Failed VMEM 3 non vmem operation 2, expected VM_NO_WRITE"
    severity error;
    wait until rising_edge(clk);
    

    ----------------------------------------- END -----------------------------------------

    -- Insert additional test cases here








    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
