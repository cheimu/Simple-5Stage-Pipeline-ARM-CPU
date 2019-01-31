`timescale 1ns/10ps

module register (dataIn, dataOut, we, clk);
	output logic [63:0] dataOut;
	input logic [63:0] dataIn;
	input logic we, clk;
	logic nwe;
	logic [63:0] a1o, a2o, o1o;
	
	not #50 n1 (nwe, we);
	
	genvar i;
	
	generate
		for (i=0; i<64; i++) begin : eachDff
		   and #50 a1 (a1o[i], dataIn[i], we);
			and #50 a2 (a2o[i], nwe, dataOut[i]);
			or #50 o1 (o1o[i], a1o[i], a2o[i]);
			D_FF dff (dataOut[i], o1o[i] , 1'b0, clk);
		end
	endgenerate
	
endmodule 

/*module register_testbench();
 logic [3:0] dataOut;
 logic [3:0] dataIn;
 logic CLOCK_50;
 logic we, reset;


 register dut (dataIn, dataOut, we, CLOCK_50, reset);
 parameter CLOCK_50_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_50_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	initial begin 
	reset <=1;	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	@(posedge CLOCK_50);
	reset <=0; dataIn <= 4'b1010; we <= 0; @(posedge CLOCK_50);
		@(posedge CLOCK_50);
	dataIn <= 4'b1010; we <= 1;	@(posedge CLOCK_50);
	dataIn <= 4'b0101; we <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	dataIn <= 4'b1111; we <= 1;	@(posedge CLOCK_50);
							 we <=0;				@(posedge CLOCK_50);

	end
endmodule*/ 

