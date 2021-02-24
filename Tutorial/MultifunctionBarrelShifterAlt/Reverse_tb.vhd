LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Reverse_tb IS
END Reverse_tb;
 
ARCHITECTURE behavior OF Reverse_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reverse
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reverse PORT MAP (
          a => a,
          y => y
        );

    -- Stimulus process
    stim_proc: process
    begin
        a <= "10000000";
        wait for 200ns;
        
        a <= "00000001";
        wait for 200ns;
        
        a <= "10101010";
        wait for 200ns;
        
        a <= "00001111";
        wait for 200ns;
        
        a <= "10000001";
        wait for 200ns;
        
        a <= "00011000";
        wait for 200ns;
        
    end process;

END;
