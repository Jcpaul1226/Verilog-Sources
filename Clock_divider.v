`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Made By Joshua Paul
// Summary: Divide the onboard clock by a certain number to achieve a specific frequency
// 
//////////////////////////////////////////////////////////////////////////////////
module Clock_divider(
    input clock_in,             //input clock on FPGA
    input [26:0] divide,        // clock_in / divide = clock out
    output reg clock_out  = 0   //output clock
    );
    
    reg[26:0] counter = 27'd0;
//clock_out frequency = clock_in/ divide
//EX: clock_in = 100Mhz, clock_out = 100Mhz/100.000.000 = 1HZ = 1/1Hz = 1s

always @(posedge clock_in)
    begin
        counter <= counter +27'd1;
        if(counter>=(divide-1))
            counter <= 27'd0;
        clock_out <= (counter<divide/2)?1'b1:1'b0; 
        //if counter < divide/2, clock_out = 1
        //if counter > divide/2, clock_out = 0;
    end
endmodule
