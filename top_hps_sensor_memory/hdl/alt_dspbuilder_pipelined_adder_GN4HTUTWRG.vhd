library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_pipelined_adder_GN4HTUTWRG is
	generic		( 			pipeline : integer := 0;
			width : natural := 0);

	port(
		aclr : in std_logic;
		add_sub : in std_logic;
		cin : in std_logic;
		clock : in std_logic;
		cout : out std_logic;
		dataa : in std_logic_vector((width)-1 downto 0);
		datab : in std_logic_vector((width)-1 downto 0);
		ena : in std_logic;
		result : out std_logic_vector((width)-1 downto 0);
		user_aclr : in std_logic);		
end entity;

architecture rtl of alt_dspbuilder_pipelined_adder_GN4HTUTWRG is 

signal cin_internal : std_logic;

Begin

	cin_internal <= '0';

-- DSP Builder Block - Simulink Block "PipelinedAdder"
PipelinedAdderi : alt_dspbuilder_sLpmAddSub  Generic map (
                                or_aclr_inputs => true,
				width	=>	width,
				pipeline	=>	pipeline,
				IsUnsigned	=>	0				)
		port map (
				clock		=>	clock,
				clken		=>	ena,
				aclr		=>	aclr,
				user_aclr	=>	user_aclr,
				cin			=> cin_internal,
				add_sub		=>	 '1' ,
				dataa		=>	dataa,
				datab		=>	datab,
				cout		=> cout,
				result		=>	result);




end architecture;
