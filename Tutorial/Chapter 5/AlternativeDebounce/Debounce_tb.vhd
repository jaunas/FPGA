LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Debounce_tb IS
END Debounce_tb;
 
ARCHITECTURE behavior OF Debounce_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debounce
    generic (N : integer := 17);
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sw : IN  std_logic;
         db : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sw : std_logic := '0';

 	--Outputs
   signal db : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: Debounce
    generic map(N=>4)
    PORT MAP (
        clk => clk,
        reset => reset,
        sw => sw,
        db => db
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
        sw <= '1';
        wait for clk_period*10;
        sw <= '0';
        wait for clk_period*10;
        sw <= '1';
        wait for clk_period*10;
        sw <= '0';
        wait for clk_period*100;
        wait;
    end process;

END;
