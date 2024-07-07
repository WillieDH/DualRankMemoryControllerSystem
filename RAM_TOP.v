`timescale 1ns / 1ps
module RAM_TOP#(parameter COMMAND_WIDTH = 19, parameter DATA_WIDTH = 8)(command, clk, data);
input [COMMAND_WIDTH-1:0] command; // [18] - wr, [17:10] - data, [9] - rankAddr, [8:0] - bankAddr 
input clk;
output reg [DATA_WIDTH-1:0] data;
//variables to disable unused rank adn choose data from enabled rank
reg rs0, rs1;
wire [DATA_WIDTH-1:0] dataOut0, dataOut1;

//instantiate RAM ranks
RAMR4x128 BR0 (.bankAddr(command[8:0]), .dataIn(command[17:10]), .wr(command[18]), .clk(clk), .be(rs0), .dataOut(dataOut0));
RAMR4x128 BR1 (.bankAddr(command[8:0]), .dataIn(command[17:10]), .wr(command[18]), .clk(clk), .be(rs1), .dataOut(dataOut1));

always @(posedge clk) 
    begin
        case (command[9]) 
        1'b0 : 
            begin
                {rs0, rs1} <= 2'b10;
                data <= dataOut0;
            end
        1'b1 :
            begin
                {rs0, rs1} <= 2'b01;
                data <= dataOut1;
            end
        endcase
    end
endmodule
