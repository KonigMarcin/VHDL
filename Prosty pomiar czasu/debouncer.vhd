library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity debouncer is
    Port (  clk_i : in std_logic;
				btn_i : in  STD_LOGIC;
            btn_o : out  STD_LOGIC :='0'			  
			  );
end debouncer;

architecture Behavioral of debouncer is

signal count: Integer := 0;
signal ff: std_logic_vector(1 downto 0) := "00";
signal stan: integer := 0;

begin
process(clk_i)
	begin
		if rising_edge(clk_i) then 
		
			ff(1) <= ff(0);
			ff(0) <= btn_i;
			btn_o <= '0';
					
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
							btn_o <= '1';
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
					
					
					
					
		end if;
	end process;
end Behavioral;
