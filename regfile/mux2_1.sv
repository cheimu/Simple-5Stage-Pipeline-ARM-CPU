`timescale 1ns/10ps

module mux2_1(out, i0, i1, sel);
	output logic [63:0] out;
	input  logic [63:0]i0, i1; 
	input logic sel;
	logic nsel;
	logic [63:0] a1o, a2o;
	not #50 n1 (nsel, sel);
	
	genvar i;
	
	generate 
		for (i=0; i < 64; i++) begin : eachDff
			// assign out[i] = ~sel & i0[i] | sel & i1[i];
		   and #50 a1 (a1o[i], nsel, i0[i]);
			and #50 a2 (a2o[i], sel, i1[i]);
			or #50 o1 (out[i], a1o[i], a2o[i]);
		end
	endgenerate
			
endmodule

/*module mux2_1_testbench();
 logic [3:0] out;
 logic [3:0]i0, i1;
 logic sel;

 mux2_1 dut (out, i0, i1, sel);

 integer i;
 initial begin
 for(i=0; i<512; i++) begin
 {i0, i1, sel } = i; #10;
 end
 end
endmodule 
*/