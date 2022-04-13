library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity box is
    port(
        clk, reset      : in  STD_LOGIC;
        bcd_in          : in  STD_LOGIC_VECTOR (7 downto 0);
        start           : in  STD_LOGIC;
        sseg            : out STD_LOGIC_VECTOR (7 downto 0);
        an              : out STD_LOGIC_VECTOR (3 downto 0);
        sseg_p           : out STD_LOGIC;
        overflow, ready : out STD_LOGIC
    );
end box;

architecture Behavioral of box is
    signal bcd_out: std_logic_vector(15 downto 0);
    signal overflow_i, ready_i: std_logic;
begin

    fib_bcd_unit: entity work.main_control
    port map(
        clk => clk,
        reset => not reset,
        bcd_in => not bcd_in,
        bcd_out => bcd_out,
        start => not start,
        overflow => overflow_i,
        ready => ready_i
    );
    overflow <= not overflow_i;
    ready <= not ready_i;

    display_unit: entity work.HexDisplay
    port map(
        clk => clk,
        hex3 => bcd_out(15 downto 12),
        hex2 => bcd_out(11 downto 8),
        hex1 => bcd_out(7 downto 4),
        hex0 => bcd_out(3 downto 0),
        dp_in => "1111",
        an => an,
        sseg => sseg
    );

    sseg_p <= '1';

end Behavioral;
