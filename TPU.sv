`timescale 1ns / 1ps
module TPU#(parameter depth=32)(
           input clk,input rst,
           input signed  [depth-1:0][depth-1:0][7:0]a,
           input signed  [depth-1:0][depth-1:0][7:0]b,
           output reg signed  [depth-1:0][depth-1:0][7:0]c
          
    );
               wire signed [depth-1:0][depth-1:0][7:0] cx;
               reg [1:0] state,nxt;
               reg signed [depth-1:0][depth-1:0][7:0]dinr,dinc;
               wire signed [depth-1:0][7:0]doutr,doutc;
               reg wr,rd,rst_sa;
               wire [depth-1:0]fullr,fullc,emptyr,emptyc;
               
               genvar i;
               
               generate 
              
                for (i=0;i<depth;i=i+1)begin :fifo
                    custom_fifo fifor(clk,rst,dinr[i],i,wr,rd,doutr[i],fullr[i],emptyr[i]);
                    custom_fifo fifoc(clk,rst,dinc[i],i,wr,rd,doutc[i],fullc[i],emptyc[i]);
                end
    
    endgenerate
    
    reg done;
    
    SA s1(clk,rst_sa,doutr,doutc,cx,done);
    
     always @(* )begin
                    if(rst)begin
                    state<=0;
                 
                    end
                    else begin 
                    state<=nxt;
                    
                    end
                    end
                 always@(*)begin
                 if(rst) begin nxt<=0;rst_sa<=1; end
                 else
                 case(state)
                     2'b00:if(fullr[0]==1'b1&fullc[0]==1'b1) nxt<=2'b01;else begin
                                            for(integer i=0;i<depth;i++)begin
                                                for(integer j=0,k=depth-1;j<depth&&k>=0;j++,k--)begin
                                                   dinr[i][j]=a[i][k];
                                                   
                                                end
                                            end
                                            
                                            
                                            for(integer i=0;i<depth;i++)begin
                                                for(integer j=0,k=depth-1;j<depth&&k>=0;j++,k--)begin
                                                   dinc[i][j]=b[k][i];
                                                   
                                                end
                                            end
                                            wr=1'b1;
                                            rd=1'b0;
                                         end
                    2'b01:
                    if(done) nxt<=2'b10;
                    else begin 
                            wr=1'b0; rd=1'b1;
                            rst_sa<=1'b0;
                           for(integer i=0;i<depth;i++) begin
                                for(integer j=0;j<depth;j++) begin
                                    c[i][j]<=cx[i][j];
                           end
                           end 
                         end
                    2'b10: begin
                    
                    rst_sa<=1'b1;
                    rd=1'b0;
                    end
                    
                    endcase
                 end
    
    
endmodule