`timescale 1ns / 1ps
module last_letter(
        input clk_divider, //makes clock 4 times slower
        input [2:0] char_pos, //up to 8 display states
        input [39:0] final_seq_of_in, // final 8-character output array
        input [23:0] final_num_of_in, // all possible 5-input sequences per character
        output [6:0] display // 7-segment output display

    );
       
    //decoder inputs
    reg [4:0] character;
    reg [2:0] possible_inputs;
    
    // instantiate decoder
    morse_decoder decoder1(.possible_chars(character),.possible_inputs(possible_inputs),.display(display));
       
    reg [2:0] display_state; // 8 (2^3) possible static display positions
    initial begin
		display_state = 0;
	end
    
    always @(negedge clk_divider)
	begin
		
		display_state = 7-char_pos;//sets position of first character
		
		if (display_state < 7) begin 
		// specific character sequence if inputs per position
		case (display_state+1) 
            7: character = final_seq_of_in[4:0]; 
            6: character = final_seq_of_in[9:5]; 
            5: character = final_seq_of_in[14:10];
            4: character = final_seq_of_in[19:15];
            3: character = final_seq_of_in[24:20];
            2: character = final_seq_of_in[29:25];
            1: character = final_seq_of_in[34:30];
            0: character = final_seq_of_in[39:35];    
            
            default: character = 5'b00000; 
        endcase
        
        case (display_state+1)  // possible number of inputs per position
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
       else begin //clears screen after exceeding 8th character position
            possible_inputs = 0;
            character = 5'b00000; 
       end
       
              
	end
    
endmodule

