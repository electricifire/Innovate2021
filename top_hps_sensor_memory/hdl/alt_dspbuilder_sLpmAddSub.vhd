--------------------------------------------------------------------------------------------
-- DSP Builder (Version 9.1)
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: © 2001 Altera Corporation. All rights reserved.  Your use of Altera 
-- Corporation's design tools, logic functions and other software and tools, and its 
-- AMPP partner logic functions, and any output files any of the foregoing 
-- (including device programming or simulation files), and any associated 
-- documentation or information are expressly subject to the terms and conditions 
-- of the Altera Program License Subscription Agreement, Altera MegaCore Function 
-- License Agreement, or other applicable license agreement, including, without 
-- limitation, that your use is for the sole purpose of programming logic devices 
-- manufactured by Altera and sold by Altera or its authorized distributors.  
-- Please refer to the applicable agreement for further details.
--------------------------------------------------------------------------------------------



library ieee ;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

library LPM;
use LPM.LPM_COMPONENTS.all;


library altera;
use altera.alt_dspbuilder_package.all;


ENTITY alt_dspbuilder_sLpmAddSub IS
	GENERIC
	(
		width	   : positive :=8;
		isunsigned : natural  :=0;	
		pipeline   : natural  :=0;	
                or_aclr_inputs : boolean := true
	);
	PORT
	(
		add_sub		: in std_logic ;
		dataa		: in std_logic_vector (width-1 DOWNTO 0);
		datab		: in std_logic_vector (width-1 DOWNTO 0);
		cin		    : in std_logic ;
		clock		: in std_logic ;
        aclr        : in std_logic ;
        user_aclr   : in std_logic ;
		clken		: in std_logic ;
		result		: out std_logic_vector (width-1 DOWNTO 0);
		cout		: out std_logic 
	);
END alt_dspbuilder_sLpmAddSub;


ARCHITECTURE SYN OF alt_dspbuilder_sLpmAddSub IS

signal aclr_i : std_logic;

BEGIN

or_aclrs: if (or_aclr_inputs=true) generate
        aclr_i <= aclr or user_aclr;
end generate or_aclrs;

only_user_aclr: if(or_aclr_inputs=false) generate
       aclr_i <= user_aclr;
end generate only_user_aclr;


gnp:if (0=pipeline) generate

	gsn:if (0=isunsigned) generate
        U0 : lpm_add_sub
        GENERIC MAP (
        	lpm_width          => width,
        	lpm_direction      => "UNUSED",
        	lpm_type           => "LPM_ADD_SUB",
        	lpm_hint           => "ONE_INPUT_IS_CONSTANT=NO",
	        lpm_representation =>  "SIGNED",
        	lpm_pipeline       => 0
        )
        PORT MAP (
        	dataa         => dataa,
        	add_sub       => add_sub,
        	datab         => datab,
        	cin           => cin,
        	overflow      => cout,
        	result        => result
        );
	end generate gsn;

	gusn:if (0<isunsigned) generate
        U0 : lpm_add_sub
        GENERIC MAP (
        	lpm_width          => width,
        	lpm_direction      => "UNUSED",
        	lpm_type           => "LPM_ADD_SUB",
        	lpm_hint           => "ONE_INPUT_IS_CONSTANT=NO",
	        lpm_representation =>  "UNSIGNED",
        	lpm_pipeline       => 0
        )
        PORT MAP (
        	dataa         => dataa,
        	add_sub       => add_sub,
        	datab         => datab,
        	cin           => cin,
        	cout          => cout,
        	result        => result
        );
	end generate gusn;
	
end generate gnp;

gp:if (pipeline>0) generate

	gsn:if (0=isunsigned) generate
		U0 : lpm_add_sub
		GENERIC MAP (
			lpm_width          => width,
			lpm_direction      => "UNUSED",
			lpm_type           => "LPM_ADD_SUB",
			lpm_hint           => "ONE_INPUT_IS_CONSTANT=NO",
	        lpm_representation =>  "SIGNED",
			lpm_pipeline       => pipeline
		)
		PORT MAP (
			dataa         => dataa,
			add_sub       => add_sub,
			datab         => datab,
			cin           => cin,
			clken         => clken,
			aclr          => aclr_i,
			clock         => clock,
			overflow      => cout,
			result        => result
		);
	end generate gsn;
	
	gusn:if (0<isunsigned) generate
		U0 : lpm_add_sub
		GENERIC MAP (
			lpm_width     => width,
			lpm_direction => "UNUSED",
			lpm_type      => "LPM_ADD_SUB",
			lpm_hint      => "ONE_INPUT_IS_CONSTANT=NO",
	        lpm_representation =>  "UNSIGNED",
			lpm_pipeline  => pipeline
		)
		PORT MAP (
			dataa         => dataa,
			add_sub       => add_sub,
			datab         => datab,
			cin           => cin,
			clken         => clken,
			aclr          => aclr_i,
			clock         => clock,
			cout          => cout,
			result        => result
		);
	end generate gusn;

end generate gp;

END SYN;



