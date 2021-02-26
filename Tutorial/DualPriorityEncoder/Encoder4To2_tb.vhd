LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Encoder4To2_tb IS
END Encoder4To2_tb;
 
ARCHITECTURE behavior OF Encoder4To2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Encoder4To2
    PORT(
         req : IN  std_logic_vector(3 downto 0);
         first : OUT  std_logic_vector(1 downto 0);
         second : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal req : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal first : std_logic_vector(1 downto 0);
   signal second : std_logic_vector(1 downto 0);

   constant period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Encoder4To2 PORT MAP (
          req => req,
          first => first,
          second => second
        );

    -- Stimulus process
    stim_proc: process
    begin
        req <= "0011";
        wait for period;
        
        req <= "0101";
        wait for period;
        
        req <= "0110";
        wait for period;
        
        req <= "0111";
        wait for period;
        
        req <= "1001";
        wait for period;
        
        req <= "1010";
        wait for period;
        
        req <= "1011";
        wait for period;
        
        req <= "1100";
        wait for period;
        
        req <= "1101";
        wait for period;
        
        req <= "1110";
        wait for period;
        
        req <= "1111";
        wait for period;
        
        assert false
            report "Simulation complete"
            severity failure;
    end process;

END;
