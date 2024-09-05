`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bits Pilani
// Engineer: 
// 
// Create Date: 08/18/2024 03:49:02 PM
// Designer Name: Ashutosh Karve
// Module Name: mux_4to1
// Project Name: Design Multiplexer
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


module mux_4to1 (
    input [3:0] a,
    input [1:0] sel,
    output y
);

    // 4-to-1 Multiplexer logic
    assign Y = (sel == 2'b00) ? a[0] :
               (sel == 2'b01) ? a[1] :
               (sel == 2'b10) ? a[2] :
                                a[3];

endmodule

