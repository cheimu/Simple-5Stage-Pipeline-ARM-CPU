`timescale 1ns/10ps

module movkMake (movk_result, mask2, Dw, movz_result); 
	input logic [63:0] mask2, Dw, movz_result;
	output logic [63:0] movk_result;
	logic [63:0] nmask2, adre;
	
	genvar i;
	generate 
	for (i = 0; i < 64; i++) begin : eachgates
		not #50 n0 (nmask2[i], mask2[i]);
		and #50 or1 (adre[i], nmask2[i], Dw[i]);
		or #50 or2 (movk_result[i], adre[i], movz_result[i]);
	end
	endgenerate
endmodule
		