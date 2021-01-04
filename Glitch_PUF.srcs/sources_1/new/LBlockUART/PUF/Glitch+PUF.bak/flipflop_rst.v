module flipflop_rst #(
	parameter		cnt_10		=	4'd9
) (
	input		CLK_50M		,
	input		DIN			,
	output		DOUT		
);

	reg [3:0] cnt = 4'd0;		// 0~9
	reg [3:0] cnt_n = 4'd0;
	reg dout;

	assign DOUT = dout;

	always@ (posedge CLK_50M)
		begin
		cnt <= cnt_n;
		end

	always@ (*)
		begin
		if (cnt == cnt_10)
			cnt_n = 4'b0;
		else
			cnt_n = cnt + 4'b1;
		end 

	always@ (*)
		begin
		if (cnt == 4'd9)
			dout = 1'b0;
		else
			dout = DIN;
		end

endmodule
