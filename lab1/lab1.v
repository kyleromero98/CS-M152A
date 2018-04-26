`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:11 01/16/2018 
// Design Name: 
// Module Name:    lab1 
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
module FPCVT(D, S, E, F);
	 // 12-bit 2's complement input
    input wire [11:0] D;
	 // sign bit
    output S;
	 // exponent bits
    output reg [2:0] E;
	 // mantissa bits
    output reg [3:0] F;
    
	 // declare as regs so we can assign
	 reg [11:0] mag;
    reg fifthbit;
    
	 // resolve sign bit right away
    assign S = D[11];
    
	 // when D changes
    always @ (D) begin
      // calculate signed magnitude
		if (D[11] == 1'b0) 
			assign mag = {1'b0, D[10:0]};
      else
         assign mag = (~D[11:0] + 1'b1);

		// use leading zeros to resolve exp, mantissa, and rounding bit
		casex(mag[11:4])
			{8'b00000000}: begin assign E=3'b000; assign F=mag[3:0]; assign fifthbit=1'b0; end
			{8'b00000001}: begin assign E=3'b001; assign F=mag[4:1]; assign fifthbit=mag[0]; end
			{8'b0000001x}: begin assign E=3'b010; assign F=mag[5:2]; assign fifthbit=mag[1]; end
			{8'b000001xx}: begin assign E=3'b011; assign F=mag[6:3]; assign fifthbit=mag[2]; end
			{8'b00001xxx}: begin assign E=3'b100; assign F=mag[7:4]; assign fifthbit=mag[3]; end
			{8'b0001xxxx}: begin assign E=3'b101; assign F=mag[8:5]; assign fifthbit=mag[4]; end
			{8'b001xxxxx}: begin assign E=3'b110; assign F=mag[9:6]; assign fifthbit=mag[5]; end
			{8'b01xxxxxx}: begin assign E=3'b111; assign F=mag[10:7]; assign fifthbit=mag[6]; end
			default: begin assign E=3'b111; assign F=4'b1111; assign fifthbit=1'b0; end
		endcase
			 
      // handle rounding bit
      if (fifthbit == 1'b1) begin
			assign F = F + 1;
         // carry and/or add 1
         if (F[3:0] == 4'b0000) begin
            assign F = 4'b1000;
				assign E = E + 1;
				// handle exponent overflow
				if (E[2:0] == 3'b000) begin
					assign F = 4'b1111;
               assign E = 3'b111;
				end
         end
      end
    end
endmodule


