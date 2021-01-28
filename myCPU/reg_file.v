`timescale 1ns / 1ps

`define DATA_WIDTH 32
`define ADDR_WIDTH 5

module reg_file(
	input clk,
	input resetn,
	input [`ADDR_WIDTH - 1:0] waddr,// write address
	input [`ADDR_WIDTH - 1:0] raddr1,// read address 1
	input [`ADDR_WIDTH - 1:0] raddr2,// read address 2
	input wen,//write enable
	input [`DATA_WIDTH - 1:0] wdata,//write data
	output [`DATA_WIDTH - 1:0] rdata1,//read data 1
	output [`DATA_WIDTH - 1:0] rdata2//read data 2
);
 
reg [31:0] mem [31:0];//32 32-bit memory

always@(posedge clk)//writing logic
	begin
		if (!resetn)
		begin
			mem[0] <= 32'b0;
		end
		else if (wen)
		begin
		    mem[waddr] <= wdata;
		end
		else
		    ;
	end

//reading logic
assign rdata1 = (raddr1 == 5'd0) ?32'd0:mem[raddr1];
assign rdata2 = (raddr2 == 5'd0) ?32'd0:mem[raddr2];
	

endmodule