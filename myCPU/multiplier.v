`timescale 1ns / 1ps

// pipeline registers is between wallance trees and adder
module multiplier(
	input mul_clk,
	input resetn,//low active
	input mul_signed,//control signed and unsigned mutiply
	input [31:0] x,
	input [31:0] y,		
	output [63:0] mul_result
);
wire [63:0] mul_x;
wire [32:0] mul_y;

assign mul_x  = (mul_signed) ?{{(32){x[31]}},x} : {32'd0,x};
assign mul_y  = (mul_signed) ?{y[31],y} : {1'd0,y};
//count partial sums
wire [63:0] part_sum_0,part_sum_1,part_sum_2,part_sum_3,part_sum_4,part_sum_5,part_sum_6,part_sum_7,part_sum_8,part_sum_9;
wire [63:0] part_sum_10,part_sum_11,part_sum_12,part_sum_13,part_sum_14,part_sum_15,part_sum_16;
wire [16:0] part_c;

part_sum_counter part_sum_counter_0(.mul_num(mul_x << 0),.booth_code({mul_y[1:0],1'd0}),.part_sum(part_sum_0),.part_c(part_c[0]));
part_sum_counter part_sum_counter_1(.mul_num(mul_x << 2),.booth_code(mul_y[3:1]),.part_sum(part_sum_1),.part_c(part_c[1]));
part_sum_counter part_sum_counter_2(.mul_num(mul_x << 4),.booth_code(mul_y[5:3]),.part_sum(part_sum_2),.part_c(part_c[2]));
part_sum_counter part_sum_counter_3(.mul_num(mul_x << 6),.booth_code(mul_y[7:5]),.part_sum(part_sum_3),.part_c(part_c[3]));
part_sum_counter part_sum_counter_4(.mul_num(mul_x << 8),.booth_code(mul_y[9:7]),.part_sum(part_sum_4),.part_c(part_c[4]));
part_sum_counter part_sum_counter_5(.mul_num(mul_x << 10),.booth_code(mul_y[11:9]),.part_sum(part_sum_5),.part_c(part_c[5]));
part_sum_counter part_sum_counter_6(.mul_num(mul_x << 12),.booth_code(mul_y[13:11]),.part_sum(part_sum_6),.part_c(part_c[6]));
part_sum_counter part_sum_counter_7(.mul_num(mul_x << 14),.booth_code(mul_y[15:13]),.part_sum(part_sum_7),.part_c(part_c[7]));
part_sum_counter part_sum_counter_8(.mul_num(mul_x << 16),.booth_code(mul_y[17:15]),.part_sum(part_sum_8),.part_c(part_c[8]));
part_sum_counter part_sum_counter_9(.mul_num(mul_x << 18),.booth_code(mul_y[19:17]),.part_sum(part_sum_9),.part_c(part_c[9]));
part_sum_counter part_sum_counter_10(.mul_num(mul_x << 20),.booth_code(mul_y[21:19]),.part_sum(part_sum_10),.part_c(part_c[10]));
part_sum_counter part_sum_counter_11(.mul_num(mul_x << 22),.booth_code(mul_y[23:21]),.part_sum(part_sum_11),.part_c(part_c[11]));
part_sum_counter part_sum_counter_12(.mul_num(mul_x << 24),.booth_code(mul_y[25:23]),.part_sum(part_sum_12),.part_c(part_c[12]));
part_sum_counter part_sum_counter_13(.mul_num(mul_x << 26),.booth_code(mul_y[27:25]),.part_sum(part_sum_13),.part_c(part_c[13]));
part_sum_counter part_sum_counter_14(.mul_num(mul_x << 28),.booth_code(mul_y[29:27]),.part_sum(part_sum_14),.part_c(part_c[14]));
part_sum_counter part_sum_counter_15(.mul_num(mul_x << 30),.booth_code(mul_y[31:29]),.part_sum(part_sum_15),.part_c(part_c[15]));
part_sum_counter part_sum_counter_16(.mul_num(mul_x << 32),.booth_code({mul_y[32],mul_y[32:31]}),.part_sum(part_sum_16),.part_c(part_c[16]));

//Wallace Trees
wire [63:0] WT_S;
wire [63:0] WT_C; 

wire [16:0] wt_input_0,wt_input_1,wt_input_2,wt_input_3,wt_input_4,wt_input_5,wt_input_6,wt_input_7,wt_input_8,wt_input_9;
wire [16:0] wt_input_10,wt_input_11,wt_input_12,wt_input_13,wt_input_14,wt_input_15,wt_input_16,wt_input_17,wt_input_18,wt_input_19;
wire [16:0] wt_input_20,wt_input_21,wt_input_22,wt_input_23,wt_input_24,wt_input_25,wt_input_26,wt_input_27,wt_input_28,wt_input_29;
wire [16:0] wt_input_30,wt_input_31,wt_input_32,wt_input_33,wt_input_34,wt_input_35,wt_input_36,wt_input_37,wt_input_38,wt_input_39;
wire [16:0] wt_input_40,wt_input_41,wt_input_42,wt_input_43,wt_input_44,wt_input_45,wt_input_46,wt_input_47,wt_input_48,wt_input_49;
wire [16:0] wt_input_50,wt_input_51,wt_input_52,wt_input_53,wt_input_54,wt_input_55,wt_input_56,wt_input_57,wt_input_58,wt_input_59;
wire [16:0] wt_input_60,wt_input_61,wt_input_62,wt_input_63;


assign wt_input_0 = {part_sum_16[0],part_sum_15[0],part_sum_14[0],part_sum_13[0],part_sum_12[0],part_sum_11[0],part_sum_10[0],
part_sum_9[0],part_sum_8[0],part_sum_7[0],part_sum_6[0],part_sum_5[0],part_sum_4[0],part_sum_3[0],part_sum_2[0],part_sum_1[0],part_sum_0[0]};

assign wt_input_1= {part_sum_16[1],part_sum_15[1],part_sum_14[1],part_sum_13[1],part_sum_12[1],part_sum_11[1],part_sum_10[1],
part_sum_9[1],part_sum_8[1],part_sum_7[1],part_sum_6[1],part_sum_5[1],part_sum_4[1],part_sum_3[1],part_sum_2[1],part_sum_1[1],part_sum_0[1]};

assign wt_input_2 = {part_sum_16[2],part_sum_15[2],part_sum_14[2],part_sum_13[2],part_sum_12[2],part_sum_11[2],part_sum_10[2],
part_sum_9[2],part_sum_8[2],part_sum_7[2],part_sum_6[2],part_sum_5[2],part_sum_4[2],part_sum_3[2],part_sum_2[2],part_sum_1[2],part_sum_0[2]};

assign wt_input_3 = {part_sum_16[3],part_sum_15[3],part_sum_14[3],part_sum_13[3],part_sum_12[3],part_sum_11[3],part_sum_10[3],
part_sum_9[3],part_sum_8[3],part_sum_7[3],part_sum_6[3],part_sum_5[3],part_sum_4[3],part_sum_3[3],part_sum_2[3],part_sum_1[3],part_sum_0[3]};

assign wt_input_4 = {part_sum_16[4],part_sum_15[4],part_sum_14[4],part_sum_13[4],part_sum_12[4],part_sum_11[4],part_sum_10[4],
part_sum_9[4],part_sum_8[4],part_sum_7[4],part_sum_6[4],part_sum_5[4],part_sum_4[4],part_sum_3[4],part_sum_2[4],part_sum_1[4],part_sum_0[4]};

assign wt_input_5 = {part_sum_16[5],part_sum_15[5],part_sum_14[5],part_sum_13[5],part_sum_12[5],part_sum_11[5],part_sum_10[5],
part_sum_9[5],part_sum_8[5],part_sum_7[5],part_sum_6[5],part_sum_5[5],part_sum_4[5],part_sum_3[5],part_sum_2[5],part_sum_1[5],part_sum_0[5]};

assign wt_input_6 = {part_sum_16[6],part_sum_15[6],part_sum_14[6],part_sum_13[6],part_sum_12[6],part_sum_11[6],part_sum_10[6],
part_sum_9[6],part_sum_8[6],part_sum_7[6],part_sum_6[6],part_sum_5[6],part_sum_4[6],part_sum_3[6],part_sum_2[6],part_sum_1[6],part_sum_0[6]};

assign wt_input_7 = {part_sum_16[7],part_sum_15[7],part_sum_14[7],part_sum_13[7],part_sum_12[7],part_sum_11[7],part_sum_10[7],
part_sum_9[7],part_sum_8[7],part_sum_7[7],part_sum_6[7],part_sum_5[7],part_sum_4[7],part_sum_3[7],part_sum_2[7],part_sum_1[7],part_sum_0[7]};

assign wt_input_8 = {part_sum_16[8],part_sum_15[8],part_sum_14[8],part_sum_13[8],part_sum_12[8],part_sum_11[8],part_sum_10[8],
part_sum_9[8],part_sum_8[8],part_sum_7[8],part_sum_6[8],part_sum_5[8],part_sum_4[8],part_sum_3[8],part_sum_2[8],part_sum_1[8],part_sum_0[8]};

assign wt_input_9 = {part_sum_16[9],part_sum_15[9],part_sum_14[9],part_sum_13[9],part_sum_12[9],part_sum_11[9],part_sum_10[9],
part_sum_9[9],part_sum_8[9],part_sum_7[9],part_sum_6[9],part_sum_5[9],part_sum_4[9],part_sum_3[9],part_sum_2[9],part_sum_1[9],part_sum_0[9]};

assign wt_input_10 = {part_sum_16[10],part_sum_15[10],part_sum_14[10],part_sum_13[10],part_sum_12[10],part_sum_11[10],part_sum_10[10],
part_sum_9[10],part_sum_8[10],part_sum_7[10],part_sum_6[10],part_sum_5[10],part_sum_4[10],part_sum_3[10],part_sum_2[10],
part_sum_1[10],part_sum_0[10]};

assign wt_input_11 = {part_sum_16[11],part_sum_15[11],part_sum_14[11],part_sum_13[11],part_sum_12[11],part_sum_11[11],part_sum_10[11],
part_sum_9[11],part_sum_8[11],part_sum_7[11],part_sum_6[11],part_sum_5[11],part_sum_4[11],part_sum_3[11],part_sum_2[11],
part_sum_1[11],part_sum_0[11]};

assign wt_input_12 = {part_sum_16[12],part_sum_15[12],part_sum_14[12],part_sum_13[12],part_sum_12[12],part_sum_11[12],part_sum_10[12],
part_sum_9[12],part_sum_8[12],part_sum_7[12],part_sum_6[12],part_sum_5[12],part_sum_4[12],part_sum_3[12],part_sum_2[12],
part_sum_1[12],part_sum_0[12]};

assign wt_input_13 = {part_sum_16[13],part_sum_15[13],part_sum_14[13],part_sum_13[13],part_sum_12[13],part_sum_11[13],part_sum_10[13],
part_sum_9[13],part_sum_8[13],part_sum_7[13],part_sum_6[13],part_sum_5[13],part_sum_4[13],part_sum_3[13],part_sum_2[13],
part_sum_1[13],part_sum_0[13]};

assign wt_input_14 = {part_sum_16[14],part_sum_15[14],part_sum_14[14],part_sum_13[14],part_sum_12[14],part_sum_11[14],part_sum_10[14],
part_sum_9[14],part_sum_8[14],part_sum_7[14],part_sum_6[14],part_sum_5[14],part_sum_4[14],part_sum_3[14],part_sum_2[14],
part_sum_1[14],part_sum_0[14]};

assign wt_input_15 = {part_sum_16[15],part_sum_15[15],part_sum_14[15],part_sum_13[15],part_sum_12[15],part_sum_11[15],part_sum_10[15],
part_sum_9[15],part_sum_8[15],part_sum_7[15],part_sum_6[15],part_sum_5[15],part_sum_4[15],part_sum_3[15],part_sum_2[15],
part_sum_1[15],part_sum_0[15]};

assign wt_input_16 = {part_sum_16[16],part_sum_15[16],part_sum_14[16],part_sum_13[16],part_sum_12[16],part_sum_11[16],part_sum_10[16],
part_sum_9[16],part_sum_8[16],part_sum_7[16],part_sum_6[16],part_sum_5[16],part_sum_4[16],part_sum_3[16],part_sum_2[16],
part_sum_1[16],part_sum_0[16]};

assign wt_input_17 = {part_sum_16[17],part_sum_15[17],part_sum_14[17],part_sum_13[17],part_sum_12[17],part_sum_11[17],part_sum_10[17],
part_sum_9[17],part_sum_8[17],part_sum_7[17],part_sum_6[17],part_sum_5[17],part_sum_4[17],part_sum_3[17],part_sum_2[17],
part_sum_1[17],part_sum_0[17]};

assign wt_input_18 = {part_sum_16[18],part_sum_15[18],part_sum_14[18],part_sum_13[18],part_sum_12[18],part_sum_11[18],part_sum_10[18],
part_sum_9[18],part_sum_8[18],part_sum_7[18],part_sum_6[18],part_sum_5[18],part_sum_4[18],part_sum_3[18],part_sum_2[18],
part_sum_1[18],part_sum_0[18]};

assign wt_input_19 = {part_sum_16[19],part_sum_15[19],part_sum_14[19],part_sum_13[19],part_sum_12[19],part_sum_11[19],part_sum_10[19],
part_sum_9[19],part_sum_8[19],part_sum_7[19],part_sum_6[19],part_sum_5[19],part_sum_4[19],part_sum_3[19],part_sum_2[19],
part_sum_1[19],part_sum_0[19]};

assign wt_input_20 = {part_sum_16[20],part_sum_15[20],part_sum_14[20],part_sum_13[20],part_sum_12[20],part_sum_11[20],part_sum_10[20],
part_sum_9[20],part_sum_8[20],part_sum_7[20],part_sum_6[20],part_sum_5[20],part_sum_4[20],part_sum_3[20],part_sum_2[20],
part_sum_1[20],part_sum_0[20]};

assign wt_input_21 = {part_sum_16[21],part_sum_15[21],part_sum_14[21],part_sum_13[21],part_sum_12[21],part_sum_11[21],part_sum_10[21],
part_sum_9[21],part_sum_8[21],part_sum_7[21],part_sum_6[21],part_sum_5[21],part_sum_4[21],part_sum_3[21],part_sum_2[21],
part_sum_1[21],part_sum_0[21]};

assign wt_input_22 = {part_sum_16[22],part_sum_15[22],part_sum_14[22],part_sum_13[22],part_sum_12[22],part_sum_11[22],part_sum_10[22],
part_sum_9[22],part_sum_8[22],part_sum_7[22],part_sum_6[22],part_sum_5[22],part_sum_4[22],part_sum_3[22],part_sum_2[22],
part_sum_1[22],part_sum_0[22]};

assign wt_input_23 = {part_sum_16[23],part_sum_15[23],part_sum_14[23],part_sum_13[23],part_sum_12[23],part_sum_11[23],part_sum_10[23],
part_sum_9[23],part_sum_8[23],part_sum_7[23],part_sum_6[23],part_sum_5[23],part_sum_4[23],part_sum_3[23],part_sum_2[23],
part_sum_1[23],part_sum_0[23]};

assign wt_input_24 = {part_sum_16[24],part_sum_15[24],part_sum_14[24],part_sum_13[24],part_sum_12[24],part_sum_11[24],part_sum_10[24],
part_sum_9[24],part_sum_8[24],part_sum_7[24],part_sum_6[24],part_sum_5[24],part_sum_4[24],part_sum_3[24],part_sum_2[24],
part_sum_1[24],part_sum_0[24]};

assign wt_input_25 = {part_sum_16[25],part_sum_15[25],part_sum_14[25],part_sum_13[25],part_sum_12[25],part_sum_11[25],part_sum_10[25],
part_sum_9[25],part_sum_8[25],part_sum_7[25],part_sum_6[25],part_sum_5[25],part_sum_4[25],part_sum_3[25],part_sum_2[25],
part_sum_1[25],part_sum_0[25]};

assign wt_input_26 = {part_sum_16[26],part_sum_15[26],part_sum_14[26],part_sum_13[26],part_sum_12[26],part_sum_11[26],part_sum_10[26],
part_sum_9[26],part_sum_8[26],part_sum_7[26],part_sum_6[26],part_sum_5[26],part_sum_4[26],part_sum_3[26],part_sum_2[26],
part_sum_1[26],part_sum_0[26]};

assign wt_input_27 = {part_sum_16[27],part_sum_15[27],part_sum_14[27],part_sum_13[27],part_sum_12[27],part_sum_11[27],part_sum_10[27],
part_sum_9[27],part_sum_8[27],part_sum_7[27],part_sum_6[27],part_sum_5[27],part_sum_4[27],part_sum_3[27],part_sum_2[27],
part_sum_1[27],part_sum_0[27]};

assign wt_input_28 = {part_sum_16[28],part_sum_15[28],part_sum_14[28],part_sum_13[28],part_sum_12[28],part_sum_11[28],part_sum_10[28],
part_sum_9[28],part_sum_8[28],part_sum_7[28],part_sum_6[28],part_sum_5[28],part_sum_4[28],part_sum_3[28],part_sum_2[28],
part_sum_1[28],part_sum_0[28]};

assign wt_input_29 = {part_sum_16[29],part_sum_15[29],part_sum_14[29],part_sum_13[29],part_sum_12[29],part_sum_11[29],part_sum_10[29],
part_sum_9[29],part_sum_8[29],part_sum_7[29],part_sum_6[29],part_sum_5[29],part_sum_4[29],part_sum_3[29],part_sum_2[29],
part_sum_1[29],part_sum_0[29]};

assign wt_input_30 = {part_sum_16[30],part_sum_15[30],part_sum_14[30],part_sum_13[30],part_sum_12[30],part_sum_11[30],part_sum_10[30],
part_sum_9[30],part_sum_8[30],part_sum_7[30],part_sum_6[30],part_sum_5[30],part_sum_4[30],part_sum_3[30],part_sum_2[30],
part_sum_1[30],part_sum_0[30]};

assign wt_input_31 = {part_sum_16[31],part_sum_15[31],part_sum_14[31],part_sum_13[31],part_sum_12[31],part_sum_11[31],part_sum_10[31],
part_sum_9[31],part_sum_8[31],part_sum_7[31],part_sum_6[31],part_sum_5[31],part_sum_4[31],part_sum_3[31],part_sum_2[31],
part_sum_1[31],part_sum_0[31]};

assign wt_input_32 = {part_sum_16[32],part_sum_15[32],part_sum_14[32],part_sum_13[32],part_sum_12[32],part_sum_11[32],part_sum_10[32],
part_sum_9[32],part_sum_8[32],part_sum_7[32],part_sum_6[32],part_sum_5[32],part_sum_4[32],part_sum_3[32],part_sum_2[32],
part_sum_1[32],part_sum_0[32]};

assign wt_input_33 = {part_sum_16[33],part_sum_15[33],part_sum_14[33],part_sum_13[33],part_sum_12[33],part_sum_11[33],part_sum_10[33],
part_sum_9[33],part_sum_8[33],part_sum_7[33],part_sum_6[33],part_sum_5[33],part_sum_4[33],part_sum_3[33],part_sum_2[33],
part_sum_1[33],part_sum_0[33]};

assign wt_input_34 = {part_sum_16[34],part_sum_15[34],part_sum_14[34],part_sum_13[34],part_sum_12[34],part_sum_11[34],part_sum_10[34],
part_sum_9[34],part_sum_8[34],part_sum_7[34],part_sum_6[34],part_sum_5[34],part_sum_4[34],part_sum_3[34],part_sum_2[34],
part_sum_1[34],part_sum_0[34]};

assign wt_input_35 = {part_sum_16[35],part_sum_15[35],part_sum_14[35],part_sum_13[35],part_sum_12[35],part_sum_11[35],part_sum_10[35],
part_sum_9[35],part_sum_8[35],part_sum_7[35],part_sum_6[35],part_sum_5[35],part_sum_4[35],part_sum_3[35],part_sum_2[35],
part_sum_1[35],part_sum_0[35]};

assign wt_input_36 = {part_sum_16[36],part_sum_15[36],part_sum_14[36],part_sum_13[36],part_sum_12[36],part_sum_11[36],part_sum_10[36],
part_sum_9[36],part_sum_8[36],part_sum_7[36],part_sum_6[36],part_sum_5[36],part_sum_4[36],part_sum_3[36],part_sum_2[36],
part_sum_1[36],part_sum_0[36]};

assign wt_input_37 = {part_sum_16[37],part_sum_15[37],part_sum_14[37],part_sum_13[37],part_sum_12[37],part_sum_11[37],part_sum_10[37],
part_sum_9[37],part_sum_8[37],part_sum_7[37],part_sum_6[37],part_sum_5[37],part_sum_4[37],part_sum_3[37],part_sum_2[37],
part_sum_1[37],part_sum_0[37]};

assign wt_input_38 = {part_sum_16[38],part_sum_15[38],part_sum_14[38],part_sum_13[38],part_sum_12[38],part_sum_11[38],part_sum_10[38],
part_sum_9[38],part_sum_8[38],part_sum_7[38],part_sum_6[38],part_sum_5[38],part_sum_4[38],part_sum_3[38],part_sum_2[38],
part_sum_1[38],part_sum_0[38]};

assign wt_input_39 = {part_sum_16[39],part_sum_15[39],part_sum_14[39],part_sum_13[39],part_sum_12[39],part_sum_11[39],part_sum_10[39],
part_sum_9[39],part_sum_8[39],part_sum_7[39],part_sum_6[39],part_sum_5[39],part_sum_4[39],part_sum_3[39],part_sum_2[39],
part_sum_1[39],part_sum_0[39]};

assign wt_input_40 = {part_sum_16[40],part_sum_15[40],part_sum_14[40],part_sum_13[40],part_sum_12[40],part_sum_11[40],part_sum_10[40],
part_sum_9[40],part_sum_8[40],part_sum_7[40],part_sum_6[40],part_sum_5[40],part_sum_4[40],part_sum_3[40],part_sum_2[40],
part_sum_1[40],part_sum_0[40]};

assign wt_input_41 = {part_sum_16[41],part_sum_15[41],part_sum_14[41],part_sum_13[41],part_sum_12[41],part_sum_11[41],part_sum_10[41],
part_sum_9[41],part_sum_8[41],part_sum_7[41],part_sum_6[41],part_sum_5[41],part_sum_4[41],part_sum_3[41],part_sum_2[41],
part_sum_1[41],part_sum_0[41]};

assign wt_input_42 = {part_sum_16[42],part_sum_15[42],part_sum_14[42],part_sum_13[42],part_sum_12[42],part_sum_11[42],part_sum_10[42],
part_sum_9[42],part_sum_8[42],part_sum_7[42],part_sum_6[42],part_sum_5[42],part_sum_4[42],part_sum_3[42],part_sum_2[42],
part_sum_1[42],part_sum_0[42]};

assign wt_input_43 = {part_sum_16[43],part_sum_15[43],part_sum_14[43],part_sum_13[43],part_sum_12[43],part_sum_11[43],part_sum_10[43],
part_sum_9[43],part_sum_8[43],part_sum_7[43],part_sum_6[43],part_sum_5[43],part_sum_4[43],part_sum_3[43],part_sum_2[43],
part_sum_1[43],part_sum_0[43]};

assign wt_input_44 = {part_sum_16[44],part_sum_15[44],part_sum_14[44],part_sum_13[44],part_sum_12[44],part_sum_11[44],part_sum_10[44],
part_sum_9[44],part_sum_8[44],part_sum_7[44],part_sum_6[44],part_sum_5[44],part_sum_4[44],part_sum_3[44],part_sum_2[44],
part_sum_1[44],part_sum_0[44]};

assign wt_input_45 = {part_sum_16[45],part_sum_15[45],part_sum_14[45],part_sum_13[45],part_sum_12[45],part_sum_11[45],part_sum_10[45],
part_sum_9[45],part_sum_8[45],part_sum_7[45],part_sum_6[45],part_sum_5[45],part_sum_4[45],part_sum_3[45],part_sum_2[45],
part_sum_1[45],part_sum_0[45]};

assign wt_input_46 = {part_sum_16[46],part_sum_15[46],part_sum_14[46],part_sum_13[46],part_sum_12[46],part_sum_11[46],part_sum_10[46],
part_sum_9[46],part_sum_8[46],part_sum_7[46],part_sum_6[46],part_sum_5[46],part_sum_4[46],part_sum_3[46],part_sum_2[46],
part_sum_1[46],part_sum_0[46]};

assign wt_input_47 = {part_sum_16[47],part_sum_15[47],part_sum_14[47],part_sum_13[47],part_sum_12[47],part_sum_11[47],part_sum_10[47],
part_sum_9[47],part_sum_8[47],part_sum_7[47],part_sum_6[47],part_sum_5[47],part_sum_4[47],part_sum_3[47],part_sum_2[47],
part_sum_1[47],part_sum_0[47]};

assign wt_input_48 = {part_sum_16[48],part_sum_15[48],part_sum_14[48],part_sum_13[48],part_sum_12[48],part_sum_11[48],part_sum_10[48],
part_sum_9[48],part_sum_8[48],part_sum_7[48],part_sum_6[48],part_sum_5[48],part_sum_4[48],part_sum_3[48],part_sum_2[48],
part_sum_1[48],part_sum_0[48]};

assign wt_input_49 = {part_sum_16[49],part_sum_15[49],part_sum_14[49],part_sum_13[49],part_sum_12[49],part_sum_11[49],part_sum_10[49],
part_sum_9[49],part_sum_8[49],part_sum_7[49],part_sum_6[49],part_sum_5[49],part_sum_4[49],part_sum_3[49],part_sum_2[49],
part_sum_1[49],part_sum_0[49]};

assign wt_input_50 = {part_sum_16[50],part_sum_15[50],part_sum_14[50],part_sum_13[50],part_sum_12[50],part_sum_11[50],part_sum_10[50],
part_sum_9[50],part_sum_8[50],part_sum_7[50],part_sum_6[50],part_sum_5[50],part_sum_4[50],part_sum_3[50],part_sum_2[50],
part_sum_1[50],part_sum_0[50]};

assign wt_input_51 = {part_sum_16[51],part_sum_15[51],part_sum_14[51],part_sum_13[51],part_sum_12[51],part_sum_11[51],part_sum_10[51],
part_sum_9[51],part_sum_8[51],part_sum_7[51],part_sum_6[51],part_sum_5[51],part_sum_4[51],part_sum_3[51],part_sum_2[51],
part_sum_1[51],part_sum_0[51]};

assign wt_input_52 = {part_sum_16[52],part_sum_15[52],part_sum_14[52],part_sum_13[52],part_sum_12[52],part_sum_11[52],part_sum_10[52],
part_sum_9[52],part_sum_8[52],part_sum_7[52],part_sum_6[52],part_sum_5[52],part_sum_4[52],part_sum_3[52],part_sum_2[52],
part_sum_1[52],part_sum_0[52]};

assign wt_input_53 = {part_sum_16[53],part_sum_15[53],part_sum_14[53],part_sum_13[53],part_sum_12[53],part_sum_11[53],part_sum_10[53],
part_sum_9[53],part_sum_8[53],part_sum_7[53],part_sum_6[53],part_sum_5[53],part_sum_4[53],part_sum_3[53],part_sum_2[53],
part_sum_1[53],part_sum_0[53]};

assign wt_input_54 = {part_sum_16[54],part_sum_15[54],part_sum_14[54],part_sum_13[54],part_sum_12[54],part_sum_11[54],part_sum_10[54],
part_sum_9[54],part_sum_8[54],part_sum_7[54],part_sum_6[54],part_sum_5[54],part_sum_4[54],part_sum_3[54],part_sum_2[54],
part_sum_1[54],part_sum_0[54]};

assign wt_input_55 = {part_sum_16[55],part_sum_15[55],part_sum_14[55],part_sum_13[55],part_sum_12[55],part_sum_11[55],part_sum_10[55],
part_sum_9[55],part_sum_8[55],part_sum_7[55],part_sum_6[55],part_sum_5[55],part_sum_4[55],part_sum_3[55],part_sum_2[55],
part_sum_1[55],part_sum_0[55]};

assign wt_input_56 = {part_sum_16[56],part_sum_15[56],part_sum_14[56],part_sum_13[56],part_sum_12[56],part_sum_11[56],part_sum_10[56],
part_sum_9[56],part_sum_8[56],part_sum_7[56],part_sum_6[56],part_sum_5[56],part_sum_4[56],part_sum_3[56],part_sum_2[56],
part_sum_1[56],part_sum_0[56]};

assign wt_input_57 = {part_sum_16[57],part_sum_15[57],part_sum_14[57],part_sum_13[57],part_sum_12[57],part_sum_11[57],part_sum_10[57],
part_sum_9[57],part_sum_8[57],part_sum_7[57],part_sum_6[57],part_sum_5[57],part_sum_4[57],part_sum_3[57],part_sum_2[57],
part_sum_1[57],part_sum_0[57]};

assign wt_input_58 = {part_sum_16[58],part_sum_15[58],part_sum_14[58],part_sum_13[58],part_sum_12[58],part_sum_11[58],part_sum_10[58],
part_sum_9[58],part_sum_8[58],part_sum_7[58],part_sum_6[58],part_sum_5[58],part_sum_4[58],part_sum_3[58],part_sum_2[58],
part_sum_1[58],part_sum_0[58]};

assign wt_input_59 = {part_sum_16[59],part_sum_15[59],part_sum_14[59],part_sum_13[59],part_sum_12[59],part_sum_11[59],part_sum_10[59],
part_sum_9[59],part_sum_8[59],part_sum_7[59],part_sum_6[59],part_sum_5[59],part_sum_4[59],part_sum_3[59],part_sum_2[59],
part_sum_1[59],part_sum_0[59]};

assign wt_input_60 = {part_sum_16[60],part_sum_15[60],part_sum_14[60],part_sum_13[60],part_sum_12[60],part_sum_11[60],part_sum_10[60],
part_sum_9[60],part_sum_8[60],part_sum_7[60],part_sum_6[60],part_sum_5[60],part_sum_4[60],part_sum_3[60],part_sum_2[60],
part_sum_1[60],part_sum_0[60]};

assign wt_input_61 = {part_sum_16[61],part_sum_15[61],part_sum_14[61],part_sum_13[61],part_sum_12[61],part_sum_11[61],part_sum_10[61],
part_sum_9[61],part_sum_8[61],part_sum_7[61],part_sum_6[61],part_sum_5[61],part_sum_4[61],part_sum_3[61],part_sum_2[61],
part_sum_1[61],part_sum_0[61]};

assign wt_input_62 = {part_sum_16[62],part_sum_15[62],part_sum_14[62],part_sum_13[62],part_sum_12[62],part_sum_11[62],part_sum_10[62],
part_sum_9[62],part_sum_8[62],part_sum_7[62],part_sum_6[62],part_sum_5[62],part_sum_4[62],part_sum_3[62],part_sum_2[62],
part_sum_1[62],part_sum_0[62]};

assign wt_input_63 = {part_sum_16[63],part_sum_15[63],part_sum_14[63],part_sum_13[63],part_sum_12[63],part_sum_11[63],part_sum_10[63],
part_sum_9[63],part_sum_8[63],part_sum_7[63],part_sum_6[63],part_sum_5[63],part_sum_4[63],part_sum_3[63],part_sum_2[63],
part_sum_1[63],part_sum_0[63]};

wire [14:0] wt_cout_0,wt_cout_1,wt_cout_2,wt_cout_3,wt_cout_4,wt_cout_5,wt_cout_6,wt_cout_7,wt_cout_8,wt_cout_9;
wire [14:0] wt_cout_10,wt_cout_11,wt_cout_12,wt_cout_13,wt_cout_14,wt_cout_15,wt_cout_16,wt_cout_17,wt_cout_18,wt_cout_19;
wire [14:0] wt_cout_20,wt_cout_21,wt_cout_22,wt_cout_23,wt_cout_24,wt_cout_25,wt_cout_26,wt_cout_27,wt_cout_28,wt_cout_29;
wire [14:0] wt_cout_30,wt_cout_31,wt_cout_32,wt_cout_33,wt_cout_34,wt_cout_35,wt_cout_36,wt_cout_37,wt_cout_38,wt_cout_39;
wire [14:0] wt_cout_40,wt_cout_41,wt_cout_42,wt_cout_43,wt_cout_44,wt_cout_45,wt_cout_46,wt_cout_47,wt_cout_48,wt_cout_49;
wire [14:0] wt_cout_50,wt_cout_51,wt_cout_52,wt_cout_53,wt_cout_54,wt_cout_55,wt_cout_56,wt_cout_57,wt_cout_58,wt_cout_59;
wire [14:0] wt_cout_60,wt_cout_61,wt_cout_62,wt_cout_63;

wallace_tree wallace_tree_0(.sum(wt_input_0),.cin(part_c[14:0]),.cout(wt_cout_0),.C(WT_C[0]),.S(WT_S[0]));
wallace_tree wallace_tree_1(.sum(wt_input_1),.cin(wt_cout_0),.cout(wt_cout_1),.C(WT_C[1]),.S(WT_S[1]));
wallace_tree wallace_tree_2(.sum(wt_input_2),.cin(wt_cout_1),.cout(wt_cout_2),.C(WT_C[2]),.S(WT_S[2]));
wallace_tree wallace_tree_3(.sum(wt_input_3),.cin(wt_cout_2),.cout(wt_cout_3),.C(WT_C[3]),.S(WT_S[3]));
wallace_tree wallace_tree_4(.sum(wt_input_4),.cin(wt_cout_3),.cout(wt_cout_4),.C(WT_C[4]),.S(WT_S[4]));
wallace_tree wallace_tree_5(.sum(wt_input_5),.cin(wt_cout_4),.cout(wt_cout_5),.C(WT_C[5]),.S(WT_S[5]));
wallace_tree wallace_tree_6(.sum(wt_input_6),.cin(wt_cout_5),.cout(wt_cout_6),.C(WT_C[6]),.S(WT_S[6]));
wallace_tree wallace_tree_7(.sum(wt_input_7),.cin(wt_cout_6),.cout(wt_cout_7),.C(WT_C[7]),.S(WT_S[7]));
wallace_tree wallace_tree_8(.sum(wt_input_8),.cin(wt_cout_7),.cout(wt_cout_8),.C(WT_C[8]),.S(WT_S[8]));
wallace_tree wallace_tree_9(.sum(wt_input_9),.cin(wt_cout_8),.cout(wt_cout_9),.C(WT_C[9]),.S(WT_S[9]));
wallace_tree wallace_tree_10(.sum(wt_input_10),.cin(wt_cout_9),.cout(wt_cout_10),.C(WT_C[10]),.S(WT_S[10]));
wallace_tree wallace_tree_11(.sum(wt_input_11),.cin(wt_cout_10),.cout(wt_cout_11),.C(WT_C[11]),.S(WT_S[11]));
wallace_tree wallace_tree_12(.sum(wt_input_12),.cin(wt_cout_11),.cout(wt_cout_12),.C(WT_C[12]),.S(WT_S[12]));
wallace_tree wallace_tree_13(.sum(wt_input_13),.cin(wt_cout_12),.cout(wt_cout_13),.C(WT_C[13]),.S(WT_S[13]));
wallace_tree wallace_tree_14(.sum(wt_input_14),.cin(wt_cout_13),.cout(wt_cout_14),.C(WT_C[14]),.S(WT_S[14]));
wallace_tree wallace_tree_15(.sum(wt_input_15),.cin(wt_cout_14),.cout(wt_cout_15),.C(WT_C[15]),.S(WT_S[15]));
wallace_tree wallace_tree_16(.sum(wt_input_16),.cin(wt_cout_15),.cout(wt_cout_16),.C(WT_C[16]),.S(WT_S[16]));
wallace_tree wallace_tree_17(.sum(wt_input_17),.cin(wt_cout_16),.cout(wt_cout_17),.C(WT_C[17]),.S(WT_S[17]));
wallace_tree wallace_tree_18(.sum(wt_input_18),.cin(wt_cout_17),.cout(wt_cout_18),.C(WT_C[18]),.S(WT_S[18]));
wallace_tree wallace_tree_19(.sum(wt_input_19),.cin(wt_cout_18),.cout(wt_cout_19),.C(WT_C[19]),.S(WT_S[19]));
wallace_tree wallace_tree_20(.sum(wt_input_20),.cin(wt_cout_19),.cout(wt_cout_20),.C(WT_C[20]),.S(WT_S[20]));
wallace_tree wallace_tree_21(.sum(wt_input_21),.cin(wt_cout_20),.cout(wt_cout_21),.C(WT_C[21]),.S(WT_S[21]));
wallace_tree wallace_tree_22(.sum(wt_input_22),.cin(wt_cout_21),.cout(wt_cout_22),.C(WT_C[22]),.S(WT_S[22]));
wallace_tree wallace_tree_23(.sum(wt_input_23),.cin(wt_cout_22),.cout(wt_cout_23),.C(WT_C[23]),.S(WT_S[23]));
wallace_tree wallace_tree_24(.sum(wt_input_24),.cin(wt_cout_23),.cout(wt_cout_24),.C(WT_C[24]),.S(WT_S[24]));
wallace_tree wallace_tree_25(.sum(wt_input_25),.cin(wt_cout_24),.cout(wt_cout_25),.C(WT_C[25]),.S(WT_S[25]));
wallace_tree wallace_tree_26(.sum(wt_input_26),.cin(wt_cout_25),.cout(wt_cout_26),.C(WT_C[26]),.S(WT_S[26]));
wallace_tree wallace_tree_27(.sum(wt_input_27),.cin(wt_cout_26),.cout(wt_cout_27),.C(WT_C[27]),.S(WT_S[27]));
wallace_tree wallace_tree_28(.sum(wt_input_28),.cin(wt_cout_27),.cout(wt_cout_28),.C(WT_C[28]),.S(WT_S[28]));
wallace_tree wallace_tree_29(.sum(wt_input_29),.cin(wt_cout_28),.cout(wt_cout_29),.C(WT_C[29]),.S(WT_S[29]));
wallace_tree wallace_tree_30(.sum(wt_input_30),.cin(wt_cout_29),.cout(wt_cout_30),.C(WT_C[30]),.S(WT_S[30]));
wallace_tree wallace_tree_31(.sum(wt_input_31),.cin(wt_cout_30),.cout(wt_cout_31),.C(WT_C[31]),.S(WT_S[31]));
wallace_tree wallace_tree_32(.sum(wt_input_32),.cin(wt_cout_31),.cout(wt_cout_32),.C(WT_C[32]),.S(WT_S[32]));
wallace_tree wallace_tree_33(.sum(wt_input_33),.cin(wt_cout_32),.cout(wt_cout_33),.C(WT_C[33]),.S(WT_S[33]));
wallace_tree wallace_tree_34(.sum(wt_input_34),.cin(wt_cout_33),.cout(wt_cout_34),.C(WT_C[34]),.S(WT_S[34]));
wallace_tree wallace_tree_35(.sum(wt_input_35),.cin(wt_cout_34),.cout(wt_cout_35),.C(WT_C[35]),.S(WT_S[35]));
wallace_tree wallace_tree_36(.sum(wt_input_36),.cin(wt_cout_35),.cout(wt_cout_36),.C(WT_C[36]),.S(WT_S[36]));
wallace_tree wallace_tree_37(.sum(wt_input_37),.cin(wt_cout_36),.cout(wt_cout_37),.C(WT_C[37]),.S(WT_S[37]));
wallace_tree wallace_tree_38(.sum(wt_input_38),.cin(wt_cout_37),.cout(wt_cout_38),.C(WT_C[38]),.S(WT_S[38]));
wallace_tree wallace_tree_39(.sum(wt_input_39),.cin(wt_cout_38),.cout(wt_cout_39),.C(WT_C[39]),.S(WT_S[39]));
wallace_tree wallace_tree_40(.sum(wt_input_40),.cin(wt_cout_39),.cout(wt_cout_40),.C(WT_C[40]),.S(WT_S[40]));
wallace_tree wallace_tree_41(.sum(wt_input_41),.cin(wt_cout_40),.cout(wt_cout_41),.C(WT_C[41]),.S(WT_S[41]));
wallace_tree wallace_tree_42(.sum(wt_input_42),.cin(wt_cout_41),.cout(wt_cout_42),.C(WT_C[42]),.S(WT_S[42]));
wallace_tree wallace_tree_43(.sum(wt_input_43),.cin(wt_cout_42),.cout(wt_cout_43),.C(WT_C[43]),.S(WT_S[43]));
wallace_tree wallace_tree_44(.sum(wt_input_44),.cin(wt_cout_43),.cout(wt_cout_44),.C(WT_C[44]),.S(WT_S[44]));
wallace_tree wallace_tree_45(.sum(wt_input_45),.cin(wt_cout_44),.cout(wt_cout_45),.C(WT_C[45]),.S(WT_S[45]));
wallace_tree wallace_tree_46(.sum(wt_input_46),.cin(wt_cout_45),.cout(wt_cout_46),.C(WT_C[46]),.S(WT_S[46]));
wallace_tree wallace_tree_47(.sum(wt_input_47),.cin(wt_cout_46),.cout(wt_cout_47),.C(WT_C[47]),.S(WT_S[47]));
wallace_tree wallace_tree_48(.sum(wt_input_48),.cin(wt_cout_47),.cout(wt_cout_48),.C(WT_C[48]),.S(WT_S[48]));
wallace_tree wallace_tree_49(.sum(wt_input_49),.cin(wt_cout_48),.cout(wt_cout_49),.C(WT_C[49]),.S(WT_S[49]));
wallace_tree wallace_tree_50(.sum(wt_input_50),.cin(wt_cout_49),.cout(wt_cout_50),.C(WT_C[50]),.S(WT_S[50]));
wallace_tree wallace_tree_51(.sum(wt_input_51),.cin(wt_cout_50),.cout(wt_cout_51),.C(WT_C[51]),.S(WT_S[51]));
wallace_tree wallace_tree_52(.sum(wt_input_52),.cin(wt_cout_51),.cout(wt_cout_52),.C(WT_C[52]),.S(WT_S[52]));
wallace_tree wallace_tree_53(.sum(wt_input_53),.cin(wt_cout_52),.cout(wt_cout_53),.C(WT_C[53]),.S(WT_S[53]));
wallace_tree wallace_tree_54(.sum(wt_input_54),.cin(wt_cout_53),.cout(wt_cout_54),.C(WT_C[54]),.S(WT_S[54]));
wallace_tree wallace_tree_55(.sum(wt_input_55),.cin(wt_cout_54),.cout(wt_cout_55),.C(WT_C[55]),.S(WT_S[55]));
wallace_tree wallace_tree_56(.sum(wt_input_56),.cin(wt_cout_55),.cout(wt_cout_56),.C(WT_C[56]),.S(WT_S[56]));
wallace_tree wallace_tree_57(.sum(wt_input_57),.cin(wt_cout_56),.cout(wt_cout_57),.C(WT_C[57]),.S(WT_S[57]));
wallace_tree wallace_tree_58(.sum(wt_input_58),.cin(wt_cout_57),.cout(wt_cout_58),.C(WT_C[58]),.S(WT_S[58]));
wallace_tree wallace_tree_59(.sum(wt_input_59),.cin(wt_cout_58),.cout(wt_cout_59),.C(WT_C[59]),.S(WT_S[59]));
wallace_tree wallace_tree_60(.sum(wt_input_60),.cin(wt_cout_59),.cout(wt_cout_60),.C(WT_C[60]),.S(WT_S[60]));
wallace_tree wallace_tree_61(.sum(wt_input_61),.cin(wt_cout_60),.cout(wt_cout_61),.C(WT_C[61]),.S(WT_S[61]));
wallace_tree wallace_tree_62(.sum(wt_input_62),.cin(wt_cout_61),.cout(wt_cout_62),.C(WT_C[62]),.S(WT_S[62]));
wallace_tree wallace_tree_63(.sum(wt_input_63),.cin(wt_cout_62),.cout(wt_cout_63),.C(WT_C[63]),.S(WT_S[63]));

//pipeline registers
reg [63:0] add_s;
reg [63:0] add_c;
reg add_d;
always@(posedge mul_clk)
begin
	if(!resetn)
	begin
		add_s <= 64'd0;
		add_c <= 64'd0;
		add_d <= 1'd0;
	end
	else
	begin
		add_s <= WT_S;
		add_c <= {WT_C[62:0],part_c[15]};
		add_d <= part_c[16];
	end
end

assign mul_result = add_s + add_c + add_d;

endmodule