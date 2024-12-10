`timescale 1ns / 1ps

// clock has a period of 4 clock cycles
// newClk has a period of 16 clock cycles
// converts 100 Mhz to 25 Mhz

module clk_div_tb();
    
    reg clk;
    wire newClk;
    
    clk_divider clk_div1 (clk, newClk);
    
    initial begin
        clk =  0; // Initialize clock to 0
        #500 $finish; // End simulation after 500 time units
    end
    
    always #2 clk = ~clk; // Toggle clock every 2 time units
endmodule
