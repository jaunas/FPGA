LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY low_frequency_counter_tb IS
END low_frequency_counter_tb;
 
ARCHITECTURE behavior OF low_frequency_counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT low_frequency_counter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         si : IN  std_logic;
         bcd3 : OUT  std_logic_vector(3 downto 0);
         bcd2 : OUT  std_logic_vector(3 downto 0);
         bcd1 : OUT  std_logic_vector(3 downto 0);
         bcd0 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal si : std_logic := '0';

 	--Outputs
   signal bcd3 : std_logic_vector(3 downto 0);
   signal bcd2 : std_logic_vector(3 downto 0);
   signal bcd1 : std_logic_vector(3 downto 0);
   signal bcd0 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: low_frequency_counter PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          si => si,
          bcd3 => bcd3,
          bcd2 => bcd2,
          bcd1 => bcd1,
          bcd0 => bcd0
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
        wait for clk_period*100;
        si <= '1';
        wait for clk_period*10;
        si <= '0';

        wait;
    end process;

END;
