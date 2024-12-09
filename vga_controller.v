`timescale 1ns / 1ps

module vga_controller(clk,display_position, addr_fixed1, h_sync, v_sync, led_on);
    
    input clk;
    input [2:0] display_position;
    input [10:0] addr_fixed1;
    output reg h_sync, v_sync, led_on;
    
    
    localparam TOTAL_WIDTH = 800;
    localparam TOTAL_HEIGHT = 525;
    localparam ACTIVE_WIDTH = 640;
    localparam ACTIVE_HEIGHT = 480;
    localparam H_SYNC_COLUMN = 704;
    localparam V_SYNC_LINE = 523;
    
    reg [11:0] widthPos = 0;
    reg [11:0] heightPos = 0;
    
    
    wire enable = ((widthPos >=0 & widthPos < 640) & (heightPos >=0 & heightPos < 480)) ? 1'b1: 1'b0; //Ensures enable is only active in the active pixel
    reg dispLetter1;
    reg dispLetter2;
    reg dispLetter3;
    reg dispLetter4;
    reg dispLetter5;
    reg dispLetter6;
    reg dispLetter7;
    reg dispLetter8;
    reg led_on1;
    reg led_on2;
    reg led_on3;
    reg led_on4;
    reg led_on5;
    reg led_on6;
    reg led_on7;
    reg led_on8;

    wire [10:0] addr_fixed = addr_fixed1; 
    reg [10:0] myActualAddress;
    reg [10:0] myActualAddress1;
    reg [10:0] myActualAddress2;
    reg [10:0] myActualAddress3;
    reg [10:0] myActualAddress4;
    reg [10:0] myActualAddress5;
    reg [10:0] myActualAddress6;
    reg [10:0] myActualAddress7;
    reg [10:0] myActualAddress8;
    wire [7:0] data;

//case statement to check which position (character) to display, one character display only and in their respective space
always @ (posedge clk)
begin
case(display_position)
        3'b000: 
begin 
dispLetter1=((widthPos >= 320 && widthPos < 328) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress1; led_on<=led_on1;
end
        
        
        3'b001:  
begin 
dispLetter2=((widthPos >= 329 && widthPos < 337) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress2; led_on<=led_on2;
end

        
        
        3'b010:  
begin 
dispLetter3=((widthPos >= 338 && widthPos < 346) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress3; led_on<=led_on3;
end

        
        3'b011:
begin 
dispLetter4=((widthPos >= 347 && widthPos < 355) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress4; led_on<=led_on4;
end       
        
        3'b100: 
begin 
dispLetter5=((widthPos >= 356 && widthPos < 364) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress5; led_on<=led_on5;
end
        
        3'b101: 
begin 
dispLetter6=((widthPos >= 365 && widthPos < 373) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress6; led_on<=led_on6;
end
        
        3'b110: 
begin 
dispLetter7=((widthPos >= 374 && widthPos < 382) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress7; led_on<=led_on7;
end
        
        3'b111:
begin 
dispLetter8=((widthPos >= 383 && widthPos < 391) && (heightPos >= 240 && heightPos < 256)) ? 1'b1: 1'b0 ;  myActualAddress<= myActualAddress8; led_on<=led_on8;
end
        
        endcase
end

ascii_rom asciiInst (
.clk(clk),
.addr(myActualAddress),
.data(data)
);

//Checks which state we are in and assigns the correct Pixel address on screen 
always @(posedge clk)
begin
	if(dispLetter1) begin
		myActualAddress1 <= addr_fixed + (heightPos-240); //Calculate correct address by adding the correct shift 
	end
	else begin
		myActualAddress1 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter2) begin
		myActualAddress2 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress2 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter3) begin
		myActualAddress3 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress3 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter4) begin
		myActualAddress4 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress4 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter5) begin
		myActualAddress5 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress5 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter6) begin
		myActualAddress6 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress6 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter7) begin
		myActualAddress7 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress7 <= 0;

	end

end

always @(posedge clk)
begin
	if(dispLetter8) begin
		myActualAddress8 <= addr_fixed + (heightPos-240);
	end
	else begin
		myActualAddress8 <= 0;

	end

end

    //Checks all pixel coordinates
    always@(posedge clk)
    begin
        // Checks and update width position
        if(widthPos < TOTAL_WIDTH -1)
        begin 
            widthPos <= widthPos + 1;
        end
        else
        begin
            widthPos <=0;
            // Checks and update height position
            if(heightPos < TOTAL_HEIGHT -1)
            begin
                heightPos <= heightPos + 1;
            end
            else
            begin
                 heightPos <= 0;
            end       
        end
    end
    
    //HSync
    always@(posedge clk)
    begin
        if (widthPos < H_SYNC_COLUMN)
        begin
            h_sync <= 1'b1;
        end
        else
        begin
            h_sync <= 1'b0;
        end
   end

    //VSync
    always@(posedge clk)
    begin
        if (heightPos < V_SYNC_LINE)
        begin
            v_sync <= 1'b1;
        end
        else
        begin
            v_sync <= 1'b0;
        end
   end
    
    
    //Controls which Pixels turns on and where in display for each character
    always@(posedge clk)
    begin
        if(enable & dispLetter1)
        begin
            led_on1 <= data[10-(widthPos-320)];
        end
        else
        begin
            led_on1 <= 1'b0;
        end 
   end     
    
always@(posedge clk)
    begin
        if(enable & dispLetter2)
        begin
            led_on2 <= data[10-(widthPos-329)];
        end
        else
        begin
            led_on2 <= 1'b0;
        end 
   end     
   
   always@(posedge clk)
    begin
        if(enable & dispLetter3)
        begin
            led_on3 <= data[10-(widthPos-338)];
        end
        else
        begin
            led_on3 <= 1'b0;
        end 
   end 
   
     
   always@(posedge clk)
    begin
        if(enable & dispLetter4)
        begin
            led_on4 <= data[10-(widthPos-347)];
        end
        else
        begin
            led_on4 <= 1'b0;
        end 
   end 

  
   always@(posedge clk)
    begin
        if(enable & dispLetter5)
        begin
            led_on5 <= data[10-(widthPos-356)];
        end
        else
        begin
            led_on5 <= 1'b0;
        end 
   end 

  
   always@(posedge clk)
    begin
        if(enable & dispLetter6)
        begin
            led_on6 <= data[10-(widthPos-365)];
        end
        else
        begin
            led_on6 <= 1'b0;
        end 
   end 

  
   always@(posedge clk)
    begin
        if(enable & dispLetter7)
        begin
            led_on7 <= data[10-(widthPos-374)];
        end
        else
        begin
            led_on7 <= 1'b0;
        end 
   end 

  
   always@(posedge clk)
    begin
        if(enable & dispLetter8)
        begin
            led_on8 <= data[10-(widthPos-383)];
        end
        else
        begin
            led_on8 <= 1'b0;
        end 
   end 


endmodule