----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:06 03/07/2019 
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

entity main is
Port ( clk_i : in STD_LOGIC;
		rst_i: in STD_LOGIC;
		btn_i: in std_logic_vector(2 downto 0);
		 digit_i : out std_logic_vector(31 downto 0)

		);
end main;

architecture Behavioral of main is
signal ten_hour: Integer range 0 to 2:=0; --dziesi¹tki godzin
signal one_hour: Integer range 0 to 9:=0; -- godzina
signal ten_minute: Integer range 0 to 5:=0;-- dziesiatki minut
signal one_minute: Integer range 0 to 9:=0;-- minuta
signal waiter: Integer range 0 to 60000:=0;
constant zero :std_logic_vector(6 downto 0):="1000000";
constant jeden :std_logic_vector(6 downto 0):="1111001";
constant dwa :std_logic_vector(6 downto 0):="0100100";
constant trzy :std_logic_vector(6 downto 0):="0110000";
constant cztery :std_logic_vector(6 downto 0):="0011001";
constant piec :std_logic_vector(6 downto 0):="0010010";
constant szesc :std_logic_vector(6 downto 0):="0000010";
constant siedem :std_logic_vector(6 downto 0):="1111000";
constant osiem :std_logic_vector(6 downto 0):="0000000";
constant dziewiec :std_logic_vector(6 downto 0):="0010000";
signal slow_fast:Integer range 0 to 60000:=60000;
signal count: Integer range 0 to 1:=0;
begin
process(clk_i,rst_i)
begin


if (rst_i = '1') then --reset
	ten_hour <= 0;
	one_hour <=0;
	ten_minute <=0;
	one_minute <=0;
	waiter <=0;
elsif (rising_edge(clk_i)) then
	if(waiter = slow_fast and one_minute = 9 and ten_minute = 5 and one_hour = 4 and ten_hour = 2) then --sprawdzanie czy nie mamy godziny 23:59 wtedy od nowa zegar czyli 00:00
		waiter <=0;
		one_minute <=0;
		ten_minute <= 0;
		one_hour <= 0;
		ten_hour <= 0;
	end if;
	
	if(btn_i(2) = '1') then
		if(count = 0) then
			slow_fast <= 60;
			count <= 1;
		else
			count <= 0;
			slow_fast <= 60000;
		end if;
	end if;
	if(btn_i(0) = '1') then --ustawianie minut
		if(one_minute < 9) then
			one_minute <= one_minute + 1;
		else 
			one_minute <= 0;
			if (ten_minute <5) then --maksymalnie mozemy miec 5 na miejscu dziesiatek minut
				ten_minute <= ten_minute + 1;
			else 
				ten_minute <= 0;
			end if;
		end if;
	end if;
	
	if(btn_i(1) = '1' ) then --ustawianie godzin
		if(one_hour<9) then
			one_hour <= one_hour + 1;
		else 
			one_hour <= 0;
			if(ten_hour<2) then --maksymalnie mo¿emy miec 2 na miejscu dziesiatek godzin
				ten_hour <= ten_hour + 1;
			
			end if;
		end if;
	end if;
	
	if(waiter < slow_fast) then --przy czêstotliwoœci 1khz - 1/1000s to 60000 taktów zegara to 60sekund - 1 minuta
		waiter <= waiter + 1;
	else --póki nie ma end if to co ni¿ej "jest" w warunku else
		waiter <=0;
		if(one_minute < 9) then 
			one_minute <= one_minute + 1;
		else 
			one_minute <=0;
			if(ten_minute < 5) then
				ten_minute <= ten_minute + 1;
			else
				ten_minute <= 0;
				if(one_hour < 9) then
					one_hour <= one_hour + 1;
				else 
					one_hour <= 0;
					if(ten_hour < 2) then
						ten_hour <= ten_hour + 1;
					
					end if;
				end if;
			end if;
		end if;
	end if;
--zapisujemy do wektora danych co ma byc wyswietlone na wyswietlaczach
	case ten_hour is --dziesiatki godzin
		when 0 => digit_i(31 downto 25)<= zero;
		when 1 => digit_i(31 downto 25)<= jeden;
		when 2 => digit_i(31 downto 25)<= dwa;
	end case;

	case one_hour is --godzina
		when 0 => digit_i(23 downto 17)<= zero;
		when 1 => digit_i(23 downto 17)<= jeden;
		when 2 => digit_i(23 downto 17)<= dwa;
		when 3 => digit_i(23 downto 17)<= trzy;
		when 4 => digit_i(23 downto 17)<= cztery;
		when 5 => digit_i(23 downto 17)<= piec;
		when 6 => digit_i(23 downto 17)<= szesc;
		when 7 => digit_i(23 downto 17)<= siedem;
		when 8 => digit_i(23 downto 17)<= osiem;
		when 9 => digit_i(23 downto 17)<= dziewiec;
	end case;

	case ten_minute is --dziesi¹tki minut
		when 0 => digit_i(15 downto 9)<= zero;
		when 1 => digit_i(15 downto 9)<= jeden;
		when 2 => digit_i(15 downto 9)<= dwa;
		when 3 => digit_i(15 downto 9)<= trzy;
		when 4 => digit_i(15 downto 9)<= cztery;
		when 5 => digit_i(15 downto 9)<= piec;
	end case;

	case one_minute is --minuty
		when 0 => digit_i(7 downto 1)<= zero;
		when 1 => digit_i(7 downto 1)<= jeden;
		when 2 => digit_i(7 downto 1)<= dwa;
		when 3 => digit_i(7 downto 1)<= trzy;
		when 4 => digit_i(7 downto 1)<= cztery;
		when 5 => digit_i(7 downto 1)<= piec;
		when 6 => digit_i(7 downto 1)<= szesc;
		when 7 => digit_i(7 downto 1)<= siedem;
		when 8 => digit_i(7 downto 1)<= osiem;
		when 9 => digit_i(7 downto 1)<= dziewiec;
	end case;
digit_i(0)<='1';
digit_i(8)<='1';
digit_i(16)<='0';--wyswietlenie kropki pomiedzy czescia jednosci sekundy, a czesciami dziesietnymi
digit_i(24)<='1';	
		

end if;

end process;
end Behavioral;

