library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PIPECPU_STD.ALL;

entity ControlUnit_tb is 
end ControlUnit_tb;

architecture behavior of ControlUnit_tb is 

  component control_unit
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
      pipe_control_signal : out unsigned(1 downto 0);
      pm_control_signal : out unsigned(2 downto 0);
      rf_read_d_or_b_control_signal : out std_logic;
      rf_write_d_control_signal : out std_logic;
      df_control_signal : out unsigned(5 downto 0);
      alu_update_flags_control_signal : out std_logic;
      alu_data_size_control_signal : out byte_mode;
      alu_op_control_signal : out alu_op;
      keyboard_read_signal : out std_logic;
      dm_write_or_read_control_signal : out std_logic;
      dm_size_mode_control_signal : out byte_mode;
      vm_write_enable_control_signal : out std_logic;
      wb_control_signal : out unsigned(1 downto 0)
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;
  signal IR1 : unsigned(31 downto 0);
  signal IR2 : unsigned(31 downto 0);
  signal IR3 : unsigned(31 downto 0);
  signal IR4 : unsigned(31 downto 0);
  signal Z_flag : std_logic;
  signal N_flag : std_logic;
  signal O_flag : std_logic;
  signal C_flag : std_logic;
  signal pipe_control_signal : unsigned(1 downto 0);
  signal pm_control_signal : unsigned(2 downto 0);
  signal rf_read_d_or_b_control_signal : std_logic;
  signal rf_write_d_control_signal : std_logic;
  signal df_control_signal : unsigned(5 downto 0);
  signal alu_update_flags_control_signal : std_logic;
  signal alu_data_size_control_signal : byte_mode;
  signal alu_op_control_signal : alu_op;
  signal keyboard_read_signal : std_logic;
  signal dm_write_or_read_control_signal : std_logic;
  signal dm_size_mode_control_signal : byte_mode;
  signal vm_write_enable_control_signal : std_logic;
  signal wb_control_signal : unsigned(1 downto 0);

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
  
  constant IMM_0 : unsigned(15 downto 0) := X"0000"; 
  
begin

  -- Component Instantiation
  uut: control_unit port map(
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
    pipe_control_signal => pipe_control_signal,
    pm_control_signal => pm_control_signal,
    rf_read_d_or_b_control_signal => rf_read_d_or_b_control_signal,
    rf_write_d_control_signal => rf_write_d_control_signal,
    df_control_signal => df_control_signal,
    alu_update_flags_control_signal => alu_update_flags_control_signal,
    alu_data_size_control_signal => alu_data_size_control_signal,
    alu_op_control_signal => alu_op_control_signal,
    keyboard_read_signal => keyboard_read_signal,
    dm_write_or_read_control_signal => dm_write_or_read_control_signal,
    dm_size_mode_control_signal => dm_size_mode_control_signal,
    vm_write_enable_control_signal => vm_write_enable_control_signal,
    wb_control_signal => wb_control_signal
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

    ------------ PIPECPU TESTS ------------ 
    IR1 <= ADD & "00" & X"3" & X"2" & X"1" & X"000"; -- Add r3, r2, r1
    IR2 <= LOAD & "00" & X"2" & X"0" & X"0000"; -- Store r2, r0, 0
    -- IR3 <= LOAD 
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      pipe_control_signal = PIPE_STALL
    )
    report "Failed Stall test (10)"
    severity error;



    ------------ DATAFORWARDING ------------ 
    -- TEST 1
    IR2 <= ADD & s_00 & r2 & r1 & r1 & NAN_12; -- ADD r2, r1, r1
    IR3 <= ADD & s_00 & r1 & r4 & r4 & NAN_12; -- ADD r1, r4, r4
    IR4 <= ADD & s_00 & r1 & r5 & r5 & NAN_12; -- ADD r1, r5, r5
    wait until rising_edge(clk);
    assert df_control_signal = "000101" 
    report "Error dataforwaring, expected: 000101 got '" & integer'image(to_integer(df_control_signal)) & "'."; 
    









    -- STALL CASE 1
   





    ----------------------------------------- END -----------------------------------------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
