/*-------------------------------------------------------------------------
 AES Encryption/Decryption Macro (ASIC version)
                                   
 File name   : AES_Comp.v
 Version     : Version 1.0
 Created     : 
 Last update : SEP/25/2007
 Desgined by : Akashi Satoh
 
 
 Copyright (C) 2007 AIST and Tohoku Univ.
 
 By using this code, you agree to the following terms and conditions.
 
 This code is copyrighted by AIST and Tohoku University ("us").
 
 Permission is hereby granted to copy, reproduce, redistribute or
 otherwise use this code as long as: there is no monetary profit gained
 specifically from the use or reproduction of this code, it is not sold,
 rented, traded or otherwise marketed, and this copyright notice is
 included prominently in any copy made.
 
 We shall not be liable for any damages, including without limitation
 direct, indirect, incidental, special or consequential damages arising
 from the use of this code.
 
 When you publish any results arising from the use of this code, we will
 appreciate it if you can cite our webpage
 (http://www.aoki.ecei.tohoku.ac.jp/crypto/).
 -------------------------------------------------------------------------*/

//`timescale 1ns / 1ps

module AES_Comp(Kin, Din, Dout, Krdy, Drdy, EncDec, RSTn, EN, CLK, BSY, Kvld, Dvld);
  input  [79:0] Kin;  // Key input
  input  [63:0] Din;  // Data input
  output [63:0] Dout; // Data output
  input  Krdy;         // Key input ready
  input  Drdy;         // Data input ready
  input  EncDec;       // 0:Encryption 1:Decryption
  input  RSTn;         // Reset (Low active)
  input  EN;           // AES circuit enable
  input  CLK;          // System clock
  output BSY;          // Busy signal
  output Kvld;         // Data output valid
  output Dvld;         // Data output valid

  wire EN_E, EN_D;
  wire [63:0] Dout_E, Dout_D;
  wire BSY_E, BSY_D;
  wire Dvld_E, Dvld_D;
  wire Kvld_E, Kvld_D;

  wire Dvld_tmp, Kvld_tmp;
  reg  Dvld_reg, Kvld_reg;

  assign EN_E = (~EncDec) & EN;
  assign EN_D =  EncDec & EN;
  assign BSY  = BSY_E | BSY_D;

  assign Dvld_tmp = Dvld_E & (~EncDec) | Dvld_D & EncDec;
  assign Kvld_tmp = Kvld_E & (~EncDec) | Kvld_D & EncDec;

  assign Dvld = ( (Dvld_reg == 1'b0) && (Dvld_tmp == 1'b1) ) ? 1'b1: 1'b0;
  assign Kvld = ( (Kvld_reg == 1'b0) && (Kvld_tmp == 1'b1) ) ? 1'b1: 1'b0;  

  assign Dout = (EncDec == 0)? Dout_E: Dout_D;

  LBlock_ENC AES_Comp_ENC(Kin, Din, Dout_E, Krdy, Drdy, RSTn, EN_E, CLK, BSY_E, Kvld_E, Dvld_E);
 // AES_Comp_DEC AES_Comp_DEC(Kin, Din, Dout_D, Krdy, Drdy, RSTn, EN_D, CLK, BSY_D, Kvld_D, Dvld_D);

  // Behavior for Dvld_reg and Kvld_reg.
  always @(posedge CLK) begin
    if (RSTn == 0) begin
      Dvld_reg <= 1'b0;
      Kvld_reg <= 1'b0;
    end
    else if (EN == 1) begin
      Dvld_reg <= Dvld_tmp;
      Kvld_reg <= Kvld_tmp;
    end
  end
endmodule

/////////////////////////////
//     S_box0              //
/////////////////////////////
module s_box0 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'he;   4'h1  :  data_out=4'h9;   4'h2  :  data_out=4'hf;   4'h3  :  data_out=4'h0;   
	4'h4  :  data_out=4'hd;   4'h5  :  data_out=4'h4;   4'h6  :  data_out=4'ha;   4'h7  :  data_out=4'hb;   
	4'h8  :  data_out=4'h1;   4'h9  :  data_out=4'h2;   4'ha  :  data_out=4'h8;   4'hb  :  data_out=4'h3;
	4'hc  :  data_out=4'h7;   4'hd  :  data_out=4'h6;   4'he  :  data_out=4'hc;   4'hf  :  data_out=4'h5;
  endcase

endmodule
/////////////////////////////
//     S_box1              //
/////////////////////////////
module s_box1 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'h4;   4'h1  :  data_out=4'hb;   4'h2  :  data_out=4'he;   4'h3  :  data_out=4'h9;   
	4'h4  :  data_out=4'hf;   4'h5  :  data_out=4'hd;   4'h6  :  data_out=4'h0;   4'h7  :  data_out=4'ha;   
	4'h8  :  data_out=4'h7;   4'h9  :  data_out=4'hc;   4'ha  :  data_out=4'h5;   4'hb  :  data_out=4'h6;
	4'hc  :  data_out=4'h2;   4'hd  :  data_out=4'h8;   4'he  :  data_out=4'h1;   4'hf  :  data_out=4'h3;
  endcase

