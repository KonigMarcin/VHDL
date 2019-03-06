----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:01:30 03/15/2018 
-- Design Name: 
-- Module Name:    programik - Behavioral 
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dzielnik is
    port (
		clock, reset : in std_logic;
		freq_out : out std_logic 
	);
end dzielnik;

architecture Behavioral of dzielnik is
signal c : unsigned(40 downto 0) :=(others => '0'); --zliczanie taktów zegara
constant N : integer :=50000000; --stala okreslajaca jak chcemy podzielic czestotliwosc zegara
begin
process(clock,reset)
begin

if reset='1' then c <= (others =>'0');--obsluga resetu
freq_out<='0';
    elsif (c=N) then      --jeżeli zliczono takty zegara tak że ich liczba jest równa N, ich licznik zostaje wyzerowany
			c <= (others => '0');
	 elsif(rising_edge(clock)) then
  
		  if( c < N/2) then --do polowy wartosci na wyjsciu otrzymujemy stan niski
           freq_out<='0';
			c <= c + 1; 

			elsif (c>=N/2 and c<(N)) then --od polowy wartosci do liczby N na wyjsciu otrzymujemy stan wysoki
           freq_out<='1';
				c <= c + 1; 
			


				 
end if;
end if;
end process;
end Behavioral;

