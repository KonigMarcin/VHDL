----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:34 03/07/2019 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
Port ( clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		btn_i: in std_logic_vector(2 downto 0);
		led7_an_o :   out STD_LOGIC_vector (3 downto 0):=(others => '1');
		led7_seg_o :   out STD_LOGIC_vector (7 downto 0):="11111111"
		);
end top;

architecture Behavioral of top is
Component dzielnik --dzielnik czestotliwosci
 Port ( 
			clock: in std_logic;
			reset : in std_logic;
			freq_out : out std_logic );
END Component;
Component displayy -- multipleksowanie wyœwietlaczy z czêstotliwosci¹ 1kHz
	 Port ( clk_i : in  STD_LOGIC;
           digit_i : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o :out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
END Component;
component debouncer is --zabezpieczenie przycisku przed drganiami
    Port (  clk_i : in std_logic;
				btn_i: in std_logic_vector(2 downto 0);
            btn_o : out  STD_LOGIC_vector(2 downto 0) :="000"			  
			  );
end component;
component main is 
Port( clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		btn_i: in std_logic_vector(2 downto 0);
		digit_i : out std_logic_vector(31 downto 0)

		);
end component;
signal clock : std_logic;
signal digit_i :STD_LOGIC_VECTOR (31 downto 0);
signal btn_o :STD_LOGIC_vector(2 downto 0);
begin

dzielnik_1: dzielnik port map(clk_i,rst_i,clock);
display: displayy port map(clock,digit_i,led7_an_o,led7_seg_o);
debouncer1:debouncer port map(clk_i,btn_i,btn_o);
main1: main port map(clock,rst_i,btn_o,digit_i); 
end Behavioral;

