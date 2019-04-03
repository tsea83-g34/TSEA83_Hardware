-- TestBench Template 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity $file_name is 
end $file_name;

architecture behavior of $file_name is 

  component $entity_name
    port(
      $ports
    );
  end component;


  $signals
  signal tb_running: boolean := true;
  
  
begin

  -- Component Instantiation
  uut: $entity_name port map(
    $initialize_component
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
    wait until rising_edge(clk);

    

    assert (
      ('1') and ('0')
    )
    report "Failed {insert_name} . Expected output: " & unsigned'image(INSERT)
    severity error;
    
    wait until rising_edge(clk);

    -- Insert additional tests here


    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
