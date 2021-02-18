library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity From3To8 is
    port(
        enable: in std_logic;
        from3: in std_logic_vector(2 downto 0);
        to8: out std_logic_vector(7 downto 0)
    );
end From3To8;

architecture Behavioral of From3To8 is
    signal enableLow, enableHigh: std_logic;
    signal low, high: std_logic_vector(3 downto 0);
begin
    from2To4_low: entity work.From2To4
    port map(
        from2 => from3(1 downto 0),
        enable => enableLow,
        to4 => low
    );
    
    from2To4_high: entity work.From2To4
    port map(
        from2 => from3(1 downto 0),
        enable => enableHigh,
        to4 => high
    );

    enableLow <= enable and (not from3(2));
    enableHigh <= enable and from3(2);
    
    to8 <= high & low;
end Behavioral;

