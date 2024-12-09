`timescale 1ns / 1ps


module morse_encoder(
    input clk,               
    input Left_dot,                // Button for dot
    input Mid_dash,                // Button for dash
    input Right_enter,                // Button for Enter (moves position)
    input Top_reset,                // Button for reset (clear all)
    input Bot_back,                // Button to undo last character
    output reg [39:0] final_seq_of_in, // 40-bit output for the stored Morse code sequence
    output reg [23:0] final_num_of_in,     // 24-bit output for the corresponding bit representation
    output reg [2:0] char_pos_out          //outputs 3-bits for last position
);

    
    reg [4:0] temp_seq;    
    reg [2:0] seq_index;             
    reg [2:0] temp_num;      // Counter for the number of dots/dashes in the current sequence

    reg [39:0] seq_of_in;           
    reg [23:0] num_of_in;      

    reg [2:0] char_position;       // Counter for determining which "slot" we are storing the sequence in

    reg old_Left_dot, old_Mid_dash, old_Right_enter, old_Top_reset, old_Bot_back;   // Previous state 

    //Establish 0 to begin with
    initial begin
        old_Left_dot = 0;
        old_Mid_dash = 0;
        old_Right_enter = 0;
        old_Top_reset = 0;
        old_Bot_back = 0;
        seq_index = 0;
        temp_num = 3'b000;
        temp_seq = 5'b00000;
        seq_of_in = 0;
        num_of_in = 0;
        char_position = 3'b000;
    end
    
    always @(posedge clk) begin
        // Update previous button states
        old_Left_dot <= Left_dot;
        old_Mid_dash <= Mid_dash;
        old_Right_enter <= Right_enter;
        old_Top_reset <= Top_reset;
        old_Bot_back <= Bot_back;

        // Reset button brings everything back to 0
        if (Top_reset && !old_Top_reset) begin
            seq_index = 0;
            temp_num = 3'b000;
            temp_seq = 5'b00000;
            seq_of_in = 0;
            num_of_in = 0;
            char_position = 3'b000;
            char_pos_out = 3'b000;
            final_num_of_in = 0; 
        end

        // Increase the counter when dot or dash is pressed
        if ((Left_dot && !old_Left_dot) || (Mid_dash && !old_Mid_dash)) begin
            temp_num = temp_num + 1; // Increment the bit counter
        end
        
        // Ensure number of input doesn't go beyond 5
        if (temp_num > 5) begin
            temp_num = 1; // Wrap around to 1 if greater than 5
        end
        
        // Ensures if we are in position 0 there is nothing 
        if (char_position == 0) begin
            seq_of_in = 0; num_of_in = 0; 
        end
        
        // Encoding the dot and dash into binary (0 and 1)
        if (Left_dot && !old_Left_dot) begin
            temp_seq[seq_index] = 0; // Store dot as '0'
            seq_index = seq_index + 1; // Move to the next index in the sequence
        end else if (Mid_dash && !old_Mid_dash) begin
            temp_seq[seq_index] = 1; // Store dash as '1'
            seq_index = seq_index + 1; 
        end else if (Right_enter && !old_Right_enter) begin //When enter is press stores into correct slot
            case (char_position)
                0: begin seq_of_in[4:0] = temp_seq; num_of_in[2:0] = temp_num; end
                1: begin seq_of_in[9:5] = temp_seq; num_of_in[5:3] = temp_num; end
                2: begin seq_of_in[14:10] = temp_seq; num_of_in[8:6] = temp_num; end
                3: begin seq_of_in[19:15] = temp_seq; num_of_in[11:9] = temp_num; end
                4: begin seq_of_in[24:20] = temp_seq; num_of_in[14:12] = temp_num; end
                5: begin seq_of_in[29:25] = temp_seq; num_of_in[17:15] = temp_num; end
                6: begin seq_of_in[34:30] = temp_seq; num_of_in[20:18] = temp_num; end
                7: begin seq_of_in[39:35] = temp_seq; num_of_in[23:21] = temp_num; end
            endcase
            
            char_position = char_position + 1; // Increment to the next slot in the sequence
            char_pos_out = char_position;
            // Assigns temporary values into final output
            final_seq_of_in = seq_of_in;
            final_num_of_in = num_of_in;
            
            // After resets back to 0
            temp_num = 3'b000;
            temp_seq = 5'b00000;
            seq_index = 0;
        end
        
        // Undo: goes back one position and clears it
        if (Bot_back && !old_Bot_back) begin
            if (char_position > 0) begin
                char_position = char_position - 1; // Move to the previous slot
                char_pos_out = char_position;
                case (char_position)
                0: begin seq_of_in[4:0] = 0; num_of_in[2:0] = 0; end
                1: begin seq_of_in[9:5] = 0; num_of_in[5:3] = 0; end
                2: begin seq_of_in[14:10] = 0; num_of_in[8:6] = 0; end
                3: begin seq_of_in[19:15] = 0; num_of_in[11:9] = 0; end
                4: begin seq_of_in[24:20] = 0; num_of_in[14:12] = 0; end
                5: begin seq_of_in[29:25] = 0; num_of_in[17:15] = 0; end
                6: begin seq_of_in[34:30] = 0; num_of_in[20:18] = 0; end
                7: begin seq_of_in[39:35] = 0; num_of_in[23:21] = 0; end
                endcase
            
                // Update the output after clearing the slot
                final_seq_of_in = seq_of_in;
                final_num_of_in = num_of_in;
            end
        end
    end
endmodule