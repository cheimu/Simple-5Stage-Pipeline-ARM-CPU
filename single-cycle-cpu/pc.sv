module pc (address, addressin, clk, rst);
	output logic [63:0] address;
	input logic [63:0] addressin;
	input logic clk, rst;
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin : eachDff
			D_FF name (address[i], addressin[i], rst, clk);
		end 
	endgenerate 
endmodule 