LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MultifunctionBarrelShifter_tb IS
END MultifunctionBarrelShifter_tb;
 
ARCHITECTURE behavior OF MultifunctionBarrelShifter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MultifunctionBarrelShifter
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         amt : IN  std_logic_vector(3 downto 0);
         lr : IN  std_logic;
         y : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal amt : std_logic_vector(3 downto 0) := (others => '0');
   signal lr : std_logic := '0';

 	--Outputs
   signal y : std_logic_vector(15 downto 0);
 
   constant period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MultifunctionBarrelShifter PORT MAP (
          a => a,
          amt => amt,
          lr => lr,
          y => y
        );


    -- Stimulus process
    stim_proc: process
    begin
        a <= "0000000110000000";
    
        -- to the left
        lr <= '1';
        amt <= "0000";
        wait for period;
        amt <= "0001";
        wait for period;
        amt <= "0010";
        wait for period;
        amt <= "0101";
        wait for period;
        amt <= "1010";
        wait for period;

        -- to the right
        lr <= '0';
        amt <= "0000";
        wait for period;
        amt <= "0001";
        wait for period;
        amt <= "0010";
        wait for period;
        amt <= "0101";
        wait for period;
        amt <= "1010";
        wait for period;
        
        assert false
        report "Simulation complete" severity failure;
    end process;

END;
