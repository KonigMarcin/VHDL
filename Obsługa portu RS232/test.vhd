LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         TXD_o : OUT  std_logic;
         RXD_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal RXD_i : std_logic := '0';

 	--Outputs
   signal TXD_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
   constant rs_period : time := 104166 ns; --1/9600
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          TXD_o => TXD_o,
          RXD_i => RXD_i
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
RXD_i <= '1';		
		wait for 1 ms;
		
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;

		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		
				wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
		wait for rs_period;
				
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
		RXD_i <= '0';wait for rs_period;
		RXD_i <= '1';wait for rs_period;
				


      -- insert stimulus here 

      wait;
   end process;

END;

