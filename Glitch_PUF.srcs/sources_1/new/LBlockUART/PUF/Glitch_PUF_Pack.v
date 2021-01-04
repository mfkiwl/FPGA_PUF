module Glitch_PUF_Pack #(
	parameter		PUF_BIT_WIDTH	=	128		// generate 128 Glitch_PUF, to get 128-bit response
) (
	input								CLK_50M		,
	input								CLK_50M_P	,
	input								CLK_50M_N	,
	output		[PUF_BIT_WIDTH - 1:0]	Response	
);

	genvar i;
	generate
		begin
		for (i = 0; i < PUF_BIT_WIDTH; i = i + 1)
			begin
			Glitch_PUF m_Glitch_PUF(
				.CLK		(CLK_50M	),		// Clock input
				.Shift_OUT1	(CLK_50M_P	),		// SRL data output
				.Shift_OUT2	(CLK_50M_N	),		// Clock input
				.Q			(Response[i])
			);
			end
		end
	endgenerate

endmodule
