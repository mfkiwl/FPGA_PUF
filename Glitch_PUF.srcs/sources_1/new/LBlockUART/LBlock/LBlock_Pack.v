module LBlock_Pack(
	input		[79:0]		Kin		,
	input		[63:0]		Din		,
	output		[63:0]		Dout	,

	input					Krdy	,
	input					Drdy	,
	input					EncDec	,		// 0:Encryption 1:Decryption
	input					RSTn	,
	input					EN		,		// AES circuit enable
	input					CLK		,
	output					BSY		,
	output					Kvld	,		// Data output valid
	output					Dvld	,
	output		[7:0]		Check	
);

	wire AES_Comp_Krdy, AES_Comp_Drdy;
	reg Drdy_delay1, Drdy_delay2;
	assign AES_Comp_Krdy = Drdy;
	assign AES_Comp_Drdy = Drdy_delay2;
	always@ (posedge CLK)
		begin
		if (!RSTn)
			begin
			Drdy_delay1 <= 1'b0;
			Drdy_delay2 <= 1'b0;
			end
		else
			begin
			Drdy_delay1 <= Drdy;
			Drdy_delay2 <= Drdy_delay1;
			end
		end

	// AES_Comp
	AES_Comp m_AES_Comp(
		.Kin(Kin), 
		.Din(Din), 
		.Dout(Dout), 
		.Krdy(AES_Comp_Krdy), 
		.Drdy(AES_Comp_Drdy), 
		.EncDec(EncDec), 
		.RSTn(RSTn), 
		.EN(EN),
		.CLK(CLK), 
		.BSY(BSY), 
		.Kvld(Kvld), 
		.Dvld(Dvld)
	);

	assign Check = Dout[63:56] ^ Dout[55:48] ^ Dout[47:40] ^ Dout[39:32] ^ Dout[31:24] ^ Dout[23:16] ^ Dout[15:8] ^ Dout[7:0];

endmodule
