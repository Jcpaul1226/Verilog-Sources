`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created By Joshua Paul
//Counter Controlled by clock speed and an enable switch
//////////////////////////////////////////////////////////////////////////////////
module Counter_12(
input clock,
input [3:0] in,
input  enable,
output reg [3:0] num =0,
output reg en = 0                        //enable switch for next counter
    );
    

    always @(posedge clock)    //Only count when enable is on
    begin                      
    en <=0;                     //ensure next couinter is on
    if (enable != 1)    
    num <= in;
        else if (num >= 4'd12 && enable)                //Reset when 12 is reached
            num <= 4'd0; 
        else if (enable) begin
        if (num >= 4'd11) begin         //signal next counter to count
            en <= 1;
            num <= num +1;end
         else num <= num +1;
        end else num <= num;
        end  
endmodule
