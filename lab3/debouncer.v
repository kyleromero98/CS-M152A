`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:27 02/15/2018 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(clk, btn, btn_state);
	// inputs/outputs
	input clk, btn;
	output btn_state;
	
	// assign outputs
	reg btn_state_reg = 0;
	assign btn_state = btn_state_reg;
	
	reg[19:0] counter;
	
	// determines the state of the button
	always @ (posedge clk) begin
		if (btn == 0) begin
			counter <= 0;
			btn_state_reg <= 0;
		end
		else begin
			counter <= counter + 1'b1;
			// means button has been down for awhile
			if (counter == 20'hfffff) begin
				btn_state_reg <= 1;
				counter <= 0;
			end
		end	
	end
	
endmodule
