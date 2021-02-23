LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY FloatingPointAdder_tb IS
END FloatingPointAdder_tb;
 
ARCHITECTURE behavior OF FloatingPointAdder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FloatingPointAdder
    PORT(
         sign1 : IN  std_logic;
         sign2 : IN  std_logic;
         exp1 : IN  std_logic_vector(3 downto 0);
         exp2 : IN  std_logic_vector(3 downto 0);
         frac1 : IN  std_logic_vector(7 downto 0);
         frac2 : IN  std_logic_vector(7 downto 0);
         sign_out : OUT  std_logic;
         exp_out : OUT  std_logic_vector(3 downto 0);
         frac_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sign1 : std_logic := '0';
   signal sign2 : std_logic := '0';
   signal exp1 : std_logic_vector(3 downto 0) := (others => '0');
   signal exp2 : std_logic_vector(3 downto 0) := (others => '0');
   signal frac1 : std_logic_vector(7 downto 0) := (others => '0');
   signal frac2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sign_out : std_logic;
   signal exp_out : std_logic_vector(3 downto 0);
   signal frac_out : std_logic_vector(7 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FloatingPointAdder PORT MAP (
          sign1 => sign1,
          sign2 => sign2,
          exp1 => exp1,
          exp2 => exp2,
          frac1 => frac1,
          frac2 => frac2,
          sign_out => sign_out,
          exp_out => exp_out,
          frac_out => frac_out
        );

    -- Stimulus process
    stim_proc: process
    constant period: time := 200ns;
    begin
        -- default values
        wait for 200ns;
        
        -- eg. 1               sort                align               add/sub             normalize
        -- 0 0011 10010111     1 0100 11010010     1 0100 11010010     1 0100 10000111     1 0100 10000111
        -- 1 0100 11010010     0 0011 10010111     0 0100 01001011
        sign1 <= '0';
        exp1 <= "0011";
        frac1 <= "10010111";

        sign2 <= '1';
        exp2 <= "0100";
        frac2 <= "11010010";
        
        wait for period;
        
        assert ((sign_out = '1') and (exp_out = "0100") and (frac_out = "10000111"))
        report "test failed for eg. 1" severity error;
        
        
        -- eg. 2               sort                align               add/sub             normalize
        -- 0 0011 10000111     1 0011 10101001     1 0011 10101001     1 0011 00100010     1 0001 10001000
        -- 1 0011 10101001     0 0011 10000111     0 0011 10000111
        sign1 <= '0';
        exp1 <= "0011";
        frac1 <= "10000111";

        sign2 <= '1';
        exp2 <= "0011";
        frac2 <= "10101001";
        
        wait for period;
        
        assert ((sign_out = '1') and (exp_out = "0001") and (frac_out = "10001000"))
        report "test failed for eg. 2" severity error;
        
        
        -- eg. 3               sort                align               add/sub             normalize
        -- 0 0000 10000111     1 0000 10101001     1 0000 10101001     1 0000 00100010     1 0000 00000000
        -- 1 0000 10101001     0 0000 10000111     0 0000 10000111
        sign1 <= '0';
        exp1 <= "0000";
        frac1 <= "10000111";

        sign2 <= '1';
        exp2 <= "0000";
        frac2 <= "10101001";
        
        wait for period;
        
        assert ((sign_out = '1') and (exp_out = "0000") and (frac_out = "00000000"))
        report "test failed for eg. 3" severity error;
        
        
        -- eg. 4               sort                align               add/sub             normalize
        -- 0 0011 11010010     0 0011 11010010     0 0011 11010010     0 0011 (1)01101001  0 0100 10110100
        -- 0 0011 10010111     0 0011 10010111     0 0011 10010111
        sign1 <= '0';
        exp1 <= "0011";
        frac1 <= "11010010";

        sign2 <= '0';
        exp2 <= "0011";
        frac2 <= "10010111";
        
        wait for period;
        
        assert ((sign_out = '0') and (exp_out = "0100") and (frac_out = "10110100"))
        report "test failed for eg. 4" severity error;
    end process;

END;
