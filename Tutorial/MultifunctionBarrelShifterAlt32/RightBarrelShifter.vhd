library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RightBarrelShifter is
    port(
        a: in STD_LOGIC_VECTOR(31 downto 0);
        amt: in STD_LOGIC_VECTOR(4 downto 0);
        y: out STD_LOGIC_VECTOR(31 downto 0)
    );
end RightBarrelShifter;

architecture Behavioral of RightBarrelShifter is
    signal s0, s1, s2, s3: std_logic_vector(31 downto 0);
begin
    -- stage 0, shift 0 or 1 bit
    s0 <= a(0) & a(31 downto 1) when amt(0) = '1' else
          a;
    -- stage 1, shift 0 or 2 bits
    s1 <= s0(1 downto 0) & s0(31 downto 2) when amt(1) = '1' else
          s0;
    -- stage 2, shift 0 or 4 bits
    s2 <= s1(3 downto 0) & s1(31 downto 4) when amt(2) = '1' else
         s1;
    -- stage 3, shift 0 or 8 bits
    s3 <= s2(7 downto 0) & s2(31 downto 8) when amt(3) = '1' else
         s2;
    -- stage 4, shift 0 or 16 bits
    y <= s3(15 downto 0) & s3(31 downto 16) when amt(4) = '1' else
         s3;
end Behavioral;

