module dec1_4(we, enable, WReg);

	output logic [3:0] we;
	input logic enable;
	input logic [1:0]WReg;
	logic [1:0] out;
	
	dec1_2 d0(out, enable,WReg[0]);
	dec1_2 d1(we[1:0], out[0], WReg[1]); 	
	dec1_2 d2(we[3:2], out[1], WReg[1]);

endmodule	