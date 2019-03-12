----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:43 03/23/2018 
-- Design Name: 
-- Module Name:    displayy - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity displayy is

    port (
	   clk_i : in std_logic;
		digit_i : in std_logic_vector(31 downto 0); --pomocniczy wektor przechowujacy informacje o wartosci bitow dla kazdego wyswietlacza
		led7_an_o :   out STD_LOGIC_vector (3 downto 0):=(others => '1'); --4 wyswietlacze
		led7_seg_o :   out STD_LOGIC_vector (7 downto 0):=(others => '1') --8 segmentów wyswietalacza
	);

end displayy;

architecture Behavioral of displayy is
signal c : unsigned(1 downto 0) :=(others => '0'); --zliczanie taktów zegara 

begin
process(clk_i,digit_i)
begin

 if(rising_edge(clk_i)) then
  --Odpowiednie segmenty poszczegolnych wyswietlaczy sa ze soba polaczone, wiec trzeba zastosowaac multipleksowanie wyswietlaczy 
  --aktywujemy wyswietlacz(stan niski) oraz wylaczamy poprzedni(stan wysoki)      
		if(c = 0) then 
				led7_an_o(3)<='1';
				led7_an_o(0)<='0';
				led7_seg_o(7 downto 0)<=digit_i(7 downto 0);
				c <= c + 1; 
		  elsif (c=1) then      
           led7_an_o(0)<='1';
			  led7_an_o(1)<='0';
				led7_seg_o(7 downto 0)<=digit_i(15 downto 8);
				c <= c + 1; 
			elsif (c=2) then      
           led7_an_o(1)<='1';
			  led7_an_o(2)<='0';
				led7_seg_o(7 downto 0)<=digit_i(23 downto 16);
				c <= c + 1; 
			elsif (c=3) then      
           led7_an_o(2)<='1';
			  led7_an_o(3)<='0';
				led7_seg_o(7 downto 0)<=digit_i(31 downto 24);
				c <= (others => '0');
			
        end if;
	end if;
end process;
end Behavioral;

