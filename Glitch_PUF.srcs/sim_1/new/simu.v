`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 09:24:38
// Design Name: 
// Module Name: simu
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


module simu();

reg clk = 0;
always #10 clk <= ~clk; //50M clk

PUF PUF_inst(
    .CLK(clk),
    .rst_n(),
    .uart_rx(),
    .uart_tx(),
    .CLK_50M_P(), 
    .CLK_50M_N()
    );

endmodule
