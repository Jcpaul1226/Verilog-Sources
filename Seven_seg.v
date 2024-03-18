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
        input CLK100MHZ,            //100Mhz clock on fpga
        output reg [7:0] Anode_Activate,    //Anode signals of 7-segment display
        output reg [6:0] LED_out            //Cathode patterns of 7-segment display
    );

reg[3:0] LED_BCD;
wire refresh;
reg [2:0]refrate = 2'b0;

Clock_divider refresh_rate(
.clock_in(CLK100MHZ),         //input clock on FPGA
.divide(26'd66666666), //100MHZ/66666666 = 15Hz = 4ms
.clock_out(refresh)  //output clock
    );
    always @(posedge refresh)
    begin
    if (refrate == 2'b11)
    refrate = 2'b00;
    else 
    refrate <= refrate + 2'b01;
    end
    
 //anode activate signals for 4 leds
 //decoder to generate anode signals
 always @(*)
 begin
    case(refrate)
    2'b00: begin
        Anode_Activate = 8'b11111110;
        //activate LED1 and Deactivate LED2, LED3,LED4
        LED_BCD = 4'd5;
        //the first hex-digit of the 16-bit number
        end
        2'b01: begin
        Anode_Activate = 8'b11111101;
        //activate LED2 and Deactivate LED1, LED3,LED4
        LED_BCD = 4'd3;
        //the second hex-digit of the 16-bit number
        end
        2'b10: begin
        Anode_Activate = 8'b11111011;
        //activate LED3 and Deactivate LED2, LED1,LED4
        LED_BCD = 4'd6;
        //the third hex-digit of the 16-bit number
        end
        2'b11: begin
        Anode_Activate = 8'b11110111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        LED_BCD = 4'd7;
        //the fourth hex-digit of the 16-bit number
        end
        default: begin
        Anode_Activate = 8'b11111110;
        //activate LED1 and Deactivate LED2, LED3,LED4
        LED_BCD = 4'd5;
        //the first hex-digit of the 16-bit number
        end
        endcase 
     end
        
 always @(*)
begin
 case(LED_BCD)
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
