library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Float2Int_impl is
    port(
        clk: in std_logic;
        frac: in std_logic_vector (6 downto 0);
        exp: in std_logic_vector (3 downto 0);
        sign: in std_logic;
        sseg: out std_logic_vector (7 downto 0);
        an: out std_logic_vector (2 downto 0);
        overflow: out std_logic;
        underflow: out std_logic
    );
end Float2Int_impl;

architecture Behavioral of Float2Int_impl is
    signal int, low_sseg, high_sseg, fraction: std_logic_vector(7 downto 0);
begin
    -- LED on on 1
    -- DPSwitch leftmost is LSB, inverted
    -- Switch 1 is LSB, inverted

    fraction <= '1' & not(frac);

    converter: entity work.Float2Int port map(
        sign => not(sign),
        exp => not(exp),
        frac => fraction,
        int => int,
        overflow => overflow,
        underflow => underflow
    );
    
    low_hex: entity work.Hex7Seg port map(
        hex => int(3 downto 0),
        dp => '1',
        sseg => low_sseg
    );
    
    high_hex: entity work.Hex7Seg port map(
        hex => int(7 downto 4),
        dp => '1',
        sseg => high_sseg
    );
    
    display: entity work.DisplayMux port map(
        clk => clk,
        reset => '0',
        in2 => (others => '1'),
        in1 => high_sseg,
        in0 => low_sseg,
        an => an,
        sseg => sseg
    );

end Behavioral;
