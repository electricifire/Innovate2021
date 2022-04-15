library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_hps_sensor_memory is 
port(
		-- CLOCK 
		FPGA_CLK1_50 	: in 	std_logic;
		FPGA_CLK2_50 	: in 	std_logic;
		FPGA_CLK3_50 	: in 	std_logic;
		
--		-- HDMI
--	   HDMI_I2C_SCL	: inout 	std_logic;
--		HDMI_I2C_SDA	: inout 	std_logic;
--		HDMI_I2S			: inout 	std_logic;
--		HDMI_LRCLK		: inout 	std_logic;
--		HDMI_MCLK		: inout 	std_logic;
--		HDMI_SCLK		: inout 	std_logic;
--		HDMI_TX_CLK		: out 	std_logic;
--		HDMI_TX_D		: out 	std_logic_vector(23 downto 0);
--		HDMI_TX_DE		: out 	std_logic;
--		HDMI_TX_HS		: out		std_logic;
--		HDMI_TX_INT		: in 		std_logic;
--		HDMI_TX_VS		: out 	std_logic;

		-- HPS 
		HPS_CONV_USB_N		: inout 	std_logic;
		HPS_DDR3_ADDR		: out 	std_logic_vector(14 downto 0);
		HPS_DDR3_BA			: out 	std_logic_vector(2 downto 0);
		HPS_DDR3_CAS_N		: out 	std_logic;
		HPS_DDR3_CK_N		: out 	std_logic;
		HPS_DDR3_CK_P		: out 	std_logic;
		HPS_DDR3_CKE		: out 	std_logic;
		HPS_DDR3_CS_N		: out 	std_logic;
		HPS_DDR3_DM			: out 	std_logic_vector(3 downto 0);
		HPS_DDR3_DQ			: inout  std_logic_vector(31 downto 0);
		HPS_DDR3_DQS_N		: inout 	std_logic_vector(3 downto 0);
		HPS_DDR3_DQS_P		: inout	std_logic_vector(3 downto 0);
		HPS_DDR3_ODT		: out 	std_logic;
		HPS_DDR3_RAS_N		: out 	std_logic;
		HPS_DDR3_RESET_N	: out 	std_logic;
		HPS_DDR3_RZQ		: in 		std_logic;
		HPS_DDR3_WE_N		: out 	std_logic;
		HPS_ENET_GTX_CLK	: out 	std_logic;
		HPS_ENET_INT_N		: inout 	std_logic;
		HPS_ENET_MDC		: out 	std_logic;
		HPS_ENET_MDIO		: inout 	std_logic;
		HPS_ENET_RX_CLK	: in 		std_logic;
		HPS_ENET_RX_DATA	: in 		std_logic_vector(3 downto 0);
		HPS_ENET_RX_DV		: in 		std_logic;
		HPS_ENET_TX_DATA	: out 	std_logic_vector(3 downto 0);	
		HPS_ENET_TX_EN		: out 	std_logic;
		HPS_GSENSOR_INT	: inout 	std_logic;
		HPS_I2C0_SCLK		: inout	std_logic;
		HPS_I2C0_SDAT		: inout	std_logic;
		HPS_I2C1_SCLK		: inout	std_logic;
		HPS_I2C1_SDAT		: inout	std_logic;
		HPS_KEY				: inout	std_logic;
		HPS_LED				: inout	std_logic;
		HPS_LTC_GPIO		: inout	std_logic;
		HPS_SD_CLK			: out 	std_logic;	
		HPS_SD_CMD			: inout	std_logic;
		HPS_SD_DATA			: inout	std_logic_vector(3 downto 0);
		HPS_SPIM_CLK		: out 	std_logic;
		HPS_SPIM_MISO		: in 		std_logic;
		HPS_SPIM_MOSI		: out 	std_logic;
		HPS_SPIM_SS			: inout	std_logic;
		HPS_UART_RX			: in  	std_logic;
		HPS_UART_TX			: out 	std_logic;
		HPS_USB_CLKOUT		: in 		std_logic;
		HPS_USB_DATA		: inout	std_logic_vector(7 downto 0);
		HPS_USB_DIR			: in 		std_logic;	
		HPS_USB_NXT			: in 		std_logic;
		HPS_USB_STP			: out		std_logic;
		
		-- ANALIZADOR LOGICO 
		CLK_to_cpu					: out 	std_logic;
		Vacont_int_to_cpu			: out 	std_logic_vector(11 downto 0);
		
		-- KEY 
		KEY	: in 	std_logic_vector(1 downto 0);
	 
		-- LED
		LED 	: out std_logic_vector(7 downto 0);
		
		-- SW 
		SW		: in 	std_logic_vector(3 downto 0)
	 
--		-- RFS CARD INTERFACE SIGNALS 
--		LSENSOR_INT			: in 	 	std_logic;
--		LSENSOR_SCL 		: inout	std_logic;
--		LSENSOR_SDA			: inout	std_logic;
--		MPU_AD0_SDO			: inout	std_logic;
--		MPU_CS_n				: out 	std_logic;
--		MPU_FSYNC			: out 	std_logic;
--		MPU_INT				: in 	 	std_logic;
--		MPU_SCL_SCLK		: inout	std_logic;
--		MPU_SDA_SDI 		: inout	std_logic;
--		RH_TEMP_DRDY_n		: inout	std_logic;
--		RH_TEMP_I2C_SCL	: inout	std_logic;
--		RH_TEMP_I2C_SDA	: inout	std_logic;
--	 
--		-- UNUSED SIGNALS IN THIS DESIGN 
--		BT_KEY		 		: inout	std_logic;
--		BT_UART_RX			: in 	 	std_logic;
--		BT_UART_TX 			: out 	std_logic;
--		TMD_D					: inout	std_logic_vector(7 downto 0);
--		UART2USB_CTS		: in 	 	std_logic;
--		UART2USB_RTS		: out 	std_logic;
--		UART2USB_RX			: in 	 	std_logic;
--		UART2USB_TX			: out 	std_logic;
--		WIFI_EN				: out 	std_logic;
--		WIFI_RST_n			: out 	std_logic;
--		WIFI_UART0_CTS		: in 	 	std_logic;
--		WIFI_UART0_RTS		: out 	std_logic;
--		WIFI_UART0_RX		: in 	 	std_logic;
--		WIFI_UART0_TX		: out 	std_logic;
--		WIFI_UART1_RX		: in 	 	std_logic

);
end top_hps_sensor_memory;

