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
constant zero :std_logic_vector(7 downto 1):="0000001";
constant jeden :std_logic_vector(7 downto 1):="1001111";
constant dwa :std_logic_vector(7 downto 1):="0010010";
constant trzy :std_logic_vector(7 downto 1):="0000110";
constant cztery :std_logic_vector(7 downto 1):="1001100";
constant piec :std_logic_vector(7 downto 1):="0100100";
constant szesc :std_logic_vector(7 downto 1):="0100000";
constant siedem :std_logic_vector(7 downto 1):="0001111";
constant osiem :std_logic_vector(7 downto 1):="0000000";
constant dziewiec :std_logic_vector(7 downto 1):="0000100";
constant AAA :std_logic_vector(7 downto 1):="0001000";
constant BBB :std_logic_vector(7 downto 1):="1100000";
constant CCC :std_logic_vector(7 downto 1):="0110001";
constant DDD :std_logic_vector(7 downto 1):="1000010";
constant EEE :std_logic_vector(7 downto 1):="0110000";
constant FFF :std_logic_vector(7 downto 1):="0111000";
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
if sw_i(3 downto 0)="0000" then digit_i(7 downto 1)<=zero; --0
elsif sw_i(3 downto 0) ="0001" then digit_i(7 downto 1)<=jeden;--1
elsif sw_i(3 downto 0)="0010" then digit_i(7 downto 1)<=dwa;--2
elsif sw_i(3 downto 0)="0011" then digit_i(7 downto 1)<=trzy;--3
elsif sw_i(3 downto 0)="0100" then digit_i(7 downto 1)<=cztery;--4
elsif sw_i(3 downto 0)="0101" then digit_i(7 downto 1)<=piec;--5
elsif sw_i(3 downto 0)="0110" then digit_i(7 downto 1)<=szesc;--6
elsif sw_i(3 downto 0)="0111" then digit_i(7 downto 1)<=siedem;--7
elsif sw_i(3 downto 0)="1000" then digit_i(7 downto 1)<=osiem;--8
elsif sw_i(3 downto 0)="1000" then digit_i(7 downto 1)<=dziewiec;--9
elsif sw_i(3 downto 0)="1001" then digit_i(7 downto 1)<=AAA;--A
elsif sw_i(3 downto 0)="1010" then digit_i(7 downto 1)<=BBB;--B
elsif sw_i(3 downto 0)="1100" then digit_i(7 downto 1)<=CCC;--C
elsif sw_i(3 downto 0)="1101" then digit_i(7 downto 1)<=DDD;--D
elsif sw_i(3 downto 0)="1110" then digit_i(7 downto 1)<=EEE;--E
elsif sw_i(3 downto 0)="1111" then digit_i(7 downto 1)<=FFF;--F			
		 
end if;

elsif btn_i(1)='1' then
if sw_i(3 downto 0)="0000" then digit_i(15 downto 9)<=zero;
elsif sw_i(3 downto 0) ="0001" then digit_i(15 downto 9)<=jeden;
elsif sw_i(3 downto 0)="0010" then digit_i(15 downto 9)<=dwa;
elsif sw_i(3 downto 0)="0011" then digit_i(15 downto 9)<=trzy;
elsif sw_i(3 downto 0)="0100" then digit_i(15 downto 9)<=cztery;
elsif sw_i(3 downto 0)="0101" then digit_i(15 downto 9)<=piec;
elsif sw_i(3 downto 0)="0110" then digit_i(15 downto 9)<=szesc;
elsif sw_i(3 downto 0)="0111" then digit_i(15 downto 9)<=siedem;
elsif sw_i(3 downto 0)="1000" then digit_i(15 downto 9)<=osiem;
elsif sw_i(3 downto 0)="1000" then digit_i(15 downto 9)<=dziewiec;
elsif sw_i(3 downto 0)="1001" then digit_i(15 downto 9)<=AAA;
elsif sw_i(3 downto 0)="1010" then digit_i(15 downto 9)<=BBB;
elsif sw_i(3 downto 0)="1100" then digit_i(15 downto 9)<=CCC;
elsif sw_i(3 downto 0)="1101" then digit_i(15 downto 9)<=DDD;
elsif sw_i(3 downto 0)="1110" then digit_i(15 downto 9)<=EEE;
elsif sw_i(3 downto 0)="1111" then digit_i(15 downto 9)<=FFF;		
	
	
end if;

elsif btn_i(2)='1' then

if sw_i(3 downto 0)="0000" then digit_i(23 downto 17)<=zero;
elsif sw_i(3 downto 0) ="0001" then digit_i(23 downto 17)<=jeden;
elsif sw_i(3 downto 0)="0010" then digit_i(23 downto 17)<=dwa;
elsif sw_i(3 downto 0)="0011" then digit_i(23 downto 17)<=trzy;
elsif sw_i(3 downto 0)="0100" then digit_i(23 downto 17)<=cztery;
elsif sw_i(3 downto 0)="0101" then digit_i(23 downto 17)<=piec;
elsif sw_i(3 downto 0)="0110" then digit_i(23 downto 17)<=szesc;
elsif sw_i(3 downto 0)="0111" then digit_i(23 downto 17)<=siedem;
elsif sw_i(3 downto 0)="1000" then digit_i(23 downto 17)<=osiem;
elsif sw_i(3 downto 0)="1000" then digit_i(23 downto 17)<=dziewiec;
elsif sw_i(3 downto 0)="1001" then digit_i(23 downto 17)<=AAA;
elsif sw_i(3 downto 0)="1010" then digit_i(23 downto 17)<=BBB;
elsif sw_i(3 downto 0)="1100" then digit_i(23 downto 17)<=CCC;
elsif sw_i(3 downto 0)="1101" then digit_i(23 downto 17)<=DDD;
elsif sw_i(3 downto 0)="1110" then digit_i(23 downto 17)<=EEE;
elsif sw_i(3 downto 0)="1111" then digit_i(23 downto 17)<=FFF;		
		
		 
end if;

elsif btn_i(3)='1' then

if sw_i(3 downto 0)="0000" then digit_i(31 downto 25)<=zero;
elsif sw_i(3 downto 0) ="0001" then digit_i(31 downto 25)<=jeden;
elsif sw_i(3 downto 0)="0010" then digit_i(31 downto 25)<=dwa;
elsif sw_i(3 downto 0)="0011" then digit_i(31 downto 25)<=trzy;
elsif sw_i(3 downto 0)="0100" then digit_i(31 downto 25)<=cztery;
elsif sw_i(3 downto 0)="0101" then digit_i(31 downto 25)<=piec;
elsif sw_i(3 downto 0)="0110" then digit_i(31 downto 25)<=szesc;
elsif sw_i(3 downto 0)="0111" then digit_i(31 downto 25)<=siedem;
elsif sw_i(3 downto 0)="1000" then digit_i(31 downto 25)<=osiem;
elsif sw_i(3 downto 0)="1000" then digit_i(31 downto 25)<=dziewiec;
elsif sw_i(3 downto 0)="1001" then digit_i(31 downto 25)<=AAA;
elsif sw_i(3 downto 0)="1010" then digit_i(31 downto 25)<=BBB;
elsif sw_i(3 downto 0)="1100" then digit_i(31 downto 25)<=CCC;
elsif sw_i(3 downto 0)="1101" then digit_i(31 downto 25)<=DDD;
elsif sw_i(3 downto 0)="1110" then digit_i(31 downto 25)<=EEE;
elsif sw_i(3 downto 0)="1111" then digit_i(31 downto 25)<=FFF;	
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

