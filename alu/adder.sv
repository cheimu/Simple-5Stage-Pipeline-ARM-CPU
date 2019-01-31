`timescale 1ns/10ps

module adder(sum, cout, cin, a,b);
	input logic cin, a, b;
	output logic sum, cout;
	
	logic ci0, ci1, ci2;
	
	
	xor #50 x1 (sum, a, b, cin);
	and #50 a0 (ci0, cin, b);
	and #50 a1 (ci1, cin, a);
   and #50 a2 (ci2, a, b);

   or #50 o0 (cout, ci0, ci1, ci2);
	
endmodule


module adder_testbench();
   logic sum, cout, a, b, cin;
	adder dut (sum, cout, cin, a, b);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <8; i++) begin
			{a, b, cin} = i; #1000;
			end
	end
endmodule 