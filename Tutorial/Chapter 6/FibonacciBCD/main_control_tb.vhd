LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY main_control_tb IS
END main_control_tb;

ARCHITECTURE behavior OF main_control_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT main_control
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         bcd_in : IN  std_logic_vector(7 downto 0);
         bcd_out : OUT  std_logic_vector(15 downto 0);
         start : IN  std_logic;
         ready : OUT  std_logic;
         overflow : OUT  std_logic
        );
    END COMPONENT;


   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal bcd_in : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal bcd_out : std_logic_vector(15 downto 0);
   signal ready : std_logic;
   signal overflow : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: main_control PORT MAP (
          clk => clk,
          reset => reset,
          bcd_in => bcd_in,
          bcd_out => bcd_out,
          start => start,
          ready => ready,
          overflow => overflow
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

        bcd_in <= B"0000_1001"; -- 9
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"0000_0000_0011_0100" -- 34
        report "Failed at Fib(9) = 34"
        severity failure;

        bcd_in <= B"0001_0101"; -- 15
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"0000_0110_0001_0000" -- 610
        report "Failed at Fib(15) = 610"
        severity failure;

        bcd_in <= B"0010_0000"; -- 20
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"0110_0111_0110_0101" -- 6765
        report "Failed at Fib(20) = 6765"
        severity failure;

        bcd_in <= B"0010_0001"; -- 21
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"1001_1001_1001_1001" and overflow = '1' -- 9999
        report "Failed at Fib(21) = 9999 with overflow"
        severity failure;

        bcd_in <= B"0011_0001"; -- 31
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"1001_1001_1001_1001" and overflow = '1' -- 9999
        report "Failed at Fib(31) = 9999 with overflow"
        severity failure;

        bcd_in <= B"1001_1001"; -- 99
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"1001_1001_1001_1001" and overflow = '1' -- 9999
        report "Failed at Fib(99) = 9999 with overflow"
        severity failure;

        bcd_in <= B"0000_0000"; -- 0
        start <= '1';
        wait for clk_period*10;
        start <= '0';
        wait until ready = '1';
        assert bcd_out = B"0000_0000_0000_0000" -- 0
        report "Failed at Fib(0) = 0"
        severity failure;

        wait;
    end process;

END;
