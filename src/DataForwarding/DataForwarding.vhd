library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataForwarding is 
  port (
        clk: in std_logic;
				rst : in std_logic;
        A2 : in unsigned(31 downto 0);
        B2 : in unsigned(31 downto 0);
        D3 : in unsigned(31 downto 0);
        D4 : in unsigned(31 downto 0);
        IMM2 : in unsigned(15 downto 0); -- 16 bit immediate
        control_signal : in unsigned(5 downto 0);        
        ALU_a_out: buffer unsigned(31 downto 0);
        ALU_b_out: out unsigned(31 downto 0);
        AR3_out: out unsigned(15 downto 0) -- !6 bit address
  );  
end DataForwarding;

architecture Behavioral of DataForwarding is 

signal dataforwarding_b: unsigned(31 downto 0);
signal ar_argument : unsigned(15 downto 0); -- 16 bit address
signal AR3 :	unsigned(15 downto 0);
signal IMM2_sign_ext : unsigned(31 downto 0);

alias control_signal_a : unsigned(1 downto 0) is control_signal(1 downto 0);
alias control_signal_b : unsigned(1 downto 0) is control_signal(3 downto 2);
alias imm_or_b : unsigned(0 downto 0) is control_signal(4 downto 4);
alias ar_select : unsigned(0 downto 0) is control_signal(5 downto 5);

begin	
	
	-- rA dataforwarding MUX
	with control_signal_a select
		ALU_a_out <= A2 when "00",
								 D3 when "01",
								 D4 when others;

	-- rB dataforwarding MUX
	with control_signal_b select
		dataforwarding_b <= B2 when "00",
												D3 when "01",
												D4 when others;
 	
  -- Sign extend IMM2
  IMM2_sign_ext <= X"FFFF" & IMM2 when IMM2(15) = '1' else
                   X"0000" & IMM2;
  
	-- Immediate or rB MUX
	with imm_or_b select
		ALU_b_out <= IMM2_sign_ext when "1", -- Immediate instruction
								 dataforwarding_b when others;

	-- AR argument MUX 
	with ar_select select
		ar_argument <= ALU_a_out(15 downto 0) when "1", -- rA + offs
									 dataforwarding_b(15 downto 0) when others; -- rB + offs
	
	-- Synchronised updating of AR register		
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				AR3 <= X"0000";
			else 
  			AR3 <= IMM2 + ar_argument;  
   		end if;
		end if;
	end process;

	AR3_out <= AR3;

end Behavioral;


