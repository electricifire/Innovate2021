
module cpu (
	clk_clk,
	reset_reset_n,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	hps_0_h2f_reset_reset_n,
	hps_io_hps_io_emac1_inst_TX_CLK,
	hps_io_hps_io_emac1_inst_TXD0,
	hps_io_hps_io_emac1_inst_TXD1,
	hps_io_hps_io_emac1_inst_TXD2,
	hps_io_hps_io_emac1_inst_TXD3,
	hps_io_hps_io_emac1_inst_RXD0,
	hps_io_hps_io_emac1_inst_MDIO,
	hps_io_hps_io_emac1_inst_MDC,
	hps_io_hps_io_emac1_inst_RX_CTL,
	hps_io_hps_io_emac1_inst_TX_CTL,
	hps_io_hps_io_emac1_inst_RX_CLK,
	hps_io_hps_io_emac1_inst_RXD1,
	hps_io_hps_io_emac1_inst_RXD2,
	hps_io_hps_io_emac1_inst_RXD3,
	hps_io_hps_io_sdio_inst_CMD,
	hps_io_hps_io_sdio_inst_D0,
	hps_io_hps_io_sdio_inst_D1,
	hps_io_hps_io_sdio_inst_CLK,
	hps_io_hps_io_sdio_inst_D2,
	hps_io_hps_io_sdio_inst_D3,
	hps_io_hps_io_usb1_inst_D0,
	hps_io_hps_io_usb1_inst_D1,
	hps_io_hps_io_usb1_inst_D2,
	hps_io_hps_io_usb1_inst_D3,
	hps_io_hps_io_usb1_inst_D4,
	hps_io_hps_io_usb1_inst_D5,
	hps_io_hps_io_usb1_inst_D6,
	hps_io_hps_io_usb1_inst_D7,
	hps_io_hps_io_usb1_inst_CLK,
	hps_io_hps_io_usb1_inst_STP,
	hps_io_hps_io_usb1_inst_DIR,
	hps_io_hps_io_usb1_inst_NXT,
	hps_io_hps_io_uart0_inst_RX,
	hps_io_hps_io_uart0_inst_TX,
	sw_external_connection_export,
	led_external_connection_export,
	pvcurrent_external_connection_export,
	pvvoltage_external_connection_export,
	bacurrent_external_connection_export,
	bavoltage_external_connection_export,
	vgr_current_external_connection_export,
	vgs_current_external_connection_export,
	vgt_current_external_connection_export,
	vgr_voltage_external_connection_export,
	vgs_voltage_external_connection_export,
	vgt_voltage_external_connection_export,
	phase_external_connection_in_port,
	phase_external_connection_out_port);	

	input		clk_clk;
	input		reset_reset_n;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	output		hps_0_h2f_reset_reset_n;
	output		hps_io_hps_io_emac1_inst_TX_CLK;
	output		hps_io_hps_io_emac1_inst_TXD0;
	output		hps_io_hps_io_emac1_inst_TXD1;
	output		hps_io_hps_io_emac1_inst_TXD2;
	output		hps_io_hps_io_emac1_inst_TXD3;
	input		hps_io_hps_io_emac1_inst_RXD0;
	inout		hps_io_hps_io_emac1_inst_MDIO;
	output		hps_io_hps_io_emac1_inst_MDC;
	input		hps_io_hps_io_emac1_inst_RX_CTL;
	output		hps_io_hps_io_emac1_inst_TX_CTL;
	input		hps_io_hps_io_emac1_inst_RX_CLK;
	input		hps_io_hps_io_emac1_inst_RXD1;
	input		hps_io_hps_io_emac1_inst_RXD2;
	input		hps_io_hps_io_emac1_inst_RXD3;
	inout		hps_io_hps_io_sdio_inst_CMD;
	inout		hps_io_hps_io_sdio_inst_D0;
	inout		hps_io_hps_io_sdio_inst_D1;
	output		hps_io_hps_io_sdio_inst_CLK;
	inout		hps_io_hps_io_sdio_inst_D2;
	inout		hps_io_hps_io_sdio_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D0;
	inout		hps_io_hps_io_usb1_inst_D1;
	inout		hps_io_hps_io_usb1_inst_D2;
	inout		hps_io_hps_io_usb1_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D4;
	inout		hps_io_hps_io_usb1_inst_D5;
	inout		hps_io_hps_io_usb1_inst_D6;
	inout		hps_io_hps_io_usb1_inst_D7;
	input		hps_io_hps_io_usb1_inst_CLK;
	output		hps_io_hps_io_usb1_inst_STP;
	input		hps_io_hps_io_usb1_inst_DIR;
	input		hps_io_hps_io_usb1_inst_NXT;
	input		hps_io_hps_io_uart0_inst_RX;
	output		hps_io_hps_io_uart0_inst_TX;
	input	[2:0]	sw_external_connection_export;
	output	[2:0]	led_external_connection_export;
	input	[11:0]	pvcurrent_external_connection_export;
	input	[11:0]	pvvoltage_external_connection_export;
	input	[11:0]	bacurrent_external_connection_export;
	input	[11:0]	bavoltage_external_connection_export;
	input	[11:0]	vgr_current_external_connection_export;
	input	[11:0]	vgs_current_external_connection_export;
	input	[11:0]	vgt_current_external_connection_export;
	input	[11:0]	vgr_voltage_external_connection_export;
	input	[11:0]	vgs_voltage_external_connection_export;
	input	[11:0]	vgt_voltage_external_connection_export;
	input	[11:0]	phase_external_connection_in_port;
	output	[11:0]	phase_external_connection_out_port;
endmodule
