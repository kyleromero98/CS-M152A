`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:41:01 02/20/2018 
// Design Name: 
// Module Name:    clk_chooser 
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
module clk_chooser(clk, clk_adj, adj, sel_clk);
	input clk, clk_adj, adj;
	output sel_clk;
	
	reg clk_reg;
	assign sel_clk = clk_reg;
	
	// selects the proper clock based on the value of adj, either 1hz or 2hz
	always @* begin
		if (adj == 0) begin
			clk_reg = clk;
		end
		else begin
			clk_reg = clk_adj;
		end
	end

endmodule
