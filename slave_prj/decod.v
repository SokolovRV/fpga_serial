module decod (input clk, input [3:0] in, output reg out);

localparam [1:0] ST1 = 2'b00;
localparam [1:0] ST2 = 2'b01;
localparam [1:0] ST3 = 2'b10;
localparam [1:0] ST4 = 2'b11;

reg [1:0] state = 2'b00;

always @(posedge clk) begin
	case(state)
		ST1: begin out <= in[0]; state <= ST2; end
		ST2: begin out <= in[1]; state <= ST3; end
		ST3: begin out <= in[2]; state <= ST4; end
		ST4: begin out <= in[3]; state <= ST1; end
		default: out = 1'b0;
	endcase
end
endmodule
		