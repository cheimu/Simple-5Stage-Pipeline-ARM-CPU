module mux8_1(out, inp, sel);
	output logic [63:0] out;
	input logic [7:0][63:0] inp;
	input logic [2:0] sel;
	logic [63:0] out1, out2;
	
	mux4_1 m0(out1, inp[3:0], sel[1:0]);
	mux4_1 m1(out2, inp[7:4], sel[1:0]);
	
	mux2_1 m2(out, out1, out2, sel[2]);
endmodule
	