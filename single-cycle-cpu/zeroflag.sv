`timescale 1ns/10ps

module zeroflag (flag, bits);
	input logic [63:0] bits;
	output logic flag;
	logic [63:0] nbits;
	logic [15:0] a0o;
	logic [3:0] a1o;
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin : eachnot
			not #50 n1 (nbits[i], bits[i]);
		end
   endgenerate	
	

	and #50 a0 (a0o[0], nbits[0], nbits[1], nbits[2], nbits[3]); 
	and #50 a1 (a0o[1], nbits[4], nbits[5], nbits[6], nbits[7]); 
	and #50 a2 (a0o[2], nbits[8], nbits[9], nbits[10], nbits[11]); 
	and #50 a3 (a0o[3], nbits[12], nbits[13], nbits[14], nbits[15]); 
	and #50 a4 (a0o[4], nbits[16], nbits[17], nbits[18], nbits[19]); 
	and #50 a5 (a0o[5], nbits[20], nbits[21], nbits[22], nbits[23]); 
	and #50 a6 (a0o[6], nbits[24], nbits[25], nbits[26], nbits[27]); 
	and #50 a7 (a0o[7], nbits[28], nbits[29], nbits[30], nbits[31]); 
	and #50 a8 (a0o[8], nbits[32], nbits[33], nbits[34], nbits[35]); 
	and #50 a9 (a0o[9], nbits[36], nbits[37], nbits[38], nbits[39]); 
	and #50 a10 (a0o[10], nbits[40], nbits[41], nbits[42], nbits[43]); 
	and #50 a11 (a0o[11], nbits[44], nbits[45], nbits[46], nbits[47]); 
	and #50 a12 (a0o[12], nbits[48], nbits[49], nbits[50], nbits[51]); 
	and #50 a13 (a0o[13], nbits[52], nbits[53], nbits[54], nbits[55]); 
	and #50 a14 (a0o[14], nbits[56], nbits[57], nbits[58], nbits[59]); 
	and #50 a15 (a0o[15], nbits[60], nbits[61], nbits[62], nbits[63]); 
	
	and #50 a16 (a1o[0], a0o[0], a0o[1], a0o[2], a0o[3]);
	and #50 a17 (a1o[1], a0o[4], a0o[5], a0o[6], a0o[7]);
	and #50 a18 (a1o[2], a0o[8], a0o[9], a0o[10], a0o[11]);
	and #50 a19 (a1o[3], a0o[12], a0o[13], a0o[14], a0o[15]);
	
	and #50 a20 (flag, a1o[0], a1o[1], a1o[2], a1o[3]);
endmodule 

module zeroflag_testbench();
   logic [63:0] bits;
	logic flag;
	zeroflag dut (flag, bits);
	// Try all combinations of inputs.
	initial begin
		bits = 64'b0; #1000;
		bits = 64'b1111; #1000;
		bits = 64'b0011; #1000;
		
	end
endmodule 