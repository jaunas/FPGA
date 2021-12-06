library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Stack is
    generic(
        B: natural := 8; -- number of bits
        W: natural := 4  -- number of address bits
    );
    port(
        clk, reset  : in  std_logic;
        push, pop   : in  std_logic;
        empty, full : out std_logic;
        w_data      : in  std_logic_vector(B-1 downto 0);
        r_data      : out std_logic_vector(B-1 downto 0)
    );
end Stack;

architecture Behavioral of Stack is
    type reg_file_type is
        array(2**W-1 downto 0) of
        std_logic_vector(B-1 downto 0);
    signal array_reg: reg_file_type;
    signal ptr_reg, ptr_next, ptr_prev, ptr_succ: std_logic_vector(W-1 downto 0);
    signal empty_reg, empty_next, push_en, full_reg, full_next: std_logic;
begin

    -- register
    process(clk, reset)
    begin
        if reset = '1' then
            array_reg <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if push_en = '1' then
                array_reg(to_integer(unsigned(ptr_reg))) <= w_data;
            end if;
        end if;
    end process;

    r_data <= array_reg(to_integer(unsigned(ptr_prev)));
--    full_reg <= '1' when (unsigned(ptr_reg) = 2**W-1) else '0';
    push_en <= push and not full_reg;
    
    -- Stack control logic
    process(clk, reset)
    begin
        if reset = '1' then
            ptr_reg <= (others => '0');
            empty_reg <= '1';
            full_reg <= '0';
        elsif rising_edge(clk) then
            ptr_reg <= ptr_next;
            empty_reg <= empty_next;
            full_reg <= full_next;
        end if;
    end process;
    
    -- Previous and succesive pointer value
    ptr_prev <= std_logic_vector(unsigned(ptr_reg)-1);
    ptr_succ <= std_logic_vector(unsigned(ptr_reg)+1);
    
    -- Next-state logic for pointer
    process(ptr_reg, ptr_succ, empty_reg, full_reg, push, pop)
    begin
        ptr_next <= ptr_reg;
        empty_next <= empty_reg;
        full_next <= full_reg;

        if (push = '1' and pop = '0') then -- push
            if full_reg /= '1' then -- not full
                ptr_next <= ptr_succ;
                empty_next <= '0';
                if unsigned(ptr_succ) = 0 then
                    full_next <= '1';
                end if;
            end if;
        elsif (pop = '1' and push = '0') then -- pop
            if empty_reg /= '1' then -- not empty
                ptr_next <= ptr_prev;
                full_next <= '0';
                if unsigned(ptr_prev) = 0 then
                    empty_next <= '1';
                end if;
            end if;
        end if; -- don't change pointer in other cases

        empty <= empty_reg;
    end process;

    full <= full_reg;

end Behavioral;

