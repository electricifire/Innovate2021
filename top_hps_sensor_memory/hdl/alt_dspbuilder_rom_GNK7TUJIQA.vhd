library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library altera;
use altera.alt_dspbuilder_package.all;

library lpm;
use lpm.lpm_components.all;
entity alt_dspbuilder_rom_GNK7TUJIQA is
	generic		( 			ClockPhase : string := "1";
			numwords : positive := 1000;
			use_ena : natural := 1;
			XFILE : string := "input.hex";
			family : string := "Cyclone V";
			runtime_mod_instance_name : string := "AAAA";
			register_outputs : natural := 0;
			data_width : positive := 14;
			supportROM : natural := 1;
			ram_block_type : string := "AUTO";
			enable_runtime_mod : natural := 0;
			initialization : string := "From MATLAB array");

	port(
		clock : in std_logic;
		aclr : in std_logic;
		addr : in std_logic_vector(9 downto 0);
		ena : in std_logic;
		q : out std_logic_vector(13 downto 0));		
end entity;

library altera;
use altera.alt_dspbuilder_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;


architecture rtl of alt_dspbuilder_rom_GNK7TUJIQA is 

	signal seqenable	: STD_LOGIC ;
	signal enadff		: STD_LOGIC ;
    signal vcc_or_ena   : STD_LOGIC ; 

Begin


	
						vcc_or_ena <= ena;
		
											enadff <= vcc_or_ena;
	
    -------------------------------------------------------------
    -- ROM
    -------------------------------------------------------------
    u1 : altsyncram
            GENERIC MAP (
                address_aclr_a                     => "NONE",
                init_file                          => "alt_dspbuilder_rom_GNK7TUJIQA.hex",			
                intended_device_family             => "Cyclone V",
                lpm_hint 			   => "ENABLE_RUNTIME_MOD=NO",     			
                lpm_type                           => "altsyncram",
                numwords_a                         => 1000,
                operation_mode                     => "ROM",
  			   	outdata_aclr_a                     => "NONE",
  				outdata_reg_a                      => "UNREGISTERED",
                power_up_uninitialized             => "FALSE",
                ram_block_type                     => "AUTO",
                read_during_write_mode_mixed_ports => "OLD_DATA",
                widthad_a                          => 10,
                width_a                            => 14,
                width_byteena_a                    => 1
            )
            PORT MAP (
                clocken0    => enadff,
                clock0      => clock,
                address_a   => addr,
                q_a         => q
             );

end architecture;
