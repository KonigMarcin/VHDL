library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity rx is
    Port ( 
			  clk : in STD_LOGIC;
           RXD_i : in  STD_LOGIC;	
			  stan : out std_logic := '0';
			  data: out  std_logic_vector(7 downto 0) :=(others => '0')			  
			  );

end rx;

architecture Behavioral of rx is


signal odbior : std_logic_vector (9 downto 0) :=(others => '0');
signal count : std_logic_vector (6 downto 0) :=(others => '0');

signal transmisja : std_logic := '0';

begin


process(clk)
	begin
	if rising_edge(clk) then
		if RXD_i= '0' 
			then transmisja <= '1';--bit startu
		end if;
		stan <= '0';
		if transmisja = '1' then
				if count=0 then odbior(0)<= RXD_i; --bit startu
				elsif count=8 then odbior(1)<= RXD_i; --bity danych
				elsif count=16 then odbior(2)<= RXD_i;
				elsif count=24 then odbior(3)<= RXD_i;
				elsif count=32 then odbior(4)<= RXD_i;
				elsif count=40 then odbior(5)<= RXD_i;
				elsif count=48 then odbior(6)<= RXD_i;
				elsif count=56 then odbior(7)<= RXD_i;
				elsif count=64 then odbior(8)<= RXD_i;
				elsif count=72 then odbior(9)<= RXD_i; --bit stopu
				end if;
				count <= count+1;
		
				if count = 72 then 
					count <= "0000000";
					data <= odbior(8 downto 1);
					transmisja <= '0';
					stan <= '1';
				end if;
		
		end if;
	end if;
end process;
end Behavioral;

