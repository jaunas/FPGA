--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:18:41 05/26/2021
-- Design Name:   
-- Module Name:   /home/tomaszk/Kod/FPGA/Tutorial/Float2Int/Float2Int_tb.vhd
-- Project Name:  Float2Int
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Float2Int
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Float2Int_tb IS
END Float2Int_tb;
 
ARCHITECTURE behavior OF Float2Int_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Float2Int
    PORT(
         sign : IN  std_logic;
         exp : IN  std_logic_vector(3 downto 0);
         frac : IN  std_logic_vector(7 downto 0);
         int : OUT  std_logic_vector(7 downto 0);
         underflow : OUT  std_logic;
         overflow : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sign : std_logic := '0';
   signal exp : std_logic_vector(3 downto 0) := (others => '0');
   signal frac : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal int : std_logic_vector(7 downto 0);
   signal underflow : std_logic;
   signal overflow : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Float2Int PORT MAP (
          sign => sign,
          exp => exp,
          frac => frac,
          int => int,
          underflow => underflow,
          overflow => overflow
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for period;

        -- 21
        sign <= '0';
        frac <= "10101010";
        exp <= "0101";
        wait for period;
        
        assert int = "00010101" and overflow = '0' and underflow = '0'
        report "Conversion failed for 21" severity failure;
        
        -- -21
        sign <= '1';
        frac <= "10101010";
        exp <= "0101";
        wait for period;
        
        assert int = "11101011" and overflow = '0' and underflow = '0'
        report "Conversion failed for -21" severity failure;
        
        -- -1
        sign <= '1';
        frac <= "10000000";
        exp <= "0001";
        wait for period;
        
        assert int = "11111111" and overflow = '0' and underflow = '0'
        report "Conversion failed for -1" severity failure;
        
        -- -127
        sign <= '1';
        frac <= "11111110";
        exp <= "0111";
        wait for period;
        
        assert int = "10000001" and overflow = '0' and underflow = '0'
        report "Conversion failed for -127" severity failure;
        
        -- -128
        sign <= '1';
        frac <= "10000000";
        exp <= "1000";
        wait for period;
        
        assert int = "10000000" and overflow = '0' and underflow = '0'
        report "Conversion failed for -128" severity failure;
        
        wait for period;
        
        -- 127
        sign <= '0';
        frac <= "11111110";
        exp <= "0111";
        wait for period;
        
        assert int = "01111111" and overflow = '0' and underflow = '0'
        report "Conversion failed for 127" severity failure;
        
        -- 0
        sign <= '0';
        frac <= "00000000";
        exp <= "0000";
        wait for period;
        
        assert int = "00000000" and overflow = '0' and underflow = '0'
        report "Conversion failed for 0" severity failure;
        
        -- 200
        sign <= '0';
        frac <= "11001000";
        exp <= "1000";
        wait for period;
        
        assert overflow = '1'
        report "Conversion failed for 200" severity failure;
        
        -- 1/2
        sign <= '0';
        frac <= "10000000";
        exp <= "0000";
        wait for period;
        
        assert underflow = '1'
        report "Conversion failed for 1/2" severity failure;
        
        wait;
    end process;

END;
