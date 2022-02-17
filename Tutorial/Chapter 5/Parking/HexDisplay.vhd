library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HexDisplay is
    port(
        clk   : in  std_logic;
        hex3  : in  std_logic_vector(3 downto 0);
        hex2  : in  std_logic_vector(3 downto 0);
        hex1  : in  std_logic_vector(3 downto 0);
        hex0  : in  std_logic_vector(3 downto 0);
        dp_in : in  std_logic_vector(3 downto 0);
        an    : out std_logic_vector(3 downto 0);
        sseg  : out std_logic_vector(7 downto 0)
    );
end HexDisplay;

architecture Behavioral of HexDisplay is
    signal in3, in2, in1, in0: std_logic_vector(7 downto 0);
begin

    -- Convert hex to sseg
    
    in3_hex: entity work.Hex7Seg port map(
        hex => hex3,
        dp => dp_in(3),
        sseg => in3
    );

    in2_hex: entity work.Hex7Seg port map(
        hex => hex2,
        dp => dp_in(2),
        sseg => in2
    );

    in1_hex: entity work.Hex7Seg port map(
        hex => hex1,
        dp => dp_in(1),
        sseg => in1
    );

    in0_hex: entity work.Hex7Seg port map(
        hex => hex0,
        dp => dp_in(0),
        sseg => in0
    );
    
    -- Pass to the display
    
    display: entity work.DisplayMux port map(
        clk => clk,
        reset => '0',
        in3 => in3,
        in2 => in2,
        in1 => in1,
        in0 => in0,
        an => an,
        sseg => sseg
    );

end Behavioral;
