module state_machine_rx (
							input clk,
							input rx,
							input reset,
											output reg [7:0] data,
											output reg 		  update_lvl_0,
											output reg       first_byte
																						);

reg        [3:0] half_byte_buff_0  = 8'b00000000;																						
reg 	     [3:0] half_byte_buff    = 4'b0000;
reg        [3:0] state      	     = 4'b0000;
reg        [3:0] next_state  	     = 4'b0000;
reg        [1:0] clk_count         = 2'b00;
reg 			     half_byte_flag    = 1'b0;
reg				  previous_strb     = 1'b0;
reg				  delay_flag        = 1'b0;
reg			     start_bit_flag    = 1'b0;
reg              posedge_detect    = 1'b0;

localparam [3:0] BIT_0_STATE_0 	  = 4'b0001;
localparam [3:0] BIT_0_STATE_1 	  = 4'b0010;
localparam [3:0] BIT_1_STATE_0 	  = 4'b0011;
localparam [3:0] BIT_1_STATE_1	  = 4'b0100;
localparam [3:0] BIT_2_STATE_0	  = 4'b0101;
localparam [3:0] BIT_2_STATE_1 	  = 4'b0110;
localparam [3:0] BIT_3_STATE_0	  = 4'b0111;
localparam [3:0] BIT_3_STATE_1     = 4'b1000;

initial begin

	update_lvl_0 = 1'b1;
	first_byte   = 1'b0;
	data   		 = 8'h00;
	
end


always @(*) begin

	next_state = state;
	
	case(state)
	
		BIT_0_STATE_0: next_state = BIT_0_STATE_1;
		
		BIT_0_STATE_1: next_state = BIT_1_STATE_0;
		
		BIT_1_STATE_0: next_state = BIT_1_STATE_1;
		
		BIT_1_STATE_1: next_state = BIT_2_STATE_0;
		
		BIT_2_STATE_0: next_state = BIT_2_STATE_1;
		
		BIT_2_STATE_1: next_state = BIT_3_STATE_0;
		
		BIT_3_STATE_0: next_state = BIT_3_STATE_1;
		
		BIT_3_STATE_1: next_state = BIT_0_STATE_0;
		
		default: next_state = BIT_0_STATE_0;
			
	endcase	
end


always @(posedge clk) begin

	if(reset) begin
		update_lvl_0 <= 1'b1;
		half_byte_flag <= 1'b0;
		first_byte <= 1'b0;
		previous_strb <= 1'b0;
		posedge_detect <= 1'b0;
		start_bit_flag <= 1'b0;
		
		state <= 4'b1001;
		
	end
	else begin
	
		state <= next_state;
	
		case(next_state)
			
		BIT_0_STATE_0: begin
			half_byte_buff[0] <= rx;
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_0_STATE_1: begin
			half_byte_buff[0] <= half_byte_buff[0];
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_1_STATE_0: begin
			half_byte_buff[1] <= rx;
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_1_STATE_1: begin
			half_byte_buff[1] <= half_byte_buff[1];
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_2_STATE_0: begin
			half_byte_buff[2] <= rx;
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_2_STATE_1: begin
			half_byte_buff[2] <= half_byte_buff[2];
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_3_STATE_0: begin
			half_byte_buff[3] <= rx;
			update_lvl_0 <= ~half_byte_flag;
		end
		
		BIT_3_STATE_1: begin
		
			if(half_byte_flag) begin	
				half_byte_flag <= 1'b0;
				/*data[7:0] <=*/ if({half_byte_buff, half_byte_buff_0} != 8'b00001010)
										 first_byte <= 1'b0;
										 else
										 first_byte <= 1'b1;
					if(start_bit_flag) begin
						start_bit_flag <= 1'b0;
						//first_byte <= 1'b1;
					end
					else begin
						//first_byte <= 1'b0;
					end			
			end
			else begin
				//first_byte <= 1'b0;
				half_byte_flag <= 1'b1;
				half_byte_buff_0 <= half_byte_buff;
			end
			
		end
		
		default: begin end
		
		endcase
	

	
		if(rx && !previous_strb) begin
			posedge_detect <= 1'b1;
		end
		else begin end
		
		if(posedge_detect)
			clk_count <= clk_count + 2'b01;
		else
			clk_count <= 2'b01;
	
		
		previous_strb <= rx;
	
	
		if(!rx && previous_strb) begin
		
			posedge_detect <= 1'b0;
			
			if(&clk_count) begin
				start_bit_flag <= 1'b1;
			   state <= 4'b1001;
				half_byte_flag <= 1'b0;
			end
			else begin end

		end
		else begin end
		
	end
end

endmodule