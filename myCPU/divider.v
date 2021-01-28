module divider(
	input div_clk,
	input resetn,
	input div,// if no new div this signal should be 0
	input div_signed,
	input [31:0] x,
	input [31:0] y,
	output [31:0] s,
	output [31:0] r,//remain
	output complete
);
parameter PREPARE = 2'd0,
	  DIV = 2'd1,
	  FINISH = 2'd2;

reg [63:0] div_x;
reg [31:0] div_y;
reg s_sign;// = 0 positive, = 1 negative
reg r_sign;
reg [31:0] s_out;
wire [31:0] r_out;
assign r_out = div_x[63:32];

reg [5:0] counter;
reg [1:0] current_state;
reg [1:0] next_state;

wire [32:0] part_sub;
assign part_sub = (current_state == DIV) ? div_x[63:31] + {1'd1,~div_y} + 1 : 33'd0;

always@(posedge div_clk)
begin
	if(!resetn)
	begin
		current_state <= PREPARE;
	end
	else
	begin
		current_state <= next_state;
	end
end

always@(*)
begin
	case(current_state)
	PREPARE:
	begin
		next_state = (resetn && div) ? DIV : PREPARE;
	end
	DIV:
	begin
		next_state = (counter == 6'd32) ? FINISH : DIV;
	end
	FINISH:
	begin
		next_state = PREPARE;
	end
	default
	begin
		next_state = PREPARE;
	end	
	endcase
end

always@(posedge div_clk)
begin
	case(current_state)
	PREPARE:
	begin
		if(resetn & div == 1'd0)
		begin
			div_x <= 64'd0;
			div_y <= 32'd0;
			s_sign <= 1'd0;
			r_sign <= 1'd0;
			counter <= 6'd0;
			s_out <= 32'd0;
		end
		else 
		begin
			div_x <= (div_signed && x[31]) ? {32'd0,~x+1} : {32'd0,x};
			div_y <= (div_signed && y[31]) ? (~y+1) : y;
			s_sign <= div_signed & (x[31] ^ y[31]);
			r_sign <= div_signed & x[31];
			counter <= counter + 1;			
		end
	end
	DIV:
	begin	
		div_x <= (part_sub[32] == 1'd0) ? ({part_sub,div_x[30:0]} << 1) : (div_x << 1);
		s_out <= (counter == 6'd32) ? {s_out[31:1],~part_sub[32]} : ({s_out[31:1],~part_sub[32]} << 1);
		counter	<= counter + 1;
	end
	FINISH:
	begin
	   ;//?
	end
	default
	begin
		;
	end
	endcase
end

assign s = (counter != 6'd33) ? 32'd0 :
	   (s_sign == 1'd1)   ? (~s_out + 1) :
					    s_out;
assign r = (counter != 6'd33) ? 32'd0 :
	   (r_sign == 1'd1)   ? (~r_out + 1) :
					    r_out;
assign complete = (counter == 6'd33) ? 1'd1 : 1'd0;

endmodule