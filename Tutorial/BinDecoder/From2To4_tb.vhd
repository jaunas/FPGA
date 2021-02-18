LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY From2To4_tb IS
END From2To4_tb;
 
ARCHITECTURE behavior OF From2To4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT From2To4
    PORT(
         enable : IN  std_logic;
         from2 : IN  std_logic_vector(1 downto 0);
         to4 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal enable : std_logic := '0';
   signal from2 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal to4 : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: From2To4 PORT MAP (
          enable => enable,
          from2 => from2,
          to4 => to4
        );


    -- Stimulus process
    process
    begin
        -- Enabled
        enable <= '1';
        
        from2 <= "00";
        wait for 200ns;
        
        from2 <= "01";
        wait for 200ns;
        
        from2 <= "10";
        wait for 200ns;
        
        from2 <= "11";
        wait for 200ns;
        
        -- Disabled
        enable <= '0';
        
        from2 <= "00";
        wait for 200ns;
        
        from2 <= "01";
        wait for 200ns;
        
        from2 <= "10";
        wait for 200ns;
        
        from2 <= "11";
        wait for 200ns;
        
        assert false
            report "Simulation Completed"
            severity failure;
    end process;

END;
