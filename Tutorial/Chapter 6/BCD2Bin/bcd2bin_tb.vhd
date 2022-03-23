LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bcd2bin_tb IS
END bcd2bin_tb;

ARCHITECTURE behavior OF bcd2bin_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT bcd2bin
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         bcd : IN  std_logic_vector(7 downto 0);
         bin : OUT  std_logic_vector(6 downto 0);
         start : IN  std_logic;
         ready : OUT  std_logic;
         done_tick : OUT  std_logic
        );
    END COMPONENT;


   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal bcd : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal bin : std_logic_vector(6 downto 0);
   signal ready : std_logic;
   signal done_tick : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: bcd2bin PORT MAP(
        clk => clk,
        reset => reset,
        bcd => bcd,
        bin => bin,
        start => start,
        ready => ready,
        done_tick => done_tick
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
        bcd <= "10010110";
        start <= '1';
        wait for clk_period*2;
        start <= '0';
        wait until done_tick = '1';

        wait;
    end process;
END;
