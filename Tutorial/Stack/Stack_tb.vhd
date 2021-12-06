LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Stack_tb IS
END Stack_tb;
 
ARCHITECTURE behavior OF Stack_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Stack
    PORT(
        clk : IN  std_logic;
        reset : IN  std_logic;
        push : IN  std_logic;
        pop : IN  std_logic;
        empty : OUT  std_logic;
        full : OUT  std_logic;
        w_data : IN  std_logic_vector(7 downto 0);
        r_data : OUT  std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    

    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal push : std_logic := '0';
    signal pop : std_logic := '0';
    signal w_data : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
    signal empty : std_logic;
    signal full : std_logic;
    signal r_data : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: Stack PORT MAP (
        clk => clk,
        reset => reset,
        push => push,
        pop => pop,
        empty => empty,
        full => full,
        w_data => w_data,
        r_data => r_data
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

        w_data <= "00110011";
        wait for clk_period;
        push <= '1';            -- 1 item
        wait for clk_period;
        push <= '0';
        wait for clk_period;

        pop <= '1';             -- 0 items
        wait for clk_period;
        pop <= '0';
        wait for clk_period;

        pop <= '1';             -- 0 items
        wait for clk_period;
        pop <= '0';
        wait for clk_period;

        w_data <= "00000001";
        wait for clk_period;
        push <= '1';            -- 1 item
        wait for clk_period;
        push <= '0';
        wait for clk_period;

        w_data <= "00000010";
        wait for clk_period;
        push <= '1';            -- 2 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00000011";
        wait for clk_period;
        push <= '1';            -- 3 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00000100";
        wait for clk_period;
        push <= '1';            -- 4 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00000101";
        wait for clk_period;
        push <= '1';            -- 5 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00000110";
        wait for clk_period;
        push <= '1';            -- 6 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00000111";
        wait for clk_period;
        push <= '1';            -- 7 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001000";
        wait for clk_period;
        push <= '1';            -- 8 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001001";
        wait for clk_period;
        push <= '1';            -- 9 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001010";
        wait for clk_period;
        push <= '1';            -- 10 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001011";
        wait for clk_period;
        push <= '1';            -- 11 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001100";
        wait for clk_period;
        push <= '1';            -- 12 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001101";
        wait for clk_period;
        push <= '1';            -- 13 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001110";
        wait for clk_period;
        push <= '1';            -- 14 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00001111";
        wait for clk_period;
        push <= '1';            -- 15 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "00010000";
        wait for clk_period;
        push <= '1';            -- 16 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        w_data <= "11111111";
        wait for clk_period;
        push <= '1';            -- 16 items
        wait for clk_period;
        push <= '0';
        wait for clk_period;
        
        pop <= '1';             -- 15 items
        wait for clk_period;
        pop <= '0';
        wait for clk_period;

        wait for clk_period*10;
        assert false severity failure;
    end process;

END;
