`timescale 1ns / 1ps

module fpm_tb;

    // Testbench signals
    reg clk;
    reg [15:0] a;
    reg [15:0] b;
    wire [15:0] result;

    // Instantiate the floating-point multiplier
    fpm uut (
	.clk(clk),
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end
    

    initial begin
        // Display the result format
        $monitor("Time: %0dns | A: %h | B: %h | Result: %h", $time, a, b, result);
	a=16'h0;
	b=16'h0;
	#5
        // Test cases
        // Case 1: Multiplying 1.0 * 1.0
        a = 16'hBC33; // -1.05 in half-precision
        b = 16'h3C00; // 0.96 in half-precision BC08
        #10;

        // Case 2: Multiplying 2.0 * 2.0
        a = 16'h5620; // 98 in half-precision
        b = 16'h5600; // 96 in half-precision 7098
        #10;

        // Case 3: Multiplying 0.5 * 0.5
        a = 16'hD160; // -43 in half-precision
        b = 16'h54C0; // 76 in half-precision EA62
        #10;

        // Case 4: Multiplying -1.0 * 1.0
        a = 16'hE218; // -780 in half-precision
        b = 16'h4600; // 6 in half-precision EC92
        #10;

        // Case 5: Multiplying small values
        a = 16'h3C00; // 1.0 in half-precision 
        b = 16'h3C01; // Just above 1.0 in half-precision
        #10;

        // Case 6: Multiplying two zero values
        a = 16'h0000; // 0.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10;

        // Case 7: Multiplying a normal value with zero
        a = 16'h3C00; // 1.0 in half-precision
        b = 16'h0000; // 0.0 in half-precision
        #10;

        // Case 8: Multiplying NaN
        //a = 16'h7E00; // NaN in half-precision
        //b = 16'h3C00; // 1.0 in half-precision
        #10;

        // End simulation
        $finish;
    end

endmodule

