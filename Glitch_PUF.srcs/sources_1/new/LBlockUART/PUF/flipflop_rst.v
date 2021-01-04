`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 08:46:43
// Design Name: 
// Module Name: flipflop_rst
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


module flipflop_rst(
    input CLK_50M,
    input DIN,
    output DOUT
    );
    
    reg [23:0] cnt = 24'd0; //0~9
    reg [23:0] cnt_n = 24'd0;
    reg       dout;
    
    parameter cnt_10 = 24'd5000000;
    
    assign DOUT = dout;
    
    always @(posedge CLK_50M) begin
        cnt <= cnt_n;
    end
    
    always @(*) begin
        if (cnt == cnt_10)
            cnt_n = 24'b0;
        else
            cnt_n = cnt + 24'b1;
    end 
    
    always @(*) begin
        if (cnt == 24'd4)
            dout = 1'b0;
        else
            dout = DIN;
    end
    
endmodule
