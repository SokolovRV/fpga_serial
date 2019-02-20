/*
	module for transmission of 10 channels of 16-bit data;
	maximum frequency of module (clk) - 120 Mhz !!! RECOMENDED - 40 Mhz !!!;
	maximum frequency of data - 30 Mbaud (10 Mbaud - 40 Mhz) (use LVDS pins)  ;
	frequency of sending all 10 channels = (clk frequency)/1600;
	length sending is 40 bit = {start_bit(1), data(16), crc(16), word_number(4), parity_bit(1), stop_bit(2)};
	uploading new data on posedge and lock data on negedge "end_send" signal (output);
	
	!!!!! use ONLY with a similar receiver - not suitable for normal UART (transfer only between FPGAs) !!!!!
	!!!!! the receiver and transmitter clk frequencies must be correlated !!!!!
	
	developer: Sokolov Roman
	version: 1.0
	data: 29.09.2017
*/

module uart_tx_lvds_10_words (input clk,
							input [15:0]data1,
							input [15:0]data2,
							input [15:0]data3,
							input [15:0]data4,
							input [15:0]data5,
							input [15:0]data6,
							input [15:0]data7,
							input [15:0]data8,
							input [15:0]data9,
							input [15:0]data10,
							output reg tx_lvds, 
							output reg end_send);
reg [15:0]data;							
reg [35:0] data_in;
reg [35:0] crc;
reg [19:0] crc_0;							
reg [7:0] base_clk_count;
reg [7:0] sum_parity;
reg [7:0] n_bit;
reg bit_clk;
reg flag_gate;
reg flag_start;
reg [15:0]buff_data1;
reg [15:0]buff_data2;
reg [15:0]buff_data3;
reg [15:0]buff_data4;
reg [15:0]buff_data5;
reg [15:0]buff_data6;
reg [15:0]buff_data7;
reg [15:0]buff_data8;
reg [15:0]buff_data9;
reg [15:0]buff_data10;
reg [3:0]data_number;
reg [15:0]buff_data_number;
reg end_tx;

initial begin
	tx_lvds = 1;
	base_clk_count = 0;
	flag_start = 0;
	n_bit = 0;
	bit_clk=0;
	end_tx=0;
	flag_gate = 1;
	sum_parity = 0;
	crc=0;
	buff_data1=0;
	buff_data2=0;
	buff_data3=0;
	buff_data4=0;
	buff_data5=0;
	buff_data6=0;
	buff_data7=0;
	buff_data8=0;
	buff_data9=0;
	buff_data10=0;
	data=0;
	data_number=0;
	buff_data_number=1;
	crc_0=0;
end

always @(posedge end_tx) begin

end_send<=0;
if(buff_data_number==10)
	end_send<=1;
	
if(buff_data_number==1) begin
	buff_data1=data1;
	buff_data2=data2;
	buff_data3=data3;
	buff_data4=data4;
	buff_data5=data5;
	buff_data6=data6;
	buff_data7=data7;
	buff_data8=data8;
	buff_data9=data9;
	buff_data10=data10;
end

case (buff_data_number)
1:begin data<=buff_data1; data_number<=buff_data_number; end
2:begin data<=buff_data2; data_number<=buff_data_number; end
3:begin data<=buff_data3; data_number<=buff_data_number; end
4:begin data<=buff_data4; data_number<=buff_data_number; end
5:begin data<=buff_data5; data_number<=buff_data_number; end
6:begin data<=buff_data6; data_number<=buff_data_number; end
7:begin data<=buff_data7; data_number<=buff_data_number; end
8:begin data<=buff_data8; data_number<=buff_data_number; end
9:begin data<=buff_data9; data_number<=buff_data_number; end
10:begin data<=buff_data10; data_number<=buff_data_number; end
endcase

buff_data_number=buff_data_number+1;
if(buff_data_number>=11)
	buff_data_number=1;
end



always @(posedge clk) begin
	
	
	if(flag_start) begin

		if(base_clk_count >=2 && bit_clk && flag_gate) begin
			crc_0 = {data_number,data};
			crc = crc_0*44111;
			crc = crc^(crc>>8);
			data_in = {data_number, crc[15:0], data};
			end_tx <= 0;
			flag_gate=0;
		end
		
		if(base_clk_count >= 4 && bit_clk) begin
			
			if(n_bit >= 37) begin
			bit_clk = 0;
			tx_lvds <= 0;
			n_bit = 0;
			end
			else begin
				if(n_bit >=36) begin
					tx_lvds <= sum_parity[0];
				end
				else begin
					tx_lvds <= data_in[n_bit];
					sum_parity = sum_parity + data_in[n_bit];
				end
					n_bit = n_bit + 1;
			end	
			base_clk_count = 0;
			
		end
		
			
		if(base_clk_count >= 2 && !bit_clk) begin 
			tx_lvds <= 1;
			if(base_clk_count >= 8) begin
				flag_start = 0;
				end_tx <= 1;
				flag_gate = 1;
			end
		end
		
			base_clk_count = base_clk_count + 1;
	end
	
	if(!flag_start) begin
		tx_lvds <= 0;
		flag_start = 1;
		bit_clk = 1;
		base_clk_count = 1;
		sum_parity = 0;
	end
		
	end
			
endmodule
		
			
	
	

