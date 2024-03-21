`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 02:19:33 PM
// Design Name: 
// Module Name: Seven_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Seven_seg(
        input clk,            //100Mhz clock on fpga
        input [6:0] X,
        input [6:0] Y,
        input [15:0] bcd,
        output reg [7:0] Anode_Activate,    //Anode signals of 7-segment display
        output reg [6:0] LED_out            //Cathode patterns of 7-segment display
    );
    
wire refresh;
reg [4:0]refrate = 4'b0;
reg [3:0] num =0;

//Seven segment must be refreshed every 2-16ms
//16 ms / 8 segments = 2 ms per segment
//1 HZ = 1cycle/one second and 2ms = .002 seconds
//x/.002 = 500/1
Clock_divider refresh_rate(
.clock_in(clk),         //input clock on FPGA
.divide(36'd200000), //100Mhz/200,000 = 500hz  
//divide(36'd2),        //replace top line if simulation
.clock_out(refresh)  //output clock
    );
    always @(posedge refresh)
    begin
    if (refrate == 4'b1000)
    refrate = 4'b000;
    else 
    refrate <= refrate + 4'b0001;
    end
    
 //anode activate signals for 8 leds
 //decoder to generate anode signals
 always @(*)
 begin
    case(refrate)
    4'b0000: begin
        Anode_Activate = 8'b11111110;
        //activate LED1 and Deactivate LED2, LED3,LED4
        num = X%10;
        end
        4'b0001: begin
        Anode_Activate = 8'b11111101;
        //activate LED2 and Deactivate LED1, LED3,LED4
        num = X/10;
        end
        4'b0010: begin
        Anode_Activate = 8'b11111011;
        //activate LED3 and Deactivate LED2, LED1,LED4
        num = Y%10;
        end
        4'b0011: begin
        Anode_Activate = 8'b11110111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        num = Y/10;
        end
        4'b0100: begin
        Anode_Activate = 8'b11101111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        num = bcd % 10;
        end
        4'b0101: begin
        Anode_Activate = 8'b11011111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        num = bcd% 100 / 10;
        end
        3'b0110: begin
        Anode_Activate = 8'b10111111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        num = bcd % 1000 / 100;
        end
        4'b0111: begin
        Anode_Activate = 8'b01111111;
        //activate LED4 and Deactivate LED1, LED2,LED
        num = bcd/ 1000;
        end
        default: begin
        Anode_Activate = 8'b11111111;
        //activate LED1 and Deactivate LED2, LED3,LED4
        end
        endcase 
     end
        
 always @(*)
begin
 case(num)
 4'b0000: LED_out = 7'b1000000; // "0"  
 4'b0001: LED_out = 7'b1111001; // "1" 
 4'b0010: LED_out = 7'b0100100; // "2" 
 4'b0011: LED_out = 7'b0110000; // "3" 
 4'b0100: LED_out = 7'b0011001; // "4" 
 4'b0101: LED_out = 7'b0010010; // "5" 
 4'b0110: LED_out = 7'b0000010; // "6" 
 4'b0111: LED_out = 7'b1111000; // "7" 
 4'b1000: LED_out = 7'b0000000; // "8"  
 4'b1001: LED_out = 7'b0011000; // "9" 
 default: LED_out = 7'b0000001; // "0"
 endcase
end
        
endmodule
