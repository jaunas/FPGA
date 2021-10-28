library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Int2Float is
    port(
        int: in STD_LOGIC_VECTOR (7 downto 0);
        sign: out STD_LOGIC;
        exp: out STD_LOGIC_VECTOR (3 downto 0);
        frac: out STD_LOGIC_VECTOR (7 downto 0)
    );
end Int2Float;

architecture Behavioral of Int2Float is
    signal lead: std_logic_vector(2 downto 0);
    signal unsigned_int: std_logic_vector(7 downto 0);
    signal unsigned_int_with_lead: std_logic_vector(3 downto 0);
begin
    -- Sign bit is same
    sign <= int(7);
    
    -- Make unsigned: if negative drop MSB, negate all bits and add 1
    with int(7) select
        unsigned_int <=
            std_logic_vector(unsigned(not int(7 downto 0)) + 1) when '1',
            int                                                       when others;

    -- Count leading zeros
    lead <= "000" when unsigned_int(7) = '1' else
            "001" when unsigned_int(6) = '1' else
            "010" when unsigned_int(5) = '1' else
            "011" when unsigned_int(4) = '1' else
            "100" when unsigned_int(3) = '1' else
            "101" when unsigned_int(2) = '1' else
            "110" when unsigned_int(1) = '1' else
            "111";
    
    -- Make fraction
    with lead select
        frac <=
            unsigned_int(7 downto 0)             when "000",
            unsigned_int(6 downto 0) & '0'       when "001",
            unsigned_int(5 downto 0) & "00"      when "010",
            unsigned_int(4 downto 0) & "000"     when "011",
            unsigned_int(3 downto 0) & "0000"    when "100",
            unsigned_int(2 downto 0) & "00000"   when "101",
            unsigned_int(1 downto 0) & "000000"  when "110",
            unsigned_int(0)          & "0000000" when others;

    -- exp = 8 - lead
    unsigned_int_with_lead <= unsigned_int(0) & lead;
    with unsigned_int_with_lead select
        exp <=
            "1000" when "0000" | "1000",
            "0111" when "0001" | "1001",
            "0110" when "0010" | "1010",
            "0101" when "0011" | "1011",
            "0100" when "0100" | "1100",
            "0011" when "0101" | "1101",
            "0010" when "0110" | "1110",
            "0001" when          "1111",
            -- exp = 0 when (MSB = 0 and lead = 7)
            "0000" when others;

end Behavioral;
