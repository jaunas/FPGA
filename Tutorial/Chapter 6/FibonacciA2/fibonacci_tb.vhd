LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY fibonacci_tb IS
END fibonacci_tb;
 
ARCHITECTURE behavior OF fibonacci_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fibonacci
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         ready : OUT  std_logic;
         done_tick : OUT  std_logic;
         bcd_in : IN  std_logic_vector(7 downto 0);
         bcd_out : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal bcd_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal ready : std_logic;
   signal done_tick : std_logic;
   signal bcd_out : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fibonacci PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          ready => ready,
          done_tick => done_tick,
          bcd_in => bcd_in,
          bcd_out => bcd_out
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

        bcd_in <= "00000000"; -- 00
        start <= '1';
        wait for clk_period*2;
        start <= '0';
        wait until falling_edge(done_tick);
        assert bcd_out = "000000000000" report "Failed at fib(0)=0"; -- 000
        wait for clk_period*2;

        bcd_in <= "00000001"; -- 01
        start <= '1';
        wait for clk_period*2;
        start <= '0';
        wait until falling_edge(done_tick);
        assert bcd_out = "000000000001" report "Failed at fib(1)=1"; -- 001
        wait for clk_period*2;

        wait;
    end process;

END;