architecture test of top_hps_sensor_memory is
--Zona de componentes

component cpu is
  port (
		clk_clk                         : in    std_logic                     := 'X';             -- clk
		reset_reset_n                   : in    std_logic                     := 'X';             -- reset_n
		memory_mem_a                    : out   std_logic_vector(14 downto 0);                    -- mem_a
		memory_mem_ba                   : out   std_logic_vector(2 downto 0);                     -- mem_ba
		memory_mem_ck                   : out   std_logic;                                        -- mem_ck
		memory_mem_ck_n                 : out   std_logic;                                        -- mem_ck_n
		memory_mem_cke                  : out   std_logic;                                        -- mem_cke
		memory_mem_cs_n                 : out   std_logic;                                        -- mem_cs_n
		memory_mem_ras_n                : out   std_logic;                                        -- mem_ras_n
		memory_mem_cas_n                : out   std_logic;                                        -- mem_cas_n
		memory_mem_we_n                 : out   std_logic;                                        -- mem_we_n
		memory_mem_reset_n              : out   std_logic;                                        -- mem_reset_n
		memory_mem_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
		memory_mem_dqs                  : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
		memory_mem_dqs_n                : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
		memory_mem_odt                  : out   std_logic;                                        -- mem_odt
		memory_mem_dm                   : out   std_logic_vector(3 downto 0);                     -- mem_dm
		memory_oct_rzqin                : in    std_logic                     := 'X';             -- oct_rzqin
		hps_0_h2f_reset_reset_n         : out   std_logic;                                        -- reset_n
		hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
		hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
		hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
		hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
		hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
		hps_io_hps_io_emac1_inst_RXD0   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
		hps_io_hps_io_emac1_inst_MDIO   : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
		hps_io_hps_io_emac1_inst_MDC    : out   std_logic;                                        -- hps_io_emac1_inst_MDC
		hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
		hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
		hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
		hps_io_hps_io_emac1_inst_RXD1   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
		hps_io_hps_io_emac1_inst_RXD2   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
		hps_io_hps_io_emac1_inst_RXD3   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
		hps_io_hps_io_sdio_inst_CMD     : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
		hps_io_hps_io_sdio_inst_D0      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
		hps_io_hps_io_sdio_inst_D1      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
		hps_io_hps_io_sdio_inst_CLK     : out   std_logic;                                        -- hps_io_sdio_inst_CLK
		hps_io_hps_io_sdio_inst_D2      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
		hps_io_hps_io_sdio_inst_D3      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
		hps_io_hps_io_usb1_inst_D0      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
		hps_io_hps_io_usb1_inst_D1      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
		hps_io_hps_io_usb1_inst_D2      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
		hps_io_hps_io_usb1_inst_D3      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
		hps_io_hps_io_usb1_inst_D4      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
		hps_io_hps_io_usb1_inst_D5      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
		hps_io_hps_io_usb1_inst_D6      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
		hps_io_hps_io_usb1_inst_D7      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
		hps_io_hps_io_usb1_inst_CLK     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
		hps_io_hps_io_usb1_inst_STP     : out   std_logic;                                        -- hps_io_usb1_inst_STP
		hps_io_hps_io_usb1_inst_DIR     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
		hps_io_hps_io_usb1_inst_NXT     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
		hps_io_hps_io_uart0_inst_RX     : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
		hps_io_hps_io_uart0_inst_TX     : out   std_logic;                                         -- hps_io_uart0_inst_TX
		led_external_connection_export  : out   std_logic_vector(2 downto 0);                     -- export
		sw_external_connection_export   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- export
		bacurrent_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		bavoltage_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		phase_external_connection_in_port      : in    std_logic_vector(11 downto 0) := (others => 'X'); -- in_port
		phase_external_connection_out_port     : out   std_logic_vector(11 downto 0);                    -- out_port
		pvcurrent_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		pvvoltage_external_connection_export   : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgr_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgr_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgs_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgs_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgt_current_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X'); -- export
		vgt_voltage_external_connection_export : in    std_logic_vector(11 downto 0) := (others => 'X')  -- export
  );
