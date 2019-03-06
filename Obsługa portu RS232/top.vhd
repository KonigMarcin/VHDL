library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is

Port ( clk_i : in  STD_LOGIC;
       rst_i : in  STD_LOGIC;
		 
		 TXD_o : out  STD_LOGIC;
		 RXD_i  : in  STD_LOGIC
		 
		 );
end top;

architecture Behavioral of top is

component dzielnik is
	port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           clk_div : out  STD_LOGIC :='0'			  
			  );
end component;

component rx is--76804
	port (  clk : in STD_LOGIC;
           RXD_i : in  STD_LOGIC;	
			  stan : out std_logic := '0';
			  data: out  std_logic_vector(7 downto 0) :=(others => '0')				  
			  );
end component;

component tx is--9600
    Port( clk : in  STD_LOGIC;
				stan : in  STD_LOGIC;
			  data : in STD_LOGIC_VECTOR(7 downto 0);
           TXD_o : out  STD_LOGIC :='0'			  
			  );
end component;

signal clk_div : std_logic;
signal stan : std_logic;
signal bufor : std_logic_vector(7 downto 0);

begin

dzielnik_1: dzielnik port map(clk_i,rst_i,clk_div);
reciver: rx port map(clk_div,RXD_i,stan,bufor);
transmiter: tx port map(clk_div,stan,bufor,TXD_o);


end Behavioral;

