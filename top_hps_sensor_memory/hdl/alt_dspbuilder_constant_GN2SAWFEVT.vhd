library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_constant_GN2SAWFEVT is
	generic		( 			BitPattern : string := "0010110010010";
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			width : natural := 13);

	port(
		output : out std_logic_vector(12 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_constant_GN2SAWFEVT is 
Begin
-- Constant
output		<=	"0010110010010";				
end architecture;