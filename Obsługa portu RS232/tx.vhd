library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity tx is
    Port ( clk : in  STD_LOGIC;
			  stan : in  STD_LOGIC;
			  data : in STD_LOGIC_VECTOR(7 downto 0);
           TXD_o : out  STD_LOGIC :='0'			  
			  );
end tx;
architecture Behavioral of tx is
signal count: std_logic_vector (6 downto 0) :="0000000";
signal transmisja : std_logic := '0';
signal data_add : STD_LOGIC_VECTOR(7 downto 0);
begin
data_add <= data+32;
	process(clk)
	begin
			if rising_edge(clk) then 
				if stan ='1' then transmisja <='1';
				end if;
				if transmisja = '1'  then
					if count=0 then TXD_o<='0'; --bit startu
					elsif count=8 then TXD_o<=data_add(0);
					elsif count=16 then TXD_o<=data_add(1);
					elsif count=24 then TXD_o<=data_add(2);
					elsif count=32 then TXD_o<=data_add(3);
					elsif count=40 then TXD_o<=data_add(4);
					elsif count=48 then TXD_o<=data_add(5);
					elsif count=56 then TXD_o<=data_add(6);
					elsif count=64 then TXD_o<=data_add(7);
					elsif count=72 then TXD_o<='1'; --bit stopu
					end if;	
					count <= count+1;
					if count = 72 then 
					count <= "0000000";
					transmisja <= '0';
					end if;
				else TXD_o <= '1';
				end if;	
			end if;
	end process;
end Behavioral;

