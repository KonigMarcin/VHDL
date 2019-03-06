----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:42 03/23/2018 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
Port ( clk_i : in STD_LOGIC;
		btn_i :   in STD_LOGIC_vector (3 downto 0);--4 przyciski
		sw_i :   in STD_LOGIC_vector (7 downto 0);--8 przelaczikow
		led7_an_o :   out STD_LOGIC_vector (3 downto 0):=(others => '1');--4 wyswietlacze
		led7_seg_o :   out STD_LOGIC_vector (7 downto 0):=(others => '1')-- 8 segmentów wyswietalacza
		);
end main;

architecture Behavioral of main is
signal Clock : STD_LOGIC;
constant Reset : STD_LOGIC:='0';
signal digit_i : STD_LOGIC_VECTOR(31 downto 0) :=(others => '1');  --pomocniczy wektor przechowujacy informacje o wartosci poszczegolnych bitow dla kazdego wyswietlacza
Component dzielnik --dzielnik czestotliwosi
 Port ( reset : in std_logic;
		 clock: in std_logic;
		freq_out : out std_logic );--sygnal zegarowy po podzielniu
END Component;
Component displayy --multipleksowanie wyswietlaczy
	 Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);--pomocniczy wektor przechowujacy informacje o wartosci bitow dla kazdego wyswietlacza
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
END Component;
begin

uut0: dzielnik PORT MAP( --dzielnik czestotliwosi
                  clock => clk_i,
                  reset => Reset,
						freq_out => Clock
);
uut1: displayy PORT MAP(--multipleksowanie wyswietlaczy
                  clk_i => Clock,
                  rst_i => Reset,
						digit_i => digit_i,
						led7_an_o => led7_an_o,
						led7_seg_o => led7_seg_o
);



process(clk_i,btn_i,sw_i)
begin

if btn_i(0)='1' then --jeżeli przycisk zostanie wciśnięty, 
--w zależności od tego jaka liczba ustawiona jest na przelacznikach, taka zostaje przekazane do okreslonych bitow wektora
--okreslajacego poszczegolne wyswietlacze 
if sw_i(3 downto 0)="0000" then digit_i(7 downto 1)<="1000000"; --0
elsif sw_i(3 downto 0) ="0001" then digit_i(7 downto 1)<="1111001";--1
elsif sw_i(3 downto 0)="0010" then digit_i(7 downto 1)<="1000100";--2
elsif sw_i(3 downto 0)="0011" then digit_i(7 downto 1)<="0110000";--3
elsif sw_i(3 downto 0)="0100" then digit_i(7 downto 1)<="0011001";--4
elsif sw_i(3 downto 0)="0101" then digit_i(7 downto 1)<="0010010";--5
elsif sw_i(3 downto 0)="0110" then digit_i(7 downto 1)<="0000010";--6
elsif sw_i(3 downto 0)="0111" then digit_i(7 downto 1)<="1111000";--7
elsif sw_i(3 downto 0)="1000" then digit_i(7 downto 1)<="0000000";--8
elsif sw_i(3 downto 0)="1000" then digit_i(7 downto 1)<="0010000";--9
elsif sw_i(3 downto 0)="1001" then digit_i(7 downto 1)<="0001000";--A
elsif sw_i(3 downto 0)="1010" then digit_i(7 downto 1)<="0000011";--B
elsif sw_i(3 downto 0)="1100" then digit_i(7 downto 1)<="0100111";--C
elsif sw_i(3 downto 0)="1101" then digit_i(7 downto 1)<="0100001";--D
elsif sw_i(3 downto 0)="1110" then digit_i(7 downto 1)<="0000110";--E
elsif sw_i(3 downto 0)="1111" then digit_i(7 downto 1)<="0001110";--F			
		 
end if;

elsif btn_i(1)='1' then
if sw_i(3 downto 0)="0000" then digit_i(15 downto 9)<="1000000";
elsif sw_i(3 downto 0) ="0001" then digit_i(15 downto 9)<="1111001";
elsif sw_i(3 downto 0)="0010" then digit_i(15 downto 9)<="1000100";
elsif sw_i(3 downto 0)="0011" then digit_i(15 downto 9)<="0110000";
elsif sw_i(3 downto 0)="0100" then digit_i(15 downto 9)<="0011001";
elsif sw_i(3 downto 0)="0101" then digit_i(15 downto 9)<="0010010";
elsif sw_i(3 downto 0)="0110" then digit_i(15 downto 9)<="0000010";
elsif sw_i(3 downto 0)="0111" then digit_i(15 downto 9)<="1111000";
elsif sw_i(3 downto 0)="1000" then digit_i(15 downto 9)<="0000000";
elsif sw_i(3 downto 0)="1000" then digit_i(15 downto 9)<="0010000";
elsif sw_i(3 downto 0)="1001" then digit_i(15 downto 9)<="0001000";
elsif sw_i(3 downto 0)="1010" then digit_i(15 downto 9)<="0000011";
elsif sw_i(3 downto 0)="1100" then digit_i(15 downto 9)<="0100111";
elsif sw_i(3 downto 0)="1101" then digit_i(15 downto 9)<="0100001";
elsif sw_i(3 downto 0)="1110" then digit_i(15 downto 9)<="0000110";
elsif sw_i(3 downto 0)="1111" then digit_i(15 downto 9)<="0001110";		
	
	
end if;

