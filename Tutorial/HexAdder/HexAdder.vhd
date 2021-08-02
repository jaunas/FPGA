library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity HexAdder is
    port(
        clk:  in  std_logic;
        sw:   in  std_logic_vector(7 downto 0);
        btn:  in  std_logic_vector(1 downto 0);
        an:   out std_logic_vector(2 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );
end HexAdder;

architecture Behavioral of HexAdder is
    signal a, b: unsigned(7 downto 0);
    signal sum: std_logic_vector(7 downto 0);
    signal disp_num: std_logic_vector(7 downto 0);
begin

    display: entity work.HexDisplay port map(
        clk => clk,
        hex2 => (others => '0'),
        hex1 => disp_num(7 downto 4),
        hex0 => disp_num(3 downto 0),
        dp_in => (others => '1'),
        an => an,
        sseg => sseg
    );
    
    a <= "0000" & unsigned(sw(3 downto 0));
    b <= "0000" & unsigned(sw(7 downto 4));
    sum <= std_logic_vector(a + b);
    
    with btn select
        disp_num <=
            std_logic_vector(a) when "01",
            std_logic_vector(b) when "10",
            sum                 when others;

end Behavioral;
