`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:56:38 01/16/2018
// Design Name:   FPCVT
// Module Name:   C:/Users/152/kyjalab1/lab1test.v
// Project Name:  kyjalab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab1test;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.E(E), 
		.F(F)
	);

	initial begin
		// Initialize Inputs
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        
        // -1
        D = 12'b111111111111;
        #10;
        // 11
        D = 12'b000000001011;
        #10;
        // 128
        D = 12'b000010000000;
        #10;
        // 64
        D = 12'b000001000000;
        #10;
        // 46
        D = 12'b000000101110;
        #10;
        // 44
        D = 12'b000000101100;
        #10;
        // 2047
        D = 12'b011111111111;
        #10;
        // -2047
        D = 12'b100000000001;
        #10;
        // -2048
        D = 12'b100000000000;
        #10;
        // 0
        D = 12'b000000000000;
        #10;
		  // 1921
		  D = 12'b011110000001;
		  #10;
		  // 417 
		  D = 12'b000110100001;
		  #10;
		  // -417
		  D = 12'b111001011111;
		  #10;
		  // 415
		  D = 12'b000110011111;
		  #10;
		  // -2000
		  D = 12'b100000110000;
		  #10;
	end
      
endmodule

