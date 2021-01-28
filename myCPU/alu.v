`timescale 1ns / 1ps

`define DATA_WIDTH 32

module alu(
	input [`DATA_WIDTH - 1:0] A,
	input [`DATA_WIDTH - 1:0] B,
	input [4:0] sa,
	input [11:0] ALUop,
	output Overflow,//used for signed number
	output CarryOut,//used for unsigned number
	output  [`DATA_WIDTH - 1:0] Result
);

/*the alu module current has 12 functions:
1.add  2.sub  3.slt  4.sltu
5.and  6.or   7.nor  8.xor
9.sll  10.slr 11.sla 12.lui */

wire op_add; //加法操作
wire op_sub; //减法操作 
wire op_slt; //有符号比较，小于置位 
wire op_sltu; //无符号比较，小于置位  
wire op_and; //按位与 
wire op_or; //按位或 
wire op_xor; //按位异或
wire op_nor; //按位或非 
wire op_sll; //逻辑左移 
wire op_srl; //逻辑右移  
wire op_sra; //算术右移 
wire op_lui; //高位加载

assign op_add = ALUop[11];
assign op_sub = ALUop[10];
assign op_slt = ALUop[9];
assign op_sltu = ALUop[8];
assign op_and = ALUop[7];
assign op_or = ALUop[6];
assign op_xor = ALUop[5];
assign op_nor = ALUop[4];
assign op_sll = ALUop[3];
assign op_srl = ALUop[2];
assign op_sra = ALUop[1];
assign op_lui = ALUop[0];

wire [31:0] add_sub_result;
wire [31:0] slt_result;
wire [31:0] sltu_result;
wire [31:0] and_result;
wire [31:0] or_result;
wire [31:0] xor_result; 
wire [31:0] nor_result;
wire [31:0] sll_result; 
wire [31:0] sr_result; 
wire [31:0] lui_result;

wire [31:0] addr_A;
wire [31:0] addr_B;
wire addr_cin;
wire addr_cout;

assign addr_A = A;
assign addr_B = {32{op_sub|op_slt|op_sltu}} ^ B;
assign addr_cin = op_sub|op_slt|op_sltu;
assign {addr_cout,add_sub_result} = {addr_A[31],addr_A} + {addr_B[31],addr_B} + addr_cin;
assign slt_result = {31'd0,addr_cout};
assign sltu_result = {31'd0,CarryOut};

assign and_result = A & B;
assign or_result = A | B;
assign nor_result = ~or_result;
assign xor_result = A ^ B;
assign sll_result = B << sa;
assign sr_result = (op_sra & B[31]) ? ~((~B) >> sa) : (B >> sa);
assign lui_result = {B[15:0],16'd0};

assign Overflow = add_sub_result[31] ^ addr_cout;	
assign CarryOut = (A[31] ^ B[31]) ^ addr_cout;
assign Result = ({32{op_add|op_sub }} & add_sub_result) 
		  | ({32{op_slt }} & slt_result) 
  		  | ({32{op_sltu }} & sltu_result) 
		  | ({32{op_and }} & and_result) 
		  | ({32{op_or }} & or_result)
		  | ({32{op_nor }} & nor_result) 
		  | ({32{op_xor }} & xor_result) 
		  | ({32{op_sll }} & sll_result) 
		  | ({32{op_srl|op_sra }} & sr_result) 
		  | ({32{op_lui }} & lui_result);
endmodule
