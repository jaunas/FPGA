library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fibonacci_impl is
    port(
        clk, reset   : in  std_logic;
        i            : in  std_logic_vector(4 downto 0);
        run          : in  std_logic;
        ready        : out std_logic;
        sseg         : out std_logic_vector(7 downto 0);
        an           : out std_logic_vector(3 downto 0);
        sseg_p       : out std_logic
    );
end fibonacci_impl;

architecture Behavioral of fibonacci_impl is
    signal start: std_logic;
    signal ready_i: std_logic;
    signal f: std_logic_vector(19 downto 0);
begin

    fibonacci: entity work.fibonacci port map(
        clk => clk,
        reset => not reset,
        start => start,
        i => not i,
        ready => ready_i,
        done_tick => open,
        f => f
    );
    
    debounce_run: entity work.debounce port map(
        clk => clk,
        reset => not reset,
        sw => not run,
        db_level => open,
        db_tick => start
    );
    
    ready <= not ready_i;
    
    dispaly: entity work.HexDisplay port map(
        clk => clk,
        hex3 => f(15 downto 12),
        hex2 => f(11 downto 8),
        hex1 => f(7 downto 4),
        hex0 => f(3 downto 0),
        dp_in => "1111",
        an => an,
        sseg => sseg
    );
    
    sseg_p <= '1';

end Behavioral;

