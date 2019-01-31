`timescale 1ns/10ps

module mux8_1(out, inp, sel);
	output logic out;
	input logic [7:0] inp;
	input logic [2:0] sel;
	logic out1, out2;
	
	mux4_1 m0(out1, inp[0], inp[1], inp[2], inp[3], sel[0], sel[1]);
	mux4_1 m1(out2, inp[4], inp[5], inp[6], inp[7], sel[0], sel[1]);
	
	mux2_1 m2(out, out1, out2, sel[2]);
endmodule
	
	
module mux_testbench();
   logic out;
	logic [2:0] sel;
	logic [7:0] inp;
	mux8_1 dut (out, inp, sel);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i < 512; i++) begin
			{sel, inp} = i; #1000;
			end
	end
endmodule 