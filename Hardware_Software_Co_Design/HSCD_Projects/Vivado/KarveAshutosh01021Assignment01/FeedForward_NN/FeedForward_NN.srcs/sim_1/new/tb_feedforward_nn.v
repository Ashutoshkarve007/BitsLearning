`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ashutosh Rajendra Karve (01021)
// 
// Create Date: 10/10/2024 11:54:58 PM
// Design Name: Feedforward Neural Network Testbench
// Module Name: tb_feedforward_nn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for Feedforward Neural Network
// 
// Dependencies: feedforward_nn module
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_feedforward_nn;
    // Declare inputs to the neural network (testbench will drive these signals)
    reg signed [7:0] in1;
    reg signed [7:0] in2;
    reg signed [7:0] in3;
    reg signed [7:0] in4;
    // Declare outputs to observe the neural network's outputs
    wire signed [7:0] out1;
    wire signed [7:0] out2;
    // Instantiate the feedforward neural network module
    feedforward_nn uut (
        .in1(in1),
        .in2(in2),
        .in3(in3),                             //Ashutosh Rajendra Karve
        .in4(in4),                             // BITS-PILANI 
        .out1(out1),                           // 01021
        .out2(out2)
    );
    // Testbench procedure to provide input values and observe outputs
    initial begin
        // Test case 1
        in1 = 8'sd1; in2 = 8'sd1; in3 = 8'sd1; in4 = 8'sd1;
        #10; // Wait for 10 time units
        // Test case 2
        in1 = 8'sd5; in2 = -8'sd3; in3 = 8'sd2; in4 = -8'sd1;
        #10;
        // Test case 3
        in1 = -8'sd2; in2 = 8'sd4; in3 = -8'sd3; in4 = 8'sd1;
        #10;
        // End the simulation
        $finish;
    end

endmodule
