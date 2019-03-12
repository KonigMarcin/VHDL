--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:50:28 03/10/2019
-- Design Name:   
-- Module Name:   C:/Xilinx/new_iup/rtc/test.vhd
-- Project Name:  rtc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         btn_i : IN  std_logic_vector(2 downto 0);
         led7_an_o : OUT  std_logic_vector(3 downto 0);
         led7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal btn_i : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal led7_an_o : std_logic_vector(3 downto 0);
   signal led7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          btn_i => btn_i,
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;
		
      -- insert stimulus here 
	
		--minuty
		wait for 80 ns;
		btn_i(0) <= '1';
		wait for 80 ns;
		btn_i(0) <= '0';
		
		--minuty
		wait for 80 ns;
		btn_i(0) <= '1';
		wait for 80 ns;
		btn_i(0) <= '0';
		
		--minuty
		wait for 80 ns;
		btn_i(0) <= '1';
		wait for 80 ns;
		btn_i(0) <= '0';


		--godziny
		wait for 80 ns;
		btn_i(1) <= '1';
		wait for 80 ns;
		btn_i(1) <= '0';
		
		--godziny
		wait for 80 ns;
		btn_i(1) <= '1';
		wait for 80 ns;
		btn_i(1) <= '0';
		
		--godziny
		wait for 80 ns;
		btn_i(1) <= '1';
		wait for 80 ns;
		btn_i(1) <= '0';
		

		
		wait for 100 ns;
		rst_i <= '1';
		wait for 100 ns;
		rst_i <= '0';
		
		btn_i(2) <= '1';
      wait;
   end process;

END;
