library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DebounceTest is
    port(
        clk : in  STD_LOGIC;
        btn : in  STD_LOGIC_VECTOR (1 downto 0);
        an : out  STD_LOGIC_VECTOR (2 downto 0);
        sseg : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end DebounceTest;

architecture Behavioral of DebounceTest is
    signal q1_reg, q1_next: unsigned(7 downto 0);
    signal q0_reg, q0_next: unsigned(3 downto 0);
    signal b_count: std_logic_vector(7 downto 0); -- bounced
    signal d_count: std_logic_vector(3 downto 0); -- debounced
    signal db_level, db_tick, btn_tick, clr: std_logic;
begin

    disp_unit: entity work.HexDisplay
    port map(
        clk => clk,
        hex2 => b_count(7 downto 4),
        hex1 => b_count(3 downto 0),
        hex0 => d_count(3 downto 0),
        dp_in => "101",
        an => an,
        sseg => sseg
    );
    
    db_unit: entity work.Debounce
    port map(
        clk => clk,
        reset => '0',
        sw => btn(1),
        db => db_level
    );
    
    -- edge detection
    edge_btn: entity work.DualEdgeDetector(Melay)
    port map(
        clk => clk,
        reset => '0',
        level => btn(1),
        tick => btn_tick
    );
    edge_db: entity work.DualEdgeDetector(Melay)
    port map(
        clk => clk,
        reset => '0',
        level => db_level,
        tick => db_tick
    );
    
    -- two counters
    clr <= btn(0);
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

