`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/02 18:07:12
// Design Name: 
// Module Name: PUF
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


module PUF(
    input       CLK,
    input       rst_n,
    input       uart_rx,
    output      uart_tx,
    output      CLK_50M_P, 
    output      CLK_50M_N
    );
 
    wire     [127:0]   Response;
    wire                CLK_50M;
//    wire                CLK_50M_P; 
//    wire                CLK_50M_N;   
//    reg      [1:0]      Shift_IN;
    reg      [31:0]     Time_Count = {32{1'b0}};
    reg      [31:0]     Time_Count_N = {32{1'b0}};
    reg                 Send;
    reg                 Send_N;

    BUFG BUFG_inst (
        .O(CLK_50M), // 1-bit output: Clock output
        .I(CLK)  // 1-bit input: Clock input
    );
   
    PLL PLL_inst
    (
        .clk_out1(CLK_50M_P),
        .clk_out2(CLK_50M_N),
        .clk_in1(CLK_50M)
    ); 
//   always @(posedge CLK_100M)
//        Shift_IN <= Shift_IN + 1'b1;

    (* DONT_TOUCH= "TRUE" *)    
    uart_module    uart_module_inst
    (
        .sys_clk(CLK_50M),
        .rst_n(rst_n),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx),
        .response(Response),
        .enable(Send)
    ); 
    
    Glitch_PUF_64 Glitch_PUF_64_inst1(
    .CLK_50M(CLK_50M),              // Clock input
    .CLK_50M_P(CLK_50M_P),         // SRL data output
    .CLK_50M_N(CLK_50M_N),              // Clock input
    .Response(Response[63:0])
 );

    Glitch_PUF_64 Glitch_PUF_64_inst2(
    .CLK_50M(CLK_50M),              // Clock input
    .CLK_50M_P(CLK_50M_P),         // SRL data output
    .CLK_50M_N(CLK_50M_N),              // Clock input
    .Response(Response[127:64])
 );

//    Glitch_PUF_64 Glitch_PUF_64_inst3(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[191:128])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst4(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[255:192])
// );
 
//    Glitch_PUF_64 Glitch_PUF_64_inst5(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[319:256])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst6(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[383:320])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst7(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[447:384])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst8(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[511:448])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst9(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[575:512])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst10(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[639:576])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst11(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[703:640])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst12(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[767:704])
// );
 
//    Glitch_PUF_64 Glitch_PUF_64_inst13(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[831:768])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst14(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[895:832])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst15(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[959:896])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst16(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1023:960])
//);
 
//    Glitch_PUF_64 Glitch_PUF_64_inst17(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1087:1024])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst18(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1151:1088])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst19(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1215:1152])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst20(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1279:1216])
// );
 
//    Glitch_PUF_64 Glitch_PUF_64_inst21(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1343:1280])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst22(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1407:1344])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst23(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1471:1408])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst24(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1535:1472])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst25(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1599:1536])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst26(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1663:1600])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst27(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1727:1664])
// );

//    Glitch_PUF_64 Glitch_PUF_64_inst28(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1791:1728])
// );
 
//    Glitch_PUF_64 Glitch_PUF_64_inst29(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1855:1792])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst30(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1919:1856])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst31(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[1983:1920])
//);

//    Glitch_PUF_64 Glitch_PUF_64_inst32(
//    .CLK_50M(CLK_50M),              // Clock input
//    .CLK_50M_P(CLK_50M_P),         // SRL data output
//    .CLK_50M_N(CLK_50M_N),              // Clock input
//    .Response(Response[2047:1984])
//);

    always @(posedge CLK_50M)
    Time_Count <= Time_Count_N;

    always @(*)
        if (Time_Count == 32'd49_999_999)
            Time_Count_N = Time_Count;//= {32{1'b0}};
        else
            Time_Count_N = Time_Count + 1'b1; 
            
    always @(posedge CLK_50M)
        Send <= Send_N;   
            
    always @(*)
        if (Time_Count == 32'd24_999_999)
            Send_N = 1'b1;
        else
            Send_N = 1'b0; 
    
    
endmodule
