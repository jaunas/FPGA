library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity box is
    port(
        clk, reset : in  STD_LOGIC;
        start, si  : in  STD_LOGIC;
        an         : out STD_LOGIC_VECTOR (3 downto 0);
        sseg       : out STD_LOGIC_VECTOR (7 downto 0);
        sseg_p     : out STD_LOGIC
    );
end box;

architecture Behavioral of box is
    signal si_db                  : std_logic;
    signal bcd3, bcd2, bcd1, bcd0 : std_logic_vector(3 downto 0);
begin

    counter_unit: entity work.low_frequency_counter
    port map(
        clk   => clk,
        reset => not reset,
        start => not start,
        si    => si_db,
        bcd3  => bcd3,
        bcd2  => bcd2,
        bcd1  => bcd1,
        bcd0  => bcd0
    );
    
    display_unit: entity work.HexDisplay
    port map(
        clk   => clk,
        reset => not reset,
        hex3  => bcd3,
        hex2  => bcd2,
        hex1  => bcd1,
        hex0  => bcd0,
        dp_in => "1111",
        an    => an,
        sseg  => sseg
    );
    sseg_p <= '1';
    
    si_db_unit: entity work.debounce
    port map(
        clk      => clk,
        reset    => not reset,
        sw       => not si,
        db_level => open,
        db_tick  => si_db
    );

end Behavioral;

