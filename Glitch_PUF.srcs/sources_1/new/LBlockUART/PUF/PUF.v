module PUF #(
	parameter		PUF_BIT_WIDTH			=	128		// generate 128 Glitch_PUF, to get 128-bit response
	`define			CHALLENGE_BIT_WIDTH		(PUF_BIT_WIDTH >> 1)
	`define			RESPONSE_BIT_WIDTH		(PUF_BIT_WIDTH >> 2)
) (
	input										CLK			,
	input										rst_n		,

	input										PUF_en		,
	input		[`CHALLENGE_BIT_WIDTH - 1:0]	challenge	,
	output		[`RESPONSE_BIT_WIDTH - 1:0]		response	,
	output	reg									PUF_rdy		,
	output		[7:0]							Check		,

	// temp useless in my design
	output										CLK_50M_P	,
	output										CLK_50M_N	
);

	// PUF_rdy (last posedge clk, challenge is valid)
	always@ (posedge CLK)
		begin
		if (!rst_n)
			begin
			PUF_rdy <= 1'b0;
			end
		else
			begin
			PUF_rdy <= PUF_en;				// 1-cycle delay is already enough
			end
		end

	wire CLK_50M;
	wire [PUF_BIT_WIDTH - 1:0] puf_response;
	(*mark_debug = "true"*)wire [PUF_BIT_WIDTH - 1:0] debug_puf_response = puf_response;

	// BUFG
	BUFG BUFG_inst (
		.O			(CLK_50M		),		// 1-bit output: Clock output
		.I			(CLK			)		// 1-bit input: Clock input
	);

	// PLL
	PLL PLL_inst (
		.clk_out1	(CLK_50M_P		),
		.clk_out2	(CLK_50M_N		),
		.clk_in1	(CLK_50M		)
	); 

	// Glitch_PUF_Pack
	Glitch_PUF_Pack #(
		.PUF_BIT_WIDTH(PUF_BIT_WIDTH)
	) m_Glitch_PUF_Pack (
		.CLK_50M	(CLK_50M		),		// Clock input
		.CLK_50M_P	(CLK_50M_P		),		// SRL data output
		.CLK_50M_N	(CLK_50M_N		),		// Clock input
		.Response	(puf_response	)
	);

	// Challenge_PUF
	wire [`CHALLENGE_BIT_WIDTH - 1:0] challenge_puf_response;
	genvar i;
	generate
		begin
		for (i = 0; i < `CHALLENGE_BIT_WIDTH; i = i + 1)
			begin
			Mux2t1 #(
				.MUX_DATA_BIT_WIDTH(1)		// data bit width
			) m_Mux2t1 (
				.a0	(puf_response[(i << 1)]		),
				.a1	(puf_response[(i << 1) + 1]	),
				.s	(challenge[i]				),
				.res(challenge_puf_response[i]	)
			);
			end
		end
	endgenerate

	// Xor_Challenge_PUF
	generate
		begin
		for (i = 0; i < `RESPONSE_BIT_WIDTH; i = i + 1)
			begin
			Xor #(
				.XOR_DATA_BIT_WIDTH(1)		// data bit width
			) (
				.a0	(challenge_puf_response[(i << 1)]		),
				.a1	(challenge_puf_response[(i << 1) + 1]	),
				.res(response[i]							)
			);
			end
		end
	endgenerate

	assign Check = response[31:24] ^ response[23:16] ^ response[15:8] ^ response[7:0];

endmodule
