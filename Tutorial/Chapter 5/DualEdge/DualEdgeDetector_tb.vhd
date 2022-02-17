LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DualEdgeDetector_tb IS
END DualEdgeDetector_tb;
 
ARCHITECTURE behavior OF DualEdgeDetector_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DualEdgeDetector
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         level : IN  std_logic;
         tick : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal level : std_logic := '0';

 	--Outputs
   signal tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: DualEdgeDetector PORT MAP (
        clk => clk,
        reset => reset,
        level => level,
        tick => tick
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
 

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for clk_period*10;

        level <= '0';
        wait for clk_period*2;
        level <= '1';
        wait for clk_period*2;
        level <= '0';
        wait for clk_period*2;

        wait;
    end process;

END;
