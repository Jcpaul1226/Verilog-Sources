`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Made by Joshua paul
// Counts up 
//////////////////////////////////////////////////////////////////////////////////


module count (
input clk,
input sw,
output  wire [11:0] num
);
wire en1,en2,en3;

    Counter one(
    .clock(clk),
    .enable(sw),
    .num(num[3:0]),
    .en(en1)
    );
    Counter ten(
    .clock(clk),
    .enable(en1),
    .num(num[7:4]),
    .en(en2)
    );
    Counter hun(
    .clock(clk),
    .enable(en2),
    .num(num[11:8]),
    .en(en3)
    );
    
endmodule
