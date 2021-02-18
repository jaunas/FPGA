LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY gt2_testbench IS
END gt2_testbench;
 
ARCHITECTURE behavior OF gt2_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gt2
    PORT(
         a : IN  std_logic_vector(1 downto 0);
         b : IN  std_logic_vector(1 downto 0);
         gt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(1 downto 0) := (others => '0');
   signal b : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal gt : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: gt2 PORT MAP (
          a => a,
          b => b,
          gt => gt
        );

    -- Stimulus process
    process
    begin
        a <= "00";
        b <= "00";
        wait for 200 ns;
        
        a <= "00";
        b <= "01";
        wait for 200 ns;
        
        a <= "00";
        b <= "10";
        wait for 200 ns;
        
        a <= "00";
        b <= "11";
        wait for 200 ns;
        
        a <= "01";
        b <= "00";
        wait for 200 ns;
        
        a <= "01";
        b <= "01";
        wait for 200 ns;
        
        a <= "01";
        b <= "10";
        wait for 200 ns;
        
        a <= "01";
        b <= "11";
        wait for 200 ns;
        
        a <= "10";
        b <= "00";
        wait for 200 ns;
        
        a <= "10";
        b <= "01";
        wait for 200 ns;
        
        a <= "10";
        b <= "10";
        wait for 200 ns;
        
        a <= "10";
        b <= "11";
        wait for 200 ns;
        
        a <= "11";
        b <= "00";
        wait for 200 ns;
        
        a <= "11";
        b <= "01";
        wait for 200 ns;
        
        a <= "11";
        b <= "10";
        wait for 200 ns;
        
        a <= "11";
        b <= "11";
        wait for 200 ns;
        
    end process;

END;
