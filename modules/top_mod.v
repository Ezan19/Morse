`timescale 1ns / 1ps

module vga_top(
input Left_dot,    // input left button for dot
input Mid_dash,    // input center button for dash
input Right_enter, // input right button for enter
input Top_reset,   // input top button for reset all
input Bot_back,    // input bottom button for backspace
input clk, 
output reg [3:0] vga_r, // output of vga red to control color
output reg [3:0]vga_g,  // output of vga green to control color
output reg [3:0]vga_b,  // output of vga blue to control color
output h_sync,          // output horizontal sync for enable
output v_sync,          // output vertical sync for enable
output[7:0] display_position, // output of 8 possibe display positions
output[6:0] display           // output for 7-segment display 
    );

// 7-segment display
       wire [39:0] final_seq_of_in;
       wire [23:0] final_num_of_in;

// debounced button
       wire clean_dot;
       wire clean_dash;
       wire clean_enter;
       wire clean_reset;
       wire clean_back;
       
// vga index 7-segment dislay 
       wire [6:0] lastLetter_disp;
       wire newClk, ledOn;
       wire [2:0] char_pos;

// debouncer button instantiations   
       debouncer db1(
       .noisy_button(Left_dot),
       .clk(clk),
       .clean_button(clean_dot)
       );
       
       debouncer db2(
       .noisy_button(Mid_dash),
       .clk(clk),
       .clean_button(clean_dash)
       );
       
       debouncer db3(
       .noisy_button(Right_enter),
       .clk(clk),
       .clean_button(clean_enter)
       );
       
       debouncer db4(
       .noisy_button(Top_reset),
       .clk(clk),
       .clean_button(clean_reset)
       );
       
       debouncer db5(
       .noisy_button(Bot_back),
       .clk(clk),
       .clean_button(clean_back)
       );
      
// morse encoder instantiation 
     morse_encoder encoder1 (
        .clk(clk),
        .Left_dot(clean_dot), 
        .Mid_dash(clean_dash), 
        .Right_enter(clean_enter),
        .Top_reset(clean_reset), 
        .Bot_back(clean_back),
        .final_seq_of_in(final_seq_of_in),
        .final_num_of_in(final_num_of_in),
        .char_pos_out(char_pos)
     );
     
     
// screen fsm instantiation    
     screenfsm fsm1 (
        .clk(clk),
        .final_seq_of_in(final_seq_of_in),
        .final_num_of_in(final_num_of_in),
        .display(display),
        .display_position(display_position),
        .clk_divider(Newclk2)
    );

// clock divider instantiation for vga
    clk_divider clkDiv (clk, newClk);
    
   
// last letter instantiation for vga 
    last_letter LL1 (
        .clk_divider(Newclk2),
        .char_pos(char_pos),
        .final_seq_of_in(final_seq_of_in),
        .final_num_of_in(final_num_of_in),
        .display(lastLetter_disp)
    );
    
// vga output based on ascii_rom 
reg [10:0] test_addr_fixed1;

// map 7-segment character to ascii_rom character
always @(posedge clk) begin
case(lastLetter_disp)

~7'b1111101://A
        test_addr_fixed1 <= 11'h410;
~7'b1110011://B
        test_addr_fixed1 <= 11'h420;
~7'b1100001://C
        test_addr_fixed1 <= 11'h430;
~7'b1111001://D
        test_addr_fixed1 <= 11'h440;
~7'b1100111://E
        test_addr_fixed1 <= 11'h450;
~7'b1000111://F
        test_addr_fixed1 <= 11'h460;
~7'b0110111://G 
        test_addr_fixed1 <= 11'h470;
~7'b1010011://H
        test_addr_fixed1 <= 11'h480;
~7'b0000101://I
        test_addr_fixed1 <= 11'h490;
~7'b0110100://J 
        test_addr_fixed1 <= 11'h4a0;
~7'b1010111://K
        test_addr_fixed1 <= 11'h4b0;
~7'b0100011://L
        test_addr_fixed1 <= 11'h4c0;
~7'b1010101://M
        test_addr_fixed1 <= 11'h4d0;
~7'b1010001://N
        test_addr_fixed1 <= 11'h4e0;
~7'b1110001://O
        test_addr_fixed1 <= 11'h4f0;
~7'b1001111://P
        test_addr_fixed1 <= 11'h500;
~7'b1011110://Q
        test_addr_fixed1 <= 11'h510;
~7'b1000001://R
        test_addr_fixed1 <= 11'h520;
~7'b0110110://S
        test_addr_fixed1 <= 11'h530;
~7'b1100011://T
        test_addr_fixed1 <= 11'h540;
~7'b0110001://U
        test_addr_fixed1 <= 11'h550;
~7'b0101010://V
        test_addr_fixed1 <= 11'h560;
~7'b1101010://W
        test_addr_fixed1 <= 11'h570;
~7'b0010001://X
        test_addr_fixed1 <= 11'h580;
~7'b1111010://Y
        test_addr_fixed1 <= 11'h590;
~7'b0101101://Z
        test_addr_fixed1 <= 11'h5a0;
~7'b0111111://0
test_addr_fixed1 <= 11'h300;
~7'b0011000://1
test_addr_fixed1 <= 11'h310;
 ~7'b1101101://2
test_addr_fixed1 <= 11'h320;
~7'b1111100://3
test_addr_fixed1 <= 11'h330;
~7'b1011010://4
test_addr_fixed1 <= 11'h340;
 ~7'b1110110://5
test_addr_fixed1 <= 11'h350;
 ~7'b1110111://6
test_addr_fixed1 <= 11'h360;
 ~7'b0011100://7
test_addr_fixed1 <= 11'h370;
 ~7'b1111111://8 
test_addr_fixed1 <= 11'h380;
 ~7'b1111110://9
test_addr_fixed1 <= 11'h390;
    default:
        test_addr_fixed1 <= 11'h400;
        endcase
end

// vga controller instantiation
vga_controller vga_con1 (newClk, char_pos, test_addr_fixed1, h_sync, v_sync, ledOn);

// output vga characters in white color
    always@(posedge newClk)
    begin
      if(ledOn) begin
            vga_r <= 4'b1111;
            vga_g <= 4'b1111;
            vga_b <= 4'b1111;
      end
      else begin
            vga_r <= 4'b0;  
            vga_g <= 4'b0;
            vga_b <= 4'b0;
      end
    end    
endmodule