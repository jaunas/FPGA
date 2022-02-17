library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Banner is
    generic(
        W: natural := 4; -- number of address bits for storing digits
        N: natural := 10 -- number of digits (has to be not greater than 2**W)
    );
    port(
        clk, reset : in  std_logic;
        en, dir    : in  std_logic;
        an         : out std_logic_vector(2 downto 0);
        sseg       : out std_logic_vector(7 downto 0)
    );
end Banner;

architecture Behavioral of Banner is
    type digits_array is
        array (0 to N-1)
        of std_logic_vector(3 downto 0);
    constant digits: digits_array := (
        "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001"
    );
    
    constant DELAY_RATE: integer := 6000000-1;
    signal delay_reg, delay_next: unsigned(22 downto 0);
    signal delay_tick: std_logic;

    signal in2_ptr_reg, in1_ptr_reg, in0_ptr_reg: unsigned(W-1 downto 0);
    signal in2_ptr_next: unsigned(W-1 downto 0);
    
    signal hex2, hex1, hex0: std_logic_vector(3 downto 0);
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            delay_reg <= (others => '0');
            in2_ptr_reg <= (others => '0');
        elsif rising_edge(clk) then
            delay_reg <= delay_next;
            in2_ptr_reg <= in2_ptr_next;
        end if;
    end process;
    
    -- next-state logic
    delay_next <=
        (others => '0') when delay_reg = DELAY_RATE else
        delay_reg + 1;
    
    delay_tick <= '1' when delay_reg = DELAY_RATE else '0';
    
    in2_ptr_next <=
        in2_ptr_reg         when delay_tick = '0' or en = '0' else
        (others => '0')     when in2_ptr_reg = N-1 and dir = '1' else
        to_unsigned(N-1, W) when in2_ptr_reg = 0 and dir = '0' else
        in2_ptr_reg + 1     when dir = '1' else
        in2_ptr_reg - 1;
    
    -- output
    in1_ptr_reg <=
        (others => '0') when in2_ptr_reg = N-1 else
        in2_ptr_reg + 1;
    
    in0_ptr_reg <=
        (others => '0') when in1_ptr_reg = N-1 else
        in1_ptr_reg + 1;
    
    hex2 <= digits(to_integer(in2_ptr_reg));
    hex1 <= digits(to_integer(in1_ptr_reg));
    hex0 <= digits(to_integer(in0_ptr_reg));
    
    hex_display: entity work.HexDisplay
    port map(
        clk => clk,
        reset => reset,
        hex2 => hex2,
        hex1 => hex1,
        hex0 => hex0,
        dp_in => "111",
        an => an,
        sseg => sseg
    );

end Behavioral;

