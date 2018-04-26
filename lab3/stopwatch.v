`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:06 02/15/2018 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(clk, rst, pause, sel, adj, seg, an);
	// inputs/outputs
	input clk, rst, pause, sel, adj;
	output seg, an;
	
	//declare as wires/regs
	wire adj;
	reg [7:0] seg;
	reg [3:0] an;
	
	wire [3:0] sec_ones_counter;
	wire [3:0] sec_tens_counter;
	
	wire [3:0] min_ones_counter;
	wire [3:0] min_tens_counter;
	
	wire [7:0] sec_ones_seg;
	wire [7:0] sec_tens_seg;
	wire [7:0] min_ones_seg;
	wire [7:0] min_tens_seg;
	
	wire two_hz, one_hz, seg_hz, blink_hz;
	
	wire rst_st, pause_st;
	
	debouncer rst_btn (
				.clk(clk),
				.btn(rst),
				.btn_state(rst_st)
			);
			
	debouncer pause_btn (
				.clk(clk),
				.btn(pause),
				.btn_state(pause_st)
			);

	clock_divider divider (
				.clk(clk),
				.rst(rst_st),
				.two_hz(two_hz),
				.one_hz(one_hz),
				.seg_hz(seg_hz),
				.blink_hz(blink_hz)
			);
			
	reg is_paused = 0;
	always @ (posedge pause_st) begin
			is_paused <= ~is_paused;
	end
				
	counter clock_counter (
			.rst(rst_st),
			.pause(is_paused),
			.adj(adj),
			.sel(sel),
			.clk_count(one_hz),
			.clk_adj(two_hz),
			.min_ones(min_ones_counter),
			.min_tens(min_tens_counter),
			.sec_ones(sec_ones_counter),
			.sec_tens(sec_tens_counter)
	);
			
	reg [1:0] cnt = 2'b00;		
	
	seg_display min_tens (
				.digit(min_tens_counter),
				.seg(min_tens_seg)
			);
			
	seg_display min_ones (
				.digit(min_ones_counter),
				.seg(min_ones_seg)
			);
			
	seg_display sec_tens (
				.digit(sec_tens_counter),
				.seg(sec_tens_seg)
			);
			
	seg_display sec_ones (
				.digit(sec_ones_counter),
				.seg(sec_ones_seg)
			);
			
	wire[7:0] blank_seg;
	seg_display blank (
				.digit(4'b1111),
				.seg(blank_seg)
			);
	
	always @ (posedge seg_hz) begin
		if (adj == 1) begin
			if (~sel) begin
				if (cnt == 0) begin
					an <= 4'b0111;
					if (blink_hz)
						seg <= min_tens_seg;
					else
						seg <= blank_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 1) begin
					an <= 4'b1011;
					if (blink_hz)
						seg <= min_ones_seg;
					else
						seg <= blank_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 2) begin
					an <= 4'b1101;
					seg <= sec_tens_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 3) begin
					an <= 4'b1110;
					seg <= sec_ones_seg;
					cnt <= cnt + 1;
				end
			end
			else begin
				if (cnt == 0) begin
					an <= 4'b0111;
					seg <= min_tens_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 1) begin
					an <= 4'b1011;
					seg <= min_ones_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 2) begin
					an <= 4'b1101;
					if (blink_hz)
						seg <= sec_tens_seg;
					else
						seg <= blank_seg;
					cnt <= cnt + 1;
				end
				else if (cnt == 3) begin
					an <= 4'b1110;
					if (blink_hz)
						seg <= sec_ones_seg;
					else
						seg <= blank_seg;
					cnt <= cnt + 1;
				end
			end
		end
		else begin
			if (cnt == 0) begin
				an <= 4'b0111;
				seg <= min_tens_seg;
				cnt <= cnt + 1;
			end
			else if (cnt == 1) begin
				an <= 4'b1011;
				seg <= min_ones_seg;
				cnt <= cnt + 1;
			end
			else if (cnt == 2) begin
				an <= 4'b1101;
				seg <= sec_tens_seg;
				cnt <= cnt + 1;
			end
			else if (cnt == 3) begin
				an <= 4'b1110;
				seg <= sec_ones_seg;
				cnt <= cnt + 1;
			end
		end
	end
	
endmodule
