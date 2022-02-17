library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LeftBarrelShifter is
    port(
        a: in STD_LOGIC_VECTOR(15 downto 0);
        amt: in STD_LOGIC_VECTOR(3 downto 0);
        y: out STD_LOGIC_VECTOR(15 downto 0)
    );
end LeftBarrelShifter;

architecture Behavioral of LeftBarrelShifter is
    signal s0, s1, s2: std_logic_vector(15 downto 0);
begin
    -- stage 0, shift 0 or 1 bit
    s0 <= a(14 downto 0) & a(15) when amt(0) = '1' else
          a;
    -- stage 1, shift 0 or 2 bits
    s1 <= s0(13 downto 0) & s0(15 downto 14) when amt(1) = '1' else
          s0;
    -- stage 2, shift 0 or 4 bits
    s2 <= s1(11 downto 0) & s1(15 downto 12) when amt(2) = '1' else
         s1;
    -- stage 3, shift 0 or 8 bits
    y <= s2(7 downto 0) & s2(15 downto 8) when amt(3) = '1' else
         s2;
end Behavioral;

