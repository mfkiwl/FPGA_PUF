`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/02 16:28:20
// Design Name: 
// Module Name: Gilitch_PUF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Glitch_PUF(
    input CLK,
    input Shift_OUT1,
    input Shift_OUT2,
    output Q
    );
    
    
//    wire                Shift_OUT1;
//    wire                Shift_OUT2;
    wire    [2:0]       CARRY4_OUT1;
    wire    [2:0]       CARRY4_OUT2;
    wire                CARRY4_CO3;
    wire                FDPE_OUT;
    wire                FDPE_inst1_out;
    wire                FDPE_inst1_din;
    wire                CARRY4_BW;

    
    
    
//   SRL16E #(
//       .INIT(16'h5555) // Initial Value of Shift Register
//    ) SRL16E_inst1 (
//       .Q(Shift_OUT1),       // SRL data output
//       .A0(1'b1),     // Select[0] input
//       .A1(1'b1),     // Select[1] input
//       .A2(1'b1),     // Select[2] input
//       .A3(1'b1),     // Select[3] input
//       .CE(1'b1),     // Clock enable input
//       .CLK(CLK),   // Clock input
//       .D(D)        // SRL data input
//    );
    
//   SRL16E #(
//       .INIT(16'hAAAA) // Initial Value of Shift Register
//    ) SRL16E_inst2 (
//       .Q(Shift_OUT2),       // SRL data output
//       .A0(1'b1),     // Select[0] input
//       .A1(1'b1),     // Select[1] input
//       .A2(1'b1),     // Select[2] input
//       .A3(1'b1),     // Select[3] input
//       .CE(1'b1),     // Clock enable input
//       .CLK(CLK),   // Clock input
//       .D(~D)        // SRL data input
//    );

//use one carry4,the PLL phase is 250.3   
//   CARRY4 CARRY4_inst1 (                
//       .CO({CARRY4_CO3,CARRY4_OUT1}),         // 4-bit carry out
//       .O(),           // 4-bit carry chain XOR data out
//       .CI(1'b1),         // 1-bit carry cascade input
//       .CYINIT(1'b1), // 1-bit carry initialization
//       .DI(4'b0000),         // 4-bit carry-MUX data in
//       .S({Shift_OUT1,1'b1,1'b1,Shift_OUT2})            // 4-bit carry-MUX select input
//    );

//use two carry4,the PLL phase is 251 
   CARRY4 CARRY4_inst1 (
       .CO({CARRY4_CO3,CARRY4_OUT1}),         // 4-bit carry out
       .O(),           // 4-bit carry chain XOR data out
       .CI(CARRY4_BW),         // 1-bit carry cascade input
       .CYINIT(1'b0), // 1-bit carry initialization
       .DI(4'b0000),         // 4-bit carry-MUX data in
       .S({Shift_OUT1,1'b1,1'b1,1'b1})            // 4-bit carry-MUX select input
    );
    
   CARRY4 CARRY4_inst2 (
       .CO({CARRY4_BW,CARRY4_OUT2}),         // 4-bit carry out
       .O(),           // 4-bit carry chain XOR data out
       .CI(1'b1),         // 1-bit carry cascade input
       .CYINIT(1'b1), // 1-bit carry initialization
       .DI(4'b0000),         // 4-bit carry-MUX data in
       .S({1'b1,1'b1,1'b1,Shift_OUT2})            // 4-bit carry-MUX select input
    );
    
    flipflop_rst flipflop_rst_inst (
        .CLK_50M(CLK),
        .DIN(FDPE_inst1_out),
        .DOUT(FDPE_inst1_din)
    ); 
 
   FDPE #(
       .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
    ) FDPE_inst1 (
       .Q(FDPE_inst1_out),      // 1-bit Data output
       .C(CLK),      // 1-bit Clock input
       .CE(1'b1),    // 1-bit Clock enable input
       .PRE(CARRY4_CO3),  // 1-bit Asynchronous preset input
       .D(FDPE_inst1_din)       // 1-bit Data input
    );
    
   FDPE #(
       .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
    ) FDPE_inst2 (
       .Q(Q),      // 1-bit Data output
       .C(CLK),      // 1-bit Clock input
       .CE(1'b1),    // 1-bit Clock enable input
       .PRE(1'b0),  // 1-bit Asynchronous preset input
       .D(FDPE_inst1_out)       // 1-bit Data input
    );
       
    
endmodule
