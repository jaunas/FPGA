LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY bin2bcd_tb IS
END bin2bcd_tb;
 
ARCHITECTURE behavior OF bin2bcd_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bin2bcd
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         bin : IN  std_logic_vector(12 downto 0);
         ready : OUT  std_logic;
         done_tick : OUT  std_logic;
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
   signal bin : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal ready : std_logic;
   signal done_tick : std_logic;
   signal bcd3 : std_logic_vector(3 downto 0);
   signal bcd2 : std_logic_vector(3 downto 0);
   signal bcd1 : std_logic_vector(3 downto 0);
   signal bcd0 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bin2bcd PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          bin => bin,
          ready => ready,
          done_tick => done_tick,
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
        bin <= "0000011111111"; -- 0255
        wait for clk_period;
        start <= '1'; wait for clk_period;
        start <= '0'; wait for clk_period;
        wait until falling_edge(done_tick);
        assert bcd3 = "0000" report "Failed to convert 0255" severity error;
        assert bcd2 = "0010" report "Failed to convert 0255" severity error;
        assert bcd1 = "0101" report "Failed to convert 0255" severity error;
        assert bcd0 = "0101" report "Failed to convert 0255" severity error;
        wait for clk_period*10;

        bin <= "1111111111111"; -- 8191
        wait for clk_period;
        start <= '1'; wait for clk_period;
        start <= '0'; wait for clk_period;
        wait until falling_edge(done_tick);
        assert bcd3 = "1000" report "Failed to convert 8191" severity error;
        assert bcd2 = "0001" report "Failed to convert 8191" severity error;
        assert bcd1 = "1001" report "Failed to convert 8191" severity error;
        assert bcd0 = "0001" report "Failed to convert 8191" severity error;
        wait for clk_period*10;

        bin <= "1010110001101"; -- 5517
        wait for clk_period;
        start <= '1'; wait for clk_period;
        start <= '0'; wait for clk_period;
        wait until falling_edge(done_tick);
        assert bcd3 = "0101" report "Failed to convert 5517" severity error;
        assert bcd2 = "0101" report "Failed to convert 5517" severity error;
        assert bcd1 = "0001" report "Failed to convert 5517" severity error;
        assert bcd0 = "0111" report "Failed to convert 5517" severity error;
        wait for clk_period*10;

        bin <= "1000000000000"; -- 4096
        wait for clk_period;
        start <= '1'; wait for clk_period;
        start <= '0'; wait for clk_period;
        wait until falling_edge(done_tick);
        assert bcd3 = "0100" report "Failed to convert 4096" severity error;
        assert bcd2 = "0000" report "Failed to convert 4096" severity error;
        assert bcd1 = "1001" report "Failed to convert 4096" severity error;
        assert bcd0 = "0110" report "Failed to convert 4096" severity error;
        wait for clk_period*10;

        wait;
    end process;

END;
