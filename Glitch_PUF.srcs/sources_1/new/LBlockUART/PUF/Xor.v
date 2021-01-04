module Xor #(
	parameter		XOR_DATA_BIT_WIDTH		=	1		// data bit width
) (
	input		[XOR_DATA_BIT_WIDTH - 1:0]		a0	,
	input		[XOR_DATA_BIT_WIDTH - 1:0]		a1	,
	output		[XOR_DATA_BIT_WIDTH - 1:0]		res	
);

	assign res = a1 ^ a0;

endmodule