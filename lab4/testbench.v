`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:38:51 03/17/2018
// Design Name:   gamelogic
// Module Name:   /home/ise/vboxshared/kyjalab4/testbench.v
// Project Name:  kyjalab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gamelogic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg [10:0] pixel_x;
	reg [10:0] pixel_y;
	reg rst;
	reg sel;

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;

	// Instantiate the Unit Under Test (UUT)
	gamelogic uut (
		.clk(clk), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y), 
		.rst(rst), 
		.sel(sel), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);

	initial begin
		// initialize inputs
		clk = 0;
		rst = 0;
		sel = 0;
		pixel_x = 0;
		pixel_y = 0;
		#50;
	end
	
	always begin
		#1 clk = ~clk;
	end

	initial begin

		// Wait 100 ns for global reset to finish
		#200;
        
		// Add stimulus here
		
		// note: some of the later tests require changing parameters in design files
		// first test does nothing really so just wait
		#10
		pixel_x = 209;
		
		// second test pressing select
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		
		// reset test
		#10;
		rst = 1;
		#10;
		rst = 0;
		
		//	lose functionality (basically spam sel)
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		
		// speed scaling can be seen from above
		
		#100; $finish;	
	end
      
endmodule

