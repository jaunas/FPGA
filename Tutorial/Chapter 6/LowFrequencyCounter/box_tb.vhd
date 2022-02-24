LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY box_tb IS
END box_tb;
 
ARCHITECTURE behavior OF box_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT box
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         si : IN  std_logic;
         an : OUT  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(7 downto 0);
         sseg_p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal start : std_logic := '1';
   signal si : std_logic := '1';

 	--Outputs
   signal an : std_logic_vector(3 downto 0);
   signal sseg : std_logic_vector(7 downto 0);
   signal sseg_p : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: box PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          si => si,
          an => an,
          sseg => sseg,
          sseg_p => sseg_p
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
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for clk_period*10;

        start <= '0';
        wait for clk_period*10;
        start <= '1';
        wait for clk_period*10;
        
        si <= '0';
        wait for clk_period*10;
        si <= '1';
        wait for clk_period*100;
        si <= '0';
        wait for clk_period*10;
        si <= '1';
        wait for clk_period*10;

        wait;
    end process;

END;
