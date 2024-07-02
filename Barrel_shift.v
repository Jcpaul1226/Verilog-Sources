`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created By Joshua Paul
//Takes a number and shifts it right by a certain amount
//If you want to shift left, change amt to (bits - amt)
//////////////////////////////////////////////////////////////////////////////////


module Barrel_shift(
input [15:0] data,              //Number to be shifted
input  [3:0]amt,               //How many bits to shift
output reg [15:0] out           //Shifted Number
    );
    
    always @(*)
    begin
        case(amt)
            4'b0000: out = data;
            4'b0001: out = {data[0],data[15:1]};
            4'b0010: out = {data[1:0],data[15:2]};
            4'b0011: out = {data[2:0],data[15:3]};
            4'b0100: out = {data[3:0],data[15:4]};
            4'b0101: out = {data[4:0],data[15:5]};
            4'b0110: out = {data[5:0],data[15:6]};
            4'b0111: out = {data[6:0],data[15:7]};
            4'b1000: out = {data[7:0],data[15:8]};
            4'b1001: out = {data[8:0],data[15:9]};
            4'b1010: out = {data[9:0],data[15:10]};
            4'b1011: out = {data[10:0],data[15:11]};
            4'b1100: out = {data[11:0],data[15:12]};
            4'b1101: out = {data[12:0],data[15:13]};
            4'b1110: out = {data[13:0],data[15:14]};
            4'b1111: out = {data[14:0],data[15]};
            
            default: out = data;
         endcase
      end
endmodule
