library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU.ALL; -- Include constants 

entity control_unit is
  port (
        clk : in std_logic;
        rst : in std_logic;

        -- IR in
        IR1 : in unsigned(31 downto 0);
        IR2 : in unsigned(31 downto 0);
        IR3 : in unsigned(31 downto 0);
        IR4 : in unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : in std_logic; -- Flags input

        pm_control_signal : out unsigned(1 downto 0);
        pipe_control_signal : out unsigned(1 downto 0);
        
        -- ALU control signals
        alu_update_flags_control_signal : out std_logic; -- 1 for true 0 for false
        data_size_control_signal : out data_size_control_signal_type;
        alu_operation_control_signal : out alu_operation_control_signal_type;

        dataforwarding_control_signal : out unsigned(1 downto 0);
        dm_control_signal : out std_logic;
  );
end control_unit;

architecture Behavioral of control_unit is 
  -- INPUT ALIASES
  -- IR1 signals
  alias IR1_op is IR1(31 downto 26);
  alias IR1_s is IR1(25 downto 24);
 
  -- IR2 signals
  alias IR2_op is IR2(31 downto 26);
  alias IR2_s is IR2(25 downto 24);
 
  -- IR3 signals
  alias IR3_op is IR3(31 downto 26);
  alias IR3_s is IR3(25 downto 24);

  -- IR4 signals
  alias IR4_op is IR4(31 downto 26);
  alias IR4_s is IR4(25 downto 24);

  begin
  -- CONTROL SIGNALS DEPENDING ON IR1
  -- Program Memory control signals


  -- Data Stalling control signals


  -- Register File control signals


  -- CONTROL SIGNALS DEPENDING ON IR2
  -- Data Forwarding control signals

  
  -- ALU control signals
  process(IR2_op, IR2_s)
  begin
    case IR2_op

  -- CONTROL SIGNALS DEPENDING ON IR3
  -- Data Memory control signals


  -- Write Back Ĺogic control signals


  -- CONTROL SIGNALS DEPENDING ON IR4
  -- Register Write Back control signals


end Behavioral
