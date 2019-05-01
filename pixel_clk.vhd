library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pixel_clk is
    generic(clk_in_freq  : natural := 50000000;
            clk_out_freq : natural := 25000000);
    port (
        clk  : in  std_logic;
        pixel_clock : out std_logic;
        rst     : in  std_logic);
end pixel_clk;

architecture CLK of pixel_clk is 
	signal count : integer;
	signal clock : std_logic; 
	constant ratio : natural := clk_in_freq/clk_out_freq-1;  
	
begin
	process(clk, rst)
		begin 
			if(rst = '1') then 
				count <= 0;  
				
			elsif (rising_edge(clk)) then
			
				if (count = 0) then
					clock <= '1'; 
					count <= count + 1; 
				elsif (count = ratio) then 
					count <= 0; 
					clock <= '0'; 
				else 
					clock <= '0'; 
					count <= count + 1; 
				end if; 
			end if; 
		end process; 
		
		pixel_clock <= clock; 
							
end CLK; 
