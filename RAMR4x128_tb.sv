`timescale 1ns / 1ps
module RAMR4x128_tb;
parameter BANKADDR_WIDTH = 9;
parameter DATA_WIDTH = 8;

//input variables
reg clk, wr, be;
reg [BANKADDR_WIDTH-1:0] bankAddr;
reg [DATA_WIDTH-1:0] dataIn;
//output wire
wire [DATA_WIDTH-1:0] dataOut;
//instantiate Design Under Testing
RAMR4x128 DUT(.bankAddr(bankAddr), .dataIn(dataIn), .wr(wr), .clk(clk), .be(be), .dataOut(dataOut));

always #10 clk = ~clk; //100MHz clock
initial
    begin
        //reset all variables
        clk = 0;
        wr = 0;
        be = 0;
        bankAddr = 9'b000000000;
        dataIn = 0;
        #125; //settle values

        //test write and read to each bank
        bankAddr[6:0] = $random; //initial random bank address
        repeat(4) 
            begin
                //BANK enabled
                be = 1;
                $display("BANK ENABLED");
                wr = 1; //write enabled
                dataIn = $random; //random data input
                #125; //
                $display("Writing %h to Address %h in Bank %d...", dataIn, bankAddr[6:0], bankAddr[8:7]);
                wr = 0; //read enabled
                #125;
                $display("Reading Address %h from Bank %d: %h", bankAddr[6:0], bankAddr[8:7], dataOut);
                //BANK disabled
                be = 0;
                $display("BANK DISABLED");
                #25;
                wr = 1; //write enabled
                dataIn = $random; //random data input
                #125; //
                $display("Writing %h to Address %h in Bank %d...", dataIn, bankAddr[6:0], bankAddr[8:7]);
                wr = 0; //read enabled
                #125;
                $display("Reading Address %h from bank %d: %h", bankAddr[6:0], bankAddr[8:7], dataOut);
                //next adddress and bank
                bankAddr[6:0] = $random;
                bankAddr[8:7]++;
               #25; //wait 
            end
        $finish;
    end //initial begin
endmodule
