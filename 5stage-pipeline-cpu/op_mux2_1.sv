`timescale 1ns/10ps

module op_mux2_1(out, i0, i1, sel);
	output logic [4:0] out;
	input  logic [4:0] i0, i1; 
	input logic sel;
	
	a_mux2_1 a0 (out[0], i0[0], i1[0], sel);
	a_mux2_1 a1 (out[1], i0[1], i1[1], sel);
	a_mux2_1 a2 (out[2], i0[2], i1[2], sel);
	a_mux2_1 a3 (out[3], i0[3], i1[3], sel);
	a_mux2_1 a4 (out[4], i0[4], i1[4], sel);
endmodule