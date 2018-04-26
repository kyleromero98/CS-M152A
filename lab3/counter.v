`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:50 02/20/2018 
// Design Name: 
// Module Name:    counter 
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
module counter(rst, pause, adj, sel, clk_count, clk_adj, min_ones, min_tens, sec_ones, sec_tens);
	// declare inputs/outputs
	input rst, pause, adj, sel, clk_count, clk_adj;
	output min_ones, min_tens, sec_ones, sec_tens;
	
	// declare wires and regs
	wire rst, pause, adj, sel, clk, clk_adj;
	wire [3:0] min_ones, min_tens, sec_ones, sec_tens;
	
	// set counts to initial values
	reg [3:0] min_ones_cnt = 4'b0000;
	reg [3:0] min_tens_cnt = 4'b0000;
	reg [3:0] sec_ones_cnt = 4'b0000;
	reg [3:0] sec_tens_cnt = 4'b0000;
	
	wire sel_clk;
	
	// choose the clock based on adj and sel
	clk_chooser clk_choose (
			.clk(clk_count),
			.clk_adj(clk_adj),
			.adj(adj),
			.sel_clk(sel_clk)
	);
	
	// assign outputs to these regs
	assign min_ones = min_ones_cnt;
	assign min_tens = min_tens_cnt;
	assign sec_ones = sec_ones_cnt;
	assign sec_tens = sec_tens_cnt;

	// when reset or the selected clock goes high
	always @ (posedge sel_clk or posedge rst) begin
		// reset all on rst
		if (rst) begin
			min_ones_cnt <= 4'b0000;
			min_tens_cnt <= 4'b0000;
			sec_ones_cnt <= 4'b0000;
			sec_tens_cnt <= 4'b0000;
		end // regular clock counting up
		else if (adj == 0 && ~pause) begin
			// account for all overflow cases
			if (sec_ones_cnt == 9 && sec_tens_cnt == 5) begin
				sec_ones_cnt <= 4'b0000;
				sec_tens_cnt <= 4'b0000;
				if (min_ones_cnt == 9 && min_tens_cnt == 9) begin
					min_ones_cnt <= 4'b0000;
					min_tens_cnt <= 4'b0000;
				end
				else if (min_ones_cnt == 9) begin
					min_ones_cnt <= 4'b0000;
					min_tens_cnt <= min_tens_cnt + 4'b0001;
				end
				else begin
					min_ones_cnt <= min_ones_cnt + 4'b0001;
				end
			end
			else if (sec_ones_cnt == 9) begin
				sec_ones_cnt <= 4'b0000;
				sec_tens_cnt <= sec_tens_cnt + 4'b0001;
			end
			else begin
				sec_ones_cnt <= sec_ones_cnt + 4'b0001;
			end
		end // increment seconds
		else if (adj == 1 && ~pause && sel) begin
			if (sec_ones_cnt == 9 && sec_tens_cnt == 5) begin
				sec_ones_cnt <= 4'b0000;
				sec_tens_cnt <= 4'b0000;
			end
			else if (sec_ones_cnt == 9) begin
				sec_ones_cnt <= 4'b0000;
				sec_tens_cnt <= sec_tens_cnt + 4'b0001;
			end
			else begin
				sec_ones_cnt <= sec_ones_cnt + 4'b0001;
			end
		end // increment minutes
		else if (adj == 1 && ~pause && ~sel) begin
			if (min_ones_cnt == 9 && min_tens_cnt == 9) begin
				min_ones_cnt <= 4'b0000;
				min_tens_cnt <= 4'b0000;
			end
			else if (min_ones_cnt == 9) begin
				min_ones_cnt <= 4'b0000;
				min_tens_cnt <= min_tens_cnt + 4'b0001;
			end
			else begin
				min_ones_cnt <= min_ones_cnt + 4'b0001;
			end
		end
	end

endmodule
