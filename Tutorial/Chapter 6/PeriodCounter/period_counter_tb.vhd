LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY period_counter_tb IS
END period_counter_tb;
 
ARCHITECTURE behavior OF period_counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT period_counter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         si : IN  std_logic;
         ready : OUT  std_logic;
         done_tick : OUT  std_logic;
         prd : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal si : std_logic := '0';

 	--Outputs
   signal ready : std_logic;
   signal done_tick : std_logic;
   signal prd : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: period_counter PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          si => si,
          ready => ready,
          done_tick => done_tick,
          prd => prd
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

        -- insert stimulus here
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait for clk_period*10;
        
        si <= '1';
        wait for clk_period*10;
        si <= '0';
        wait for 15 ms;
        si <= '1';
        wait for clk_period*10;
        si <= '0';

        wait;
    end process;

END;
