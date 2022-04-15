LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY pll IS
    PORT
    (
        inclk0    : IN STD_LOGIC  := '0';
        c0      	: OUT STD_LOGIC;
		  c1			: OUT STD_LOGIC
    );
END pll;


ARCHITECTURE SYN OF pll IS

    SIGNAL sub_wire0		: STD_LOGIC ;
	SIGNAL sub_wire1		: STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sub_wire2_bv	: BIT_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire2		: STD_LOGIC_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire3		: STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL sub_wire4		: STD_LOGIC ;
	SIGNAL sub_wire5		: STD_LOGIC ;


    COMPONENT altpll
    GENERIC (
        clk0_divide_by     	  : NATURAL;
        clk0_duty_cycle     	  : NATURAL;
        clk0_multiply_by        : NATURAL;
        clk0_phase_shift        : STRING;
		  clk1_divide_by			  : NATURAL;
		  clk1_duty_cycle			  : NATURAL;
		  clk1_multiply_by		  : NATURAL;
		  clk1_phase_shift		  : STRING;
        compensate_clock        : STRING;
        inclk0_input_frequency  : NATURAL;
        intended_device_family  : STRING;
        lpm_hint        		  : STRING;
        lpm_type        		  : STRING;
        operation_mode          : STRING
    );
    PORT (
            inclk   : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            clk 	  : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
    );
    END COMPONENT;

BEGIN
    sub_wire2_bv(0 DOWNTO 0) <= "0";
	 sub_wire2    <= To_stdlogicvector(sub_wire2_bv);
	 sub_wire0    <= inclk0;
	 sub_wire1    <= sub_wire2(0 DOWNTO 0) & sub_wire0;
	 sub_wire5    <= sub_wire3(1);
	 sub_wire4    <= sub_wire3(0);
	 c0    <= sub_wire4;
	 c1    <= sub_wire5;

    altpll_component : altpll
    GENERIC MAP (
        clk0_divide_by => 5,
        clk0_duty_cycle => 50,
        clk0_multiply_by => 12,
        clk0_phase_shift => "0",
		  clk1_divide_by => 5,
		  clk1_duty_cycle => 50,
		  clk1_multiply_by => 6,
		  clk1_phase_shift => "0",
        compensate_clock => "CLK0",
        inclk0_input_frequency => 20000,
        intended_device_family => "Cyclone IV E",
        lpm_hint => "CBX_MODULE_PREFIX=pll",
        lpm_type => "altpll",
        operation_mode => "NORMAL"
    )
    PORT MAP (
        inclk => sub_wire1,
        clk => sub_wire3
    );


END SYN;