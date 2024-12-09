`timescale 1ns / 1ps

module debouncer(
    input clk, // clock is used to increment the count when noisy_button and clean_button are different           
    input noisy_button, // noisy_button is the fgpa push_button which has mechanical bouncing
    output reg clean_button = 0  // clean_button is the output of this module which removes the bouncing
);

    reg [16:0] count; // we establish a 17-bit count of binary values
    wire maxCount = &count; // we instantiate maxCount to 131,071 clock cyles (17 bit array of 1s or 2^17 - 1)
    
    always @(posedge clk) begin // at every positive_edge of clock
        if (noisy_button == clean_button) begin // if the input and output button are same (both 1 or both 0)
            count <= 17'd0;  // count does not increment		
        end 
        else begin // if the input and output button are different values (1 and 0 or 0 and 1)
            count <= count + 17'd1;  // count increments every positive clock cycle
            if (maxCount) begin // if count is equal to maxCount or 131,071 clock cyles
                clean_button <= noisy_button; // the clean_button output becomes the noisy_button input (changes to 1 or 0)
            end
        end
    end

endmodule
