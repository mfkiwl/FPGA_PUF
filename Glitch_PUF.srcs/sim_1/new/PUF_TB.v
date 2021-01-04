`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 12:23:00
// Design Name: 
// Module Name: PUF_TB
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


module PUF_TB();

reg                CLK;
reg                rst_n;
wire               Respond;
reg                uart_rx;
wire               uart_tx;

initial
begin
CLK = 1'b0;
rst_n = 1'b0;
#100 rst_n = 1'b1;
end

always#10 CLK = ~CLK;


PUF  PUF_inst
(
    .CLK(CLK),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .rst_n(rst_n)
);

endmodule
