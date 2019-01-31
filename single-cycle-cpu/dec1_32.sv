module dec1_32(we, enable, WReg);

	output logic [31:0] we;
	input logic enable;
	input logic [4:0]WReg;
	logic [3:0] out;
	
	dec1_4 d0(out[3:0], enable, WReg[1:0]);
	dec1_8 d1(we[7:0], out[0], WReg[4:2]);
	dec1_8 d2(we[15:8], out[1], WReg[4:2]);
	dec1_8 d3(we[23:16], out[2], WReg[4:2]);
	dec1_8 d4(we[31:24], out[3], WReg[4:2]);
endmodule
