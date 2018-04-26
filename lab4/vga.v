`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:01 02/22/2018 
// Design Name: 
// Module Name:    vga 
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
module vga(pix_clk, rst, hsync, vsync, pixel_x, pixel_y, vidon);
  input pix_clk, rst;
  output hsync, vsync, pixel_x, pixel_y, vidon;
  
  reg vidon;
  wire hsync, vsync;
  reg [10:0] pixel_x, pixel_y;
  
  // parameters calculated from information here:
  // http://tinyvga.com/vga-timing/800x600@72Hz
  parameter tot_h_pixels = 11'd800;
  parameter tot_v_lines = 11'd521;
  parameter h_pulse = 11'd96;
  parameter v_pulse = 11'd2;
  parameter hbp = 11'd144;
  parameter hfp= 11'd784;
  parameter vbp = 11'd31;
  parameter vfp = 11'd511;
  
  reg [10:0] v_counter;
  reg [10:0] h_counter;
  
  always @ (posedge pix_clk or posedge rst) begin
    if (rst == 1) begin
      v_counter <= 0;
      h_counter <= 0;
    end
    else begin
      if (h_counter < tot_h_pixels - 1)
        h_counter <= h_counter + 1;
      else begin
        h_counter <= 0;
        if (v_counter < tot_v_lines - 1) 
          v_counter <= v_counter + 1;
        else
          v_counter <= 0;
      end
    end
  end
  
  assign hsync = (h_counter < h_pulse) ? 0:1;
  assign vsync = (v_counter < v_pulse) ? 0:1;
  
  always @ (posedge pix_clk) begin
    if (v_counter >= vbp && v_counter < vfp && h_counter >= hbp && h_counter < hfp) begin
      vidon <= 1;
      pixel_x <= h_counter - hbp;
      pixel_y <= v_counter - vbp;
    end
    else begin
      vidon <= 0;
      pixel_x <= 0;
      pixel_y <= 0;
    end
  end

endmodule
