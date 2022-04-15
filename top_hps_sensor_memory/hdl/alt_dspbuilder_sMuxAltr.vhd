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


library IEEE;
use IEEE.std_logic_1164.all;

library altera;
use altera.alt_dspbuilder_package.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

entity alt_dspbuilder_sMuxAltr is
	generic ( 	lpm_pipeline	: natural:=0;
				lpm_size		: positive:=5;
				lpm_widths		: positive:=3;
				lpm_width		: positive:=8;
				SelOneHot		: natural:=0);
	PORT	(	clock		: in std_logic ;
                aclr		: in std_logic  := '0';
                user_aclr	: in std_logic  := '0';
				ena			: in std_logic  := '1';
				data		: in std_logic_vector (lpm_width*lpm_size-1 downto 0);
				sel			: in std_logic_vector (lpm_widths-1 downto 0);
				result		: out std_logic_vector (lpm_width-1 downto 0));
end alt_dspbuilder_sMuxAltr;

architecture synth of alt_dspbuilder_sMuxAltr is

function salive( ipp : integer; w : natural ) return std_logic_vector is
variable sxbus : std_logic_vector(w-1 downto 0);
begin
	for i in 0 to w-1 loop
		if ipp=i then
			sxbus(i) :='1';
		else
			sxbus(i) :='0';			
		end if;
	end loop;
	return sxbus;
end;

signal selint	: std_logic_vector(nbitnecessary(lpm_size)-1 downto 0);
signal dataa	: std_logic_2d (lpm_size-1 downto 0, lpm_width-1 downto 0);
signal aclr_i : std_logic;

begin

aclr_i <= aclr or user_aclr;

gnoh:if SelOneHot=0 generate
	selint <= sel;
end generate gnoh;

g_one_hot:if SelOneHot>0 generate
	
	gi:for i in 0 to  lpm_size-1 generate
		selint <= int2ustd(i,nbitnecessary(lpm_size)) when sel = salive(i, lpm_size) else (others=>'Z');
	end generate gi;

end generate g_one_hot;

g2d:for i in 1 to lpm_size generate
	gw:for j in 0 to lpm_width-1 generate
		dataa(i-1,j) <= data(j+(i-1)*lpm_width);
	end generate gw;
end generate g2d;

gp:if lpm_pipeline>0 generate
	U0 : lpm_mux generic map (	lpm_pipeline => lpm_pipeline,
								lpm_size => lpm_size,
								lpm_widths => nbitnecessary(lpm_size),
								lpm_width => lpm_width,
								lpm_type => "LPM_MUX")
				port map (   	sel => selint,
								clken => ena,
								aclr => aclr_i,
								clock => clock,
								data => dataa,
								result => result);
end generate gp;

gc:if lpm_pipeline=0 generate	
	U0 : lpm_mux generic map (	lpm_size => lpm_size,
								lpm_widths => nbitnecessary(lpm_size),
								lpm_width => lpm_width,
								lpm_type => "LPM_MUX")
				port map (   	sel => selint,
								data => dataa,
								result => result);
end generate gc;

end synth;


