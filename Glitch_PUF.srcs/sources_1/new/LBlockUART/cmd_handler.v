module cmd_handler #(
	parameter		CLK_FRE					=	50,		// 50MHz
					BAUD_RATE				=	115200,	// 115200Hz
					// granularity
					TX_DATA_BYTE_WIDTH		=	1,		// 1 bytes to transmit
					RX_DATA_BYTE_WIDTH		=	1,		// 1 bytes to receive
					DATA_WIDTH				=	8,		// the bit width of data we stored in the FIFO
					DATA_DEPTH_INDEX		=	5,		// the index_width of data unit(reg [DATA_WIDTH - 1:0])
					// buffer
					REQUEST_BUF_MAX			=	32,		// Request-buffer max 32 bytes
					RESPONSE_BUF_MAX		=	16		// Response-buffer max 16 bytes
	`define			TX_DATA_BIT_WIDTH		(TX_DATA_BYTE_WIDTH << 3)
	`define			RX_DATA_BIT_WIDTH		(RX_DATA_BYTE_WIDTH << 3)
	`define			REQUEST_BUF_MAX_BIT		(REQUEST_BUF_MAX << 3)
	`define			RESPONSE_BUF_MAX_BIT	(RESPONSE_BUF_MAX << 3)
) (
	input									clk			,
	input									rst_n		,
	input									uart_rx		,
	output									uart_tx		
);


	// PUF signals
	reg PUF_en;
	wire PUF_rdy;
	wire [7:0] PUF_Check;
	reg [63:0] PUF_challenge;
	wire [31:0] PUF_response;

	// LBlock signals
	wire LBlock_Dvld;
	reg LBlock_Drdy, LBlock_EncDec;
	wire [7:0] LBlock_Check;
	reg [63:0] LBlock_Din;
	wire [63:0] LBlock_Dout;
	reg [79:0] LBlock_Kin;

	// uart_controller signals
	wire tx_rdy, rx_rdy;
	reg rx_ack, tx_vld;
	(*mark_debug = "true"*)wire debug_tx_vld = tx_vld;
	reg [`TX_DATA_BIT_WIDTH - 1:0] tx_data;
	wire [`RX_DATA_BIT_WIDTH - 1:0] rx_data;
	(*mark_debug = "true"*)wire [`TX_DATA_BIT_WIDTH - 1:0] debug_tx_data = tx_data;
	generate
		begin
		if (TX_DATA_BYTE_WIDTH == 1 && RX_DATA_BYTE_WIDTH == 1)
			begin
			// uart_controller8bit
			uart_controller8bit #(
				.CLK_FRE(CLK_FRE),		// 50MHz
				.BAUD_RATE(BAUD_RATE)	// 115200Hz
			) m_uart_controller8bit (
				.clk			(clk		),
				.rst_n			(rst_n		),
				.uart_rx		(uart_rx	),
				.uart_tx		(uart_tx	),

				// inner data
				.tx_data		(tx_data	),		// data
				.tx_vld			(tx_vld		),		// start the transmit process
				.tx_rdy			(tx_rdy		),		// transmit process complete
				.rx_data		(rx_data	),		// data
				.rx_ack			(rx_ack		),		// data is received by receiver buffer					(RX_WAIT)
				.rx_rdy			(rx_rdy		)	// send signal to receiver buffer that data is ready
			);
			end
		else
			begin
			// uart_controller
			uart_controller #(
				.CLK_FRE(CLK_FRE),								// 50MHz
				.BAUD_RATE(BAUD_RATE),							// 115200Hz
				.TX_DATA_BYTE_WIDTH(TX_DATA_BYTE_WIDTH),		// bytes to transmit
				.RX_DATA_BYTE_WIDTH(RX_DATA_BYTE_WIDTH)			// bytes to receive
			) m_uart_controller (
				.clk			(clk		),
				.rst_n			(rst_n		),
				.uart_rx		(uart_rx	),
				.uart_tx		(uart_tx	),

				// inner data
				.tx_data		(tx_data	),		// data
				.tx_vld			(tx_vld		),		// start the transmit process
				.tx_rdy			(tx_rdy		),		// transmit process complete
				.rx_data		(rx_data	),		// data
				.rx_ack			(rx_ack		),		// data is received by receiver buffer					(RX_WAIT)
				.rx_rdy			(rx_rdy		)		// send signal to receiver buffer that data is ready
			);
			end
		end
	endgenerate

	localparam		CMD_RX_IDLE		=	3'b000,
					CMD_RX_WRITE	=	3'b001,
					CMD_RX_WTDATA	=	3'b010,
					CMD_RX_SKIP		=	3'b011,
					CMD_RX_SKIPWT	=	3'b100,
					CMD_RD_IDLE		=	3'b000,
					CMD_RD_LENG		=	3'b001,
					CMD_RD_COMBDATA	=	3'b010,
					CMD_RD_GETDATA	=	3'b011,
					CMD_RD_WAITEXC	=	3'b100,
					CMD_TX_IDLE		=	2'b00,
					CMD_TX_LENG		=	2'b01,
					CMD_TX_WTSEND	=	2'b10,
					CMD_TX_GETDATA	=	2'b11,
					CMD_WR_IDLE		=	2'b00,
					CMD_WR_ADDCHECK	=	2'b01,
					CMD_WR_WRDATA	=	2'b10,
					CMD_WR_GETDATA	=	2'b11;

	reg [`RX_DATA_BIT_WIDTH - 1:0] rx_packet_cnt;
	reg [`RX_DATA_BIT_WIDTH - 1:0] rx_packet_leng;
	reg [`RX_DATA_BIT_WIDTH - 1:0] rd_packet_cnt;
	reg [`RX_DATA_BIT_WIDTH - 1:0] rd_packet_leng;
	reg [`TX_DATA_BIT_WIDTH - 1:0] wr_packet_cnt;
	reg [`TX_DATA_BIT_WIDTH - 1:0] wr_packet_leng;
	reg [`TX_DATA_BIT_WIDTH - 1:0] tx_packet_cnt;
	reg [`TX_DATA_BIT_WIDTH - 1:0] tx_packet_leng;

	/**************************/
	/*        REQUEST         */
	/**************************/
	// request_FIFO
	reg request_FIFO_data_i_vld, request_FIFO_r_en;
	(*mark_debug = "true"*)wire debug_request_FIFO_r_en = request_FIFO_r_en;
	wire request_FIFO_data_i_rdy, request_FIFO_data_o_vld;
	wire request_FIFO_FIFO_full, request_FIFO_FIFO_empty;
	wire [DATA_DEPTH_INDEX - 1:0] request_FIFO_FIFO_surplus;
	wire [DATA_WIDTH - 1:0] request_FIFO_data_i, request_FIFO_data_o;
	FIFO #(
		.DATA_WIDTH(DATA_WIDTH),				// the bit width of data we stored in the FIFO
		.DATA_DEPTH_INDEX(DATA_DEPTH_INDEX)		// the index_width of data unit(reg [DATA_WIDTH - 1:0])
	) m_request_FIFO (
		.clk			(clk						),
		.rst_n			(rst_n						),

		.data_i			(request_FIFO_data_i		),
		.data_i_vld		(request_FIFO_data_i_vld	),
		.data_i_rdy		(request_FIFO_data_i_rdy	),

		.r_en			(request_FIFO_r_en			),
		.data_o			(request_FIFO_data_o		),
		.data_o_vld		(request_FIFO_data_o_vld	),

		// for debug
		.FIFO_full		(request_FIFO_FIFO_full		),
		.FIFO_empty		(request_FIFO_FIFO_empty	),
		.FIFO_surplus	(request_FIFO_FIFO_surplus	)
	);
	assign request_FIFO_data_i = rx_data;

	// request_FIFO_cmdnum
	reg [DATA_DEPTH_INDEX - 1:0] request_FIFO_cmdnum;
	(*mark_debug = "true"*)wire [DATA_DEPTH_INDEX - 1:0] debug_request_FIFO_cmdnum = request_FIFO_cmdnum;
	reg request_FIFO_cmdnum_plus1, request_FIFO_cmdnum_minus1;
	always@ (negedge clk)
		begin
		if (!rst_n)
			begin
			request_FIFO_cmdnum <= {DATA_DEPTH_INDEX{1'b0}};
			end
		else
			begin
			if (request_FIFO_cmdnum_plus1 && request_FIFO_cmdnum_minus1)
				begin
				// do nothing
				end
			else if (request_FIFO_cmdnum_plus1)
				begin
				request_FIFO_cmdnum <= request_FIFO_cmdnum + 1'b1;
				end
			else if (request_FIFO_cmdnum_minus1)
				begin
				request_FIFO_cmdnum <= request_FIFO_cmdnum - 1'b1;
				end
			else
				begin
				// do nothing
				end
			end
		end

	// request-receiver state-machine
	reg [2:0] cmdrstate;
	reg cmdrstate_cnt;
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			// state
			cmdrstate <= CMD_RX_IDLE;
			// output
			request_FIFO_cmdnum_plus1 <= 1'b0;
			rx_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
			rx_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
			request_FIFO_data_i_vld <= 1'b0;
			rx_ack <= 1'b0;
			// inner signals
			cmdrstate_cnt <= 1'b0;
			end
		else
			begin
			case (cmdrstate)
				CMD_RX_IDLE:
					begin
					if (rx_rdy)
						begin
						rx_packet_leng <= rx_data;
						rx_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
						if (rx_data < request_FIFO_FIFO_surplus)		// can hold this packet
							begin
							// state
							cmdrstate <= CMD_RX_WRITE;
							// output
							request_FIFO_data_i_vld <= 1'b1;
							rx_ack <= 1'b1;
							// inner signals
							cmdrstate_cnt <= 1'b0;
							end
						else
							begin
							// state
							cmdrstate <= CMD_RX_SKIP;
							// output
							request_FIFO_data_i_vld <= 1'b0;			// not write FIFO
							rx_ack <= 1'b1;								// just skip
							// inner signals
							cmdrstate_cnt <= 1'b0;
							end
						end
					else
						begin
						// output
						request_FIFO_cmdnum_plus1 <= 1'b0;
						rx_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
						rx_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
						request_FIFO_data_i_vld <= 1'b0;
						rx_ack <= 1'b0;
						end
					end
				CMD_RX_WRITE:
					begin
					// output
					rx_ack <= 1'b0;
					request_FIFO_data_i_vld <= 1'b0;
					if (cmdrstate_cnt)
						begin
						if (rx_packet_cnt == rx_packet_leng)
							begin
							// state 
							cmdrstate <= CMD_RX_IDLE;
							// output
							request_FIFO_cmdnum_plus1 <= 1'b1;
							end
						else
							begin
							// state 
							cmdrstate <= CMD_RX_WTDATA;
							end
						end
					else
						begin
						cmdrstate_cnt <= cmdrstate_cnt + 1'b1;
						end
					end
				CMD_RX_WTDATA:
					begin
					if (rx_rdy)
						begin
						// state
						cmdrstate <= CMD_RX_WRITE;
						// output
						request_FIFO_cmdnum_plus1 <= 1'b0;
						rx_packet_cnt <= rx_packet_cnt + 1'b1;
						request_FIFO_data_i_vld <= 1'b1;
						rx_ack <= 1'b1;
						// inner signals
						cmdrstate_cnt <= 1'b0;
						end
					else
						begin
						// output
						request_FIFO_cmdnum_plus1 <= 1'b0;
						request_FIFO_data_i_vld <= 1'b0;
						rx_ack <= 1'b0;
						end
					end
				CMD_RX_SKIP:
					begin
					// output
					request_FIFO_cmdnum_plus1 <= 1'b0;
					request_FIFO_data_i_vld <= 1'b0;
					rx_ack <= 1'b0;
					if (cmdrstate_cnt)
						begin
						// state 
						cmdrstate <= CMD_RX_SKIPWT;
						end
					else
						begin
						cmdrstate_cnt <= cmdrstate_cnt + 1'b1;
						end
					end
				CMD_RX_SKIPWT:
					begin
					if (rx_rdy)
						begin
						// output
						request_FIFO_cmdnum_plus1 <= 1'b0;
						request_FIFO_data_i_vld <= 1'b0;
						rx_ack <= 1'b1;
						if (rx_packet_cnt == rx_packet_leng - 1'b1)			// this is the last one
							begin
							// statet 
							cmdrstate <= CMD_RX_IDLE;
							// output
							rx_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
							rx_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
							end
						else
							begin
							// state
							cmdrstate <= CMD_RX_SKIP;
							// output
							rx_packet_cnt <= rx_packet_cnt + 1'b1;
							// inner signals
							cmdrstate_cnt <= 1'b0;
							end
						end
					else
						begin
						// output
						request_FIFO_cmdnum_plus1 <= 1'b0;
						request_FIFO_data_i_vld <= 1'b0;
						rx_ack <= 1'b0;
						end
					end
				default:
					begin
					// state
					cmdrstate <= CMD_RX_IDLE;
					// output
					request_FIFO_cmdnum_plus1 <= 1'b0;
					rx_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
					rx_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
					request_FIFO_data_i_vld <= 1'b0;
					rx_ack <= 1'b0;
					end
			endcase
			end
		end

	// request-handler state-machine
	reg [2:0] cmdestate;
	(*mark_debug = "true"*)wire [2:0] debug_cmdestate = cmdestate;
	reg [`REQUEST_BUF_MAX_BIT - 1:0] request_buffer;
	reg cmdestate_cnt;
	reg [3:0] cmdestate_waitexc_cnt;
	reg [7:0] request_check;
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			// state
			cmdestate <= CMD_RD_IDLE;
			// output
			PUF_en <= 1'b0;
			PUF_challenge <= 64'b0;
			LBlock_Drdy <= 1'b0;
			LBlock_EncDec <= 1'b0;
			LBlock_Din <= 64'b0;
			LBlock_Kin <= 80'b0;
			request_FIFO_r_en <= 1'b0;
			request_FIFO_cmdnum_minus1 <= 1'b0;
			rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
			rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
			// inner signals
			cmdestate_cnt <= 1'b0;
			request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
			request_check <= 8'b0;
			cmdestate_waitexc_cnt <= 4'b0;
			end
		else
			begin
			case (cmdestate)
				CMD_RD_IDLE:
					begin
					if (request_FIFO_cmdnum != {DATA_DEPTH_INDEX{1'b0}})
						begin
						// state
						cmdestate <= CMD_RD_LENG;
						// output
						PUF_en <= 1'b0;
						PUF_challenge <= 64'b0;
						LBlock_Drdy <= 1'b0;
						LBlock_EncDec <= 1'b0;
						LBlock_Din <= 64'b0;
						LBlock_Kin <= 80'b0;
						request_FIFO_r_en <= 1'b1;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
						rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdestate_cnt <= 1'b0;
						request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
						request_check <= 8'b0;
						end
					else
						begin
						// output
						PUF_en <= 1'b0;
						PUF_challenge <= 64'b0;
						LBlock_Drdy <= 1'b0;
						LBlock_EncDec <= 1'b0;
						LBlock_Din <= 64'b0;
						LBlock_Kin <= 80'b0;
						request_FIFO_r_en <= 1'b0;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
						rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdestate_cnt <= 1'b0;
						request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
						request_check <= 8'b0;
						end
					end
				CMD_RD_LENG:
					begin
					if (cmdestate_cnt)
						begin
						// state
						cmdestate <= CMD_RD_GETDATA;
						// output
						PUF_en <= 1'b0;
						PUF_challenge <= 64'b0;
						LBlock_Drdy <= 1'b0;
						LBlock_EncDec <= 1'b0;
						LBlock_Din <= 64'b0;
						LBlock_Kin <= 80'b0;
						request_FIFO_r_en <= 1'b1;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
						rd_packet_leng <= request_FIFO_data_o;
						// inner signals
						cmdestate_cnt <= 1'b0;
						request_buffer[`REQUEST_BUF_MAX_BIT - 1:`REQUEST_BUF_MAX_BIT - 8] <= request_FIFO_data_o;
						request_check <= 8'b0;
						end
					else
						begin
						// output
						request_FIFO_r_en <= 1'b0;
						// inner signals
						cmdestate_cnt <= cmdestate_cnt + 1'b1;
						end
					end
				CMD_RD_COMBDATA:
					begin
					if (rd_packet_cnt == rd_packet_leng)		// buffer is ready
						begin
						// state
						cmdestate <= CMD_RD_WAITEXC;
						cmdestate_waitexc_cnt <= 4'b0;
						// output
						if (request_buffer[`REQUEST_BUF_MAX_BIT - 9:`REQUEST_BUF_MAX_BIT - 16] == 8'h55)		// Enc
							begin
							PUF_en <= 1'b0;
							PUF_challenge <= 64'b0;
							LBlock_Drdy <= (request_check == 8'b0);		// check ok
							LBlock_EncDec <= 1'b0;		// Enc
							LBlock_Din <= request_buffer[`REQUEST_BUF_MAX_BIT - 17:`REQUEST_BUF_MAX_BIT - 80];
							LBlock_Kin <= request_buffer[`REQUEST_BUF_MAX_BIT - 81:`REQUEST_BUF_MAX_BIT - 160];
							request_FIFO_r_en <= 1'b0;
							request_FIFO_cmdnum_minus1 <= 1'b1;
							rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
							rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
							// inner signals
							cmdestate_cnt <= 1'b0;
							request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
							request_check <= 8'b0;
							end
						else if (request_buffer[`REQUEST_BUF_MAX_BIT - 9:`REQUEST_BUF_MAX_BIT - 16] == 8'haa)	// challenge
							begin
							PUF_en <= (request_check == 8'b0);
							PUF_challenge <= request_buffer[`REQUEST_BUF_MAX_BIT - 17:`REQUEST_BUF_MAX_BIT - 80];
							LBlock_Drdy <= 1'b0;
							LBlock_EncDec <= 1'b0;
							LBlock_Din <= 64'b0;
							LBlock_Kin <= 80'b0;
							request_FIFO_r_en <= 1'b0;
							request_FIFO_cmdnum_minus1 <= 1'b1;
							rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
							rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
							// inner signals
							cmdestate_cnt <= 1'b0;
							request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
							request_check <= 8'b0;
							end
						else
							begin
							// output
							PUF_en <= 1'b0;
							PUF_challenge <= 64'b0;
							LBlock_Drdy <= 1'b0;
							LBlock_EncDec <= 1'b0;
							LBlock_Din <= 64'b0;
							LBlock_Kin <= 80'b0;
							request_FIFO_r_en <= 1'b0;
							request_FIFO_cmdnum_minus1 <= 1'b1;
							rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
							rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
							// inner signals
							cmdestate_cnt <= 1'b0;
							request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
							request_check <= 8'b0;
							end
						end
					else
						begin
						// state
						cmdestate <= CMD_RD_GETDATA;
						// output
						PUF_en <= 1'b0;
						PUF_challenge <= 64'b0;
						LBlock_Drdy <= 1'b0;
						LBlock_EncDec <= 1'b0;
						LBlock_Din <= 64'b0;
						LBlock_Kin <= 80'b0;
						request_FIFO_r_en <= 1'b1;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						// inner signals
						cmdestate_cnt <= 1'b0;
						end
					end
				CMD_RD_GETDATA:
					begin
					if (cmdestate_cnt)
						begin
						// state
						cmdestate <= CMD_RD_COMBDATA;
						// output
						PUF_en <= 1'b0;
						PUF_challenge <= 64'b0;
						LBlock_Drdy <= 1'b0;
						LBlock_EncDec <= 1'b0;
						LBlock_Din <= 64'b0;
						LBlock_Kin <= 80'b0;
						request_FIFO_r_en <= 1'b0;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						rd_packet_cnt <= rd_packet_cnt + 1'b1;
						// inner signals
						cmdestate_cnt <= 1'b0;
						// request_buffer[`REQUEST_BUF_MAX_BIT - 1:`REQUEST_BUF_MAX_BIT - (rd_packet_leng << 3) - 8] <= {request_buffer[`REQUEST_BUF_MAX_BIT - 9:`REQUEST_BUF_MAX_BIT - (rd_packet_leng << 3) - 8], request_FIFO_data_o};
						if (rd_packet_leng == 8'h14)
							begin
							request_buffer[`REQUEST_BUF_MAX_BIT - 1:`REQUEST_BUF_MAX_BIT - (20 << 3) - 8] <= {request_buffer[`REQUEST_BUF_MAX_BIT - 9:`REQUEST_BUF_MAX_BIT - (20 << 3) - 8], request_FIFO_data_o};
							end
						else if (rd_packet_leng == 8'h0a)
							begin
							request_buffer[`REQUEST_BUF_MAX_BIT - 1:`REQUEST_BUF_MAX_BIT - (10 << 3) - 8] <= {request_buffer[`REQUEST_BUF_MAX_BIT - 9:`REQUEST_BUF_MAX_BIT - (10 << 3) - 8], request_FIFO_data_o};
							end
						if (rd_packet_cnt > {`RX_DATA_BIT_WIDTH{1'b0}})		// skip func code
							begin
							request_check <= request_check ^ request_FIFO_data_o;
							end
						else
							begin
							request_check <= 8'b0;
							end
						end
					else
						begin
						// output
						request_FIFO_r_en <= 1'b0;
						request_FIFO_cmdnum_minus1 <= 1'b0;
						// inner signals
						cmdestate_cnt <= cmdestate_cnt + 1'b1;
						end
					end
				CMD_RD_WAITEXC:
					begin
					if (cmdestate_waitexc_cnt == 4'b0010)
						begin
						// state
						cmdestate <= CMD_RD_IDLE;
						end
					else
						begin
						// do nothing
						cmdestate_waitexc_cnt <= cmdestate_waitexc_cnt + 1'b1;
						end
					// output
					PUF_en <= 1'b0;
					LBlock_Drdy <= 1'b0;
					request_FIFO_r_en <= 1'b0;
					request_FIFO_cmdnum_minus1 <= 1'b0;
					rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
					rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
					// inner signals
					cmdestate_cnt <= 1'b0;
					request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
					request_check <= 8'b0;
					end
				default:
					begin
					// state
					cmdestate <= CMD_RD_IDLE;
					// output
					PUF_en <= 1'b0;
					PUF_challenge <= 64'b0;
					LBlock_Drdy <= 1'b0;
					LBlock_EncDec <= 1'b0;
					LBlock_Din <= 64'b0;
					LBlock_Kin <= 80'b0;
					request_FIFO_r_en <= 1'b0;
					request_FIFO_cmdnum_minus1 <= 1'b0;
					rd_packet_cnt <= {`RX_DATA_BIT_WIDTH{1'b0}};
					rd_packet_leng <= {`RX_DATA_BIT_WIDTH{1'b0}};
					// inner signals
					cmdestate_cnt <= 1'b0;
					request_buffer <= {`REQUEST_BUF_MAX_BIT{1'b0}};
					request_check <= 8'b0;
					end
			endcase
			end
		end


	/**************************/
	/*       RESPOMNSE        */
	/**************************/
	// response_FIFO
	reg response_FIFO_data_i_vld, response_FIFO_r_en;
	(*mark_debug = "true"*)wire debug_response_FIFO_r_en = response_FIFO_r_en;
	wire response_FIFO_data_i_rdy, response_FIFO_data_o_vld;
	wire response_FIFO_FIFO_full, response_FIFO_FIFO_empty;
	wire [DATA_DEPTH_INDEX - 1:0] response_FIFO_FIFO_surplus;
	wire [DATA_WIDTH - 1:0] response_FIFO_data_i;
	wire [DATA_WIDTH - 1:0] response_FIFO_data_o;
	FIFO #(
		.DATA_WIDTH(DATA_WIDTH),				// the bit width of data we stored in the FIFO
		.DATA_DEPTH_INDEX(DATA_DEPTH_INDEX)		// the index_width of data unit(reg [DATA_WIDTH - 1:0])
	) m_response_FIFO (
		.clk			(clk						),
		.rst_n			(rst_n						),

		.data_i			(response_FIFO_data_i		),
		.data_i_vld		(response_FIFO_data_i_vld	),
		.data_i_rdy		(response_FIFO_data_i_rdy	),

		.r_en			(response_FIFO_r_en			),
		.data_o			(response_FIFO_data_o		),
		.data_o_vld		(response_FIFO_data_o_vld	),

		// for debug
		.FIFO_full		(response_FIFO_FIFO_full		),
		.FIFO_empty		(response_FIFO_FIFO_empty	),
		.FIFO_surplus	(response_FIFO_FIFO_surplus	)
	);

	// response_FIFO_cmdnum
	reg [DATA_DEPTH_INDEX - 1:0] response_FIFO_cmdnum;
	(*mark_debug = "true"*)wire [DATA_DEPTH_INDEX - 1:0] debug_response_FIFO_cmdnum = response_FIFO_cmdnum;
	reg response_FIFO_cmdnum_plus1, response_FIFO_cmdnum_minus1;
	always@ (negedge clk)
		begin
		if (!rst_n)
			begin
			response_FIFO_cmdnum <= {DATA_DEPTH_INDEX{1'b0}};
			end
		else
			begin
			if (response_FIFO_cmdnum_plus1 && response_FIFO_cmdnum_minus1)
				begin
				// do nothing
				end
			else if (response_FIFO_cmdnum_plus1)
				begin
				response_FIFO_cmdnum <= response_FIFO_cmdnum + 1'b1;
				end
			else if (response_FIFO_cmdnum_minus1)
				begin
				response_FIFO_cmdnum <= response_FIFO_cmdnum - 1'b1;
				end
			else
				begin
				// do nothing
				end
			end
		end

	// response-handler state-machine
	reg [1:0] cmdrestate;
	reg [`RESPONSE_BUF_MAX_BIT - 1:0] response_buffer;
	reg cmdrestate_cnt;
	reg [7:0] response_check;
	assign response_FIFO_data_i = response_buffer[`RESPONSE_BUF_MAX_BIT - 1:`RESPONSE_BUF_MAX_BIT - 8];
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			// state
			cmdrestate <= CMD_RD_IDLE;
			// output
			response_FIFO_data_i_vld <= 1'b0;
			response_FIFO_cmdnum_plus1 <= 1'b0;
			wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
			wr_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
			// inner signals
			cmdrestate_cnt <= 1'b0;
			response_buffer <= {`RESPONSE_BUF_MAX_BIT{1'b0}};
			response_check <= 8'b0;
			end
		else
			begin
			case (cmdrestate)
				CMD_WR_IDLE:
					begin
					if (PUF_rdy)
						begin
						// state
						cmdrestate <= CMD_WR_ADDCHECK;
						// output
						response_FIFO_data_i_vld <= 1'b0;
						response_FIFO_cmdnum_plus1 <= 1'b0;
						wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						wr_packet_leng <= 8'h06;		// didn't use macro, need to modify
						// inner signals
						cmdrestate_cnt <= 1'b0;
						response_buffer[`RESPONSE_BUF_MAX_BIT - 1:`RESPONSE_BUF_MAX_BIT - 56] <= {8'h06, 8'haa, PUF_response, PUF_Check};
						response_check <= PUF_response[31:24] ^ PUF_response[23:16] ^ PUF_response[15:8] ^ PUF_response[7:0];
						end
					else if (LBlock_Dvld)
						begin
						// state
						cmdrestate <= CMD_WR_ADDCHECK;
						// output
						response_FIFO_data_i_vld <= 1'b0;
						response_FIFO_cmdnum_plus1 <= 1'b0;
						wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						wr_packet_leng <= 8'h0a;		// didn't use macro, need to modify
						// inner signals
						cmdrestate_cnt <= 1'b0;
						response_buffer[`RESPONSE_BUF_MAX_BIT - 1:`RESPONSE_BUF_MAX_BIT - 88] <= {8'h0a, 8'h55, LBlock_Dout, LBlock_Check};
						// response_check <= LBlock_Dout[63:56] ^ LBlock_Dout[55:48] ^ LBlock_Dout[47:40] ^ LBlock_Dout[39:32] ^ LBlock_Dout[31:24] ^ LBlock_Dout[23:16] ^ LBlock_Dout[15:8] ^ LBlock_Dout[7:0];
						end
					else
						begin
						// state
						cmdrestate <= CMD_RD_IDLE;
						// output
						response_FIFO_data_i_vld <= 1'b0;
						response_FIFO_cmdnum_plus1 <= 1'b0;
						wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						wr_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdrestate_cnt <= 1'b0;
						response_buffer <= {`RESPONSE_BUF_MAX_BIT{1'b0}};
						response_check <= 8'b0;
						end
					end
				CMD_WR_ADDCHECK:
					begin
					// state
					cmdrestate <= CMD_WR_GETDATA;
					// inner signals
					/*if (wr_packet_leng == 8'h0a)
						begin
						// response_buffer[`RESPONSE_BUF_MAX_BIT - (10 << 3) - 1, `RESPONSE_BUF_MAX_BIT - (10 << 3) - 8] <= response_check;
						response_buffer[`RESPONSE_BUF_MAX_BIT - 81, `RESPONSE_BUF_MAX_BIT - 88] <= response_check;
						end
					else if (wr_packet_leng == 8'h06)
						begin
						// response_buffer[`RESPONSE_BUF_MAX_BIT - (6 << 3) - 1, `RESPONSE_BUF_MAX_BIT - (6 << 3) - 8] <= response_check;
						response_buffer[`RESPONSE_BUF_MAX_BIT - 49, `RESPONSE_BUF_MAX_BIT - 56] <= response_check;
						end*/
					end
				CMD_WR_GETDATA:
					begin
					// state
					cmdrestate <= CMD_WR_WRDATA;
					// output
					response_FIFO_data_i_vld <= 1'b1;
					response_FIFO_cmdnum_plus1 <= 1'b0;
					wr_packet_cnt <= wr_packet_cnt + 1'b1;
					// inner signals
					response_check <= 8'b0;
					end
				CMD_WR_WRDATA:
					begin
					// output
					response_FIFO_data_i_vld <= 1'b0;
					// inner signals
					response_check <= 8'b0;
					if (wr_packet_cnt == wr_packet_leng + 1'b1)
						begin
						// state
						cmdrestate <= CMD_WR_IDLE;
						// output
						response_FIFO_cmdnum_plus1 <= 1'b1;
						wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						response_buffer <= {`RESPONSE_BUF_MAX_BIT{1'b0}};
						end
					else
						begin
						// state
						cmdrestate <= CMD_WR_GETDATA;
						// output
						response_FIFO_cmdnum_plus1 <= 1'b0;
						// inner signals
						response_buffer <= {response_buffer[`RESPONSE_BUF_MAX_BIT - 9:0], 8'b0};
						end
					end
				default:
					begin
					// state
					cmdrestate <= CMD_RD_IDLE;
					// output
					response_FIFO_data_i_vld <= 1'b0;
					response_FIFO_cmdnum_plus1 <= 1'b0;
					wr_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
					wr_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
					// inner signals
					cmdrestate_cnt <= 1'b0;
					response_buffer <= {`RESPONSE_BUF_MAX_BIT{1'b0}};
					response_check <= 8'b0;
					end
			endcase
			end
		end

	// response-transmitor state-machine
	reg [1:0] cmdtstate;
	(*mark_debug = "true"*)wire [1:0] debug_cmdtstate = cmdtstate;
	reg cmdtstate_cnt;
	always@ (posedge clk)
		begin
		if (!rst_n)
			begin
			// state
			cmdtstate <= CMD_TX_IDLE;
			// output
			tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
			tx_vld <= 1'b0;
			response_FIFO_r_en <= 1'b0;
			response_FIFO_cmdnum_minus1 <= 1'b0;
			tx_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
			tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
			// inner signals
			cmdtstate_cnt <= 1'b0;
			end
		else
			begin
			case (cmdtstate)
				CMD_TX_IDLE:
					begin
					if (response_FIFO_cmdnum != {DATA_DEPTH_INDEX{1'b0}})		// start tx
						begin
						// state
						cmdtstate <= CMD_TX_LENG;
						// output
						tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
						tx_vld <= 1'b0;
						response_FIFO_r_en <= 1'b1;		// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						tx_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
						tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdtstate_cnt <= 1'b0;
						end
					else
						begin
						// output
						tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
						tx_vld <= 1'b0;
						response_FIFO_r_en <= 1'b0;		// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						tx_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
						tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdtstate_cnt <= 1'b0;
						end
					end
				CMD_TX_LENG:
					begin
					if (cmdtstate_cnt)
						begin
						// state
						cmdtstate <= CMD_TX_WTSEND;
						// output
						tx_data <= response_FIFO_data_o;
						tx_vld <= 1'b1;
						response_FIFO_r_en <= 1'b0;		// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						tx_packet_leng <= response_FIFO_data_o;
						tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
						// inner signals
						cmdtstate_cnt <= 1'b0;
						end
					else
						begin
						// output
						tx_vld <= 1'b0;
						response_FIFO_r_en <= 1'b0;		// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						// inner signals
						cmdtstate_cnt <= cmdtstate_cnt + 1'b1;
						end
					end
				CMD_TX_WTSEND:
					begin
					if (cmdtstate_cnt)
						begin
						if (tx_rdy)
							begin
							if (tx_packet_cnt == tx_packet_leng)
								begin
								// state
								cmdtstate <= CMD_TX_IDLE;
								// output
								tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
								tx_vld <= 1'b0;
								response_FIFO_r_en <= 1'b0;		// 
								response_FIFO_cmdnum_minus1 <= 1'b1;		// 
								tx_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
								tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
								// inner signals
								cmdtstate_cnt <= 1'b0;
								end
							else
								begin
								// state
								cmdtstate <= CMD_TX_GETDATA;
								// output
								tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
								tx_vld <= 1'b0;
								response_FIFO_r_en <= 1'b1;		// 
								response_FIFO_cmdnum_minus1 <= 1'b0;		// 
								// inner signals
								cmdtstate_cnt <= 1'b0;
								end
							end
						else
							begin
							// output
							tx_vld <= 1'b0;
							response_FIFO_r_en <= 1'b0;		// 
							end
						end
					else
						begin
						// output
						tx_vld <= 1'b0;
						response_FIFO_r_en <= 1'b0;		// 
						// inner signals
						cmdtstate_cnt <= cmdtstate_cnt + 1'b1;
						end
					end
				CMD_TX_GETDATA:
					begin
					if (cmdtstate_cnt)
						begin
						// state
						cmdtstate <= CMD_TX_WTSEND;
						// output
						tx_data <= response_FIFO_data_o;
						tx_vld <= 1'b1;
						response_FIFO_r_en <= 1'b0;		// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						tx_packet_cnt <= tx_packet_cnt + 1'b1;
						// inner signals
						cmdtstate_cnt <= 1'b0;
						end
					else
						begin
						// output
						tx_vld <= 1'b0;
						response_FIFO_r_en <= 1'b0;					// 
						response_FIFO_cmdnum_minus1 <= 1'b0;		// 
						// inner signals
						cmdtstate_cnt <= cmdtstate_cnt + 1'b1;
						end
					end
				default:
					begin
					// state
					cmdtstate <= CMD_TX_IDLE;
					// output
					tx_data <= {`TX_DATA_BIT_WIDTH{1'b0}};
					tx_vld <= 1'b0;
					response_FIFO_r_en <= 1'b0;					// 
					response_FIFO_cmdnum_minus1 <= 1'b0;		// 
					tx_packet_leng <= {`TX_DATA_BIT_WIDTH{1'b0}};
					tx_packet_cnt <= {`TX_DATA_BIT_WIDTH{1'b0}};
					// inner signals
					cmdtstate_cnt <= 1'b0;
					end
			endcase
			end
		end

	// PUF
	PUF #(
		.PUF_BIT_WIDTH(128)		// generate 128 Glitch_PUF, to get 128-bit response
	) m_PUF (
		.CLK			(clk			),
		.rst_n			(rst_n			),

		.PUF_en			(PUF_en			),
		.challenge		(PUF_challenge	),
		.response		(PUF_response	),
		.PUF_rdy		(PUF_rdy		),
		.Check			(PUF_Check		),

		// temp useless in my design
		.CLK_50M_P		(				),
		.CLK_50M_N		(				)
	);

	// LBlock_Pack
	LBlock_Pack m_LBlock_Pack (
		.Kin		(LBlock_Kin		),
		.Din		(LBlock_Din		),
		.Dout		(LBlock_Dout	),

		.Krdy		(				),
		.Drdy		(LBlock_Drdy	),
		.EncDec		(LBlock_EncDec	),		// 0:Encryption 1:Decryption
		.RSTn		(rst_n			),
		.EN			(1'b1			),		// AES circuit enable
		.CLK		(clk			),
		.BSY		(				),
		.Kvld		(				),		// Data output valid
		.Dvld		(LBlock_Dvld	),
		.Check		(LBlock_Check	)
	);

endmodule
