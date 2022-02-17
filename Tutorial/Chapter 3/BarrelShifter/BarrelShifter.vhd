library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BarrelShifter is
    port(
        a: in STD_LOGIC_VECTOR(7 downto 0);
        amt: in STD_LOGIC_VECTOR(2 downto 0);
        y: out STD_LOGIC_VECTOR(7 downto 0)
    );
end BarrelShifter;

architecture Behavioral of BarrelShifter is
    signal s0, s1: std_logic_vector(7 downto 0);
begin
    -- stage 0, shift 0 or 1 bit
    s0 <= a(0) & a(7 downto 1) when amt(0) = '1' else
          a;
    -- stage 1, shift 0 or 2 bits
    s1 <= s0(1 downto 0) & s0(7 downto 2) when amt(1) = '1' else
          s0;
    -- stage 2, shift 0 or 4 bits
    y <= s1(3 downto 0) & s1(7 downto 4) when amt(2) = '1' else
         s1;
end Behavioral;

