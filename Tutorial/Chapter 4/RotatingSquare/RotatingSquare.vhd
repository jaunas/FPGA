library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RotatingSquare is
    port(
        clk, reset : in  std_logic;
        en, cw     : in  std_logic;
        an         : out std_logic_vector(2 downto 0);
        sseg       : out std_logic_vector(7 downto 0)
    );
end RotatingSquare;

architecture Behavioral of RotatingSquare is

    constant DELAY_RATE: integer := 1200000;

    signal delay_reg, delay_next: unsigned(20 downto 0);
    signal delay_tick: std_logic;

    signal square_reg, square_next: unsigned(2 downto 0);
    
    signal in2, in1, in0: std_logic_vector(7 downto 0);
    
    constant UP_SQUARE: std_logic_vector(7 downto 0) := "00111001";
    constant DOWN_SQUARE: std_logic_vector(7 downto 0) := "11000101";
    constant NO_SQUARE: std_logic_vector(7 downto 0) := (others => '1');
    
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            delay_reg <= (others => '0');
            square_reg <= (others => '0');
        elsif rising_edge(clk) then
            delay_reg <= delay_next;
            square_reg <= square_next;
        end if;
    end process;
    
    -- next-state logic
    delay_next <=
        (others => '0') when delay_reg = DELAY_RATE else
        delay_reg + 1;
    
    delay_tick <= '1' when delay_reg = DELAY_RATE else '0';
    
    square_next <=
        square_reg     when delay_tick = '0' or en = '0' else
        "000"          when cw = '1' and square_reg = "101" else
        "101"          when cw = '0' and square_reg = "000" else
        square_reg + 1 when cw = '1' else
        square_reg - 1;

    -- output
    in2 <=
        UP_SQUARE   when square_reg = "000" else
        DOWN_SQUARE when square_reg = "101" else
        NO_SQUARE;
    
    in1 <=
        UP_SQUARE   when square_reg = "001" else
        DOWN_SQUARE when square_reg = "100" else
        NO_SQUARE;
    
    in0 <=
        UP_SQUARE   when square_reg = "010" else
        DOWN_SQUARE when square_reg = "011" else
        NO_SQUARE;
    
    display_mux: entity work.DisplayMux
    port map(
        clk => clk,
        reset => reset,
        in2 => in2,
        in1 => in1,
        in0 => in0,
        an => an,
        sseg => sseg
    );

end Behavioral;

