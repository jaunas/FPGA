library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity square_wave is
    generic (
        -- 12 MHz
        TIMING: integer := 12e6;
        -- Frequency in Hz
        FREQ: integer;
        -- sizeof(TIMING/FREQ) + 7
        -- or
        -- ceil(log2(TIMING/FREQ)) + 7
        REG_SIZE: integer
    );
    port (
        clk, reset : in  std_logic;
        offset     : in  std_logic_vector(2 downto 0);
        duty       : in  std_logic_vector(2 downto 0);
        output     : out std_logic
    );
end square_wave;

architecture Behavioral of square_wave is
    signal r_reg, r_next, r_max: unsigned(REG_SIZE-1 downto 0);
    signal peak: unsigned(REG_SIZE-2 downto 0);
begin

    -- Register
    process(clk, reset)
    begin
        if reset = '1' then
            r_reg <= (others => '0');
        elsif rising_edge(clk) then
            r_reg <= r_next;
        end if;
    end process;
    
    r_max <=
        to_unsigned(TIMING/FREQ, REG_SIZE)               when offset = "111" else
        to_unsigned(TIMING/FREQ, REG_SIZE-1) & "0"       when offset = "110" else
        to_unsigned(TIMING/FREQ, REG_SIZE-2) & "00"      when offset = "101" else
        to_unsigned(TIMING/FREQ, REG_SIZE-3) & "000"     when offset = "100" else
        to_unsigned(TIMING/FREQ, REG_SIZE-4) & "0000"    when offset = "011" else
        to_unsigned(TIMING/FREQ, REG_SIZE-5) & "00000"   when offset = "010" else
        to_unsigned(TIMING/FREQ, REG_SIZE-6) & "000000"  when offset = "001" else
        to_unsigned(TIMING/FREQ, REG_SIZE-7) & "0000000";
        
    peak <=
                     r_max(REG_SIZE-1 downto 1) when duty = "000" else
        "0"        & r_max(REG_SIZE-1 downto 2) when duty = "001" else
        "00"       & r_max(REG_SIZE-1 downto 3) when duty = "010" else
        "000"      & r_max(REG_SIZE-1 downto 4) when duty = "011" else
        "0000"     & r_max(REG_SIZE-1 downto 5) when duty = "100" else
        "00000"    & r_max(REG_SIZE-1 downto 6) when duty = "101" else
        "000000"   & r_max(REG_SIZE-1 downto 7) when duty = "110" else
        "0000000"  & r_max(REG_SIZE-1 downto 8);
    
    -- Next-state logic
    r_next <=
        (others => '0') when r_reg = r_max else
        r_reg + 1;


    -- Output logic
    output <=
        '1' when r_reg < peak else
        '0';

end Behavioral;

