`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ashutosh Rajendra Karve (01021)
// 
// Create Date: 10/10/2024 11:41:20 PM
// Design Name: Feedforward Neural Network
// Module Name: feedforward_nn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Simple feedforward neural network with one hidden layer
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module feedforward_nn(
    input signed [7:0] in1,
    input signed [7:0] in2,
    input signed [7:0] in3,
    input signed [7:0] in4,
    output reg signed [7:0] out1,
    output reg signed [7:0] out2
    );

    // Internal signals for hidden layer outputs
    reg signed [7:0] hidden_output[0:2]; // 3 neurons in the hidden layer

    // Weights and biases for hidden and output layers
    reg signed [7:0] w_hidden[0:2][0:3]; // 3 hidden neurons, each with 4 inputs
    reg signed [7:0] b_hidden[0:2];      // Biases for hidden neurons
    reg signed [7:0] w_output[0:1][0:2]; // 2 output neurons, each with 3 inputs (from hidden layer)
    reg signed [7:0] b_output[0:1];      // Biases for output neurons

    // Initialize weights and biases
    initial begin
        // Initialize hidden layer weights and biases
        w_hidden[0][0] = 8'sd1; w_hidden[0][1] = 8'sd2; w_hidden[0][2] = -8'sd1; w_hidden[0][3] = 8'sd1;
        w_hidden[1][0] = 8'sd0; w_hidden[1][1] = 8'sd1; w_hidden[1][2] = -8'sd2; w_hidden[1][3] = 8'sd2;
        w_hidden[2][0] = 8'sd3; w_hidden[2][1] = -8'sd1; w_hidden[2][2] = 8'sd2; w_hidden[2][3] = -8'sd1;

        b_hidden[0] = 8'sd1; b_hidden[1] = -8'sd1; b_hidden[2] = 8'sd0;

        // Initialize output layer weights and biases
        w_output[0][0] = 8'sd2; w_output[0][1] = -8'sd3; w_output[0][2] = 8'sd1;
        w_output[1][0] = 8'sd1; w_output[1][1] = 8'sd2; w_output[1][2] = -8'sd1;

        b_output[0] = 8'sd1; b_output[1] = -8'sd2;
    end

    // ReLU activation function
    function signed [7:0] ReLU(input signed [7:0] x);
    begin
        if (x > 8'sd0)
            ReLU = x;
        else
            ReLU = 8'sd0;
    end
    endfunction

    // Compute hidden layer outputs
    always @(*) begin
        hidden_output[0] = ReLU(in1 * w_hidden[0][0] + in2 * w_hidden[0][1] + in3 * w_hidden[0][2] + in4 * w_hidden[0][3] + b_hidden[0]);
        hidden_output[1] = ReLU(in1 * w_hidden[1][0] + in2 * w_hidden[1][1] + in3 * w_hidden[1][2] + in4 * w_hidden[1][3] + b_hidden[1]);
        hidden_output[2] = ReLU(in1 * w_hidden[2][0] + in2 * w_hidden[2][1] + in3 * w_hidden[2][2] + in4 * w_hidden[2][3] + b_hidden[2]);
    end

    // Compute output layer values and apply ReLU
    always @(*) begin
        out1 = ReLU(hidden_output[0] * w_output[0][0] + hidden_output[1] * w_output[0][1] + hidden_output[2] * w_output[0][2] + b_output[0]);
        out2 = ReLU(hidden_output[0] * w_output[1][0] + hidden_output[1] * w_output[1][1] + hidden_output[2] * w_output[1][2] + b_output[1]);
    end

endmodule
