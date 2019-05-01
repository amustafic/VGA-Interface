library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all; 

entity VGA_64_Row is

  port(
	input 			: in std_logic_vector(2 downto 0); 
	Vcount 			: in unsigned (9 downto 0); 
	address_row 	: out unsigned (5 downto 0); 
	row_enable		: out std_logic ); 
end VGA_64_Row; 
	
architecture DISPLAY of VGA_64_Row is
begin
	 
process(input, Vcount) 
begin 
		if (input = "000") then 

			if(Vcount >= CENTERED_Y_START and Vcount <= CENTERED_Y_END ) then 
				--address <= vcount - offset 
				row_enable <= '1'; 
				address_row <= resize((Vcount - 175)/2, 6);  
			else
				row_enable <= '0';
				address_row <= resize((Vcount - 175)/2, 6); 
			end if; 
			
			
		elsif (input = "001") then 
					
			if(Vcount >= TOP_LEFT_Y_START and Vcount <= TOP_LEFT_Y_END) then 
				--address <= vcount - offset
				row_enable <= '1'; 
				address_row <= resize((Vcount)/2, 6); 
			else 
				row_enable <= '0';
				address_row <= resize((Vcount)/2, 6);	
			end if; 
			
			
		elsif (input = "010") then  
			
			if(Vcount >= TOP_RIGHT_Y_START and Vcount <= TOP_RIGHT_Y_END) then 
				--address <= vcount - offset 
				row_enable <= '1';
				address_row <= resize((Vcount)/2, 6);
			else 
				row_enable <= '0'; 
				address_row <= resize((Vcount)/2, 6);
			end if; 
		
		
		elsif (input = "011") then 
					
			if(Vcount >= BOTTOM_LEFT_Y_START and Vcount <= BOTTOM_LEFT_Y_END) then 
				--address <= vcount - offset 
				row_enable <= '1';
				address_row <= resize((Vcount - 351)/2, 6);
			else 
				row_enable <= '0';
				address_row <= resize((Vcount - 352)/2, 6);
			end if; 
			
			
		elsif (input = "100") then 
						
			if(Vcount >= BOTTOM_RIGHT_Y_START and Vcount <= BOTTOM_RIGHT_Y_END) then 
				--address <= vcount - offset 
				row_enable <= '1';
				address_row <= resize((Vcount - 351)/2, 6); 
			else 
				row_enable <= '0';
				address_row <= resize((Vcount - 351)/2, 6);
			end if; 
		end if; 
 	end process; 
end DISPLAY; 