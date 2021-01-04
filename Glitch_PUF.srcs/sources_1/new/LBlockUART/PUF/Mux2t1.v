module Mux2t1 #(
	parameter		MUX_DATA_BIT_WIDTH		=	1		// data bit width
) (
	input		[MUX_DATA_BIT_WIDTH - 1:0]		a0	,
	input		[MUX_DATA_BIT_WIDTH - 1:0]		a1	,
	input										s	,
	output		[MUX_DATA_BIT_WIDTH - 1:0]		res	
);

	assign res = s ? a1 : a0;

endmodule
