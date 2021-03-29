LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY BCDIncrementor_tb IS
END BCDIncrementor_tb;
 
ARCHITECTURE behavior OF BCDIncrementor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCDIncrementor
    PORT(
         number : IN  std_logic_vector(11 downto 0);
         incremented_number : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal number : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal incremented_number : std_logic_vector(11 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCDIncrementor PORT MAP (
          number => number,
          incremented_number => incremented_number
        );

	-- Stimulus process
	stim_proc: process
	begin
      -- 000
		number <= "000000000000";
		wait for period;
		
      -- 888
		number <= "100010001000";
		wait for period;
		
      -- 009
		number <= "000000001001";
		wait for period;
      
      -- 290
      number <= "001010010000";
      wait for period;
      
      -- 399
      number <= "001110011001";
      wait for period;
		
		assert false
            report "Simulation Completed"
            severity failure;
	end process;

END;
