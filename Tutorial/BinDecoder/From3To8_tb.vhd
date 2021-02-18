LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY From3To8_tb IS
END From3To8_tb;
 
ARCHITECTURE behavior OF From3To8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT From3To8
    PORT(
         enable : IN  std_logic;
         from3 : IN  std_logic_vector(2 downto 0);
         to8 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal enable : std_logic := '0';
   signal from3 : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal to8 : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: From3To8 PORT MAP (
          enable => enable,
          from3 => from3,
          to8 => to8
        );

    -- Stimulus process
    process
    begin
        -- Enabled
        enable <= '1';
        
        from3 <= "000";
        wait for 200ns;
        
        from3 <= "001";
        wait for 200ns;
        
        from3 <= "010";
        wait for 200ns;
        
        from3 <= "011";
        wait for 200ns;
        
        from3 <= "100";
        wait for 200ns;
        
        from3 <= "101";
        wait for 200ns;
        
        from3 <= "110";
        wait for 200ns;
        
        from3 <= "111";
        wait for 200ns;
        
        -- Disabled
        enable <= '0';
        
        from3 <= "000";
        wait for 200ns;
        
        from3 <= "001";
        wait for 200ns;
        
        from3 <= "010";
        wait for 200ns;
        
        from3 <= "011";
        wait for 200ns;
        
        from3 <= "100";
        wait for 200ns;
        
        from3 <= "101";
        wait for 200ns;
        
        from3 <= "110";
        wait for 200ns;
        
        from3 <= "111";
        wait for 200ns;
        
        assert false
            report "Simulation Completed"
            severity failure;
    end process;

END;
