LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY FloatGT_tb IS
END FloatGT_tb;
 
ARCHITECTURE behavior OF FloatGT_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FloatGT
    PORT(
         sign1 : IN  std_logic;
         sign2 : IN  std_logic;
         exp1 : IN  std_logic_vector(3 downto 0);
         exp2 : IN  std_logic_vector(3 downto 0);
         frac1 : IN  std_logic_vector(7 downto 0);
         frac2 : IN  std_logic_vector(7 downto 0);
         gt : OUT  std_logic
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
   signal gt : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FloatGT PORT MAP (
          sign1 => sign1,
          sign2 => sign2,
          exp1 => exp1,
          exp2 => exp2,
          frac1 => frac1,
          frac2 => frac2,
          gt => gt
        );

    -- Stimulus process
    stim_proc: process
    begin
        wait for period;
        -- 0 0000 00000000  +0
        -- 0 0000 00000000  +0
        sign1 <= '0';
        exp1 <= "0000";
        frac1 <= "00000000";
        sign2 <= '0';
        exp2 <= "0000";
        frac2 <= "00000000";
        
        wait for period;
        -- 1 0001 11110000 -0.11110000 * 2^0001 = -1.875
        -- 1 1010 10111110 -0.10111110 * 2^1010 = -760
        sign1 <= '1';
        exp1 <= "0001";
        frac1 <= "11110000";
        sign2 <= '1';
        exp2 <= "1010";
        frac2 <= "10111110";

        wait for period;
        -- 1 1111 10111100  -0.10111100 * 2^1111 = -24064
        -- 0 1101 10000011  +0.10000011 * 2^1101 = 4192
        sign1 <= '1';
        exp1 <= "1111";
        frac1 <= "10111100";
        sign2 <= '0';
        exp2 <= "1101";
        frac2 <= "10000011";
        
        wait for period;
        -- 0 1101 10111100  +0.10111100 * 2^1101 = 6016
        -- 0 1101 10000011  +0.10000011 * 2^1101 = 4192
        sign1 <= '0';
        exp1 <= "1101";
        frac1 <= "10111100";
        sign2 <= '0';
        exp2 <= "1101";
        frac2 <= "10000011";
        
        wait for period;
        assert false
        report "Simulation complete" severity failure;
    end process;

END;
