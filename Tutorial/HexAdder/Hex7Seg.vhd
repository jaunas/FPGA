library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Hex7Seg is
    port(
        hex: in STD_LOGIC_VECTOR(3 downto 0);
        dp: in STD_LOGIC;
        sseg: out STD_LOGIC_VECTOR(7 downto 0)
    );
end Hex7Seg;

architecture Behavioral of Hex7Seg is
begin
    with hex select
        sseg(7 downto 1) <=
            "0000001" when "0000",
            "1001111" when "0001",
            "0010010" when "0010",
            "0000110" when "0011",
            "1001100" when "0100",
            "0100100" when "0101",
            "0100000" when "0110",
            "0001111" when "0111",
            "0000000" when "1000",
            "0000100" when "1001",
            "0001000" when "1010", --a
            "1100000" when "1011", --b
            "0110001" when "1100", --c
            "1000010" when "1101", --d
            "0110000" when "1110", --e
            "0111000" when others; --f
            
    sseg(0) <= dp;
end Behavioral;

