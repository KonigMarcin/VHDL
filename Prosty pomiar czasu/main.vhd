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
		start_stop_button_i: in std_logic;
	
		rst_i: 					in std_logic;
		led7_an_o :   out STD_LOGIC_vector (3 downto 0):=(others => '1');
		led7_seg_o :   out STD_LOGIC_vector (7 downto 0):=(others => '0')
		);
end main;

architecture Behavioral of main is
signal Clock : STD_LOGIC;
constant Reset : STD_LOGIC:='0';
signal btn: std_logic; -- przycisk
signal digit_i : STD_LOGIC_VECTOR(31 downto 0) :=(others => '0');  --pomocniczy wektor przechowujacy informacje o wartosci poszczegolnych bitow dla kazdego wyswietlacza
signal waiter: Integer range 0 to 9:=0; -- opoznienie w celu synchronizacji częstotliwosci multipleksowanie wyswietlacza oraz wyswietlania poszczegolnych czesci sekund(czasu)
signal tens: Integer range 0 to 5:=0; --dziesiątki sekund
signal ones: Integer range 0 to 9:=0; -- pojedyncze sekundy
signal tenths: Integer range 0 to 9:=0;-- czesc dziesietna sekundy
signal hundreds: Integer range 0 to 9:=0;-- czesc setna sekundy
signal stan: Integer range 0 to 4:=0;--informuje ile razy zostal zalaczony przycisk, gdzie 1 raz -start, 2 stop 3 reset
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
constant kreska :std_logic_vector(7 downto 1):="0111111"; 
Component dzielnik --dzielnik czestotliwosci
 Port ( reset : in std_logic;
		 clock: in std_logic;
		freq_out : out std_logic );
END Component;
Component displayy -- multipleksowanie wyświetlaczy z częstotliwoscią 1kHz
	 Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
END Component;
component debouncer is --zabezpieczenie przycisku przed drganiami
    Port (  clk_i : in std_logic;
				btn_i : in  STD_LOGIC;
            btn_o : out  STD_LOGIC :='0'			  
			  );
end component;
begin

uut0: dzielnik PORT MAP(
                  clock => clk_i,
                  reset => Reset,
						freq_out => Clock
);
uut1: displayy PORT MAP(
                  clk_i => Clock,
                  rst_i => Reset,
						digit_i => digit_i,
						led7_an_o => led7_an_o,
						led7_seg_o => led7_seg_o
);

uut2: debouncer port map
	(
	btn_i => start_stop_button_i,
	clk_i => Clock,
	btn_o => btn
	);


process(Clock,rst_i)
begin
if rst_i='1' then --obsluga resetu
		stan<= 0;
		hundreds <= 0;
		tenths <= 0;
		ones <= 0;
		tens <= 0;
	elsif rising_edge(Clock)  then 
	 
	if btn='1' then  --obsluga przycisku - stanów 
		case stan is 
		when 0 => stan <= 1;
		when 1 => stan <= 2;
		when others => stan<= 0;
		hundreds <= 0;
		tenths <= 0;
		ones <= 0;
		tens <= 0;
		end case;
		
	
end if;

	
	if stan=1 then --jeżeli start
		if waiter < 9 then --czekamy 10 taktów zegara
			waiter <= waiter +1;
		else waiter <= 0;	
			if hundreds < 9 then --po każdych 10 taktach zegara(waiter) zwiekszana jest wartosc poszczegolnej czesci sekundy az do osiegniaca max wartosci(9 lub dla dziesiatek 5)
				hundreds <= hundreds +1;
			else hundreds <= 0;
				if tenths < 9 then 
					tenths <= tenths +1;
				else tenths <= 0;
					if ones < 9 then 
						ones <= ones +1;
					else ones <= 0;
						if tens < 5 then 
							tens <= tens +1;
						else stan<=3;
				
							end if;	
						end if;	
					end if;
				end if;
			end if;
		end if;
	
	
end if;


if tens=0 then digit_i(31 downto 25)<=zero;
elsif  tens=1 then digit_i(31 downto 25)<=jeden;
elsif tens=2 then digit_i(31 downto 25)<=dwa;
elsif tens=3 then digit_i(31 downto 25)<=trzy;
elsif tens=4 then digit_i(31 downto 25)<=cztery;
elsif tens=5 then digit_i(31 downto 25)<=piec;
end if;


if ones=0 then digit_i(23 downto 17)<=zero; --0
elsif ones=1  then digit_i(23 downto 17)<=jeden;--1
elsif ones=2  then digit_i(23 downto 17)<=dwa;--2
elsif ones=3  then digit_i(23 downto 17)<=trzy;--3
elsif ones=4  then digit_i(23 downto 17)<=cztery;--4
elsif ones=5  then digit_i(23 downto 17)<=piec;--5
elsif ones=6  then digit_i(23 downto 17)<=szesc;--6
elsif ones=7 then digit_i(23 downto 17)<=siedem;--7
elsif ones=8 then digit_i(23 downto 17)<=osiem;--8
elsif ones=9 then digit_i(23 downto 17)<=dziewiec;--9 
end if;

if tenths=0 then digit_i(15 downto 9)<=zero;
elsif tenths=1 then digit_i(15 downto 9)<=jeden;
elsif tenths=2 then digit_i(15 downto 9)<=dwa;
elsif tenths=3  then digit_i(15 downto 9)<=trzy;
elsif tenths=4  then digit_i(15 downto 9)<=cztery;
elsif tenths=5  then digit_i(15 downto 9)<=piec;
elsif tenths=6  then digit_i(15 downto 9)<=szesc;
elsif tenths=7  then digit_i(15 downto 9)<=siedem;
elsif tenths=8 then digit_i(15 downto 9)<=osiem;
elsif tenths=9 then digit_i(15 downto 9)<=dziewiec;
end if;

if hundreds=0 then digit_i(7 downto 1)<=zero;
elsif hundreds=1 then digit_i(7 downto 1)<=jeden;
elsif hundreds=2 then digit_i(7 downto 1)<=dwa;
elsif hundreds=3 then digit_i(7 downto 1)<=trzy;
elsif hundreds=4 then digit_i(7 downto 1)<=cztery;
elsif hundreds=5 then digit_i(7 downto 1)<=piec;
elsif hundreds=6 then digit_i(7 downto 1)<=szesc;
elsif hundreds=7 then digit_i(7 downto 1)<=siedem;
elsif hundreds=8 then digit_i(7 downto 1)<=osiem;
elsif hundreds=9 then digit_i(7 downto 1)<=dziewiec;

end if;

digit_i(0)<='1';
digit_i(8)<='1';
digit_i(16)<='0';--wyswietlenie kropki pomiedzy czescia jednosci sekundy, a czesciami dziesietnymi
digit_i(24)<='1';
if stan=3 then  -- reset poprzez przycisk start/stop/reset
digit_i(7 downto 1)<=kreska; 
digit_i(15 downto 9)<=kreska; 
digit_i(23 downto 17)<=kreska; 
digit_i(31 downto 25)<=kreska; 
end if;
end process;
end Behavioral;

