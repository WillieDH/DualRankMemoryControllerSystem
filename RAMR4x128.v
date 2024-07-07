`timescale 1ns / 1ps
module RAMR4x128#(parameter BANKADDR_WIDTH = 9, parameter DATA_WIDTH = 8)(bankAddr, dataIn, wr, clk, be, dataOut);
input [BANKADDR_WIDTH-1:0] bankAddr;
input [DATA_WIDTH-1:0] dataIn;
input wr, clk, be;
output reg [DATA_WIDTH-1:0] dataOut;
// variables to disable unused chips and choosing data form enabled chips
reg cs0, cs1, cs2, cs3;
wire [DATA_WIDTH-1:0] dataOut0, dataOut1, dataOut2, dataOut3;

//instantiate RAM banks
RAMB128x8 BA0 (.wordAddr(bankAddr[6:0]), .cs(cs0), .wr(wr), .clk(clk), .dataIn(dataIn), .dataOut(dataOut0));
RAMB128x8 BA1 (.wordAddr(bankAddr[6:0]), .cs(cs1), .wr(wr), .clk(clk), .dataIn(dataIn), .dataOut(dataOut1));
RAMB128x8 BA2 (.wordAddr(bankAddr[6:0]), .cs(cs2), .wr(wr), .clk(clk), .dataIn(dataIn), .dataOut(dataOut2));
RAMB128x8 BA3 (.wordAddr(bankAddr[6:0]), .cs(cs3), .wr(wr), .clk(clk), .dataIn(dataIn), .dataOut(dataOut3));

always @ (posedge clk) 
    begin
        if (be)
            begin
                case (bankAddr[8:7]) // based on Bank Address, enable chip, disable other chips, and output the chip's data.
                    2'b00 :
                        begin
                            dataOut <= dataOut0;
                            {cs0, cs1, cs2, cs3} <= 4'b1000;
                        end
                    2'b01 :
                        begin
                            dataOut <= dataOut1;
                            {cs0, cs1, cs2, cs3} <= 4'b0100;
                        end
                    2'b10 :
                        begin
                            dataOut <= dataOut2;
                            {cs0, cs1, cs2, cs3} <= 4'b0010;
                        end
                    2'b11 :
                        begin
                            dataOut <= dataOut3;
                            {cs0, cs1, cs2, cs3} <= 4'b0001;
                        end
                    default: 
                        begin
                            dataOut <= 0;
                            {cs0, cs1, cs2, cs3} <= 4'b0000;
                        end
                endcase
            end 
            else
                {cs0, cs1, cs2, cs3} = 4'b0000;
    end // always begin
endmodule
