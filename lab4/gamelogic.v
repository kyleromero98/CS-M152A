`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:31 03/06/2018 
// Design Name: 
// Module Name:    gamelogic 
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
module gamelogic(clk, pixel_x, pixel_y, rst, sel, red, green, blue);
  // input/output declarations
  input clk, rst, sel;
  input [10:0] pixel_x, pixel_y;
  output red, green, blue;
  
  // reg and size declarations
  reg [2:0] red, green;
  reg [1:0] blue;
  
  parameter BLOCK_WIDTH = 32;
  parameter HALF_B_WIDTH = BLOCK_WIDTH / 2;
  parameter HALF_B_WIDTH_G = HALF_B_WIDTH - 2;
  parameter H_LOWER = 208;
  parameter H_UPPER = 432;
  
  parameter INITIAL_X = 320;
  parameter INITIAL_Y = 464;
  
  parameter ST_GAME = 2'b00;
  parameter ST_WON = 2'b01;
  parameter ST_LOSE = 2'b10;
  
  reg signed [11:0] current_x [2:0];
	reg signed [11:0] current_y [2:0];
  
  reg signed [11:0] previous_x [14:0] [2:0];
  
  integer index;
  integer index2;
  integer flag;
  
  reg [63:0] clk_counter = 0;
  reg clk_first = 0;
  reg [3:0] currentLevel = 0;
  reg isMovingRight = 1;
  reg prev_clk = 0;
  reg prev_sel = 0;
  reg [1:0] curr_st = ST_GAME;
  reg [1:0] numBlocks = 3;
  wire [63:0] move_speed;
  
  initial begin
      // initialize initial x values
      current_x[0] = INITIAL_X - BLOCK_WIDTH;
      current_x[1] = INITIAL_X;
      current_x[2] = INITIAL_X + BLOCK_WIDTH;
      for (index = 0; index < 3; index=index + 1) begin
        current_y[index] = INITIAL_Y;
      end
      // reset stored values to 0
      for (index = 0; index < 15; index=index+1) begin
        for (index2 = 0; index2 < 3; index2=index2+1) begin
          previous_x[index][index2] = 0;
        end
      end
  end
	
  // reduced clock for movement
	always @ (posedge clk) begin
    // handle reset or select button press
    if (rst) begin
      // reset all values
      curr_st = ST_GAME;
      // initialize initial x values
      current_x[0] = INITIAL_X - BLOCK_WIDTH;
      current_x[1] = INITIAL_X;
      current_x[2] = INITIAL_X + BLOCK_WIDTH;
      
      for (index = 0; index < 3; index=index + 1) begin
        current_y[index] = INITIAL_Y;
      end
      currentLevel = 0;
      isMovingRight = 1;
      numBlocks = 3;
      // reset stored values to 0
      for (index = 0; index < 15; index=index+1) begin
        for (index2 = 0; index2 < 3; index2=index2+1) begin
          previous_x[index][index2] = 0;
        end
      end
    end
    else if (prev_sel == 0 && sel == 1) begin
      if (currentLevel != 0) begin
			if (numBlocks == 3) begin
				if (current_x[0] == previous_x[currentLevel-1][0]) begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = previous_x[currentLevel-1][1];
					current_x[2] = previous_x[currentLevel-1][2];
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 3;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][1]) begin
					current_x[0] = previous_x[currentLevel-1][1];
					current_x[1] = previous_x[currentLevel-1][2];
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 2;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][2]) begin
					current_x[0] = previous_x[currentLevel-1][2];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[2] == previous_x[currentLevel-1][1])begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = previous_x[currentLevel-1][1];
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 2;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[2] == previous_x[currentLevel-1][0])begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else begin
					curr_st = ST_LOSE;
				end
			end else if (numBlocks == 2) begin
				if (current_x[0] == previous_x[currentLevel-1][0]) begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = previous_x[currentLevel-1][1];
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 2;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][1] && current_x[1]!= previous_x[currentLevel-1][2]) begin
					current_x[0] = previous_x[currentLevel-1][1];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[1] == previous_x[currentLevel-1][0]) begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][1] && current_x[1] == previous_x[currentLevel-1][2]) begin
					current_x[0] = previous_x[currentLevel-1][1];
					current_x[1] = previous_x[currentLevel-1][2];
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 2;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][2]) begin
					current_x[0] = previous_x[currentLevel-1][2];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else begin
					curr_st = ST_LOSE;
				end
			end else if (numBlocks == 1) begin
				if (current_x[0] == previous_x[currentLevel-1][0]) begin
					current_x[0] = previous_x[currentLevel-1][0];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][1]) begin
					current_x[0] = previous_x[currentLevel-1][1];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else if (current_x[0] == previous_x[currentLevel-1][2]) begin
					current_x[0] = previous_x[currentLevel-1][2];
					current_x[1] = 0;
					current_x[2] = 0;
					previous_x[currentLevel][0] = current_x[0];
					previous_x[currentLevel][1] = current_x[1];
					previous_x[currentLevel][2] = current_x[2];
					numBlocks = 1;
					currentLevel = currentLevel + 1;
				end
				else begin
					curr_st = ST_LOSE;
				end
			end
			
			if (currentLevel == 7 && numBlocks == 3) begin
				current_x[0] = previous_x[currentLevel-1][0];
				current_x[1] = previous_x[currentLevel-1][1];
				current_x[2] = 0;
				previous_x[currentLevel][0] = current_x[0];
				previous_x[currentLevel][1] = current_x[1];
				previous_x[currentLevel][2] = current_x[2];
				numBlocks = 2;
			end
			
			if (currentLevel == 11 && numBlocks == 2) begin
				current_x[0] = previous_x[currentLevel-1][0];
				current_x[1] = 0;
				current_x[2] = 0;
				previous_x[currentLevel][0] = current_x[0];
				previous_x[currentLevel][1] = current_x[1];
				previous_x[currentLevel][2] = current_x[2];
				numBlocks = 1;
			end
		end
      else begin
        for (index = 0; index < 3; index=index+1) begin
          previous_x[currentLevel][index] = current_x[index];
        end
		  currentLevel = currentLevel + 1;
      end
    end
  
    // generate movement clock
	if (clk_counter >= move_speed) begin
		clk_counter = 0;
      clk_first = 1;
   end
   else begin
		clk_counter = clk_counter + 1;
      clk_first = 0;
	end
    
    // movement time
   if (prev_clk == 0 && clk_first == 1) begin
		for (index = 0; index < 3; index=index+1) begin
			current_y[index] = 480 - ((currentLevel * 32) + 16); 
		end
		if (isMovingRight == 1) begin
			for (index = 0; index < numBlocks; index=index+1) begin
				if (current_x[index] != 0) begin
					current_x[index] = current_x[index] + BLOCK_WIDTH;
				end
			end
		end else begin
			for (index = 0; index < numBlocks; index=index+1) begin
				if (current_x[index] != 0) begin
					current_x[index] = current_x[index] - BLOCK_WIDTH;
				end
			end
		end
      
		for (index = 2; index >= 0; index=index-1) begin
			if (current_x[index] + HALF_B_WIDTH >= H_UPPER && current_x[index] != 0) begin
				isMovingRight = 0;
			end 
		end
		
		for (index = 0; index < numBlocks; index=index+1) begin
			if (current_x[index] - HALF_B_WIDTH <= H_LOWER && current_x[index] != 0) begin
				isMovingRight = 1;
			end
      end
    end
    
    // handling winning
    if (currentLevel >= 15) begin
      curr_st = ST_WON;
    end
    
    prev_clk = clk_first;
    prev_sel = sel;
	end
  
  // graphics driver
  always @ (posedge clk) begin
    if (curr_st == ST_GAME) begin
      // game graphics
		// side borders
      if (pixel_x < H_LOWER || pixel_x > H_UPPER) begin
        red[2:0] = 3'b000;
        green[2:0] = 3'b101;
        blue[1:0] = 2'b11;
      end
      else begin
        red[2:0] = 3'b000;
        green[2:0] = 3'b000;
        blue[1:0] = 2'b00;
      end
		
      for (index = 0; index < 3; index=index+1) begin
        if (pixel_x >= (current_x[index] - HALF_B_WIDTH_G) && pixel_x <= (current_x[index] + HALF_B_WIDTH_G) && pixel_y >= (current_y[index] - HALF_B_WIDTH_G) && pixel_y <= (current_y[index] + HALF_B_WIDTH_G))
        begin
			if (current_x[index] != 0) begin
				red[2:0] = 3'b111;
				green[2:0] = 3'b111;
				blue[1:0] = 2'b11;
			end
        end
      end
      
      for (index = 0; index < currentLevel; index=index+1) begin
        for (index2 = 0; index2 < 3; index2=index2+1) begin
          if (index < 15) begin
            if (pixel_x >= (previous_x[index][index2] - HALF_B_WIDTH_G) && pixel_x <= (previous_x[index][index2] + HALF_B_WIDTH_G) && pixel_y >= ((480 - ((index + 1) * BLOCK_WIDTH) + 2)) && pixel_y <= ((480 - (index * BLOCK_WIDTH)) - 2)) begin
              red[2:0] = 3'b111;
              green[2:0] = 3'b111;
              blue[1:0] = 2'b11;
            end
        end
        end
      end
    end
    else if (curr_st == ST_WON) begin
       //we won the game so turn green
      red[2:0] = 3'b000;
      green[2:0] = 3'b111;
      blue[1:0] = 2'b00;
    end
    else if (curr_st == ST_LOSE) begin
      red[2:0] = 3'b111;
      green[2:0] = 3'b000;
      blue[1:0] = 2'b00;
    end
	end
  
  speed_controller speed (.current_lvl(currentLevel),
                          .move_speed(move_speed));
endmodule
