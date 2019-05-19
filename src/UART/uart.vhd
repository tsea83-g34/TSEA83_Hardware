library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity UART is
    Port ( 
          clk,rst, rx : in  STD_LOGIC;
          out_port : out unsigned(31 downto 0);
          read_signal : in std_logic
        );   -- rst är tryckknappen i mitten under
end UART;

architecture Behavioral of UART is

    signal sreg : UNSIGNED(9 downto 0) := B"0_00000000_0";  -- 10 bit skiftregister
    signal instruction : UNSIGNED(31 downto 0) := X"0000_0000";  
    signal rx1,rx2 : std_logic := '0';         -- vippor på insignalen
    signal sp : std_logic := '0';              -- skiftpuls
    signal lp : std_logic := '0';              -- laddpuls
    signal pos : UNSIGNED(1 downto 0) := "00";

		signal count : UNSIGNED(9 downto 0) := "0000000000";
		signal is_receiving : boolean := false ;
		signal receive_count : UNSIGNED(3 downto 0) := "0000";
  

    signal byte_value : unsigned(7 downto 0) := X"00";
    signal is_new : unsigned(0 downto 0) := "0";
    constant OUT_PADDING : unsigned(22 downto 0) := "000" & X"00000";
begin




  -- ***************************
  -- *  synkroniseringsvippor    *
  -- ***************************

	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then
				rx1 <= '1';
				rx2 <= '1';
			else
				rx1 <= rx;
				rx2 <= rx1;
			end if;
		end if;
	end process;
  
  -- ***************************
  -- *       styrenhet           *
  -- ***************************
	process(clk) begin

		if rising_edge(clk) then
			sp <= '0';
			lp <= '0';
			if rst = '1' then
				is_receiving <= false;
				count <= "0000000000";
				receive_count <= "0000";
				
			elsif not is_receiving then
				if rx1 = '0' then
					is_receiving <= true;
				end if;	
			else		
				count <= count + 1;
				if count = 400  then 
					sp <= '1';
				end if;
				if count >= 869 then 
					receive_count <= receive_count + 1;
					if receive_count >= 9 then
						is_receiving <= false;
						receive_count <= "0000";
						lp <= '1';
					end if;			
					count <= "0000000001";
				end if;
			end if;
			
				
		end if;
	end process;
                  

  -- ***************************
  -- * 10 bit skiftregister      *
  -- ***************************

	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then 
				sreg <= "0000000000";
			elsif sp = '1' then
				sreg <= sreg(8 DOWNTO 0) & rx2;
			end if;
		end if;
	end process;




  
  -- ***************************
  -- * 16 bit register           *
  -- ***************************
	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then 
				instruction <= X"0000_0000";
			elsif lp = '1' then 
        byte_value <= sreg(8 downto 1);
        is_new <= "1";
      elsif read_signal <= '1' then 
        is_new <= "0";
			end if;
		end if;
	end process;

  out_port <= OUT_PADDING & is_new & byte_value;
  

end Behavioral;
