library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipeCPU is
  port(
    clk : in std_logic;
    rst : in std_logic;

    pm_out : in unsigned(31 downto 0);
    pipe_control_signals : in unsigned(1 downto 0);

    IR1 IR2, IR3, IR4 : buffer unsigned(31 downto 0)
  );
end pipeCPU;

architecture Behavioral of pipeCPU is
  variable NOP: unsigned(31 downto 0) := (others => 0); -- NOP variabl
  
  signal IR1_next, IR2_next, IR3_next, IR4_next : unsigned(31 downto 0);
begin
  -- Data stall / jump mux logic
  with pipe_control_signals select
  IR1_next <= NOP when "JMP",
              IR1 when "STALL",
              pm_out when others;
    
  with pipe_control_signals select
  IR2_next <= NOP when "STALL",
              IR1 when others;
  
  IR3_next <= IR2;

  IR4_next <= IR3;
  
  -- Update registers on clock cycle
  process(clk)
  begin
    if rising_edge(clk) then 
      if rst = '1' then 
        IR1 <= NOP;
        IR2 <= NOP;
        IR3 <= NOP;
        IR4 <= NOP;
      else
      ' IR1 <= IR1_next;
        IR2 <= IR2_next;
        IR3 <= IR3_next;
        IR4 <= IR4_next;
      end if;
    end if;
  end;
end architecture;    

