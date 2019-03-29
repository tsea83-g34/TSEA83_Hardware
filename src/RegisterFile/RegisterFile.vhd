library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
  port (
        clk : in std_logic;
        rst : in std_logic;

        addr_a : in unsigned(3 downto 0);
        addr_b : in unsigned(3 downto 0);

        write_d : in std_logic; -- Should write
        addr_d : in unsigned(3 downto 0);
        data_d : in unsigned(31 downto 0);

        out_a : out unsigned(31 downto 0);
        out_b : out unsigned(31 downto 0)
  );
end register_file;


architecture Behavioral of register_file is
  type reg_array is array (0 to 15) of unsigned(31 downto 0);
  signal registers : reg_array := (others => X"00000000");
begin
  
  -- Register file logic 
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        registers <= (others => X"00000000");
      else 
        -- 1. Update out_a and out_b registers based on addr_a and addr_b
        out_a <= registers(to_integer(addr_a));
        out_b <= registers(to_integer(addr_b));

        -- 2. Check if should write, and if write data_d to addr_d.
        if write_d = '1' then
          registers(to_integer(addr_d)) <= data_d;
        end if;
      end if;
    end if;
  end process;

end architecture;
