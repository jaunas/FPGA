LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MultifunctionBarrelShifterAlt_tb IS
END MultifunctionBarrelShifterAlt_tb;
 
ARCHITECTURE behavior OF MultifunctionBarrelShifterAlt_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MultifunctionBarrelShifterAlt
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         amt : IN  std_logic_vector(4 downto 0);
         lr : IN  std_logic;
         y : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal amt : std_logic_vector(4 downto 0) := (others => '0');
   signal lr : std_logic := '0';

 	--Outputs
   signal y : std_logic_vector(31 downto 0);
 
   constant period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MultifunctionBarrelShifterAlt PORT MAP (
          a => a,
          amt => amt,
          lr => lr,
          y => y
        );

    -- Stimulus process
    stim_proc: process
    begin
        a <= "00000000000000011000000000000000";
    
        -- to the left
        lr <= '1';
        amt <= "00000";
        wait for period;
        amt <= "00001";
        wait for period;
        amt <= "00010";
        wait for period;
        amt <= "00101";
        wait for period;
        amt <= "01010";
        wait for period;
        amt <= "11010";
        wait for period;

        -- to the right
        lr <= '0';
        amt <= "00000";
        wait for period;
        amt <= "00001";
        wait for period;
        amt <= "00010";
        wait for period;
        amt <= "00101";
        wait for period;
        amt <= "01010";
        wait for period;
        amt <= "11010";
        wait for period;
        
        assert false
        report "Simulation complete" severity failure;
    end process;
END;
