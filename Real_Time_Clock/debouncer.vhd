library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity debouncer is
    Port (  clk_i : in std_logic;
				btn_i: in std_logic_vector(2 downto 0);
            btn_o : out  STD_LOGIC_vector(2 downto 0) :="000"			  
			  );
end debouncer;

architecture Behavioral of debouncer is

signal count: Integer := 0;
signal count1: Integer := 0;
signal count2: Integer := 0;
signal ff: std_logic_vector(1 downto 0) := "00";
signal ee: std_logic_vector(1 downto 0) := "00";
signal dd: std_logic_vector(1 downto 0) := "00";
signal stan: integer := 0;
signal stan1: integer := 0;
signal stan2: integer := 0;
begin
process(clk_i)
	begin
		if rising_edge(clk_i) then 
		
			ff(1) <= ff(0);
			ff(0) <= btn_i(0);
			btn_o(0) <= '0';
					
					if stan = 0 then	--wciœniêto	
						if ff = "01" then

						stan <= 1;
						end if;
					end if;

					if stan = 1 then --czas nieczu³oœci 
						if count < 50 then
							count <= count +1;
						elsif ff = "11" then
							count <= 0 ;
							stan <= 2;
						end if;
					end if;

										
					if stan = 2 then --puszczono
						if ff = "10" then
							stan <= 3;
							btn_o(0) <= '1';
						end if;
					end if;
					
					if stan = 3 then --czas nieczu³oœci 
						if count < 50 then
							count <= count +1;
						elsif ff = "00" then
							count <= 0 ;
							stan <= 0;
						end if;
					end if;
	
	
	
	
			ee(1) <= ee(0);
			ee(0) <= btn_i(1);
			btn_o(1) <= '0';
					
					if stan1 = 0 then	--wciœniêto	
						if ee = "01" then

						stan1 <= 1;
						end if;
					end if;

					if stan1 = 1 then --czas nieczu³oœci 
						if count1 < 50 then
							count1 <= count1 +1;
						elsif ff = "11" then
							count1 <= 0 ;
							stan1 <= 2;
						end if;
					end if;

										
					if stan1 = 2 then --puszczono
						if ee = "10" then
							stan1 <= 3;
							btn_o(1) <= '1';
						end if;
					end if;
					
					if stan1 = 3 then --czas nieczu³oœci 
						if count1 < 50 then
							count1 <= count1 +1;
						elsif ee = "00" then
							count1 <= 0 ;
							stan1 <= 0;
						end if;
					end if;
					
					
			
			dd(1) <= dd(0);
			dd(0) <= btn_i(2);
			btn_o(2) <= '0';
					
					if stan2 = 0 then	--wciœniêto	
						if dd = "01" then

						stan2 <= 1;
						end if;
					end if;

					if stan2 = 1 then --czas nieczu³oœci 
						if count2 < 50 then
							count2 <= count1 +1;
						elsif dd = "11" then
							count2 <= 0 ;
							stan2 <= 2;
						end if;
					end if;

										
					if stan2 = 2 then --puszczono
						if dd = "10" then
							stan2 <= 3;
							btn_o(2) <= '1';
						end if;
					end if;
					
					if stan2 = 3 then --czas nieczu³oœci 
						if count2 < 50 then
							count2 <= count2 +1;
						elsif dd = "00" then
							count2 <= 0 ;
							stan2 <= 0;
						end if;
					end if;
					
					
					
		end if;
	end process;
end Behavioral;
