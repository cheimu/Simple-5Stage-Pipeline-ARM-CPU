`timescale 1ns / 10ps 

module alu_1b (ri, cout, a, b, sel, cin);

	output logic ri, cout;
	input logic a, b, cin;
	input [2:0] sel;
	logic sum;
	logic a0, o0, b0, x0;
	
	add_sub fulladder (sum, cout, cin, a,b, sel[0]);
	and #50 aandb (a0, a, b);
	or #50 aorb (o0, a, b);
	buf #50 buffer (b0, b);
	xor #50 axorb (x0, a, b);
	
	
	a_mux8_1 mux0 (ri, {1'b0, x0, o0, a0, sum, sum, 1'b0, b0}, sel[2:0]);
	
endmodule

module alu_1b_testbench();
   logic ri, cout, a, b, cin;
	logic [2:0] sel;
	alu_1b dut (ri, cout, a, b, sel, cin);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <64; i++) begin
			{a, b, sel, cin} = i; #1000;
			end
	end
endmodule 