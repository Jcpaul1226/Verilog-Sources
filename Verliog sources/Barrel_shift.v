`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created By Joshua Paul
//Takes a number and shifts it right by a certain amount
//If you want to shift left, change amt to (bits - amt)
//////////////////////////////////////////////////////////////////////////////////


module Barrel_shift(
input [7:0] data,              //Number to be shifted
input [3:0] amt,               //How many bits to shift
output reg [7:0] out           //Shifted Number
    );
    
    always @(*)
    begin
        case(amt)
            4'b0000: out = data;
            4'b0001: out = {data[0],data[7:1]};
            4'b0010: out = {data[1:0],data[7:2]};
            4'b0011: out = {data[2:0],data[7:3]};
            4'b0100: out = {data[3:0],data[7:4]};
            4'b0101: out = {data[4:0],data[7:5]};
            4'b0110: out = {data[5:0],data[7:6]};
            4'b0111: out = {data[6:0],data[7]};
            default: out = data;
         endcase
      end
endmodule
