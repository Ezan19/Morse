`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 12:18:25 AM
// Design Name: 
// Module Name: vga_controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vga_controller_tb();
// recommend changing  addr_fixed1 output radix to unsigned decimal


    reg clk;
    reg [2:0] display_position;
    reg [10:0] addr_fixed1;
    wire h_sync, v_sync, led_on;

    vga_controller vgac1 (
        .clk(clk),
        .display_position(display_position),
        .addr_fixed1(addr_fixed1),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .led_on(led_on)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        display_position = 3'b000;
        addr_fixed1 = 11'd100;
        #10;
        display_position = 3'b000;
        addr_fixed1 = 11'd100;
        #10;
        display_position = 3'b001;
        addr_fixed1 = 11'd200;
        #10;
        display_position = 3'b010;
        addr_fixed1 = 11'd300;
        #10;
        display_position = 3'b011;
        addr_fixed1 = 11'd400;
        #10;
        display_position = 3'b100;
        addr_fixed1 = 11'd500;
        #10;
        display_position = 3'b101;
        addr_fixed1 = 11'd600;
        #10;
        display_position = 3'b110;
        addr_fixed1 = 11'd700;
        #10;
        display_position = 3'b111;
        addr_fixed1 = 11'd800;
        #10;
        #100;
        display_position = 3'b000;
        addr_fixed1 = 11'd900;
        #10;
        $finish;
    end

endmodule


