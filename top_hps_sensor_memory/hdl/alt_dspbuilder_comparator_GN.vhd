library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_comparator_GN is
	generic		( 			Operator : string := "Altaeb";
			lpm_width : natural := 8);

	port(
		clock : in std_logic;
		dataa : in std_logic_vector((lpm_width)-1 downto 0);
		datab : in std_logic_vector((lpm_width)-1 downto 0);
		result : out std_logic;
		sclr : in std_logic);		
end entity;

architecture rtl of alt_dspbuilder_comparator_GN is 
Begin

    gAltaeb:if Operator="Altaeb" generate
        result <='1' when (dataa = datab) else '0';
    end generate gAltaeb;
    
    gAltaneb:if Operator="Altaneb" generate
        result <='1' when (dataa /= datab) else '0';
    end generate gAltaneb;
    
    gAltagb:if Operator="Altagb" generate
        result <='1' when (SIGNED(dataa) > SIGNED(datab)) else '0';
    end generate gAltagb;
        
    gAltageb:if Operator="Altageb" generate
        result <='1' when (SIGNED(dataa) >= SIGNED(datab)) else '0';
    end generate gAltageb;
        
    gAltalb:if Operator="Altalb" generate
        result <='1' when (SIGNED(dataa) < SIGNED(datab)) else '0';
    end generate gAltalb;
    
    gAltaleb:if Operator="Altaleb" generate
        result <='1' when (SIGNED(dataa) <= SIGNED(datab)) else '0';
    end generate gAltaleb;

end architecture;					