library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        alu_control_signal : in unsigned(3 downto 0);
        alu_a : in unsigned(31 downto 0);
        alu_b : in unsigned(31 downto 0);

        alu_result : out unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : buffer std_logic
  );
end alu;

architecture Behavioral of alu is
  constant NOP: unsigned(31 downto 0) := (others => 0); -- NOP variable
  
  signal alu_result_next : unsigned(31 downto 0);
  signal Z_next, N_next, O_next, C_next : std_logic;

begin
  -- 1. Calculate next result
  process(alu_a, alu_b, alu_control_signal)
  begin
    case alu_control_signal is
      when "NOP" => alu_result_next <= NOP;
      when "ADD" => alu_result_next <= alu_a + alu_b;
      when others => alu_result_next <= NOP;
    end case;
  end process;

  -- 2. Calculate flags
  -- TODO

  -- 3. Assign next result and flags to registers
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = 1 then
        alu_result <= NOP;

        Z_flag, N_flag , O_flag, C_flag <= 0;
      else
        alu_result <= alu_result_next;

        Z_flag <= Z_next;
        N_flag <= N_next;
        O_flag <= O_next;
        C_flag <= C_next;
      end if;
    end if;
  end process;

end architecture;
