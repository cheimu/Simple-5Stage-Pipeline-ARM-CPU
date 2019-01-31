module dec1_8(we, enable, WReg);

	output logic [7:0] we;
	input logic enable;
	input logic [2:0] WReg;
	logic [1:0] out;
	
	dec1_2 d1 (out[1:0], enable,WReg[0]);
	dec1_4 d2 (we[3:0], out[0], WReg[2:1]);
	dec1_4 d3(we[7:4], out[1], WReg[2:1]);
	
endmodule

