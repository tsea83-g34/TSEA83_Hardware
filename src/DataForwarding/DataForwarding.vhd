library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity DataForwarding is
  port (
        clk: in std_logic;
        A2 : in unsigned(31 downto 0);
        B2 : in unsigned(31 downto 0);
        D3 : in unsigned(31 downto 0);
        D4 : in unsigned(31 downto 0);
        IMM1 : in unsigned(31 downto 0);
        df_control_signal : in unsigned(4 downto 0);
        ALU_a_out: out unsigned(31 downto 0);
        ALU_b_out: out unsigned(31 downto 0);
        AR_out: out unsigned(31 downto 0)
  );
end DataForwarding;

architecture Behavioral of DataForwarding is
-- TODO: Update for control signals, maybe move some of the earlier code to Control Unit?


signal ALU_a: unsigned(31 downto 0);
signal ALU_b: unsigned(31 downto 0);
signal AR: unsigned(31 downto 0);

alias control_signal_a : unsigned(1 downto 0) is df_control_signal(1 downto 0);
alias control_signal_b : unsigned(1 downto 0) is df_control_signal(3 downto 2);
alias ar_write : unsigned(0 downto 0) is df_control_signal(4 downto 4);

begin
    -- ALU A
    process (clk)
    begin
      if rising_edge(clk) then
        case control_signal_a is
          when "00" =>
            ALU_a <= A2;
          when "01" =>
            ALU_a <= D3;
          when others =>
            ALU_a <= D4;
        end case;
        -- Switch statements to determine both data to send
        -- and where to send it (depending on 'ar').
        case control_signal_b is
          when "00" =>
            if ar_write = "1" then
              AR <= B2;
            else
              ALU_b <= B2;
            end if;
          when "01" =>
            if ar_write = "1" then
              AR <= D3;
            else
              ALU_b <= D3;
            end if;
          when "10" =>
            if ar_write = "1" then
              AR <= D4;
            else
              ALU_b <= D4;
            end if;
           when others =>
            ALU_b <= IMM1;
        end case;
      end if;
    end process;

    ALU_a_out <= ALU_a;
    ALU_b_out <= ALU_b;
    AR_out <= AR;

end Behavioral;
