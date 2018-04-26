`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:52 02/27/2018 
// Design Name: 
// Module Name:    gamecontroller 
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
module gamecontroller(clk, rst, sel, hsync, vsync, vgaRed, vgaGreen, vgaBlue);
  input clk, rst, sel;
  output hsync, vsync, vgaRed, vgaGreen, vgaBlue;
  
  reg[2:0] vgaRed, vgaGreen;
  reg[1:0] vgaBlue;
  
  wire clk_25;
  wire hsync_out;
	wire vsync_out;
  wire vidon;
	 
	wire [10:0] pixel_x;
	wire [10:0] pixel_y;
	 
	wire [2:0] im_game_r;
	wire [2:0] im_game_g;
	wire [1:0] im_game_b;
  
  wire rst_st, sel_st;
	 
	assign hsync = ~hsync_out;
	assign vsync = ~vsync_out;
  
  always @ (posedge clk_25) begin	
    if (vidon) begin
			vgaRed[2:0] = im_game_r;
			vgaGreen[2:0] = im_game_g;
			vgaBlue[1:0] = im_game_b;
    end
    else begin
      vgaRed[2:0] = 3'b000;
			vgaGreen[2:0] = 3'b000;
			vgaBlue[1:0] = 2'b00;
    end
	end
  
  gamelogic game(.clk(clk),
						 .pixel_x(pixel_x),
						 .pixel_y(pixel_y),
						 .rst(rst_st),
						 .sel(sel_st),
						 .red(im_game_r),
						 .green(im_game_g),
						 .blue(im_game_b));
  
  vga vgacontrol(.pix_clk(clk_25),
      .rst(rst_st),
      .hsync(hsync_out),
      .vsync(vsync_out),
      .pixel_x(pixel_x),
      .pixel_y(pixel_y),
      .vidon(vidon));
      
  debouncer rst_button (.clk(clk),
                        .btn(rst),
                        .btn_state(rst_st));
                        
  debouncer sel_button (.clk(clk),
                        .btn(sel),
                        .btn_state(sel_st));
      
  Clock clk25(.CLK_IN1(clk),
              .CLK_OUT1(clk_25));

endmodule
