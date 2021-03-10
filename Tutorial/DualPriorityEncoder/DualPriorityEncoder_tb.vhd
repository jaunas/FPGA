LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DualPriorityEncoder_tb IS
END DualPriorityEncoder_tb;
 
ARCHITECTURE behavior OF DualPriorityEncoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DualPriorityEncoder
    PORT(
         req : IN  std_logic_vector(12 downto 1);
         first : OUT  std_logic_vector(3 downto 0);
         second : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal req : std_logic_vector(12 downto 1) := (others => '0');

 	--Outputs
   signal first : std_logic_vector(3 downto 0);
   signal second : std_logic_vector(3 downto 0);

   constant period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DualPriorityEncoder PORT MAP (
          req => req,
          first => first,
          second => second
        );


    -- Stimulus process
    stim_proc: process
    begin
        req <= "100001010000";
        wait for period;
        
        req <= "010111000001";
        wait for period;
        
        req <= "100100011001";
        wait for period;
        
        req <= "010110011101";
        wait for period;
        
        req <= "110100111000";
        wait for period;
        
        req <= "001111101110";
        wait for period;
        
        req <= "000100101010";
        wait for period;
        
        assert false
            report "Simulation Completed"
            severity failure;
    end process;
END;
