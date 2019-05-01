library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all; 

entity VGA_64_Column is

  port(
	input 				: in std_logic_vector(2 downto 0); 
	Hcount 				: in unsigned (9 downto 0); 
	address_column  	: out unsigned (5 downto 0); 
	column_enable		: out std_logic ); 
end VGA_64_Column; 
	
architecture DISPLAY of VGA_64_Column is 
begin
	
process(input, Hcount) 
begin 
		if (input = "000") then 
			if(Hcount >= CENTERED_X_START and Hcount <= CENTERED_X_END) then   
				column_enable <= '1'; 
				address_column <= resize((Hcount - 255)/2, 6); 
			else 
				column_enable <= '0'; 
				address_column <= resize((Hcount - 255)/2, 6);
			end if; 
			
			
		elsif (input = "001") then  
			if(Hcount >= TOP_LEFT_X_START and Hcount <= TOP_LEFT_X_END) then 
				column_enable <= '1'; 
				address_column <= resize((Hcount)/2, 6);
			else 
				column_enable <= '0'; 
				address_column <= resize((Hcount)/2, 6);
			end if; 
			
			
		elsif (input = "010") then 
			if(Hcount >= TOP_RIGHT_X_START and Hcount <= TOP_RIGHT_X_END) then   
				column_enable <= '1'; 
				address_column <= resize((Hcount - 511)/2, 6);
			else 
				column_enable <= '0'; 
				address_column <= resize((Hcount - 511)/2, 6);
			end if; 
	
			
		elsif (input = "011") then 
				if(Hcount >= BOTTOM_LEFT_X_START and Hcount <= BOTTOM_LEFT_X_END) then   			
				column_enable <= '1';
				address_column <= resize((Hcount)/2, 6); 
			else 
				column_enable <= '0';
				address_column <= resize((Hcount)/2, 6);
			end if; 
			
			
		elsif (input = "100") then 
			if(Hcount >= BOTTOM_RIGHT_X_START and Hcount <= BOTTOM_RIGHT_X_END) then 
				--address <= hcount - offset 
				column_enable <= '1';
				address_column <= resize((Hcount - 511)/2, 6);
			else 
				column_enable <= '0';
				address_column <= resize((Hcount - 511)/2, 6);
			end if; 
			
			
		end if; 
 	end process; 
end DISPLAY; 

