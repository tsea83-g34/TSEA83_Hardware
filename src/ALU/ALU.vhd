library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
  port (
        clk : in std_logic;
        rst : in std_logic;
        
        alu_control_signal : in unsigned(6 downto 0);

        alu_a : in unsigned(31 downto 0);
        alu_b : in unsigned(31 downto 0);

        alu_res : out unsigned(31 downto 0);

        Z_flag, N_flag, O_flag, C_flag : buffer std_logic
  );
end alu;

architecture Behavioral of alu is
  constant ZERO : unsigned(32 downto 0) := X"0_0000_0000"; -- Zero constant variable
  constant ONE : unsigned(32 downto 0) := X"0_0000_0001"; -- one constant variable

  alias alu_update_flag_control_signal is alu_control_signal(6 downto 6);
  alias data_size_control_signal is alu_control_signal(5 downto 4);
  alias alu_operation_control_signal is alu_control_signal(3 downto 0);
  
  signal alu_a_33 : unsigned(31 downto 0);
  signal alu_b_33 : unsigned(31 downto 0);
  signal alu_res_33 : unsigned(32 downto 0);

  signal alu_res_n : unsigned(31 downto 0);
  signal Z_n, N_n, O_n, C_n : std_logic;

begin
  -- 1. Change data to right size.
  -- Combinatorical process for access to better syntax tools
  process(alu_a, alu_b, data_size_control_signal)
  begin
    case data_size_control_signal is 
      when "11" => -- 32 bit data size 
        alu_a_33 <= '0' & alu_a;
        alu_b_33 <= '0' & alu_b;
      when "10" => -- 16 bit data size
        alu_a_32 <= '0' & alu_a(15 downto 0) & X"0000";
        alu_b_32 <= '0' & alu_b(15 downto 0) & X"0000";
      when "01" => -- 8 bit data size
        alu_a_32 <= '0' & alu_a(7 downto 0) & X"00_0000";
        alu_b_32 <= '0' & alu_b(7 downto 0) & X"00_0000";
      when others => -- Non arithmetic operation
        alu_a_32 <= '0' & alu_a;
        alu_b_32 <= '0' & alu_b;
    end case;
  end process;

  -- 2. Perform ALU operation and calculate result
  -- Combinatorical process for access to better syntax tools
  process(alu_a_32, alu_b_32, alu_i_32, alu_operation_control_signal)
  begin
    case alu_operation_control_signal is
      when "0000" => -- Non arithmetic operation
        alu_res_33 <= ZERO;
      -- ARITHMETIC / COMPARE OPERATIONS
      when "0001" => -- Add without carry, Add immediate
        alu_res_33 <= alu_a_33 + alu_b_33;
      when "0010" => -- Sub without borrow, Sub immediate, Compare, Compare immediate
        alu_res_33 <= alu_a_33 - alu_b_33;
      when "0011" => -- NEG - negate
        alu_res_33 <= ZERO - alu_a_33;
      when "0100" => -- INC - increment
        alu_res_33 <= alu_a_33 + ONE;
      when "0101" => -- DEC - decrement
        alu_res_33 <= alu_a_33 - ONE;
      when "0111" => -- MUL - multiply
        alu_res_33 <= alu_a_33 * alu_b_33;
      -- SHIFT OPERATIONS
      when "1000" => -- Logical shift left
        alu_res_33 <= alu_a_33(31 downto 0) & '0';
      when "1001" => -- Logical shift right
        alu_res_33 <= '0' & alu_a_33(32 downto 1);
      when "1010" => -- Arithmetical shift left
        alu_res_33 <= alu_a_33(31 downto 0) & C_flag;
      when "1011" => -- Arighmetical shift right'
        alu_res_33 <= C_flag & alu_a_33(32 downto 0);
      -- LOGICAL OPERATIONS
      when "1100" => -- AND
        alu_res_33 <= alu_a_33 and alu_b_33;
      when "1101" => -- OR 
        alu_res_33 <= alu_a_33 or alu_b_33;
      when "1110" => -- XOR
        alu_res_33 <= alu_a_33 xor alu_b_33;
      when "1111" => -- NOT
        alu_res_33 <= not alu_a_33;
      -- Some other case
      when others => 
        alut_res_33 <= ZERO;
    end case;
  end process;

  -- 3. Calculate flags
  -- Zero flag
  Z_next <= '1' when alu_res_33(31 downto 0) = 0 else '0';
  -- Negative flag
  N_next <= alu_res_33(32);
  -- Overflow flag

  -- Carry flag

  -- 4. Assign next result and flags to registers
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = 1 then
        alu_result <= NOP;

        Z_flag, N_flag , O_flag, C_flag <= '0';
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
