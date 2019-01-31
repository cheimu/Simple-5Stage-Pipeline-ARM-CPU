module regfile(ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);
	
	output logic [63:0] ReadData1, ReadData2;
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0] WriteData;
	input logic clk, RegWrite;
	logic [31:0] we;
	logic [31:0][63:0] Regout;
	
	assign Regout[31] = 64'b0;
	
	dec1_32 decoder(we, RegWrite, {WriteRegister[0],WriteRegister[1],WriteRegister[2],WriteRegister[3],WriteRegister[4]});
	
	genvar i;
	
	generate
		for (i=0; i < 31; i++) begin : eachDff
			register dff (WriteData, Regout[i], we[i], clk);
		end
	endgenerate
	
	mux32_1 read1 (ReadData1, Regout, ReadRegister1);
	mux32_1 read2 (ReadData2, Regout, ReadRegister2);


endmodule
	

	 