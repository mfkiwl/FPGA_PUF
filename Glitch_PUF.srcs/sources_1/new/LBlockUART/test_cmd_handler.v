`timescale 1ns/1ns
module test_cmd_handler();

	reg clk, rst_n, uart_rx;
	always
		#50 clk = ~clk;
	
	initial
		begin
		clk = 1'b0;
		rst_n = 1'b1;
		uart_rx = 1'b0;
		# 100;
		rst_n = 1'b0;
		# 900;
		rst_n = 1'b1;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		uart_rx  = 1'b0;		// start-bit
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;
		# 86805;
		uart_rx  = 1'b0;
		# 86805;
		uart_rx  = 1'b1;		// stop-bit
		# 86805;
		end

	// cmd_handler
	cmd_handler #(
	) m_cmd_handler (
		.clk			(clk			),
		.rst_n			(rst_n			),
		.uart_rx		(uart_rx		),
		.uart_tx		(		)

		// inner data
		
	);

endmodule
