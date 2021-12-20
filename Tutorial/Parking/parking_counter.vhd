library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_counter is
    port(
        clk, reset : in  std_logic;
        sensor     : in  std_logic_vector(1 downto 0);
        sseg       : out std_logic_vector(7 downto 0);
        an         : out std_logic_vector(1 downto 0)
    );
end parking_counter;

architecture Behavioral of parking_counter is
    signal enter, \exit\: std_logic;
    signal a, b: std_logic;
    signal count: std_logic_vector(7 downto 0);
    signal ext_an: std_logic_vector(3 downto 0);
begin

    gate: entity work.gate port map(
        clk => clk,
        reset => reset,
        a => sensor(0),
        b => sensor(1),
        enter => enter,
        \exit\ => \exit\
    );
    
    counter: entity work.counter port map(
        clk => clk,
        reset => reset,
        inc => enter,
        dec => \exit\,
        count => count
    );
    
    debounce_a: entity work.debounce port map(
        clk => clk,
        reset => reset,
        sw => sensor(0),
        db => a
    );

    debounce_b: entity work.debounce port map(
        clk => clk,
        reset => reset,
        sw => sensor(1),
        db => b
    );
    
    HexDisplay: entity work.HexDisplay port map(
        clk => clk,
        hex3 => "0000",
        hex2 => "0000",
        hex1 => count(7 downto 4),
        hex0 => count(3 downto 0),
        dp_in => "1111",
        an => ext_an,
        sseg => sseg
    );
    an <= ext_an(1 downto 0);

end Behavioral;

