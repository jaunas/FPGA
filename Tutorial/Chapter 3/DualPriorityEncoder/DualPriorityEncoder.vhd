library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DualPriorityEncoder is
    port(
        req: in STD_LOGIC_VECTOR (12 downto 1);
        first: out STD_LOGIC_VECTOR (3 downto 0);
        second: out STD_LOGIC_VECTOR (3 downto 0)
    );
end DualPriorityEncoder;

architecture Behavioral of DualPriorityEncoder is
signal first_decode: std_logic_vector(15 downto 0);
signal first_code: std_logic_vector(3 downto 0);
signal masked_req: std_logic_vector(12 downto 1);
begin
    -- Get first code
    first_coder: entity work.PriorityEncoder port map(
        req => req,
        code => first_code
    );
    -- Assign it
    first <= first_code;
    
    -- Decode first code
    first_decoder: entity work.From4To16 port map(
        enable => '1',
        from4 => first_code,
        to16 => first_decode
    );
    -- Remove first code from req
    masked_req <= req xor first_decode(12 downto 1);
    
    -- Get second code
    second_coder: entity work.PriorityEncoder port map(
        req => masked_req,
        code => second
    );
end Behavioral;
