`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:42:51 03/15/2018
// Design Name:   gamecontroller
// Module Name:   /home/ise/vboxshared/kyjalab4/game_tb.v
// Project Name:  kyjalab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gamecontroller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module game_tb;

	// Inputs
	reg clk;
	reg rst;
	reg sel;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [1:0] vgaBlue;

	// Instantiate the Unit Under Test (UUT)
	gamecontroller uut (
		.clk(clk), 
		.rst(rst), 
		.sel(sel), 
		.hsync(hsync), 
		.vsync(vsync), 
		.vgaRed(vgaRed), 
		.vgaGreen(vgaGreen), 
		.vgaBlue(vgaBlue)
	);
	
	initial begin
		// initialize inputs
		clk = 0;
		rst = 0;
		sel = 0;
		#50;
	end
	
	always begin
		#2 clk = ~clk;
	end

	initial begin

		// Wait 100 ns for global reset to finish
		#200;
        
		// Add stimulus here
		// first test does nothing really so just wait
		#200;
		
		// second test pressing select
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		sel = 0;
		#10;
		sel = 1;
		#10;
		
		#100; $finish;
		

	end
      
endmodule

