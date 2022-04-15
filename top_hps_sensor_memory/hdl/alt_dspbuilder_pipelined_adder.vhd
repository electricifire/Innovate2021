-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alt_dspbuilder_pipelined_adder is
	generic (
		USE_CARRY_OUT_PORT : natural := 1;
		SIGNED : integer := 0;
		OR_ACLR_INPUTS : natural := 1;
		NDIRECTION : integer := 1;
		PIPELINE : integer := 0;
		WIDTH : natural := 0;
		USE_CARRY_PORT : natural := 1
	);
	port (
		result : out std_logic_vector(width-1 downto 0);
		aclr : in std_logic;
		cout : out std_logic;
		datab : in std_logic_vector(width-1 downto 0);
		dataa : in std_logic_vector(width-1 downto 0);
		user_aclr : in std_logic;
		cin : in std_logic;
		ena : in std_logic;
		clock : in std_logic;
		add_sub : in std_logic
	);
end entity alt_dspbuilder_pipelined_adder;

architecture rtl of alt_dspbuilder_pipelined_adder is

component alt_dspbuilder_pipelined_adder_GNY2JEH574 is
	generic (
		USE_CARRY_OUT_PORT : natural := 0;
		SIGNED : integer := 1;
		OR_ACLR_INPUTS : natural := 1;
		NDIRECTION : integer := 0;
		PIPELINE : integer := 0;
		WIDTH : natural := 0;
		USE_CARRY_PORT : natural := 0
	);
	port (
		aclr : in std_logic;
		clock : in std_logic;
		dataa : in std_logic_vector(0-1 downto 0);
		datab : in std_logic_vector(0-1 downto 0);
		ena : in std_logic;
		result : out std_logic_vector(0-1 downto 0);
		user_aclr : in std_logic
	);
end component alt_dspbuilder_pipelined_adder_GNY2JEH574;

begin

alt_dspbuilder_pipelined_adder_GNY2JEH574_0: if ((USE_CARRY_OUT_PORT = 0) and (SIGNED = 1) and (OR_ACLR_INPUTS = 1) and (NDIRECTION = 0) and (PIPELINE = 0) and (WIDTH = 0) and (USE_CARRY_PORT = 0)) generate
	inst_alt_dspbuilder_pipelined_adder_GNY2JEH574_0: alt_dspbuilder_pipelined_adder_GNY2JEH574
		generic map(USE_CARRY_OUT_PORT => 0, SIGNED => 1, OR_ACLR_INPUTS => 1, NDIRECTION => 0, PIPELINE => 0, WIDTH => 0, USE_CARRY_PORT => 0)
		port map(aclr => aclr, clock => clock, dataa => dataa, datab => datab, ena => ena, result => result, user_aclr => user_aclr);
end generate;

assert not (((USE_CARRY_OUT_PORT = 0) and (SIGNED = 1) and (OR_ACLR_INPUTS = 1) and (NDIRECTION = 0) and (PIPELINE = 0) and (WIDTH = 0) and (USE_CARRY_PORT = 0)))
	report "Please run generate again" severity error;

end architecture rtl;

