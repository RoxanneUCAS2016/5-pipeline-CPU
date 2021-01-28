`timescale 1ns / 1ps

//wallace tree for 1 bit
module wallace_tree(
	input [16:0] sum,
	input [14:0] cin,//from lower wallace tree 
	output [14:0] cout,// for higher wallace tree
	output C,
	output S
);

//floor 1 adders
wire cout0,s0;
wire cout1,s1;
wire cout2,s2;
wire cout3,s3;
wire cout4,s4;
wire cout5,s5;

assign cout0 = sum[1]&sum[0];
assign s0 = sum[1]^sum[0];
assign cout1 = (sum[4]&sum[3])|(sum[4]&sum[2])|(sum[3]&sum[2]);
assign s1 = sum[4]^sum[3]^sum[2];
assign cout2 = (sum[7]&sum[6])|(sum[7]&sum[5])|(sum[6]&sum[5]);
assign s2 = sum[7]^sum[6]^sum[5];
assign cout3 = (sum[10]&sum[9])|(sum[10]&sum[8])|(sum[9]&sum[8]);
assign s3 = sum[10]^sum[9]^sum[8];
assign cout4 = (sum[13]&sum[12])|(sum[13]&sum[11])|(sum[12]&sum[11]);
assign s4 = sum[13]^sum[12]^sum[11];
assign cout5 = (sum[16]&sum[15])|(sum[16]&sum[14])|(sum[15]&sum[14]);
assign s5 = sum[16]^sum[15]^sum[14];

//floor 2 adders
wire cout6,s6;
wire cout7,s7;
wire cout8,s8;
wire cout9,s9;

assign cout6 = (cin[2]&cin[1])|(cin[2]&cin[0])|(cin[1]&cin[0]);
assign s6 = cin[2]^cin[1]^cin[0];
assign cout7 = (cin[5]&cin[4])|(cin[5]&cin[3])|(cin[4]&cin[3]);
assign s7 = cin[5]^cin[4]^cin[3];
assign cout8 = (s2&s1)|(s1&s0)|(s2&s0);
assign s8 = s2^s1^s0;
assign cout9 = (s5&s4)|(s5&s3)|(s4&s3);
assign s9 = s5^s4^s3;

//floor 3 adders
wire cout10,s10;
wire cout11,s11;

assign cout10 = (s6&cin[7])|(s6&cin[6])|(cin[7]&cin[6]);
assign s10 = s6^cin[7]^cin[6];
assign cout11 = (s9&s8)|(s9&s7)|(s8&s7);
assign s11 = s9^s8^s7;

//floor 4 adders
wire cout12,s12;
wire cout13,s13;

assign cout12 = (cin[10]&cin[9])|(cin[10]&cin[8])|(cin[9]&cin[8]);
assign s12 = cin[10]^cin[9]^cin[8];
assign cout13 = (s11&s10)|(s11&cin[11])|(s10&cin[11]);
assign s13 = s11^s10^cin[11];

//floor 5 adder
wire cout14,s14;

assign cout14 = (s13&s12)|(s13&cin[12])|(s12&cin[12]);
assign s14 = s13^s12^cin[12];

//floor 6 adder
wire cout15,s15;

assign cout15 = (s14&cin[14])|(s14&cin[13])|(cin[14]&cin[13]);
assign s15 = s14^cin[14]^cin[13];

//outputs
assign C = cout15;
assign S = s15;
assign cout = {cout14,cout13,cout12,cout11,cout10,cout9,cout8,cout7,cout6,cout5,cout4,cout3,cout2,cout1,cout0};

endmodule