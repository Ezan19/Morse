`timescale 1ns / 1ps

module morse_encoder_tb();

    reg clk;
    reg Left_dot;
    reg Mid_dash;
    reg Right_enter;
    reg Top_reset;
    reg Bot_back;

    wire [39:0] final_seq_of_in;
    wire [23:0] final_num_of_in;
    wire [2:0] char_pos_out;

    morse_encoder ME1 (
        .clk(clk),
        .Left_dot(Left_dot),
        .Mid_dash(Mid_dash),
        .Right_enter(Right_enter),
        .Top_reset(Top_reset),
        .Bot_back(Bot_back),
        .final_seq_of_in(final_seq_of_in),
        .final_num_of_in(final_num_of_in),
        .char_pos_out(char_pos_out)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        Left_dot = 0;
        Mid_dash = 0;
        Right_enter = 0;
        Top_reset = 0;
        Bot_back = 0;

        Top_reset = 1;
        #10 Top_reset = 0;
        #10;

        Left_dot = 1; // dot (1)
        #10 Left_dot = 0;
        #10;

        Mid_dash = 1; // dash (2)
        #10 Mid_dash = 0;
        #10;

        Right_enter = 1; // char 1 inputs: dot dash = letter A
        #10 Right_enter = 0;
        #10;

        Left_dot = 1; // dot (1)
        #10 Left_dot = 0;
        #10;
        
        Left_dot = 1; // dot (2)
        #10 Left_dot = 0;
        #10;
        
        Left_dot = 1; // dot (3)
        #10 Left_dot = 0;
        #10;
        
        Right_enter = 1; // char 2 inputs: dot dot dot = letter S
        #10 Right_enter = 0;
        #10;

        Bot_back = 1; // delete --> back to char 1 
        #10 Bot_back = 0;
        #10;

        Top_reset = 1; // reset --> back to char 0
        #10 Top_reset = 0;
        #10;

        Mid_dash = 1; // dash (1)
        #10 Mid_dash = 0;
        #10;
        
        Mid_dash = 1; // dash (2)
        #10 Mid_dash = 0;
        #10;

        Right_enter = 1; // char 1 inputs: dash dash = letter M
        #10 Right_enter = 0;
        #10;

        Mid_dash = 1; // dash (1)
        #10 Mid_dash = 0;
        #10;
        
        Left_dot = 1; // dot (2)
        #10 Left_dot = 0;
        #10;
        
        Left_dot = 1; // dot (3)
        #10 Left_dot = 0;
        #10;
        
        Left_dot = 1; // dot (4)
        #10 Left_dot = 0;
        #10;
        
        Left_dot = 1; // dot (5)
        #10 Left_dot = 0;
        #10;
        
        Right_enter = 1; // char 2 inputs: dash dot dot dot dot = number 6
        #10 Right_enter = 0;
        #10;

        $finish;
    end

endmodule
