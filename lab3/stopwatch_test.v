`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:27:53 03/04/2018
// Design Name:   stopwatch
// Module Name:   /home/ise/vboxshared/kyjalab3/stopwatch_test.v
// Project Name:  kyjalab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stopwatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stopwatch_test;

	// Inputs
	reg clk;
	reg rst;
	reg pause;
	reg sel;
	reg adj;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	stopwatch uut (
		.clk(clk), 
		.rst(rst), 
		.pause(pause), 
		.sel(sel), 
		.adj(adj), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		pause = 0;
		sel = 0;
		adj = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

