library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Int2Float_impl is
    port(
        clk: in std_logic;
        int: in std_logic_vector(7 downto 0);
        sseg: out std_logic_vector(7 downto 0);
        an: out std_logic_vector(2 downto 0);
        switch: in std_logic;
        sign: out std_logic
    );
end Int2Float_impl;

architecture Behavioral of Int2Float_impl is
    signal displayed_number, frac, low_ssg, high_ssg: std_logic_vector(7 downto 0);
    signal exp: std_logic_vector(3 downto 0);
begin

    with switch select
        displayed_number <=
            frac when '1',
            "0000" & exp when others;

    converter: entity work.Int2Float port map(
        int => not(int),
        sign => sign,
        exp => exp,
        frac => frac
    );
    
    low_hex: entity work.Hex7Seg port map(
        hex => displayed_number(3 downto 0),
        dp => '1',
        sseg => low_ssg
    );

    high_hex: entity work.Hex7Seg port map(
        hex => displayed_number(7 downto 4),
        dp => '1',
        sseg => high_ssg
    );

    display: entity work.DisplayMux port map(
        clk => clk,
        reset => '0',
        in2 => (others => '1'),
        in1 => high_ssg,
        in0 => low_ssg,
        an => an,
        sseg => sseg
    );
    
end Behavioral;
