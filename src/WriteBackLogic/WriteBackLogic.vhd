library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity write_back_logic is
  port (
        clk : in std_logic;
        rst : in std_logic;

        alu_res : in unsigned(31 downto 0);
        dm_out : in unsigned(31 downto 0);
        keyboard_out : in unsigned(31 downto 0);

        write_back_control_signal : in unsigned(1 downto 0);

        alu_res_3 : out unsigned(31 downto 0);
        write_back_out_4 : out unsigned(31 downto 0);
  );
end write_back_logic;


architecture Behavioral of write_back_logic is
  constant NOP : unsigned(31 downo 0) := (others => '0');

  signal alu_out_4 : unsigned(31 downto 0);

  alias control_signal_res_3 is write_back_control_signal(0 downto 0);
  alias control_signal_res_4 is write_back_control_signal(1 downto 0);
begin
  
  -- Selection of alu_res_3 output, used for data_forwarding and in the second mux
  with control_signal_res_3 select
    alu_res_3 <= alu_res when "0" else
                 keyboard_out when "1" else
                 NOP;
  
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

  -- Selection of wrrite_back_out_4 output, used for register write back and dataforwarding
  with control_signal_res_4 select
    write_back_out_4 <= alu_res_4 when "0" else
                        dm_out when "1" else
                        NOP;

end architecture

  
  