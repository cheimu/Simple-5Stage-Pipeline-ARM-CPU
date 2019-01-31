`timescale 1ns/10ps

module mux2_1(out, i0, i1, sel);
	output logic out;
	input  logic i0, i1; 
	input logic sel;
	logic nsel;
	logic a1o, a2o;
	not #50 n1 (nsel, sel);
	
	
	and #50 a1 (a1o, nsel, i0);
	and #50 a2 (a2o, sel, i1);
	or #50 o1 (out, a1o, a2o);			
endmodule


module mux2_1_testbench();
   logic out;
	logic sel;
	logic i0, i1;
	mux2_1 dut (out, i0, i1, sel);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i < 8; i++) begin
			{i0, i1, sel} = i; #1000;
			end
	end
endmodule 