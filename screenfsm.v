`timescale 1ns / 1ps

module screenfsm(
        input clk,
        input [39:0] final_seq_of_in, // final 8-character output array
        input [23:0] final_num_of_in, // all possible 5-input sequences per character
        output [6:0] display, // 7-segment output display
        output reg [7:0] display_position, // output array of 8 character positions
        output reg clk_divider  // clock_divider to stabilize display output
    );
    
    reg [16:0] max_count; // set a possible max count up to 131,071 clock cycles
	initial begin
		max_count <= 0;
        clk_divider <= 0;
	end
	
	always @(negedge clk)
	begin
		// increment count until it reaches 100,000
		max_count = max_count + 1;
		if (max_count == 100000) begin
            clk_divider <= ~clk_divider;
            // Reset count to zero
            max_count <= 0;
        end
	end
      
    // decoder inputs
    reg [4:0] character; 
    reg [2:0] possible_inputs; 
    
    // instantiate decoder
    morse_decoder decoder1(.possible_chars(character),.possible_inputs(possible_inputs),.display(display));
       
    reg [2:0] display_state; // 8 (2^3) possible cycling display positions
    initial begin
		display_state = 0;
		display_position = ~8'b00000000;
	end
    
    always @(negedge clk_divider)
	begin
		
		display_state = display_state + 1;

		// one hot encoding of display position
		case (display_state)
            7: display_position = ~8'b10000000; 
            6: display_position = ~8'b01000000; 
            5: display_position = ~8'b00100000; 
            4: display_position = ~8'b00010000; 
            3: display_position = ~8'b00001000;
            2: display_position = ~8'b00000100;
            1: display_position = ~8'b00000010; 
            0: display_position = ~8'b00000001; 
            default: display_position = ~8'b00000000; // defaults to all off
        endcase
		
		// specific character sequence if inputs per position
		case (display_state) 
            7: character = final_seq_of_in[4:0]; 
            6: character = final_seq_of_in[9:5]; 
            5: character = final_seq_of_in[14:10]; 
            4: character = final_seq_of_in[19:15];
            3: character = final_seq_of_in[24:20];
            2: character = final_seq_of_in[29:25]; 
            1: character = final_seq_of_in[34:30]; 
            0: character = final_seq_of_in[39:35];    
            default: character = 5'b00000; // defaults to a blank
        endcase
       
        // possible number of inputs per position
        case (display_state)
            7: possible_inputs = final_num_of_in[2:0];
            6: possible_inputs = final_num_of_in[5:3];
            5: possible_inputs = final_num_of_in[8:6];
            4: possible_inputs = final_num_of_in[11:9];
            3: possible_inputs =final_num_of_in[14:12];
            2: possible_inputs = final_num_of_in[17:15];
            1: possible_inputs =final_num_of_in[20:18];
            0: possible_inputs = final_num_of_in[23:21];
        endcase             
	end
endmodule
