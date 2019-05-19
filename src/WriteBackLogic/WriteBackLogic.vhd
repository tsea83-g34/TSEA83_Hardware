library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

entity WriteBackLogic is
  port (
        clk : in std_logic;
       rst : in std_logic;

        alu_res : in unsigned(31 downto 0);
        dm_out : in unsigned(31 downto 0);
        keyboard_out : in unsigned(31 downto 0);

        wb3_in_or_alu3 : in wb3_in_or_alu3_enum;
        wb4_dm_or_alu4 : in wb4_dm_or_alu4_enum;

        write_back_out_3 : buffer unsigned(31 downto 0)   :=  X"0000_0000";
        write_back_out_4 : out unsigned(31 downto 0)      :=  X"0000_0000"
  );
end WriteBackLogic;


architecture Behavioral of WriteBackLogic is
  constant NOP_REG : unsigned(31 downto 0) := (others => '0');
  
  signal alu_res_3 : unsigned(31 downto 0)  :=  X"0000_0000";
  signal alu_res_4 : unsigned(31 downto 0)  :=  X"0000_0000";

begin
  
  -- Selection of alu_res_3, used in the second mux
  with wb3_in_or_alu3 select
  alu_res_3 <= alu_res when WB3_ALU3,
                 keyboard_out when WB3_IN;

  -- Output alu_res_3 for dataforwarding
  write_back_out_3 <= alu_res_3;
  
  -- Update alu_res_4 value on clk cycle
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        alu_res_4 <= NOP_REG;
      else
        alu_res_4 <= alu_res_3;
      end if;
    end if;
  end process;

  -- Selection of write_back_out_4 output, used for register write back and dataforwarding
  with wb4_dm_or_alu4 select
  write_back_out_4 <= alu_res_4 when WB4_ALU4,
                        dm_out when WB4_DM;

end architecture;

  
  
