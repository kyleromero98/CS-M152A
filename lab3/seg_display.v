`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:00 02/15/2018 
// Design Name: 
// Module Name:    seg_display 
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
module seg_display(digit, seg);
	// declare inputs/outputs
	input digit;
	output seg;
	
	wire [3:0] digit;
	wire [7:0] seg;
	
	// assign reg to output
	reg [7:0] seg_reg;
	assign seg = seg_reg;
	
	// selects the proper value for segment display based on digit
	always @ (*) begin
		case (digit)
			4'h0: seg_reg = 8'b11000000;
			4'h1: seg_reg = 8'b11111001;
			4'h2: seg_reg = 8'b10100100;
			4'h3: seg_reg = 8'b10110000;
			4'h4: seg_reg = 8'b10011001;
			4'h5: seg_reg = 8'b10010010;
			4'h6: seg_reg = 8'b10000010;
			4'h7: seg_reg = 8'b11111000;
			4'h8: seg_reg = 8'b10000000;
			4'h9: seg_reg = 8'b10010000;
			default: seg_reg = 8'b11111111;
		endcase
	end

endmodule
