-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alt_dspbuilder_comparator is
	generic (
		OPERATOR : string := "Altaeb";
		LPM_WIDTH : natural := 8
	);
	port (
		result : out std_logic;
		sclr : in std_logic;
		datab : in std_logic_vector(lpm_width-1 downto 0);
		dataa : in std_logic_vector(lpm_width-1 downto 0);
		clock : in std_logic
	);
end entity alt_dspbuilder_comparator;

architecture rtl of alt_dspbuilder_comparator is

component alt_dspbuilder_comparator_GN is
	generic (
		OPERATOR : string := "Altaeb";
		LPM_WIDTH : natural := 8
	);
	port (
		clock : in std_logic;
		dataa : in std_logic_vector(8-1 downto 0);
		datab : in std_logic_vector(8-1 downto 0);
		result : out std_logic;
		sclr : in std_logic
	);
end component alt_dspbuilder_comparator_GN;

begin

alt_dspbuilder_comparator_GN_0: if ((OPERATOR = "Altaeb") and (LPM_WIDTH = 8)) generate
	inst_alt_dspbuilder_comparator_GN_0: alt_dspbuilder_comparator_GN
		generic map(OPERATOR => "Altaeb", LPM_WIDTH => 8)
		port map(clock => clock, dataa => dataa, datab => datab, result => result, sclr => sclr);
end generate;

assert not (((OPERATOR = "Altaeb") and (LPM_WIDTH = 8)))
	report "Please run generate again" severity error;

end architecture rtl;

