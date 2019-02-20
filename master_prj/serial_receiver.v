module serial_receiver (clk, rx, reset, byte_out, ready, timeout);

input clk, rx, reset;

output reg [7:0] byte_out;
output reg       ready, timeout;

localparam [4:0] MAX_DELAY = 5'b10100;

localparam [3:0] IDLE  = 4'b0000;
localparam [3:0] START = 4'b0001;
localparam [3:0] ST_0  = 4'b0010;
localparam [3:0] ST_1  = 4'b0011;
localparam [3:0] ST_2  = 4'b0100;
localparam [3:0] ST_3  = 4'b0101;
localparam [3:0] ST_4  = 4'b0110;
localparam [3:0] ST_5  = 4'b0111;
localparam [3:0] ST_6  = 4'b1000;
localparam [3:0] ST_7  = 4'b1001;
localparam [3:0] STOP  = 4'b1010;

reg [7:0] byte_bf   = 8'h00;
reg [3:0] state     = 4'b0000;
reg [4:0] delay_cnt = 5'b00000;

reg pre_strb        = 1'b0;
reg parity_clk      = 1'b0;
reg receiv_flg      = 1'b0;


always @(posedge  clk) begin
	pre_strb <= rx;
	
	if(reset) begin
		ready <= 1'b0;
		timeout <= 1'b1;
		parity_clk <= 1'b1;
		receiv_flg <= 1'b0;
		state <= IDLE;
	end
	else begin
		if(receiv_flg)
			parity_clk <= ~parity_clk;
		else
			parity_clk <= 1'b1;
			
		if(rx)
			delay_cnt <= delay_cnt + 5'b00001;
		else
			delay_cnt <= 5'b00000;
			
		if(delay_cnt == MAX_DELAY) begin
			timeout <= 1'b1;
			delay_cnt <= 5'b00000;
			state <= IDLE;
			parity_clk <= 1'b1;
			receiv_flg <= 1'b0;
			ready <= 1'b0;
		end
		else begin end
		
		if(parity_clk) begin
			case(state)
				IDLE: begin
					if(!rx && pre_strb) begin
						state <= START;
					end
					else begin
						state <= state;
					end
				end
				START: begin
					parity_clk <= 1'b0;
					receiv_flg <= 1'b1;
					timeout <= 1'b0;
					ready <= 1'b0;
					state <= ST_0;
				end
				ST_0: begin byte_bf[0] <= rx; state <= ST_1; end
				ST_1: begin byte_bf[1] <= rx; state <= ST_2; end
				ST_2: begin byte_bf[2] <= rx; state <= ST_3; end
				ST_3: begin byte_bf[3] <= rx; state <= ST_4; end
				ST_4: begin byte_bf[4] <= rx; state <= ST_5; end
				ST_5: begin byte_bf[5] <= rx; state <= ST_6; end
				ST_6: begin byte_bf[6] <= rx; state <= ST_7; end
				ST_7: begin byte_bf[7] <= rx; state <= STOP; end
				STOP: begin
					byte_out <= byte_bf;
					ready <= 1'b1;
					receiv_flg <= 1'b0;
					parity_clk <= 1'b1;
				end
				default: begin
					state <= IDLE;
				end
			endcase
		end
		else begin end
	end
end
endmodule
		
				
				
					
					
