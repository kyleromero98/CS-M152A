`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:30:21 03/04/2018
// Design Name:   counter
// Module Name:   /home/ise/vboxshared/kyjalab3/counter_test.v
// Project Name:  kyjalab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_test;

	// Inputs
	reg rst;
	reg pause;
	reg adj;
	reg sel;
	reg clk_count;
	reg clk_adj;

	// Outputs
	wire [3:0] min_ones;
	wire [3:0] min_tens;
	wire [3:0] sec_ones;
	wire [3:0] sec_tens;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.rst(rst), 
		.pause(pause), 
		.adj(adj), 
		.sel(sel), 
		.clk_count(clk_count), 
		.clk_adj(clk_adj), 
		.min_ones(min_ones), 
		.min_tens(min_tens), 
		.sec_ones(sec_ones), 
		.sec_tens(sec_tens)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		pause = 0;
		adj = 0;
		sel = 0;
		clk_count = 0;
		clk_adj = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
   always begin
		#10 clk_count = ~clk_count;
	end
	
	always begin
		#5 clk_adj = ~clk_adj;
	end
	
	initial begin
		// testing regular clock mode
		adj = 0;
		
		#1000
		
		// adjust mode, minutes
		adj = 1;
		sel = 0;
		
		#1000
		
		// adjust mode, seconds
		adj = 1;
		sel = 1;
		
		#1000
		
		// pause
		adj = 0;
		sel = 0;
		#100
		pause = 1;
		#100
		pause = 0;
		
		#1000
		
		pause = 1;
		#100
		pause = 0;
		
		#1000
		
		// reset
		#10
		rst = 1;
		#10
		rst = 0;
		#400; $finish;
	end
		
endmodule

