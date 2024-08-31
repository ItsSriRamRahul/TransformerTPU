`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2024 14:32:42
// Design Name: 
// Module Name: custom_fifo
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


module custom_fifo#(parameter N = 32,                 // Number of data packets
    parameter FIFO_DEPTH = 2 * N+2,     // FIFO depth is 2*N
    parameter FIFO_WIDTH = 8 ) (
    input clk,
    input rst,
    input signed [N-1:0][7:0] data_in,   // Assuming 8-bit data packet input
    input [31:0] row_in,    // Number of zeros to prepend
    input wrt,input rd,
    output reg signed  [7:0] data_out,
    output wire fifo_full,
    output wire fifo_empty
);

             // Assuming 8-bit data width

    // FIFO memory
    reg [FIFO_WIDTH-1:0] fifo_mem [FIFO_DEPTH-1:0];
    reg [$clog2(FIFO_DEPTH)-1:0] write_ptr;
    reg [$clog2(FIFO_DEPTH)-1:0] read_ptr;
    reg [$clog2(FIFO_DEPTH)-1:0] counter;
    reg[$clog2(FIFO_DEPTH)-1:0]c;

    // FIFO full and empty logic
    assign fifo_full = ( (counter==N) && (read_ptr == 0));
    assign fifo_empty = (write_ptr == read_ptr);
    integer i;
    //init RAM
     
    
    //write
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            write_ptr<=row_in;
            counter<=0;
            c<=0;
            read_ptr <= 0;
            data_out <= 0;
            for(i=0;i<FIFO_DEPTH;i=i+1)begin
                fifo_mem[i]<=0;
            end
            end
        else if(wrt&c<N&!rd) begin
             fifo_mem[write_ptr]<=data_in[c];  
             c<=c+1; 
             write_ptr<=write_ptr+1;
             counter<=counter+1;
        end else if (rd&!wrt&read_ptr<(2*N)+2) begin
        
            data_out <= fifo_mem[read_ptr];
            read_ptr <= read_ptr + 1;
        end
    
    end

   
endmodule