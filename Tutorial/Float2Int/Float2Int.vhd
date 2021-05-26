library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Float2Int is
    port(
        sign: in STD_LOGIC;
        exp: in STD_LOGIC_VECTOR (3 downto 0);
        frac: in STD_LOGIC_VECTOR (7 downto 0);
        int: out STD_LOGIC_VECTOR (7 downto 0);
        underflow: out std_logic;
        overflow: out std_logic
    );
end Float2Int;

architecture Behavioral of Float2Int is
    signal unsigned_int: std_logic_vector(6 downto 0);
begin

    -- Sign bit is same
    int(7) <= sign;
    
    -- Convert to unsigned int
    with exp select
        unsigned_int <=
            "0000000"                   when "0000",
            "000000" & frac(7)          when "0001",
            "00000"  & frac(7 downto 6) when "0010",
            "0000"   & frac(7 downto 5) when "0011",
            "000"    & frac(7 downto 4) when "0100",
            "00"     & frac(7 downto 3) when "0101",
            "0"      & frac(7 downto 2) when "0110",
                       frac(7 downto 1) when "0111",
                       frac(6 downto 0) when others; -- shift for -128

    -- Convert unsigned int to signed int
    with sign select
        int(6 downto 0) <=
            std_logic_vector(unsigned(not unsigned_int) + 1) when '1',
            unsigned_int                                     when others;

    overflow <=
        '1' when
            -- too big                       -- too small
            (sign = '0' and exp > "0111") or (sign = '1' and exp > "0111" and frac > "10000000")
            else
        '0';
    
    underflow <=
        '1' when exp = "0000" and frac /= "00000000" else
        '0';
    
end Behavioral;
