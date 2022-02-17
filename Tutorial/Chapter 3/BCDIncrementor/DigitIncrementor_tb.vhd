LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DigitIncrementor_tb IS
END DigitIncrementor_tb;
 
ARCHITECTURE behavior OF DigitIncrementor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DigitIncrementor
    PORT(
         digit : IN  std_logic_vector(3 downto 0);
         enable : IN  std_logic;
         incremented_digit : OUT  std_logic_vector(3 downto 0);
         carry : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal digit : std_logic_vector(3 downto 0) := (others => '0');
   signal enable : std_logic := '0';

 	--Outputs
   signal incremented_digit : std_logic_vector(3 downto 0);
   signal carry : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DigitIncrementor PORT MAP (
          digit => digit,
          enable => enable,
          incremented_digit => incremented_digit,
          carry => carry
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- Disabled
      enable <= '0';
   
      digit <= "0000";
      wait for period;
      
      digit <= "0001";
      wait for period;
      
      digit <= "0111";
      wait for period;
      
      digit <= "1001";
      wait for period;
      
      -- Enabled
      enable <= '1';

      digit <= "0000";
      wait for period;
      
      digit <= "0001";
      wait for period;
      
      digit <= "0111";
      wait for period;
      
      digit <= "1001";
      wait for period;
            
      assert false
         report "Simulation complete"
         severity failure;
   end process;

END;
