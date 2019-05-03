-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit_tb is 
end ControlUnit_tb;

architecture behavior of ControlUnit_tb is 

  component control_unit
    port(
    );
  end component;


  signal clk : std_logic;
  signal rst : std_logic;

  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: control_unit port map(
  );

  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  

  process
  begin


    ------ Format of a test case -------

    -- Assign your inputs: A2 <= X"0000_0001";


    -- Have to wait TWO clock cycles, because this process
    -- AND the components process has to tick before the output
    -- of the component is registered
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    assert (
      2 = 1 + 1 -- Check that: {actual output} = {expected output}, for example: (a_out = '1') and (b_out = '0') 
    )
    report "Failed (Addition test). Expected output: 2"
    severity error;
    -------  END ---------

    -- Insert additional test cases here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