endmodule
/////////////////////////////
//     S_box2              //
/////////////////////////////
module s_box2 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'h1;   4'h1  :  data_out=4'he;   4'h2  :  data_out=4'h7;   4'h3  :  data_out=4'hc;   
	4'h4  :  data_out=4'hf;   4'h5  :  data_out=4'hd;   4'h6  :  data_out=4'h0;   4'h7  :  data_out=4'h6;   
	4'h8  :  data_out=4'hb;   4'h9  :  data_out=4'h5;   4'ha  :  data_out=4'h9;   4'hb  :  data_out=4'h3;
	4'hc  :  data_out=4'h2;   4'hd  :  data_out=4'h4;   4'he  :  data_out=4'h8;   4'hf  :  data_out=4'ha;
  endcase

endmodule
/////////////////////////////
//     S_box3              //
/////////////////////////////
module s_box3 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'h7;   4'h1  :  data_out=4'h6;   4'h2  :  data_out=4'h8;   4'h3  :  data_out=4'hb;   
	4'h4  :  data_out=4'h0;   4'h5  :  data_out=4'hf;   4'h6  :  data_out=4'h3;   4'h7  :  data_out=4'he;   
	4'h8  :  data_out=4'h9;   4'h9  :  data_out=4'ha;   4'ha  :  data_out=4'hc;   4'hb  :  data_out=4'hd;
	4'hc  :  data_out=4'h5;   4'hd  :  data_out=4'h2;   4'he  :  data_out=4'h4;   4'hf  :  data_out=4'h1;
  endcase

endmodule
/////////////////////////////
//     S_box4              //
/////////////////////////////
module s_box4 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'he;   4'h1  :  data_out=4'h5;   4'h2  :  data_out=4'hf;   4'h3  :  data_out=4'h0;   
	4'h4  :  data_out=4'h7;   4'h5  :  data_out=4'h2;   4'h6  :  data_out=4'hc;   4'h7  :  data_out=4'hd;   
	4'h8  :  data_out=4'h1;   4'h9  :  data_out=4'h8;   4'ha  :  data_out=4'h4;   4'hb  :  data_out=4'h9;
	4'hc  :  data_out=4'hb;   4'hd  :  data_out=4'ha;   4'he  :  data_out=4'h6;   4'hf  :  data_out=4'h3;
  endcase

endmodule
/////////////////////////////
//     S_box5              //
/////////////////////////////
module s_box5 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'h2;   4'h1  :  data_out=4'hd;   4'h2  :  data_out=4'hb;   4'h3  :  data_out=4'hc;   
	4'h4  :  data_out=4'hf;   4'h5  :  data_out=4'he;   4'h6  :  data_out=4'h0;   4'h7  :  data_out=4'h9;   
	4'h8  :  data_out=4'h7;   4'h9  :  data_out=4'ha;   4'ha  :  data_out=4'h6;   4'hb  :  data_out=4'h3;
	4'hc  :  data_out=4'h1;   4'hd  :  data_out=4'h8;   4'he  :  data_out=4'h4;   4'hf  :  data_out=4'h5;
  endcase

endmodule
/////////////////////////////
//     S_box6              //
/////////////////////////////
module s_box6 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'hb;   4'h1  :  data_out=4'h9;   4'h2  :  data_out=4'h4;   4'h3  :  data_out=4'he;   
	4'h4  :  data_out=4'h0;   4'h5  :  data_out=4'hf;   4'h6  :  data_out=4'ha;   4'h7  :  data_out=4'hd;   
	4'h8  :  data_out=4'h6;   4'h9  :  data_out=4'hc;   4'ha  :  data_out=4'h5;   4'hb  :  data_out=4'h7;
	4'hc  :  data_out=4'h3;   4'hd  :  data_out=4'h8;   4'he  :  data_out=4'h1;   4'hf  :  data_out=4'h2;
  endcase

endmodule
/////////////////////////////
//     S_box7              //
/////////////////////////////
module s_box7 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'hd;   4'h1  :  data_out=4'ha;   4'h2  :  data_out=4'hf;   4'h3  :  data_out=4'h0;   
	4'h4  :  data_out=4'he;   4'h5  :  data_out=4'h4;   4'h6  :  data_out=4'h9;   4'h7  :  data_out=4'hb;   
	4'h8  :  data_out=4'h2;   4'h9  :  data_out=4'h1;   4'ha  :  data_out=4'h8;   4'hb  :  data_out=4'h3;
	4'hc  :  data_out=4'h7;   4'hd  :  data_out=4'h5;   4'he  :  data_out=4'hc;   4'hf  :  data_out=4'h6;
  endcase

