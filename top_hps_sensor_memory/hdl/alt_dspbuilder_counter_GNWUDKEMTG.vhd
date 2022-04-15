library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_counter_GNWUDKEMTG is
	generic		( 			svalue : string := "300";
			use_cnt_ena : string := "false";
			use_cout : string := "false";
			modulus : integer := 1000;
			use_sclr : string := "true";
			ndirection : natural := 1;
			use_usr_aclr : string := "false";
			width : natural := 10;
			use_ena : string := "true";
			use_sset : string := "false";
			use_aload : string := "false";
			avalue : string := "0";
			use_aset : string := "false";
			use_sload : string := "false";
			use_cin : string := "false");

	port(
		aclr : in std_logic;
		aload : in std_logic;
		aset : in std_logic;
		cin : in std_logic;
		clock : in std_logic;
		cnt_ena : in std_logic;
		cout : out std_logic;
		data : in std_logic_vector((width)-1 downto 0);
		direction : in std_logic;
		ena : in std_logic;
		q : out std_logic_vector((width)-1 downto 0);
		sclr : in std_logic;
		sload : in std_logic;
		sset : in std_logic;
		user_aclr : in std_logic);		
end entity;

architecture rtl of alt_dspbuilder_counter_GNWUDKEMTG is 


Begin


	-- DSP Builder Block - Simulink Block "Counter"
	Counteri : lpm_counter  Generic map (
					LPM_WIDTH		=> 10,
					LPM_DIRECTION	=> "UP",
					LPM_MODULUS		=> 1000,
					LPM_AVALUE		=> "0",
					LPM_SVALUE		=> "300",
					LPM_TYPE		=> "LPM_COUNTER"
					)
			port map (
					clock	=>	clock,
					clk_en	=>	ena,
					aclr	=>	aclr,
					sclr	=>	sclr,
					q		=>	q);

end architecture;