end component cpu;
 
component mem_GN is
	port (
		Vbcont_int : out std_logic_vector(11 downto 0);        -- Vbcont_int.wire
		Clock      : in  std_logic                     := '0'; --      Clock.clk
		aclr       : in  std_logic                     := '0'; --           .reset_n
		Ibcont_int : out std_logic_vector(11 downto 0);        -- Ibcont_int.wire
		clk60KPLL  : in  std_logic                     := '0'; --  clk60KPLL.wire
		Iccont_int : out std_logic_vector(11 downto 0);        -- Iccont_int.wire
		Iacont_int : out std_logic_vector(11 downto 0);        -- Iacont_int.wire
		Vacont_int : out std_logic_vector(11 downto 0);        -- Vacont_int.wire
		Vccont_int : out std_logic_vector(11 downto 0)         -- Vccont_int.wire
	);
end component mem_GN;
	
component pll is 
	port(
			inclk0				: in  std_logic := '0';
			c0 					: out std_logic;		-- 120MHz
			c1 					: out std_logic		-- 60MHz
	);
end component;

component timer is 
port(
			clk        :  in  std_logic;
			rst        :  in  std_logic;
	  		
		-- Señales de temporization --
			t_0		  :  out  std_logic;		-- lecture des ADC 
			t_1		  :  out  std_logic		-- Calcule des signals de commande	
);
end component;
	 
