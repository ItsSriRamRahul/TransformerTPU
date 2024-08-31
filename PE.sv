`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 10:19:29
// Design Name: 
// Module Name: PE
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


module PE(
        input clk,
        input rst,
        input signed [7:0]a1,
        input signed [7:0]b1,
        
        output reg signed  [7:0]a2,
        output reg signed  [7:0]b2,
        output reg signed [7:0]c2
    );
    
    
    
    wire [7:0] multi;
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            a2<=0;
            b2<=0;
            c2<=0;
        end
        else begin
            a2=a1;
            b2=b1;
            c2=c2+multi;
        
        
        end
    end
    assign multi =a1*b1;
endmodule
