LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Int2Float_tb IS
END Int2Float_tb;
 
ARCHITECTURE behavior OF Int2Float_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Int2Float
    PORT(
         int : IN  std_logic_vector(7 downto 0);
         sign : OUT  std_logic;
         exp : OUT  std_logic_vector(3 downto 0);
         frac : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal int : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal sign : std_logic;
   signal exp : std_logic_vector(3 downto 0);
   signal frac : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Int2Float PORT MAP (
          int => int,
          sign => sign,
          exp => exp,
          frac => frac
        );

    -- Stimulus process
    stim_proc: process
    begin
        wait for period;
        
        int <= "10101010"; -- -86
        wait for period;
        
        assert sign = '1' and exp = "0111" and frac = "10101100"
        report "Number -86 is not converted correctly" severity failure;
        
        int <= "00111100"; -- 74
        wait for period;

        assert sign = '0' and exp = "0110" and frac = "11110000"
        report "Number 74 is not converted correctly" severity failure;
        
        int <= "10000000"; -- -128
        wait for period;
        
        assert sign = '1' and exp = "1000" and frac = "10000000"
        report "Number -128 is not converted correctly" severity failure;
        
        int <= "01111111"; -- 127
        wait for period;
        
        assert sign = '0' and exp = "0111" and frac = "11111110"
        report "Number 127 is not converted correctly" severity failure;
        
        int <= "00000000"; -- 0
        wait for period;
        
        assert sign = '0' and exp = "0000" and frac = "00000000"
        report "Number 0 is not converted correctly" severity failure;
        
        int <= "00000001"; -- 1
        wait for period;
        
        assert sign = '0' and exp = "0001" and frac = "10000000"
        report "Number 1 is not converted correctly" severity failure;
        
        int <= "11111111"; -- -1
        wait for period;
        
        assert sign = '1' and exp = "0001" and frac = "10000000"
        report "Number 1 is not converted correctly" severity failure;
        
        wait;
    end process;

END;