signal scount	: integer range 0 to 2500000 := 0;
signal sclk 	: std_logic; 
signal sled		: std_logic_vector(7 downto 0);
signal ssw		: std_logic_vector(2 downto 0);
    
signal CLK_4MHz : std_logic;
signal CLK_60MHZ 	: std_logic;
signal st_0		 	:	std_logic;
signal st_1		 	:	std_logic;

signal sIacont_int	: std_logic_vector(11 downto 0);
signal sIbcont_int	: std_logic_vector(11 downto 0);
signal sIccont_int	: std_logic_vector(11 downto 0);
signal sVacont_int	: std_logic_vector(11 downto 0);
signal sVbcont_int	: std_logic_vector(11 downto 0);
signal sVccont_int	: std_logic_vector(11 downto 0);

begin 

	LED(2 downto 0) <= sled(2 downto 0);
	ssw <= SW(2 downto 0);
	
	CLK_to_cpu			<= st_0;
	Vacont_int_to_cpu(0) <= FPGA_CLK1_50;
	Vacont_int_to_cpu(1) <= CLK_4MHz;
	

P1: pll PORT MAP (
				inclk0   => FPGA_CLK1_50,
				c0			=> CLK_4MHz,			-- CLK 500KHz
				c1       => CLK_60MHZ			-- CLK 60MHZ
);	
	

T1	:timer PORT MAP(
			clk	 	 => CLK_4MHz,
			rst	 	 => KEY(0),
			
		-- Señales de temporization --
			t_0		 => st_0,		--500Hz
			t_1		 => st_1
	);
	
P2 :mem_GN PORT MAP(		
			Clock 								 => FPGA_CLK1_50,			
			aclr 									 => KEY(0),
			clk60KPLL 							 => st_0,
			Iacont_int 							 => sIacont_int,
			Ibcont_int 							 => sIbcont_int,
			Iccont_int 							 => sIccont_int,
			Vacont_int 							 => sVacont_int,
			Vbcont_int 							 => sVbcont_int,
			Vccont_int 							 => sVccont_int	
);
	
