library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gate is
    port(
        clk, reset    : in  std_logic;
        a, b          : in  std_logic;
        enter, \exit\ : out std_logic
    );
end gate;

architecture Behavioral of gate is
    type state_type is (
        idle, invalid,
        enter_in, enter_full, enter_out,
        exit_in, exit_full, exit_out
    );
    signal state_reg, state_next: state_type;
begin

    -- state register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;
    
    -- next-state/output logic
    process(state_reg, a, b)
    begin
        state_next <= state_reg; -- default: don't change state
        enter <= '0';
        \exit\ <= '0';
        
        case state_reg is
            when invalid =>
                state_next <= idle;

            when idle =>
                if a = '1' and b = '0' then
                    state_next <= enter_in;
                elsif a = '0' and b = '1' then
                    state_next <= exit_in;
                elsif a = '1' and b = '1' then
                    state_next <= invalid;
                end if;
            
            when enter_in =>
                if a = '1' and b = '1' then
                    state_next <= enter_full;
                elsif a = '0' and b = '0' then
                    state_next <= idle;
                elsif a = '0' and b = '1' then
                    state_next <= invalid;
                end if;
            when enter_full =>
                if a = '0' and b = '1' then
                    state_next <= enter_out;
                elsif a = '1' and b = '1' then
                    state_next <= enter_full;
                elsif a = '1' and b = '0' then
                    state_next <= invalid;
                end if;
            when enter_out =>
                if a = '0' and b = '0' then
                    enter <= '1'; -- <<<<<<<<
                    state_next <= idle;
                elsif a = '1' and b = '1' then
                    state_next <= enter_full;
                elsif a = '1' and b = '0' then
                    state_next <= invalid;
                end if;
            
            when exit_in =>
                if a = '1' and b = '1' then
                    state_next <= exit_full;
                elsif a = '0' and b = '0' then
                    state_next <= idle;
                elsif a = '1' and b = '0' then
                    state_next <= invalid;
                end if;
            when exit_full =>
                if a = '1' and b = '0' then
                    state_next <= exit_out;
                elsif a = '0' and b = '1' then
                    state_next <= exit_in;
                elsif a = '0' and b = '0' then
                    state_next <= invalid;
                end if;
            when exit_out =>
                if a = '0' and b = '0' then
                    \exit\ <= '1'; -- <<<<<<<<
                    state_next <= idle;
                elsif a = '1' and b = '1' then
                    state_next <= exit_full;
                elsif a = '0' and b = '1' then
                    state_next <= invalid;
                end if;
        end case;
    end process;

end Behavioral;

