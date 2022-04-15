-- This file is not intended for synthesis, is is present so that simulators
-- see a complete view of the system.

-- You may use the entity declaration from this file as the basis for a
-- component declaration in a VHDL file instantiating this entity.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity mem is
	port (
		Clock : in std_logic;
		Iacont_int : out std_logic_vector(12-1 downto 0);
		Ibcont_int : out std_logic_vector(12-1 downto 0);
		Iccont_int : out std_logic_vector(12-1 downto 0);
		Vacont_int : out std_logic_vector(12-1 downto 0);
		Vbcont_int : out std_logic_vector(12-1 downto 0);
		Vccont_int : out std_logic_vector(12-1 downto 0);
		aclr : in std_logic;
		clk60KPLL : in std_logic
	);
end entity mem;

architecture rtl of mem is

component mem_GN is
	port (
		Clock : in std_logic;
		Iacont_int : out std_logic_vector(12-1 downto 0);
		Ibcont_int : out std_logic_vector(12-1 downto 0);
		Iccont_int : out std_logic_vector(12-1 downto 0);
		Vacont_int : out std_logic_vector(12-1 downto 0);
		Vbcont_int : out std_logic_vector(12-1 downto 0);
		Vccont_int : out std_logic_vector(12-1 downto 0);
		aclr : in std_logic;
		clk60KPLL : in std_logic
	);
end component mem_GN;

begin

mem_GN_0: if true generate
	inst_mem_GN_0: mem_GN
		port map(Clock => Clock, Iacont_int => Iacont_int, Ibcont_int => Ibcont_int, Iccont_int => Iccont_int, Vacont_int => Vacont_int, Vbcont_int => Vbcont_int, Vccont_int => Vccont_int, aclr => aclr, clk60KPLL => clk60KPLL);
end generate;

end architecture rtl;

