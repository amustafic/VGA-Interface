library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all; 

entity VGA_top_level is

	signal RED			: out std_logic_vector (3 downto 0);
	signal GREEN   	: out std_logic_vector (3 downto 0); 
	signal BLUE    	: out std_logic_vector (3 downto 0); 
	signal Horiz_sync : out std_logic; 
	signal Vert_sync  : out std_logic;  
	signal Video_on   : out std_logic; 
	
end VGA_top_level; 
	
architecture TL of VGA_top_level is
	signal Hcount 				: unsigned (9 downto 0); 
	signal Vcount 				: unsigned (9 downto 0); 
	signal address_row 		: unsigned (6 downto 0); 
	signal row_enable 		: std_logic; 
	signal address_column 	: unsigned (6 downto 0); 
	signal column_enable 	: std_logic; 
	signal output				: std_logic_vector (11 downto 0); 
	signal rom_address		: std_logic_vector (11 downto 0); 
begin 
	U_SYNC_GEN : entity work.VGA_SYNC_GEN 
	
			port map( 
				 clk 			=> clk, 	
				 rst 		  	=> rst,   
				 Hcount 		=> Hcount,
				 Vcount		=> Vcount,  	 
				 Horiz_sync => Horiz_sync,
				 Vert_sync 	=> Vert_sync,  
				 Video_on   => Video_on );
	PXL_CLK : entity work.pixel_clk 
				
			port map( 
				clk 			=>	clk,
				pixel_clock => clk_25MHz,  
				rst 			=> rst);   
				 
	 U_VGA_ROW : entity work.VGA_64_Row 
	 
			port map( 
				input 		=>	input, 
				Hcount 		=>	Hcount,
				address_row =>	address_row,
				row_enable 	=> row_enable); 
				
	U_VGA_COLUMN : entity work.VGA_64_Column 
	
			port map( 
				input 			=> input. 
				Vcount 			=>	Vcount,
				address_column =>	address_column, 
				column_enable	=>	column_enable); 
				
	U_VGA_ROM : entity work.VGA_ROM 
	
			port map( 
				address	=> rom_address, 
				clock 	=> clk_25MHz,
				q			=> output); 
				
	rom_address <= address_row & address_columm; 
end TL; 
