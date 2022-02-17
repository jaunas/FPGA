LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY eq2_testbench IS
END eq2_testbench;
 
ARCHITECTURE behavior OF eq2_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT eq2
    PORT(
         a : IN  std_logic_vector(1 downto 0);
         b : IN  std_logic_vector(1 downto 0);
         aeqb : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(1 downto 0) := (others => '0');
   signal b : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal aeqb : std_logic;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: eq2 PORT MAP (
          a => a,
          b => b,
          aeqb => aeqb
        );

    -- Stimulus process
    process
    begin
        -- test vector 1
        a <= "00";
        b <= "00";
        wait for 200ns;
        
        -- test vector 2
        a <= "01";
        b <= "00";
        wait for 200ns;
        
        -- test vector 3
        a <= "01";
        b <= "11";
        wait for 200ns;
        
        -- test vector 4
        a <= "10";
        b <= "10";
        wait for 200ns;
        
        -- test vector 5
        a <= "10";
        b <= "00";
        wait for 200ns;
        
        -- test vector 6
        a <= "11";
        b <= "11";
        wait for 200ns;
        
        -- test vector 7
        a <= "11";
        b <= "01";
        wait for 200ns;
        
        assert false
            report "Simulation complete"
            severity failure;
    end process;

END;
