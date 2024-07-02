`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created By Joshua Paul
// Seven segment Display using a clock divider for refresh rate
//////////////////////////////////////////////////////////////////////////////////

module Seven_seg(
        input clk,            //100Mhz clock on fpga
        input [17:0] num,
        output reg [7:0] Anode_Activate,    //Anode signals of 7-segment display
        output reg [6:0] LED_out            //Cathode patterns of 7-segment display
    );

reg[3:0] LED_BCD;
wire refresh;
reg [3:0]refrate = 4'b0;

Clock_divider refresh_rate(
.clock_in(clk),         //input clock on FPGA
.divide(27'd200000), //100MHZ/200000 = 500Hz = 500/1s = 1/.002s = 2ms
//.divide(27'd02),
.clock_out(refresh)  //output clock
    );
    
    always @(posedge refresh)
    begin
    if (refrate >= 4'b0101)
    refrate = 4'b0000;
    else 
    refrate <= refrate + 4'b01;
    end
    
 //anode activate signals for 6 leds
 //decoder to generate anode signals
 always @(*)
 begin
    case(refrate)
    4'b0000: begin
        Anode_Activate = 8'b11111110;
        //activate LED1 and Deactivate LED2, LED3,LED4
        LED_BCD = num[3:0];
        end
        4'b0001: begin
        Anode_Activate = 8'b11111101;
        //activate LED2 and Deactivate LED1, LED3,LED4
        LED_BCD = num[6:4];
        end
        4'b0010: begin
        Anode_Activate = 8'b11111011;
        //activate LED3 and Deactivate LED2, LED1,LED4
        LED_BCD = num[10:7];
        end
        4'b0011: begin
        Anode_Activate = 8'b11110111;
        //activate LED4 and Deactivate LED1, LED2,LED3
        LED_BCD = num[13:11];
        end
        4'b0100: begin
        Anode_Activate = 8'b11101111;
        //activate LED1 and Deactivate LED2, LED3,LED4
        LED_BCD = num[17:14]%10;
        end
        4'b0101: begin
        Anode_Activate = 8'b11011111;
        //activate LED1 and Deactivate LED2, LED3,LED4
        LED_BCD = num[17:14]/10;
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
