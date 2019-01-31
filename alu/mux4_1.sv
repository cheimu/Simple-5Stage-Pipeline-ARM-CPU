`timescale 1ns/10ps

module mux4_1(out, i00, i01, i10, i11, sel0, sel1);
 output logic out;
 input logic i00, i01, i10, i11, sel0, sel1;

 logic v0, v1;

 mux2_1 m0(v0, i00, i01, sel0);
 mux2_1 m1(v1, i10, i11, sel0);
 mux2_1 m3 (out, v0, v1, sel1);
endmodule

module mux4_1_testbench();
   logic out;
	logic sel0, sel1;
	logic i00, i01, i10, i11;
	mux4_1 dut (out, i00, i01, i10, i11, sel0, sel1);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i < 64; i++) begin
			{i00, i01, i10, i11, sel0, sel1} = i; #1000;
			end
	end
endmodule 