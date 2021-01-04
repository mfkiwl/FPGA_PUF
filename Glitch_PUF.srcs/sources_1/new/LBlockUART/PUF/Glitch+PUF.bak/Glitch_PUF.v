module Glitch_PUF(
	input		CLK			,
	input		Shift_OUT1	,
	input		Shift_OUT2	,
	output		Q			
);

	wire [2:0] CARRY4_OUT1, CARRY4_OUT2;
	wire CARRY4_CO3;
	wire FDPE_inst1_out, FDPE_inst1_din;
	wire CARRY4_BW;

	// use two carry4,the PLL phase is 251
	// CARRY4_1
	CARRY4 m_CARRY4_1 (
		.CO		({CARRY4_CO3,CARRY4_OUT1}	),		// 4-bit carry out
		.O		(							),		// 4-bit carry chain XOR data out
		.CI		(CARRY4_BW					),		// 1-bit carry cascade input
		.CYINIT	(1'b0						),		// 1-bit carry initialization
		.DI		(4'b0000					),		// 4-bit carry-MUX data in
		.S		({Shift_OUT1,1'b1,1'b1,1'b1})		// 4-bit carry-MUX select input
	);

	// CARRY4_2
	CARRY4 m_CARRY4_2 (
		.CO		({CARRY4_BW,CARRY4_OUT2}	),		// 4-bit carry out
		.O		(							),		// 4-bit carry chain XOR data out
		.CI		(1'b1						),		// 1-bit carry cascade input
		.CYINIT	(1'b1						),		// 1-bit carry initialization
		.DI		(4'b0000					),		// 4-bit carry-MUX data in
		.S		({1'b1,1'b1,1'b1,Shift_OUT2})		// 4-bit carry-MUX select input
	);

	// flipflop_rst
	flipflop_rst m_flipflop_rst (
		.CLK_50M(CLK						),
		.DIN	(FDPE_inst1_out				),
		.DOUT	(FDPE_inst1_din				)
	); 

	// FDPE_1
	FDPE #(
		.INIT(1'b0)									// Initial value of register (1'b0 or 1'b1)
	) m_FDPE_1 (
		.Q		(FDPE_inst1_out				),		// 1-bit Data output
		.C		(CLK						),		// 1-bit Clock input
		.CE		(1'b1						),		// 1-bit Clock enable input
		.PRE	(CARRY4_CO3					),		// 1-bit Asynchronous preset input
		.D		(FDPE_inst1_din				)		// 1-bit Data input
	);

	// FDPE_2
	FDPE #(
		.INIT(1'b0)									// Initial value of register (1'b0 or 1'b1)
	) m_FDPE_2 (
		.Q		(Q							),		// 1-bit Data output
		.C		(CLK						),		// 1-bit Clock input
		.CE		(1'b1						),		// 1-bit Clock enable input
		.PRE	(1'b0						),		// 1-bit Asynchronous preset input
		.D		(FDPE_inst1_out				)		// 1-bit Data input
	);

endmodule
