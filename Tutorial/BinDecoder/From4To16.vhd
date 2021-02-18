library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity From4To16 is
    port(
        enable: in std_logic;
        from4: in std_logic_vector(3 downto 0);
        to16: out std_logic_vector(15 downto 0)
    );
end From4To16;

architecture Behavioral of From4To16 is
    signal enable0, enable1, enable2, enable3: std_logic;
    signal part0, part1, part2, part3: std_logic_vector(3 downto 0);
begin
    from2To4_0: entity work.From2To4
    port map(
        from2 => from4(1 downto 0),
        enable => enable0,
        to4 => part0
    );

    from2To4_1: entity work.From2To4
    port map(
        from2 => from4(1 downto 0),
        enable => enable1,
        to4 => part1
    );

    from2To4_2: entity work.From2To4
    port map(
        from2 => from4(1 downto 0),
        enable => enable2,
        to4 => part2
    );

    from2To4_3: entity work.From2To4
    port map(
        from2 => from4(1 downto 0),
        enable => enable3,
        to4 => part3
    );
    
    enable0 <= (not from4(3)) and (not from4(2)) and enable;
    enable1 <= (not from4(3)) and from4(2) and enable;
    enable2 <= from4(3) and (not from4(2)) and enable;
    enable3 <= from4(3) and from4(2) and enable;

    to16 <= part3 & part2 & part1 & part0;
end Behavioral;

