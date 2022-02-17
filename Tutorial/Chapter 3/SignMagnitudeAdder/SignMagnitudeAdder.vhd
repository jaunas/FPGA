library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity SignMagnitudeAdder is
    generic(N: integer := 4); -- by default adder is 4-bits
    port(
        a, b: in STD_LOGIC_VECTOR (N-1 downto 0);
        sum: out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end SignMagnitudeAdder;

architecture Behavioral of SignMagnitudeAdder is
    signal mag_a, mag_b: unsigned(N-2 downto 0);
    signal mag_sum, max, min: unsigned(N-2 downto 0);
    signal sign_a, sign_b, sign_sum: std_logic;
begin
    mag_a <= unsigned(a(N-2 downto 0));
    mag_b <= unsigned(b(N-2 downto 0));
    sign_a <= a(N-1);
    sign_b <= b(N-1);

    -- sort according to magnitude
    process(mag_a, mag_b, sign_a, sign_b)
    begin
        if mag_a > mag_b then
            max <= mag_a;
            min <= mag_b;
            sign_sum <= sign_a;
        else
            max <= mag_b;
            min <= mag_a;
            sign_sum <= sign_b;
        end if;
    end process;

    -- add/sub magnitude
    mag_sum <= max + min when sign_a = sign_b else
               max - min;
    
    -- form output
    sum <= std_logic_vector(sign_sum & mag_sum);
end Behavioral;
