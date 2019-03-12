module clk_dev_3 (clk, clk_dev_3);

input clk;

output reg clk_dev_3;

reg [1:0] cnt_f_dev <= 2'b00;

always @(posedge clk) begin
	cnt_f_dev <= cnt_f_dev + 2'b01;
	if(cnt_f_dev[1]) begin
		clk_dev_3 <= 1'b0;
		cnt_f_dev <= 2'b00;
	end
	else
		clk_dev_3 <= 1'b1;
end 

