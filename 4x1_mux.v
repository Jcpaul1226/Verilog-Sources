`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by Joshua Paul
// takes in 4 inputs and uses two select lines to output one of the inputs
//////////////////////////////////////////////////////////////////////////////////


module mux_4x1(
    input [3:0] x,
    input [1:0] select,
    output y
    );
    assign y = (~select[0]&~select[1]&x[0])+(select[0]&~select[1]&x[1])+(~select[0]&select[1]&x[2])+(select[0]&select[1]&x[3]);
endmodule
