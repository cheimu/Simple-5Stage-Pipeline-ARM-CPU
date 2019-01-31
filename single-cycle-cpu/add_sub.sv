`timescale 1ns / 10ps 

module add_sub (sum, cout, cin, a,b, sel);
	input logic cin, a, b, sel;
	output logic sum, cout;
	
	logic nb, bin;
	
	not #50 n0 (nb, b);
	a_mux2_1 m0 (bin, b, nb, sel);
	adder add0 (sum, cout, cin, a, bin);
endmodule

	