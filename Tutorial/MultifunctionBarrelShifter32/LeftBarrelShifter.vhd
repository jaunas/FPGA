library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LeftBarrelShifter is
    port(
        a: in STD_LOGIC_VECTOR(31 downto 0);
        amt: in STD_LOGIC_VECTOR(4 downto 0);
        y: out STD_LOGIC_VECTOR(31 downto 0)
    );
end LeftBarrelShifter;

architecture Behavioral of LeftBarrelShifter is
    signal s0, s1, s2, s3: std_logic_vector(31 downto 0);
begin
    -- stage 0, shift 0 or 1 bit
    s0 <= a(30 downto 0) & a(31) when amt(0) = '1' else
          a;
    -- stage 1, shift 0 or 2 bits
    s1 <= s0(29 downto 0) & s0(31 downto 30) when amt(1) = '1' else
          s0;
    -- stage 2, shift 0 or 4 bits
    s2 <= s1(27 downto 0) & s1(31 downto 28) when amt(2) = '1' else
         s1;
    -- stage 3, shift 0 or 8 bits
    s3 <= s2(23 downto 0) & s2(31 downto 24) when amt(3) = '1' else
         s2;
    -- stage 4, shift 0 or 16 bits
    y <= s3(15 downto 0) & s3(31 downto 16) when amt(4) = '1' else
         s3;
end Behavioral;

