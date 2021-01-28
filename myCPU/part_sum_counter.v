`timescale 1ns/1ps
module part_sum_counter(
	input [63:0] mul_num,
	input [2:0] booth_code,
//	input [5:0] sa,
	output [63:0] part_sum,
	output part_c
);

assign part_sum = ((booth_code== 3'd0)||(booth_code == 3'd7)) ? 64'd0:
		    ((booth_code == 3'd1)||(booth_code == 3'd2)) ? mul_num:
		     (booth_code == 3'd3) ? (mul_num << 1):
		     (booth_code == 3'd4) ? ~(mul_num << 1):
							  ~mul_num;//booth_code == 3'd5 | 3'd6
assign part_c = booth_code[2]&(~(booth_code[1]&booth_code[0]));

endmodule