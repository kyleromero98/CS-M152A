`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:29 02/15/2018 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(clk, rst, two_hz, one_hz, seg_hz, blink_hz);
	// inputs and outputs
	input wire clk, rst;
	output wire two_hz, one_hz, seg_hz, blink_hz;
	
	// factors for clocks
	localparam TWO_HZ_DIV = 25000000;
	localparam ONE_HZ_DIV = 50000000;
	localparam SEG_DIV = 50000;
	localparam BLINK_DIV = 12500000;
	
	// regs and counters for each clock
	reg two_hz_reg;
	reg [31:0] two_hz_counter;
	reg one_hz_reg;
	reg [31:0] one_hz_counter;
	reg seg_reg;
	reg [31:0] seg_counter;
	reg blink_reg;
	reg [31:0] blink_counter;
	
	// assign all outputs to regs
	assign two_hz = two_hz_reg;
	assign one_hz = one_hz_reg;
	assign seg_hz = seg_reg;
	assign blink_hz = blink_reg;
	
	// two hz divider
	always @ (posedge (clk) or posedge (rst)) begin
		if (rst == 1'b1) begin
			two_hz_counter <= 32'b0;
			two_hz_reg <= 1'b0;
		end
		else if (two_hz_counter == TWO_HZ_DIV - 1) begin
			two_hz_counter <= 32'b0;
			two_hz_reg <= ~two_hz;
		end
		else begin
			two_hz_counter <= two_hz_counter + 32'b1;
			two_hz_reg <= two_hz;
		end
	end
	
	// one hz divider
	always @ (posedge (clk) or posedge (rst)) begin
		if (rst == 1'b1) begin
			one_hz_counter <= 32'b0;
			one_hz_reg <= 1'b0;
		end
		else if (one_hz_counter == ONE_HZ_DIV - 1) begin
			one_hz_counter <= 32'b0;
			one_hz_reg <= ~one_hz;
		end
		else begin
			one_hz_counter <= one_hz_counter + 32'b1;
			one_hz_reg <= one_hz;
		end
	end
	
	// segment divider
	always @ (posedge (clk) or posedge (rst)) begin
		if (rst == 1'b1) begin
			seg_counter <= 32'b0;
			seg_reg <= 1'b0;
		end
		else if (seg_counter == SEG_DIV - 1) begin
			seg_counter <= 32'b0;
			seg_reg <= ~seg_hz;
		end
		else begin
			seg_counter <= seg_counter + 32'b1;
			seg_reg <= seg_hz;
		end
	end
	
	// blinking clock divider
	always @ (posedge (clk) or posedge (rst)) begin
		if (rst == 1'b1) begin
			blink_counter <= 32'b0;
			blink_reg <= 1'b0;
		end
		else if (blink_counter == BLINK_DIV - 1) begin
			blink_counter <= 32'b0;
			blink_reg <= ~blink_hz;
		end
		else begin
			blink_counter <= blink_counter + 32'b1;
			blink_reg <= blink_hz;
		end
	end
	
endmodule
