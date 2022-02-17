LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY SquareWave_tb IS
END SquareWave_tb;
 
ARCHITECTURE behavior OF SquareWave_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SquareWave
    GENERIC (
        TICKS : integer
    );
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         m : IN  std_logic_vector(3 downto 0);
         n : IN  std_logic_vector(3 downto 0);
         wave : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal m : std_logic_vector(3 downto 0) := (others => '0');
   signal n : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal wave : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: SquareWave
    generic map (
        TICKS => 4
    )
    PORT MAP (
        clk => clk,
        reset => reset,
        m => m,
        n => n,
        wave => wave
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
        -- hold reset state
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- insert stimulus here
        -- 1 => 400 ns

        -- TODO: Try to add assertions

        m <= "0001";
        n <= "0001";
        wait for clk_period*50;
        
        m <= "0010";
        n <= "0010";
        wait for clk_period*100;

        m <= "0010";
        n <= "0001";
        wait for clk_period*100;

        m <= "0001";
        n <= "0010";
        wait for clk_period*100;

        m <= "0100";
        n <= "0001";
        wait for clk_period*200;
        
        m <= "1111";
        n <= "1111";
        wait for clk_period*800;
        
        wait;
    end process;

END;
