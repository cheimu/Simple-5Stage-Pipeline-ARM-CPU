module mux4_1(out, inp, sel);
	output logic [63:0] out;
	input  logic [3:0][63:0] inp; 
	input logic [1:0] sel;
	logic [63:0] out0, out1;

	
	mux2_1 m0(out0, inp[0], inp[1], sel[0]);
	mux2_1 m1(out1, inp[2], inp[3], sel[0]);
	
	mux2_1 m2(out, out0, out1, sel[1]);
endmodule