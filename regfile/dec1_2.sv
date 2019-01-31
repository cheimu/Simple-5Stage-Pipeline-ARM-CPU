`timescale 1ns/10ps

module dec1_2(we, enable, WReg);
	output logic [1:0] we;
	input logic enable, WReg;
	logic nWReg;
	
		
	not #50 n1 (nWReg, WReg);
	
	// assign we[0] = enable & ~WReg;
	
	and #50 a1 (we[0], enable, nWReg);
	
	
	// assign we[1] = enable & WReg;
   and #50 a2 (we[1], enable, WReg);
endmodule

	