`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created By Joshua Paul
//Counter Controlled by clock speed and an enable switch
//////////////////////////////////////////////////////////////////////////////////
module Counter_10(
input clock,
input [3:0] in,
input  enable,
output reg [3:0] num =0,
output reg en = 0                         //enable switch for next counter
    );

    always @(posedge clock)    //Only count when enable is on
    begin                      //ensure only next counter is off
        en <=0;
        if (enable != 1)            // if enable is off, time is being adjusted
            num <= in; 
        else if  (num >= 4'd9 && enable)                //Reset when 9 is reached
            num  <= 4'd0;                  //When 9 is reached, enable next counter
        else if (enable) begin
            if (num == 4'd8)
            begin
                en <= 1;
                num <= num +1;
            end
        else
            num <= num +1;
        end
        else num <= num;
        end 
endmodule
