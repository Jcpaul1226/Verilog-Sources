`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created By Joshua Paul
// Removes unexpected up and down bounces when pressing a button
//and produces one single pulse instead
//////////////////////////////////////////////////////////////////////////////////


module button_debouncer(
    input pb_1,
    input clk,
    output pb_out
    );
    
    wire slow_clk_en;           //generates pulse on a slower clock
    wire q1,q2,q2_bar,q0;
    clock_enable u1(clk,slow_clk_en);
    my_dff_en d0 (clk,slow_clk_en,pb_1,q0);
    my_dff_en d1 (clk,slow_clk_en,q0,q1);
    my_dff_en d2 (clk,slow_clk_en,q1,q2);
    assign q2_bar = ~q2;
    assign pb_out = q1 & q2_bar;
endmodule

//100MHZ/250k = 400HZ = 400/1second = .0025s
module clock_enable(input clock, output slow_clk_en);
    reg [26:0] counter = 0;
    always @(posedge clock)
    begin
        counter <=(counter>=249999)?0:counter + 1;      // increase counter untill 249999
        //counter <=(counter>=1)?0:counter + 1;      // testbench
    end
    assign slow_clk_en = (counter == 249999)?1'b1:1'b0;
    //assign slow_clk_en = (counter == 1)?1'b1:1'b0;  //testbench
endmodule

//D flip flop, delays the change of state untill the rising edge of clock
module my_dff_en(input DFF_CLOCK, clock_enable,D,output reg Q=0);
    always @(posedge DFF_CLOCK)
    begin
        if (clock_enable == 1)
        Q <=D;
        end
endmodule
