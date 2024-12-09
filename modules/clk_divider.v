`timescale 1ns / 1ps

module clk_divider(
    input clk, 
    output reg newClk);
	
	reg[32:0] count;

	initial begin
		// initialize everything to zero
		count <= 0;
        newClk <= 0;
	end
	
	always @(negedge clk)
	begin
		// increment count
		count = count + 1;
		// convert 100 Mhz to 25 Mhz
		if (count == 2) begin
            newClk <= ~newClk;
            // Reset count to zero
            count <= 0;
        end
	end
endmodule
