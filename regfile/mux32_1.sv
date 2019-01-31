module mux32_1 (out, inp, sel);
	output logic [63:0] out;
	input logic [31:0][63:0] inp;
	input logic [4:0] sel;
	logic [3:0][63:0] outi;
	
	mux8_1 m0(outi[0], inp[7:0], sel[2:0]);
	mux8_1 m1(outi[1], inp[15:8], sel[2:0]);
	mux8_1 m2(outi[2], inp[23:16], sel[2:0]);
	mux8_1 m3(outi[3], inp[31:24], sel[2:0]);
	
	
	mux4_1 m4(out, outi, sel[4:3]);
endmodule
