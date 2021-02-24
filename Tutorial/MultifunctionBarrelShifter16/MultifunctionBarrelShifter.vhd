library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MultifunctionBarrelShifter is
    port(
        a: in std_logic_vector(15 downto 0);
        amt: in std_logic_vector(3 downto 0);
        lr: in std_logic; -- '0' to right, '1' to left
        y: out std_logic_vector(15 downto 0)
    );
end MultifunctionBarrelShifter;

architecture Behavioral of MultifunctionBarrelShifter is
    signal leftShift, rightShift: std_logic_vector(15 downto 0);
begin
    with lr select
        y <= leftShift  when '1',
             rightShift when others;
    
    left_shift: entity work.LeftBarrelShifter port map(
        a => a,
        amt => amt,
        y => leftShift
    );

    right_shift: entity work.RightBarrelShifter port map(
        a => a,
        amt => amt,
        y => rightShift
    );
end Behavioral;

