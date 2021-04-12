library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FloatGT is
    port(
        sign1, sign2: in STD_LOGIC;
        exp1, exp2: in STD_LOGIC_VECTOR (3 downto 0);
        frac1, frac2: in STD_LOGIC_VECTOR (7 downto 0);
        gt: out STD_LOGIC
    );
end FloatGT;

architecture Behavioral of FloatGT is
    signal gt_exp, gt_frac: std_logic;
begin

    gt_exp <= '1' when exp1 > exp2 else '0';
    gt_frac <= '1' when frac1 > frac2 else '0';

    gt <= sign2 when sign1 /= sign2 else
          gt_exp xor sign1 when exp1 /= exp2 else
          gt_frac xor sign1;

end Behavioral;

