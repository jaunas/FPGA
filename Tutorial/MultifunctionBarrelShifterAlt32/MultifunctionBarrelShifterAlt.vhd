library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MultifunctionBarrelShifterAlt is
    port(
        a: in  STD_LOGIC_VECTOR (31 downto 0);
        amt: in  STD_LOGIC_VECTOR (4 downto 0);
        lr: in  STD_LOGIC; -- '0' to right, '1' to left
        y: out  STD_LOGIC_VECTOR (31 downto 0)
    );
end MultifunctionBarrelShifterAlt;

architecture Behavioral of MultifunctionBarrelShifterAlt is
    signal leftShift, rightShift, preReversed, postReversed: std_logic_vector(31 downto 0);
begin
    with lr select
        y <= postReversed  when '1',
             rightShift when others;
    
    left_shift: entity work.RightBarrelShifter port map(
        a => preReversed,
        amt => amt,
        y => leftShift
    );
    
    right_shift: entity work.RightBarrelShifter port map(
        a => a,
        amt => amt,
        y => rightShift
    );
    
    pre_reverse: entity work.Reverse port map(
        a => a,
        y => preReversed
    );

    post_reverse: entity work.Reverse port map(
        a => leftShift,
        y => postReversed
    );
end Behavioral;
