--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:51:34 02/19/2021
-- Design Name:   
-- Module Name:   /mnt/46C58EC06C46C4B6/Kod/FPGA/Tutorial/Hex7Seg/Hex7Seg_tb.vhd
-- Project Name:  Hex7Seg
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Hex7Seg
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
 
ENTITY Hex7Seg_tb IS
END Hex7Seg_tb;
 
ARCHITECTURE behavior OF Hex7Seg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Hex7Seg
    PORT(
         hex : IN  std_logic_vector(3 downto 0);
         dp : IN  std_logic;
         sseg : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal hex : std_logic_vector(3 downto 0) := (others => '0');
   signal dp : std_logic := '0';

 	--Outputs
   signal sseg : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Hex7Seg PORT MAP (
          hex => hex,
          dp => dp,
          sseg => sseg
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
