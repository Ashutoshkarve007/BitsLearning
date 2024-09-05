`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 04:24:24 PM
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


module mux_4to1(
    input a,
    input b,
    input c,
    input d,
    input s0,
    input s1,
    input y
    );
    
    assign y = s1 ? (s0 ? d : c) : (s0 ? b : a );
endmodule
