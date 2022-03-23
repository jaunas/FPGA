library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DebounceTest is
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        btn   : in  std_logic;
        an    : out std_logic_vector(3 downto 0);
        sseg  : out std_logic_vector(7 downto 0)
    );
end DebounceTest;

architecture Behavioral of DebounceTest is
    signal q1_reg, q1_next: unsigned(7 downto 0);
    signal q0_reg, q0_next: unsigned(7 downto 0);
    signal b_count: std_logic_vector(7 downto 0); -- bounced
    signal d_count: std_logic_vector(7 downto 0); -- debounced
    signal btn_reg: std_logic;
    signal db_tick, btn_tick, clr: std_logic;
begin

    disp_unit: entity work.HexDisplay
    port map(
        clk => clk,
        hex3 => b_count(7 downto 4),
        hex2 => b_count(3 downto 0),
        hex1 => d_count(7 downto 4),
        hex0 => d_count(3 downto 0),
        dp_in => "1111",
        an => an,
        sseg => sseg
    );

    db_unit: entity work.Debounce
    port map(
        clk => clk,
        reset => '0',
        sw => btn,
        db_level => open,
        db_tick => db_tick
    );

    -- edge detection
    process(clk)
    begin
        if rising_edge(clk) then
            btn_reg <= btn;
        end if;
    end process;
    btn_tick <= (not btn_reg) and btn;

    -- two counters
    clr <= reset;
    process(clk)
    begin
        if rising_edge(clk) then
            q1_reg <= q1_next;
            q0_reg <= q0_next;
        end if;
    end process;
    q1_next <=
        (others => '0') when clr = '1' else
        q1_reg + 1 when btn_tick = '1' else
        q1_reg;
    q0_next <=
        (others => '0') when clr = '1' else
        q0_reg + 1 when db_tick = '1' else
        q0_reg;

    b_count <= std_logic_vector(q1_reg);
    d_count <= std_logic_vector(q0_reg);

end Behavioral;
