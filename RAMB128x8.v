`timescale 1ns / 1ps
module RAMB128x8#(parameter WORDADDR_WIDTH = 7, parameter DATA_WIDTH = 8, parameter DEPTH = 128)(wordAddr, cs, wr, clk, dataIn, dataOut);
input [WORDADDR_WIDTH-1:0] wordAddr;
input [DATA_WIDTH-1:0] dataIn;
input cs, wr, clk;
output reg [DATA_WIDTH-1:0] dataOut;

reg [DATA_WIDTH-1:0] RAMBANK [DEPTH-1:0];
    
always @ (posedge clk) 
    begin
        if (cs & wr) RAMBANK[wordAddr] <= dataIn;
        if (cs & !wr) dataOut <= RAMBANK[wordAddr];
    end
    
endmodule
