library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

entity DataForwarding is 
  port (
        clk: in std_logic;
				rst : in std_logic;
        A2 : in unsigned(31 downto 0);
        B2 : in unsigned(31 downto 0);
        D3 : in unsigned(31 downto 0);
        D4 : in unsigned(31 downto 0);
        IMM2 : in unsigned(15 downto 0); -- 16 bit immediate
        df_a_select : in df_select;
        df_b_select : in df_select;    
        df_alu_imm_or_b : in df_alu_imm_or_b_enum; 
        df_ar_a_or_b : in df_ar_a_or_b_enum;

        ALU_a_out: buffer unsigned(31 downto 0)   :=  X"0000_0000";
        ALU_b_out: out unsigned(31 downto 0)      :=  X"0000_0000";
        AR3_out: out unsigned(15 downto 0)        :=  X"0000"
  );  
end DataForwarding;

architecture Behavioral of DataForwarding is 

  signal dataforwarding_b: unsigned(31 downto 0)  :=  X"0000_0000";
  signal ar_argument : unsigned(15 downto 0)      :=  X"0000";
  signal AR3 :	unsigned(15 downto 0)             :=  X"0000";
  signal IMM2_sign_ext : unsigned(31 downto 0)    :=  X"0000_0000";

begin	
	
	-- rA dataforwarding MUX
	with df_a_select select
	ALU_a_out <= A2 when DF_FROM_RF,
							 D3 when DF_FROM_D3,
							 D4 when DF_FROM_D4;

	-- rB dataforwarding MUX
	with df_b_select select
	dataforwarding_b <= B2 when DF_FROM_RF,
											D3 when DF_FROM_D3,
											D4 when DF_FROM_D4;
 	
  -- Sign extend IMM2
  IMM2_sign_ext <= X"FFFF" & IMM2 when IMM2(15) = '1' else
                   X"0000" & IMM2;
  
	-- Immediate or rB MUX
	with df_alu_imm_or_b select
	ALU_b_out <= IMM2_sign_ext when DF_ALU_IMM, -- Immediate instruction
							 dataforwarding_b when DF_ALU_B;

	-- AR argument MUX 
	with df_ar_a_or_b select
	ar_argument <= ALU_a_out(15 downto 0) when DF_AR_A, -- rA + offs
								 dataforwarding_b(15 downto 0) when DF_AR_B; -- rB + offs
	
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