U0 : component cpu
        port map (
		  
				-- CLK AND RESET
            clk_clk                         => FPGA_CLK1_50,                         --                     clk.clk
            reset_reset_n                   => KEY(0),                   --                   reset.reset_n
				
				--HPS DDR3
            memory_mem_a                    => HPS_DDR3_ADDR,                    --                  memory.mem_a
            memory_mem_ba                   => HPS_DDR3_BA,                   --                        .mem_ba
            memory_mem_ck                   => HPS_DDR3_CK_P,                   --                        .mem_ck
            memory_mem_ck_n                 => HPS_DDR3_CK_N,                 --                        .mem_ck_n
            memory_mem_cke                  => HPS_DDR3_CKE,                  --                        .mem_cke
            memory_mem_cs_n                 => HPS_DDR3_CS_N,                 --                        .mem_cs_n
            memory_mem_ras_n                => HPS_DDR3_RAS_N,                --                        .mem_ras_n
            memory_mem_cas_n                => HPS_DDR3_CAS_N,                --                        .mem_cas_n
            memory_mem_we_n                 => HPS_DDR3_WE_N,                 --                        .mem_we_n
            memory_mem_reset_n              => HPS_DDR3_RESET_N,              --                        .mem_reset_n
            memory_mem_dq                   => HPS_DDR3_DQ,                   --                        .mem_dq
            memory_mem_dqs                  => HPS_DDR3_DQS_P,                  --                        .mem_dqs
            memory_mem_dqs_n                => HPS_DDR3_DQS_N,                --                        .mem_dqs_n
            memory_mem_odt                  => HPS_DDR3_ODT,                  --                        .mem_odt
            memory_mem_dm                   => HPS_DDR3_DM,                   --                        .mem_dm
            memory_oct_rzqin                => HPS_DDR3_RZQ,                --                        .oct_rzqin
				
            hps_0_h2f_reset_reset_n         => open,         --         hps_0_h2f_reset.reset_n
            led_external_connection_export  => sled(2 downto 0),  -- led_external_connection.export
            sw_external_connection_export   => ssw(2 downto 0),   --  sw_external_connection.export
				phase_external_connection_in_port => std_logic_vector(to_unsigned(400,12)),
				phase_external_connection_out_port => open,
				pvcurrent_external_connection_export => std_logic_vector(to_unsigned(0,12)),
				pvvoltage_external_connection_export => std_logic_vector(to_unsigned(0,12)),
				vgr_current_external_connection_export => sIacont_int, 	--std_logic_vector(to_unsigned(70,12)),
				vgr_voltage_external_connection_export => sVacont_int,	--std_logic_vector(to_unsigned(200,12)),
				vgs_current_external_connection_export => sIbcont_int,	--std_logic_vector(to_unsigned(60,12)),
				vgs_voltage_external_connection_export => sVbcont_int,	--std_logic_vector(to_unsigned(300,12)),
				vgt_current_external_connection_export => sIccont_int,	--std_logic_vector(to_unsigned(10,12)),
				vgt_voltage_external_connection_export => sVccont_int,	--std_logic_vector(to_unsigned(250,12)),
				bacurrent_external_connection_export => std_logic_vector(to_unsigned(200,12)),
				bavoltage_external_connection_export => std_logic_vector(to_unsigned(600,12)),
				
				--HPS ETHERNET
            hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK, --                  hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),   --                        .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),   --                        .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),   --                        .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),   --                        .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),   --                        .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,   --                        .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,    --                        .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV, --                        .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN, --                        .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK, --                        .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),   --                        .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),   --                        .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),   --                        .hps_io_emac1_inst_RXD3
				
				--HPS SD CARD
            hps_io_hps_io_sdio_inst_CMD     => HPS_SD_CMD,     --                        .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0      => HPS_SD_DATA(0),      --                        .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1      => HPS_SD_DATA(1),      --                        .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK     => HPS_SD_CLK,     --                        .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2      => HPS_SD_DATA(2),      --                        .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3      => HPS_SD_DATA(3),      --                        .hps_io_sdio_inst_D3
				
				--HPS USB
            hps_io_hps_io_usb1_inst_D0      => HPS_USB_DATA(0),      --                        .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1      => HPS_USB_DATA(1),      --                        .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2      => HPS_USB_DATA(2),      --                        .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3      => HPS_USB_DATA(3),      --                        .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4      => HPS_USB_DATA(4),      --                        .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5      => HPS_USB_DATA(5),      --                        .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6      => HPS_USB_DATA(6),      --                        .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7      => HPS_USB_DATA(7),      --                        .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK     => HPS_USB_CLKOUT,     --                        .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP     => HPS_USB_STP,     --                        .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR     => HPS_USB_DIR,     --                        .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT     => HPS_USB_NXT,     --                        .hps_io_usb1_inst_NXT
				
				--HPS UART
            hps_io_hps_io_uart0_inst_RX     => HPS_UART_RX,     --                        .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX     => HPS_UART_TX      --                        .hps_io_uart0_inst_TX
        );

-- Indica que el sistema esta corriendo 10ms
toggle_led: process(FPGA_CLK1_50)
begin
	if((FPGA_CLK1_50'event and FPGA_CLK1_50 = '1')) then
		if (scount = 2500000) then  
			  scount <= 0;
			  sclk <= not sclk;
		 else
			  scount <= scount + 1;
		 end if;
	end if;
end process toggle_led;

	LED(7) <= sclk; 


end test;