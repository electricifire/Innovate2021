library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_multiplexer_GNBGHTTLA2 is
	generic		( 			number_inputs : natural := 2;
			pipeline : natural := 1;
			width : positive := 13;
			HDLTYPE : string := "STD_LOGIC_VECTOR";
			use_one_hot_select_bus : natural := 0);

	port(
		clock : in std_logic;
		aclr : in std_logic;
		sel : in std_logic_vector(0 downto 0);
		result : out std_logic_vector(12 downto 0);
		ena : in std_logic;
		user_aclr : in std_logic;
		in0 : in std_logic_vector(12 downto 0);
		in1 : in std_logic_vector(12 downto 0));		
end entity;

architecture rtl of alt_dspbuilder_multiplexer_GNBGHTTLA2 is 

	signal data_muxin		:	std_logic_vector(25 downto 0);
	

Begin

data_muxin		<=	 in1 &  in0 ;

nto1Multiplexeri : alt_dspbuilder_sMuxAltr generic map (
				lpm_pipeline =>1,
				lpm_size => 2,
				lpm_widths => 1  ,
				lpm_width => 13 ,
				SelOneHot => 0 )
		port map (
				clock		=>	clock,
				ena   		=>	ena,
				user_aclr	=>	user_aclr,
				aclr		=>	aclr,
				data   		=>	data_muxin,
				sel   		=>	sel,
				result		=>	 result);


end architecture;









