module state_machine_tx (
							input 		clk, 
							input [7:0] data,
							input       start_lvl_0,
							input 		reset, 
															output reg tx, 
															output reg update_lvl_0
																							);
																			
reg 	     [7:0] byte_buff 		  = 8'b00000000;
reg 	     [3:0] half_byte_buff    = 4'b0000;
reg        [3:0] state      	     = 4'b0000;
reg        [3:0] next_state  	     = 4'b0000;
reg 			     half_byte_flag    = 1'b0;
reg				  previous_strb     = 1'b0;
reg				  first_byte_flag   = 1'b0;

localparam [3:0] IDLE    		     = 4'b0000;
localparam [3:0] START_BIT_1_STATE = 4'b0001;
localparam [3:0] START_BIT_2_STATE = 4'b0010;
localparam [3:0] START_BIT_3_STATE = 4'b0011;
localparam [3:0] START_BIT_4_STATE = 4'b0100;
localparam [3:0] BIT_0_STATE_0 	  = 4'b0101;
localparam [3:0] BIT_0_STATE_1 	  = 4'b0110;
localparam [3:0] BIT_1_STATE_0	  = 4'b0111;
localparam [3:0] BIT_2_STATE_1	  = 4'b1000;
localparam [3:0] BIT_3_STATE_0  	  = 4'b1001;
localparam [3:0] BIT_1_STATE_1	  = 4'b1010;
localparam [3:0] BIT_2_STATE_0	  = 4'b1011;
localparam [3:0] BIT_3_STATE_1  	  = 4'b1100;


initial begin

	update_lvl_0 = 1'b1;
	tx     		 = 1'b0;
	
end


always @(posedge clk) begin

	if(reset)
		state <= 4'b0000;
	else
		state <= next_state;
		
end


always @(*) begin

	next_state = state;
	
	case(state)

				       IDLE:
					      begin
								if(first_byte_flag)
									next_state = START_BIT_1_STATE;
								else
									next_state = IDLE;
							end
					
		START_BIT_1_STATE: next_state = START_BIT_2_STATE;
		
		START_BIT_2_STATE: next_state = START_BIT_3_STATE;
		
		START_BIT_3_STATE: next_state = START_BIT_4_STATE;
		
		START_BIT_4_STATE: next_state = BIT_0_STATE_0;
	
		    BIT_0_STATE_0: next_state = BIT_0_STATE_1;
			 
			 BIT_0_STATE_1: next_state = BIT_1_STATE_0;
			 
			 BIT_1_STATE_0: next_state = BIT_1_STATE_1;
			 
			 BIT_1_STATE_1: next_state = BIT_2_STATE_0;
			 
			 BIT_2_STATE_0: next_state = BIT_2_STATE_1;
			 
			 BIT_2_STATE_1: next_state = BIT_3_STATE_0;
			 
			 BIT_3_STATE_0: next_state = BIT_3_STATE_1;
			 
			 BIT_3_STATE_1:
								if(first_byte_flag && half_byte_buff)
									next_state = IDLE;
								else
									next_state = BIT_0_STATE_0;

		
		          default: next_state = IDLE;
			
	endcase	
end

always @(posedge clk) begin

	if(reset) begin
		tx <= 1'b0;
		update_lvl_0 <= 1'b1;
		half_byte_buff <= 4'h0;
		byte_buff <= 8'h00;
		previous_strb <= 1'b0;
		first_byte_flag <= 1'b0;
	end
	else begin
	
		if(start_lvl_0 && !previous_strb)
			first_byte_flag <= 1'b1;
		else begin end
			
		previous_strb <= start_lvl_0;
		
		case(next_state)
		
			IDLE: begin
				tx <= 1'b0;
				update_lvl_0 <= 1'b0;
			end
			
			START_BIT_1_STATE: begin
				tx <= 1'b1;
				update_lvl_0 <= 1'b0;
			end
			
			START_BIT_2_STATE: begin
				tx <= 1'b1;
				update_lvl_0 <= 1'b0;
				first_byte_flag <= 1'b0;
				byte_buff <= data;
			end
			
			START_BIT_3_STATE: begin
				tx <= 1'b1;
				update_lvl_0 <= 1'b0;
				half_byte_buff[3:0] <= byte_buff[3:0];
			end
			
			START_BIT_4_STATE: begin
				tx <= 1'b0;
				update_lvl_0 <= 1'b0;
			end
			
			BIT_0_STATE_0: begin
				tx <= half_byte_buff[0];
				update_lvl_0 <= 1'b0;
			end
			
			BIT_0_STATE_1: begin
				tx <= tx;
				update_lvl_0 <= 1'b0;
			end
		
			BIT_1_STATE_0: begin
				tx <= half_byte_buff[1];
				update_lvl_0 <= half_byte_flag;
			end

			BIT_1_STATE_1: begin
				tx <= tx;
				update_lvl_0 <= half_byte_flag;
			end	
	
			BIT_2_STATE_0: begin
				tx <= half_byte_buff[2];
				update_lvl_0 <= half_byte_flag;
			end

			BIT_2_STATE_1: begin
				tx <= tx;
				update_lvl_0 <= half_byte_flag;
			end
			
			BIT_3_STATE_0: begin
				tx <= half_byte_buff[3];
				update_lvl_0 <= half_byte_flag;
				if(half_byte_flag)
					byte_buff <= data;
				else begin end		
			end
			
			BIT_3_STATE_1: begin
				tx <= tx;
				update_lvl_0 <= half_byte_flag;
				
				if(half_byte_flag) begin
					half_byte_buff[3:0] <= byte_buff[3:0];
					half_byte_flag <= 1'b0;
				end
				else begin
					half_byte_buff[3:0] <= byte_buff[7:4];
					half_byte_flag <= 1'b1;
				end
			end
		
			default: begin end
		
		endcase	
	end
end

endmodule