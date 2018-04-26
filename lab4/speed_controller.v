`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:25:27 03/08/2018 
// Design Name: 
// Module Name:    speed_controller 
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
module speed_controller(current_lvl, move_speed);
  input current_lvl;
  output move_speed;
  
  wire [3:0] current_lvl;
  reg [63:0] move_speed = 64'd8000000;
  
  always @ (current_lvl) begin
    case (current_lvl)
      {4'b0000}  : move_speed = 64'd11000000;
      {4'b0001}  : move_speed = 64'd10600000;
      {4'b0010}  : move_speed = 64'd10200000;
      {4'b0011}  : move_speed = 64'd9800000;
      {4'b0100}  : move_speed = 64'd9400000;
      {4'b0101}  : move_speed = 64'd9000000;
      {4'b0110}  : move_speed = 64'd8600000;
      {4'b0111}  : move_speed = 64'd8200000;
      {4'b1000}  : move_speed = 64'd7800000;
      {4'b1001}  : move_speed = 64'd7400000;
      {4'b1010}  : move_speed = 64'd7000000;
      {4'b1011}  : move_speed = 64'd6600000;
      {4'b1100}  : move_speed = 64'd6200000;
      {4'b1101}  : move_speed = 64'd5800000;
      {4'b1110}  : move_speed = 64'd5400000;
      default : move_speed = 64'd8000000; 
    endcase
  end
endmodule
