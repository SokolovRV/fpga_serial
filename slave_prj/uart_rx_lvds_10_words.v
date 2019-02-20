/*
	module for receive of 10 channels of 16-bit data;
	validation data - crc, parity bit and stop bit;
	maximum frequency of module (clk) - 120 Mhz !!! RECOMENDED - 40 Mhz !!!;
	maximum frequency of data - 30 Mbaud (10 Mbaud - 40 Mhz) (use LVDS pins)  ;
	frequency of sending all 10 channels = (clk frequency)/1600;
	length sending is 40 bit = {start_bit(1), data(16), crc(16), word_number(4), parity_bit(1), stop_bit(2)};
	uploading new data on posedge "end_rx" signal (output);
	posedge signal "bad_connection" - probable physical data line is broken;
	
	!!!!! use ONLY with a similar transmitter - not suitable for normal UART (transfer only between FPGAs) !!!!!
	!!!!! the receiver and transmitter clk frequencies must be correlated !!!!!
	
	developer: Sokolov Roman
	version: 1.0
	data: 29.09.2017
*/


module uart_rx_lvds_10_words (input clk, input rx_lvds, 
							output reg [15:0]data1,
							output reg [15:0]data2,
							output reg [15:0]data3,
							output reg [15:0]data4,
							output reg [15:0]data5,
							output reg [15:0]data6,
							output reg [15:0]data7,
							output reg [15:0]data8,
							output reg [15:0]data9,
							output reg [15:0]data10,
							output reg [15:0]errors_count,
							output reg end_rx,
							output reg bad_connection);

reg [36:0]data_in;
reg signed [7:0]freq_count;
reg [7:0]count_start_bit;
reg [7:0]sum_parity;
reg [7:0]bit_count;
reg [7:0]error_count;

reg [15:0]data1_out_buffer;
reg [15:0]data2_out_buffer;
reg [15:0]data3_out_buffer;
reg [15:0]data4_out_buffer;
reg [15:0]data5_out_buffer;
reg [15:0]data6_out_buffer;
reg [15:0]data7_out_buffer;
reg [15:0]data8_out_buffer;
reg [15:0]data9_out_buffer;
reg [15:0]data10_out_buffer;

reg [35:0] crc;
reg [19:0] crc_0;
reg last_rx;
reg first_synchro_buff_rx;
reg second_synchro_buff_rx;
reg start_bit;
reg stop_bit_validation;
reg bit_was;
reg [3:0]word_number;
reg [15:0]data;


initial begin
	data=0;
	data_in=0;
	freq_count=0;
	last_rx=0;
	first_synchro_buff_rx=0;
	second_synchro_buff_rx=0;
	count_start_bit=0;
	start_bit=0;
	bit_count=0;
	data1_out_buffer=0;
	data2_out_buffer=0;
	data3_out_buffer=0;
	data4_out_buffer=0;
	data5_out_buffer=0;
	data6_out_buffer=0;
	data7_out_buffer=0;
	data8_out_buffer=0;
	data9_out_buffer=0;
	data10_out_buffer=0;
	data1=0;
	data2=0;
	data3=0;
	data4=0;
	data5=0;
	data6=0;
	data7=0;
	data8=0;
	data9=0;
	data10=0;
	bit_was=0;
	crc=0;
	word_number=0;
	error_count=0;
	bad_connection=0;
	errors_count=0;
end

always @(posedge clk) first_synchro_buff_rx <= rx_lvds;
always @(posedge clk) second_synchro_buff_rx <= first_synchro_buff_rx;
always @(posedge end_rx) begin
					data1<=data1_out_buffer;
					data2<=data2_out_buffer;
					data3<=data3_out_buffer;
					data4<=data4_out_buffer;
					data5<=data5_out_buffer;
					data6<=data6_out_buffer;
					data7<=data7_out_buffer;
					data8<=data8_out_buffer;
					data9<=data9_out_buffer;
					data10<=data10_out_buffer;
end

always @(posedge clk) begin

end_rx<=0;

if(second_synchro_buff_rx == 1 && last_rx == 0)begin
	count_start_bit = 0;
end

if(second_synchro_buff_rx == 0 && last_rx==1 && count_start_bit>=5 && count_start_bit<=7 ) begin

	if(start_bit==1) begin
		bit_count=0;
		freq_count=0;
		data_in=0;
		sum_parity=0;
		data_in=0;
		stop_bit_validation<=0;
		bit_was=0;
		crc=0;
	end
	else	begin
		start_bit=1;
		data_in=0;
		if(bit_was==1 && word_number==10)
			end_rx<=1;
		stop_bit_validation<=0;
		bit_was=0;
	end
end

if(start_bit==1) begin
	bit_was=1;
	if(freq_count>=5) begin
		if(bit_count<=36) begin
		data_in[bit_count] = second_synchro_buff_rx;
			if(bit_count<=35) begin
				sum_parity = sum_parity + second_synchro_buff_rx;
				freq_count = 2;
			end
			else
				freq_count = -1;
		bit_count = bit_count + 1;
		end
		else begin
			crc = {data_in[35:32],data_in[15:0]} *44111;
			crc = crc^(crc>>8);
			
			if(sum_parity[0]== data_in[36] && second_synchro_buff_rx==1 && crc[15:0] == data_in[31:16] ) begin
				data[15:0] = data_in[15:0];
				word_number = data_in[35:32];					
				case (word_number)
				1:begin data1_out_buffer<=data; end
				2:begin data2_out_buffer<=data;end
				3:begin data3_out_buffer<=data;end
				4:begin data4_out_buffer<=data;end
				5:begin data5_out_buffer<=data;end
				6:begin data6_out_buffer<=data;end
				7:begin data7_out_buffer<=data;end
				8:begin data8_out_buffer<=data;end
				9:begin data9_out_buffer<=data;end
				10:begin data10_out_buffer<=data;end
				endcase		
				stop_bit_validation<=1;
				bit_count=0;
				freq_count=0;
				start_bit=0;
				sum_parity=0;
				crc=0;
				error_count=0;
				bad_connection<=0;

			end
			else begin
				bit_count=0;
				freq_count=0;
				start_bit=0;
				sum_parity=0;
				bit_was=0;
				crc=0;
				errors_count <= errors_count + 1;
				if(error_count<100)
					error_count=error_count+1;
				else
					bad_connection<=1;
			end
		end
		
	end
	else
		freq_count = freq_count + 1;
end
		
last_rx<=second_synchro_buff_rx;
count_start_bit=count_start_bit+1;

end
endmodule
	
	