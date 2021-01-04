`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/13 13:45:47
// Design Name: 
// Module Name: Glitch_PUF_64
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


module Glitch_PUF_64(
    input           CLK_50M,
    input           CLK_50M_P,
    input           CLK_50M_N,        
    output [63:0]   Response
    );
    
    Glitch_PUF Glitch_PUF_inst1(
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output
    .Shift_OUT2(CLK_50M_N),              // Clock input
    .Q(Response[0])
 );
    
    Glitch_PUF Glitch_PUF_inst2(
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output
    .Shift_OUT2(CLK_50M_N),              // Clock input
    .Q(Response[1])
);
 
    Glitch_PUF Glitch_PUF_inst3(
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output
    .Shift_OUT2(CLK_50M_N),              // Clock input
    .Q(Response[2])
);
 
    Glitch_PUF Glitch_PUF_inst4(
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output
    .Shift_OUT2(CLK_50M_N),              // Clock input
    .Q(Response[3])
);
    
    Glitch_PUF Glitch_PUF_inst5(
    .Q(Response[4]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst6(
    .Q(Response[5]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst7(
    .Q(Response[6]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst8(
    .Q(Response[7]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst9(
    .Q(Response[8]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst10(
     .Q(Response[9]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst11(
    .Q(Response[10]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst12(
    .Q(Response[11]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst13(
    .Q(Response[12]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst14(
    .Q(Response[13]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst15(
    .Q(Response[14]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst16(
    .Q(Response[15]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst17(
    .Q(Response[16]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst18(
     .Q(Response[17]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst19(
    .Q(Response[18]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst20(
    .Q(Response[19]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst21(
    .Q(Response[20]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst22(
    .Q(Response[21]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst23(
    .Q(Response[22]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst24(
    .Q(Response[23]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst25(
    .Q(Response[24]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst26(
     .Q(Response[25]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst27(
    .Q(Response[26]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst28(
    .Q(Response[27]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst29(
    .Q(Response[28]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst30(
    .Q(Response[29]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst31(
    .Q(Response[30]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst32(
    .Q(Response[31]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output   
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst33(
    .Q(Response[32]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst34(
     .Q(Response[33]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst35(
    .Q(Response[34]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst36(
    .Q(Response[35]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst37(
    .Q(Response[36]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst38(
    .Q(Response[37]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst39(
    .Q(Response[38]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst40(
    .Q(Response[39]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst41(
    .Q(Response[40]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst42(
     .Q(Response[41]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst43(
    .Q(Response[42]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst44(
    .Q(Response[43]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst45(
    .Q(Response[44]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst46(
    .Q(Response[45]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst47(
    .Q(Response[46]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst48(
    .Q(Response[47]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst49(
    .Q(Response[48]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst50(
     .Q(Response[49]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst51(
    .Q(Response[50]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst52(
    .Q(Response[51]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst53(
    .Q(Response[52]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst54(
    .Q(Response[53]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst55(
    .Q(Response[54]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst56(
    .Q(Response[55]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst57(
    .Q(Response[56]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
 );
    
    Glitch_PUF Glitch_PUF_inst58(
     .Q(Response[57]),         // SRL data output
     .CLK(CLK_50M),              // Clock input
     .Shift_OUT1(CLK_50M_P),         // SRL data output     
     .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst59(
    .Q(Response[58]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
 
    Glitch_PUF Glitch_PUF_inst60(
    .Q(Response[59]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);
    
    Glitch_PUF Glitch_PUF_inst61(
    .Q(Response[60]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst62(
    .Q(Response[61]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst63(
    .Q(Response[62]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);

    Glitch_PUF Glitch_PUF_inst64(
    .Q(Response[63]),         // SRL data output
    .CLK(CLK_50M),              // Clock input
    .Shift_OUT1(CLK_50M_P),         // SRL data output     
    .Shift_OUT2(CLK_50M_N)              // Clock input
);   
    
    
endmodule
