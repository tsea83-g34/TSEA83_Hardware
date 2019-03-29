library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_forwarding is 
  port (
        clk: in std_logic;

        OP1 : in unsigned(31 downto 0);
        OP2 : in unsigned(31 downto 0);
        IMM1 : in unsigned(31 downto 0);
        
        alu_res_3 : in unsigned(31 downto 0);
        alu_res_4 : in unsigned(31 downto 0);

        dataforwarding_control_signal : in unsigned(1 downto 0);

        ALU_a: out unsigned(31 downto 0);
        ALU_b: out unsigned(31 downto 0);
  );  
end data_forwarding;

architecture Behavioral of data_forwarding is 
-- TODO: Update for control signals, maybe move some of the earlier code to Control Unit?

constant IR3_rom: unsigned(63 downto 0) = (others=>"0") 
constant IR4_rom: unsigned(63 downto 0) = (others=>"0") 



signal alu_a = unsigned(31 downto 0);

begin
    process (clk)
    begin
        alu_a <= (others <= '0');
        if rising_edge(clk) then 
            if IR2_a = IR3_d then 
                if IR3_rom(IR2_op) = '1' then 
                    alu_a <= (others <= '0'); -- D3
                end if;
            end if;
        end if;
    end process;
    ALU_a <= alu_a;




end Behavioral;
