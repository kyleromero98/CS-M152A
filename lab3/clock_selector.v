`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:35 02/15/2018 
// Design Name: 
// Module Name:    clock_selector 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_selector(clk, clk_adj, adjust, clock);
	// inputs/outputs
	input clk, clk_adj, adjust;
	output clock;
	
	wire [1:0] adjust;
	
	reg clock_reg;
	assign clock = clock_reg;
	
	always @ (*) begin
		if (adjust == 0) begin
			clock_reg = clk;
		end
		else begin
			clock_reg = clk_adj;
		end
	end

endmodule
