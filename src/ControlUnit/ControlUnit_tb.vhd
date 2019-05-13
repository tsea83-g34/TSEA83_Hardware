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

  constant s_00 : unsigned(1 downto 0) := "00";
  constant s_01 : unsigned(1 downto 0) := "01";
  constant s_10 : unsigned(1 downto 0) := "10";
  constant s_11 : unsigned(1 downto 0) := "11";


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

    ------------ JUMP AND STALL TESTS ------------ 
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
    report "Failed Stall test (10)"
    severity error;


    ------------ DATAFORWARDING ------------ 
    -- Case 1:
    report "Dataforwarding 1";
    IR2 <= OP_ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR3 <= OP_ADD & s_00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s_00 & r1 & r5 & r5 & NAN_12; -- ADD r1, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D3 and df_b_select = DF_FROM_D3 
    report "Error dataforwaring 1, expected: from_D3, from_D3"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 2
    report "Dataforwarding 2";
    IR2 <= OP_ADD & s_00 & r1 & r1 & r2 & NAN_12; -- ADD r1, r1, r2
    IR3 <= OP_ADD & s_00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s_00 & r2 & r5 & r5 & NAN_12; -- ADD r2, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D3 and df_b_select = DF_FROM_D4 
    report "Error dataforwaring 2, expected: from_D3, from_D4"
    severity error; 
    wait until rising_edge(clk);


    -- Case 3
    report "Dataforwarding 3";
    IR2 <= OP_ADD & s_00 & r2 & r2 & r1 & NAN_12; -- ADD r2, r2, r1
    IR3 <= OP_ADD & s_00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= OP_ADD & s_00 & r2 & r5 & r5 & NAN_12; -- ADD r2, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D4 and df_b_select = DF_FROM_D3 
    report "Error dataforwaring 3, expected: from_D4, from_D3"
    severity error; 
    wait until rising_edge(clk);

    -- Case 4
    report "Dataforwarding 4";
    IR2 <= OP_ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR3 <= OP_ADD & s_00 & r3 & r2 & r2 & NAN_12; -- ADD r3, r2, r2
    IR4 <= OP_ADD & s_00 & r1 & r5 & r5 & NAN_12; -- ADD r1, r5, r5
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_D4 and df_b_select = DF_FROM_D4 
    report "Error dataforwaring 4, expected: from_D4, from_D4"
    severity error; 
    wait until rising_edge(clk);
   
    -- Case 5
    report "Dataforwarding 5";
    IR2 <= OP_ADD & s_00 & r2 & r1 & r3 & NAN_12; -- ADD r2, r1, r3
    IR3 <= OP_ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR4 <= OP_ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_RF and df_b_select = DF_FROM_RF 
    report "Error dataforwaring 5, expected: from_RF, from_RF"
    severity error; 
    wait until rising_edge(clk);

    -- Case 6
    report "Dataforwarding 6";
    IR2 <= OP_ADD & s_00 & r2 & r1 & r3 & NAN_12; -- ADD r2, r1, r3
    IR3 <= OP_ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR4 <= OP_ADD & s_00 & r3 & r1 & r1 & NAN_12; -- ADD r3, r1, r1
    wait until rising_edge(clk);
    assert df_a_select = DF_FROM_RF and df_b_select = DF_FROM_D4 
    report "Error dataforwaring 6, expected: from_RF, from_RF"
    severity error; 
    wait until rising_edge(clk);



    ------------ REGISTER FILE TESTS ------------ 
    -- Case 1
    report "Registerfile 1";
    IR1 <= OP_STORE & s_11 & r1 & r2 & OFFS_0;    -- STORE, s11, r1, r2, "0000"
    IR4 <= OP_SUBB & s_00 & r2 & r4 & r5 & NAN_12; -- SUB, r2, r4, r5 
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Error register file 1, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);

    -- Case 2
    report "Registerfile 2";
    IR1 <= OP_STORE_PM & s_00 & r1 & r2 & OFFS_0;    -- STORE_PM , r1, r2, "0000"
    IR4 <= OP_NEG & s_00 & r2 & r4 & NAN_16;         -- NEG, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Error register file 2, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 3
    report "Registerfile 3";
    IR1 <= OP_STORE_VGA & s_00 & r1 & r2 & OFFS_0;    -- STORE_VGA, s11, r1, r2, "0000"
    IR4 <= OP_INC & s_00 & r2 & r4 & NAN_16;         -- INC, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_D and rf_write_d_control_signal = RF_WRITE_D
    report "Error register file 3, expected RF_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);

    -- Case 4
    report "Registerfile 4";
    IR1 <= OP_MOVE & s_00 & r1 & r2 & NAN_16;        -- MOVE, r1, r2
    IR4 <= OP_INC & s_00 & r2 & r4 & NAN_16;         -- INC, r2, r4
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_B and rf_write_d_control_signal = RF_WRITE_D
    report "Error register file 4, expected RF_NO_READ_D and RF_WRITE_D"
    severity error;
    wait until rising_edge(clk);
    
    -- Case 5
    report "Registerfile 5";
    IR1 <= OP_MUL & s_00 & r1 & r2 & r3 & NAN_12;      -- MUL, r1, r2, r3
    IR4 <= OP_STORE & s_11 & r2 & r4 & OFFS_0;         -- STORE, s11, r2, r4, "0000"
    wait until rising_edge(clk);
    assert rf_read_d_or_b_control_signal = RF_READ_B and rf_write_d_control_signal = RF_NO_WRITE_D
    report "Error register file 5, expected RF_NO_READ_D and RF_NO_WRITE_D"
    severity error;
    wait until rising_edge(clk);

    ----------------------------------------- END -----------------------------------------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
