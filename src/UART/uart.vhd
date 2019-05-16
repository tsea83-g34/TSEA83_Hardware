library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity lab is
    Port ( clk,rst, rx : in  STD_LOGIC;    -- rst är tryckknappen i mitten under displayen
           seg: out  UNSIGNED(7 downto 0);
           an : out  UNSIGNED (3 downto 0));
end lab;

architecture Behavioral of lab is

  component leddriver
    Port ( clk,rst : in  STD_LOGIC;
           seg : out  UNSIGNED(7 downto 0);
           an : out  UNSIGNED (3 downto 0);
           value : in  UNSIGNED (15 downto 0));
  end component;

    signal sreg : UNSIGNED(9 downto 0) := B"0_00000000_0";  -- 10 bit skiftregister
    signal tal : UNSIGNED(15 downto 0) := X"0000";  
    signal rx1,rx2 : std_logic;         -- vippor på insignalen
    signal sp : std_logic;              -- skiftpuls
    signal lp : std_logic;              -- laddpuls
    signal pos : UNSIGNED(1 downto 0) := "00";

		signal count : UNSIGNED(9 downto 0) := "0000000000";
    signal assembly_line : unsigned(31 downto 0) := X"0000_0000";
    signal is_programming : boolean := false;
    signal is_assembly_line : boolean := false;
    signal load_assembly : boolean := false;
		signal receiving : boolean := false ;
    signal line_count : unsigned(1 downto 0) := "00";
		signal receive_count : UNSIGNED(3 downto 0) := "0000";
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
				receiving <= '0';
				count <= "0000000000";
				receive_count <= "0000";
				
			elsif receiving = '0' then
				if rx1 = '0' then
					receiving <= '1';
          if not is_programming then
            is_programming = true;
          end if;
          if not is_assembly_line then 
            is_assembly_line = true;
          end if;
				end if;	
			else		
				count <= count + 1;
				if count = 400  then 
					sp <= '1';
				end if;
				if count >= 869 then 
					receive_count <= receive_count + 1;
					if receive_count >= 9 then
						receiving <= '0';
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
				sreg <= rx2 & sreg(9 DOWNTO 1);
			end if;
		end if;
	end process;



  -- ***************************
  -- * 2  bit register           *
  -- ***************************
	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then 
				pos <= "00";
			elsif lp = '1' then
				pos <= pos + 1;
				if pos = "11" then
          is_assembly_line = false;
          load_assembly = true;
					pos <= "00";
				end if;
			end if;
		end if;
	end process
  
  -- ***************************
  -- * 16 bit register           *
  -- ***************************
	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then 
				tal <= "0000000000000000";
			elsif lp = '1' then 
				case pos is
					when "00" => tal(31 downto 24) <= sreg(8 downto 1);
					when "01" => tal(23 downto 16) <= sreg(8 downto 1);
					when "10" => tal(15 downto 8) <= sreg(8 downto 1);
					when "11" => tal(7 downto 0) <=  sreg(8 downto 1);
					when others => null;
				end case;
			end if;
		end if;
	end process;

	process(clk) begin
		if rising_edge(clk) then
			if rst = '1' then 
				
			elsif load_assembly then 
        -- TODO: send output to ProgramMemory
			end if;
		end if;
	end process;
  

end Behavioral;
