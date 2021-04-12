library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FloatGT_impl is
    port(
        gt: out STD_LOGIC;
        ex1: in STD_LOGIC;
        ex2: in STD_LOGIC;
        ex3: in STD_LOGIC;
        ex4: in STD_LOGIC
    );
end FloatGT_impl;

architecture Behavioral of FloatGT_impl is
    constant sign11: std_logic := '0';
    constant exp11: std_logic_vector := "0000";
    constant frac11: std_logic_vector := "00000000";
    constant sign12: std_logic := '0';
    constant exp12: std_logic_vector := "0000";
    constant frac12: std_logic_vector := "00000000";

    constant sign21: std_logic := '1';
    constant exp21: std_logic_vector := "0001";
    constant frac21: std_logic_vector := "11110000";
    constant sign22: std_logic := '1';
    constant exp22: std_logic_vector := "1010";
    constant frac22: std_logic_vector := "10111110";

    constant sign31: std_logic := '1';
    constant exp31: std_logic_vector := "1111";
    constant frac31: std_logic_vector := "10111100";
    constant sign32: std_logic := '0';
    constant exp32: std_logic_vector := "1101";
    constant frac32: std_logic_vector := "10000011";

    constant sign41: std_logic := '0';
    constant exp41: std_logic_vector := "1101";
    constant frac41: std_logic_vector := "10111100";
    constant sign42: std_logic := '0';
    constant exp42: std_logic_vector := "1101";
    constant frac42: std_logic_vector := "10000011";
    
    signal sign1, sign2: std_logic;
    signal exp1, exp2: std_logic_vector(3 downto 0);
    signal frac1, frac2: std_logic_vector(7 downto 0);
begin

    sign1 <= sign11 when ex1 = '0' else
             sign21 when ex2 = '0' else
             sign31 when ex3 = '0' else
             sign41 when ex4 = '0' else
             sign11;

    sign2 <= sign12 when ex1 = '0' else
             sign22 when ex2 = '0' else
             sign32 when ex3 = '0' else
             sign42 when ex4 = '0' else
             sign12;
    
    exp1 <= exp11 when ex1 = '0' else
            exp21 when ex2 = '0' else
            exp31 when ex3 = '0' else
            exp41 when ex4 = '0' else
            exp11;

    exp2 <= exp12 when ex1 = '0' else
            exp22 when ex2 = '0' else
            exp32 when ex3 = '0' else
            exp42 when ex4 = '0' else
            exp12;

    frac1 <= frac11 when ex1 = '0' else
             frac21 when ex2 = '0' else
             frac31 when ex3 = '0' else
             frac41 when ex4 = '0' else
             frac11;

    frac2 <= frac12 when ex1 = '0' else
             frac22 when ex2 = '0' else
             frac32 when ex3 = '0' else
             frac42 when ex4 = '0' else
             frac12;
             
    comparator: entity work.FloatGT port map(
        sign1 => sign1,
        exp1 => exp1,
        frac1 => frac1,
        sign2 => sign2,
        exp2 => exp2,
        frac2 => frac2,
        gt => gt
    );
end Behavioral;
