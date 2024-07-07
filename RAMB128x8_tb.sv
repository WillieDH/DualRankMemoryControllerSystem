`timescale 1ns / 1ps
module RAMB128x8_tb;
parameter WORDADDR_WIDTH = 7;
parameter DATA_WIDTH = 8;
parameter DEPTH = 128;
//input variables
reg clk, cs, wr;
reg [WORDADDR_WIDTH-1:0] wordAddr;
reg [DATA_WIDTH-1:0] dataIn;
//output wire
wire [DATA_WIDTH-1:0] dataOut;

//instantiate module
RAMB128x8 DUT(.wordAddr(wordAddr), .dataIn(dataIn), .cs(cs), .clk(clk), .wr(wr), .dataOut(dataOut));

always #10 clk = ~clk; // 100MHz clock
initial 
    begin
        //reset all variables
        clk = 0;
        cs = 0;
        wr = 0;
        wordAddr = 0;
        dataIn = 0;
        #25; // settle values
        repeat(2) 
            begin   
                cs = 1;
                $display("CHIP ENABLED");          
                wr = 1; //write enabled
                wordAddr = $random;
                dataIn = $random;
                $display("Writing 0x%h to 0x%h...", dataIn, wordAddr);
                #20;
                wr = 0; //read enabled
                #20;
                $display("Address 0x%h is storing data 0x%h.", wordAddr, dataOut);
                cs = 0;
                $display("CHIP DISABLED");
                wr = 1; //write enabled
                dataIn = $random;
                $display("Writing 0x%h to 0x%h...", dataIn, wordAddr);
                #20;
                wr = 0; //read enabled
                #20;
                $display("Address 0x%h is storing data 0x%h.", wordAddr, dataOut);
            end
        $finish;
    end



endmodule
