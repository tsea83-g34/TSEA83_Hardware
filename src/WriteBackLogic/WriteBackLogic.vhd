library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WriteBackLogic is
  port (
        clk : in std_logic;
       rst : in std_logic;

        alu_res : in unsigned(31 downto 0);
        dm_out : in unsigned(31 downto 0);
        keyboard_out : in unsigned(31 downto 0);

        write_back_control_signal : in unsigned(1 downto 0);

        write_back_out_3 : buffer unsigned(31 downto 0);
        write_back_out_4 : out unsigned(31 downto 0)
  );
end WriteBackLogic;


architecture Behavioral of WriteBackLogic is
  constant NOP : unsigned(31 downto 0) := (others => '0');
  
  signal alu_res_3 : unsigned(31 downto 0);
  signal alu_res_4 : unsigned(31 downto 0);

  alias in_or_alu3 : unsigned(0 downto 0) is write_back_control_signal(0 downto 0);
  alias dm_or_alu4 : unsigned(0 downto 0) is write_back_control_signal(1 downto 1);
begin
  
  -- Selection of alu_res_3, used in the second mux
  with in_or_alu3 select
    alu_res_3 <= alu_res when "0",
                 keyboard_out when "1",
                 NOP when others;

  -- Output alu_res_3 for dataforwarding
  write_back_out_3 <= alu_res_3;
  
  -- Update alu_res_4 value on clk cycle
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        alu_res_4 <= NOP;
      else
        alu_res_4 <= alu_res_3;
      end if;
    end if;
  end process;

  -- Selection of write_back_out_4 output, used for register write back and dataforwarding
  with dm_or_alu4 select
    write_back_out_4 <= alu_res_4 when "0",
                        dm_out when "1",
                        NOP when others;

end architecture;

  
  
