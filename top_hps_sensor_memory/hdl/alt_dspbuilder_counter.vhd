-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alt_dspbuilder_counter is
	generic (
		SVALUE : string := "0";
		USE_CNT_ENA : string := "false";
		USE_COUT : string := "false";
		MODULUS : integer := 256;
		USE_SCLR : string := "false";
		NDIRECTION : natural := 1;
		USE_USR_ACLR : string := "false";
		WIDTH : natural := 8;
		USE_ENA : string := "false";
		USE_SSET : string := "false";
		USE_ALOAD : string := "false";
		AVALUE : string := "0";
		USE_ASET : string := "false";
		USE_SLOAD : string := "false";
		USE_CIN : string := "false"
	);
	port (
		sclr : in std_logic;
		data : in std_logic_vector(width-1 downto 0);
		aclr : in std_logic;
		cout : out std_logic;
		user_aclr : in std_logic;
		cin : in std_logic;
		clock : in std_logic;
		aset : in std_logic;
		aload : in std_logic;
		cnt_ena : in std_logic;
		q : out std_logic_vector(width-1 downto 0);
		ena : in std_logic;
		sset : in std_logic;
		sload : in std_logic;
		direction : in std_logic
	);
end entity alt_dspbuilder_counter;

architecture rtl of alt_dspbuilder_counter is

component alt_dspbuilder_counter_GNWUDKEMTG is
	generic (
		SVALUE : string := "300";
		USE_CNT_ENA : string := "false";
		USE_COUT : string := "false";
		MODULUS : integer := 1000;
		USE_SCLR : string := "true";
		NDIRECTION : natural := 1;
		USE_USR_ACLR : string := "false";
		WIDTH : natural := 10;
		USE_ENA : string := "true";
		USE_SSET : string := "false";
		USE_ALOAD : string := "false";
		AVALUE : string := "0";
		USE_ASET : string := "false";
		USE_SLOAD : string := "false";
		USE_CIN : string := "false"
	);
	port (
		aclr : in std_logic;
		clock : in std_logic;
		cout : out std_logic;
		ena : in std_logic;
		q : out std_logic_vector(10-1 downto 0);
		sclr : in std_logic
	);
end component alt_dspbuilder_counter_GNWUDKEMTG;

begin

alt_dspbuilder_counter_GNWUDKEMTG_0: if ((SVALUE = "300") and (USE_CNT_ENA = "false") and (USE_COUT = "false") and (MODULUS = 1000) and (USE_SCLR = "true") and (NDIRECTION = 1) and (USE_USR_ACLR = "false") and (WIDTH = 10) and (USE_ENA = "true") and (USE_SSET = "false") and (USE_ALOAD = "false") and (AVALUE = "0") and (USE_ASET = "false") and (USE_SLOAD = "false") and (USE_CIN = "false")) generate
	inst_alt_dspbuilder_counter_GNWUDKEMTG_0: alt_dspbuilder_counter_GNWUDKEMTG
		generic map(SVALUE => "300", USE_CNT_ENA => "false", USE_COUT => "false", MODULUS => 1000, USE_SCLR => "true", NDIRECTION => 1, USE_USR_ACLR => "false", WIDTH => 10, USE_ENA => "true", USE_SSET => "false", USE_ALOAD => "false", AVALUE => "0", USE_ASET => "false", USE_SLOAD => "false", USE_CIN => "false")
		port map(aclr => aclr, clock => clock, cout => cout, ena => ena, q => q, sclr => sclr);
end generate;

assert not (((SVALUE = "300") and (USE_CNT_ENA = "false") and (USE_COUT = "false") and (MODULUS = 1000) and (USE_SCLR = "true") and (NDIRECTION = 1) and (USE_USR_ACLR = "false") and (WIDTH = 10) and (USE_ENA = "true") and (USE_SSET = "false") and (USE_ALOAD = "false") and (AVALUE = "0") and (USE_ASET = "false") and (USE_SLOAD = "false") and (USE_CIN = "false")))
	report "Please run generate again" severity error;

end architecture rtl;

