library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DualPriorityEncoder_impl is
	port(
		clk : in  STD_LOGIC;
		req: in STD_LOGIC_VECTOR (8 downto 1);
		an: out STD_LOGIC_VECTOR(2 downto 0);
		sseg: out STD_LOGIC_VECTOR (7 downto 0)
	);
end DualPriorityEncoder_impl;

architecture Behavioral of DualPriorityEncoder_impl is

signal full_req: std_logic_vector(12 downto 1);
signal first_code, second_code: std_logic_vector(3 downto 0);
signal first_sseg, second_sseg: std_logic_vector(7 downto 0);

begin
	-- Get priorities
	encoder: entity work.DualPriorityEncoder port map(
		req => full_req,
		first => first_code,
		second => second_code
	);
	
	-- Trim req
	full_req <= "0000" & req;
	
	-- Convert to sseg format
	first_code_format: entity work.Hex7Seg port map(
		hex => first_code,
		dp => '1',
		sseg => first_sseg
	);
	second_code_format: entity work.Hex7Seg port map(
		hex => second_code,
		dp => '1',
		sseg => second_sseg
	);
	
	-- Display priorities
	display: entity work.DisplayMux port map(
		clk => clk,
		reset => '0',
		in2 => first_sseg,
		in1 => "11111111",
		in0 => second_sseg,
		an => an,
		sseg => sseg
	);
end Behavioral;
