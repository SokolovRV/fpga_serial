module data_mux (
					input        clk,
					input        data_lock,
					input [7:0]  selector,
					input [15:0] data_0,
					input [15:0] data_1,
					input 		 reset,
												output reg [15:0] data_out
																				);

reg pre_strb = 1'b0;
																						
always @(posedge clk) begin

	if(reset)
		data_out <= 16'h0000;
	else begin
		pre_strb <= data_lock;
		if(data_lock && !pre_strb)
			case(selector)
				0: data_out <= data_0;
				1: data_out <= data_1;
				default: data_out <= data_out;
			endcase
		else begin end
	end
end
endmodule
