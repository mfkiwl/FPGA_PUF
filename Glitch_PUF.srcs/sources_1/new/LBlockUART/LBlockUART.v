module LBlockUART #(
	parameter		CLK_FRE				=	50,		// 50MHz
					BAUD_RATE			=	115200,	// 115200Hz
					TX_DATA_BYTE_WIDTH	=	18,		// 18 bytes to transmit
					RX_DATA_BYTE_WIDTH	=	8,		// 8 bytes to receive
					DATA_WIDTH			=	64,		// the bit width of data we stored in the FIFO
					DATA_DEPTH_INDEX	=	3		// the index_width of data unit(reg [DATA_WIDTH - 1:0])
) (
	input					clk			,
	input					rst_n		,
	input					uart_rx		,
	output					uart_tx		
);

	// uart_controller signals
	wire [(TX_DATA_BYTE_WIDTH << 3) - 1:0] tx_data;
	wire [(RX_DATA_BYTE_WIDTH << 3) - 1:0] rx_data;
	wire rx_rdy, tx_vld, rx_ack, FIFO_data_i_rdy;
	reg rx_rdy_delay;
	assign rx_ack = FIFO_data_i_rdy;

	// FIFO signals
	wire FIFO_data_i_vld, LBlock_Krdy, LBlock_Dvld;
	reg FIFO_r_en, FIFO_r_en_delay, FIFO_r_en_flag, LBlock_flag;
	wire [DATA_DEPTH_INDEX - 1:0] FIFO_head;
	wire [DATA_WIDTH - 1:0] FIFO_data_o, FIFO_data_i;
	assign FIFO_data_i = rx_data;
	// for FIFO data_i_vld hold just 1 cycle
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			rx_rdy_delay <= 1'b0;
			end
		else
			begin
			rx_rdy_delay <= rx_rdy;
			end
		end
	assign FIFO_data_i_vld = rx_rdy & ~rx_rdy_delay;		// just 1 cycle
	// FIFO_r_en_delay for LBlock_Krdy
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			FIFO_r_en_delay <= 1'b0;
			end
		else
			begin
			FIFO_r_en_delay <= FIFO_r_en;
			end
		end
	// when data_o_vld == 1'b1 and LBlock_Dvld is already 1'b1(don't start another AES), generate 1-cycle FIFO_r_en
	// data_o_vld means FIFO is not empty
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			LBlock_flag <= 1'b0;
			end
		else
			begin
			if (LBlock_Krdy)		// means start AES
				begin
				LBlock_flag <= 1'b1;
				end
			else if (LBlock_Dvld)	// means end AES
				begin
				LBlock_flag <= 1'b0;
				end
			else
				begin
				// do nothing
				end
			end
		end
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			FIFO_r_en_flag <= 1'b0;
			end
		else
			begin
			if (FIFO_data_o_vld && ~LBlock_flag && ~FIFO_r_en_flag)
				begin
				FIFO_r_en_flag <= 1'b1;
				end
			// unlock FIFO_r_En_flag
			else if (LBlock_flag)
				begin
				FIFO_r_en_flag <= 1'b0;
				end
			else
				begin
				// do nothing
				end
			end
		end
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			FIFO_r_en <= 1'b0;
			end
		else
			begin
			if (FIFO_data_o_vld && ~LBlock_flag && ~FIFO_r_en_flag)
				begin
				FIFO_r_en <= 1'b1;
				end
			else if (FIFO_r_en_flag)		// just 1-cycle
				begin
				FIFO_r_en <= 1'b0;
				end
			else
				begin
				// do nothing
				end
			end
		end

	// LBlock signals
	wire LBlock_Drdy;
	wire [63:0] LBlock_Din, LBlock_Dout;
	wire [79:0] LBlock_Kin;
	assign LBlock_Drdy = LBlock_Krdy;
	assign LBlock_Kin = 80'h01_23_45_67_89_ab_cd_ef_fe_dc;
	assign LBlock_Din = FIFO_data_o;
	assign LBlock_Krdy = FIFO_r_en_delay;
	assign tx_vld = FIFO_r_en;
	assign tx_data = {{FIFO_head, 76'h0}, LBlock_Din};

	// uart_controller
	uart_controller #(
		.CLK_FRE(CLK_FRE),
		.BAUD_RATE(BAUD_RATE),
		.TX_DATA_BYTE_WIDTH(TX_DATA_BYTE_WIDTH),
		.RX_DATA_BYTE_WIDTH(RX_DATA_BYTE_WIDTH)
	) m_uart_controller(
		.clk			(clk		),
		.rst_n			(rst_n		),
		.uart_rx		(uart_rx	),
		.uart_tx		(uart_tx	),

		// inner data
		.tx_data		(tx_data	),
		.tx_vld			(tx_vld		),
		.tx_rdy			(			),
		.rx_data		(rx_data	),
		.rx_ack			(rx_ack		),
		.rx_rdy			(rx_rdy		)
	);

	// FIFO
	FIFO #(
		.DATA_WIDTH(DATA_WIDTH),
		.DATA_DEPTH_INDEX(DATA_DEPTH_INDEX)
	) (
		.clk			(clk				),
		.rst_n			(rst_n				),

		.data_i			(FIFO_data_i		),
		.data_i_vld		(FIFO_data_i_vld	),
		.data_i_rdy		(FIFO_data_i_rdy	),

		.r_en			(FIFO_r_en			),
		.data_o			(FIFO_data_o		),
		.data_o_vld		(FIFO_data_o_vld	),		// not empty

		// for debug
		.FIFO_full		(					),
		.FIFO_head		(FIFO_head			)
	);

	// LBlock_Pack
	LBlock_Pack LBlock_Pack(
		.Kin			(LBlock_Kin			), 
		.Din			(LBlock_Din			), 
		.Dout			(LBlock_Dout		), 
		.Krdy			(LBlock_Krdy		), 
		.Drdy			(LBlock_Drdy		), 
		.EncDec			(1'b0				), 
		.RSTn			(rst_n				), 
		.EN				(1'b1				),
		.CLK			(clk				), 
		.BSY			(					), 
		.Kvld			(					), 
		.Dvld			(LBlock_Dvld		)
	);

endmodule
