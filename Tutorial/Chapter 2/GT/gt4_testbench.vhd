LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY gt4_testbench IS
END gt4_testbench;
 
ARCHITECTURE behavior OF gt4_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gt4
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         gt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal gt : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gt4 PORT MAP (
          a => a,
          b => b,
          gt => gt
        );


    -- Stimulus process
    process
    begin		
        a <= "0000";
        b <= "0000";
        wait for 200ns;
        
        a <= "0001";
        b <= "0000";
        wait for 200ns;
        
        a <= "0010";
        b <= "0001";
        wait for 200ns;
        
        a <= "0100";
        b <= "0000";
        wait for 200ns;
        
        a <= "0100";
        b <= "0001";
        wait for 200ns;
        
        a <= "1000";
        b <= "0001";
        wait for 200ns;
        
        a <= "0011";
        b <= "0111";
        wait for 200ns;
        
        a <= "0011";
        b <= "0100";
        wait for 200ns;
        
        assert false
            report "Sumulation Completed"
            severity failure;
        
    end process;

END;
