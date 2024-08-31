`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2024 11:03:26
// Design Name: 
// Module Name: SA
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


module SA#(parameter N=32)(
    input clk,input rst,input [N-1:0] [7:0]a, input[N-1:0][7:0] b,
    output reg [N-1:0][N-1:0][7:0] c, output reg done
    );
    wire [N-1:0][N-1:0][7:0] r,d;
    genvar i,j;
    generate 
        for(i=0;i<N;i++) begin
            for(j=0;j<N;j++) begin
            if(i==0 && j==0)
                PE p(clk,rst,a[0],b[0],r[0][0],d[0][0],c[i][j]);
            else if(i==0 && j!=0)
                PE p(clk,rst,r[0][j-1],b[j],r[0][j],d[0][j],c[0][j]);
            else if(i!=0 && j==0)
                PE p(clk,rst,a[i],d[i-1][0],r[i][0],d[i][j],c[i][0]);  
            else
            PE p(clk,rst,r[i][j-1],d[i-1][j],r[i][j],d[i][j],c[i][j]);    
        end
        end
    
    endgenerate
    
    
    
endmodule
