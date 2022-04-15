-- Commande --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity timer is 
  
	 
  port (                                 
		clk            	:  in  std_logic;
		rst            	:  in  std_logic;
	  		
		-- Señales de temporization --
		t_0			  		:  out  std_logic;	-- lecture des ADC 
		t_1			  		:  out  std_logic		-- Calcule des signals de commande	
		
		);
	 
end timer;

architecture test of timer is

begin

		-- temporizador cada 50KHz --
		process(rst, clk)
		variable temp: integer range 0 to 999;
		begin
		
		  if (rst = '0') then  
		  
				temp:=0;
				
				t_0<='0';	-- no ADC
				t_1<='0';	-- no calcule
				
								
		  elsif (rising_edge(clk)) then  		
									
				-- *********** LECTURES DES ADCs *********
				if (temp=999) then		-- t=0
					temp:=0;
					t_0<='1';				-- lire l'ADC --
					
			-- ***********  *********
				else
					temp:=temp+1;		
					
					t_0		<='0';		-- no ADC
					t_1		<='0';		-- no DAC
					
					-- *********** CALCUL DE SIGNALS DE COMMANDE *********
					if (temp=150)  then	-- 2.5us
						t_1<='1';			-- calcule des signals de commande
					end if;					
					-- *********** *********** *********
				end if;	
		
		  end if;	-- end de if sequentielle
		end process;
		
		
end test;