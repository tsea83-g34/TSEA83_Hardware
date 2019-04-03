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

  type test_record is record 
    $declare_test_record
  end record; 
  type test_record_array is array(natural range <>) of test_record;
  constant test_records : test_record_array := (
    $test_records
  );

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
    for i in test_records'range loop 
      $assign_input
      wait until rising_edge(clk);
      assert (
        $check_output
      )
      report "Failed test " & integer'image(i) & "failed." severity error;
    end loop;
    -- Insert test here, and add more if you want 
    wait until rising_edge(clk);
    wait for 1 us;
    
    tb_running <= false;           
    wait;
  end process;
      
end;
