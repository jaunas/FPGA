LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY From4To16_tb IS
END From4To16_tb;
 
ARCHITECTURE behavior OF From4To16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT From4To16
    PORT(
         enable : IN  std_logic;
         from4 : IN  std_logic_vector(3 downto 0);
         to16 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal enable : std_logic := '0';
   signal from4 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal to16 : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: From4To16 PORT MAP (
          enable => enable,
          from4 => from4,
          to16 => to16
        );

    -- Stimulus process
    process
    begin
        -- Enabled
        enable <= '1';
        
        from4 <= "0000";
        wait for 200ns;
        
        from4 <= "0001";
        wait for 200ns;
        
        from4 <= "0010";
        wait for 200ns;
        
        from4 <= "0011";
        wait for 200ns;
        
        from4 <= "0100";
        wait for 200ns;
        
        from4 <= "0101";
        wait for 200ns;
        
        from4 <= "0110";
        wait for 200ns;
        
        from4 <= "0111";
        wait for 200ns;
        
        from4 <= "1000";
        wait for 200ns;
        
        from4 <= "1001";
        wait for 200ns;
        
        from4 <= "1010";
        wait for 200ns;
        
        from4 <= "1011";
        wait for 200ns;
        
        from4 <= "1100";
        wait for 200ns;
        
        from4 <= "1101";
        wait for 200ns;
        
        from4 <= "1110";
        wait for 200ns;
        
        from4 <= "1111";
        wait for 200ns;
        
        -- Disabled
        enable <= '0';
        
        from4 <= "0000";
        wait for 200ns;
        
        from4 <= "0001";
        wait for 200ns;
        
        from4 <= "0010";
        wait for 200ns;
        
        from4 <= "0011";
        wait for 200ns;
        
        from4 <= "0100";
        wait for 200ns;
        
        from4 <= "0101";
        wait for 200ns;
        
        from4 <= "0110";
        wait for 200ns;
        
        from4 <= "0111";
        wait for 200ns;
        
        from4 <= "1000";
        wait for 200ns;
        
        from4 <= "1001";
        wait for 200ns;
        
        from4 <= "1010";
        wait for 200ns;
        
        from4 <= "1011";
        wait for 200ns;
        
        from4 <= "1100";
        wait for 200ns;
        
        from4 <= "1101";
        wait for 200ns;
        
        from4 <= "1110";
        wait for 200ns;
        
        from4 <= "1111";
        wait for 200ns;
        
        assert false
            report "Simulation Completed"
            severity failure;
    end process;

END;
