`timescale 1ns / 1ps

module morse_decoder(
    input [4:0] possible_chars,   // 5 maximum inputs of dot/dash (for numbers 0-9)
    input [2:0] possible_inputs, // 6 possible cases of dot/dash inputs
    output reg [6:0] display // output of 7-segment dispaly
);

// Instantiating blank variables for leading zeros for letters/blank
    wire [0:0] one_blank = 1'b0;
    wire [1:0] two_blanks = 2'b00;
    wire [2:0] three_blanks = 3'b000;
    wire [3:0] four_blanks = 4'b0000;
    wire [4:0] five_blanks = 5'b00000;

// 7-segment representations of letters based on Siekoo alphabet
    wire [6:0] A = ~7'b1111101; 
    wire [6:0] B = ~7'b1110011;
    wire [6:0] C = ~7'b1100001; 
    wire [6:0] D = ~7'b1111001;
    wire [6:0] E = ~7'b1100111; 
    wire [6:0] F = ~7'b1000111;
    wire [6:0] G = ~7'b0110111; 
    wire [6:0] H = ~7'b1010011; 
    wire [6:0] I = ~7'b0000101; 
    wire [6:0] J = ~7'b0110100; 
    wire [6:0] K = ~7'b1010111;
    wire [6:0] L = ~7'b0100011;
    wire [6:0] M = ~7'b1010101; 
    wire [6:0] N = ~7'b1010001; 
    wire [6:0] O = ~7'b1110001; 
    wire [6:0] P = ~7'b1001111;
    wire [6:0] Q = ~7'b1011110; 
    wire [6:0] R = ~7'b1000001;
    wire [6:0] S = ~7'b0110110; 
    wire [6:0] T = ~7'b1100011;
    wire [6:0] U = ~7'b0110001; 
    wire [6:0] V = ~7'b0101010; 
    wire [6:0] W = ~7'b1101010; 
    wire [6:0] X = ~7'b0010001; 
    wire [6:0] Y = ~7'b1111010;
    wire [6:0] Z = ~7'b0101101; 

// 7-segment representations of numbers
    wire [6:0] number_0 = ~7'b0111111;
    wire [6:0] number_1 = ~7'b0011000;
    wire [6:0] number_2 = ~7'b1101101;
    wire [6:0] number_3 = ~7'b1111100;
    wire [6:0] number_4 = ~7'b1011010;
    wire [6:0] number_5 = ~7'b1110110;
    wire [6:0] number_6 = ~7'b1110111;
    wire [6:0] number_7 = ~7'b0011100;
    wire [6:0] number_8 = ~7'b1111111;
    wire [6:0] number_9 = ~7'b1111110;

    always @(*) begin
        case (possible_inputs)
        
            // if no inputs, output blank
            0: case (possible_chars)
                five_blanks: display = ~7'b0000000; // blank
                default: display = ~7'b0000000; // default blank
               endcase
            
            // if 1 input, output 2 (2^1) possible letters
            1: case (possible_chars)
                {four_blanks, 1'b1}: display = T;
                {four_blanks, 1'b0}: display = E; 
                default: display = ~7'b0000000; // default blank
               endcase
            
            // if 2 inputs, output 4 (2^2) possible letters
            2: case (possible_chars)
                {three_blanks, 2'b11}: display = M; 
                {three_blanks, 2'b01}: display = N; 
                {three_blanks, 2'b10}: display = A; 
                {three_blanks, 2'b00}: display = I; 
                default: display = ~7'b0000000; // default blank
               endcase

            // if 3 inputs, output 8 (2^3) possible letters
            3: case (possible_chars)
                {two_blanks, 3'b111}: display = O;
                {two_blanks, 3'b011}: display = G; 
                {two_blanks, 3'b101}: display = K; 
                {two_blanks, 3'b001}: display = D; 
                {two_blanks, 3'b000}: display = S; 
                {two_blanks, 3'b100}: display = U; 
                {two_blanks, 3'b010}: display = R; 
                {two_blanks, 3'b110}: display = W; 
                default: display = ~7'b0000000; // default blank
               endcase

            // if 4 inputs, output remaining 12 letters
            4: case (possible_chars)
                {one_blank, 4'b1011}: display = Q; 
                {one_blank, 4'b0011}: display = Z; 
                {one_blank, 4'b1101}: display = Y; 
                {one_blank, 4'b0101}: display = C; 
                {one_blank, 4'b1001}: display = X; 
                {one_blank, 4'b0001}: display = B; 
                {one_blank, 4'b1110}: display = J; 
                {one_blank, 4'b0110}: display = P; 
                {one_blank, 4'b0010}: display = L; 
                {one_blank, 4'b0100}: display = F; 
                {one_blank, 4'b1000}: display = V; 
                {one_blank, 4'b0000}: display = H; 
                default: display = ~7'b0000000; // default blank
               endcase

            // if 5 inputs, output a number 0-9
            5: case (possible_chars)
                {5'b11111}: display = number_0;
                {5'b11110}: display = number_1;
                {5'b11100}: display = number_2;
                {5'b11000}: display = number_3;
                {5'b10000}: display = number_4;
                {5'b00000}: display = number_5;
                {5'b00001}: display = number_6;
                {5'b00011}: display = number_7;
                {5'b00111}: display = number_8;
                {5'b01111}: display = number_9;
                default: display = ~7'b0000000; // default blank
               endcase

            default: display = ~7'b0000000; // default blank
        endcase
    end
endmodule 