elsif btn_i(2)='1' then

if sw_i(3 downto 0)="0000" then digit_i(23 downto 17)<="1000000";
elsif sw_i(3 downto 0) ="0001" then digit_i(23 downto 17)<="1111001";
elsif sw_i(3 downto 0)="0010" then digit_i(23 downto 17)<="1000100";
elsif sw_i(3 downto 0)="0011" then digit_i(23 downto 17)<="0110000";
elsif sw_i(3 downto 0)="0100" then digit_i(23 downto 17)<="0011001";
elsif sw_i(3 downto 0)="0101" then digit_i(23 downto 17)<="0010010";
elsif sw_i(3 downto 0)="0110" then digit_i(23 downto 17)<="0000010";
elsif sw_i(3 downto 0)="0111" then digit_i(23 downto 17)<="1111000";
elsif sw_i(3 downto 0)="1000" then digit_i(23 downto 17)<="0000000";
elsif sw_i(3 downto 0)="1000" then digit_i(23 downto 17)<="0010000";
elsif sw_i(3 downto 0)="1001" then digit_i(23 downto 17)<="0001000";
elsif sw_i(3 downto 0)="1010" then digit_i(23 downto 17)<="0000011";
elsif sw_i(3 downto 0)="1100" then digit_i(23 downto 17)<="0100111";
elsif sw_i(3 downto 0)="1101" then digit_i(23 downto 17)<="0100001";
elsif sw_i(3 downto 0)="1110" then digit_i(23 downto 17)<="0000110";
elsif sw_i(3 downto 0)="1111" then digit_i(23 downto 17)<="0001110";		
		
		 
end if;

elsif btn_i(3)='1' then

if sw_i(3 downto 0)="0000" then digit_i(31 downto 25)<="1000000";
elsif sw_i(3 downto 0) ="0001" then digit_i(31 downto 25)<="1111001";
elsif sw_i(3 downto 0)="0010" then digit_i(31 downto 25)<="1000100";
elsif sw_i(3 downto 0)="0011" then digit_i(31 downto 25)<="0110000";
elsif sw_i(3 downto 0)="0100" then digit_i(31 downto 25)<="0011001";
elsif sw_i(3 downto 0)="0101" then digit_i(31 downto 25)<="0010010";
elsif sw_i(3 downto 0)="0110" then digit_i(31 downto 25)<="0000010";
elsif sw_i(3 downto 0)="0111" then digit_i(31 downto 25)<="1111000";
elsif sw_i(3 downto 0)="1000" then digit_i(31 downto 25)<="0000000";
elsif sw_i(3 downto 0)="1000" then digit_i(31 downto 25)<="0010000";
elsif sw_i(3 downto 0)="1001" then digit_i(31 downto 25)<="0001000";
elsif sw_i(3 downto 0)="1010" then digit_i(31 downto 25)<="0000011";
elsif sw_i(3 downto 0)="1100" then digit_i(31 downto 25)<="0100111";
elsif sw_i(3 downto 0)="1101" then digit_i(31 downto 25)<="0100001";
elsif sw_i(3 downto 0)="1110" then digit_i(31 downto 25)<="0000110";
elsif sw_i(3 downto 0)="1111" then digit_i(31 downto 25)<="0001110";	
end if;
end if;
if sw_i(4)='1' then digit_i(0)<='0'; --jeżeli przelacznik zalaczony to kropka zostaje wlaczona, nizej dla poszczegolnych wyswietlaczy
elsif sw_i(4)='0' then digit_i(0)<='1';
end if;
if sw_i(5)='1' then digit_i(8)<='0';
elsif sw_i(5)='0' then digit_i(8)<='1';
end if;
if sw_i(6)='1' then digit_i(16)<='0';

elsif sw_i(6)='0' then digit_i(16)<='1';
end if;
if sw_i(7)='1' then digit_i(24)<='0';
elsif sw_i(7)='0' then digit_i(24)<='1';
end if;



end process;
end Behavioral;

