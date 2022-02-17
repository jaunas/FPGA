library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gt4 is
    port(
        a, b: in std_logic_vector(3 downto 0);
        gt: out std_logic
    );
end gt4;

architecture Behavioral of gt4 is
    signal p0, p1, p2, p3: std_logic;
begin
    gt_bits01: entity work.gt2
        port map(a => a(1 downto 0), b => b(1 downto 0), gt => p0);
    
    eq_bits23: entity work.eq2
        port map(a => a(3 downto 2), b => b(3 downto 2), eq => p1);

    gt_bits23: entity work.gt2
        port map(a => a(3 downto 2), b => b(3 downto 2), gt => p3);

    p2 <= p0 and p1;
    gt <= p2 or p3;
end Behavioral;

