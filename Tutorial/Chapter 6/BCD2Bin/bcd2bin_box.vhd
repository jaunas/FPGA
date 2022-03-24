library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd2bin_box is
    port(
        clk, reset : in  STD_LOGIC;
        start      : in  STD_LOGIC;
        switch     : in  STD_LOGIC_VECTOR (7 downto 0);
        ready      : out STD_LOGIC;
        an         : out STD_LOGIC_VECTOR (3 downto 0);
        sseg       : out STD_LOGIC_VECTOR (7 downto 0);
        sseg_p     : out STD_LOGIC
    );
end bcd2bin_box;

architecture Behavioral of bcd2bin_box is
    signal bin: STD_LOGIC_VECTOR(6 downto 0);
    signal not_ready: STD_LOGIC;
    signal hex1, hex0: STD_LOGIC_VECTOR(3 downto 0);
    signal an_tmp: STD_LOGIC_VECTOR(3 downto 0);
begin

    bcd2bin: entity work.bcd2bin port map(
        clk => clk,
        reset => not reset,
        start => not start,
        bcd => not switch,
        bin => bin,
        ready => not_ready,
        done_tick => open
    );

    display: entity work.HexDisplay port map(
        clk => clk,
        hex3 => (others => '0'),
        hex2 => (others => '0'),
        hex1 => hex1,
        hex0 => hex0,
        dp_in => "1111",
        an => an_tmp,
        sseg => sseg
    );

    hex1 <= '0' & bin(6 downto 4);
    hex0 <= bin(3 downto 0);

    sseg_p <= '1';
    an <= "00" & an_tmp(1 downto 0);

    ready <= not not_ready;

end Behavioral;
