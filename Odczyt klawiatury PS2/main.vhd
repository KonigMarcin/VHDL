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
Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0);
           ps2_clk_i : in  STD_LOGIC;
           ps2_data_i : in  STD_LOGIC);
end main;

architecture Behavioral of main is
signal clock_key: STD_LOGIC;
signal Clock : STD_LOGIC;
signal Reset : STD_LOGIC;
signal digit_i : STD_LOGIC_VECTOR(31 downto 0) :=(others => '1');  --pomocniczy wektor przechowujacy informacje o wartosci poszczegolnych bitow dla kazdego wyswietlacza
signal stan: Integer range 0 to 4:=0;
signal data: STD_LOGIC_VECTOR (7 downto 0);--pomoniczy wektor przechowujacy dane otrzymane z lini danych klawiatury
signal counter: integer range 0 to 7:=0;
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
Component dzielnik
 Port ( reset : in std_logic;
		 clock: in std_logic;
		freq_out : out std_logic );
END Component;
Component displayy
	 Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0):=(others => '1');
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
END Component;
COMPONENT clkTest --generowanie sygnalu z klawiatury
    PORT(
         clk_i : IN  std_logic;
         ps2_clk_i : IN  std_logic;
         clk_o : OUT  std_logic
        );
    END COMPONENT;
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
uut2: clkTest PORT MAP (
          clk_i => clk_i,
          ps2_clk_i => ps2_clk_i,
          clk_o => clock_key
        );



process(clock_key,rst_i)
begin
if rst_i='1' then 
digit_i<=(others => '1');

elsif rising_edge(clock_key) then
	if stan=0 then
		
		if ps2_data_i = '0' then--jezeli zbocze opadajace i stan=0 to zaczyna sie wysylanie danych
			stan <=1;
		end if;
	elsif stan=1  then 
		data(counter)<=ps2_data_i;--zapis danych
		
		if counter=7 then --7 btow danych, jezeli powyzej to zatrzymujemy zapis
			stan<=2;
			counter<=0;
		else counter<=counter+1;
		end if;
	elsif stan=2 then --wyswietalnie danych na jednym wyswietlaczu
		
		if data="01000101" then digit_i(7 downto 1)<=zero;  --0
		elsif data="00010110" then digit_i(7 downto 1)<=jeden; --1
		elsif data="00011110" then digit_i(7 downto 1)<=dwa; --2
		elsif data="00100110" then digit_i(7 downto 1)<=trzy; --3
		elsif data="00100101" then digit_i(7 downto 1)<=cztery; --4
		elsif data="00101110" then digit_i(7 downto 1)<=piec; --5
		elsif data="00110110" then digit_i(7 downto 1)<=szesc; --6
		elsif data="00111101" then digit_i(7 downto 1)<=siedem;--7
		elsif data="00111110" then digit_i(7 downto 1)<=osiem;--8
		elsif data="01000110" then digit_i(7 downto 1)<=dziewiec;--9
		elsif data="00011100" then digit_i(7 downto 1)<=AAA;--a
		elsif data="00110010" then digit_i(7 downto 1)<=BBB;--b
		elsif data="00100001" then digit_i(7 downto 1)<=CCC;--c
		elsif data="00100011" then digit_i(7 downto 1)<=DDD;--d
		elsif data="00100100" then digit_i(7 downto 1)<=EEE;--e
		elsif data="00101011" then digit_i(7 downto 1)<=FFF;	--f
		else digit_i<=(others => '1');
			
		end if;
			stan <=0;--oczekiwanie na zobcze opadajace zegara klawiatury
	end if;			
end if;




end process;
end Behavioral;

