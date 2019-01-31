module se19_64 (out, in);
	input logic [18:0] in;
	output logic [63:0] out;
	
	
	genvar i;
	generate
		for (i = 19; i < 64; i++) begin : eachAssign
			assign out[i] = in[18];
		end
	endgenerate
	
	assign out[18:0] = in;
endmodule 

module se26_64 (out, in);
	input logic [25:0] in;
	output logic [63:0] out;
	
	
	genvar i;
	generate
		for (i = 26; i < 64; i++) begin : eachAssign
			assign out[i] = in[25];
		end
	endgenerate
	
	assign out[25:0] = in;
endmodule 

module se9_64 (out, in);
	input logic [8:0] in;
	output logic [63:0] out;
	
	
	genvar i;
	generate
		for (i = 9; i < 64; i++) begin : eachAssign
			assign out[i] = in[8];
		end
	endgenerate
	
	assign out[8:0] = in;
endmodule 


module zero12_64 (out, in);
	input logic [11:0] in;
	output logic [63:0] out;
	
	assign out[63:12] = 0;
	assign out[11:0] = in;
	
endmodule 


module zero16_64 (out, in);
	input logic [15:0] in;
	output logic [63:0] out;
	
	assign out[63:16] = 0;
	assign out[15:0] = in;
	
endmodule 