endmodule
/////////////////////////////
//     S_box8              //
/////////////////////////////
module s_box8 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'h8;   4'h1  :  data_out=4'h7;   4'h2  :  data_out=4'he;   4'h3  :  data_out=4'h5;   
	4'h4  :  data_out=4'hf;   4'h5  :  data_out=4'hd;   4'h6  :  data_out=4'h0;   4'h7  :  data_out=4'h6;   
	4'h8  :  data_out=4'hb;   4'h9  :  data_out=4'hc;   4'ha  :  data_out=4'h9;   4'hb  :  data_out=4'ha;
	4'hc  :  data_out=4'h2;   4'hd  :  data_out=4'h4;   4'he  :  data_out=4'h1;   4'hf  :  data_out=4'h3;
  endcase

endmodule
/////////////////////////////
//     S_box9              //
/////////////////////////////
module s_box9 (
				data_in		,
				data_out
	 );

input    [3:0]    data_in;
output   [3:0]    data_out;

reg      [3:0]    data_out;
  
always @(data_in)
  case(data_in)     //synopsys full_case parallel_case
	4'h0  :  data_out=4'hb;   4'h1  :  data_out=4'h5;   4'h2  :  data_out=4'hf;   4'h3  :  data_out=4'h0;   
	4'h4  :  data_out=4'h7;   4'h5  :  data_out=4'h2;   4'h6  :  data_out=4'h9;   4'h7  :  data_out=4'hd;   
	4'h8  :  data_out=4'h4;   4'h9  :  data_out=4'h8;   4'ha  :  data_out=4'h1;   4'hb  :  data_out=4'hc;
	4'hc  :  data_out=4'he;   4'hd  :  data_out=4'ha;   4'he  :  data_out=4'h3;   4'hf  :  data_out=4'h6;
  endcase

endmodule

/////////////////////////////
//     round               //
/////////////////////////////
module round
(
        Rrg,
        round		  
);
input   [31:0] Rrg;
output  [4:0] round; 
reg     [4:0] round;
always @(Rrg) begin
  case(Rrg) 
32'h00000001  : round[4:0] = 5'b00000; 32'h00000002  : round[4:0] = 5'b00001;
32'h00000004  : round[4:0] = 5'b00010; 32'h00000008  : round[4:0] = 5'b00011;
32'h00000010  : round[4:0] = 5'b00100; 32'h00000020  : round[4:0] = 5'b00101;
32'h00000040  : round[4:0] = 5'b00110; 32'h00000080  : round[4:0] = 5'b00111;
32'h00000100  : round[4:0] = 5'b01000; 32'h00000200  : round[4:0] = 5'b01001;
32'h00000400  : round[4:0] = 5'b01010; 32'h00000800  : round[4:0] = 5'b01011;
32'h00001000  : round[4:0] = 5'b01100; 32'h00002000  : round[4:0] = 5'b01101;
32'h00004000  : round[4:0] = 5'b01110; 32'h00008000  : round[4:0] = 5'b01111;
32'h00010000  : round[4:0] = 5'b10000; 32'h00020000  : round[4:0] = 5'b10001;
32'h00040000  : round[4:0] = 5'b10010; 32'h00080000  : round[4:0] = 5'b10011;
32'h00100000  : round[4:0] = 5'b10100; 32'h00200000  : round[4:0] = 5'b10101;
32'h00400000  : round[4:0] = 5'b10110; 32'h00800000  : round[4:0] = 5'b10111;
32'h01000000  : round[4:0] = 5'b11000; 32'h02000000  : round[4:0] = 5'b11001;
32'h04000000  : round[4:0] = 5'b11010; 32'h08000000  : round[4:0] = 5'b11011;
32'h10000000  : round[4:0] = 5'b11100; 32'h20000000  : round[4:0] = 5'b11101;
32'h40000000  : round[4:0] = 5'b11110; 32'h80000000  : round[4:0] = 5'b11111;
endcase
end

endmodule
/////////////////////////////
//     key_expansion_32    //
/////////////////////////////
module key_expansion
(
        K,
        Rrg,
        Knext		  
);
input   [79:0] K;
input   [31:0] Rrg;
output  [79:0] Knext; 

wire [3:0] k1,k2;
wire [4:0] round;

s_box9 s_box9_enc (K[50:47],  k1[3:0]);
s_box8 s_box8_enc (K[46:43],  k2[3:0]);

round round_enc(Rrg,round);

     
assign Knext[79:0] = {k1,k2,K[42:22],K[21:17] ^ round[4:0],K[16:0],K[79:51]};
				 
endmodule


