--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:30:39 04/05/2018
-- Design Name:   
-- Module Name:   C:/Users/Keniol/Desktop/zadanie6m/testb.vhd
-- Project Name:  zadanie6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY testb IS
END testb;
 
ARCHITECTURE behavior OF testb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk_i : IN  std_logic;
         btn_i : IN  std_logic_vector(3 downto 0);
         sw_i : IN  std_logic_vector(7 downto 0);
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal btn_i : std_logic_vector(3 downto 0) := (others => '0');
   signal sw_i : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 50ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk_i => clk_i,
          btn_i => btn_i,
          sw_i => sw_i,
          led7_an_o => led7_an_o,
          led7_seg_o => led7_seg_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 10ns;-- hold reset state for 100ms.
   sw_i(3 downto 0)<="0101";
	 wait for 10ns;
	 btn_i(0)<='1';	 -- insert stimulus here 
wait for 50ns;
btn_i(0)<='0';    
	  sw_i(3 downto 0)<="1101";
	 wait for 10ns;
	 btn_i(2)<='1';	 -- insert stimulus here 
wait for 50ns;
btn_i(2)<='0'; 
	 wait;
   end process;

END;
