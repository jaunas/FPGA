LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PWM_tb IS
END PWM_tb;
 
ARCHITECTURE behavior OF PWM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         w : IN  std_logic_vector(3 downto 0);
         wave : OUT  std_logic
        );
    END COMPONENT;
    

    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal w : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
    signal wave : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: PWM PORT MAP (
        clk => clk,
        reset => reset,
        w => w,
        wave => wave
    );

    -- Clock process definitions
    clk_process: process
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
        w <= "0000";
        wait for clk_period*40;

        w <= "0001";
        wait for clk_period*40;

        w <= "0010";
        wait for clk_period*40;

        w <= "0011";
        wait for clk_period*40;

        w <= "0100";
        wait for clk_period*40;
        
        w <= "1000";
        wait for clk_period*40;
        
        w <= "1010";
        wait for clk_period*40;
        
        w <= "1110";
        wait for clk_period*40;
        
        w <= "1111";
--        wait for clk_period*40;

        wait;
    end process;

END;
