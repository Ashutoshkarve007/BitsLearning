`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bits Pilani
// Engineer: 
// 
// Create Date: 08/18/2024 01:18:59 PM
// Designer Name: Ashutosh Karve
// Module Name: mux_2to1
// Project Name: Multiplexer Design
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


module mux_2to1(
    input a,
    input b,
    input sel,
    output y
    );
    
    assign y = sel ? b : a;
endmodule
