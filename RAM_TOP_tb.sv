`timescale 1ns / 1ps
module RAM_TOP_tb;
parameter COMMAND_WIDTH = 19;
parameter DATA_WIDTH = 8;

//input variables
reg clk;
reg [COMMAND_WIDTH-1:0] command;
//output wire
wire [DATA_WIDTH-1:0] dataOut;
//instantiate Design Under Testing
RAM_TOP DUT(.command(command), .clk(clk), .data(dataOut));

always #10 clk = ~clk; //100MHz clock
initial  
    begin
        //reset all vairalbes
        clk = 0;
        command = 0;
        #125; //settle values

        //test write and read to each rank
        command[9] = 0;
        command[8:7] = 2'b00;
        command[6:0] = $random; //inital random bank address
        $display("Rank %d ENABLED, RANK %d DISABLED", command[9], ~command[9]);
        repeat(4)
            begin               
                command[18] = 1; //Write enabled
                command[17:10] = $random; // [18] - wr, [17:10] - data, [9] - rankAddr, [8:0] - bankAddr 
                $display("Writing %h to Address %h in Bank %d of Rank %d", command[17:10], command[6:0], command[8:7], command[9]);
                #125;
                command[18] = 0; //Read enabled
                #125;
                $display("Reading Address %h from Bank %d of Rank %d: %h", command[6:0], command[8:7], command[9], dataOut);
                //Next address and bank
                command[6:0] = $random;
                command[8:7]++;
                #125;
            end
        //rank 2
        command[9] = 1;
        command[8:7] = 2'b00; //reset banks
        $display("Rank %d ENABLED, RANK %d DISABLED", command[9], ~command[9]);
        repeat(4)
            begin               
                command[18] = 1; //Write enabled
                command[17:10] = $random; // [18] - wr, [17:10] - data, [9] - rankAddr, [8:0] - bankAddr 
                command[6:0] = $random;
                $display("Writing %h to Address %h in Bank %d of Rank %d", command[17:10], command[6:0], command[8:7], command[9]);
                #125;
                command[18] = 0; //Read enabled
                #125;
                $display("Reading Address %h from Bank %d of Rank %d: %h", command[6:0], command[8:7], command[9], dataOut);
                command[8:7]++;
                #25; //wait
            end
            $finish;
    end // initial begin
endmodule