///////////////////////////////
//        Function F         //
///////////////////////////////
module function_f(
       xin,
       kin,
		 xout
);
input  [31:0] xin;
input  [31:0] kin;
output [31:0] xout;

wire [31:0] xtemp;

assign xtemp[31:0] = xin[31:0] ^ kin[31:0];

s_box7 s_box7_enc (xtemp[31:28],xout[23:20]);
s_box6 s_box6_enc (xtemp[27:24],xout[31:28]);
s_box5 s_box5_enc (xtemp[23:20],xout[19:16]);
s_box4 s_box4_enc (xtemp[19:16],xout[27:24]);
s_box3 s_box3_enc (xtemp[15:12],xout[7:4]);
s_box2 s_box2_enc (xtemp[11:8],xout[15:12]);
s_box1 s_box1_enc (xtemp[7:4],xout[3:0]);	
s_box0 s_box0_enc (xtemp[3:0],xout[11:8]);

endmodule

/////////////////////////////
//        round 32         //
/////////////////////////////
module round_32 (
       x1,
		 x2,
		 k,
		 xout
);
input  [31:0] x1,x2;
input  [31:0] k;
output [31:0] xout;

wire [31:0] xnext;
wire [31:0] xtemp;

assign xnext[31:0] = {x1[23:0],x1[31:24]};
function_f function_f_enc (x2[31:0],k[31:0],xtemp[31:0]);

assign xout[31:0] = xtemp[31:0] ^ xnext[31:0]; 

endmodule
/////////////////////////////
//     Encryption Core     //
/////////////////////////////
module AES_Comp_EncCore(di, ki, Rrg, do,ko);
  input  [63:0] di;
  input  [79:0] ki;
  input  [31:0] Rrg;
  output [63:0] do;
  output [79:0] ko;

wire [31:0] x1,x2;
wire [79:0] Knext;
wire [31:0] xout;

assign x1[31:0] = di[31:0]; 
assign x2[31:0] = di[63:32];


key_expansion key_expansion_enc (ki[79:0],Rrg[31:0],Knext[79:0]);
round_32 round_32_enc (x1[31:0],x2[31:0],ki[79:48],xout[31:0]);

assign do[63:0] = {xout[31:0],x2[31:0]};
assign ko[79:0] = Knext[79:0];
 
endmodule




/////////////////////////////
//   AES for encryption    //
/////////////////////////////
module LBlock_ENC(Kin, Din, Dout, Krdy, Drdy, RSTn, EN, CLK, BSY, Kvld, Dvld);
  input  [79:0] Kin;  // Key input
  input  [63:0] Din;  // Data input
  output [63:0] Dout; // Data output
  input  Krdy;         // Key input ready
  input  Drdy;         // Data input ready
  input  RSTn;         // Reset (Low active)
  input  EN;           // AES circuit enable
  input  CLK;          // System clock
  output BSY;          // Busy signal
  output Kvld;         // Key valid
  output Dvld;         // Data output valid

  reg  [63:0] Drg;    // Data register
  reg  [79:0] Krg;    // Key register
  reg  [79:0] KrgX;   // Temporary key Register
  reg  [31:0] Rrg;    // Round counter
  reg  Kvldrg, Dvldrg, BSYrg;
  wire [63:0] Dnext; 
  wire [79:0] Knext;

  AES_Comp_EncCore EC (Drg, KrgX, Rrg, Dnext, Knext);
  

  assign Kvld = Kvldrg;
  assign Dvld = Dvldrg;
  assign Dout = Drg[63:0];
  assign BSY  = BSYrg;

  always @(posedge CLK) begin
    if (RSTn == 0) begin
      Krg    <= 80'h00000000000000000000;
      KrgX   <= 80'h00000000000000000000;
      Rrg    <= 32'h00000001;
      Kvldrg <= 0;
      Dvldrg <= 0;
      BSYrg  <= 0;
    end
    else if (EN == 1) begin
      if (BSYrg == 0) begin
        if (Krdy == 1) begin
          Kvldrg <= 1;
          Dvldrg <= 0;
        end
        else if (Drdy == 1) begin
			 Rrg    <= {Rrg[30:0], Rrg[31]};	
			 Krg <= Kin;
			 KrgX <= Kin;
          Drg    <= Din;		 
          Dvldrg <= 0;
          BSYrg  <= 1;	 
        end
      end
      else begin
        Drg <= Dnext;
        if (Rrg[0] == 1) begin
          KrgX   <= Krg;
          Dvldrg <= 1;
          BSYrg  <= 0;
		  Drg[63:0] <= {Dnext[31:0],Dnext[63:32]};
        end
        else begin
          Rrg    <= {Rrg[30:0], Rrg[31]};
          KrgX   <= Knext;  
        end
      end
    end
  end
endmodule


