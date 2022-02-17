library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DualEdgeDetector is
    port(
        clk, reset : in  STD_LOGIC;
        level      : in  STD_LOGIC;
        tick       : out STD_LOGIC
    );
end DualEdgeDetector;

architecture Moore of DualEdgeDetector is
    type state_type is (zero, one, edge);
    signal state_reg, state_next: state_type;
begin

    -- state register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= zero;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;
    
    -- next-state/output logic
    process(state_reg, level)
    begin
        state_next <= state_reg;
        tick <= '0';
        case state_reg is
            when zero =>
                if level = '1' then
                    state_next <= one;
                end if;
            when one =>
                if level = '0' then
                    state_next <= edge;
                end if;
            when edge =>
                tick <= '1';
                state_next <= zero;
        end case;
    end process;

end Moore;

architecture Melay of DualEdgeDetector is
    type state_type is (zero, one);
    signal state_reg, state_next: state_type;
begin

    -- state register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= zero;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;
    
    -- next-state/output logic
    process(state_reg, level)
    begin
        state_next <= state_reg;
        tick <= '0';
        case state_reg is
            when zero =>
                if level = '1' then
                    state_next <= one;
                end if;
            when one =>
                if level = '0' then
                    tick <= '1';
                    state_next <= zero;
                end if;
        end case;
    end process;

end Melay;

