module serial_receiver (clk, rx, byte_out, ready, timeout);

input clk, rx;

output reg [7:0] byte_out;
output reg       ready, timeout;

localparam [4:0] IDLE    = 5'b00000;
localparam [4:0] START_0 = 5'b00001;
localparam [4:0] START_1 = 5'b00010;
localparam [4:0] ST_0_0  = 5'b00011;
localparam [4:0] ST_0_1  = 5'b00100;
localparam [4:0] ST_0_2  = 5'b00101;
localparam [4:0] ST_1_0  = 5'b00110;
localparam [4:0] ST_1_1  = 5'b00111;
localparam [4:0] ST_1_2  = 5'b01000;
localparam [4:0] ST_2_0  = 5'b01001;
localparam [4:0] ST_2_1  = 5'b01010;
localparam [4:0] ST_2_2  = 5'b01011;
localparam [4:0] ST_3_0  = 5'b01100;
localparam [4:0] ST_3_1  = 5'b01101;
localparam [4:0] ST_3_2  = 5'b01110;
localparam [4:0] ST_4_0  = 5'b01111;
localparam [4:0] ST_4_1  = 5'b10000;
localparam [4:0] ST_4_2  = 5'b10001;
localparam [4:0] ST_5_0  = 5'b10010;
localparam [4:0] ST_5_1  = 5'b10011;
localparam [4:0] ST_5_2  = 5'b10100;
localparam [4:0] ST_6_0  = 5'b10101;
localparam [4:0] ST_6_1  = 5'b10110;
localparam [4:0] ST_6_2  = 5'b10111;
localparam [4:0] ST_7_0  = 5'b11000;
localparam [4:0] ST_7_1  = 5'b11001;
localparam [4:0] STOP    = 5'b11010;

reg [7:0] byte_bf        = 8'h00;
reg [4:0] state          = 5'b00000;
reg [2:0] delay_cnt_hi   = 3'b000;
reg [2:0] delay_cnt_lo   = 3'b000;

reg lo_cnt_done     = 1'b0;
reg pre_strb        = 1'b0;

always @(posedge clk) begin
	
	pre_strb <= rx;
	
		delay_cnt_lo <= delay_cnt_lo + 3'b001;
		lo_cnt_done <= (delay_cnt_lo == 3'b110);
		if(lo_cnt_done)
			delay_cnt_hi <= delay_cnt_hi + 3'b001;
		else begin end
	
		if(!rx) begin
			delay_cnt_hi <= 3'b000;
			delay_cnt_lo <= 3'b000;
		end
		else begin end

		if(delay_cnt_hi[2]) begin
			timeout <= 1'b1;
		end
		else begin end
		
			case(state)
				IDLE: begin
					if(!rx && pre_strb) begin
						state <= START_0;
					end
					else begin
						state <= state;
					end	
				end
				START_0: begin
					state <= START_1;
				end
				START_1: begin
					state <= ST_0_0;
				end	
				
				ST_0_0: begin state <= ST_0_1; ready <= 1'b0; end
				ST_0_1: begin byte_bf[0] <= rx; state <= ST_0_2; end
				ST_0_2: begin state <= ST_1_0; timeout <= 1'b0; end
				
				ST_1_0: state <= ST_1_1;
				ST_1_1: begin byte_bf[1] <= rx; state <= ST_1_2; end
				ST_1_2: state <= ST_2_0;
				
				ST_2_0: state <= ST_2_1;
				ST_2_1: begin byte_bf[2] <= rx; state <= ST_2_2; end
				ST_2_2: state <= ST_3_0;
				
				ST_3_0: state <= ST_3_1 ;
				ST_3_1: begin byte_bf[3] <= rx; state <= ST_3_2; end
				ST_3_2: state <= ST_4_0;
				
				ST_4_0: begin state <= ST_4_1;  end
				ST_4_1: begin byte_bf[4] <= rx; state <= ST_4_2; end
				ST_4_2: state <= ST_5_0;
				
				ST_5_0: state <= ST_5_1;
				ST_5_1: begin byte_bf[5] <= rx; state <= ST_5_2; end
				ST_5_2: state <= ST_6_0;
				
				ST_6_0: state <= ST_6_1;
				ST_6_1: begin byte_bf[6] <= rx; state <= ST_6_2; end
				ST_6_2: state <= ST_7_0;
				
				ST_7_0: state <= ST_7_1;
				ST_7_1: begin byte_bf[7] <= rx; state <= STOP; end
				
				STOP: begin
					byte_out <= byte_bf;
					ready <= 1'b1;
					state <= IDLE;
				end
				default: begin
					state <= IDLE;
					ready <= 1'b0;
					timeout <= 1'b0;
				end
			endcase
end
endmodule
		
				
				
					
					
