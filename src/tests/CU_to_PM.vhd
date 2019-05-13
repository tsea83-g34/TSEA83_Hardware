-- TestBench Template 

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
      pm_control_signal : out unsigned(1 downto 0);
      pm_offset : out unsigned(15 downto 0);
      pm_write_data : out unsigned(31 downto 0);
      pm_write_address : out unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pipe_control_signal : out unsigned(1 downto 0);
      rf_write_d_control_signal : out std_logic;
      rf_a_address : out unsigned(3 downto 0);
      rf_b_address : out unsigned(3 downto 0);
      rf_d_address : out unsigned(3 downto 0);
      alu_update_flags_control_signal : out std_logic;
      data_size_control_signal : out byte_mode;
      alu_op_control_signal : out alu_operation_control_signal_type;
      df_control_signal : out unsigned(4 downto 0);
      dm_control_signal : out std_logic
    );
  end component;


  component program_memory
    port(
      clk : in std_logic;
      rst : in std_logic;
      pm_control_signal : in unsigned(1 downto 0);
      pm_offset : in unsigned(15 downto 0);
      pm_write_data : in unsigned(31 downto 0);
      pm_write_address : in unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_counter : buffer unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
      pm_out : out unsigned(31 downto 0)
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
  signal pm_control_signal : unsigned(1 downto 0);
  signal pm_offset : unsigned(15 downto 0);
  signal pm_write_data : unsigned(31 downto 0);
  signal pm_write_address : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pipe_control_signal : unsigned(1 downto 0);
  signal rf_write_d_control_signal : std_logic;
  signal rf_a_address : unsigned(3 downto 0);
  signal rf_b_address : unsigned(3 downto 0);
  signal rf_d_address : unsigned(3 downto 0);
  signal alu_update_flags_control_signal : std_logic;
  signal data_size_control_signal : byte_mode;
  signal alu_op_control_signal : alu_operation_control_signal_type;
  signal df_control_signal : unsigned(4 downto 0);
  signal dm_control_signal : std_logic;

  signal tb_running: boolean := true;
  
  -- PROGRAM MEMORY 
  signal pm_counter : unsigned(PROGRAM_MEMORY_ADDRESS_BITS downto 1);
  signal pm_out : unsigned(31 downto 0);

begin

  -- Component Instantiation
  CU_ut: control_unit port map(
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
    pm_control_signal => pm_control_signal,
    pm_offset => pm_offset,
    pm_write_data => pm_write_data,
    pm_write_address => pm_write_address,
    pipe_control_signal => pipe_control_signal,
    rf_write_d_control_signal => rf_write_d_control_signal,
    rf_a_address => rf_a_address,
    rf_b_address => rf_b_address,
    rf_d_address => rf_d_address,
    alu_update_flags_control_signal => alu_update_flags_control_signal,
    data_size_control_signal => data_size_control_signal,
    alu_op_control_signal => alu_op_control_signal,
    df_control_signal => df_control_signal,
    dm_control_signal => dm_control_signal
  );

  PM_ut: program_memory port map(
    clk => clk,
    rst => rst,
    pm_control_signal => pm_control_signal,
    pm_offset => pm_offset,
    pm_write_data => pm_write_data,
    pm_write_address => pm_write_address,
    pm_counter => pm_counter,
    pm_out => pm_out
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
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      2 = 1 + 1 -- Check that: {actual output} = {expected output}, for example: (a_out = '1') and (b_out = '0') 
    )
    report "Failed (Addition test). Expected output: 2"
    severity error;
    -------  END ---------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
