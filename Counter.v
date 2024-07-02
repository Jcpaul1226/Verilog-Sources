`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created By Joshua Paul
//Counter Controlled by clock speed and an enable switch
//////////////////////////////////////////////////////////////////////////////////
module Counter(
input clock,
input enable,
output reg [3:0] num =0,
output reg en =0                        //enable switch for next counter
    );

    always @(posedge clock & enable)    //Only count when enable is on
    begin
        en <= 0;                        //ensure only next counter is off
        if (num == 4'd9)                //Reset when 9 is reached
        begin
            num = 4'd0; 
            en = 1;                     //When 9 is reached, enable next counter
        end
        else 
            num <= num +1;
        end  
endmodule
