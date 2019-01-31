`timescale 1ns/10ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	input logic [63:0] A, B;
	input logic [2:0] cntrl;
	output logic [63:0] result;
   output logic zero, overflow, carry_out, negative;
	logic [63:0] couti;
	
	// alu calculation unit
	alu_1b alu0 (result[0], couti[0], A[0], B[0], cntrl, cntrl[0]);
	
	genvar i;
	generate
		for (i = 1; i < 64; i++) begin : eachbit
			alu_1b alui (result[i], couti[i], A[i], B[i], cntrl, couti[i - 1]);
		end
	endgenerate
	
	// flag
	
	// nor #50 zero_nor (zero, out[63:0]);
	
	xor #50 x0(overflow, couti[63], couti[62]);
	assign carry_out = couti[63];
	assign negative = result[63];
	zeroflag zflag (zero, result);
endmodule

// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic 	[63:0]   AB;
	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_b operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing ADD operations", $time);
		cntrl = ALU_ADD;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			AB = A + B;
			#(delay);
			assert(result == (A + B) && negative == AB[63] && zero == ((A +B) == '0));
		end
		
		$display("%t testing SUB operations", $time);
		cntrl = ALU_SUBTRACT;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			AB = A - B;
			#(delay);
			assert(result == (A - B) && negative == AB[63] && zero == ((A-B) == '0));
		end
		
		$display("%t testing AND operations", $time);
		cntrl = ALU_AND;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			AB = A & B;
			#(delay);
			assert(result == (A & B) && negative == AB[63] && zero == ((A&B) == '0));
		end
		
		$display("%t testing XOR operations", $time);
		cntrl = ALU_XOR;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			AB = (A^B);
			#(delay);
			assert(result == (A ^ B) && negative == AB[63] && zero == ((A^B) == '0));
		end
		
		
		$display("%t testing OR operations", $time);
		cntrl = ALU_OR;
		for (i=0; i< 100; i++) begin
			A = $random(); B = $random();
			AB = A|B;
			#(delay);
			assert(result == (A | B) && negative == AB[63] && zero == ((A|B) == '0));
		end
		
		
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h8000000000000000 && overflow == 1 && negative == 1);
		
	end
endmodule
