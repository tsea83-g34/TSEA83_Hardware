library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataForwarding is 
    port (
            clk: in std_logic;
            IR2: in unsigned(31 downto 0);
            IR3: in unsigned(31 downto 0);
            IR4: in unsigned(31 downto 0);
            ALU_a: out unsigned(31 downto 0);
            ALU_b: out unsigned(31 downto 0);
    );
end DataForwarding;

architecture Behavioral of DataForwarding is 

constant IR3_rom: unsigned(63 downto 0) = (others=>"0") -- Cancerous to hardcode, need a script, 64 instructions cap
constant IR4_rom: unsigned(63 downto 0) = (others=>"0") -- Dito
-- Might be able to save on performance by not allocating all the the memory, only the ones that are '1'

alias IR2_op = unsigned(5 downto 0) is IR2(31 downto 26); -- Probably won't work because IR2 is an INPUT?
alias IR2_a = unsigned(4 downto 0) is IR2(20 downto 16); -- Probably won't work because IR2 is an INPUT?
alias IR2_b = unsigned(4 downto 0) is IR2(15 downto 11); -- ......
alias IR3_d = unsigned(4 downto 0) is IR3(25 downto 21);
alias IR4_d = unsigned(4 downto 0) is IR4(25 downto 21);
signal alu_a = unsigned(31 downto 0);

begin
    process (clk)
    begin
        alu_a <= (others <= '0');
        if rising_edge(clk) then 
            if IR2_a = IR3_d then 
                if IR3_rom(IR2_op) = '1' then -- Probably wrong, have to convert to 'index' ?
                    alu_a <= (others <= '0'); -- D3 most prob. This should maybe be a control unit, or D3 should be an input.  
                end if;
            end if;
        end if;
    end process;
    ALU_a <= alu_a;




end Behavioral;