library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCDIncrementor_impl is
    port(
        increment: in STD_LOGIC;
        clk: in STD_LOGIC;
        an: out STD_LOGIC_VECTOR (2 downto 0);
        sseg: out STD_LOGIC_VECTOR (7 downto 0)
    );
end BCDIncrementor_impl;

architecture Behavioral of BCDIncrementor_impl is
    signal led2, led1, led0: std_logic_vector(7 downto 0);
    constant number: std_logic_vector(11 downto 0) := "001001011001";
    signal displayed_number, incremented_number: std_logic_vector(11 downto 0);
begin

    displayed_number <= number when increment = '1' else
                        incremented_number;

    incrementor: entity work.BCDIncrementor port map(
        number => number,
        incremented_number => incremented_number
    );

    sseg_unit_0: entity work.Hex7Seg port map(
        hex => displayed_number(3 downto 0),
        dp => '1',
        sseg => led0
    );

    sseg_unit_1: entity work.Hex7Seg port map(
        hex => displayed_number(7 downto 4),
        dp => '1',
        sseg => led1
    );

    sseg_unit_2: entity work.Hex7Seg port map(
        hex => displayed_number(11 downto 8),
        dp => '1',
        sseg => led2
    );
    
    disp_unit: entity work.DisplayMux port map(
        clk => clk,
        reset => '0',
        in0 => led0, in1 => led1, in2 => led2,
        an => an,
        sseg => sseg
    );

end Behavioral;

