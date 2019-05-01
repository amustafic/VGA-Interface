library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all; 

entity VGA_sync_gen is

  port(
	 clk 		 	: in  std_logic;
	 rst 		  	: in  std_logic;  
    Hcount 		: out unsigned (9 downto 0);  
	 Vcount  	: out unsigned (9 downto 0); 
	 Horiz_sync : out std_logic; 
	 Vert_sync 	: out std_logic; 
	 Video_on   : out std_logic 
	);
end VGA_sync_gen;

architecture VGA of VGA_sync_gen is 

	signal clk_25MHz	: std_logic; 
	signal new_Hcount : unsigned (9 downto 0);  
	signal new_Vcount : unsigned (9 downto 0); 
	
begin 

	PXL_CLK : entity work.pixel_clk 
				
			port map( 
				clk 			=>	clk,
				pixel_clock => clk_25MHz,  
				rst 			=> rst);  
	
	process(new_Hcount, new_Vcount) 
	begin
		
		if(new_Hcount >= H_DISPLAY_END and new_Hcount <= H_MAX) then 
			Video_on   <= '0';
		else 
			Video_on   <= '1'; 
		end if; 
			
		if(new_Hcount >= HSYNC_BEGIN and new_Hcount < HSYNC_END) then 
			Horiz_sync <= '0';
			
		else 
			Horiz_sync <= '1';
		end if; 
			
		
		if(new_Vcount >= VSYNC_BEGIN and new_Vcount <= VSYNC_END and new_Vcount < HSYNC_END) then 
			Vert_sync <= '0'; 
		else 
			Vert_sync <= '1'; 
		end if; 
		
		
	end process; 
	
	process (clk_25MHz, rst) 
	begin 
		if (rst = '1') then 
		
			new_Hcount <= "0000000000"; 
			new_Vcount <= "0000000000"; 
			
		elsif (rising_edge(clk_25Mhz)) then 
			
			if(new_Hcount = H_MAX) then 
				new_Hcount <= "0000000000"; 
			else 
				new_Hcount <= new_Hcount + 1; 
			end if; 
			
			 
			if(new_Vcount = V_MAX) then
				new_Vcount <= "0000000000"; 
			elsif(new_Hcount = H_VERT_INC) then 
				new_Vcount <= new_Vcount + 1; 
			else 
				new_Vcount <= new_Vcount; 
				
			end if;  
			
		end if; 
	end process;
	
	Hcount <= new_Hcount; 
	Vcount <= new_Vcount; 
	 			
end VGA; 